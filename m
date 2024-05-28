Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5C917E8E6
	for <linux-perf-users@vger.kernel.org>; Tue, 28 May 2024 05:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716872512; cv=none; b=k5dk3jqKu2cXCvOsa+njAPelfd0i90jNf6ZdzgfUAwBQ+k/jfYhrg2K70CCsHscNA8f43sYD0PFK77AE/0KEkbjv8fVKp/kNxZ9vvhjyGBXWYVVhpPiY0WmF2tpCsGoCJWtCSngEzg9OPd8w2ya+rxRIVIxWOU/eoZL3LOMJ/is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716872512; c=relaxed/simple;
	bh=M6E5Gfsb5W6qgTh8DwJyYW2wa3IYFd66YShPAJVtGQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tL+pU+5w3K9uYvEPHtWaELKbwhUojjswjwg2LaeQyl+fXPtvPB1f2YYDH7e1pIHNB6R3CzUCeLEVHL5zbgVIiO9vWXtC3lcC4Kk2p1hPZEfVG31xOH+A7mLXfrPxHq6s5dvM12maER+k428jmbjg0pcfohWJRaNNGDtFIUaV6vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gzL2S6QB; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gzL2S6QB"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36db330403fso464245ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 27 May 2024 22:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716872510; x=1717477310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShUs+ArefrGrwEvSZVGkTEEWh8oL8EkyheQUHFcH+8E=;
        b=gzL2S6QB+PTemENrctSSnv8HaPgP6HCnQcI+vMhrVbp/X54kS0ia/OqCLwn6d69Fam
         JIxhGNDv64YvCRlF9D75aPd8mZOhGHvZ8T9XmQ8dilczUnI1yjzknK2DI4ZCD4eD9Nt5
         8A83xZG3+D3CrcDTYYEn6VW/oMgTsDxZOnH+LHLuxEaMnjIeETrRjFMjo9hvukNSL+Tn
         ASuZpZ31gsRzNYJDid/LBIi6wY4b63C8eWL+X3s7DEmYbg7cRvOTmkr3Vunra7C9LsIQ
         0L9P1s0G8DxC/CV4WdGTveWGlkydrvN798353CrXfcXf0u5lxVGnM3fUx10D/bDp3Aer
         RWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716872510; x=1717477310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShUs+ArefrGrwEvSZVGkTEEWh8oL8EkyheQUHFcH+8E=;
        b=nL8MU3YmZIdon0q2ZGl9EEAANVlwl8NtWT9c/gd+3B42bdus5VLMGfMeWxZKEtm6zH
         vAvv01OrMJ2uIKzmswOkJArWZqRxcllD6oGkfoXAvMO3H+gcQNl5UVGAg8DIIevQ+pTv
         7nDwOYQmKGsZT4pvdB1DwsD5GUfqZOeTjTX90mx2KA21L34vtN03VTQrz6xyvxggw1uC
         OpYtVXVYb9k2+Ggs2ym0WZsnP2TO1Xm6GmZLzs31SpXEUjBSsrS6kmvIpqXKL3pitlaS
         FBt6G5ChJP3KIU9OeNthA2CUMme+1VLVr8a7foyLdCJh/Cj8K+RrR9OkBW7/fOvHZEWN
         SrRg==
X-Forwarded-Encrypted: i=1; AJvYcCWS4yHxI9DwZLfy13gT9CYs54It73v0ZV4++YUTyUFC/RGN9jTFU5t+ObzeVDhe6evmiXZ4CNmxXwokhOT2Dhe3ZNbJHKP/Uq1GVSkOU4US6A==
X-Gm-Message-State: AOJu0YycD9sUbsYfO9C+W4Q1TG1xtEJdZjqJD7ukbCkkOGT6pEDdAHE3
	j8DBbSie1WOnXZ6uPhhYq5IkZ/L75idarIuv5aQgwD+Oix2kbdwnTyvb5h2WkfY9k0cm2ctDrcJ
	uXhX9b58V/+2zlMem85z35GAil/B8XoxZwOYq
X-Google-Smtp-Source: AGHT+IHzuK0DpTm+IHMW/fXweRop4RIIBFY7ksq2++/ACr/WM36rftETw5LPH8Fv4zSFX8Fvr4VCxBjBV2xADJf++JM=
X-Received: by 2002:a05:6e02:552:b0:36d:c1a1:b586 with SMTP id
 e9e14a558f8ab-3738a7331demr5378095ab.10.1716872510129; Mon, 27 May 2024
 22:01:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527101519.356342-1-asavkov@redhat.com> <ZlS8pc39t2c1WFye@x1>
 <ZlS9M1vcxZ3Qsx_B@x1> <ZlTCvelaGVb6lCia@x1> <ZlTG-kPuYUyHLQZ2@x1>
In-Reply-To: <ZlTG-kPuYUyHLQZ2@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 27 May 2024 22:01:37 -0700
Message-ID: <CAP-5=fWmmtagTVfacFZgdhughvU--Dz0=jkoqFB8CP1Qd3o3Yw@mail.gmail.com>
Subject: Re: [PATCH] perf record: add a shortcut for metrics
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Artem Savkov <asavkov@redhat.com>, linux-perf-users@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 10:46=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, May 27, 2024 at 02:28:32PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, May 27, 2024 at 02:04:54PM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > On Mon, May 27, 2024 at 02:02:33PM -0300, Arnaldo Carvalho de Melo wr=
ote:
> > > > On Mon, May 27, 2024 at 12:15:19PM +0200, Artem Savkov wrote:
> > > > > Add -M/--metrics option to perf-record providing a shortcut to re=
cord
> > > > > metrics and metricgroups. This option mirrors the one in perf-sta=
t.
> >
> > > > > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > > Signed-off-by: Artem Savkov <asavkov@redhat.com>
>
> > How did you test this?
>
> > The idea, from my notes, was to be able to have extra columns in 'perf
> > report' with things like IPC and other metrics, probably not all metric=
s
> > will apply. We need to find a way to find out which ones are OK for tha=
t
> > purpose, for instance:
>
> One that may make sense:
>
> root@number:~# perf record -M tma_fb_full
> ^C[ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 3.846 MB perf.data (21745 samples) ]
>
> root@number:~# perf evlist
> cpu_core/CPU_CLK_UNHALTED.THREAD/
> cpu_core/L1D_PEND_MISS.FB_FULL/
> dummy:u
> root@number:~#
>
> But then we need to read both to do the math, maybe something like:
>
> root@number:~# perf record -e '{cpu_core/CPU_CLK_UNHALTED.THREAD/,cpu_cor=
e/L1D_PEND_MISS.FB_FULL/}:S'
> ^C[ perf record: Woken up 40 times to write data ]
> [ perf record: Captured and wrote 14.640 MB perf.data (219990 samples) ]
>
> root@number:~# perf script | head
>     cc1plus 1339704 [000] 36028.995981:  2011389 cpu_core/CPU_CLK_UNHALTE=
D.THREAD/:           1097303 [unknown] (/usr/libexec/gcc/x86_64-pc-linux-gn=
u/13/cc1plus)
>     cc1plus 1339704 [000] 36028.995981:    26231   cpu_core/L1D_PEND_MISS=
.FB_FULL/:           1097303 [unknown] (/usr/libexec/gcc/x86_64-pc-linux-gn=
u/13/cc1plus)
>     cc1plus 1340011 [001] 36028.996008:  2004568 cpu_core/CPU_CLK_UNHALTE=
D.THREAD/:            8c23b4 [unknown] (/usr/libexec/gcc/x86_64-pc-linux-gn=
u/13/cc1plus)
>     cc1plus 1340011 [001] 36028.996008:    20113   cpu_core/L1D_PEND_MISS=
.FB_FULL/:            8c23b4 [unknown] (/usr/libexec/gcc/x86_64-pc-linux-gn=
u/13/cc1plus)
>       clang 1340462 [002] 36028.996043:  2007356 cpu_core/CPU_CLK_UNHALTE=
D.THREAD/:  ffffffffb43b045d release_pages+0x3dd ([kernel.kallsyms])
>       clang 1340462 [002] 36028.996043:    23481   cpu_core/L1D_PEND_MISS=
.FB_FULL/:  ffffffffb43b045d release_pages+0x3dd ([kernel.kallsyms])
>     cc1plus 1339622 [003] 36028.996066:  2004148 cpu_core/CPU_CLK_UNHALTE=
D.THREAD/:            760874 [unknown] (/usr/libexec/gcc/x86_64-pc-linux-gn=
u/13/cc1plus)
>     cc1plus 1339622 [003] 36028.996066:    31935   cpu_core/L1D_PEND_MISS=
.FB_FULL/:            760874 [unknown] (/usr/libexec/gcc/x86_64-pc-linux-gn=
u/13/cc1plus)
>          as 1340513 [004] 36028.996097:  2005052 cpu_core/CPU_CLK_UNHALTE=
D.THREAD/:  ffffffffb4491d65 __count_memcg_events+0x55 ([kernel.kallsyms])
>          as 1340513 [004] 36028.996097:    45084   cpu_core/L1D_PEND_MISS=
.FB_FULL/:  ffffffffb4491d65 __count_memcg_events+0x55 ([kernel.kallsyms])
> root@number:~#
>
> root@number:~# perf report --stdio -F +period | head -20
> # To display the perf.data header info, please use --header/--header-only=
 options.
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 219K of events 'anon group { cpu_core/CPU_CLK_UNHALTED.THREAD/=
, cpu_core/L1D_PEND_MISS.FB_FULL/ }'
> # Event count (approx.): 216528524863
> #
> #         Overhead                Period  Command    Shared Object      S=
ymbol
> # ................  ....................  .........  .................  .=
...................................
> #
>      4.01%   1.09%  8538169256  39826572  podman     [kernel.kallsyms]  [=
k] native_queued_spin_lock_slowpath
>      1.35%   1.17%  2863376078  42829266  cc1plus    cc1plus            [=
.] 0x00000000003f6bcc
>      0.94%   0.78%  1990639149  28408591  cc1plus    cc1plus            [=
.] 0x00000000003f6be4
>      0.65%   0.17%  1375916283   6109515  podman     [kernel.kallsyms]  [=
k] _raw_spin_lock_irqsave
>      0.61%   0.99%  1304418325  36198834  cc1plus    [kernel.kallsyms]  [=
k] get_mem_cgroup_from_mm
>      0.52%   0.42%  1103054030  15427418  cc1plus    cc1plus            [=
.] 0x0000000000ca6c69
>      0.51%   0.17%  1094200572   6299289  podman     [kernel.kallsyms]  [=
k] psi_group_change
>      0.42%   0.41%   893633315  14778675  cc1plus    cc1plus            [=
.] 0x00000000018afafe
>      0.42%   1.29%   887664793  47046952  cc1plus    [kernel.kallsyms]  [=
k] asm_exc_page_fault
> root@number:~#
>
> That 'tma_fb_full' metric then would be another column, calculated from
> the sampled components of its metric equation:
>
> root@number:~# perf list tma_fb_full | head
>
> Metric Groups:
>
> MemoryBW: [Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet]
>   tma_fb_full
>        [This metric does a *rough estimation* of how often L1D Fill Buffe=
r
>         unavailability limited additional L1D miss memory access requests=
 to
>         proceed]
>
> TopdownL4: [Metrics for top-down breakdown at level 4]
> root@number:~#
>
> This is roughly what we brainstormed, to support metrics in other tools
> than 'perf stat' but we need to check the possibilities and limitations
> of such an idea, hopefully this discussion will help with that,

Putting metrics next to code in perf report/annotate sounds good to
me, opening all events from a metric as if we want to sample on them
less so. We don't have metrics working with `perf stat record`, I
think Kan may have volunteered for that, but it seems like something
more urgent than expanding `perf record`. Presumably the way the
metric would be recorded for that could also benefit this effort.

If you look at the tma metrics a number of them have a "Sample with".
For example:
```
$ perf list -v
...
  tma_branch_mispredicts
       [This metric represents fraction of slots the CPU has wasted
due to Branch Misprediction.
        These slots are either wasted by uops fetched from an
incorrectly speculated program path;
        or stalls when the out-of-order part of the machine needs to
recover its state from a
        speculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES.
Related metrics:
        tma_info_bad_spec_branch_misprediction_cost,tma_info_bottleneck_mis=
predictions,
        tma_mispredicts_resteers]
...
```
It could be logical for `perf record -M tma_branch_mispredicts ...` to
be translated to `perf record -e BR_MISP_RETIRED.ALL_BRANCHES ...`
rather than to do any form of counting.

Thanks,
Ian
