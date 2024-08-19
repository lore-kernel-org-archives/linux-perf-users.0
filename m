Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB4B9460;
	Mon, 19 Aug 2024 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096107; cv=none; b=Lqt0D4x24WGunu+i3rpDMgdAhvq78VSiKSlPhwXlyt8CH6lNN8cpEuJwRZ6Ntulq0A2dEuP7pTk2jK/6JxzISf0cfJA/77TLOFHCwX6jJb1IrT1y/eml7GIO6yBUkoe+I1iDfZLAJEQFc4XhOZ3+7+SsRRv8Dmo7J2jxVPFS8ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096107; c=relaxed/simple;
	bh=JahsyMtN0peOVfQtiQs2ZrtDmssy9ML06xUmp/FnA1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPswMMGb8TvlyeKIm9kp32wxTPn/K3iaI1MJdTrMPUvyIXsXZxwgVN3GLd8HpCHVqrqW5C4ytN7aLYWZXFf90vBTwJ3bR4r94so3FrzV+q2TlTsaItqQCHyXLpZU7nB/LbP5dYDidYA5KnLrS8okFASyJoQSuBxqt5VCDFZuTgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haJY+L9A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haJY+L9A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39B7C32782;
	Mon, 19 Aug 2024 19:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724096107;
	bh=JahsyMtN0peOVfQtiQs2ZrtDmssy9ML06xUmp/FnA1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=haJY+L9ANRaSrlydIatI3YR5XAOxkzxuaZKVv/eBR0sd9qTAZlww5evTdBPe4nELz
	 zujPuohC7ZSZv4KuBBJSS5/5jp4KkjqvwawcvZTsC24mLib+WLwDtVMJI1PMTRMOFh
	 fNJkoKa1fIo6BgxThGv6M/YOsgFi18inJ+UXfLahF7cOTch0ogUaKQ3HLuPrE1ifgC
	 tetqwHa1oGFQ6/n3f9Ir+YmP7Cj/lGuOQ22KOWNt2YdO/spe6ZVAB+tZV/6Rn/kt8k
	 iOk4+Jv/DYYyVt0rzyF0rDdREfTruVrbe6aP3ChXZiJ1xXfzJ7rAEL2kOIqs2Vg05o
	 A5ABMCo0s18YQ==
Date: Mon, 19 Aug 2024 16:35:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCHSET 0/9] perf annotate-data: Update data-type profiling
 quality (v1)
Message-ID: <ZsOeaPxZu1bAobUs@x1>
References: <20240816235840.2754937-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816235840.2754937-1-namhyung@kernel.org>

On Fri, Aug 16, 2024 at 04:58:30PM -0700, Namhyung Kim wrote:
> Hello,
> 
> I've found a couple of bugs in the DWARF location handling and had
> some updates to improve the quality of the type resolution.
> 
> The current code only checks the first variable it found in the
> closest scope but sometimes it's not good because macro expansions
> like container_of (which is used by many list/rb tree manipulation
> routines) only gives a very limited information (like void *) with
> type cast.  So it needs to lookup other variables in the upper scope.
> See the patch 8 for more details.
> 
> Also sometimes it can have more information for the parent type if the
> pointer is for an embedded type.  For example, a list_head is
> typically a part of bigger struct.  Even if it found a variable for
> the list_head, it'd be nice if it can tell which list it is.
> 
> To compare two type information in general, I've added a heuristic to
> take a pointer to a bigger data type.
> 
> This is an example data, the portion of unknown type went down a bit
> and the atomic_t turned out to be _mapcount in the struct page.
> 
> Before:
>   #
>   # Overhead  Data Type
>   # ........  .........
>   #
>       37.24%  (unknown)
>       14.40%  atomic_t 
>        8.81%  (stack operation)
>        5.54%  struct psi_group_cpu
>        3.40%  struct task_struct
>        2.99%  struct pcpu_hot
>        2.99%  struct cfs_rq
>        2.18%  struct audit_krule
>        1.93%  struct psi_group
>        1.62%  struct sched_entity
> 
> After:
>   #
>   # Overhead  Data Type
>   # ........  .........
>   #
>       36.87%  (unknown)
>       14.40%  struct page
>        8.81%  (stack operation)
>        6.00%  struct psi_group_cpu
>        3.40%  struct task_struct
>        3.36%  struct cfs_rq
>        2.99%  struct pcpu_hot
>        2.18%  struct audit_krule
>        1.93%  struct psi_group
>        1.62%  struct sched_entity
> 
> Also updated the debug message and the statistics to help debugging.
> 
> The code is available at 'perf/data-profile-update-v1' branch in
> git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 

Thanks, applied to perf-tools-next,

- Arnaldo
