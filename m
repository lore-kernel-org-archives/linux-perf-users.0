Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3372A1D8;
	Mon, 27 May 2024 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716831997; cv=none; b=KahQ3aaOBBjvrAWrvIt0tbI8UTqTuKmKP6Gufja1VPpjm+rm4jT6nzfThJ3UAB5X18o5zN+oc3unlG3yxNgQ/oq7ng818fdQ9k7MgPuB3V0SgFCpbFXZnGt8JlzqSkVVvwlAbUxR/TksD9rnzK+MCBCrcGhhwii+CGz6EStoPOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716831997; c=relaxed/simple;
	bh=jjEgkcM+R5xMiaHfw6EilFEbMrSIF3kmdYD9AfNHiIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEo08LwWEzpnKR2E8wm0wFgBG/a7oIgT+f5bgFHfTy3fxsKjZRGnSpLu3UPMjjHeSCndUi2idJAACQOZmygIRx56EWToYzvkIw3iRcLDbcmOMCPSdRSDIRDsc05sTTg9X/uZDB9qFaiqtLI3WYrehjNLP7lsZWLZgyjWknmBXAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/zm/ANO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/zm/ANO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97988C2BBFC;
	Mon, 27 May 2024 17:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716831997;
	bh=jjEgkcM+R5xMiaHfw6EilFEbMrSIF3kmdYD9AfNHiIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F/zm/ANOQpIjbkDwWVvwBlt/B+p694Hpu+h4/3xc7MbmC43ZOBem59DFkH2VkhMSc
	 P+EVOAXQx4O0+kbyTX50O94PsfZwxfD0FYYTyThrNsCrXUUW4AvNm5hpffz+QKlxwF
	 uCqNcLV8sRjY+GHhcwzZwdI0toINBIPRNCsuLKDdIrHV5omWmyTGal+qoYmVrekwM0
	 45aBUxkDrddsgEJD0bJ2e/1D/pzya82YxQOOmOmKS+6flT50N2IxlRyKPXow10gOBd
	 c+e2u5LrZ77+UxWuH2Fe4px9nuTA5tYxDqpkYcmvCXDOMmIqJ8iWaNoMqrcOFIobRg
	 mYp7jHr0Iys3g==
Date: Mon, 27 May 2024 14:46:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Artem Savkov <asavkov@redhat.com>, Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf record: add a shortcut for metrics
Message-ID: <ZlTG-kPuYUyHLQZ2@x1>
References: <20240527101519.356342-1-asavkov@redhat.com>
 <ZlS8pc39t2c1WFye@x1>
 <ZlS9M1vcxZ3Qsx_B@x1>
 <ZlTCvelaGVb6lCia@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlTCvelaGVb6lCia@x1>

On Mon, May 27, 2024 at 02:28:32PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, May 27, 2024 at 02:04:54PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, May 27, 2024 at 02:02:33PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Mon, May 27, 2024 at 12:15:19PM +0200, Artem Savkov wrote:
> > > > Add -M/--metrics option to perf-record providing a shortcut to record
> > > > metrics and metricgroups. This option mirrors the one in perf-stat.
> 
> > > > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > Signed-off-by: Artem Savkov <asavkov@redhat.com>

> How did you test this?

> The idea, from my notes, was to be able to have extra columns in 'perf
> report' with things like IPC and other metrics, probably not all metrics
> will apply. We need to find a way to find out which ones are OK for that
> purpose, for instance:

One that may make sense:

root@number:~# perf record -M tma_fb_full
^C[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 3.846 MB perf.data (21745 samples) ]

root@number:~# perf evlist 
cpu_core/CPU_CLK_UNHALTED.THREAD/
cpu_core/L1D_PEND_MISS.FB_FULL/
dummy:u
root@number:~#

But then we need to read both to do the math, maybe something like:

root@number:~# perf record -e '{cpu_core/CPU_CLK_UNHALTED.THREAD/,cpu_core/L1D_PEND_MISS.FB_FULL/}:S'
^C[ perf record: Woken up 40 times to write data ]
[ perf record: Captured and wrote 14.640 MB perf.data (219990 samples) ]

root@number:~# perf script | head
    cc1plus 1339704 [000] 36028.995981:  2011389 cpu_core/CPU_CLK_UNHALTED.THREAD/:           1097303 [unknown] (/usr/libexec/gcc/x86_64-pc-linux-gnu/13/cc1plus)
    cc1plus 1339704 [000] 36028.995981:    26231   cpu_core/L1D_PEND_MISS.FB_FULL/:           1097303 [unknown] (/usr/libexec/gcc/x86_64-pc-linux-gnu/13/cc1plus)
    cc1plus 1340011 [001] 36028.996008:  2004568 cpu_core/CPU_CLK_UNHALTED.THREAD/:            8c23b4 [unknown] (/usr/libexec/gcc/x86_64-pc-linux-gnu/13/cc1plus)
    cc1plus 1340011 [001] 36028.996008:    20113   cpu_core/L1D_PEND_MISS.FB_FULL/:            8c23b4 [unknown] (/usr/libexec/gcc/x86_64-pc-linux-gnu/13/cc1plus)
      clang 1340462 [002] 36028.996043:  2007356 cpu_core/CPU_CLK_UNHALTED.THREAD/:  ffffffffb43b045d release_pages+0x3dd ([kernel.kallsyms])
      clang 1340462 [002] 36028.996043:    23481   cpu_core/L1D_PEND_MISS.FB_FULL/:  ffffffffb43b045d release_pages+0x3dd ([kernel.kallsyms])
    cc1plus 1339622 [003] 36028.996066:  2004148 cpu_core/CPU_CLK_UNHALTED.THREAD/:            760874 [unknown] (/usr/libexec/gcc/x86_64-pc-linux-gnu/13/cc1plus)
    cc1plus 1339622 [003] 36028.996066:    31935   cpu_core/L1D_PEND_MISS.FB_FULL/:            760874 [unknown] (/usr/libexec/gcc/x86_64-pc-linux-gnu/13/cc1plus)
         as 1340513 [004] 36028.996097:  2005052 cpu_core/CPU_CLK_UNHALTED.THREAD/:  ffffffffb4491d65 __count_memcg_events+0x55 ([kernel.kallsyms])
         as 1340513 [004] 36028.996097:    45084   cpu_core/L1D_PEND_MISS.FB_FULL/:  ffffffffb4491d65 __count_memcg_events+0x55 ([kernel.kallsyms])
root@number:~# 

root@number:~# perf report --stdio -F +period | head -20
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 219K of events 'anon group { cpu_core/CPU_CLK_UNHALTED.THREAD/, cpu_core/L1D_PEND_MISS.FB_FULL/ }'
# Event count (approx.): 216528524863
#
#         Overhead                Period  Command    Shared Object      Symbol
# ................  ....................  .........  .................  ....................................
#
     4.01%   1.09%  8538169256  39826572  podman     [kernel.kallsyms]  [k] native_queued_spin_lock_slowpath
     1.35%   1.17%  2863376078  42829266  cc1plus    cc1plus            [.] 0x00000000003f6bcc
     0.94%   0.78%  1990639149  28408591  cc1plus    cc1plus            [.] 0x00000000003f6be4
     0.65%   0.17%  1375916283   6109515  podman     [kernel.kallsyms]  [k] _raw_spin_lock_irqsave
     0.61%   0.99%  1304418325  36198834  cc1plus    [kernel.kallsyms]  [k] get_mem_cgroup_from_mm
     0.52%   0.42%  1103054030  15427418  cc1plus    cc1plus            [.] 0x0000000000ca6c69
     0.51%   0.17%  1094200572   6299289  podman     [kernel.kallsyms]  [k] psi_group_change
     0.42%   0.41%   893633315  14778675  cc1plus    cc1plus            [.] 0x00000000018afafe
     0.42%   1.29%   887664793  47046952  cc1plus    [kernel.kallsyms]  [k] asm_exc_page_fault
root@number:~#

That 'tma_fb_full' metric then would be another column, calculated from
the sampled components of its metric equation:

root@number:~# perf list tma_fb_full | head

Metric Groups:

MemoryBW: [Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet]
  tma_fb_full
       [This metric does a *rough estimation* of how often L1D Fill Buffer
        unavailability limited additional L1D miss memory access requests to
        proceed]

TopdownL4: [Metrics for top-down breakdown at level 4]
root@number:~#

This is roughly what we brainstormed, to support metrics in other tools
than 'perf stat' but we need to check the possibilities and limitations
of such an idea, hopefully this discussion will help with that,

- Arnaldo
