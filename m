Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4E52AEFD;
	Tue,  3 Sep 2024 23:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725405921; cv=none; b=Eof5K9n7vaT4MzPZbjE2rkyDIZpP5PF2zBOwHDwLoblPqsj8BIoKtqFxhT778o5oQGiPazl1noqfZ3Ru1MH8asaqIJsjuqWB8o9/yVnwqD74r0lXwVZeGktmGT7lIHhzq3ewdRKsqx4osShAoyay3qBsta9sdRR61ZGgsEr1JAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725405921; c=relaxed/simple;
	bh=sC8/ns/8sGJ+aohpSH7TbnP6UXd84O6n98pLOsq51zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/cBKNOCcnjYYSgB4MCj7dF9Ue03aBT+4KASq5peE1Wb7oJVkN0O0VtuJz5Q7BnMFDzvOshGdc3NjsrJjMoFMf8ZmH1b1UvnZ7SZTgPos8jar+ilocmVOxnsB9fVHo0szUtV14RfhqzXopahmJMFEJOFUDTrYSFJhjKvjRov/Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d2zL97vN; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2zL97vN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725405920; x=1756941920;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=sC8/ns/8sGJ+aohpSH7TbnP6UXd84O6n98pLOsq51zM=;
  b=d2zL97vNgoH18OA70ezx1bsPDdjz5D41EN9KLPM3bmF9dOLlyMnCycz4
   31sipmbjOWlntl3dDgewcUO8SwfEjJRwgK67DJgNjOWh4ZYgjaMUlH7W7
   TJcJh0PA1hNfwG6eFDukB+XfKM3vNp3jGlBDm1F1eqRUz9WcuVsosbn44
   +r3c3yVkdut99C29VxlgwJWhtQFNwn6l1/TgQaw5IEZ7Z7SWwas4NQCL1
   z8qNcS3+3jiuves53idq5+UuikgEJI/fu5R6HaEqMW7yM3UykNxZInkzz
   60aRT3ZHVpTAG/E2JV2MeUAZ8npaB587Vg35ueIPHTmQb7utQGUCJYPaY
   A==;
X-CSE-ConnectionGUID: 9kLIKtzJTz6oUXkMk2p8TA==
X-CSE-MsgGUID: OLCamxkHRQ+jUN/2Y2q+Ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24175710"
X-IronPort-AV: E=Sophos;i="6.10,200,1719903600"; 
   d="scan'208";a="24175710"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 16:25:19 -0700
X-CSE-ConnectionGUID: aSFd0emMTQOcDeAj1kf8nw==
X-CSE-MsgGUID: 00E4BWA/RSy9RvQTWM2+Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,200,1719903600"; 
   d="scan'208";a="88315235"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 16:25:18 -0700
Date: Tue, 3 Sep 2024 16:25:17 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 1/4] Create source symlink in perf object dir
Message-ID: <Ztea3dUZ-XSG2gfB@tassilo>
References: <20240813213651.1057362-1-ak@linux.intel.com>
 <Zstiry-K_v51oDC4@tassilo>
 <ZsyR4eQr8X-q2X28@x1>
 <CAP-5=fWKiN8jJ2rehG+0fw_REyYZxC3562KLBG1g9jHCyXMRvQ@mail.gmail.com>
 <Zs0RE60KpHyZlj8g@x1>
 <CAP-5=fUZwoDrGaEh7Us1aDM+W3aj1zb3D5VEH39qDfCjQGvePQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUZwoDrGaEh7Us1aDM+W3aj1zb3D5VEH39qDfCjQGvePQ@mail.gmail.com>

On Mon, Aug 26, 2024 at 04:53:01PM -0700, Ian Rogers wrote:
> On Mon, Aug 26, 2024, 4:34 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > On Mon, Aug 26, 2024 at 08:27:43AM -0700, Ian Rogers wrote:
> > > On Mon, Aug 26, 2024 at 7:32 AM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > On Sun, Aug 25, 2024 at 09:58:23AM -0700, Andi Kleen wrote:
> > > > > Arnaldo,
> > > >
> > > > > can you please apply the patchkit? This fixes a regression.
> > > >
> > > > First one was applied, was letting the others to be out there for a
> > > > while, I thought there were concerns about it, but I see Namhyung's Ack,
> > > > so applied.
> > >
> > > Can we not apply this? See comments on the thread. Basically we're
> >
> > And what about the reported segfault?
> 
> It is better addressed by:
> https://lore.kernel.org/lkml/20240720074552.1915993-1-irogers@google.com/

I finally got around to test this other patch.

The reason for the feature is to get the metric for every individual
sampling interval as the most fine grained unit, as it was explained in the
original commit message:


    perf script: Allow computing 'perf stat' style metrics

    Add support for computing 'perf stat' style metrics in 'perf script'.

    When using leader sampling we can get metrics ____for each sampling period___
    by computing formulas over the values of the different group members.

    This allows things like fine grained IPC tracking through sampling, much
    more fine grained than with 'perf stat'.

    The metric is still averaged over the sampling period, it is not just
    for the sampling point.

...


Note the "for each sampling period" which is the key aspect.

With my version I get:

perf record -e '{cycles,instructions}:S' -a tcall
perf script -F +metric

            perf 2061404 [000] 6395040.804752:       2687       cycles:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [000] 6395040.804752:        396 instructions:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [000] 6395040.804752:  metric:    0.15  insn per cycle
            perf 2061404 [001] 6395040.804879:       2411       cycles:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [001] 6395040.804879:        396 instructions:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [001] 6395040.804879:  metric:    0.16  insn per cycle
            perf 2061404 [002] 6395040.805000:       2245       cycles:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [002] 6395040.805000:        396 instructions:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [002] 6395040.805000:  metric:    0.18  insn per cycle
            perf 2061404 [003] 6395040.805122:       2442       cycles:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [003] 6395040.805122:        396 instructions:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [003] 6395040.805122:  metric:    0.16  insn per cycle
            perf 2061404 [004] 6395040.805241:       2208       cycles:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [004] 6395040.805241:        396 instructions:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [004] 6395040.805241:  metric:    0.18  insn per cycle
            perf 2061404 [005] 6395040.805359:       2199       cycles:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [005] 6395040.805359:        396 instructions:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [005] 6395040.805359:  metric:    0.18  insn per cycle
            perf 2061404 [006] 6395040.805479:       2269       cycles:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [006] 6395040.805479:        382 instructions:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [006] 6395040.805479:  metric:    0.17  insn per cycle
            perf 2061404 [007] 6395040.805596:       2215       cycles:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [007] 6395040.805596:        396 instructions:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [007] 6395040.805596:  metric:    0.18  insn per cycle
            perf 2061404 [008] 6395040.805715:       2258       cycles:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [008] 6395040.805715:        396 instructions:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [008] 6395040.805715:  metric:    0.18  insn per cycle
            perf 2061404 [009] 6395040.805835:       2293       cycles:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [009] 6395040.805835:        396 instructions:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])



You see there is one metric for every sampling period

            
But Ian's version generates this:

            perf 2061404 [000] 6395040.804752:       2687       cycles:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [000] 6395040.804752:  metric:    0.15  insn per cycle
            perf 2061404 [000] 6395040.804752:        396 instructions:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [000] 6395040.804752:  metric:    0.07  insn per cycle

This is the only metric for "perf"

            perf 2061404 [001] 6395040.804879:       2411       cycles:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [001] 6395040.804879:        396 instructions:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [002] 6395040.805000:       2245       cycles:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [002] 6395040.805000:        396 instructions:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [003] 6395040.805122:       2442       cycles:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [003] 6395040.805122:        396 instructions:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [004] 6395040.805241:       2208       cycles:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [004] 6395040.805241:        396 instructions:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [005] 6395040.805359:       2199       cycles:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [005] 6395040.805359:        396 instructions:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [006] 6395040.805479:       2269       cycles:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [006] 6395040.805479:        382 instructions:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [007] 6395040.805596:       2215       cycles:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [007] 6395040.805596:        396 instructions:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [008] 6395040.805715:       2258       cycles:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [008] 6395040.805715:        396 instructions:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [009] 6395040.805835:       2293       cycles:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [009] 6395040.805835:        396 instructions:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [010] 6395040.806013:       2159       cycles:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [010] 6395040.806013:        396 instructions:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
            perf 2061404 [011] 6395040.806121:       3058       cycles:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])


.... <lots more samples but no metrics for "perf" anymore"> 

There are some metrics for other processes, but I don't even know what logic it follows here
(as in what intervals actually get aggregated)

So yes maybe his implementation may be cleaner, but it simply doesn't solve the problem,
it implements something else.


-Andi



