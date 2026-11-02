Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793615455;
	b=0KZ59bJzz9sNr6SsKnsDukoP0G58fhg96OP6fZ3ToFP1nR/XBf+kSHaWLh6YnfVo9LDU
	 sdTgMwRafBSzeAshnxL+fomA0+/OvTbSHsCYb5Ot+Ta7QsBjEGDo4ALySFKxpcSOfw/lZ
	 e1iwLZk1W+3bynvE1pCqUYBhqjUXbo0jdg1ToqBhHTfM/lfv9wRRZNUQ0XlG8nWPfv+vs
	 NGVUEpxvKr2ZJPL8XiW9LSuQooLyVy96dmF3QTK4wU4NhdVxfU8y/pM6fW6+Em/Qmm80c
	 WuDpHVj51kNgtCjTip2PHwQo/P3J054j/rVlGvQXU+KcQPjvrfER9xv2cuqpRVrX3vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793615455;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=TG6233zEpb+rSVfSqflC2boy12f75HN0PuFPajXRgoQ=;
	b=SbrlKvZ5I8pMbYA41wT94sHWco6MVKc7mSzhAJ5uZusewfR8rZ7yS49F52JTNgRGdjQq
	 QCDNz137Gwc2ZR3tW4WPBRmJZAWEVNOJ/DsQj4Oh2tgSUiQbEsrYxfxI9kronGH72/r9T
	 9P+cPMDJ+Wk/67ABoPriDVZxlLqZZQibJBS210ZlXne0CNdxIDbGEMZ/Csi0tz70+JmTn
	 73JfL3RlYSTSFr/xeqPU5LWH8boE5r6z+S4xHb+T6SpmOXdNEDV2TRBBXPVlY00C9osln
	 /UVw9zar4aXwrcPuuwtV8HjQWwLHlGnmybQO4OAqz5H45an18g8sMKY94yVYPMuA6kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="dJkN8mL/";
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CC6606A326
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 10:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1CC6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dJkN8mL/
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4322d310e7so459231866b.0
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 02:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793615453; x=1794220253; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TG6233zEpb+rSVfSqflC2boy12f75HN0PuFPajXRgoQ=;
        b=dJkN8mL/WmQvYgijBc0NOUDbpRSCiu3Ssb1jpNP4RXf+YYHSkNf8kQncjcy/gyASR1
         QnEodpM8Op5I7YbB/9jcDYRINjTQYqhnun/97mKgfEKrdGARQAixQcNTxQBaGQ3p0CpV
         pZ+qB8u/I0X8kuBeCZtllD1tAAjKmHNcCkvaxCnnLOoIdSXLIwHE7jptLcNyVk6hPhY3
         bzo303fZLqAfsuK+sQpmt2Nnp/oVIAT0adT+X+OtgTDuAQJei+LL0dUzeKNdIWoklkbO
         fJBAB7ahbdMshF9P1LNsMKDiRglJGjRnlodqPvp2sY0mIziFp/FicJ+OwbVu6JG0QqmU
         rPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793615453; x=1794220253;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TG6233zEpb+rSVfSqflC2boy12f75HN0PuFPajXRgoQ=;
        b=O2JqyixJvEcvXFCJS9JLU5bJQjsRYouQV+sWHy4eybPwZxcntW38n8aSypfJXEH5Yt
         KZAf7+FPE7LjkHeU09LUGon4vYGX+ERPIhTXtQtpLc101h6qVLWAMZBL5ZfjjvV3QQ4J
         px3wSayv61o2MKl9xdFvLKdfLpsVQXYW1uX4QTIqf5vqiaAWZt/4VENaeCFFWGHlNuQF
         BtOLLnZZYuR5jFwKLsnmPlH7vyiJvLeVTSaoP73qsYTiHuKyy84LKshFFd4BcTNlv5Na
         73t/rt5buHXzWdZcDzqzaFbLzYkTl+lRBLhbqTUZGkDV8lyLNsHkTGzZTJevsIOWt3vn
         PgOQ==
X-Forwarded-Encrypted: i=1; AKwUvBz6uf9NejykYIimtjt7/l/+1twvSkjlOphSot27hJBUieA8oTq96TdTmLWkwMV+F8QoOfjr7+58gtlL7X/FnPL9@vger.kernel.org
X-Gm-Message-State: APuU4Z/68UM8Q730cHrfUg286Tf15pKKKh9kH5mXLAHd7hTPcATHA3Ac
	6w7MOw8LmdWQHkqFPS/X1+FZKpE9UVZuSsO532vQJO7H3fiSDT3DCGslJf+k8m0Qpnk=
X-Gm-Gg: AYBFou0bEgpTn12TgHfNW4IBcBvCHYGU3CGyqIfMgieuYUHjGu6kOLb1NBs3o7/NeY6
	tRLyI2iJtbvFmXzb+6Z4B3jTnRzdDXgma5GieNxdvXnSRJqL31gxYtY1PaQ2QlQCnFn0+KH8EIZ
	MH5bpTgI+Ra1UXpkhNigPy3pCrCVdhwJ/igg4h+46+eyv9EGiQb4rKK+7GdqIdm2fJ+E73AhWXN
	eJhXTLN0V9XDnJSPejYSEmzA+ZNbiZRD+7MZVjF3WVStmHlR/kLbVdWjfL4721YloYsfnMBPMFe
	AtF4fJEks8ob1dJ52iVPmmTqo7o3PfbXVrg701FAxPnGSVf0Qr9heXNKHesIu7vEX/gVpggtNKm
	auBOP3SF5Q1rERHN11xjsFIf7K4Fgx5q1O3dUp2l8MyJHf/cwa2FB8A0G1Rqfsh9biXvjJvpCND
	QSPxzQ2hkKMCBb5rwBs+WTJZtUsNJkGQT1LpasoTWZJyEFwYec4tp15x83Qx7I3rlU5f9dPbjV5
	YYvHKvg5Qhx/3yZNzcnayQpBtVXRzqCy9Rc8hy9VVS+Uk6xVcT3vW3vxrGNCB1vXTDdTTKtkq2v
	hvG7v9SVJ9l4nOOV5HQ/aIhcQoF5LfeR
X-Received: by 2002:a17:906:c156:b0:c49:9383:a28 with SMTP id a640c23a62f3a-c4ca7ac537bmr772991066b.35.1793615452931;
        Mon, 02 Nov 2026 02:30:52 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabeb11acsm371161266b.70.2026.11.02.02.30.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 02:30:52 -0800 (PST)
Message-ID: <6682e9cf-8350-4410-8acc-1fbeca638e64@linaro.org>
Date: Mon, 2 Nov 2026 10:30:51 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/14] perf cs-etm: Fix bogus branch samples on
 exceptions
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Mike Leach <mike.leach@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
References: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/10/2026 15:13, Leo Yan wrote:
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
> Changes in v3:
> - Introduced the pref_ret_addr/end_addr union (James).
> - Clarified zero-size A32/A64 exception handling and why T32 retains
>    per-address instruction decoding (James).
> - Retreed missing exception pairs for up to three recordings,
>    then fail instead of skipping (James).
> - Shorten the IRQ workload (James).
> - Fix FIFO argument quoting and remove redundant ShellCheck source
>    directives (James).
> - Checked instruction length before copying bytes into sample->insn
>    (Sashiko).
> - Retried MRS checks when instruction page faults may match the opcode
>    filter (Sashiko).
> - Rebased onto the updated perf tree and collect review tags.
> - Link to v2: https://lore.kernel.org/r/20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com
> 
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
>   .../perf/tests/shell/coresight/abort_entry_exit.sh |  32 +++
>   tools/perf/tests/shell/coresight/irq_entry_exit.sh |  36 +++
>   .../tests/shell/coresight/syscall_entry_exit.sh    |  32 +++
>   .../perf/tests/shell/coresight/trap_entry_exit.sh  |  39 ++++
>   tools/perf/tests/shell/lib/coresight_exception.sh  | 164 ++++++++++++++
>   tools/perf/tests/tests.h                           |   3 +
>   tools/perf/tests/thread-stack.c                    | 106 +++++++++
>   tools/perf/tests/workloads/Build                   |   4 +
>   tools/perf/tests/workloads/branch_not_taken_loop.c |  33 +++
>   tools/perf/tests/workloads/page_fault_loop.c       |  37 ++++
>   tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    | 106 ++++++---
>   tools/perf/util/cs-etm.c                           | 246 +++++++++++----------
>   tools/perf/util/cs-etm.h                           |   6 +-
>   tools/perf/util/intel-pt.c                         |   7 +
>   tools/perf/util/sample.c                           |   1 +
>   tools/perf/util/sample.h                           |   5 +
>   tools/perf/util/thread-stack.c                     |   5 +-
>   19 files changed, 714 insertions(+), 152 deletions(-)
> ---
> base-commit: 4626d370ae89b8af4d46a45372b269f926ec662d
> change-id: 20260713-perf_cs_etm_fix_non_taken-5b4d7f73f41e
> 
> Best regards,

Reviewed-by: James Clark <james.clark@linaro.org>

