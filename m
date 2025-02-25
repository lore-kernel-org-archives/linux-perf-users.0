Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5AE25B660;
	Tue, 25 Feb 2025 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740469898; cv=none; b=uouEbM7epIFJB2ngsXZvw221Ak7N1iG4GJarW9SbAhp1EupyHVDdGMoDvuAJf3QiOsm9iHsrG+P74hO1p2wF1QwcsOYuRzPz2geSkknRn/1mPa85KwwR4oTXOImYSxLXH3ouzTPVYv2UyvnvBccTpgkf2j8KkP6dHvRdWVBAaX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740469898; c=relaxed/simple;
	bh=IdIHFTJJBzhkWz8ONeGPdv4DAah1gj/Jkggn2Po/AzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7HlrtB7xOJiyW0Zez42N3sUJSgvuue4y48LeUtSaO3/cTv9Wszzf71za6yrTHPUaH39lPA/TIKviKy/94BveBn1Xw1ICCRWy9/NeMeFuvSWsV6/NKZnlmd5rP8f+Jd1i+YQwN/EkIqdoXYPh/Wc369reXgGsQR8GEi4JxJdagI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKIU2V+/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKIU2V+/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B36C4CEDD;
	Tue, 25 Feb 2025 07:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740469898;
	bh=IdIHFTJJBzhkWz8ONeGPdv4DAah1gj/Jkggn2Po/AzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AKIU2V+/suEnAUq64o+SVyAoJgaexC2/nWZIya8okzIj5BfLr33wZW43XHROgYkRT
	 naH+vLcAtAqtPR5YGoOpSs+YrWxm20rXFPMOWJsE/MVoFl6EdwqegliWkMgfaRD/Qe
	 NeIL5TPYkY9SpMvaABRvZXO6Pt7UbX5Dso4lUv56KJycr5JBjg66bgMuYv5pwMOfHS
	 XrnkdgNFGSc/CF5cV6Z02kRvraw0fQx03kLNjarfIzsklO2iBZdXONJLwTjzsyBLBf
	 UKGv/vuM9tze6uaf6VC29mt3aqj8IdwgnU8SdxqrIznrOJR2PE32ZhURSqBrastpGd
	 Jl6goZIsjyJmQ==
Date: Mon, 24 Feb 2025 23:51:35 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf report: Add 'tgid' sort key
Message-ID: <Z712hzvv22Ni63f1@google.com>
References: <Z7T1LVSLo8EEMmkM@x1>
 <Z7UDlZKnqXRqNqQa@google.com>
 <Z7XsltyqUWrdKma0@x1>
 <Z7XvEFEZtCRZKG7Y@x1>
 <Z7ZIqpwffQbibwL2@google.com>
 <CAP-5=fWZXPjD3Ok5XmMwwaYt+9mL+V8t8fNSUdf-F5PPiEAvrg@mail.gmail.com>
 <Z7gllQZeg6U2OvZE@google.com>
 <CAP-5=fXEEMFgPF2aZhKsfrY_En+qoqX20dWfuE_ad73Uxf0ZHQ@mail.gmail.com>
 <Z70wHEl6Sp0H0c-3@google.com>
 <CAP-5=fUosOVUKi5tQ3gVtHhfApk0oH3r2zHDW7-i+_qASKm+Cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUosOVUKi5tQ3gVtHhfApk0oH3r2zHDW7-i+_qASKm+Cg@mail.gmail.com>

On Mon, Feb 24, 2025 at 08:40:37PM -0800, Ian Rogers wrote:
> On Mon, Feb 24, 2025 at 6:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > On Mon, Feb 24, 2025 at 10:18:37AM -0800, Ian Rogers wrote:
[SNIP]
> > > I thought the real-time processing had to use
> > > maps__fixup_overlap_and_insert (rather than maps__insert) as mmap
> > > events only give us VMA data and two mmaps may have been merged.
> > > Shouldn't doing this change be the simplest fix?
> >
> > Make sense.  How about this?
> 
> Lgtm, I have no way to test the issue. Why does maps__fixup_end need
> to get pushed later?

I just noticed it would add extra kernel maps after modules.  I think it
should fixup end address of the kernel maps after adding all maps first.

Arnaldo, can you please test this?

Thanks,
Namhyung

> 
> Thanks,
> Ian
> 
> > Thanks,
> > Namhyung
> >
> >
> > ---8<---
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index 316f0879e5e08d66..d80b34717090db44 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -717,7 +717,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
> >
> >                 map__set_start(map, event->ksymbol.addr);
> >                 map__set_end(map, map__start(map) + event->ksymbol.len);
> > -               err = maps__insert(machine__kernel_maps(machine), map);
> > +               err = maps__fixup_overlap_and_insert(machine__kernel_maps(machine), map);
> >                 if (err) {
> >                         err = -ENOMEM;
> >                         goto out;
> > @@ -1459,8 +1459,6 @@ static int machine__create_modules(struct machine *machine)
> >         if (modules__parse(modules, machine, machine__create_module))
> >                 return -1;
> >
> > -       maps__fixup_end(machine__kernel_maps(machine));
> > -
> >         if (!machine__set_modules_path(machine))
> >                 return 0;
> >
> > @@ -1554,6 +1552,8 @@ int machine__create_kernel_maps(struct machine *machine)
> >                 }
> >         }
> >
> > +       maps__fixup_end(machine__kernel_maps(machine));
> > +
> >  out_put:
> >         dso__put(kernel);
> >         return ret;
