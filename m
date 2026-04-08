Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2FC3AB296
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 08:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775638069; cv=none; b=oY6V1AUU1vH5qalz7+qJd1nb+KOZSl7y/MibrPHJxq4YLuxpiHTQiRu0x+aTPIPN18iJf9Ux1q6Qi2l6oV8tBuZo5uDRgGH5Lp6OqRodCFAN2FmeIYF3O5g60im7kGmslroByvDFx7qxGNl2Q0hjSwZ6NB30dERSwG70MB7MuI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775638069; c=relaxed/simple;
	bh=hB9MAbLqyDwY6yogfk834BxnczTGxd/f1QRLXiZqz2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vz6cdSzteYIHfORPOEqozBxhlhfHm580UXrcc8+S6znoJjJ9HsO4eweVNnv26ZYtdCTioyPdgt9kwJKXECEcg3Jsrx1dIpH78OpVznabWYZQAO3COZ3yRs8Lbjnrf6e2yPTvz5RNi4vcSJmoEFpKl+lzPZf5bfnW0K/ieq7xCdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=euq8vU3K; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="euq8vU3K"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4889e045bc6so41222395e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Apr 2026 01:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775638063; x=1776242863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I5xUeBoBW+ZGY0tPjnIwZA7YbDVLWoQy/vmQ+CJGtpk=;
        b=euq8vU3K5GXLq0bHSnkoUOqQyA9PEcGOlbY+oQcMuSaeGdrF4NpD8MQs48TZ6IY5y/
         2g+0NHndrT05gMiRrBseDxFrKoCcXwNj2WEZGweSC+93WTxIJjotpLihjUTTrJ5aGVRu
         w/jnDPJy9Mk+MyKmAgFAqjpHSoz5Q1AR4hlQADew5HruVo4O858UE7GYp1p4xuxcmVSa
         lAE3oLFPDLhz/qn63l8OMRLiv5qMedvbmre+1k3VEkF+hgRcAbf7k3jLc4Gex3/1CiBt
         W7r7yLZvhXuY/CCi0uUJrX9ggNrZTx8vvpdcK3o6MTzKWe8dNO7Wqjb2RSIA9kPNRIlo
         v77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775638063; x=1776242863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5xUeBoBW+ZGY0tPjnIwZA7YbDVLWoQy/vmQ+CJGtpk=;
        b=jHRpLhn9+V0vTuUKTBi6UQWpcda5YtvcIW/FUIV/IconHJId+P1zm6vbHrpjuJXvU6
         lqtPawpamGsWMkaI4YiH7DCfahjXkqcj4OrLXA1fKT34g+duirxTQ9WYPUn+1d5BQelL
         9b8X5iDunp0RCYw2ggLfXf5SGd9qTBsK/fDxTSlDXTXTWlaGcSK9I8IVNnhyjoaKlM3v
         gInbBLFPpms/4cDIYn0SMFFjnVs9wNx/WtZREQhHrkf3G7nqPZljzzTicrwGcKDGLkUw
         brpaV6WO3sY48toaO67jpa/ImrJVxUqJ4tmzkEjlSphC/l7RKpeq5BgHpO9zZC0DMoll
         JYKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGTXXnR70mlhrrxaBzOChrdn50rP+YAmldkUq6D9Bj0pKrDdwvac2oSd94E3fjucpdFTJ2OdIJWXmJ/jo7fX/i@vger.kernel.org
X-Gm-Message-State: AOJu0YwqX40hpgtDDvbb8SbGceT2ZGOfp5AY5YQcvT2MnlUzFObBhopQ
	oO/9SheIunkd+dK0DiPStu/gSU2d3cemKX68OJ3AH6zy7PyAyz0XNYJmayJhMTOKamg=
X-Gm-Gg: AeBDietOucloCSv/Yjv/YPPD6U+YUYUnFI+KHbNR6U2bIcIywhL97TBatiwKbSoSMEk
	T0Fjt/B+J8G9LZrJk2f9OXfS4Et3mGSNpnEjG+pUXrKmkM/Vf1Tdgl68E36CL4oL+A315poIdg5
	w0e7pwiyuj7ZumJwlixtadhgzrBNmrlhqhKwYPu3fFQv+iBOBS1+z8TM2Tpt7Ozq3f+82e5bnd6
	kT5pPIAkL56P7SgTktOAd1ct+urCSid37qdgZaRaphQARbyx7Evf83+rVf5v3Qg3rbuT7M6qP/9
	oAWDtvCzcGXUZuZtn7DGNR3QCT0dmb4czW/mXM5FsugcNZKWtkex/VTx9eAtnQP58v5ObzyVadq
	8bz7sYVeRJSqdGU6c7W14qB2afJTSCNYmPHye3Z+EX2qlHMz2eWsiejUzAvNB+vvyVx/CqkQGTA
	Su+e86RSSom+lzunA3euXgDC7m4NTB
X-Received: by 2002:a05:600c:4e0e:b0:482:f564:d613 with SMTP id 5b1f17b1804b1-488ca3983ebmr9645075e9.15.1775638062837;
        Wed, 08 Apr 2026 01:47:42 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e83682fsm650337045e9.7.2026.04.08.01.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 01:47:42 -0700 (PDT)
Message-ID: <1b40ec9a-a003-4acc-9399-1a8d96fc4e42@linaro.org>
Date: Wed, 8 Apr 2026 09:47:41 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] perf arm_spe: Decode Arm N1 IMPDEF events
To: Ian Rogers <irogers@google.com>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Al Grant <al.grant@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260401-james-spe-impdef-decode-v1-0-ad0d372c220c@linaro.org>
 <20260401-james-spe-impdef-decode-v1-3-ad0d372c220c@linaro.org>
 <CAP-5=fVcYOJ_3TWd6won5FVaH2MH6QwLhCoCRnNzzeE-9PgO1Q@mail.gmail.com>
 <ee012f48-5d08-4004-b9d0-bcac825cb50c@linaro.org>
 <CAP-5=fXNb50wXT3YH0i=-U8bXwizzH4bv8EL8mC9BMQE0Anp9Q@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fXNb50wXT3YH0i=-U8bXwizzH4bv8EL8mC9BMQE0Anp9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 07/04/2026 7:26 pm, Ian Rogers wrote:
> On Tue, Apr 7, 2026 at 5:35 AM James Clark <james.clark@linaro.org> wrote:
>>
>>
>>
>> On 02/04/2026 4:26 pm, Ian Rogers wrote:
>>> On Wed, Apr 1, 2026 at 7:26 AM James Clark <james.clark@linaro.org> wrote:
>>>>
>>>>   From the TRM [1], N1 has one IMPDEF event which isn't covered by the
>>>> common list. Add a framework so that more cores can be added in the
>>>> future and that the N1 IMPDEF event can be decoded. Also increase the
>>>> size of the buffer because we're adding more strings and if it gets
>>>> truncated it falls back to a hex dump only.
>>>>
>>>> [1]: https://developer.arm.com/documentation/100616/0401/Statistical-Profiling-Extension/implementation-defined-features-of-SPE
>>>> Suggested-by: Al Grant <al.grant@arm.com>
>>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>>> ---
>>>>    tools/perf/util/arm-spe-decoder/Build              |  2 +
>>>>    .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     | 45 ++++++++++++++++++++--
>>>>    .../util/arm-spe-decoder/arm-spe-pkt-decoder.h     |  5 ++-
>>>>    tools/perf/util/arm-spe.c                          | 13 ++++---
>>>>    4 files changed, 54 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/tools/perf/util/arm-spe-decoder/Build b/tools/perf/util/arm-spe-decoder/Build
>>>> index ab500e0efe24..97a298d1e279 100644
>>>> --- a/tools/perf/util/arm-spe-decoder/Build
>>>> +++ b/tools/perf/util/arm-spe-decoder/Build
>>>> @@ -1 +1,3 @@
>>>>    perf-util-y += arm-spe-pkt-decoder.o arm-spe-decoder.o
>>>> +
>>>> +CFLAGS_arm-spe-pkt-decoder.o += -I$(srctree)/tools/arch/arm64/include/ -I$(OUTPUT)arch/arm64/include/generated/
>>>> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
>>>> index c880b0dec3a1..42a7501d4dfe 100644
>>>> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
>>>> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
>>>> @@ -15,6 +15,8 @@
>>>>
>>>>    #include "arm-spe-pkt-decoder.h"
>>>>
>>>> +#include "../../arm64/include/asm/cputype.h"
>>>
>>> Sashiko spotted:
>>> https://sashiko.dev/#/patchset/20260401-james-spe-impdef-decode-v1-0-ad0d372c220c%40linaro.org
>>> """
>>> This isn't a bug, but does this include directive rely on accidental
>>> path normalization?
>>>
>>> The relative path ../../arm64/include/asm/cputype.h does not exist relative
>>> to arm-spe-pkt-decoder.c. It only compiles because the Build file adds
>>> -I$(srctree)/tools/arch/arm64/include/ to CFLAGS.
>>>
>>> Would it be cleaner to use #include <asm/cputype.h> to explicitly rely on
>>> the include path?
>>> [ ... ]
>>> """
>>> I wouldn't use <asm/cputype.h> due to cross-compilation and the like,
>>> instead just add the extra "../" into the include path.
>>>
>>
>> Do you mean change the #include to this?
>>
>>     #include "../../../arm64/include/asm/cputype.h"
>>
>> I still need to add:
>>
>>     CFLAGS_arm-spe-pkt-decoder.o += -I$(srctree)/tools/arch/arm64/include/
>>
>> To make the this include in cputype.h work:
>>
>>     #include <asm/sysreg.h>
>>
>> Which probably only works because there isn't a sysreg.h on other
>> architectures. But I'm not sure what the significance of ../../ vs
>> ../../../ is if either compile? arm-spe.c already does it with ../../
>> which is what I copied.
> 
> Hmm.. maybe the path should be
> "../../../arch/arm64/include/asm/cputype.h". The include preference is
> for a path relative to the source file and
> ../../arm64/include/asm/cputype.h doesn't exist. It is kind of horrid

Up 3 dirs from arm-spe-pkt-decoder.c would be 
"tools/arm64/include/asm/cputype.h" which doesn't exist either unless 
I'm missing something?

If get the compiler to print the path it uses with 3 then it would use 
the x86 uapi include path which doesn't seem any less weird to me:

  ...
  In file included from util/arm-spe-decoder/arm-spe-pkt-decoder.c:19:

  linux/tools/arch/x86/include/uapi/../../../arm64/include/asm/cputype.h:254:10:


> to add an include path and then use a relative path to escape into a
> higher-level directory. arm-spe.c is a little different as it is one
> directory higher in the directory layout.
> 

It is one folder higher, but arm-spe.c still relies on adding a special 
include path to CFLAGS_arm-spe.o to make it work. It's not including a 
real path relative to the source either.

Yeah it's a bit horrible but I don't think the asm/ thing combined with 
copying headers from the kernel to tools expected to handle the case 
where we would want to use asm/ stuff for a different arch than the 
compile one. It might not be normal to use relative include paths to 
escape to higher directories, but it's not a normal situation either. I 
think it's a special case for a special scenario. I'm not sure of a 
better way, but this is working for now.

> Thanks,
> Ian
> 
>>>> +
>>>>    static const char * const arm_spe_packet_name[] = {
>>>>           [ARM_SPE_PAD]           = "PAD",
>>>>           [ARM_SPE_END]           = "END",
>>>> @@ -307,6 +309,11 @@ static const struct ev_string common_ev_strings[] = {
>>>>           { .event = 0, .desc = NULL },
>>>>    };
>>>>
>>>> +static const struct ev_string n1_event_strings[] = {
>>>> +       { .event = 12, .desc = "LATE-PREFETCH" },
>>>> +       { .event = 0, .desc = NULL },
>>>> +};
>>>> +
>>>>    static u64 print_event_list(int *err, char **buf, size_t *buf_len,
>>>>                               const struct ev_string *ev_strings, u64 payload)
>>>>    {
>>>> @@ -318,14 +325,44 @@ static u64 print_event_list(int *err, char **buf, size_t *buf_len,
>>>>           return payload;
>>>>    }
>>>>
>>>> +struct event_print_handle {
>>>> +       const struct midr_range *midr_ranges;
>>>> +       const struct ev_string *ev_strings;
>>>> +};
>>>> +
>>>> +#define EV_PRINT(range, strings)                       \
>>>> +       {                                       \
>>>> +               .midr_ranges = range,           \
>>>> +               .ev_strings = strings,  \
>>>> +       }
>>>> +
>>>> +static const struct midr_range n1_event_encoding_cpus[] = {
>>>> +       MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
>>>> +       {},
>>>> +};
>>>> +
>>>> +static const struct event_print_handle event_print_handles[] = {
>>>> +       EV_PRINT(n1_event_encoding_cpus, n1_event_strings),
>>>> +};
>>>> +
>>>>    static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
>>>> -                                 char *buf, size_t buf_len)
>>>> +                                 char *buf, size_t buf_len, u64 midr)
>>>>    {
>>>>           u64 payload = packet->payload;
>>>>           int err = 0;
>>>>
>>>>           arm_spe_pkt_out_string(&err, &buf, &buf_len, "EV");
>>>> -       print_event_list(&err, &buf, &buf_len, common_ev_strings, payload);
>>>> +       payload = print_event_list(&err, &buf, &buf_len, common_ev_strings,
>>>> +                                  payload);
>>>> +
>>>> +       /* Try to decode IMPDEF bits for known CPUs */
>>>> +       for (unsigned int i = 0; i < ARRAY_SIZE(event_print_handles); i++) {
>>>> +               if (is_midr_in_range_list(midr,
>>>> +                                         event_print_handles[i].midr_ranges))
>>>> +                       payload = print_event_list(&err, &buf, &buf_len,
>>>> +                                                  event_print_handles[i].ev_strings,
>>>> +                                                  payload);
>>>> +       }
>>>>
>>>>           return err;
>>>>    }
>>>> @@ -506,7 +543,7 @@ static int arm_spe_pkt_desc_counter(const struct arm_spe_pkt *packet,
>>>>    }
>>>>
>>>>    int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>>>> -                    size_t buf_len)
>>>> +                    size_t buf_len, u64 midr)
>>>>    {
>>>>           int idx = packet->index;
>>>>           unsigned long long payload = packet->payload;
>>>> @@ -522,7 +559,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>>>>                   arm_spe_pkt_out_string(&err, &buf, &blen, "%s", name);
>>>>                   break;
>>>>           case ARM_SPE_EVENTS:
>>>> -               err = arm_spe_pkt_desc_event(packet, buf, buf_len);
>>>> +               err = arm_spe_pkt_desc_event(packet, buf, buf_len, midr);
>>>>                   break;
>>>>           case ARM_SPE_OP_TYPE:
>>>>                   err = arm_spe_pkt_desc_op_type(packet, buf, buf_len);
>>>> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
>>>> index adf4cde320aa..17b067fe3c87 100644
>>>> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
>>>> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
>>>> @@ -11,7 +11,7 @@
>>>>    #include <stddef.h>
>>>>    #include <stdint.h>
>>>>
>>>> -#define ARM_SPE_PKT_DESC_MAX           256
>>>> +#define ARM_SPE_PKT_DESC_MAX           512
>>>>
>>>>    #define ARM_SPE_NEED_MORE_BYTES                -1
>>>>    #define ARM_SPE_BAD_PACKET             -2
>>>> @@ -186,5 +186,6 @@ const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
>>>>    int arm_spe_get_packet(const unsigned char *buf, size_t len,
>>>>                          struct arm_spe_pkt *packet);
>>>>
>>>> -int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf, size_t len);
>>>> +int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf, size_t len,
>>>> +                    u64 midr);
>>>>    #endif
>>>> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
>>>> index 7447b000f9cd..46f0309c092b 100644
>>>> --- a/tools/perf/util/arm-spe.c
>>>> +++ b/tools/perf/util/arm-spe.c
>>>> @@ -135,7 +135,7 @@ struct data_source_handle {
>>>>           }
>>>>
>>>>    static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
>>>> -                        unsigned char *buf, size_t len)
>>>> +                        unsigned char *buf, size_t len, u64 midr)
>>>>    {
>>>>           struct arm_spe_pkt packet;
>>>>           size_t pos = 0;
>>>> @@ -161,7 +161,7 @@ static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
>>>>                           color_fprintf(stdout, color, "   ");
>>>>                   if (ret > 0) {
>>>>                           ret = arm_spe_pkt_desc(&packet, desc,
>>>> -                                              ARM_SPE_PKT_DESC_MAX);
>>>> +                                              ARM_SPE_PKT_DESC_MAX, midr);
>>>>                           if (!ret)
>>>>                                   color_fprintf(stdout, color, " %s\n", desc);
>>>>                   } else {
>>>> @@ -174,10 +174,10 @@ static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
>>>>    }
>>>>
>>>>    static void arm_spe_dump_event(struct arm_spe *spe, unsigned char *buf,
>>>> -                              size_t len)
>>>> +                              size_t len, u64 midr)
>>>>    {
>>>>           printf(".\n");
>>>> -       arm_spe_dump(spe, buf, len);
>>>> +       arm_spe_dump(spe, buf, len, midr);
>>>>    }
>>>>
>>>>    static int arm_spe_get_trace(struct arm_spe_buffer *b, void *data)
>>>> @@ -1469,8 +1469,11 @@ static int arm_spe_process_auxtrace_event(struct perf_session *session,
>>>>                   /* Dump here now we have copied a piped trace out of the pipe */
>>>>                   if (dump_trace) {
>>>>                           if (auxtrace_buffer__get_data(buffer, fd)) {
>>>> +                               u64 midr = 0;
>>>> +
>>>> +                               arm_spe__get_midr(spe, buffer->cpu.cpu, &midr);
>>>
>>> Sashiko claims to have spotted an issue here:
>>> """
>>> Is it possible for arm_spe__get_midr() to cause a segmentation fault here?
>>>
>>> If the trace is from an older recording (metadata version 1) and the
>>> environment lacks a CPUID string (such as during cross-architecture
>>> analysis), perf_env__cpuid() returns NULL.
>>>
>>> It appears arm_spe__get_midr() then passes this NULL pointer to
>>> strtol(cpuid, NULL, 16), which leads to undefined behavior.
>>> """
>>>
>>> But this feels like, if this happens you're already having a bad time
>>> and these changes aren't necessarily making things worse.
>>>
>>> Thanks,
>>> Ian
>>>
>>
>> Yeah I think it might be possible so I can add an error instead of a
>> segfault. I'll check the rest of the Sashiko comments too.
>>
>>>>                                   arm_spe_dump_event(spe, buffer->data,
>>>> -                                               buffer->size);
>>>> +                                               buffer->size, midr);
>>>>                                   auxtrace_buffer__put_data(buffer);
>>>>                           }
>>>>                   }
>>>>
>>>> --
>>>> 2.34.1
>>>>
>>

