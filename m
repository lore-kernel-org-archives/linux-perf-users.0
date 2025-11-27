Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E110532ABCF
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Nov 2025 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764251310; cv=none; b=tMMaY/z+DqAz7W1ZMSrKsoyQfgnKKY5dC1+qDha8OhCoxupc9QRHwgBjw+KWLGXwNVbxd193f0W5/0A0RpFV3KK2zE3aqpnGBRKtST97pB+M8hZGhrm+vBWXVxEfjzNSseYXYolsYCSE6UmbHWyOIoUlywVSmavgrKSLSTGK+aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764251310; c=relaxed/simple;
	bh=9X6VetEin9U03e5jZaFQu5PJaplgFFuIrSySNDCnMaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YngNG7iFyF/9+CGHbs0qoaVZAcc8ydWkBlVpWpe3zu3DIFQ5WfsotfjLav/yXQ7jZeMPbEuya1bfNU4MtTvIkF/F7IrB3wbeCn6cRjlv/tYzcYNPEZvYkh+u77Nyj4Nkme+Y5IzdavpAHa8tIngaFohICYWYTTbM1CrTmTXNTWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vdUuQD1G; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vdUuQD1G"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso3556025e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Nov 2025 05:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764251305; x=1764856105; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZ3aIF7jZy1lOd6ZpW4yfHlcafT3KJiSOUlsU84qv8w=;
        b=vdUuQD1G2W/jBo9QLm1BUXFQUzanruDBTE74AAriDZiu21VZMobnFlQz4k8WttmIdB
         1AiGY2d0PEsz9+OaQ+Curw1ZeuoEK2vWps717iO2dz8dJ7hJpr24W94hQ5pdMsNjeYH/
         nDQZ/qnLUZLYwHx75yggnT4f1Uk/9dwj76c+RVEiAbKOKdt3zJntgx7XgcKsYQlloLor
         p6x5BSdM0Q2VcCnvQkGLAZ32RKxBd49nU8hlW9mQVyMXpKdhFFsCyvysgEx3wH0JrfPA
         x0v2O13xIAqFJqS7biyFL2ck6znEKY4EbQeAgcgwKJvhOOKRZUAwjD2b3t48BQ2SBpqB
         /gXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764251305; x=1764856105;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RZ3aIF7jZy1lOd6ZpW4yfHlcafT3KJiSOUlsU84qv8w=;
        b=I8DvE+5Ij4bKaAy8AQTTbqSAmKWtIoqpo0Mrae8+rd4u3W+gq+WNbH3AfnlmgIqbg3
         RblYDcQYbX5LpmXiKMFT3jXv5iW7s2+5C84QkQhFCkd3gR1s06M9wkvrvNcVnrCrMy+p
         5TcV1LJ1H4DRSj5WvQVmmM8e4EowtGPCc/4s9aavZmrD+QsUXgWOtN/Dq4ZuvtuIn7TZ
         M4vd7R/5jKLT/HfdbdH89D/si6SEGn9sXQfr1/RAebSZPTXL8llmNDg72FCfnxogQ8rv
         o8bL6Vqt/8EIJu7W+Suit30NlL4aYwI7pEOeI/sn4VpNsTcVSpSpyMwWGukLvzNsIDYT
         oCZw==
X-Forwarded-Encrypted: i=1; AJvYcCWqQNj9SxZeTo7oJCir0cU2xL9FHJ3UtE7/GkdV1vFAc2ceLyMAo1SqpRqWH6CADjM1Ee1k+rexBxOqwr66Q1fL@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7OHHmCxxznmv3KWmwejm6oDtHIpRSil/AQTortlXTqtFfij+1
	oZLUY48NH7etKGKXRm9mKl5v48bpSGhFOucmS0Y4yk+F+BfvJv058hy4c1bx1SwVSyY=
X-Gm-Gg: ASbGncvay85KyGXJS/tlBLLui3ix+7pU/A2F30OOXvRtYk1o49LgfBzX8ONRvOy18aH
	2Y2udgmPjO5NT55enx/OLFTd+twpzi2gnNTnZIpwjatB4M2fZwO93h7cCSeyPOkb+sIxe4yl6jz
	d3C9QLvnQ9TsSUqCKVslGmu/jxhurpdsg74d0hT02pAvFKi02faC8DIJz2vbNLJE0PSNKeStNJM
	wypx7e3a3XgoiUePFQQNkGvZJXUQrcWRuM2/yucomtZ0yz51lwBkW+XIfPe2D5vUqbDskEUKYDP
	VQIVS8yAh+NFTuA8+1YR4+zNvbcnU1kWfzsv+2fj87cgu5DuO5eduyRrw7eX4DpBf1P91m33Qpr
	oEe31hZ5z2TKa40oPGy+4iJPmmtm9LbNtLHK4EN37x2jfgnZ1OyX+WllQIAuTUoB5LQpsBV+fNi
	XBhS/tj6tXc+e5aVHZ
X-Google-Smtp-Source: AGHT+IHUTGs1DrPGNZ8JOg+M9RFIeRx0IklaVBwTkvmXFsO5OCAfdrZiAAfJZmxmpX9idbD7b+urgw==
X-Received: by 2002:a05:600c:1f8f:b0:477:3e0b:c0e3 with SMTP id 5b1f17b1804b1-477c01eba39mr217221735e9.32.1764251304988;
        Thu, 27 Nov 2025 05:48:24 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790b0c3a1dsm101916505e9.10.2025.11.27.05.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 05:48:24 -0800 (PST)
Message-ID: <d808f86b-551c-4028-97c0-d468dac71d51@linaro.org>
Date: Thu, 27 Nov 2025 13:48:23 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf addr2line: Add a libdw implementation
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Tony Jones <tonyj@suse.de>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Howard Chu <howardchu95@gmail.com>,
 Stephen Brennan <stephen.s.brennan@oracle.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20251122093934.94971-1-irogers@google.com>
 <aSdGq2K6TRMyG009@google.com>
 <CAP-5=fULHMCw=b0PuN07r=aAjoamb+MNSNrHM3nyHPYM2DGkow@mail.gmail.com>
 <f85dacc5-5d81-4ee7-acf3-8aa053c42dab@linaro.org>
 <CAP-5=fW01urmSotcEHauc3xVUPqDRhkBttCvpa=6FuJyRaxiEw@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fW01urmSotcEHauc3xVUPqDRhkBttCvpa=6FuJyRaxiEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 27/11/2025 1:19 pm, Ian Rogers wrote:
> On Thu, Nov 27, 2025 at 4:16 AM James Clark <james.clark@linaro.org> wrote:
>>
>>
>>
>> On 27/11/2025 11:43 am, Ian Rogers wrote:
>>> On Wed, Nov 26, 2025 at 10:27 AM Namhyung Kim <namhyung@kernel.org> wrote:
>>>>
>>>> On Sat, Nov 22, 2025 at 01:39:34AM -0800, Ian Rogers wrote:
>>>>> Add an implementation of addr2line that uses libdw. Other addr2line
>>>>> implementations or, in the case of forking addr2line, slow. Add an
>>>>> implementation that caches the libdw information in the dso and uses
>>>>> it to find the file and line number information.
>>>
>>> Thanks James and Namhyung for the reviews! I agree with James' comment
>>> about a typo in the commit message.
>>>
>>>> My concern is the limit in the open file descriptors in case the data
>>>> touched a lot of different libraries.  The DSO code has some logic to
>>>> deal with it but I'm not sure if we can share that since libdw seems to
>>>> want to own the FD.
>>>
>>> The code opens the FD:
>>>
>>> +               fd = open(dso_name, O_RDONLY);
>>> +               if (fd < 0)
>>> +                       return 0;
>>> +
>>> +               dwfl = dwfl_begin(&offline_callbacks);
>>> +               if (!dwfl) {
>>> +                       close(fd);
>>> +                       return 0;
>>> +               }
>>>
>>> It then uses the FD and closes it (the close is hidden in libdw itself):
>>>
>>> +               /*
>>> +                * If the report is successful, the file descriptor fd
>>> is consumed
>>> +                * and closed by the Dwfl. If not, it is not closed.
>>> +                */
>>> +               mod = dwfl_report_offline(dwfl, dso_name, dso_name, fd);
>>>
>>> So it is possible we exhaust all the file descriptors if there are
>>> multiple concurrent calls to libdw__addr2line and every dso has
>>> missing libdw dwfl data... but because the open/close are close
>>> together and that 1 FD is say small to the FDs needed for the
>>> cmd__addr2line, I don't think it is a problem we need to specifically
>>> handle. Were the FD kept open until the dso was deleted, I'd agree
>>> with you.
>>>
>>>> Also, have you checked if this generates the exactly same output with
>>>> other implementations?
>>>
>>> So the code passes `perf test` and I was checking functionality with
>>> perf annotate, top, etc. What I saw looked good, but it may not have
>>> been exhaustive. I didn't specifically create a test that compares the
>>> output of the different addr2line implementations. Such a test would
>>> be possible, it's not something we've done elsewhere.
>>>
>>> Thanks,
>>> Ian
>>>
>>
>> I manually looked at a couple of line numbers and they looked
>> reasonable. I think an automated test that compared dwarf decoders would
>> be a bit of a nightmare because I'm sure there would always be subtle
>> differences.
>>
>> Doing a manual side by side comparison of libdw__addr2line() and
>> llvm__addr2line(), they seem to be quite different:
>>
>>     $ perf record -- perf test -w leafloop
>>     $ perf script -F ip,srcline > libdw_addr2line.txt
>>     # Comment out libdw_addr2line() and rebuild
>>     $ perf script -F ip,srcline > llvm_addr2line.txt
>>     $ diff libdw_addr2line.txt llvm_addr2line.txt
>>
>> It gets all of the simple leafloop workload lines the same, but lots of
>> the libc stuff is different.
>>
>> For example libdw gives cpu-features.c:350 where llvm gives strcmp.S. At
>> least that one looks like inlining so llvm might be "better", but where
>> it gives dl-cache.c:490 isntead of llvm's mmap64.c:47, it's hard to see
>> how that can be inlining if they're in different compilation units.
>>
>> If the llvm addr2line implementation is also supposed to be slow, it
>> just means we're trading speed with accuracy with this change. Hard to
>> say what the default should be in that case.
> 
> Agreed. We could do some kind of option scheme like with the disassemblers:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/disasm.c?h=perf-tools-next#n1715
> 
> I'm not sure there are currently any distributions using the LLVM
> options, this in part motivates:
> https://lore.kernel.org/lkml/20251007163835.3152881-1-irogers@google.com/
> but the addr2line APIs are a pain there - see the extra generated .so.
> Because of that it could be reasonable to delete the LLVM addr2line
> code and just focus on libdw. I kind of wish we could also delete the
> precarious command forking versions too. And libbfd... Perhaps with
> this code, those advocating libbfd have a fast enough alternative
> without bringing in large dependencies like libLLVM.
> 
> Thanks,
> Ian
> 

Personally for debugging I would want the most accurate and detailed 
information possible and don't care at all about the size of 
dependencies. If Perf is a tool for debugging then surely that should be 
the default? But right now I don't actually know which of the outputs is 
most accurate although I'll assume that the llvm one is.

Wanting the smallest application possible while trading away detail and 
accuracy seems like an unusual special case that should be opt in. It 
also seems to relate to this old discussion [1], in that if we're going 
to keep the llvm depencency then it doesn't make sense to re-write 
anything in Perf.

[1]: 
https://lore.kernel.org/linux-perf-users/549d3812-a606-4981-83f5-0a99b0ff9f6a@linaro.org/

>>>> Thanks,
>>>> Namhyung
>>>>
>>>>>
>>>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>>>> ---
>>>>>    tools/perf/util/Build     |   1 +
>>>>>    tools/perf/util/dso.c     |   2 +
>>>>>    tools/perf/util/dso.h     |  11 +++
>>>>>    tools/perf/util/libdw.c   | 136 ++++++++++++++++++++++++++++++++++++++
>>>>>    tools/perf/util/libdw.h   |  60 +++++++++++++++++
>>>>>    tools/perf/util/srcline.c |   5 ++
>>>>>    6 files changed, 215 insertions(+)
>>>>>    create mode 100644 tools/perf/util/libdw.c
>>>>>    create mode 100644 tools/perf/util/libdw.h
>>>>>
>>>>> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
>>>>> index 1c2a43e1dc68..2bed6274e248 100644
>>>>> --- a/tools/perf/util/Build
>>>>> +++ b/tools/perf/util/Build
>>>>> @@ -224,6 +224,7 @@ perf-util-$(CONFIG_LIBDW) += dwarf-regs-powerpc.o
>>>>>    perf-util-$(CONFIG_LIBDW) += dwarf-regs-x86.o
>>>>>    perf-util-$(CONFIG_LIBDW) += debuginfo.o
>>>>>    perf-util-$(CONFIG_LIBDW) += annotate-data.o
>>>>> +perf-util-$(CONFIG_LIBDW) += libdw.o
>>>>>
>>>>>    perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
>>>>>    perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind-local.o
>>>>> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
>>>>> index 344e689567ee..06980844c014 100644
>>>>> --- a/tools/perf/util/dso.c
>>>>> +++ b/tools/perf/util/dso.c
>>>>> @@ -32,6 +32,7 @@
>>>>>    #include "string2.h"
>>>>>    #include "vdso.h"
>>>>>    #include "annotate-data.h"
>>>>> +#include "libdw.h"
>>>>>
>>>>>    static const char * const debuglink_paths[] = {
>>>>>         "%.0s%s",
>>>>> @@ -1605,6 +1606,7 @@ void dso__delete(struct dso *dso)
>>>>>         auxtrace_cache__free(RC_CHK_ACCESS(dso)->auxtrace_cache);
>>>>>         dso_cache__free(dso);
>>>>>         dso__free_a2l(dso);
>>>>> +     dso__free_a2l_libdw(dso);
>>>>>         dso__free_symsrc_filename(dso);
>>>>>         nsinfo__zput(RC_CHK_ACCESS(dso)->nsinfo);
>>>>>         mutex_destroy(dso__lock(dso));
>>>>> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
>>>>> index f8ccb9816b89..4aee23775054 100644
>>>>> --- a/tools/perf/util/dso.h
>>>>> +++ b/tools/perf/util/dso.h
>>>>> @@ -268,6 +268,7 @@ DECLARE_RC_STRUCT(dso) {
>>>>>         const char       *short_name;
>>>>>         const char       *long_name;
>>>>>         void             *a2l;
>>>>> +     void             *a2l_libdw;
>>>>>         char             *symsrc_filename;
>>>>>    #if defined(__powerpc__)
>>>>>         void            *dwfl;                  /* DWARF debug info */
>>>>> @@ -334,6 +335,16 @@ static inline void dso__set_a2l(struct dso *dso, void *val)
>>>>>         RC_CHK_ACCESS(dso)->a2l = val;
>>>>>    }
>>>>>
>>>>> +static inline void *dso__a2l_libdw(const struct dso *dso)
>>>>> +{
>>>>> +     return RC_CHK_ACCESS(dso)->a2l_libdw;
>>>>> +}
>>>>> +
>>>>> +static inline void dso__set_a2l_libdw(struct dso *dso, void *val)
>>>>> +{
>>>>> +     RC_CHK_ACCESS(dso)->a2l_libdw = val;
>>>>> +}
>>>>> +
>>>>>    static inline unsigned int dso__a2l_fails(const struct dso *dso)
>>>>>    {
>>>>>         return RC_CHK_ACCESS(dso)->a2l_fails;
>>>>> diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
>>>>> new file mode 100644
>>>>> index 000000000000..c4331fa8e1a3
>>>>> --- /dev/null
>>>>> +++ b/tools/perf/util/libdw.c
>>>>> @@ -0,0 +1,136 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +#include "dso.h"
>>>>> +#include "libdw.h"
>>>>> +#include "srcline.h"
>>>>> +#include "symbol.h"
>>>>> +#include "dwarf-aux.h"
>>>>> +#include <fcntl.h>
>>>>> +#include <unistd.h>
>>>>> +#include <elfutils/libdwfl.h>
>>>>> +
>>>>> +void dso__free_a2l_libdw(struct dso *dso)
>>>>> +{
>>>>> +     Dwfl *dwfl = dso__a2l_libdw(dso);
>>>>> +
>>>>> +     if (dwfl) {
>>>>> +             dwfl_end(dwfl);
>>>>> +             dso__set_a2l_libdw(dso, NULL);
>>>>> +     }
>>>>> +}
>>>>> +
>>>>> +int libdw__addr2line(const char *dso_name, u64 addr,
>>>>> +                  char **file, unsigned int *line_nr,
>>>>> +                  struct dso *dso, bool unwind_inlines,
>>>>> +                  struct inline_node *node, struct symbol *sym)
>>>>> +{
>>>>> +     static const Dwfl_Callbacks offline_callbacks = {
>>>>> +             .find_debuginfo = dwfl_standard_find_debuginfo,
>>>>> +             .section_address = dwfl_offline_section_address,
>>>>> +             .find_elf = dwfl_build_id_find_elf,
>>>>> +     };
>>>>> +     Dwfl *dwfl = dso__a2l_libdw(dso);
>>>>> +     Dwfl_Module *mod;
>>>>> +     Dwfl_Line *dwline;
>>>>> +     Dwarf_Addr bias;
>>>>> +     const char *src;
>>>>> +     int lineno;
>>>>> +
>>>>> +     if (!dwfl) {
>>>>> +             /*
>>>>> +              * Initialize Dwfl session.
>>>>> +              * We need to open the DSO file to report it to libdw.
>>>>> +              */
>>>>> +             int fd;
>>>>> +
>>>>> +             fd = open(dso_name, O_RDONLY);
>>>>> +             if (fd < 0)
>>>>> +                     return 0;
>>>>> +
>>>>> +             dwfl = dwfl_begin(&offline_callbacks);
>>>>> +             if (!dwfl) {
>>>>> +                     close(fd);
>>>>> +                     return 0;
>>>>> +             }
>>>>> +
>>>>> +             /*
>>>>> +              * If the report is successful, the file descriptor fd is consumed
>>>>> +              * and closed by the Dwfl. If not, it is not closed.
>>>>> +              */
>>>>> +             mod = dwfl_report_offline(dwfl, dso_name, dso_name, fd);
>>>>> +             if (!mod) {
>>>>> +                     dwfl_end(dwfl);
>>>>> +                     close(fd);
>>>>> +                     return 0;
>>>>> +             }
>>>>> +
>>>>> +             dwfl_report_end(dwfl, /*removed=*/NULL, /*arg=*/NULL);
>>>>> +             dso__set_a2l_libdw(dso, dwfl);
>>>>> +     } else {
>>>>> +             /* Dwfl session already initialized, get module for address. */
>>>>> +             mod = dwfl_addrmodule(dwfl, addr);
>>>>> +     }
>>>>> +
>>>>> +     if (!mod)
>>>>> +             return 0;
>>>>> +
>>>>> +     /* Find source line information for the address. */
>>>>> +     dwline = dwfl_module_getsrc(mod, addr);
>>>>> +     if (!dwline)
>>>>> +             return 0;
>>>>> +
>>>>> +     /* Get line information. */
>>>>> +     src = dwfl_lineinfo(dwline, &addr, &lineno, /*col=*/NULL, /*mtime=*/NULL, /*length=*/NULL);
>>>>> +
>>>>> +     if (file)
>>>>> +             *file = src ? strdup(src) : NULL;
>>>>> +     if (line_nr)
>>>>> +             *line_nr = lineno;
>>>>> +
>>>>> +     /* Optionally unwind inline function call chain. */
>>>>> +     if (unwind_inlines && node && src) {
>>>>> +             Dwarf_Die *cudie = dwfl_module_addrdie(mod, addr, &bias);
>>>>> +             Dwarf_Die *scopes = NULL;
>>>>> +             int nscopes;
>>>>> +
>>>>> +             if (!cudie)
>>>>> +                     return 1;
>>>>> +
>>>>> +             nscopes = die_get_scopes(cudie, addr, &scopes);
>>>>> +             if (nscopes > 0) {
>>>>> +                     int i;
>>>>> +                     const char *call_file = src;
>>>>> +                     unsigned int call_line = lineno;
>>>>> +
>>>>> +                     for (i = 0; i < nscopes; i++) {
>>>>> +                             Dwarf_Die *die = &scopes[i];
>>>>> +                             struct symbol *inline_sym;
>>>>> +                             char *srcline = NULL;
>>>>> +                             int tag = dwarf_tag(die);
>>>>> +
>>>>> +                             /* We are interested in inlined subroutines. */
>>>>> +                             if (tag != DW_TAG_inlined_subroutine &&
>>>>> +                                 tag != DW_TAG_subprogram)
>>>>> +                                     continue;
>>>>> +
>>>>> +                             inline_sym = new_inline_sym(dso, sym, dwarf_diename(die));
>>>>> +
>>>>> +                             if (call_file)
>>>>> +                                     srcline = srcline_from_fileline(call_file, call_line);
>>>>> +
>>>>> +                             inline_list__append(inline_sym, srcline, node);
>>>>> +
>>>>> +                             /* Update call site for next level. */
>>>>> +                             if (tag == DW_TAG_inlined_subroutine) {
>>>>> +                                     call_file = die_get_call_file(die);
>>>>> +                                     call_line = die_get_call_lineno(die);
>>>>> +                             } else {
>>>>> +                                     /* Reached the root subprogram. */
>>>>> +                                     break;
>>>>> +                             }
>>>>> +                     }
>>>>> +                     free(scopes);
>>>>> +             }
>>>>> +     }
>>>>> +
>>>>> +     return 1;
>>>>> +}
>>>>> diff --git a/tools/perf/util/libdw.h b/tools/perf/util/libdw.h
>>>>> new file mode 100644
>>>>> index 000000000000..0f8d7b4a11a5
>>>>> --- /dev/null
>>>>> +++ b/tools/perf/util/libdw.h
>>>>> @@ -0,0 +1,60 @@
>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>>> +#ifndef PERF_LIBDW_H
>>>>> +#define PERF_LIBDW_H
>>>>> +
>>>>> +#include <linux/types.h>
>>>>> +
>>>>> +struct dso;
>>>>> +struct inline_node;
>>>>> +struct symbol;
>>>>> +
>>>>> +#ifdef HAVE_LIBDW_SUPPORT
>>>>> +/*
>>>>> + * libdw__addr2line - Convert address to source location using libdw
>>>>> + * @dso_name: Name of the DSO
>>>>> + * @addr: Address to resolve
>>>>> + * @file: Pointer to return filename (caller must free)
>>>>> + * @line_nr: Pointer to return line number
>>>>> + * @dso: The dso struct
>>>>> + * @unwind_inlines: Whether to unwind inline function calls
>>>>> + * @node: Inline node list to append to
>>>>> + * @sym: The symbol associated with the address
>>>>> + *
>>>>> + * This function initializes a Dwfl context for the DSO if not already present,
>>>>> + * finds the source line information for the given address, and optionally
>>>>> + * resolves inline function call chains.
>>>>> + *
>>>>> + * Returns 1 on success (found), 0 on failure (not found).
>>>>> + */
>>>>> +int libdw__addr2line(const char *dso_name, u64 addr, char **file,
>>>>> +                  unsigned int *line_nr, struct dso *dso,
>>>>> +                  bool unwind_inlines, struct inline_node *node,
>>>>> +                  struct symbol *sym);
>>>>> +
>>>>> +/*
>>>>> + * dso__free_a2l_libdw - Free libdw resources associated with the DSO
>>>>> + * @dso: The dso to free resources for
>>>>> + *
>>>>> + * This function cleans up the Dwfl context used for addr2line lookups.
>>>>> + */
>>>>> +void dso__free_a2l_libdw(struct dso *dso);
>>>>> +
>>>>> +#else /* HAVE_LIBDW_SUPPORT */
>>>>> +
>>>>> +static inline int libdw__addr2line(const char *dso_name __maybe_unused,
>>>>> +                                u64 addr __maybe_unused, char **file __maybe_unused,
>>>>> +                                unsigned int *line_nr __maybe_unused,
>>>>> +                                struct dso *dso __maybe_unused,
>>>>> +                                bool unwind_inlines __maybe_unused,
>>>>> +                                struct inline_node *node __maybe_unused,
>>>>> +                                struct symbol *sym __maybe_unused)
>>>>> +{
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>> +static inline void dso__free_a2l_libdw(struct dso *dso __maybe_unused)
>>>>> +{
>>>>> +}
>>>>> +#endif /* HAVE_LIBDW_SUPPORT */
>>>>> +
>>>>> +#endif /* PERF_LIBDW_H */
>>>>> diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
>>>>> index 27c0966611ab..4b456c4d4138 100644
>>>>> --- a/tools/perf/util/srcline.c
>>>>> +++ b/tools/perf/util/srcline.c
>>>>> @@ -6,6 +6,7 @@
>>>>>    #include "libbfd.h"
>>>>>    #include "llvm.h"
>>>>>    #include "symbol.h"
>>>>> +#include "libdw.h"
>>>>>
>>>>>    #include <inttypes.h>
>>>>>    #include <string.h>
>>>>> @@ -120,6 +121,10 @@ static int addr2line(const char *dso_name, u64 addr, char **file, unsigned int *
>>>>>    {
>>>>>         int ret;
>>>>>
>>>>> +     ret = libdw__addr2line(dso_name, addr, file, line_nr, dso, unwind_inlines, node, sym);
>>>>> +     if (ret > 0)
>>>>> +             return ret;
>>>>> +
>>>>>         ret = llvm__addr2line(dso_name, addr, file, line_nr, dso, unwind_inlines, node, sym);
>>>>>         if (ret > 0)
>>>>>                 return ret;
>>>>> --
>>>>> 2.52.0.rc2.455.g230fcf2819-goog
>>>>>
>>

