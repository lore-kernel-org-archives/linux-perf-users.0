Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C412356D2;
	Thu, 28 Aug 2025 19:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756411046; cv=none; b=WU2hsAWT/3TBu0ln6Q6plci3xE1a5IXgFsgj9ZiKSUxH2tprTamJqBOra18un2giRRRg9wQdYZB9pRDWEfS4A0OusCJ6/uMIferVm4gVI44Nvd4FYljL9U9nhPBJu1ydjF8NGLjnS2xehVePzRajPppEfVCbZZGN0bsnTU91K/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756411046; c=relaxed/simple;
	bh=US+02qZRGEe9Qt2oFtidirMsz0sKMTA744j/8cWkjPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cK0N6AqN1eTzBwcTKu7+SsvuS4CVuLJtmPLp9Q3PRb8wSGFdqBj6pcC47cC3yxRbQdmy++DwFSLoODI2+ddAEEdAqZlSuzDPTHdR8iUHt7UQ44ko+GgjNzIdJttWdtgqYRUIyZIx8SE7WpDFVB3Ewz2+aUyE3w+FUEKXZbJGLzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/BAhaEa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/BAhaEa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D761FC4CEEB;
	Thu, 28 Aug 2025 19:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756411046;
	bh=US+02qZRGEe9Qt2oFtidirMsz0sKMTA744j/8cWkjPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K/BAhaEaSBIrAwDDYjUWwuRfGluR0L8XQrEenJb4Xgz9CTHxaaBOIJMqA/QWaUBgQ
	 2bJL89QLhTfFGey7KAAP4X3qRhNxYTdvncNI08vfYTniZqPQasv15C9xs5Q4eJE3Nr
	 jFNiP+CNkxmRkw9psRHf+fObxMbEIslMDSTH/kCpqn2bDwxAjL80d1McyOWbadhz0W
	 R6uR62etwXnRhUvPJ7g9hRQd4NPHUdyyjCpy7iCmPvDxP2FWPAg4DYKXnfQEafXMR/
	 IvIUisKmrcDNcdR+lNccCYjNKaDuYbOAJidxcCmLJn+dZ/taG4xVC5LGHcwc/0QbM0
	 AiABJbHmC3DzQ==
Date: Thu, 28 Aug 2025 16:57:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] Revert "perf hist: Fix bogus profiles when filters
 are enabled"
Message-ID: <aLC0o8Shis3FSIuI@x1>
References: <aKYEpf7xp3NnkBWm@x1>
 <CACT4Y+YX-ROx0cW4pkDnqbdfbigVycwPLwO12RNbbtX9-Qp73A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YX-ROx0cW4pkDnqbdfbigVycwPLwO12RNbbtX9-Qp73A@mail.gmail.com>

On Wed, Aug 20, 2025 at 06:14:08PM -0700, Dmitry Vyukov wrote:
> On Wed, 20 Aug 2025 at 10:23, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> > This reverts commit 8b4799e4f0f40a4ec737bf870aa38d06288bf0fb.

> > Not combining entries in 'perf top', so we're getting multiple lines for
> > the same symbol, with the same address.

> > To test it, simply run 'perf top', then do /acpi to see just symbols
> > starting with acpi_ and notice that there are various lines with the
> > same symbol, press V to see the address and its the same.
 
> With this revert, does it show 1 entry but with a wrong percent?

Unsure, I have not investigated it further, just noticed the strange
output with multiple entries for the same symbol, bisected and doing the
revert found what looks like a familiar output.

It is possible that the familiar output is problematic, but I haven't
dig deeper so far.

Since it is a change of behaviour, can we apply the revert and continue
the discussion from that point?

'perf top' decays histogram entries, which is in addition to the
"static" processing done in 'perf report', maybe this is a problem that
is there since forever but statistically, by means of decaying, goes
away and only now we're noticing? Merits investigation.

- Arnaldo

> I am not sure why there are 2 entries for the same symbol, but if we
> merge them, we can sum of percents. Is it the right thing to do?
> 
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/util/hist.c | 11 +----------
> >  1 file changed, 1 insertion(+), 10 deletions(-)
> >
> > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > index 64ff427040c34112..f3f64aff9b882303 100644
> > --- a/tools/perf/util/hist.c
> > +++ b/tools/perf/util/hist.c
> > @@ -1391,16 +1391,7 @@ hist_entry__cmp_impl(struct perf_hpp_list *hpp_list, struct hist_entry *left,
> >         struct hists *hists = left->hists;
> >         struct perf_hpp_fmt *fmt;
> >         perf_hpp_fmt_cmp_t *fn;
> > -       int64_t cmp;
> > -
> > -       /*
> > -        * Never collapse filtered and non-filtered entries.
> > -        * Note this is not the same as having an extra (invisible) fmt
> > -        * that corresponds to the filtered status.
> > -        */
> > -       cmp = (int64_t)!!left->filtered - (int64_t)!!right->filtered;
> > -       if (cmp)
> > -               return cmp;
> > +       int64_t cmp = 0;
> >
> >         perf_hpp_list__for_each_sort_list(hpp_list, fmt) {
> >                 if (ignore_dynamic && perf_hpp__is_dynamic_entry(fmt) &&
> > --
> > 2.50.1
> >
