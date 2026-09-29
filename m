Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2DE5383E9
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 14:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790692900; cv=none; b=eeJEgf3AjiB4+Ojv7AokUOmJ9j5am7LFGVlNZpYpLAYdFNEVfrZpuauDo2BMYG/cNPRq5LWBAE93hRPH3HxER17uuP2W/RIygdEeprsr4tUYbdD0mmVXCMuz+YydVcY7hm8iUU27yp7kC87GXYFo8u+hpHnjwEIvh8Q2XxXccHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790692900; c=relaxed/simple;
	bh=I+1TtXq3U+1B/VQR2q2ohCXl8X3baiWAnbXgVNkqxsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q8BpzcRwgtD7CTnMxJxDEe/iE38S6qiLFominQiQxzsHvlCCTuD4t0lQY16cbtcG5Ho5Ov2P3innLdPg96K8J2dD61xV4FbLrKNtREbpFte/HubPdVYGD7ybOj2mxJ9E/Qu8jGnM9+Bg08BXeMMKucq/HAd0ALUP0M/Y4l5Rp+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vnWGGL9s; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vnWGGL9s"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2af43c5b0cso552049666b.1
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 07:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790692890; x=1791297690; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ljt9qo4CbaNAhZ8NBb8RScI9+T0M5HBa8xMXa6k6Vt0=;
        b=vnWGGL9suXiT6pmulhc0TuLPLp+MGcpywAt5jGtpAhUMxTa9Kj8UArKV5m7xFTDGKS
         snHc7FvvnZeUxsB9iiDVm68mLoXruxMbWIZD+i7Ege1yCkddHWO08KJfUkSQ7hIf4BSh
         qg6SMuJLsEiKS2JpT6JKSOb5V4J/S88z3tMl3D61LeEi14SRuFSFl1H3zBhrf5NfsEa2
         6J0Z5Uup12+gsZfpISX6D6J8ZEr5y1vqq0drfFL6i+dRLfsbFINmkevJLpDGp7YdUmHp
         9SPJcoRmOnoqANjhxeErCYregFBZCpKmq8HgxN6VcgLe62A4EpN3RisOwUkbYxWNaNQ2
         rucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790692890; x=1791297690;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ljt9qo4CbaNAhZ8NBb8RScI9+T0M5HBa8xMXa6k6Vt0=;
        b=1z0nZR6uf6PB4sUWIpe8nfcDFAK+EfJETKjfzXtrgxiCkpil72YJtKo/YiKsqoJ+9e
         T5FR+IALeGbUWS+OLNVzJTQG1psJSw2DspecxdW0TAC7UpDw7rdjF7ujiFn57wB8Wh1V
         ABRUnj/hpGVUULPNoRBF1NwMXc2ZB3Ql0fhk1n1WHZ+ILxXKba1Ta8KJrGwv+N7t6bdV
         gOdCTGbfwtdaGiN6G7qc+vreEO/e8D/4+rr1YZmrheMae//2NtFjdFTRkDHSaGy8u0nN
         9TCpjnG7mfHFBYSO/7NduemJW1j9j+tGOzGHdPMWU3/sObas5oCgLDSyAb28BfZhttAr
         P7Yw==
X-Forwarded-Encrypted: i=1; AKwUvBxiRZ5sgwK/ghCFIiPZLUqQJgb0P5iC5hL8+Y2kjNtNF+QR9oBTKE3ZnpAW9S2Z8ZV/Ira26Rp9cVYrzwj5lGtH@vger.kernel.org
X-Gm-Message-State: AFq9FYIpHzoF59b11tPrTGskUcjfAePClqXupPovjOPlAz5Tz3EL6rKN
	aIaXwnVSt13d6m5W7KEjXPb6YvjJP7Wpw5XSpGqS0ebE1No/uxLycvtu4NjlJV2qKxA=
X-Gm-Gg: AYBFou1YCIx+34df4ZJqn84EvazflzMJoP1hQ3MgurB8wMYCTd/xaTsQXnbTlEEOwQl
	ywtfqZEsl49cudvAlMA+I5Akg23KakU1C+2Dguhqrc6Py5Y9qSFjjCEzC4ArVNpMRixOZ5RDjqn
	FXO72qDHIxL2TJrg/dgrXIP5pZSZSb/uumtsnEViP6FDLh2aD02s6RV2foh6VRjE/A2TaZde07A
	aQFcMXahbLWo2rorQ6VxsbJjxWXyFYV9eLtH0G5OKICPEMWJ9V8CuKD+spRFRSgcjK56TcBmrnS
	Gtk88R9KJ6Z/TsHfsbOmhmgsznPDBXRhrQfR8ZvzpinTw2TxDzw3Mf2bgqTCy8F3/IWP2LxQ/3o
	xacmxyKLuOPtrBhYIPDP7j+zFPoVnZGCFXJkC8MKQQgqc9XTikrwxEJ1lgmpED9826bppXY6LK/
	D+QdoAX030UJPEwRQ61ijewuUyFt2Ysz5ERnr/R7zFOhTf84XCPbVkvQMe9Bz/
X-Received: by 2002:a17:907:c310:b0:c25:32b0:e56c with SMTP id a640c23a62f3a-c2ac23862eemr1446037966b.4.1790692889352;
        Tue, 29 Sep 2026 07:41:29 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6acb905c6f4sm966711a12.37.2026.09.29.07.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 07:41:28 -0700 (PDT)
Message-ID: <8094040d-cb75-4f44-9662-97987f6eadef@linaro.org>
Date: Tue, 29 Sep 2026 15:41:27 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] perf cs-etm: Fix bogus branch samples on
 exceptions
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Mike Leach <mike.leach@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
References: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23/09/2026 16:21, Leo Yan wrote:
> CoreSight currently models exception entry by changing the preceding
> instruction range into a taken branch. This can give an IRQ the source
> PC of an instruction that already retired and overwrite a real branch
> immediately before the exception.
> 
> For an untaken B.LS followed by an IRQ, perf script currently reports:
> 
>    hw int  4000f8 => ffff800080010c80  b.ls #0x400118
>    ...
>    iret    ffff800080012284 => 4000fc  eret
> 
> The hardware trace supplies 0x4000fc as the preferred return address.
> For an IRQ, this is the architectural resume PC (Arm ARM, R_VBQMV).
> B.LS has retired, and the saved PC identifies the boundary before the
> following MOV. Using this PC as the IRQ source reflects the
> architectural state at exception entry:
> 
>    hw int  4000fc => ffff800080010c80  movz x2, #0x1796
>    ...
>    iret    ffff800080012284 => 4000fc  eret
> 
> The IRQ sample represents the transfer from this architectural execution
> position to the handler. The series synthesizes exception entries from
> exception packets, preserving the preceding branch and its outcome.
> 
> The supporting changes:
> 
> - Let decoders supply sample.ret_addr so later instruction fetching cannot
>    change thread-stack return addresses. Apply this to Intel PT
>    asynchronous samples as well.
> - Prepare packet ISA and instruction-size handling and share sample
>    synthesis helpers. Mark untaken branches and break history when
>    instruction memory is unavailable.
> - Add a thread-stack regression test and four AArch64 CoreSight tests.
>    IRQs and page faults must resume at the entry PC; SVC and emulated MRS
>    must resume four bytes later.
> 
> Based on the AI search and test on my x86 machine, this matches perf's
> Intel PT handling of IRQs. Intel PT records the next instruction's IP in
> the FUP packet, and Perf uses that IP as the interrupt sample's source.
> 
> This series is verified on Orion6 board with "perf test coresight".
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
> Changes in v2:
> 
> - Rework the fix around exception packets to preserve both exception
>    entries and preceding branches.
> - Add explicit return addresses and the Intel PT asynchronous-branch fix.
> - Split out packet/synthesis preparation, record not-taken branches and
>    handle unreadable instruction memory.
> - Add thread-stack regression coverage and four CoreSight tests.
> - Link to v1: https://lore.kernel.org/r/20260713-perf_cs_etm_fix_non_taken-v1-0-4561607fc69f@arm.com
> 
> ---
> Leo Yan (14):
>        perf sample: Allow decoders to supply branch return addresses
>        perf intel-pt: Preserve return addresses for asynchronous branches
>        perf cs-etm: Break branch history when instruction memory is unavailable
>        perf cs-etm: Centralize packet ISA initialization
>        perf cs-etm: Use the recorded instruction size for A32 and A64
>        perf cs-etm: Mark branches that were not taken
>        perf cs-etm: Factor out final instruction sample synthesis
>        perf cs-etm: Centralize branch sample synthesis checks
>        perf cs-etm: Classify exception calls using the exception packet
>        perf cs-etm: Synthesize exception entries separately from branches
>        perf tests: Check CoreSight IRQ entry and exit
>        perf tests: Check CoreSight syscall entry and exit
>        perf tests: Check CoreSight abort entry and exit
>        perf tests: Check CoreSight emulated instruction entry and exit
> 
>   tools/perf/tests/Build                             |   1 +
>   tools/perf/tests/builtin-test.c                    |   3 +
>   .../perf/tests/shell/coresight/abort_entry_exit.sh |  21 ++
>   tools/perf/tests/shell/coresight/irq_entry_exit.sh |  37 ++++
>   .../tests/shell/coresight/syscall_entry_exit.sh    |  21 ++
>   .../perf/tests/shell/coresight/trap_entry_exit.sh  |  24 +++
>   tools/perf/tests/shell/lib/coresight_exception.sh  | 165 +++++++++++++++
>   tools/perf/tests/tests.h                           |   3 +
>   tools/perf/tests/thread-stack.c                    | 106 ++++++++++
>   tools/perf/tests/workloads/Build                   |   4 +
>   tools/perf/tests/workloads/branch_not_taken_loop.c |  33 +++
>   tools/perf/tests/workloads/page_fault_loop.c       |  37 ++++
>   tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    | 106 +++++++---
>   tools/perf/util/cs-etm.c                           | 222 ++++++++++-----------
>   tools/perf/util/cs-etm.h                           |   2 +
>   tools/perf/util/intel-pt.c                         |   7 +
>   tools/perf/util/sample.c                           |   1 +
>   tools/perf/util/sample.h                           |   5 +
>   tools/perf/util/thread-stack.c                     |   5 +-
>   19 files changed, 656 insertions(+), 147 deletions(-)
> ---
> base-commit: edd8a9fe2eca009599e013a29c421c7a6b5ad1b9
> change-id: 20260713-perf_cs_etm_fix_non_taken-5b4d7f73f41e
> 
> Best regards,

Reviewed-by: James Clark <james.clark@linaro.org>

