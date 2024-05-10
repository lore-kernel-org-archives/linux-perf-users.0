Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984538F48;
	Fri, 10 May 2024 01:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715305665; cv=none; b=pWytAtefx5EFef95L4BQGJSsLcOSeXC2PCWBgT9iJfKFpEt3OSTvErFBJITnIWLAw0ywe8tqDWm7JduaxwMfle2z6x4X7xu9MeeC/KcSvjJRxOppoZu2UAJ8iVZ3T2JiMgtefyQlIoRXjOoBShLBuusAsWH1V14IISfhZMpiVcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715305665; c=relaxed/simple;
	bh=Pz98CedxNk0vV7m7hgc2ArtORV1gA6UnVDg6h4BkadY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YsqRWaZODac8BAywbKgcb8eTIHxVA3dYNOesP4KsN/RUv/v7+ETky+5Kqu9fEep4Ye8DXrfhh1VtSid58notHs62tv906xqCZrk9yyVPPALHEDQK8lMIEChvfx94WPH1hFnCWLh6ps1+xeLk15rNt2b5dvz89g0RJPdzZRHgr6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.173])
	by gateway (Coremail) with SMTP id _____8AxR_C6fD1mKlMKAA--.26986S3;
	Fri, 10 May 2024 09:47:38 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx9Va2fD1mju4XAA--.28550S3;
	Fri, 10 May 2024 09:47:36 +0800 (CST)
Subject: Re: [PATCH v3] perf kvm: Add kvm-stat for loongarch64
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ian Rogers <irogers@google.com>,
 Ming Wang <wangming01@loongson.cn>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20240411121047.2005033-1-maobibo@loongson.cn>
 <db839f86-6749-e15b-a084-d8a4a6735f1c@loongson.cn>
 <CAAhV-H4MucyKrQdxBtoh7PJZDiWo1kB-9TP2L-x0tw8vh=ypNQ@mail.gmail.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <83ae11b8-69af-eaf8-8768-dc6d55cdcd90@loongson.cn>
Date: Fri, 10 May 2024 09:47:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4MucyKrQdxBtoh7PJZDiWo1kB-9TP2L-x0tw8vh=ypNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Dx9Va2fD1mju4XAA--.28550S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Zw18AF4fGw4DJF13WF1ktFc_yoWDKw17pr
	WjyF15Kr45Jr17CwnavFn09F15JrWxWF1ag3W7JrW7ArsIvrnrGa18trn8CFy29w4kJFW0
	vw1j9w4SkFs5JagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jepB-UUUUU=



On 2024/5/8 下午9:02, Huacai Chen wrote:
> On Tue, May 7, 2024 at 2:11 PM maobibo <maobibo@loongson.cn> wrote:
>>
>> Hi Peter/Ian/Huacai,
>>
>> This patch stays one month without response, I know you are busy and
>> look through thousands of patch every day.
>>
>> Just one question, who has permission to merge perf kvm patch for
>> LoongArch. Is it LoongArch maintainer or perf kvm maintainer?
> It should probably go to perf tree, but if it is allowed, maybe I can
> try to merge into LoongArch tree.

  tools/perf/arch/loongarch/Makefile        |   1 +
  tools/perf/arch/loongarch/util/Build      |   2 +
  tools/perf/arch/loongarch/util/header.c   |  88 ++++++++++++++
  tools/perf/arch/loongarch/util/kvm-stat.c | 135 ++++++++++++++++++++++

All the modification is LoongArch specific, there will be much 
appreciated if it can reviewed and merged.

Regards
Bibo Mao

> 
> 
> Huacai
>>
>> Regards
>> Bibo Mao
>>
>>
>> On 2024/4/11 下午8:10, Bibo Mao wrote:
>>> Add support for 'perf kvm stat' on loongarch64 platform, now only
>>> kvm exit event is supported.
>>>
>>> Here is example output about "perf kvm --host stat report" command
>>>
>>>      Event name   Samples   Sample%     Time (ns)   Time%   Mean Time (ns)
>>>       Mem store     83969    51.00%     625697070   8.00%             7451
>>>        Mem read     37641    22.00%     112485730   1.00%             2988
>>>       Interrupt     15542     9.00%      20620190   0.00%             1326
>>>           Iocsr     15207     9.00%      94296190   1.00%             6200
>>>       Hypercall      4873     2.00%      12265280   0.00%             2516
>>>            Idle      3713     2.00%    6322055860  87.00%          1702681
>>>             FPU      1819     1.00%       2750300   0.00%             1511
>>>          Ifecth       502     0.00%       1341740   0.00%             2672
>>>      Mem modify       324     0.00%        602240   0.00%             1858
>>>          Cpucfg        55     0.00%         77610   0.00%             1411
>>>             Csr        12     0.00%         19690   0.00%             1640
>>>            LASX         3     0.00%          4870   0.00%             1623
>>>             LSX         2     0.00%          2100   0.00%             1050
>>>
>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>> ---
>>> v2 --- v3:
>>>     1. Add NULL check with cpuid in function get_cpuid()
>>>     2. Add example output from /proc/cpuinfo before function get_cpuid()
>>> v1 --- v2:
>>>     1. Add child_ops for kvm exit event, split kvm:kvm_exit_gspr events
>>> into cpucfg/csr/iocsr/idle child events by decoding detailed gspr
>>> instruction.
>>>     2. Remove some exception code type which does not happen in current
>>> kvm implementation, such as meomry NR/NX/priviledge exception.
>>> ---
>>>    tools/perf/arch/loongarch/Makefile        |   1 +
>>>    tools/perf/arch/loongarch/util/Build      |   2 +
>>>    tools/perf/arch/loongarch/util/header.c   |  88 ++++++++++++++
>>>    tools/perf/arch/loongarch/util/kvm-stat.c | 135 ++++++++++++++++++++++
>>>    4 files changed, 226 insertions(+)
>>>    create mode 100644 tools/perf/arch/loongarch/util/header.c
>>>    create mode 100644 tools/perf/arch/loongarch/util/kvm-stat.c
>>>
>>> diff --git a/tools/perf/arch/loongarch/Makefile b/tools/perf/arch/loongarch/Makefile
>>> index 3992a67a87d9..c89d6bb6b184 100644
>>> --- a/tools/perf/arch/loongarch/Makefile
>>> +++ b/tools/perf/arch/loongarch/Makefile
>>> @@ -4,6 +4,7 @@ PERF_HAVE_DWARF_REGS := 1
>>>    endif
>>>    PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
>>>    PERF_HAVE_JITDUMP := 1
>>> +HAVE_KVM_STAT_SUPPORT := 1
>>>
>>>    #
>>>    # Syscall table generation for perf
>>> diff --git a/tools/perf/arch/loongarch/util/Build b/tools/perf/arch/loongarch/util/Build
>>> index d776125a2d06..b12d374d7096 100644
>>> --- a/tools/perf/arch/loongarch/util/Build
>>> +++ b/tools/perf/arch/loongarch/util/Build
>>> @@ -1,5 +1,7 @@
>>> +perf-y += header.o
>>>    perf-y += perf_regs.o
>>>
>>>    perf-$(CONFIG_DWARF)     += dwarf-regs.o
>>>    perf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
>>>    perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
>>> +perf-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
>>> diff --git a/tools/perf/arch/loongarch/util/header.c b/tools/perf/arch/loongarch/util/header.c
>>> new file mode 100644
>>> index 000000000000..a4ed732b49c6
>>> --- /dev/null
>>> +++ b/tools/perf/arch/loongarch/util/header.c
>>> @@ -0,0 +1,88 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * Implementation of get_cpuid().
>>> + *
>>> + * Author: Nikita Shubin <n.shubin@yadro.com>
>>> + */
>>> +
>>> +#include <stdio.h>
>>> +#include <stdlib.h>
>>> +#include <api/fs/fs.h>
>>> +#include <errno.h>
>>> +#include "util/debug.h"
>>> +#include "util/header.h"
>>> +
>>> +/*
>>> + * Output example from /proc/cpuinfo
>>> + *   CPU Family              : Loongson-64bit
>>> + *   Model Name              : Loongson-3C5000
>>> + *   CPU Revision            : 0x11
>>> + */
>>> +#define CPUINFO_MODEL        "Model Name"
>>> +#define CPUINFO              "/proc/cpuinfo"
>>> +static char *_get_field(const char *line)
>>> +{
>>> +     char *line2, *nl;
>>> +
>>> +     line2 = strrchr(line, ' ');
>>> +     if (!line2)
>>> +             return NULL;
>>> +
>>> +     line2++;
>>> +     nl = strrchr(line, '\n');
>>> +     if (!nl)
>>> +             return NULL;
>>> +
>>> +     return strndup(line2, nl - line2);
>>> +}
>>> +
>>> +static char *__get_cpuid(void)
>>> +{
>>> +     char *line, *model, *cpuid;
>>> +     unsigned long line_sz;
>>> +     FILE *file;
>>> +
>>> +     file = fopen(CPUINFO, "r");
>>> +     if (file == NULL)
>>> +             return cpuid;
>>> +
>>> +     line = model = cpuid = NULL;
>>> +     while (getline(&line, &line_sz, file) != -1) {
>>> +             if (strncmp(line, CPUINFO_MODEL, strlen(CPUINFO_MODEL)))
>>> +                     continue;
>>> +
>>> +             model = _get_field(line);
>>> +             if (!model)
>>> +                     goto free;
>>> +             break;
>>> +     }
>>> +
>>> +     if (model && (asprintf(&cpuid, "%s", model) < 0))
>>> +             cpuid = NULL;
>>> +
>>> +free:
>>> +     fclose(file);
>>> +     free(model);
>>> +     return cpuid;
>>> +}
>>> +
>>> +int get_cpuid(char *buffer, size_t sz)
>>> +{
>>> +     char *cpuid = __get_cpuid();
>>> +     int ret = 0;
>>> +
>>> +     if (!cpuid)
>>> +             return EINVAL;
>>> +
>>> +     if (sz >= strlen(cpuid))
>>> +             scnprintf(buffer, sz, "%s", cpuid);
>>> +     else
>>> +             ret = ENOBUFS;
>>> +     free(cpuid);
>>> +     return ret;
>>> +}
>>> +
>>> +char *get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
>>> +{
>>> +     return __get_cpuid();
>>> +}
>>> diff --git a/tools/perf/arch/loongarch/util/kvm-stat.c b/tools/perf/arch/loongarch/util/kvm-stat.c
>>> new file mode 100644
>>> index 000000000000..cc50adb0835a
>>> --- /dev/null
>>> +++ b/tools/perf/arch/loongarch/util/kvm-stat.c
>>> @@ -0,0 +1,135 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +#include <errno.h>
>>> +#include <memory.h>
>>> +#include <errno.h>
>>> +#include "util/kvm-stat.h"
>>> +#include "util/parse-events.h"
>>> +#include "util/debug.h"
>>> +#include "util/evsel.h"
>>> +#include "util/evlist.h"
>>> +#include "util/pmus.h"
>>> +
>>> +#define LOONGARCH_EXCEPTION_INT              0
>>> +#define LOONGARCH_EXCEPTION_PIL              1
>>> +#define LOONGARCH_EXCEPTION_PIS              2
>>> +#define LOONGARCH_EXCEPTION_PIF              3
>>> +#define LOONGARCH_EXCEPTION_PME              4
>>> +#define LOONGARCH_EXCEPTION_FPD              15
>>> +#define LOONGARCH_EXCEPTION_SXD              16
>>> +#define LOONGARCH_EXCEPTION_ASXD     17
>>> +#define LOONGARCH_EXCEPTION_GSPR     22
>>> +#define  LOONGARCH_EXCEPTION_CPUCFG  100
>>> +#define  LOONGARCH_EXCEPTION_CSR     101
>>> +#define  LOONGARCH_EXCEPTION_IOCSR   102
>>> +#define  LOONGARCH_EXCEPTION_IDLE    103
>>> +#define  LOONGARCH_EXCEPTION_OTHERS  104
>>> +#define LOONGARCH_EXCEPTION_HVC              23
>>> +
>>> +#define loongarch_exception_type                             \
>>> +     {LOONGARCH_EXCEPTION_INT,  "Interrupt" },               \
>>> +     {LOONGARCH_EXCEPTION_PIL,  "Mem read" },                \
>>> +     {LOONGARCH_EXCEPTION_PIS,  "Mem store" },               \
>>> +     {LOONGARCH_EXCEPTION_PIF,  "Ifecth" },                  \
>>> +     {LOONGARCH_EXCEPTION_PME,  "Mem modify" },              \
>>> +     {LOONGARCH_EXCEPTION_FPD,  "FPU" },                     \
>>> +     {LOONGARCH_EXCEPTION_SXD,  "LSX" },                     \
>>> +     {LOONGARCH_EXCEPTION_ASXD, "LASX" },                    \
>>> +     {LOONGARCH_EXCEPTION_GSPR, "Privilege Error" },         \
>>> +     {LOONGARCH_EXCEPTION_HVC,  "Hypercall" },               \
>>> +     {LOONGARCH_EXCEPTION_CPUCFG, "Cpucfg" },                \
>>> +     {LOONGARCH_EXCEPTION_CSR,    "Csr" },                   \
>>> +     {LOONGARCH_EXCEPTION_IOCSR,  "Iocsr" },                 \
>>> +     {LOONGARCH_EXCEPTION_IDLE,   "Idle" },                  \
>>> +     {LOONGARCH_EXCEPTION_OTHERS, "Others" }
>>> +
>>> +define_exit_reasons_table(loongarch_exit_reasons, loongarch_exception_type);
>>> +
>>> +const char *vcpu_id_str = "vcpu_id";
>>> +const char *kvm_exit_reason = "reason";
>>> +const char *kvm_entry_trace = "kvm:kvm_enter";
>>> +const char *kvm_reenter_trace = "kvm:kvm_reenter";
>>> +const char *kvm_exit_trace = "kvm:kvm_exit";
>>> +const char *kvm_events_tp[] = {
>>> +     "kvm:kvm_enter",
>>> +     "kvm:kvm_reenter",
>>> +     "kvm:kvm_exit",
>>> +     "kvm:kvm_exit_gspr",
>>> +     NULL,
>>> +};
>>> +
>>> +static bool event_end(struct evsel *evsel,
>>> +             struct perf_sample *sample __maybe_unused,
>>> +             struct event_key *key __maybe_unused)
>>> +{
>>> +     /*
>>> +      * LoongArch kvm is different with other architectures
>>> +      *
>>> +      * There is kvm:kvm_reenter or kvm:kvm_enter event adjacent with
>>> +      * kvm:kvm_exit event.
>>> +      *   kvm:kvm_reenter means returning to guest immediately
>>> +      *   kvm:kvm_enter   means returning to vmm and then to guest
>>> +      */
>>> +     return evsel__name_is(evsel, kvm_entry_trace) ||
>>> +             evsel__name_is(evsel, kvm_reenter_trace);
>>> +}
>>> +
>>> +static void event_gspr_get_key(struct evsel *evsel,
>>> +                     struct perf_sample *sample,
>>> +                     struct event_key *key)
>>> +{
>>> +     unsigned int insn;
>>> +
>>> +     key->key = LOONGARCH_EXCEPTION_OTHERS;
>>> +     insn = evsel__intval(evsel, sample, "inst_word");
>>> +     switch (insn >> 24) {
>>> +     case 0:
>>> +             /* cpucfg inst trap */
>>> +             if ((insn >> 10) == 0x1b)
>>> +                     key->key = LOONGARCH_EXCEPTION_CPUCFG;
>>> +             break;
>>> +     case 4:
>>> +             /* csr inst trap */
>>> +             key->key = LOONGARCH_EXCEPTION_CSR;
>>> +             break;
>>> +     case 6:
>>> +             /* iocsr inst trap */
>>> +             if ((insn >> 15) == 0xc90)
>>> +                     key->key = LOONGARCH_EXCEPTION_IOCSR;
>>> +             else if ((insn >> 15) == 0xc91)
>>> +                     /* idle inst trap */
>>> +                     key->key = LOONGARCH_EXCEPTION_IDLE;
>>> +             break;
>>> +     default:
>>> +             key->key = LOONGARCH_EXCEPTION_OTHERS;
>>> +             break;
>>> +     }
>>> +}
>>> +
>>> +static struct child_event_ops child_events[] = {
>>> +     { .name = "kvm:kvm_exit_gspr", .get_key = event_gspr_get_key },
>>> +     { NULL, NULL },
>>> +};
>>> +
>>> +static struct kvm_events_ops exit_events = {
>>> +     .is_begin_event = exit_event_begin,
>>> +     .is_end_event = event_end,
>>> +     .child_ops = child_events,
>>> +     .decode_key = exit_event_decode_key,
>>> +     .name = "VM-EXIT"
>>> +};
>>> +
>>> +struct kvm_reg_events_ops kvm_reg_events_ops[] = {
>>> +     { .name = "vmexit", .ops = &exit_events, },
>>> +     { NULL, NULL },
>>> +};
>>> +
>>> +const char * const kvm_skip_events[] = {
>>> +     NULL,
>>> +};
>>> +
>>> +int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid __maybe_unused)
>>> +{
>>> +     kvm->exit_reasons_isa = "loongarch64";
>>> +     kvm->exit_reasons = loongarch_exit_reasons;
>>> +     return 0;
>>> +}
>>>
>>> base-commit: 2c71fdf02a95b3dd425b42f28fd47fb2b1d22702
>>>
>>

