Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F073A2676DE
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Nov 2025 14:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339954; cv=none; b=AhzSpsPs7lkbssC55CjSgbMbrD10zyAff4pgUp8r0Nq7MyZDCd+uA3c9+zlzIgVhyX32vkh+VytAj40hkYf0Yl9FFh7ydxvYdPy8Fl//IzqSh23hGvdayyHDR2+KvqUo+pcSC7DU1nJ+Qa35cVQoKQE8ExTnfPmyettAxK7XHAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339954; c=relaxed/simple;
	bh=vyWMoHIj+PuSovFZHchq/447GWUaVnUJhkFDyLPyutQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GGer9qW0As5sDZooQP868rWj7PEtZ+6vbyUPRPw4wjPqxiZik2mMyYeK9MZJfcOjSUSUrTlTavvvzn7zIRJMNJP1HGKtHtAv24XuhzyVToeZI+O9J/LrGsTn6I0295W+V2VuMmP5pnhMe0vpN0GDLLOdcGlOAl1Le1rXYnIIgbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rneBK11s; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rneBK11s"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47755de027eso12498245e9.0
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Nov 2025 06:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764339948; x=1764944748; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v8/ohxAgHHaN2EtQS+Uih5++4UiIx2jDsHKPa01+IIw=;
        b=rneBK11sN7+9RKYKqUeVqSxiGMHqQVqBiRTctEJN1rNziyVnp9Gte2CI1OSAwyUuKR
         o21mdlQcqVONnirqCsn093PKgc00DkSRI3h1ZQojfW7vSBjXSMnPfYw+t6gQ0LfCIdNk
         fnb4tm9afvDPy4Wq+Yz1KTZGsSHabcasZCTOb9Sq4RBiDiEVXqs1DzWQUb30mbqtWk0i
         5iwEgcH1IwYj4zqrI3PQ6JWPyQWqwsQyB250/ydyf7c7vPhHMmoE2KJCyBR6YFNudgjR
         0TMhLykdXRsrR/e6fOuA/lWeet5cgCNQFBZyhhlT4kVVsYeAm0Ee+3TSd7nSnOdCeztP
         odQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764339948; x=1764944748;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v8/ohxAgHHaN2EtQS+Uih5++4UiIx2jDsHKPa01+IIw=;
        b=egcb5HBj1T40MVZD9OfFYU8qzO5/X9MT/9+xeq3sx5KyELjuN+uwNfLfrnqlZJ2IZD
         Gq2NA4MUmLbfgIw2oE0oX6S0bzxZwb/YhxYmdUkJTmkLtJij5o7JK4/ix9dgR4zMJqJ6
         vU2NYcXAleWLcje3a0z9SxiQuo4s7gZnpXInFdhHCgmDH/yFmyiZp/dDWmYo/Cu4Qo+2
         A7fePG6akX6HzgHwRcJeTs0aM13JS0a6QFE9xRu0ttQZ/OZTWUpUiHc1G2H2uu/gYrvA
         fpU1ksnvSK8Zaih+ykozuB2CdG21giOGFo83lgnTf14qraCJJgNeXGn6Wd6VFTJpCBA7
         lA1w==
X-Forwarded-Encrypted: i=1; AJvYcCUWlTNNWQKRDZdkjB7xyIuUuIdt+egaCqeYBCf0qqzF1hpONacH9Ss85VHgZRnTY8e/u0X78MTUlR+AwjsBPCEa@vger.kernel.org
X-Gm-Message-State: AOJu0YyG+ZegHq2ddHkXT9HArCdJ7+0H97xC2wxVElcT1F/9WbCgiY3c
	DxREhnr/ZEglh5zfq8l3KkY1Nb9K8ggZyIKLfkdXkTi1B+K2gkDAy/yD0Rj1w8+/GpUgzCTFcSI
	nE1yn
X-Gm-Gg: ASbGncugHd5Y44kD8P5TA0fqFbnm9yFoA2x8Avjeb+fMsmV2Vu40W3bBhr/voyT7tk2
	qm8OR10xFgn5wi63b7PYQqv4fV9K1TKMAIEwp0umKIv6/ho7+HbpQOVsEQKYtUWKiA2xAGQ7U3+
	uXBG439Kf3/jiYVLWC+yuFtGrYpkj1RPfdEycxRe0RF9BXAAQQxKNTtfzBKaIykbcgCqfLoZ3TV
	fKd7YyBMytkRbbBMEY+7UOF1pjMwN4JOCgjXCgY6ypTJnplLrGyd9qN0OWIwnHWa9q112+Fnbn7
	gFCNe7NPeVbAMapjz6QdANei014fC8ZgfxdYe7GB2i15eO+TFyA1byFlg+1/86Il066HDt+rs66
	l8ypYq9Pt+HMra8SHWDvTQ0ZhRXsFTeZ3v9p3gVzOZQBwWJq9m0UXyGBHVakzATXgnP+fc/KBPZ
	ze81CYNC6b9B6w04cdkHBXdPK8ghs=
X-Google-Smtp-Source: AGHT+IG5XWW8EU/n+SElWifeRaCdIb3qSk59NKsERLQuygTEzy/niHcmWKkyQrfmM4an8zXoMDFRZQ==
X-Received: by 2002:a05:600c:6287:b0:477:a246:8398 with SMTP id 5b1f17b1804b1-47904acef7cmr136262085e9.2.1764339947844;
        Fri, 28 Nov 2025 06:25:47 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790adc6f7bsm162026015e9.2.2025.11.28.06.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 06:25:47 -0800 (PST)
Message-ID: <1136b408-7bf8-4cc8-98b6-e44c2ed45aaf@linaro.org>
Date: Fri, 28 Nov 2025 14:25:46 +0000
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
 <d808f86b-551c-4028-97c0-d468dac71d51@linaro.org>
 <CAP-5=fV7QOe7ThUDCFpqWkqLpuq4j_f1mA=zRE78bmwcyY_nXA@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fV7QOe7ThUDCFpqWkqLpuq4j_f1mA=zRE78bmwcyY_nXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 28/11/2025 9:00 am, Ian Rogers wrote:
> On Thu, Nov 27, 2025 at 5:48 AM James Clark <james.clark@linaro.org> wrote:
>>
>>
>>
>> On 27/11/2025 1:19 pm, Ian Rogers wrote:
>>> On Thu, Nov 27, 2025 at 4:16 AM James Clark <james.clark@linaro.org> wrote:
>>>>
>>>>
>>>>
>>>> On 27/11/2025 11:43 am, Ian Rogers wrote:
>>>>> On Wed, Nov 26, 2025 at 10:27 AM Namhyung Kim <namhyung@kernel.org> wrote:
>>>>>>
>>>>>> On Sat, Nov 22, 2025 at 01:39:34AM -0800, Ian Rogers wrote:
>>>>>>> Add an implementation of addr2line that uses libdw. Other addr2line
>>>>>>> implementations or, in the case of forking addr2line, slow. Add an
>>>>>>> implementation that caches the libdw information in the dso and uses
>>>>>>> it to find the file and line number information.
>>>>>
>>>>> Thanks James and Namhyung for the reviews! I agree with James' comment
>>>>> about a typo in the commit message.
>>>>>
>>>>>> My concern is the limit in the open file descriptors in case the data
>>>>>> touched a lot of different libraries.  The DSO code has some logic to
>>>>>> deal with it but I'm not sure if we can share that since libdw seems to
>>>>>> want to own the FD.
>>>>>
>>>>> The code opens the FD:
>>>>>
>>>>> +               fd = open(dso_name, O_RDONLY);
>>>>> +               if (fd < 0)
>>>>> +                       return 0;
>>>>> +
>>>>> +               dwfl = dwfl_begin(&offline_callbacks);
>>>>> +               if (!dwfl) {
>>>>> +                       close(fd);
>>>>> +                       return 0;
>>>>> +               }
>>>>>
>>>>> It then uses the FD and closes it (the close is hidden in libdw itself):
>>>>>
>>>>> +               /*
>>>>> +                * If the report is successful, the file descriptor fd
>>>>> is consumed
>>>>> +                * and closed by the Dwfl. If not, it is not closed.
>>>>> +                */
>>>>> +               mod = dwfl_report_offline(dwfl, dso_name, dso_name, fd);
>>>>>
>>>>> So it is possible we exhaust all the file descriptors if there are
>>>>> multiple concurrent calls to libdw__addr2line and every dso has
>>>>> missing libdw dwfl data... but because the open/close are close
>>>>> together and that 1 FD is say small to the FDs needed for the
>>>>> cmd__addr2line, I don't think it is a problem we need to specifically
>>>>> handle. Were the FD kept open until the dso was deleted, I'd agree
>>>>> with you.
>>>>>
>>>>>> Also, have you checked if this generates the exactly same output with
>>>>>> other implementations?
>>>>>
>>>>> So the code passes `perf test` and I was checking functionality with
>>>>> perf annotate, top, etc. What I saw looked good, but it may not have
>>>>> been exhaustive. I didn't specifically create a test that compares the
>>>>> output of the different addr2line implementations. Such a test would
>>>>> be possible, it's not something we've done elsewhere.
>>>>>
>>>>> Thanks,
>>>>> Ian
>>>>>
>>>>
>>>> I manually looked at a couple of line numbers and they looked
>>>> reasonable. I think an automated test that compared dwarf decoders would
>>>> be a bit of a nightmare because I'm sure there would always be subtle
>>>> differences.
>>>>
>>>> Doing a manual side by side comparison of libdw__addr2line() and
>>>> llvm__addr2line(), they seem to be quite different:
>>>>
>>>>      $ perf record -- perf test -w leafloop
>>>>      $ perf script -F ip,srcline > libdw_addr2line.txt
>>>>      # Comment out libdw_addr2line() and rebuild
>>>>      $ perf script -F ip,srcline > llvm_addr2line.txt
>>>>      $ diff libdw_addr2line.txt llvm_addr2line.txt
>>>>
>>>> It gets all of the simple leafloop workload lines the same, but lots of
>>>> the libc stuff is different.
>>>>
>>>> For example libdw gives cpu-features.c:350 where llvm gives strcmp.S. At
>>>> least that one looks like inlining so llvm might be "better", but where
>>>> it gives dl-cache.c:490 isntead of llvm's mmap64.c:47, it's hard to see
>>>> how that can be inlining if they're in different compilation units.
>>>>
>>>> If the llvm addr2line implementation is also supposed to be slow, it
>>>> just means we're trading speed with accuracy with this change. Hard to
>>>> say what the default should be in that case.
>>>
>>> Agreed. We could do some kind of option scheme like with the disassemblers:
>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/disasm.c?h=perf-tools-next#n1715
>>>
>>> I'm not sure there are currently any distributions using the LLVM
>>> options, this in part motivates:
>>> https://lore.kernel.org/lkml/20251007163835.3152881-1-irogers@google.com/
>>> but the addr2line APIs are a pain there - see the extra generated .so.
>>> Because of that it could be reasonable to delete the LLVM addr2line
>>> code and just focus on libdw. I kind of wish we could also delete the
>>> precarious command forking versions too. And libbfd... Perhaps with
>>> this code, those advocating libbfd have a fast enough alternative
>>> without bringing in large dependencies like libLLVM.
>>>
>>> Thanks,
>>> Ian
>>>
>>
>> Personally for debugging I would want the most accurate and detailed
>> information possible and don't care at all about the size of
>> dependencies. If Perf is a tool for debugging then surely that should be
>> the default? But right now I don't actually know which of the outputs is
>> most accurate although I'll assume that the llvm one is.
> 
> I know LLVM got dwarf 5 support early. I'm not sure if accurate is the
> best word to compare libdw and LLVM as, if libdw supports the format,
> discrepancies are bugs in LLVM or libdw, .. Building around LLVM as a
> common base sgtm and my main use-case doesn't get impeded by the large
> dependency because of the dlopen patches. As libelf/libdw is pretty
> much a given for a perf build, as it is required for libbpf, then the
> code here can avoid the fork/exec fallback. I can see the sense in
> trying with LLVM first and then falling back to libdw.
> 

Seems like my libc does have dwarf 5 symbols. Looking a bit more I still 
think "accurate" is the right word. Comparing gdb, forked addr2line and 
llvm_addr2line(), all 3 agree on the source line for every address in my 
recording. The only one that disagrees is libdw_addr2line(). I don't 
know if there's an issue with how it's being called, or there is a bug 
in the library.

Digging even deeper, if I put breakpoints on the lines that 
libdw_addr2line() gives, they aren't even hit. So it's not even like 
it's not de-inlining stuff, which you could argue is fine. And there is 
the issue that some of the results are in completely different C files. 
It's hard to see why it's giving such different results without 
debugging libdw line by line.

I'm not sure if you see the same thing with a simple recording or you 
want me to send a perf archive?

>> Wanting the smallest application possible while trading away detail and
>> accuracy seems like an unusual special case that should be opt in. It
>> also seems to relate to this old discussion [1], in that if we're going
>> to keep the llvm depencency then it doesn't make sense to re-write
>> anything in Perf.
> 
> So I think PE support in libdw wouldn't be a priority and so LLVM for
> the win there. I think distributions have been slow to pick up the
> LLVM dependency, I'm not sure what the issue is there. It would be
> nice to start removing some of the alternatives the perf build
> supports. The libbfd and libunwind code is only built with specific
> opt-ins, and I think the fork/exec addr2line is redundant after this
> change. For addr2line that'd bring the 2 implementations down to libdw

It might be a bit premature to drop the addr2line fork if libdw isn't 
mature enough. Especially as it seems to fall over on such a basic test. 
Hopefully it's just an issue with how it's called or the version that I 
have.

> and LLVM. As the recent libbfd fixes show [1], inadvertently we can
> break these largely untested dependencies by exposing latent bugs in
> things like improper initialization.
> 
> Thanks,
> Ian
> 
> [1] https://lore.kernel.org/lkml/20251112074311.1440101-1-irogers@google.com/
> 
>> [1]:
>> https://lore.kernel.org/linux-perf-users/549d3812-a606-4981-83f5-0a99b0ff9f6a@linaro.org/
>>
>>>>>> Thanks,
>>>>>> Namhyung
>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>>>>>> ---
>>>>>>>     tools/perf/util/Build     |   1 +
>>>>>>>     tools/perf/util/dso.c     |   2 +
>>>>>>>     tools/perf/util/dso.h     |  11 +++
>>>>>>>     tools/perf/util/libdw.c   | 136 ++++++++++++++++++++++++++++++++++++++
>>>>>>>     tools/perf/util/libdw.h   |  60 +++++++++++++++++
>>>>>>>     tools/perf/util/srcline.c |   5 ++
>>>>>>>     6 files changed, 215 insertions(+)
>>>>>>>     create mode 100644 tools/perf/util/libdw.c
>>>>>>>     create mode 100644 tools/perf/util/libdw.h
>>>>>>>
>>>>>>> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
>>>>>>> index 1c2a43e1dc68..2bed6274e248 100644
>>>>>>> --- a/tools/perf/util/Build
>>>>>>> +++ b/tools/perf/util/Build
>>>>>>> @@ -224,6 +224,7 @@ perf-util-$(CONFIG_LIBDW) += dwarf-regs-powerpc.o
>>>>>>>     perf-util-$(CONFIG_LIBDW) += dwarf-regs-x86.o
>>>>>>>     perf-util-$(CONFIG_LIBDW) += debuginfo.o
>>>>>>>     perf-util-$(CONFIG_LIBDW) += annotate-data.o
>>>>>>> +perf-util-$(CONFIG_LIBDW) += libdw.o
>>>>>>>
>>>>>>>     perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
>>>>>>>     perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind-local.o
>>>>>>> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
>>>>>>> index 344e689567ee..06980844c014 100644
>>>>>>> --- a/tools/perf/util/dso.c
>>>>>>> +++ b/tools/perf/util/dso.c
>>>>>>> @@ -32,6 +32,7 @@
>>>>>>>     #include "string2.h"
>>>>>>>     #include "vdso.h"
>>>>>>>     #include "annotate-data.h"
>>>>>>> +#include "libdw.h"
>>>>>>>
>>>>>>>     static const char * const debuglink_paths[] = {
>>>>>>>          "%.0s%s",
>>>>>>> @@ -1605,6 +1606,7 @@ void dso__delete(struct dso *dso)
>>>>>>>          auxtrace_cache__free(RC_CHK_ACCESS(dso)->auxtrace_cache);
>>>>>>>          dso_cache__free(dso);
>>>>>>>          dso__free_a2l(dso);
>>>>>>> +     dso__free_a2l_libdw(dso);
>>>>>>>          dso__free_symsrc_filename(dso);
>>>>>>>          nsinfo__zput(RC_CHK_ACCESS(dso)->nsinfo);
>>>>>>>          mutex_destroy(dso__lock(dso));
>>>>>>> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
>>>>>>> index f8ccb9816b89..4aee23775054 100644
>>>>>>> --- a/tools/perf/util/dso.h
>>>>>>> +++ b/tools/perf/util/dso.h
>>>>>>> @@ -268,6 +268,7 @@ DECLARE_RC_STRUCT(dso) {
>>>>>>>          const char       *short_name;
>>>>>>>          const char       *long_name;
>>>>>>>          void             *a2l;
>>>>>>> +     void             *a2l_libdw;
>>>>>>>          char             *symsrc_filename;
>>>>>>>     #if defined(__powerpc__)
>>>>>>>          void            *dwfl;                  /* DWARF debug info */
>>>>>>> @@ -334,6 +335,16 @@ static inline void dso__set_a2l(struct dso *dso, void *val)
>>>>>>>          RC_CHK_ACCESS(dso)->a2l = val;
>>>>>>>     }
>>>>>>>
>>>>>>> +static inline void *dso__a2l_libdw(const struct dso *dso)
>>>>>>> +{
>>>>>>> +     return RC_CHK_ACCESS(dso)->a2l_libdw;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static inline void dso__set_a2l_libdw(struct dso *dso, void *val)
>>>>>>> +{
>>>>>>> +     RC_CHK_ACCESS(dso)->a2l_libdw = val;
>>>>>>> +}
>>>>>>> +
>>>>>>>     static inline unsigned int dso__a2l_fails(const struct dso *dso)
>>>>>>>     {
>>>>>>>          return RC_CHK_ACCESS(dso)->a2l_fails;
>>>>>>> diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..c4331fa8e1a3
>>>>>>> --- /dev/null
>>>>>>> +++ b/tools/perf/util/libdw.c
>>>>>>> @@ -0,0 +1,136 @@
>>>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>>>> +#include "dso.h"
>>>>>>> +#include "libdw.h"
>>>>>>> +#include "srcline.h"
>>>>>>> +#include "symbol.h"
>>>>>>> +#include "dwarf-aux.h"
>>>>>>> +#include <fcntl.h>
>>>>>>> +#include <unistd.h>
>>>>>>> +#include <elfutils/libdwfl.h>
>>>>>>> +
>>>>>>> +void dso__free_a2l_libdw(struct dso *dso)
>>>>>>> +{
>>>>>>> +     Dwfl *dwfl = dso__a2l_libdw(dso);
>>>>>>> +
>>>>>>> +     if (dwfl) {
>>>>>>> +             dwfl_end(dwfl);
>>>>>>> +             dso__set_a2l_libdw(dso, NULL);
>>>>>>> +     }
>>>>>>> +}
>>>>>>> +
>>>>>>> +int libdw__addr2line(const char *dso_name, u64 addr,
>>>>>>> +                  char **file, unsigned int *line_nr,
>>>>>>> +                  struct dso *dso, bool unwind_inlines,
>>>>>>> +                  struct inline_node *node, struct symbol *sym)
>>>>>>> +{
>>>>>>> +     static const Dwfl_Callbacks offline_callbacks = {
>>>>>>> +             .find_debuginfo = dwfl_standard_find_debuginfo,
>>>>>>> +             .section_address = dwfl_offline_section_address,
>>>>>>> +             .find_elf = dwfl_build_id_find_elf,
>>>>>>> +     };
>>>>>>> +     Dwfl *dwfl = dso__a2l_libdw(dso);
>>>>>>> +     Dwfl_Module *mod;
>>>>>>> +     Dwfl_Line *dwline;
>>>>>>> +     Dwarf_Addr bias;
>>>>>>> +     const char *src;
>>>>>>> +     int lineno;
>>>>>>> +
>>>>>>> +     if (!dwfl) {
>>>>>>> +             /*
>>>>>>> +              * Initialize Dwfl session.
>>>>>>> +              * We need to open the DSO file to report it to libdw.
>>>>>>> +              */
>>>>>>> +             int fd;
>>>>>>> +
>>>>>>> +             fd = open(dso_name, O_RDONLY);
>>>>>>> +             if (fd < 0)
>>>>>>> +                     return 0;
>>>>>>> +
>>>>>>> +             dwfl = dwfl_begin(&offline_callbacks);
>>>>>>> +             if (!dwfl) {
>>>>>>> +                     close(fd);
>>>>>>> +                     return 0;
>>>>>>> +             }
>>>>>>> +
>>>>>>> +             /*
>>>>>>> +              * If the report is successful, the file descriptor fd is consumed
>>>>>>> +              * and closed by the Dwfl. If not, it is not closed.
>>>>>>> +              */
>>>>>>> +             mod = dwfl_report_offline(dwfl, dso_name, dso_name, fd);
>>>>>>> +             if (!mod) {
>>>>>>> +                     dwfl_end(dwfl);
>>>>>>> +                     close(fd);
>>>>>>> +                     return 0;
>>>>>>> +             }
>>>>>>> +
>>>>>>> +             dwfl_report_end(dwfl, /*removed=*/NULL, /*arg=*/NULL);
>>>>>>> +             dso__set_a2l_libdw(dso, dwfl);
>>>>>>> +     } else {
>>>>>>> +             /* Dwfl session already initialized, get module for address. */
>>>>>>> +             mod = dwfl_addrmodule(dwfl, addr);
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     if (!mod)
>>>>>>> +             return 0;
>>>>>>> +
>>>>>>> +     /* Find source line information for the address. */
>>>>>>> +     dwline = dwfl_module_getsrc(mod, addr);
>>>>>>> +     if (!dwline)
>>>>>>> +             return 0;
>>>>>>> +
>>>>>>> +     /* Get line information. */
>>>>>>> +     src = dwfl_lineinfo(dwline, &addr, &lineno, /*col=*/NULL, /*mtime=*/NULL, /*length=*/NULL);
>>>>>>> +
>>>>>>> +     if (file)
>>>>>>> +             *file = src ? strdup(src) : NULL;
>>>>>>> +     if (line_nr)
>>>>>>> +             *line_nr = lineno;
>>>>>>> +
>>>>>>> +     /* Optionally unwind inline function call chain. */
>>>>>>> +     if (unwind_inlines && node && src) {
>>>>>>> +             Dwarf_Die *cudie = dwfl_module_addrdie(mod, addr, &bias);
>>>>>>> +             Dwarf_Die *scopes = NULL;
>>>>>>> +             int nscopes;
>>>>>>> +
>>>>>>> +             if (!cudie)
>>>>>>> +                     return 1;
>>>>>>> +
>>>>>>> +             nscopes = die_get_scopes(cudie, addr, &scopes);
>>>>>>> +             if (nscopes > 0) {
>>>>>>> +                     int i;
>>>>>>> +                     const char *call_file = src;
>>>>>>> +                     unsigned int call_line = lineno;
>>>>>>> +
>>>>>>> +                     for (i = 0; i < nscopes; i++) {
>>>>>>> +                             Dwarf_Die *die = &scopes[i];
>>>>>>> +                             struct symbol *inline_sym;
>>>>>>> +                             char *srcline = NULL;
>>>>>>> +                             int tag = dwarf_tag(die);
>>>>>>> +
>>>>>>> +                             /* We are interested in inlined subroutines. */
>>>>>>> +                             if (tag != DW_TAG_inlined_subroutine &&
>>>>>>> +                                 tag != DW_TAG_subprogram)
>>>>>>> +                                     continue;
>>>>>>> +
>>>>>>> +                             inline_sym = new_inline_sym(dso, sym, dwarf_diename(die));
>>>>>>> +
>>>>>>> +                             if (call_file)
>>>>>>> +                                     srcline = srcline_from_fileline(call_file, call_line);
>>>>>>> +
>>>>>>> +                             inline_list__append(inline_sym, srcline, node);
>>>>>>> +
>>>>>>> +                             /* Update call site for next level. */
>>>>>>> +                             if (tag == DW_TAG_inlined_subroutine) {
>>>>>>> +                                     call_file = die_get_call_file(die);
>>>>>>> +                                     call_line = die_get_call_lineno(die);
>>>>>>> +                             } else {
>>>>>>> +                                     /* Reached the root subprogram. */
>>>>>>> +                                     break;
>>>>>>> +                             }
>>>>>>> +                     }
>>>>>>> +                     free(scopes);
>>>>>>> +             }
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     return 1;
>>>>>>> +}
>>>>>>> diff --git a/tools/perf/util/libdw.h b/tools/perf/util/libdw.h
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..0f8d7b4a11a5
>>>>>>> --- /dev/null
>>>>>>> +++ b/tools/perf/util/libdw.h
>>>>>>> @@ -0,0 +1,60 @@
>>>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>>>>> +#ifndef PERF_LIBDW_H
>>>>>>> +#define PERF_LIBDW_H
>>>>>>> +
>>>>>>> +#include <linux/types.h>
>>>>>>> +
>>>>>>> +struct dso;
>>>>>>> +struct inline_node;
>>>>>>> +struct symbol;
>>>>>>> +
>>>>>>> +#ifdef HAVE_LIBDW_SUPPORT
>>>>>>> +/*
>>>>>>> + * libdw__addr2line - Convert address to source location using libdw
>>>>>>> + * @dso_name: Name of the DSO
>>>>>>> + * @addr: Address to resolve
>>>>>>> + * @file: Pointer to return filename (caller must free)
>>>>>>> + * @line_nr: Pointer to return line number
>>>>>>> + * @dso: The dso struct
>>>>>>> + * @unwind_inlines: Whether to unwind inline function calls
>>>>>>> + * @node: Inline node list to append to
>>>>>>> + * @sym: The symbol associated with the address
>>>>>>> + *
>>>>>>> + * This function initializes a Dwfl context for the DSO if not already present,
>>>>>>> + * finds the source line information for the given address, and optionally
>>>>>>> + * resolves inline function call chains.
>>>>>>> + *
>>>>>>> + * Returns 1 on success (found), 0 on failure (not found).
>>>>>>> + */
>>>>>>> +int libdw__addr2line(const char *dso_name, u64 addr, char **file,
>>>>>>> +                  unsigned int *line_nr, struct dso *dso,
>>>>>>> +                  bool unwind_inlines, struct inline_node *node,
>>>>>>> +                  struct symbol *sym);
>>>>>>> +
>>>>>>> +/*
>>>>>>> + * dso__free_a2l_libdw - Free libdw resources associated with the DSO
>>>>>>> + * @dso: The dso to free resources for
>>>>>>> + *
>>>>>>> + * This function cleans up the Dwfl context used for addr2line lookups.
>>>>>>> + */
>>>>>>> +void dso__free_a2l_libdw(struct dso *dso);
>>>>>>> +
>>>>>>> +#else /* HAVE_LIBDW_SUPPORT */
>>>>>>> +
>>>>>>> +static inline int libdw__addr2line(const char *dso_name __maybe_unused,
>>>>>>> +                                u64 addr __maybe_unused, char **file __maybe_unused,
>>>>>>> +                                unsigned int *line_nr __maybe_unused,
>>>>>>> +                                struct dso *dso __maybe_unused,
>>>>>>> +                                bool unwind_inlines __maybe_unused,
>>>>>>> +                                struct inline_node *node __maybe_unused,
>>>>>>> +                                struct symbol *sym __maybe_unused)
>>>>>>> +{
>>>>>>> +     return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static inline void dso__free_a2l_libdw(struct dso *dso __maybe_unused)
>>>>>>> +{
>>>>>>> +}
>>>>>>> +#endif /* HAVE_LIBDW_SUPPORT */
>>>>>>> +
>>>>>>> +#endif /* PERF_LIBDW_H */
>>>>>>> diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
>>>>>>> index 27c0966611ab..4b456c4d4138 100644
>>>>>>> --- a/tools/perf/util/srcline.c
>>>>>>> +++ b/tools/perf/util/srcline.c
>>>>>>> @@ -6,6 +6,7 @@
>>>>>>>     #include "libbfd.h"
>>>>>>>     #include "llvm.h"
>>>>>>>     #include "symbol.h"
>>>>>>> +#include "libdw.h"
>>>>>>>
>>>>>>>     #include <inttypes.h>
>>>>>>>     #include <string.h>
>>>>>>> @@ -120,6 +121,10 @@ static int addr2line(const char *dso_name, u64 addr, char **file, unsigned int *
>>>>>>>     {
>>>>>>>          int ret;
>>>>>>>
>>>>>>> +     ret = libdw__addr2line(dso_name, addr, file, line_nr, dso, unwind_inlines, node, sym);
>>>>>>> +     if (ret > 0)
>>>>>>> +             return ret;
>>>>>>> +
>>>>>>>          ret = llvm__addr2line(dso_name, addr, file, line_nr, dso, unwind_inlines, node, sym);
>>>>>>>          if (ret > 0)
>>>>>>>                  return ret;
>>>>>>> --
>>>>>>> 2.52.0.rc2.455.g230fcf2819-goog
>>>>>>>
>>>>
>>

