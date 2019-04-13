#include <public.sdk/source/main/pluginfactory.h>
#include <public.sdk/source/vst/vstsinglecomponenteffect.h>

bool InitModule() { return true; }
bool DeinitModule() { return true; }

static const Steinberg::FUID _TestUID(0x68759359, 0x99200001, 0x88883334, 0x777654AF);

class TestProcessor : public Steinberg::Vst::SingleComponentEffect
{
public:
	TestProcessor()
	{
	}

	virtual ~TestProcessor()
	{
	}
};

class TestService
{
public:
	static Steinberg::FUnknown* newInstance(void* context)
	{
		return (Steinberg::Vst::IAudioProcessor*)new TestProcessor();
	}
};

BEGIN_FACTORY("Nimble Tools", "https://nimble.tools/", "support@nimble.tools", PFactoryInfo::kNoFlags)
DEF_CLASS(INLINE_UID_FROM_FUID(_TestUID),
	PClassInfo::kManyInstances,
	kVstAudioEffectClass,
	"Test Processor",
	TestService::newInstance)
END_FACTORY
