Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBCB3EAC76
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066640; cv=none; b=cTlRIdwYmlCi1RG6eGx4/f2YtkFnZUneKjQZQMMnRi5Xwb9TQbbaRTZPjHukTltlAaa53ohe9sAnCmgqVFPMMNbeKUs79hOQHceoiORGzC5xuVk0oWFE/TXow8nI9kutnEzt5SnJMCFhjAP5rQ4orXLdJpMCVkMZ5oKtMozk4W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066640; c=relaxed/simple;
	bh=B90UaGm3G9O/6A5KDCucCNPxKGC0YUsHtAw4IHShAJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2G5Srt3xte++nTc+9B1dCZUX+npswq0gSz4VcKjDytgVIx9VhretSn76v1dACtUX/4F8JnZfBDAg9azMnK7Vl5phoj4+tz6DcrxlZpunz/jSRdl3c4XAUDPljwONo+pPtemMrBgnAr+xBML1MdKyJmNtXyLU3QHLWfjrDFcw2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmUEdEY/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmUEdEY/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68531F00893;
	Fri, 29 May 2026 14:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780066638;
	bh=nE1mGeNI+8Hfx54NAJa09ZayrLU/Dyo+3dvjMnx8elg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LmUEdEY/L1sgTt9Gjcc1JmkfIYvQyPfq+Gw63gxYQsX2AnLcwMT5bi3DZ5BaAwR1V
	 DouiaupUJgxW+7RvtkI0gEvA1NJlGcTkxsZWsG0H2zsydXlJSWgoeoHT8cvFyCymOc
	 Af1lyhrFo9bE43H4a23Cc5K0tsGrmvecFm+RiJzZDQ21NUmdGiRrBnrPHlebuFbaNa
	 Rprv0KQO5kx1H4cwxGEUqQSBPD3ouN5Cqoz8tEdB1YvkenR1xGku8HY8aMjBSponZt
	 QnaGnEWeUiZPbPKzul/VsQB32Jr3a9ej200T7uSh5kfJa9lGwC2RUXO4UOo4pLnx8R
	 P9zLTkT+UFUJA==
Date: Fri, 29 May 2026 11:57:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Al Grant <al.grant@arm.com>,
	Paschalis Mpeis <paschalis.mpeis@arm.com>,
	Amir Ayupov <aaupov@fb.com>, linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	Leo Yan <leo.yan@linux.dev>
Subject: Re: [PATCH v6 0/8] perf cs-etm: Support thread stack and callchain
Message-ID: <ahmpSnDTJ14_BNiv@x1>
References: <20260526-b4-arm_cs_callchain_support_v1-v6-0-f9f49f53c9dd@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526-b4-arm_cs_callchain_support_v1-v6-0-f9f49f53c9dd@arm.com>

On Tue, May 26, 2026 at 05:59:36PM +0100, Leo Yan wrote:
> This series adds thread-stack and synthesized callchain support for Arm
> CoreSight, which comes from older series [1] but heavily rewritten.

Hi Leo,

	Please add what changed from v5, v4, etc.

- Arnaldo
 
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
>   perf test 150 -vvv
> 
>   150: Check Arm CoreSight synthesized callchain:
>   --- start ---
>   test child forked, pid 13528
>   Test callchain push: PASS
>   Test callchain pop: PASS
>   ---- end(0) ----
>   150: Check Arm CoreSight synthesized callchain                       : Ok
> 
>   perf script --itrace=g16i10il64
> 
>   callchain_test   17468 [005] 1031003.229943:         10 instructions:
>               aaaac32507c4 main+0x8 (/home/kernel/leoy/test_cs_callchain/callchain_test)
>               ffff90bd225c __libc_start_call_main+0x7c (/usr/lib/aarch64-linux-gnu/libc.so.6)
>               ffff90bd233c call_init+0x9c (inlined)
>               ffff90bd233c __libc_start_main_impl+0x9c (inlined)
>               aaaac3250670 _start+0x30 (/home/kernel/leoy/test_cs_callchain/callchain_test)
> 
>   callchain_test   17468 [005] 1031003.229943:         10 instructions:
>               aaaac3250774 do_svc+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
>               aaaac3250798 print+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
>               aaaac32507b0 foo+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
>               aaaac32507c8 main+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
>               ffff90bd225c __libc_start_call_main+0x7c (/usr/lib/aarch64-linux-gnu/libc.so.6)
>               ffff90bd233c call_init+0x9c (inlined)
>               ffff90bd233c __libc_start_main_impl+0x9c (inlined)
>               aaaac3250670 _start+0x30 (/home/kernel/leoy/test_cs_callchain/callchain_test)
> 
>   callchain_test   17468 [005] 1031003.229944:         10 instructions:
>           ffff800080010c20 vectors+0x420 ([kernel.kallsyms])
>               aaaac3250784 do_svc+0x1c (/home/kernel/leoy/test_cs_callchain/callchain_test)
>               aaaac3250798 print+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
>               aaaac32507b0 foo+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
>               aaaac32507c8 main+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
>               ffff90bd225c __libc_start_call_main+0x7c (/usr/lib/aarch64-linux-gnu/libc.so.6)
>               ffff90bd233c call_init+0x9c (inlined)
>               ffff90bd233c __libc_start_main_impl+0x9c (inlined)
>               aaaac3250670 _start+0x30 (/home/kernel/leoy/test_cs_callchain/callchain_test)
> 
> Note, the test fails on Juno board which is caused by many discontinuity
> packets (mainly caused by NO_SYNC elem). This is likely caused by the
> FIFO overflow on the path.
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20200220052701.7754-1-leo.yan@linaro.org/
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
> Leo Yan (8):
>       perf cs-etm: Decode ETE exception packets
>       perf cs-etm: Refactor instruction size handling
>       perf cs-etm: Use thread-stack for last branch entries
>       perf cs-etm: Flush thread stacks after decoder reset
>       perf cs-etm: Support call indentation
>       perf cs-etm: Filter synthesized branch samples
>       perf cs-etm: Synthesize callchains for instruction samples
>       perf test: Add Arm CoreSight callchain test
> 
>  .../tests/shell/test_arm_coresight_callchain.sh    | 235 ++++++++++++++++
>  tools/perf/util/cs-etm.c                           | 309 ++++++++++++---------
>  2 files changed, 408 insertions(+), 136 deletions(-)
> ---
> base-commit: bd2a5be1fe731bc7548205dd148db75f1d588da2
> change-id: 20260521-b4-arm_cs_callchain_support_v1-2c2a70719bcc
> 
> Best regards,
> -- 
> Leo Yan <leo.yan@arm.com>
> 
