Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51992765E3;
	Wed, 20 Aug 2025 23:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733389; cv=none; b=fFSMv477I4JXCCIDjhlOoLFzh2H1UOt3QTZjBVgZtSuAvIMpD6Ix87YRdkJPwT4vJdxkP/NKuPx7IdVuEftHGJh5tH8TVWCZuY81PpCdB4CeSNEISKo6cAyAbZAbokc170CF1X4Iekbgadp/aiLtkgKLKhvw7x/g5pWF91oH0+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733389; c=relaxed/simple;
	bh=/TpHuLfcHmrK+eeqFIMicwvfRxrY9ctMe24v5i4nTrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZ7TmEyLG/sBpXJc/1PPutFhsD6M+tFzOQA1KsSYmdkpMwqYpKWGTmSHfop7PBbsn9UVcMYxNsT0dZImu7aawtw5/+JLvzwGtstHKGzAnTp/4bzGlJOar4OLDYh3e10BGODoT/fmYhiTicCnulprVdAHt6JiSVjQNqDrDz8xzVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNi8BTvt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNi8BTvt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55AFC4CEE7;
	Wed, 20 Aug 2025 23:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755733389;
	bh=/TpHuLfcHmrK+eeqFIMicwvfRxrY9ctMe24v5i4nTrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bNi8BTvtSafZRq2YEWlg/InGC4/7aRot7zwMhZTCUmNil4vn7leYAuW3esqeUbBVR
	 lFs92rNMAfuJdtg2bAGTunLfHM3uZnNF0f2G5yIj/xWjQHkmGciXOlIPLzmbr4+9Hx
	 lukZRkefQNooDvIVYClpjCT+ZiTCW3HN32XBX7JUoMGwbtZOPQ9u3VuFFL/ORE97TY
	 36bg6MCFxTdJaZalWeVVHU3zYQFzoE38ezhDNPpN1tJPwtY5KTIKdxJlO8kSOkf4aY
	 5D1nnAEFtPYMJ5pNNakqdgsYEVQ4I6bkaoGrKnt8p4Hn2lEw/xxNvBStrrO3Oj1ANw
	 hcgXHhnmJBUQA==
Date: Wed, 20 Aug 2025 16:43:05 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 08/12] perf annotate: Add 'T' hot key to toggle data
 type display
Message-ID: <aKZdiXgwWPwGEvLg@google.com>
References: <20250816031635.25318-1-namhyung@kernel.org>
 <20250816031635.25318-9-namhyung@kernel.org>
 <aKY6a0ELxX3jru1q@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aKY6a0ELxX3jru1q@x1>

On Wed, Aug 20, 2025 at 06:13:15PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Aug 15, 2025 at 08:16:31PM -0700, Namhyung Kim wrote:
> > Support data type display with a key press so that users can toggle the
> > output dynamically on TUI.  Also display "[Type]" in the title line if
> > it's enabled.
> 
> Testing here I see:
> 
>    0.81 │       mov     0x9c(%r8),%r11d         # data-type: struct cfs_rq +0x9c
> 
> If I ask for source code by pressing 's':
> 
>         │     delta += sa->period_contrib;                                                                                                                              ▒
>    0.97 │       mov     0x9c(%r8),%r11d         # data-type: struct cfs_rq +0x9c
> 
> So it is the 'period_contrib' field of 'struct cfs_rq', humm, not:
> 
> root@number:~# pahole -E --hex cfs_rq | grep 0x9c -B 10 -A10
> 	struct sched_entity *      next;                                                 /*  0x60   0x8 */
> 
> 	/* XXX 24 bytes hole, try to pack */
> 
> 	/* --- cacheline 2 boundary (128 bytes) --- */
> 	struct sched_avg {
> 		/* typedef u64 -> __u64 */ long long unsigned int last_update_time;      /*  0x80   0x8 */
> 		/* typedef u64 -> __u64 */ long long unsigned int load_sum;              /*  0x88   0x8 */
> 		/* typedef u64 -> __u64 */ long long unsigned int runnable_sum;          /*  0x90   0x8 */
> 		/* typedef u32 -> __u32 */ unsigned int       util_sum;                  /*  0x98   0x4 */
> 		/* typedef u32 -> __u32 */ unsigned int       period_contrib;            /*  0x9c   0x4 */
> 		long unsigned int  load_avg;                                             /*  0xa0   0x8 */
> 		long unsigned int  runnable_avg;                                         /*  0xa8   0x8 */
> 		long unsigned int  util_avg;                                             /*  0xb0   0x8 */
> 		unsigned int       util_est;                                             /*  0xb8   0x4 */
> 	} avg __attribute__((__aligned__(64))); /*  0x80  0x40 */
> 
> 	/* XXX last struct has 4 bytes of padding */
> 
> 	/* --- cacheline 3 boundary (192 bytes) --- */
> 	struct {
> root@number:~#
> 
> So it is in a subtype and probably this is an improvement to be made,
> right?

It seems %r8 contains a pointer to cfs_rq and there's a variable for sa
(sched_avg) but it actually uses the same register as it's embeded.  I
think DWARF has correct location expression to find the containing data
type and the output looks ok.  In general, I'd prefer seeing outer types.

Thanks,
Namhyung
