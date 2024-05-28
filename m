Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2986816C85E
	for <linux-perf-users@vger.kernel.org>; Tue, 28 May 2024 11:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897437; cv=none; b=AWVd+aqKOrIHSd2VzGqyZrReAeX1Dm9e6ScGJ+tfmwOLPhkOsZd1q3lHatX/b8+yRtIHJSWoMmc8EPuKcVQ3y6YpXhQY3UyOxPG6HWuHsGSgAIBL0gNZ0fPvfW+7DhMZufAK5qmDTmbzGvpwYPFjtJNMnxWH7Jy1SsiViJi0xWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897437; c=relaxed/simple;
	bh=w7aldM16JHgcJeDQZB2/8l7sNkK7STVmVf2OHcFU4Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7qbDXacqhy4tQ54JrluMX0+wQvdYJ91ep/rhu8VSpF//rums+a6Iqe+FxiSMAw6NbO5T/TrgODq0uVUUOZufnw7yrn226uOGly9gHxMZZ0VMkNDlCB0Bd/UpYq2Z7IdIkRCq8YrAZ3oGAbow5QHcwXoRXoumPMftBPgJ6B/zC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BEW6InBs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BEW6InBs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716897432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SIJ8nojhETCDkAUUqhBd0573y1zDKmktkeIXW+mucrc=;
	b=BEW6InBsKkQpZD96BfYyDNIE/5uIR96MCSgKr5tIbwhmnDLucevzdJLzehLTrDuCwcJxmu
	sVM6bk1L4fvo9MarA3IfVtUC+d6cuzDiliNcB2yVAZH+tc5i+wQlWhV4aOECzdmyTt5bk7
	HIaqzcijNSLvNTcryL5qG3/37ojQUgU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-yZQmyO8MOM2g7Hj2GsF-Ig-1; Tue, 28 May 2024 07:57:08 -0400
X-MC-Unique: yZQmyO8MOM2g7Hj2GsF-Ig-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D8CA08058DF;
	Tue, 28 May 2024 11:57:07 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.45.224.59])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 660F840004D;
	Tue, 28 May 2024 11:57:05 +0000 (UTC)
Date: Tue, 28 May 2024 13:57:03 +0200
From: Artem Savkov <asavkov@redhat.com>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf record: add a shortcut for metrics
Message-ID: <20240528115703.GB449511@alecto.usersys.redhat.com>
References: <20240527101519.356342-1-asavkov@redhat.com>
 <ZlS8pc39t2c1WFye@x1>
 <ZlS9M1vcxZ3Qsx_B@x1>
 <ZlTCvelaGVb6lCia@x1>
 <ZlTG-kPuYUyHLQZ2@x1>
 <CAP-5=fWmmtagTVfacFZgdhughvU--Dz0=jkoqFB8CP1Qd3o3Yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWmmtagTVfacFZgdhughvU--Dz0=jkoqFB8CP1Qd3o3Yw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Mon, May 27, 2024 at 10:01:37PM -0700, Ian Rogers wrote:
> On Mon, May 27, 2024 at 10:46 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Mon, May 27, 2024 at 02:28:32PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Mon, May 27, 2024 at 02:04:54PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > On Mon, May 27, 2024 at 02:02:33PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > On Mon, May 27, 2024 at 12:15:19PM +0200, Artem Savkov wrote:
> > > > > > Add -M/--metrics option to perf-record providing a shortcut to record
> > > > > > metrics and metricgroups. This option mirrors the one in perf-stat.
> > >
> > > > > > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > > > Signed-off-by: Artem Savkov <asavkov@redhat.com>
> >
> > > How did you test this?
> >
> > > The idea, from my notes, was to be able to have extra columns in 'perf
> > > report' with things like IPC and other metrics, probably not all metrics
> > > will apply. We need to find a way to find out which ones are OK for that
> > > purpose, for instance:
> >
> > One that may make sense:
> >
> > root@number:~# perf record -M tma_fb_full
> > ^C[ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 3.846 MB perf.data (21745 samples) ]
> >
> > root@number:~# perf evlist
> > cpu_core/CPU_CLK_UNHALTED.THREAD/
> > cpu_core/L1D_PEND_MISS.FB_FULL/
> > dummy:u
> > root@number:~#
> >
> > But then we need to read both to do the math, maybe something like:
> >
> > root@number:~# perf record -e '{cpu_core/CPU_CLK_UNHALTED.THREAD/,cpu_core/L1D_PEND_MISS.FB_FULL/}:S'
> > ^C[ perf record: Woken up 40 times to write data ]
> > [ perf record: Captured and wrote 14.640 MB perf.data (219990 samples) ]
> >
> > root@number:~# perf script | head
> >     cc1plus 1339704 [000] 36028.995981:  2011389 cpu_core/CPU_CLK_UNHALTED.THREAD/:           1097303 [unknown] (/usr/libexec/gcc/x86_64-pc-linux-gnu/13/cc1plus)
> >     cc1plus 1339704 [000] 36028.995981:    26231   cpu_core/L1D_PEND_MISS.FB_FULL/:           1097303 [unknown] (/usr/libexec/gcc/x86_64-pc-linux-gnu/13/cc1plus)
> >     cc1plus 1340011 [001] 36028.996008:  2004568 cpu_core/CPU_CLK_UNHALTED.THREAD/:            8c23b4 [unknown] (/usr/libexec/gcc/x86_64-pc-linux-gnu/13/cc1plus)
> >     cc1plus 1340011 [001] 36028.996008:    20113   cpu_core/L1D_PEND_MISS.FB_FULL/:            8c23b4 [unknown] (/usr/libexec/gcc/x86_64-pc-linux-gnu/13/cc1plus)
> >       clang 1340462 [002] 36028.996043:  2007356 cpu_core/CPU_CLK_UNHALTED.THREAD/:  ffffffffb43b045d release_pages+0x3dd ([kernel.kallsyms])
> >       clang 1340462 [002] 36028.996043:    23481   cpu_core/L1D_PEND_MISS.FB_FULL/:  ffffffffb43b045d release_pages+0x3dd ([kernel.kallsyms])
> >     cc1plus 1339622 [003] 36028.996066:  2004148 cpu_core/CPU_CLK_UNHALTED.THREAD/:            760874 [unknown] (/usr/libexec/gcc/x86_64-pc-linux-gnu/13/cc1plus)
> >     cc1plus 1339622 [003] 36028.996066:    31935   cpu_core/L1D_PEND_MISS.FB_FULL/:            760874 [unknown] (/usr/libexec/gcc/x86_64-pc-linux-gnu/13/cc1plus)
> >          as 1340513 [004] 36028.996097:  2005052 cpu_core/CPU_CLK_UNHALTED.THREAD/:  ffffffffb4491d65 __count_memcg_events+0x55 ([kernel.kallsyms])
> >          as 1340513 [004] 36028.996097:    45084   cpu_core/L1D_PEND_MISS.FB_FULL/:  ffffffffb4491d65 __count_memcg_events+0x55 ([kernel.kallsyms])
> > root@number:~#
> >
> > root@number:~# perf report --stdio -F +period | head -20
> > # To display the perf.data header info, please use --header/--header-only options.
> > #
> > #
> > # Total Lost Samples: 0
> > #
> > # Samples: 219K of events 'anon group { cpu_core/CPU_CLK_UNHALTED.THREAD/, cpu_core/L1D_PEND_MISS.FB_FULL/ }'
> > # Event count (approx.): 216528524863
> > #
> > #         Overhead                Period  Command    Shared Object      Symbol
> > # ................  ....................  .........  .................  ....................................
> > #
> >      4.01%   1.09%  8538169256  39826572  podman     [kernel.kallsyms]  [k] native_queued_spin_lock_slowpath
> >      1.35%   1.17%  2863376078  42829266  cc1plus    cc1plus            [.] 0x00000000003f6bcc
> >      0.94%   0.78%  1990639149  28408591  cc1plus    cc1plus            [.] 0x00000000003f6be4
> >      0.65%   0.17%  1375916283   6109515  podman     [kernel.kallsyms]  [k] _raw_spin_lock_irqsave
> >      0.61%   0.99%  1304418325  36198834  cc1plus    [kernel.kallsyms]  [k] get_mem_cgroup_from_mm
> >      0.52%   0.42%  1103054030  15427418  cc1plus    cc1plus            [.] 0x0000000000ca6c69
> >      0.51%   0.17%  1094200572   6299289  podman     [kernel.kallsyms]  [k] psi_group_change
> >      0.42%   0.41%   893633315  14778675  cc1plus    cc1plus            [.] 0x00000000018afafe
> >      0.42%   1.29%   887664793  47046952  cc1plus    [kernel.kallsyms]  [k] asm_exc_page_fault
> > root@number:~#
> >
> > That 'tma_fb_full' metric then would be another column, calculated from
> > the sampled components of its metric equation:
> >
> > root@number:~# perf list tma_fb_full | head
> >
> > Metric Groups:
> >
> > MemoryBW: [Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet]
> >   tma_fb_full
> >        [This metric does a *rough estimation* of how often L1D Fill Buffer
> >         unavailability limited additional L1D miss memory access requests to
> >         proceed]
> >
> > TopdownL4: [Metrics for top-down breakdown at level 4]
> > root@number:~#
> >
> > This is roughly what we brainstormed, to support metrics in other tools
> > than 'perf stat' but we need to check the possibilities and limitations
> > of such an idea, hopefully this discussion will help with that,
>
> Putting metrics next to code in perf report/annotate sounds good to
> me, opening all events from a metric as if we want to sample on them
> less so.

The idea was to record whatever data was asked on record step and
provide the list of all metrics that can be calculated out of that data
in perf report, e.g. you could record tma_info_thread_ipc but report
will suggest both it and tma_info_thread_cpi.

> We don't have metrics working with `perf stat record`, I
> think Kan may have volunteered for that, but it seems like something
> more urgent than expanding `perf record`. Presumably the way the
> metric would be recorded for that could also benefit this effort.
>
> If you look at the tma metrics a number of them have a "Sample with".
> For example:
> ```
> $ perf list -v
> ...
>   tma_branch_mispredicts
>        [This metric represents fraction of slots the CPU has wasted
> due to Branch Misprediction.
>         These slots are either wasted by uops fetched from an
> incorrectly speculated program path;
>         or stalls when the out-of-order part of the machine needs to
> recover its state from a
>         speculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES.
> Related metrics:
>         tma_info_bad_spec_branch_misprediction_cost,tma_info_bottleneck_mispredictions,
>         tma_mispredicts_resteers]
> ...
> ```
> It could be logical for `perf record -M tma_branch_mispredicts ...` to
> be translated to `perf record -e BR_MISP_RETIRED.ALL_BRANCHES ...`
> rather than to do any form of counting.

Thanks for the pointer, I'll see how this could be done.

--
 Artem

