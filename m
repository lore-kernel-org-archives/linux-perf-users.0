Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709AF3783C9
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Apr 2026 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775565322; cv=none; b=oDIWuGCj+fBNYo8rNRMBCNevpG0W4o1GIMm1YFDI86Ln7BdAVferw50AH9TucaWhjmmRYD6sV/ryiZ2ASz8rtyk9RLpKjMwuHoedTkwOCdohap+NTtyphgHzjNh0jfktnlc3YCR0IZXV9p9BgBzZg1Xqumyk7PVjgP+7OQ1u9ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775565322; c=relaxed/simple;
	bh=pa73AlHnnnNKmcWgkzu5nAtWsCq/a1AMChQ6+sgaC0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fnB+QB6p7HB20TPrRH8W0kWrbEXsu0QleXCcmQWYwiC6F57qbzVhr8E935Vpgiyb5n+oPlf+EkiLS6p71EsBrPrYotS9aKNc8miZoYF9FCMkbJCDSIzHOizFIkYuXYhy7G9eAZp8KKPK1Rgc+V1M+ENKpLRKyJNMzT6J7ayXy8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aQolJkCD; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aQolJkCD"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b9358dd7f79so916276466b.1
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Apr 2026 05:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775565319; x=1776170119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IlLMdkxF2W1r/jVdkYBQ+fiAEAbN2x1XXxv6OXDhViE=;
        b=aQolJkCDdEkC0ILWpkb8FZC+Uo1YRI2Fum8zKSeGjKkjKs0VdArC3Hp6lqVTzlBMh7
         u4r7uBrw0EN36cgiW+Z+CdWTuu2I0iaDp+6DmJbwTVE/QCsehgLHn5FlqUK3TJRYujbC
         xd42f7sSODkfPoGLspbaZTjaU5BLg10Pzx0wXNx3nAPGUGIZBwlLGGpR33GzY5vn3w/B
         W++Aqt0lcnvtam2tRjoom5MtY2iEBD18hsD2r9p+3olXjqttgnUlwrD+2LgryJbveUoG
         ZzKIem8KAcV6y7w/EwEzckPbbyYftzZoOBShGohv6tuvYNi3U13VK3thc/eGw/OYGD8W
         XJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775565319; x=1776170119;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IlLMdkxF2W1r/jVdkYBQ+fiAEAbN2x1XXxv6OXDhViE=;
        b=faDPiAs/fcR4e5oF34zF1cBvW5dZXhsFv7V0jZJGZ+GnSFcr+m5Cj1lOEMdsQ6qXaX
         Ppq5iCh7NxSFx3JGBESmUjbuIw6MxhiANGk/9tOGpE9hm1qV52pvHjbRfWFZQ4zYiBam
         oOJqOzoqrJIWKZWeONAUc+3umU0BcdJ9L41MGirh+A4EiHYfsQQpKBwscV1EQPirwCyG
         zHrVfAyc7jSOqgcty7Y4N91TK3Z9isiut7q16pp0AYYb73jwuIyIAhKlzsmifEwXAXXU
         6wxOM6BB46+nU5Fqj7UVKuWcoNQcCW5YFHB5bRB8yPH99GH8m1lW0Ax36PzCCaoDK9eB
         eP5w==
X-Forwarded-Encrypted: i=1; AJvYcCW+G01Jx0ghbPZPQ3xS51VoK/kGk9GlnZdcpiM+75J9ATAmKOh/XYzLiDeYKXFOVlfQdtqh3aXXpFb8NfKrIExT@vger.kernel.org
X-Gm-Message-State: AOJu0YzNdUG+JY/5ZNsbvGe/wMtUsGNdgKSJHqusfw01EWKIYjydGGAj
	23CAqPf3Px9z0pgwI5aEHidRYOa8klrjgLr9l8yonXFrYZ1PzUHFcPOHXL51la2bCSs=
X-Gm-Gg: AeBDieuwsk2quwwrcp/vdjwsEriEYZRSfkogH0L/eMyx8dUj7oOJ8JrwVAMzp3xtNjm
	ynpMz0+zlcqpQ4jm2Nt9TMLJlIvG5HBnuqg8C5Zq9lVC9KX6cSZcnUr1ndlWiL4SUqXcLXLfJNk
	gQRlaX+fpCi4NMqN7FcEdAqITHyEEn/XmsJy/0elsGq/MbVTsHW03Ql/0/nbI74J8dHq/EGprey
	w4wd0Dcag8an+VW+86DWMN8ctAY7OPXeukCDh/7NDBeQ69ykThSVwslH8gE8XbkoHQtH5cMl7EJ
	/JRyrYPseTxiS6kase+4omAlu9TNPONKEVh/cBVTMpxIr2zK5//tyR11W+KpiPCP5yy5vaW61zP
	dpE0K+a0fznOi370O4QqThDPEpvtNpaPOKhLvFtkFyPtbUViRecByA6WJBPlJV6y9YLvxmzSEta
	A5lf+i2jUINA9Vhx+Pyo3Ni3Vmazv4
X-Received: by 2002:a17:907:3cd4:b0:b97:a086:ac9d with SMTP id a640c23a62f3a-b9c67b3de18mr815577566b.43.1775565318453;
        Tue, 07 Apr 2026 05:35:18 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3cff17basm554144066b.50.2026.04.07.05.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 05:35:17 -0700 (PDT)
Message-ID: <ee012f48-5d08-4004-b9d0-bcac825cb50c@linaro.org>
Date: Tue, 7 Apr 2026 13:35:16 +0100
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
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fVcYOJ_3TWd6won5FVaH2MH6QwLhCoCRnNzzeE-9PgO1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 02/04/2026 4:26 pm, Ian Rogers wrote:
> On Wed, Apr 1, 2026 at 7:26 AM James Clark <james.clark@linaro.org> wrote:
>>
>>  From the TRM [1], N1 has one IMPDEF event which isn't covered by the
>> common list. Add a framework so that more cores can be added in the
>> future and that the N1 IMPDEF event can be decoded. Also increase the
>> size of the buffer because we're adding more strings and if it gets
>> truncated it falls back to a hex dump only.
>>
>> [1]: https://developer.arm.com/documentation/100616/0401/Statistical-Profiling-Extension/implementation-defined-features-of-SPE
>> Suggested-by: Al Grant <al.grant@arm.com>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   tools/perf/util/arm-spe-decoder/Build              |  2 +
>>   .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     | 45 ++++++++++++++++++++--
>>   .../util/arm-spe-decoder/arm-spe-pkt-decoder.h     |  5 ++-
>>   tools/perf/util/arm-spe.c                          | 13 ++++---
>>   4 files changed, 54 insertions(+), 11 deletions(-)
>>
>> diff --git a/tools/perf/util/arm-spe-decoder/Build b/tools/perf/util/arm-spe-decoder/Build
>> index ab500e0efe24..97a298d1e279 100644
>> --- a/tools/perf/util/arm-spe-decoder/Build
>> +++ b/tools/perf/util/arm-spe-decoder/Build
>> @@ -1 +1,3 @@
>>   perf-util-y += arm-spe-pkt-decoder.o arm-spe-decoder.o
>> +
>> +CFLAGS_arm-spe-pkt-decoder.o += -I$(srctree)/tools/arch/arm64/include/ -I$(OUTPUT)arch/arm64/include/generated/
>> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
>> index c880b0dec3a1..42a7501d4dfe 100644
>> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
>> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
>> @@ -15,6 +15,8 @@
>>
>>   #include "arm-spe-pkt-decoder.h"
>>
>> +#include "../../arm64/include/asm/cputype.h"
> 
> Sashiko spotted:
> https://sashiko.dev/#/patchset/20260401-james-spe-impdef-decode-v1-0-ad0d372c220c%40linaro.org
> """
> This isn't a bug, but does this include directive rely on accidental
> path normalization?
> 
> The relative path ../../arm64/include/asm/cputype.h does not exist relative
> to arm-spe-pkt-decoder.c. It only compiles because the Build file adds
> -I$(srctree)/tools/arch/arm64/include/ to CFLAGS.
> 
> Would it be cleaner to use #include <asm/cputype.h> to explicitly rely on
> the include path?
> [ ... ]
> """
> I wouldn't use <asm/cputype.h> due to cross-compilation and the like,
> instead just add the extra "../" into the include path.
> 

Do you mean change the #include to this?

   #include "../../../arm64/include/asm/cputype.h"

I still need to add:

   CFLAGS_arm-spe-pkt-decoder.o += -I$(srctree)/tools/arch/arm64/include/

To make the this include in cputype.h work:

   #include <asm/sysreg.h>

Which probably only works because there isn't a sysreg.h on other 
architectures. But I'm not sure what the significance of ../../ vs 
../../../ is if either compile? arm-spe.c already does it with ../../ 
which is what I copied.

>> +
>>   static const char * const arm_spe_packet_name[] = {
>>          [ARM_SPE_PAD]           = "PAD",
>>          [ARM_SPE_END]           = "END",
>> @@ -307,6 +309,11 @@ static const struct ev_string common_ev_strings[] = {
>>          { .event = 0, .desc = NULL },
>>   };
>>
>> +static const struct ev_string n1_event_strings[] = {
>> +       { .event = 12, .desc = "LATE-PREFETCH" },
>> +       { .event = 0, .desc = NULL },
>> +};
>> +
>>   static u64 print_event_list(int *err, char **buf, size_t *buf_len,
>>                              const struct ev_string *ev_strings, u64 payload)
>>   {
>> @@ -318,14 +325,44 @@ static u64 print_event_list(int *err, char **buf, size_t *buf_len,
>>          return payload;
>>   }
>>
>> +struct event_print_handle {
>> +       const struct midr_range *midr_ranges;
>> +       const struct ev_string *ev_strings;
>> +};
>> +
>> +#define EV_PRINT(range, strings)                       \
>> +       {                                       \
>> +               .midr_ranges = range,           \
>> +               .ev_strings = strings,  \
>> +       }
>> +
>> +static const struct midr_range n1_event_encoding_cpus[] = {
>> +       MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
>> +       {},
>> +};
>> +
>> +static const struct event_print_handle event_print_handles[] = {
>> +       EV_PRINT(n1_event_encoding_cpus, n1_event_strings),
>> +};
>> +
>>   static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
>> -                                 char *buf, size_t buf_len)
>> +                                 char *buf, size_t buf_len, u64 midr)
>>   {
>>          u64 payload = packet->payload;
>>          int err = 0;
>>
>>          arm_spe_pkt_out_string(&err, &buf, &buf_len, "EV");
>> -       print_event_list(&err, &buf, &buf_len, common_ev_strings, payload);
>> +       payload = print_event_list(&err, &buf, &buf_len, common_ev_strings,
>> +                                  payload);
>> +
>> +       /* Try to decode IMPDEF bits for known CPUs */
>> +       for (unsigned int i = 0; i < ARRAY_SIZE(event_print_handles); i++) {
>> +               if (is_midr_in_range_list(midr,
>> +                                         event_print_handles[i].midr_ranges))
>> +                       payload = print_event_list(&err, &buf, &buf_len,
>> +                                                  event_print_handles[i].ev_strings,
>> +                                                  payload);
>> +       }
>>
>>          return err;
>>   }
>> @@ -506,7 +543,7 @@ static int arm_spe_pkt_desc_counter(const struct arm_spe_pkt *packet,
>>   }
>>
>>   int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>> -                    size_t buf_len)
>> +                    size_t buf_len, u64 midr)
>>   {
>>          int idx = packet->index;
>>          unsigned long long payload = packet->payload;
>> @@ -522,7 +559,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>>                  arm_spe_pkt_out_string(&err, &buf, &blen, "%s", name);
>>                  break;
>>          case ARM_SPE_EVENTS:
>> -               err = arm_spe_pkt_desc_event(packet, buf, buf_len);
>> +               err = arm_spe_pkt_desc_event(packet, buf, buf_len, midr);
>>                  break;
>>          case ARM_SPE_OP_TYPE:
>>                  err = arm_spe_pkt_desc_op_type(packet, buf, buf_len);
>> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
>> index adf4cde320aa..17b067fe3c87 100644
>> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
>> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
>> @@ -11,7 +11,7 @@
>>   #include <stddef.h>
>>   #include <stdint.h>
>>
>> -#define ARM_SPE_PKT_DESC_MAX           256
>> +#define ARM_SPE_PKT_DESC_MAX           512
>>
>>   #define ARM_SPE_NEED_MORE_BYTES                -1
>>   #define ARM_SPE_BAD_PACKET             -2
>> @@ -186,5 +186,6 @@ const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
>>   int arm_spe_get_packet(const unsigned char *buf, size_t len,
>>                         struct arm_spe_pkt *packet);
>>
>> -int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf, size_t len);
>> +int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf, size_t len,
>> +                    u64 midr);
>>   #endif
>> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
>> index 7447b000f9cd..46f0309c092b 100644
>> --- a/tools/perf/util/arm-spe.c
>> +++ b/tools/perf/util/arm-spe.c
>> @@ -135,7 +135,7 @@ struct data_source_handle {
>>          }
>>
>>   static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
>> -                        unsigned char *buf, size_t len)
>> +                        unsigned char *buf, size_t len, u64 midr)
>>   {
>>          struct arm_spe_pkt packet;
>>          size_t pos = 0;
>> @@ -161,7 +161,7 @@ static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
>>                          color_fprintf(stdout, color, "   ");
>>                  if (ret > 0) {
>>                          ret = arm_spe_pkt_desc(&packet, desc,
>> -                                              ARM_SPE_PKT_DESC_MAX);
>> +                                              ARM_SPE_PKT_DESC_MAX, midr);
>>                          if (!ret)
>>                                  color_fprintf(stdout, color, " %s\n", desc);
>>                  } else {
>> @@ -174,10 +174,10 @@ static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
>>   }
>>
>>   static void arm_spe_dump_event(struct arm_spe *spe, unsigned char *buf,
>> -                              size_t len)
>> +                              size_t len, u64 midr)
>>   {
>>          printf(".\n");
>> -       arm_spe_dump(spe, buf, len);
>> +       arm_spe_dump(spe, buf, len, midr);
>>   }
>>
>>   static int arm_spe_get_trace(struct arm_spe_buffer *b, void *data)
>> @@ -1469,8 +1469,11 @@ static int arm_spe_process_auxtrace_event(struct perf_session *session,
>>                  /* Dump here now we have copied a piped trace out of the pipe */
>>                  if (dump_trace) {
>>                          if (auxtrace_buffer__get_data(buffer, fd)) {
>> +                               u64 midr = 0;
>> +
>> +                               arm_spe__get_midr(spe, buffer->cpu.cpu, &midr);
> 
> Sashiko claims to have spotted an issue here:
> """
> Is it possible for arm_spe__get_midr() to cause a segmentation fault here?
> 
> If the trace is from an older recording (metadata version 1) and the
> environment lacks a CPUID string (such as during cross-architecture
> analysis), perf_env__cpuid() returns NULL.
> 
> It appears arm_spe__get_midr() then passes this NULL pointer to
> strtol(cpuid, NULL, 16), which leads to undefined behavior.
> """
> 
> But this feels like, if this happens you're already having a bad time
> and these changes aren't necessarily making things worse.
> 
> Thanks,
> Ian
> 

Yeah I think it might be possible so I can add an error instead of a 
segfault. I'll check the rest of the Sashiko comments too.

>>                                  arm_spe_dump_event(spe, buffer->data,
>> -                                               buffer->size);
>> +                                               buffer->size, midr);
>>                                  auxtrace_buffer__put_data(buffer);
>>                          }
>>                  }
>>
>> --
>> 2.34.1
>>

