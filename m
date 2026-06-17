Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B093C3BF1
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jun 2026 10:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781690803; cv=none; b=bbNdjgWmc+UbMq4X03SV8skA94aW70n7Vf0hfVQ48GsALKElMiza5aqqZgRom8ur6XQX4qeK3pv5sC7yTTH5+s2HTOe8xuWHe/7G2EPRuAT0q162D7R+DTE0ByReC0nvatzAg6LrNLAG+89335b6l3Thz1zFfx1678QJlN6WOsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781690803; c=relaxed/simple;
	bh=w3cI5Deemt2qYOtwG4ctKnP8+05qHqSGiMsT4NkEIwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbrq2DnNdG2KVOXql2vw+zvOYdAc0hElwInvXBhlOhjBb5Kli87a80RGNyIqAs4jyjOunisfRpyZeQ6QbNrQb1VPMxFfTH6do+s+cMYQq2uUQPpW1vXvYnPcqB3Z8pnq39M3s5uNblywjFPH8oEhXFqxfpJD2yO8B0ljDGN9qBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fDngDXRA; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fDngDXRA"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69574a26071so644197a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jun 2026 03:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781690800; x=1782295600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VXKQCpYuYiPcndIbQaX7IVVokjA341dpStjQTn3hjd0=;
        b=fDngDXRAre25MzdPOOcO9a/AA3Z3w+vwUmPUSM56rJVaLye5hGgFrjGpySw6ALZl+2
         Kg5c+ND0pucaBbV5Jdwc5QliCoB4dct8BmF/OKtqzbOZWOXlhWu1+A+/m8xtG1HkNiJ5
         TVM8J0KLLxJpnrxEXpWV2ItDieKa0WSi4jcqrloF9Eg30sxg3lTvtqN1XinlGcEi17CQ
         yCbNOl6o4tOJ0yOtcwIrWCPOXAauC/VjOeZ44SPE2ZowHEO2iVM/lP0ku2J1O8+MJEFb
         wOguJMC4AM6ZvKhDumVaNfY6ZMh90BF7CuFMa3h5gMBVuIK26XYdCR70dT6Plitnigye
         HPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781690800; x=1782295600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VXKQCpYuYiPcndIbQaX7IVVokjA341dpStjQTn3hjd0=;
        b=WOM2QAKLguNhha4uc984Hlwo+XB+H86nDZrKDZnNYBAokIRb6S+ZGUzYoeamCYbGAj
         zN1C6yW7DtV3JjaEzbzi8v5QuqewaMo331g0blS3IOysHxRAH30x4PqRp8SKfu0xfcAe
         ZudSeggPurW7q8c31rXitAniktfy033jXDGQCN9IjS+Lkd3/mNafWcYJKwXrb+rLS5NM
         dQA9Vc9lfDeht2izCKkcKI8W3cTUZN4BZwyYQPJ5D6b0RYq/RcevkPfVhUJ9aqq2MbCE
         cCaHpaKbk7LhBG1VbkmhTphpkrYZoFkTYJHw0Xui02D6RBYUy0WQuQxm7JROnBFWsDug
         dg1A==
X-Forwarded-Encrypted: i=1; AFNElJ8KIRKleRPdBGa3UoinAAGvNsMVgjdu3pTySfqZL3LIVe3XbxSYnIU2VMyGqv3XqGvNL3tEKEkG/7scuR2nS07+@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Q+BO2D8RA2rgRfqlCx5Nerd2sb4AvEEZkLUXgRMZQHcAD68l
	9jJm7TBUouU+I8zrY7AGt/BNSI124vJ6njHZAbNHTU3sBlI+UlHEHFWaDV/nJH+axw0=
X-Gm-Gg: AfdE7clKc+rbvkIG9IcOWyRneRYGe9Hkd0q3paXzWjqyvXXR4V+bkuqCz5pgcEjUYgL
	bvJAaspuCexiTUv2xRhUKnNalu/BKTESO58lXym6olGxRgKyAiN70wyZiyaDrvGozgCGbDqpqtF
	vMe11staRyNVp8KqWvSnG1gFGB5TpPCsVHdqlA2cB9ojVE9Us+jDKAkPj+6FEyxdXpRqUZEKF27
	MfG//14qh1KpusUocNta4+FshARiHQUUpbTZ68pe3G54doAxiu46j6Dp0iMhlvWT8tc6bcV3VHU
	7pNnQI1RC9Dh59MIC+M/Ux4buf+rrOk8v/LuuUgiJoFRjQ/dLg2BFpBh7GUNMV67ObQnB3f95U8
	AwSnSRgER1dXWIqBuTNOpLcG5chIA64O1wovGBHeWfL7SCEM16Conx3S1env8IJb83wF+4GTH79
	gb9AklTz756jl+n7Q2dw==
X-Received: by 2002:a05:6402:530e:b0:68b:d82b:fbf with SMTP id 4fb4d7f45d1cf-695474906e1mr1572175a12.26.1781690799915;
        Wed, 17 Jun 2026 03:06:39 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-695647013acsm582858a12.11.2026.06.17.03.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 03:06:39 -0700 (PDT)
Message-ID: <6446f782-8a31-4455-8d33-a1219bb02981@linaro.org>
Date: Wed, 17 Jun 2026 11:06:38 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/9] perf cs-etm: Support thread stack and callchain
To: Leo Yan <leo.yan@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linux.dev>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>,
 Paschalis Mpeis <paschalis.mpeis@arm.com>, Amir Ayupov <aaupov@fb.com>
References: <20260616-b4-arm_cs_callchain_support_v1-v9-0-f8fad931c413@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260616-b4-arm_cs_callchain_support_v1-v9-0-f8fad931c413@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/06/2026 3:51 pm, Leo Yan wrote:
> This series adds thread-stack and synthesized callchain support for Arm
> CoreSight, which comes from older series [1] but heavily rewritten.
> 
> CS ETM previously kept last-branch state in a per-trace-queue buffer.
> That effectively makes the state per CPU, while the call/return history
> belongs to a thread. This series moves branch tracking to the common
> thread-stack code.
> 
> The series records CoreSight branches with thread_stack__event(), uses
> thread_stack__br_sample() for last branch entries, flushes thread stacks
> after decoder resets.
> 
> A decoder reset between AUX trace buffers is treated as a global trace
> discontinuity, so all thread stacks are flushed, so avoids carrying
> stale call/return history across a trace discontinuity.
> 
> One limitation remains for instructions emulated by the kernel. In that
> case the exception return address may not match the return address
> stored in the thread stack, because after exception return can be one
> instruction ahead. The stack can still recover when a later return
> matches an upper caller. Given emulated instructions are not the common
> target for performance callchain analysis. Supporting this would require
> extending the common thread-stack path to accept both the real target
> address and an adjusted address for stack matching, so this series
> leaves that extra complexity out.
> 
> The series has been tested on Orion6 board:
> 
>    perf test 136 -vvv
>    136: CoreSight synthesized callchain:
>    --- start ---
>    test child forked, pid 3539
>    ---- end(0) ----
>    136: CoreSight synthesized callchain			: Ok
> 
>    perf script --itrace=g16i10il64
> 
>    callchain_test   17468 [005] 1031003.229943:         10 instructions:
>                aaaac32507c4 main+0x8 (/home/kernel/leoy/test_cs_callchain/callchain_test)
>                ffff90bd225c __libc_start_call_main+0x7c (/usr/lib/aarch64-linux-gnu/libc.so.6)
>                ffff90bd233c call_init+0x9c (inlined)
>                ffff90bd233c __libc_start_main_impl+0x9c (inlined)
>                aaaac3250670 _start+0x30 (/home/kernel/leoy/test_cs_callchain/callchain_test)
> 
>    callchain_test   17468 [005] 1031003.229943:         10 instructions:
>                aaaac3250774 do_svc+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
>                aaaac3250798 print+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
>                aaaac32507b0 foo+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
>                aaaac32507c8 main+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
>                ffff90bd225c __libc_start_call_main+0x7c (/usr/lib/aarch64-linux-gnu/libc.so.6)
>                ffff90bd233c call_init+0x9c (inlined)
>                ffff90bd233c __libc_start_main_impl+0x9c (inlined)
>                aaaac3250670 _start+0x30 (/home/kernel/leoy/test_cs_callchain/callchain_test)
> 
>    callchain_test   17468 [005] 1031003.229944:         10 instructions:
>            ffff800080010c20 vectors+0x420 ([kernel.kallsyms])
>                aaaac3250784 do_svc+0x1c (/home/kernel/leoy/test_cs_callchain/callchain_test)
>                aaaac3250798 print+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
>                aaaac32507b0 foo+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
>                aaaac32507c8 main+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
>                ffff90bd225c __libc_start_call_main+0x7c (/usr/lib/aarch64-linux-gnu/libc.so.6)
>                ffff90bd233c call_init+0x9c (inlined)
>                ffff90bd233c __libc_start_main_impl+0x9c (inlined)
>                aaaac3250670 _start+0x30 (/home/kernel/leoy/test_cs_callchain/callchain_test)
> 
> Note, the test fails on Juno board which is caused by many discontinuity
> packets (mainly caused by NO_SYNC elem). This is likely caused by the
> FIFO overflow on the path.

It passes 20/20 times on my r0 Juno board. But I wonder if reducing the 
timestamp interval fixes it by reducing the rate of trace generation?

I'm just about to send patches that will change it to "timestamp=14" for 
--per-thread mode (only context packet timestamps). And "timestamp=7" 
for per-cpu mode (64 cycle interval).

> 
> [1] https://lore.kernel.org/linux-arm-kernel/20200220052701.7754-1-leo.yan@linaro.org/
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
> Changes in v9:
> - Added patch 01 to fixed thread leak during trace queue init (sashiko).
> - Added check in instruction and branch samples in
>    cs_etm__add_stack_event() (sashiko).
> - Released frontend_thread properly in cs_etm__context() (sashiko).
> - Refined cs_etm__flush_all_stack() to use switch (sashiko).
> - Gathered James' review tags.
> - Rebased on the latest perf-tools-next.
> - Link to v8: https://lore.kernel.org/r/20260611-b4-arm_cs_callchain_support_v1-v8-0-737948584fea@arm.com
> 
> Changes in v8:
> - Updated test_arm_coresight_disasm.sh to pass "--itrace=b" and updated
>    examples in arm-cs-trace-disasm.py (James).
> - Removed static annotation in callchain workload and renamed functions
>    with prefix "callchain_" to reduce naming conflict (James).
> - For callchain test pre-condition check, removed the aarch64 check and
>    added the root permission check (James).
> - Resolved the shellcheck errors (James).
> - Link to v7: https://lore.kernel.org/r/20260611-b4-arm_cs_callchain_support_v1-v7-0-1ba770c862ae@arm.com
> 
> Changes in v7:
> - Rebased on the latest perf-tools-next.
> - Used struct_size() for allocation callchain struct (James).
> - Added a helper cs_etm__packet_has_taken_branch() (James).
> - Minor improvements for the callchain test (used record-ctl FIFO and
>    reworked the validation callstack push / pop).
> - Link to v6: https://lore.kernel.org/r/20260526-b4-arm_cs_callchain_support_v1-v6-0-f9f49f53c9dd@arm.com
> 
> Changes in v6:
> - Heavily rewrote the patches since restarted the work after 6 years.
> - Changed to use the common thread-stack for branch stack and callchain
>    management.
> - Added a callchain test.
> - Link to v5: https://lore.kernel.org/linux-arm-kernel/20200220052701.7754-1-leo.yan@linaro.org/
> 
> Changes in v5:
> - Addressed Mike's suggestion for performance improvement for function
>    cs_etm__instr_addr() for quick calculation for non T32;
> - Removed the patch 'perf cs-etm: Synchronize instruction sample with
>    the thread stack' (Mike);
> - Fixed the issue for exception is taken for branch target address
>    accessing, for the branch sample and stack thread handling, the
>    related patches are 01, 02, 07;
> - Fixed the stack thread handling for instruction emulation and single
>    step with patches 08, 09.
> - Link to v4: https://lore.kernel.org/linux-arm-kernel/20200203020716.31832-1-leo.yan@linaro.org/
> 
> ---
> Leo Yan (9):
>        perf cs-etm: Fix thread leaks on trace queue init failure
>        perf cs-etm: Filter synthesized branch samples
>        perf cs-etm: Decode ETE exception packets
>        perf cs-etm: Refactor instruction size handling
>        perf cs-etm: Use thread-stack for last branch entries
>        perf cs-etm: Flush thread stacks after decoder reset
>        perf cs-etm: Support call indentation
>        perf cs-etm: Synthesize callchains for instruction samples
>        perf test: Add Arm CoreSight callchain test
> 
>   tools/perf/Documentation/perf-test.txt             |   6 +-
>   tools/perf/scripts/python/arm-cs-trace-disasm.py   |   9 +-
>   tools/perf/tests/builtin-test.c                    |   1 +
>   tools/perf/tests/shell/coresight/callchain.sh      | 172 ++++++++++
>   .../shell/coresight/test_arm_coresight_disasm.sh   |   4 +-
>   tools/perf/tests/tests.h                           |   1 +
>   tools/perf/tests/workloads/Build                   |   2 +
>   tools/perf/tests/workloads/callchain.c             |  33 ++
>   tools/perf/util/cs-etm.c                           | 367 +++++++++++++--------
>   9 files changed, 446 insertions(+), 149 deletions(-)
> ---
> base-commit: 44543bb53ebfecb5ce4e890053a666affab9e482
> change-id: 20260521-b4-arm_cs_callchain_support_v1-2c2a70719bcc
> 
> Best regards,

