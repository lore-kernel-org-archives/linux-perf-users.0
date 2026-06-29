Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C013F8EB2
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Jun 2026 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782725399; cv=none; b=ucy3C7XEAQJnqakKwZSOvw/uS/KCSciY1yMNeCUJQeLR22/UCAC5vGocOgMvISNFJjkvmxDNZ+DrKrfn7kMd0vDodrOL4eHX6CD8Wx5mczjOySo7m8lIDau845CNbFCHOhILoiB2S6gULUbEfJqHPX4py8EDTvCZT0jbzsyMbu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782725399; c=relaxed/simple;
	bh=mvmgu5uBTBfMAEJlxYDsrZzwbpYc+IO6eX52BnghmVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQQ3sftF01slunEXMWerXQ20H4nEbW683af79Lj9A9h8t90Xpzf2RzrEOdtgzEcu9OW8TjBm7Et4N8QSPSaEJ1QdmWHelgzwFh0iJoQpOHNYKcVNuvxpzZLJ6WMczgoY49wAGZ/lVwcl9iBD4RcbQ4Q+vaoncRsmgkQWAea5a9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bwGiXYe1; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bwGiXYe1"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4927014c0deso13215015e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Jun 2026 02:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1782725396; x=1783330196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5VzBTGZrdgpQvGtlKCw94HtWGY2NhejYI3ygK47bEVw=;
        b=bwGiXYe1YQ+DmfUt7zsBYj/BBM2fnUvyNnxpA2zDhVHmVHWNzBQKD2BOVbXOFcZiZA
         IYQG0VV6HN+fe70N2wSH75dKUewveiXDO8j83I1WDDBzHuq07JpdchTD4dV/2Ue5Jl/0
         IuUh1sEE/dkWip098RUG9O+nkzh0XcpyLa71hy7326+CNARcR6SPO0MRXLPeI/3wRW2S
         yUQ+kTwUOgvvAOo6wU/r6ex5bp25lN2NGymcc1bHKk4jyhqE4IB3jikL3SZRGgZkeplD
         0OeW4RQsqJ8r0ye037NVI8GwOnuWdS187cDNTartObng7yoRyj8g2tZci3ptxcR6tm/P
         fnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782725396; x=1783330196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5VzBTGZrdgpQvGtlKCw94HtWGY2NhejYI3ygK47bEVw=;
        b=Bkc5LeFep+e0nbQ7Jn0sj5VPWVEBXeksotbnLB+GuU5DLwdgltifr/K2ZQOPfr2/Ii
         9nb+gj0yaAX1W8jSRMvR1lyaimEaweclWnfV5LG/k51rjYZhJ6qfP2TyU9JyahTLaMVy
         7lkdX7VlYHD1r3PrPqsLlxxb3yKOEqWjZtJQpg7AtGxsYADrZ9LsMEkyVCXAK9FbZ+Zp
         1tc6/PgLHDo+xATlHYL2WqEke4kC3pIa341soS0PZEL7uykAXJaDCF+ttndIoZTBdByu
         9b22zwfM2Oc23/eBF+h3KqSJJb+PdtQPAaeXii9UnvatNOIOZaH4Te0FsiLwEhWi3hsu
         6TmA==
X-Forwarded-Encrypted: i=1; AFNElJ/QvOYj34ftMMHDtVt9b8IBVe7iAyxCjlPNnDouH069vHLLJh3sEYFYzVuh3ZQaufNm95ll7w0aZsyNd8vmNG4i@vger.kernel.org
X-Gm-Message-State: AOJu0YzgCnw0aK4bhTKizD9xaPHrZDcJwfvSH4aanacfz1Aro1IzQ2i0
	ZeB2w6iZ+KuNNVTP75QdiwaCvHyF7T23eWHYn5uiG1/Spy+tuvdioPrDERL15TIN2uY=
X-Gm-Gg: AfdE7cnjonhjgfQ53bbrfnsaumdnVjZOf1l3ql6ZID9IQ7Vg7jQsRGSV2+VNJepZeWE
	7rYoBTtPWDFwGO9u2809pGHs6XjPxWyzPWoNiSKzjvEkBx7TlNWf16kw6Bk62sLMuw4Wikw2alP
	Wcb0XcqVJR3lBUa4ttidtlgA+qqdvG7V4Sf7XacTqknXY6x+UmurqvmWth23T1t4ncOWKoGPJM9
	mo/rxFnZ07T/o/qOBwBoDvc0BfTLTUZTHtZJCLNYrZUrD6XDxqRFNnibnsYAllRUMMp3KOctPzF
	P2c2efJWeXf1UdL+LjnnB9Nq9NuHQjOhFGKHPdd6rkzrT9vMdeForcW60i+D5NiszisVA4JR1Dp
	i6uW/FNGcBou0Yzn5wbwcOBvKODL4xurTNkpTuk7zEEpGayCja7Rd6/TvzQpzqmyZBebeUjgt8V
	Ym4MhS3xMiZGnxbmCLvA==
X-Received: by 2002:a05:600c:4e4b:b0:490:b724:5085 with SMTP id 5b1f17b1804b1-4926689ab05mr226507435e9.33.1782725396228;
        Mon, 29 Jun 2026 02:29:56 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492690100c7sm331873245e9.12.2026.06.29.02.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 02:29:55 -0700 (PDT)
Message-ID: <9918583c-30c0-44c6-9a3f-26b02654b53b@linaro.org>
Date: Mon, 29 Jun 2026 10:29:54 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/9] perf cs-etm: Support thread stack and callchain
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
References: <20260617-b4-arm_cs_callchain_support_v1-v10-0-e8b6e5d63db5@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260617-b4-arm_cs_callchain_support_v1-v10-0-e8b6e5d63db5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/06/2026 4:08 pm, Leo Yan wrote:
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
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20200220052701.7754-1-leo.yan@linaro.org/
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
> Changes in v10:
> - Change to syscall(SYS_gettid) for build failure on x86 (James).
> - Extracted sample thread stack into cs_etm__sample_branch_stack().
> - Link to v9: https://lore.kernel.org/r/20260616-b4-arm_cs_callchain_support_v1-v9-0-f8fad931c413@arm.com
> 
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
>   tools/perf/util/cs-etm.c                           | 377 +++++++++++++--------
>   9 files changed, 454 insertions(+), 151 deletions(-)
> ---
> base-commit: 8c214ad8cb8d692c82c6466b8e88973dbfa8e064
> change-id: 20260521-b4-arm_cs_callchain_support_v1-2c2a70719bcc
> 
> Best regards,

Reviewed-by: James Clark <james.clark@linaro.org>

