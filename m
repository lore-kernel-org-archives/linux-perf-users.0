Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8DB2628D;
	Sun, 10 May 2026 06:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778395285; cv=none; b=hylbMNxmLyFl03GihvKb/kmj1nQvnYmq+Jffojt91nieUKAXowX4I6bgYVV563ZzlEWs46/xKZX/eeMrC0/zVf7g+EyDLx/0Cl0rTeLPCbYEiN6GbMYUfaoZdY/4MYw2w11ClgG9Z6tuAL/oWBDjzfJQz7OZAJQDfl7KvM/8d6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778395285; c=relaxed/simple;
	bh=ni3zQhrq/IY/QjaqPRXeXkY2u7FoqHsiu/VUpL0mIG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AI23kAGly6rAz+bzayF4sglD4lFNqI8Gl2Y2vKFSAlLX8UHTSC5wRKMydfXdKHDhLG2bwgvDpsUS/+I2GIukxAnYAnkifs6KyWJ+QxXifsqLVjXGBodHU98qRzuZ52g/dGIFnrT1399Tiq5XgmrOJ7isLNVXZGjWn9nTx42bCRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmoSZKLt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmoSZKLt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8C9C2BCB8;
	Sun, 10 May 2026 06:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778395285;
	bh=ni3zQhrq/IY/QjaqPRXeXkY2u7FoqHsiu/VUpL0mIG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dmoSZKLtPjBcZQTRvA0HA6xlId6O25vdq6o0W+syXjgdf/yeiIi7q2oWpeFYFDTIQ
	 JmTrVkVN6acMw/8dHG9vWBsyGJvOJ7Kjo3YwebCTGoVe2q+AfOkmIS3KCKAMsbZS/0
	 NX9Niu1RdDiaaL5Wln0dCKlpJ6KR/THc4Y6qlxqRa5k67npCsiLwXMFWqpGl3fKYzz
	 yDebLp2Pd5JbmEpDk7XlxCvQmGVH60jfkIRYB7MYsNDnVahcqicXZ8FrfPSfO1SysR
	 jYjThM9XsWDVLtEzNkEh0hOE1vDX9InDI5oxthNZo7idfKQnZiAm3Z07mOfzjzy08z
	 PHiLVqry2AbzA==
Date: Sat, 9 May 2026 23:41:23 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	James Clark <james.clark@linaro.org>, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Manali Shukla <manali.shukla@amd.com>,
	Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: Re: [PATCH v3 0/8] perf tools amd ibs: Fixes + Zen6 enhancements
Message-ID: <agAok_vgqBrZzMhA@google.com>
References: <20260508060004.2575-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260508060004.2575-1-ravi.bangoria@amd.com>

Hello,

On Fri, May 08, 2026 at 05:59:56AM +0000, Ravi Bangoria wrote:
> o Fix kernel version check in perf IBS unit test.
> o On Zen6 and newer platforms, skip perf unit test that assumes IBS don't
>   have hardware-assisted privilege filter.
> o Starting with Zen4, the validity of several IBS fields changes. Add
>   the required dependency checks when decoding IBS MSRs.
> o Zen6 and future platforms extends IBS OP with Streaming-Store and
>   Remote-Socket indicators for load/store instructions. Add decoding
>   support for these new bits.
> o Document new IBS features in perf-amd-ibs man page 
> 
> IBS Zen6 enhancements doc:
>   AMD64 Zen6 Instruction Based Sampling (IBS) Extensions and Features,
>   Pub. 69205 Rev. 1.00 March 2026 
>   https://bugzilla.kernel.org/attachment.cgi?id=310002
> 
> Patches are prepared on perf-tools-next/perf-tools-next (53bc03289278).
> 
> v2: https://lore.kernel.org/r/20260430061115.10266-1-ravi.bangoria@amd.com  
> v2->v3:
>  - Instead of removing the priv modifier unit test completely, skip
>    it on platforms that supports hardware privilege filtering. (Namhyung)
>  - Rebased the series on latest perf-tools-next/perf-tools-next.
> 
> Ravi Bangoria (8):
>   perf test amd ibs: Fix incorrect kernel version check
>   perf tool ibs: Sync AMD IBS header file
>   perf test ibs: Skip privilege test on Zen6 and newer platforms
>   perf amd ibs: Suppress bogus TlbRefillLat and DCPhysAd on Zen4+
>   perf amd ibs: Make Fetch status bits dependent on PhyAddrValid for
>     newer platforms
>   perf amd ibs: Decode Remote-Socket flag in IBS OP raw dump
>   perf amd ibs: Decode Streaming-store flag in IBS OP raw dump
>   perf doc: Document new IBS capabilities in man page

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
>  tools/arch/x86/include/asm/amd/ibs.h       |  4 +-
>  tools/perf/Documentation/perf-amd-ibs.txt  | 39 ++++++++++
>  tools/perf/arch/x86/tests/amd-ibs-period.c |  2 +-
>  tools/perf/tests/shell/amd-ibs-swfilt.sh   | 37 ++++++++-
>  tools/perf/util/amd-sample-raw.c           | 87 ++++++++++++++++++++--
>  5 files changed, 156 insertions(+), 13 deletions(-)
> 
> -- 
> 2.43.0
> 
