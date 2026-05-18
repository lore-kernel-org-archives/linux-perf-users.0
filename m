Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E740231A23;
	Mon, 18 May 2026 01:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779068476; cv=none; b=BkkIexUXuhK10jzsMETllEuJtMu7nI3O5JRbIA25D8NPbyyRP9bXvrXADV/qQf5ecwb/0C7LKy81TTkzVfWX6hYq4lFyn//70tD2MXfXPhcv2Wpm/LkV3U6N/9K/B42fvd6qsfRjK2GmDQcEPihcsi4Qne2ogaNaZ5X3fQ+3cdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779068476; c=relaxed/simple;
	bh=Ao/4UW0V/N03Ok/KtoGDeo454SJuQ6jSFMg7+Zkej8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9eaJ3QsrNvj3iwUCgAC/V1YfA8a5g2sw2s1U5knUkHdLuzFhlGsLSW4ZRDtd9ZLAo8kvBHm97PZAS/AvE3xV1JLn+y5GCDiTBrZsWy4LojYb+UVBhuHt8GWMXkydiZ4k02y8eclML3lkGzKLUgyJ2+Pp51xyuZ5a3v1vyvmios=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7UZFNat; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7UZFNat"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23967C2BCB0;
	Mon, 18 May 2026 01:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779068476;
	bh=Ao/4UW0V/N03Ok/KtoGDeo454SJuQ6jSFMg7+Zkej8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W7UZFNatdkAO6TyzLDY5hbxKginRpscbt3ke1b4M7WN28jCkcAJUKgU+6Gvqivavx
	 EhsxeGtsibIsuPqz+WE0DO1Mm+ezcHcb1j3NGvZHVfLWidpQiokrepfwCWwhBVvkB9
	 SwYsfR924qDRdBe+bopVJLLSkWh0Rv9K4CPiuqqnmxNvOjFPogt4JHPW6f9MjRzcHD
	 8fwPhtdkY5e1QVq+vJKJpFp+ml+J7+1IR34UJfwC/pZ5LwOfr7g+QrT8zX0s/e6qKX
	 azlBzB03SRBozR5PMKii+Uny5CP25ny5MWDmt/MOk80tbIGLSkhhtihOhXYPAo3ciF
	 0Fc91wmfEC0jg==
Date: Sun, 17 May 2026 18:41:14 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v5 10/14] perf pmu-events: Split big_c_string storage
 into standalone compilation unit
Message-ID: <agpuOvZvo_HNnYsr@z2>
References: <20260515193314.1593560-11-irogers@google.com>
 <20260515195854.1A3C0C2BCB0@smtp.kernel.org>
 <CAP-5=fXM_bGY8uiVa-U9SiFrwY+Dxkrt=s66dfoL9YR7=14Edg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXM_bGY8uiVa-U9SiFrwY+Dxkrt=s66dfoL9YR7=14Edg@mail.gmail.com>

On Fri, May 15, 2026 at 04:25:29PM -0700, Ian Rogers wrote:
> On Fri, May 15, 2026 at 12:58 PM <sashiko-bot@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Medium] Incremental build breakage and partial clean failure due to Makefile dependency chaining and Python file closing order.
> > --
> >
> > commit 6c014984ddc9092cbb7ef975a3904baefa427ed5
> > Author: Ian Rogers <irogers@google.com>
> >
> > perf pmu-events: Split big_c_string storage into standalone compilation unit
> >
> > This commit splits the large big_c_string literal into a dedicated
> > pmu-events-string.c file to allow parallel compilation during Kbuild.
> > It updates jevents.py to output both files and adjusts the Makefile
> > dependencies to ensure jevents.py is only executed once.
> >
> > > In jevents.py, defer closing output_string_file until
> > > the absolute tail of main() to guarantee identical modification timestamps
> > > with output_file, preventing redundant rebuilds during incremental runs.
> >
> > Is this guarantee accurate? Since output_file is never explicitly closed
> > in main(), it gets flushed and closed automatically during Python
> > interpreter shutdown, strictly after main() returns.
> >
> > Will this result in pmu-events.c having a slightly newer modification
> > timestamp than pmu-events-string.c on filesystems with nanosecond
> > resolution?
> 
> So previously we were worried about the opposite scenario. Using &:
> for a group of generated files solves the problem but Linux builds
> only require GNU make 4.0 not 4.3, which added this group construct.
> We may need to drop this change as I don't see a way to satisfy
> Sashiko.
 
Isn't the message at the end a proposed solution by Sashiko to satisfy
the problem?  See below ...


> > > diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> > > --- a/tools/perf/pmu-events/Build
> > > +++ b/tools/perf/pmu-events/Build
> >
> > [ ... ]
> >
> > > @@ -224,6 +234,10 @@ endif
> > >  # and inputs are dependencies.
> > >  $(PMU_EVENTS_C): $(JEVENTS_DEPS)
> > >       $(call rule_mkdir)
> > > -     $(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) $(OUT_DIR) $@
> > > +     $(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) \
> > > +            $(OUT_DIR) $(PMU_EVENTS_C) $(PMU_EVENTS_STRING_C)
> > > +
> > > +$(PMU_EVENTS_STRING_C): $(PMU_EVENTS_C)
> > > +     @:
> >
> > If pmu-events.c consistently ends up newer than pmu-events-string.c
> > due to the Python teardown order, won't Make permanently see
> > pmu-events-string.c as out-of-date?
> >
> > Could this silently trigger redundant recompilations of pmu-events-string.o
> > and relinking of perf on every incremental build?
> >
> > Additionally, if pmu-events-string.c is deleted while pmu-events.c
> > remains up-to-date, Make will execute this dummy recipe and then attempt
> > to compile a missing file. Does this pattern handle partial cleanups
> > gracefully without creating a build regression?
> >
> > > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> > > --- a/tools/perf/pmu-events/jevents.py
> > > +++ b/tools/perf/pmu-events/jevents.py
> >
> > [ ... ]
> >
> > > @@ -1476,6 +1488,8 @@ struct pmu_table_entry {
> > >    print_mapping_table(archs)
> > >    print_system_mapping_table()
> > >    print_metricgroups()
> > > +  if _args.output_string_file:
> > > +    _args.output_string_file.close()
> > >
> > >  if __name__ == '__main__':
> > >    main()
> >
> > Should _args.output_file.close() be added here alongside
> > output_string_file.close() to ensure their final filesystem writes happen
> > simultaneously before interpreter shutdown?

... here.  Or, maybe you can call os.utime().

Thanks,
Namhyung

