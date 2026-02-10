Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28A63EBF1A;
	Tue, 10 Feb 2026 01:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770686288; cv=none; b=NJC6UQOktDVsmd81zrrGS9clZa6vKfFERP+g+5n+FIOTSbjFX3xZfnv7SgKEmbuQAfwjRTxWk4cqCqST57y2sgSmRpF3uv16eaRIPbS+Omj6xVTutjuyYV8AwIAb2sxF/iRhAsNy+gd0u4tQ+0lPPNN4AkwRVoZ8cn+9snfD5cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770686288; c=relaxed/simple;
	bh=kgevp4Vfh69dFy2iaiyqDXN56ya/OPL65CeQtlz7eOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcXluKKr8eMm55j7IXVHhC8qA9ISnUx24Np2HX1zc/v50d26SePhqxcAPvyXON8WDd1fpDHqH+vsMp8eFXlcUXoOYGOTutrsZW/uQoDpf4r/Jd0WFhWR1Nc85zqJvqoPurIpM+SgtD/UHiTgjr2TcKJUDClgI6xje1UmL4ImWz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCE0nuv2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCE0nuv2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6161C116C6;
	Tue, 10 Feb 2026 01:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770686287;
	bh=kgevp4Vfh69dFy2iaiyqDXN56ya/OPL65CeQtlz7eOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BCE0nuv26ERIquCeBkvV9J9LKWiQoa1XjS9opKKgPb/CWdMIwHBke1RsMShvjUulA
	 z6adhyFc71XqmMdOONp03vOZZype24IkqVFfhCIQabajx4B1TCNvO/iI632G7mxxqD
	 l+QmSkGyrZoEFSqxFegZJx/JiMfmJOMsl0wZt5to9jucbSfoNkgovRVtaWEYOU+qHA
	 IbIjB1u+WpKB17aFLA7GPGrYJ45WVOtUPtiGzBZ0vpeIE/Hsjn2dz6nitjPuSD0WDS
	 DizlTMDfnfeg18shPLhGNJ2a76z08CNBx0lxvNieLsfyM+C9NvMisPpkasDWv8K/D5
	 KUmzd4pzMZXhw==
Date: Mon, 9 Feb 2026 17:18:05 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, adrian.hunter@intel.com,
	ak@linux.intel.com, alexander.shishkin@linux.intel.com,
	andres@anarazel.de, dapeng1.mi@linux.intel.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux@treblig.org, mingo@redhat.com, peterz@infradead.org,
	thomas.falcon@intel.com, tmricht@linux.ibm.com,
	yang.lee@linux.alibaba.com
Subject: Re: [PATCH v8 6/6] perf stat: Add no-affinity flag
Message-ID: <aYqHTfCoW1bGmJF4@google.com>
References: <aYZnkYqWXnKpHd3h@x1>
 <20260206222509.982489-1-irogers@google.com>
 <20260206222509.982489-7-irogers@google.com>
 <aYc1NrEYIMxKzlCF@x1>
 <CAP-5=fXOasXgKRSvrA1B+Yx42egfZfLO4h1OKrB4tLCCz_o8Cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXOasXgKRSvrA1B+Yx42egfZfLO4h1OKrB4tLCCz_o8Cg@mail.gmail.com>

On Sat, Feb 07, 2026 at 07:54:05AM -0800, Ian Rogers wrote:
> On Sat, Feb 7, 2026 at 4:51 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > On Fri, Feb 06, 2026 at 02:25:09PM -0800, Ian Rogers wrote:
> > > Add flag that disables affinity behavior. Using sched_setaffinity to
> > > place a perf thread on a CPU can avoid certain interprocessor
> > > interrupts but may introduce a delay due to the scheduling,
> > > particularly on loaded machines. Add a command line option to disable
> > > the behavior. This behavior is less present in other tools like `perf
> > > record`, as it uses a ring buffer and doesn't make repeated system
> > > calls.
> >
> > This is confusing:
> >
> > ⬢ [acme@toolbx perf-tools-next]$ perf stat -h affinity
> >
> >  Usage: perf stat [<options>] [<command>]
> >
> >         --affinity        don't allow affinity optimizations aimed at reducing IPIs
> >
> > ⬢ [acme@toolbx perf-tools-next]$
> >
> > The way it is presented in the -h output it looks as if one has to use:
> >
> >         perf stat --affinity
> >
> > To disable affinity setting, when used that way it looks as if the user
> > is asking for affinity to be used.
> >
> > We have things like:
> >
> > ⬢ [acme@toolbx perf-tools-next]$ grep -A2 OPT_.*no- tools/perf/builtin-record.c
> >         OPT_BOOLEAN(0, "no-buffering", &record.opts.no_buffering,
> >                     "collect data without buffering"),
> >         OPT_BOOLEAN('R', "raw-samples", &record.opts.raw_samples,
> > --
> >         OPT_BOOLEAN_SET('i', "no-inherit", &record.opts.no_inherit,
> >                         &record.opts.no_inherit_set,
> >                         "child tasks do not inherit counters"),
> > --
> >         OPT_BOOLEAN(0, "no-bpf-event", &record.opts.no_bpf_event, "do not record bpf events"),
> >         OPT_BOOLEAN(0, "strict-freq", &record.opts.strict_freq,
> >                     "Fail if the specified frequency can't be used"),
> > --
> >         OPT_BOOLEAN('n', "no-samples", &record.opts.no_samples,
> >                     "don't sample"),
> >         OPT_BOOLEAN_SET('N', "no-buildid-cache", &record.no_buildid_cache,
> >                         &record.no_buildid_cache_set,
> >                         "do not update the buildid cache"),
> >         OPT_BOOLEAN_SET('B', "no-buildid", &record.no_buildid,
> >                         &record.no_buildid_set,
> >                         "do not collect buildids in perf.data"),
> > ⬢ [acme@toolbx perf-tools-next]$
> >
> > Probably this needs to be that way?
> 
> So it was that way in the v4 patch set but Namhyung asked for it to be
> the other way around:
> https://lore.kernel.org/lkml/aRvcuMfbDRSBU87k@google.com/
> The comment on the option didn't get changed and that's a  mistake.
> Let me know what's preferred and I can send a patch.

Right, I still prefer positive option names so that "--no-" prefix can
be added.

Thanks,
Namhyung

