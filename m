Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9C2340A48
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Oct 2025 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665211; cv=none; b=BQTFsivEBL0cMvAZaJqpu62Gjs8Jc95kAMPnK2QNv8hpWluBQvUl44k4tHLu6LFQnvY1e1B0KQrQx2yvsRiUj141MQn0OWJToNfZPyi91Ccps8jKYpRA6B+lkGnfrxEkouaUjmrglWdr5SEpne2wN9dzViV0G4HCg5tqFGmiDo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665211; c=relaxed/simple;
	bh=J8gWe5S/wU/Aw3JtTddPawUYb2A11E91lY5KPNIjULE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+at9ILo7jebWrxMlteV3xpT5CS5ILBi/cHDIl6IFavr5u+L8JY0dNgBcu6F+CLDx/6CqQ4YZCSJ6kpPbfTuLGi7OHxnpYhWteivaJPsB1alPosgbvFuIAq09TrFLoWx2W7eogo1fjuM9ZSeCbZ44wTpAmGEb/EzIHmu/gGEfOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wgzzf499; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wgzzf499"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso6168470f8f.2
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Oct 2025 08:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761665207; x=1762270007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L5NN874Vbf6j1t9kDklEAtFLWXAQFaa3F0AHLiRU/ns=;
        b=wgzzf49981lb2sPpB7bztN7xkYR0c2cKBvb6NlHuj+c+PijJ4xHS9UUsU12icVC50w
         aUX5calUvKp0gBYfuCM7ODVFWNNIeiisBEsFlrFuIi61yfcYlvBPXFllF+km7rdXcS24
         AGukgPQ8u6ywykFPtGEsbdtmeHM0J71yvUh1O8CWoaYmCIkkhp1PQ7K/0RCjmU7UQYUC
         P2GYbUkguTzUsBuaRgNmMr98R3byzXlOIH0poao7me3I/W+ME28f3iV7vbpztzGPV4Gm
         MVcTJ9n8+B1t3nAVpSfCsTzRL2e2ZFU6QB2UenZ4HD6VzdG/QIR+y+70/wt1KbMufi6d
         TG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761665207; x=1762270007;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L5NN874Vbf6j1t9kDklEAtFLWXAQFaa3F0AHLiRU/ns=;
        b=awwqJBxf2K8DvGjLGA4l9EIDvOzTxWm3zJ2Sao7vvV+rQEpxcEbvVxYR7WoqRbx0TM
         Jcpaiog2XWUTpuAyyLmTjF/x4ZBNLepeD6G4ik5a0CIp03u+KBsxVCuPbxyryPiyzFNU
         juljKgsqOkgP0EcgCdZKu38krp6UFJVFQ1qoyfRg00nw2rTj+ZLBU1MHdJueNqK33R/T
         PWyCjqxWI3R9liX07G5CbedY4j2iVrkx+2/AZQy1PctnhjsUE1PYL/E4QmCpiJb17m+b
         KcY0lPadxZLqAaIEjURIOT/yieLE/9oiTNaf0qO3nJyiDk/HjxrvJ7u0g+5CSCvQR0sE
         BUEA==
X-Forwarded-Encrypted: i=1; AJvYcCWMsPlNORW7lf/qQ0I8XQ2M2d0tLdDkudpZTNZZb2J3ciqAKXikWvUiKkvaQogtmAtpYlVzYtVxiNILldZHODlf@vger.kernel.org
X-Gm-Message-State: AOJu0YzidV1Sw/M41i75VUV4SQhkXI4v/pXtj5OxKegYMxKVNoPKF/hF
	B9TOUklwQ+ihUhdPygOeJoQlK8m7KSL2yQy2F21jxoWQkhEusABFbHC7DuzTXC+cgeo=
X-Gm-Gg: ASbGncsIQvoBo9PfNyKNMnI49ucaSytViJrcYZ24Xt9MiEn2DsqHeONF4gQ8FhOEYKz
	cPAIymNqfi0LwJDAGzpnATVSh30uchCK5N3y14csZpqY+JgneuIRceTYSvPwt4zgigvnmtyWA6M
	7+eMw+5AhZzL5p+vkEtahUM3DhVBKJo8pWEKRqAIpabCP7UQLJwn3zAZHCA+XTc0JIaZkGtvYYR
	3ExWzRm2+k32/1yL1nJFBiNNb4KEvOONcbHl3sYF5MYtRgsoMxFcyG+9AWQ+3epgdU41rg3WEyB
	fYpg/naPHX2lGkX2dO2ksNmefW1hx8eDI8hPl3LHldHmqJufxXHvvPUXAAicbqmrICbtjxr4IrQ
	ozF1LpBZfC0OxA4XV0LWnhFiB/I5IJMZL67ChpFtuA9lhco29J2z4Au559qb7EacKBk3kC5ZmBV
	gKn0K5PA==
X-Google-Smtp-Source: AGHT+IFht8W8LlHf+fVb5sQbyInnI36G4HSXQo3iShQ7ls0EqY4pU5HsL5gFy2X7AKE+Q9Dl1X05Xg==
X-Received: by 2002:a05:6000:61e:b0:427:546:4378 with SMTP id ffacd0b85a97d-429a7e4eeeamr4138749f8f.20.1761665207072;
        Tue, 28 Oct 2025 08:26:47 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7b2dsm20547898f8f.2.2025.10.28.08.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 08:26:46 -0700 (PDT)
Message-ID: <643e2956-2ddb-45a8-9c8f-c77a73bac4d2@linaro.org>
Date: Tue, 28 Oct 2025 15:26:45 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf dsos: Don't block when reading build IDs
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251022-james-perf-fix-dso-block-v1-1-c4faab150546@linaro.org>
 <CAP-5=fUF8C=yFkPb_ohJVzX01PvS5n++yZZifWSV-4sMNKZAZA@mail.gmail.com>
 <aP1kSdZJKYIpnRia@google.com>
 <CAP-5=fUiO1uypnsw=G-FFj0xE=uCowG5FetaC9JGygOxybuGGA@mail.gmail.com>
 <17f00d4d-5cbf-4c9c-a51a-f0ae34f181cf@linaro.org>
 <CAP-5=fV-g1CeJCoEnNnz_eFsks01JyUR3Fxz_H0X_rdTzOGuAw@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fV-g1CeJCoEnNnz_eFsks01JyUR3Fxz_H0X_rdTzOGuAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 28/10/2025 3:07 pm, Ian Rogers wrote:
> On Tue, Oct 28, 2025 at 3:33 AM James Clark <james.clark@linaro.org> wrote:
>>
>> On 26/10/2025 4:52 am, Ian Rogers wrote:
>>> On Sat, Oct 25, 2025 at 4:59 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>>>
>>>> Hello,
>>>>
>>>> On Fri, Oct 24, 2025 at 11:26:18AM -0700, Ian Rogers wrote:
>>>>> On Wed, Oct 22, 2025 at 8:46 AM James Clark <james.clark@linaro.org> wrote:
>>>>>>
>>>>>> The following command will hang consistently when the GPU is being used
>>>>>> due to non regular files (e.g. /dev/dri/renderD129, /dev/dri/card2)
>>>>>> being opened to read build IDs:
>>>>>>
>>>>>>    $ perf record -asdg -e cpu-clock -- true
>>>>>>
>>>>>> Change to non blocking reads to avoid the hang here:
>>>>>>
>>>>>>     #0  __libc_pread64 (offset=<optimised out>, count=0, buf=0x7fffffffa4a0, fd=237) at ../sysdeps/unix/sysv/linux/pread64.c:25
>>>>>>     #1  __libc_pread64 (fd=237, buf=0x7fffffffa4a0, count=0, offset=0) at ../sysdeps/unix/sysv/linux/pread64.c:23
>>>>>>     #2  ?? () from /lib/x86_64-linux-gnu/libelf.so.1
>>>>>>     #3  read_build_id (filename=0x5555562df333 "/dev/dri/card2", bid=0x7fffffffb680, block=true) at util/symbol-elf.c:880
>>>>>>     #4  filename__read_build_id (filename=0x5555562df333 "/dev/dri/card2", bid=0x7fffffffb680, block=true) at util/symbol-elf.c:924
>>>>>>     #5  dsos__read_build_ids_cb (dso=0x5555562df1d0, data=0x7fffffffb750) at util/dsos.c:84
>>>>>>     #6  __dsos__for_each_dso (dsos=0x55555623de68, cb=0x5555557e7030 <dsos__read_build_ids_cb>, data=0x7fffffffb750) at util/dsos.c:59
>>>>>>     #7  dsos__for_each_dso (dsos=0x55555623de68, cb=0x5555557e7030 <dsos__read_build_ids_cb>, data=0x7fffffffb750) at util/dsos.c:503
>>>>>>     #8  dsos__read_build_ids (dsos=0x55555623de68, with_hits=true) at util/dsos.c:107
>>>>>>     #9  machine__read_build_ids (machine=0x55555623da58, with_hits=true) at util/build-id.c:950
>>>>>>     #10 perf_session__read_build_ids (session=0x55555623d840, with_hits=true) at util/build-id.c:956
>>>>>>     #11 write_build_id (ff=0x7fffffffb958, evlist=0x5555562323d0) at util/header.c:327
>>>>>>     #12 do_write_feat (ff=0x7fffffffb958, type=2, p=0x7fffffffb950, evlist=0x5555562323d0, fc=0x0) at util/header.c:3588
>>>>>>     #13 perf_header__adds_write (header=0x55555623d840, evlist=0x5555562323d0, fd=3, fc=0x0) at util/header.c:3632
>>>>>>     #14 perf_session__do_write_header (session=0x55555623d840, evlist=0x5555562323d0, fd=3, at_exit=true, fc=0x0, write_attrs_after_data=false) at util/header.c:3756
>>>>>>     #15 perf_session__write_header (session=0x55555623d840, evlist=0x5555562323d0, fd=3, at_exit=true) at util/header.c:3796
>>>>>>     #16 record__finish_output (rec=0x5555561838d8 <record>) at builtin-record.c:1899
>>>>>>     #17 __cmd_record (rec=0x5555561838d8 <record>, argc=2, argv=0x7fffffffe320) at builtin-record.c:2967
>>>>>>     #18 cmd_record (argc=2, argv=0x7fffffffe320) at builtin-record.c:4453
>>>>>>     #19 run_builtin (p=0x55555618cbb0 <commands+288>, argc=9, argv=0x7fffffffe320) at perf.c:349
>>>>>>     #20 handle_internal_command (argc=9, argv=0x7fffffffe320) at perf.c:401
>>>>>>     #21 run_argv (argcp=0x7fffffffe16c, argv=0x7fffffffe160) at perf.c:445
>>>>>>     #22 main (argc=9, argv=0x7fffffffe320) at perf.c:553
>>>>>>
>>>>>> Fixes: 53b00ff358dc ("perf record: Make --buildid-mmap the default")
>>>>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>>>>> ---
>>>>>> I'm not actually sure if this is the right fix for this. Commit
>>>>>> 2c369d91d093 ("perf symbol: Add blocking argument to
>>>>>> filename__read_build_id") which added the blocking argument says that it
>>>>>> should be non-blocking reads for event synthesis, but the callstack here
>>>>>> is when writing the header out.
>>>>>>
>>>>>> There was also an is_regular_file() check added in commit c21986d33d6b
>>>>>> ("perf unwind-libdw: skip non-regular files"), which presumably falls
>>>>>> afoul of the "which unfortunately fails for symlinks" part of the other
>>>>>> linked commit message?
>>>>>>
>>>>>> So I can't tell if we should add the is_regular_file() check here too,
>>>>>> or just set it to non-blocking, or it needs some extra state to be
>>>>>> passed all the way down to dsos__read_build_ids_cb() to do different
>>>>>> things.
>>>>>
>>>>> The fix lgtm but I worry about making all the build ID reading
>>>>> non-blocking meaning build IDs getting lost.
>>>>
>>>> I'm not sure what non-blocking means for regular file system operations
>>>> on a block device.  But it may have some impact on regular files on a
>>>> network filesystem.
>>
>> It depends on the filesystem, but I think the assurances given by
>> O_NONBLOCK are very weak anyway. It can be practically ignored or do
>> different things in different situations. Especially as we don't handle
>> EAGAIN or do anything fancy we shouldn't use it.
>>
>> For our case it looks like we should always do blocking reads but make
>> sure to not open a non-regular file.
>>
>>>
>>> Agreed. Prior to using blocking we tried to imply from the file type
>>> from stat, but that skipped things like symlinks :-/
>>>
>>
>> Am I missing something here? is_regular_file() uses stat() which returns
>> info about the target file, rather than the symlink, so they wouldn't be
>> skipped. lstat() is the one that returns info about the link file.
>>
>> I tested is_regular_file() with links, links to links, pipes, files and
>> devices and it works as expected and would avoid the need to use O_NONBLOCK.
> 
> I don't mind we back out the use of the is_block parameter and use
> is_regular_file. In the code before the change to use is_block the
> callers would call is_regular_file and then call
> filename__read_build_id. This seemed error prone as some callers were
> doing the is_regular_file check and others not. I think I favor just
> getting rid of the argument but putting the is_regular_file check in
> filename__read_build_id. I'd switched to using O_NONBLOCK rather than

That makes sense to me. Should I make that change in addition to 
Namhyung's patch?

> is_regular_file not just because of symlinks but just because it
> wasn't clear that anything non-regular may still have a build id.

That I'm not sure about either. Can we assume that no non-regular files 
have build IDs as we're not handling EAGAIN anyway? Or at least if they 
do it's not currently supported.

> 
> There's the separate issue of why are we writing out buildids in the
> features when the buildid-mmaps contain the same data. It seems
> Namhyung has a patch just about optimizing that case :-)
> 
> Thanks,
> Ian
> 
>> James
>>
>>>>> It seems that generating
>>>>> the build ID feature table is unnecessary if we have build ID mmap
>>>>> events, including synthesized ones that will have read the build IDs.
>>>>> I wonder if a better "fix" is:
>>>>> ```
>>>>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>>>>> index cb52aea9607d..15f75c70eb76 100644
>>>>> --- a/tools/perf/builtin-record.c
>>>>> +++ b/tools/perf/builtin-record.c
>>>>> @@ -1842,7 +1842,7 @@ static void record__init_features(struct record *rec)
>>>>>          for (feat = HEADER_FIRST_FEATURE; feat < HEADER_LAST_FEATURE; feat++)
>>>>>                  perf_header__set_feat(&session->header, feat);
>>>>>
>>>>> -       if (rec->no_buildid)
>>>>> +       if (rec->no_buildid || rec->buildid_mmap)
>>>>>                  perf_header__clear_feat(&session->header, HEADER_BUILD_ID);
>>>>>
>>>>>          if (!have_tracepoints(&rec->evlist->core.entries))
>>>>> ```
>>>>> that should disable the build ID feature table generation when build
>>>>> ID mmaps are in use (the default). Having the build IDs twice in the
>>>>> data file feels redundant. Or we could do your fix or both, wdyt?
>>>>
>>>> I'm ok to remove the header feature but I think it should update
>>>> build-ID cache even with this change.
>>>
>>> Yeah, dropping the feature writing also impacts updating the build ID
>>> cache because:
>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/header.c?h=perf-tools-next#n338
>>> It is kind of strange that writing a header feature does this. What if
>>> I want to write a header with build IDs but not update the cache? It'd
>>> make more sense, I think, for perf_session__cache_build_ids to be
>>> called explicitly. There is also the global no_buildid_cache
>>> controlling behavior:
>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/build-id.c?h=perf-tools-next#n43
>>> But that's kind of a hack as we may have >1 session such as with TPEBS.
>>>
>>>> I'm also curious if the device has samples actually.  It should be
>>>> checked by dso->hit.
>>>
>>> In this case the header writing is happening after the samples have
>>> been processed, but it looks like marking of samples doesn't consider
>>> data addresses:
>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/build-id.c?h=perf-tools-next#n55
>>> just sample->ip and the callchain. If the marking was updated for data
>>> pages then just writing build IDs for marked dsos would make sense.
>>> There could be callers not marking dsos so they'd need altering, or
>>> two versions of the code.
>>>
>>> Thanks,
>>> Ian
>>>
>>>> Thanks,
>>>> Namhyung
>>>>
>>>>>
>>>>> Thanks,
>>>>> Ian
>>>>>
>>>>>> ---
>>>>>>    tools/perf/util/dsos.c | 5 +++--
>>>>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
>>>>>> index 64c1d65b0149..5e1c815d7cb0 100644
>>>>>> --- a/tools/perf/util/dsos.c
>>>>>> +++ b/tools/perf/util/dsos.c
>>>>>> @@ -81,13 +81,14 @@ static int dsos__read_build_ids_cb(struct dso *dso, void *data)
>>>>>>                   return 0;
>>>>>>           }
>>>>>>           nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
>>>>>> -       if (filename__read_build_id(dso__long_name(dso), &bid, /*block=*/true) > 0) {
>>>>>> +       /* Don't block in case path isn't for a regular file. */
>>>>>> +       if (filename__read_build_id(dso__long_name(dso), &bid, /*block=*/false) > 0) {
>>>>>>                   dso__set_build_id(dso, &bid);
>>>>>>                   args->have_build_id = true;
>>>>>>           } else if (errno == ENOENT && dso__nsinfo(dso)) {
>>>>>>                   char *new_name = dso__filename_with_chroot(dso, dso__long_name(dso));
>>>>>>
>>>>>> -               if (new_name && filename__read_build_id(new_name, &bid, /*block=*/true) > 0) {
>>>>>> +               if (new_name && filename__read_build_id(new_name, &bid, /*block=*/false) > 0) {
>>>>>>                           dso__set_build_id(dso, &bid);
>>>>>>                           args->have_build_id = true;
>>>>>>                   }
>>>>>>
>>>>>> ---
>>>>>> base-commit: a1d8548c23076c66d96647f5f6f25aa43567f247
>>>>>> change-id: 20251022-james-perf-fix-dso-block-ca1d8437bbc0
>>>>>>
>>>>>> Best regards,
>>>>>> --
>>>>>> James Clark <james.clark@linaro.org>
>>>>>>
>>

