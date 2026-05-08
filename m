Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D782F8E99
	for <linux-perf-users@vger.kernel.org>; Fri,  8 May 2026 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778250589; cv=none; b=lf55v4XFpTQxPWRV7RTJd4Flrk0b/Q/V9yhI9hpyeoddWcmKPVOxt5Txa6Tv203u7DqNX/wl9GMtJiy1i50SkXFrCfo2rHQhU/tO6PvRo+hDWQfHH44jurjuUkcFz1SlxlV/269NVQ95GxqT5hfzX+Caj7fpqF5aWH8gsQe4pNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778250589; c=relaxed/simple;
	bh=fg8jXBHULv8qVF7RNm+GMHmjnIwBn8fdOQwqj8QGvrU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=f6MSqvfI8+Wvo2y/NM3xoB684N8PbpMyhxnwfnDJS84xGlxGanpJTMQi7Iv2Uyz7bDPNt4iQhyLMJKqF5zY3d6+pZYkx4ZlnIZQ+cbR9C17taY6o2YXz3AtQAIKH9OUrYWtWaK3gMvzoLEEF3xBMcEsFGIy4xuFWrvdI8y9Vcf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LDxcGETj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LDxcGETj"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso19816525e9.2
        for <linux-perf-users@vger.kernel.org>; Fri, 08 May 2026 07:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778250586; x=1778855386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SdYHfvOoNjnJsMzD6pUrVs57XryxqtQjd9HLlNoGnyk=;
        b=LDxcGETjJm2+SUFVP90Q12nJDmZHEMvl/0oElxD8+Ok6Or1UQh57UqLPBRup0UwHBw
         +7HSLswvfkEb5IF+xqD+h0d1uMXHIWMmUi8IFDPTddXpKBwyGl719GxQS0MGxj/lSDvV
         ql51yytR/HyRbTcsMAxkgn69Gudw+GMIaGkX8c6mKmIX7TvDZYjarV6bLPP4LZutxOVo
         qz9FDO9kNHEGHOsvtVhiYaatJ89YbXDwkMtt/xm4FcNqmx4wI4KFL6qSId15sRo6rzLE
         neW1nui+q31X9toFeQEicAlXRV/Op3JrbtujqFH9dBi2b36vVW8fZopOib6o5zrOK9Nd
         cr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778250586; x=1778855386;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SdYHfvOoNjnJsMzD6pUrVs57XryxqtQjd9HLlNoGnyk=;
        b=hOU0BSCsx0yZ9X+M1UciFtA1wimT8vmwzIEVw1wGqAf8Cljrzp/CXWxt1xm+qPF7zV
         QKPUNkJk9X1qhUYkdoUFEFcuXhcAV5qUqpNeDbTkTWuTXFO3uYG6i5oDmJBbKBvTsWae
         lACxW4cQ5Zc/bxzVubeFAVKUaSdBkJYZcU8owXwm9sTdJb4fEFLAl9cSARd51vo2hEHm
         KUs7EQk+ghkqDrUGYzfTArAg9TyuJe640AwlLw/Nv2if0JhIQsSLBvt/8y/WMLX8DMhj
         dZA5+9pzvbmi9b88N81KRmX80vseopyEUdagA/r/TL/OFVHbV9576m6PBqVTa/ZoaVc6
         Blsg==
X-Forwarded-Encrypted: i=1; AFNElJ+HumcXDsNOS3phqs75UA9PKjSyvw/aveUPCur8+Whgq7fWjIP/KXcWssjwZ0RKPciWBYU35B5sZCjwhNmWORR7@vger.kernel.org
X-Gm-Message-State: AOJu0YwSzZBCsUSA93MEC6ineUWYbMfUczcXvRg3T10HfMX8oQ6d4UGQ
	VCKwxZT9iTrmIWxwurdhu2VqRqLEgUni/+/4iMBqjEHpVDCLm5BKDZtIC5Px+MnL+tI=
X-Gm-Gg: AeBDiesfHHaofYwH+X0O+T+9n4wWTaHayUWbdCR3pZbmPmDowlj6hLkAjAusNE5Xj1Z
	K88TaOKNJWyrJ+/HGNNgFVt4iMXxsqHuXUBKiYTfL/EwOTCurxQjgdWDqRehuJdX9UJwFb0qI3j
	WzBWfA+AktPhnKe3srdxVvRUYvab3B2cFMw//ZDEs6m+02MhYgzbEYoI0kQPAnVnq6fG0ObVtF5
	0IhzEK/OX4TRVv/dvw3vlTx979hvJLTqle9ef9LPV0DJedaMQCbWJsiaiceDDyL83vh7D9/zmhl
	aUHUzwHRy4e2xOmRFg7klajq4raVWqxJN3epGN5PRN/qpnv3Q6DIRxfNTFJF8UuOPtLyQMdwcRi
	XRmyvQ/8L9mwyyUozDrNYw+JBKfzdazFsfTqKkGpIwssnJVIiCsIxBGhUrZHSTFv1UNB+mmxcPs
	mWnQq00eVNdUrJkJHa72990qF6xwbl
X-Received: by 2002:a05:600c:8b08:b0:488:a977:8de with SMTP id 5b1f17b1804b1-48e51f32757mr224058395e9.16.1778250586073;
        Fri, 08 May 2026 07:29:46 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e68edca90sm75474865e9.5.2026.05.08.07.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 07:29:45 -0700 (PDT)
Message-ID: <ab4fec52-d4a9-41d7-9422-9265f4113cbd@linaro.org>
Date: Fri, 8 May 2026 15:29:44 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] perf test: Add inject ASLR test
From: James Clark <james.clark@linaro.org>
To: Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
 acme@kernel.org, gmx@google.com, namhyung@kernel.org
References: <20260506004546.3140141-1-irogers@google.com>
 <20260508082726.2795191-1-irogers@google.com>
 <20260508082726.2795191-6-irogers@google.com>
 <dec2f42d-3c2a-424e-9d50-e52ebbee3d69@linaro.org>
Content-Language: en-US
In-Reply-To: <dec2f42d-3c2a-424e-9d50-e52ebbee3d69@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 08/05/2026 2:29 pm, James Clark wrote:
> 
> 
> On 08/05/2026 9:27 am, Ian Rogers wrote:
>> Add a new shell test `inject_aslr.sh` to verify the `perf inject --aslr`
>> feature. The test covers:
>> - Basic address remapping for user space samples.
>> - Pipe mode coverage for `perf record` piped into `perf inject --aslr`.
>> - Callchain address remapping.
>> - Consistency of `perf report` output before and after injection.
>> - Pipe mode report consistency.
>> - Dropping of samples that leak ASLR info (physical addresses).
>> - Kernel address remapping (utilizing a dedicated kernel-intensive VFS 
>> dd workload
>>    to guarantee continuous timer interrupts sampling flow inside 
>> kernel privilege states).
>> - Kernel report consistency with address normalization.
>>
>> The test suite is hardened with global 'set -o pipefail' assertions to 
>> catch
>> pipeline failures, stream-consuming awk processors to handle SIGPIPE 
>> signals,
>> and a dedicated pipe output scenario validating raw 'perf inject -o -' 
>> stdout
>> streams.
>>
>> Assisted-by: Gemini-CLI:Google Gemini 3
>> Signed-off-by: Ian Rogers <irogers@google.com>
>> ---
>> v6: Refactor kernel-space sampling test cases to utilize a dedicated
>>      system-call intensive VFS dd workload (kprog) instead of purely
>>      userspace-bound tight loops, guaranteeing high-density kernel
>>      privilege state sampling streams and eliminating intermittent
>>      execution flakiness dropouts.
>>
> 
> 
> Hi Ian,
> 
> V5 passed on X86, but now I get this test failing about 50% of the time 
> with output like:
> 
> 
> Test user register stripping
> User registers stripping test [Failed - report parsing differs]
> Showing first 20 lines of diff:
> --- /tmp/perf-test-aslr.ssH9urcfri/report_regs1.clean   2026-05-08 
> 14:14:02.127298207 +0100
> +++ /tmp/perf-test-aslr.ssH9urcfri/report_regs2.clean   2026-05-08 
> 14:14:02.129298219 +0100
> @@ -30,8 +30,8 @@
>        0.02%  perf          ld-linux-x86-64.so.2  [.] mmap64
>        0.02%  perf-noploop  [kernel.kallsyms]     [k] kmem_cache_free
>        0.02%  perf-noploop  [kernel.kallsyms]     [k] nohz_balancer_kick
> -     0.02%  perf-noploop  [kernel.kallsyms]     [k] pvclock_gtod_notify
>        0.02%  perf-noploop  [kernel.kallsyms]     [k] try_to_wake_up
> +     0.02%  perf-noploop  [kvm]                 [k] pvclock_gtod_notify
>        0.02%  perf-noploop  libc.so.6             [.] __cxa_finalize
>        0.04%  perf          ld-linux-x86-64.so.2  [.] strcmp
>        0.05%  perf          libLLVM-15.so.1       [.] 
> llvm::StringMapImpl::LookupBucketFor(llvm::StringRef)
> ---- end ----
> 
> or:
> 
> Test user register stripping
> User registers stripping test [Failed - report parsing differs]
> Showing first 20 lines of diff:
> --- /tmp/perf-test-aslr.NoDUUXtHyh/report_regs1.clean   2026-05-08 
> 14:05:31.109246491 +0100
> +++ /tmp/perf-test-aslr.NoDUUXtHyh/report_regs2.clean   2026-05-08 
> 14:05:31.111246503 +0100
> @@ -2,8 +2,8 @@
>        0.01%  perf          [kernel.kallsyms]     [k] 
> find_mergeable_anon_vma
>        0.01%  perf          [kernel.kallsyms]     [k] finish_fault
>        0.01%  perf          [kernel.kallsyms]     [k] 
> pte_offset_map_rw_nolock
> +     0.02%  perf          [amdgpu]              [k] amdgpu_device_rreg
>        0.02%  perf          [kernel.kallsyms]     [k] 
> __alloc_frozen_pages_noprof
> -     0.02%  perf          [kernel.kallsyms]     [k] amdgpu_device_rreg
>        0.02%  perf          [kernel.kallsyms]     [k] 
> __build_id_parse.isra.0
>        0.02%  perf          [kernel.kallsyms]     [k] filemap_get_entry
>        0.02%  perf          [kernel.kallsyms]     [k] filemap_map_pages
> ---- end ----
> 
> 
> And on Arm I get a hang/infinite loop every time in "Test kernel ASLR 
> remapping". Looks like it could be related to the changes in V6 as I 
> didn't see it on V5:

After around an hour it ended up passing successfully, so not an 
infinite loop, just very slow.

Then after that, "User registers stripping test" failed the same way as 
on x86.

> 
>    #0  __read_once_size (size=4, res=0xffffe56c64a0, p=0xaaaaeaedbab8)
>        at linux/tools/include/linux/compiler.h:180
>    #1  atomic_read (v=0xaaaaeaedbab8) at linux/tools/include/asm- 
> generic/atomic-gcc.h:26
>    #2  0x0000aaaaaf65cd6c in refcount_read (r=0xaaaaeaedbab8)
>        at linux/tools/include/linux/refcount.h:70
>    #3  0x0000aaaaaf65d9dc in check_invariants (maps=0xaaaae7e3b480) at 
> util/maps.c:114
>    #4  0x0000aaaaaf65eef8 in maps__insert (maps=0xaaaae7e3b480, 
> map=0xaaaaec2ccf10) at util/maps.c:536
>    #5  0x0000aaaaaf62a028 in maps__split_kallsyms (kmaps=0xaaaae7e3b480, 
> dso=0xaaaae7e3f910, delta=1879048192,
>        initial_map=0xaaaae7e3fab0) at util/symbol.c:986
>    #6  0x0000aaaaaf62b550 in __dso__load_kallsyms (dso=0xaaaae7e3f910, 
> filename=0xaaaae7e55200 "/proc/kallsyms",
>        map=0xaaaae7e3fab0, no_kcore=false) at util/symbol.c:1530
>    #7  0x0000aaaaaf62b5bc in dso__load_kallsyms (dso=0xaaaae7e3f910, 
> filename=0xaaaae7e55200 "/proc/kallsyms",
>        map=0xaaaae7e3fab0) at util/symbol.c:1536
>    #8  0x0000aaaaaf62cbc0 in dso__load_kernel_sym (dso=0xaaaae7e3f910, 
> map=0xaaaae7e3fab0) at util/symbol.c:2125
>    #9  0x0000aaaaaf62bc5c in dso__load (dso=0xaaaae7e3f910, 
> map=0xaaaae7e3fab0) at util/symbol.c:1721
>    #10 0x0000aaaaaf65b98c in map__load (map=0xaaaae7e3fab0) at util/ 
> map.c:351
>    #11 0x0000aaaaaf5e43cc in thread__find_map (thread=0xaaaae7e443b0, 
> cpumode=1 '\001', addr=18446603336494207932,
>        al=0xffffe56c8c28) at util/event.c:744
>    #12 0x0000aaaaaf5e4810 in machine__resolve (machine=0xaaaae7e3bee0, 
> al=0xffffe56c8c28, sample=0xffffe56c8df0)
>        at util/event.c:818
>    #13 0x0000aaaaaf41d850 in process_sample_event (tool=0xffffe56c93d0, 
> event=0xffffb1091ec8, sample=0xffffe56c8df0,
>        evsel=0xaaaae7e3b580, machine=0xaaaae7e3bee0) at builtin- 
> script.c:2686
>    #14 0x0000aaaaaf6668f4 in evlist__deliver_sample 
> (evlist=0xaaaae7e3c550, tool=0xffffe56c93d0, event=0xffffb1091ec8,
>        sample=0xffffe56c8df0, evsel=0xaaaae7e3b580, 
> machine=0xaaaae7e3bee0) at util/session.c:1335
>    #15 0x0000aaaaaf667000 in machines__deliver_event 
> (machines=0xaaaae7e3bee0, evlist=0xaaaae7e3c550, event=0xffffb1091ec8,
>        sample=0xffffe56c8df0, tool=0xffffe56c93d0, file_offset=3784,
>        file_path=0xaaaae7e3b540 "/tmp/perf-test-aslr.J1XB8pvpFy/ 
> perf.data2.kernel.FA0Uvd") at util/session.c:1502
>    #16 0x0000aaaaaf667538 in perf_session__deliver_event 
> (session=0xaaaae7e3bca0, event=0xffffb1091ec8,
>        tool=0xffffe56c93d0, file_offset=3784,
>        file_path=0xaaaae7e3b540 "/tmp/perf-test-aslr.J1XB8pvpFy/ 
> perf.data2.kernel.FA0Uvd") at util/session.c:1593
>    #17 0x0000aaaaaf662bbc in ordered_events__deliver_event 
> (oe=0xaaaae7e3c460, event=0xaaaae7e44740) at util/session.c:134
>    #18 0x0000aaaaaf672c98 in do_flush (oe=0xaaaae7e3c460, 
> show_progress=true) at util/ordered-events.c:245
>    #19 0x0000aaaaaf673048 in __ordered_events__flush (oe=0xaaaae7e3c460, 
> how=OE_FLUSH__FINAL, timestamp=0)
>        at util/ordered-events.c:324
>    #20 0x0000aaaaaf673154 in ordered_events__flush (oe=0xaaaae7e3c460, 
> how=OE_FLUSH__FINAL) at util/ordered-events.c:342
>    #21 0x0000aaaaaf669e54 in __perf_session__process_events 
> (session=0xaaaae7e3bca0) at util/session.c:2508
>    #22 0x0000aaaaaf66a790 in perf_session__process_events 
> (session=0xaaaae7e3bca0) at util/session.c:2675
>    #23 0x0000aaaaaf41f59c in __cmd_script (script=0xffffe56c93d0) at 
> builtin-script.c:3241
>    #24 0x0000aaaaaf4242b0 in cmd_script (argc=0, argv=0xffffe56cb370) at 
> builtin-script.c:4586
>    #25 0x0000aaaaaf4a03f8 in run_builtin (p=0xaaaaafa14e60 
> <commands+480>, argc=3, argv=0xffffe56cb370) at perf.c:348
>    #26 0x0000aaaaaf4a066c in handle_internal_command (argc=3, 
> argv=0xffffe56cb370) at perf.c:398
>    #27 0x0000aaaaaf4a0824 in run_argv (argcp=0xffffe56cb1ac, 
> argv=0xffffe56cb1a0) at perf.c:442
>    #28 0x0000aaaaaf4a0b4c in main (argc=3, argv=0xffffe56cb370) at 
> perf.c:549
> 

