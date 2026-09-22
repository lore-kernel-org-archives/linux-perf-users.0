Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE035448A9;
	Tue, 22 Sep 2026 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081579; cv=none; b=DIhAvBDYvxesHYf84JKYC5HeKqqHgjLcA3g0H4Zgozp4QLWVQVexsI92qx5BVcsN43CYfBkC8fVVyi0erSARQk+9u+lPjny01BGGYefp1fCZQo0bQj3ph2k6AdNAanmhCw54rL6X/wemZngFBX+Sa7ECm+An6LMz446LxdWvvgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081579; c=relaxed/simple;
	bh=NbsZa6yZfcvh9RqSptkC+p6qLHLlvIj87ZSf+8FU5Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDnzM1PajADHz0ueGLMONi3lHMDkGomfxZBoHduq7+Ns5YnHRkkaa8m8XEkBAMJ4AN5oyfB+YA9yLf8mfEQd95z8tfg8Ht7ETZcpLaj+RVO5kvnEARIG0fR1HU/wspbafc6gFE4YCRJKSKq0HoeDPoVGC8M+UPpd8OW3763kXHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUvlPuQT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUvlPuQT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37DD1F000FF;
	Tue, 22 Sep 2026 12:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790081578;
	bh=8A0Nr4owqTy5u99VUcQDSXvgPwFdy3G5d6whIytN+Xg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RUvlPuQTj+joVpOoOkh0E0STlBG6ClZcZ5mp4RtHkxxDdedP+O6Gt/J60pPfKj7p3
	 Ayt1U+HahZ8fPOYvDRqdHkHXgxZov6/LPiqC5ix4b4obkfvFu7rXJEmlVG0TeyWRde
	 otKIV23EUmn6sKDDS1FGLok/EgfGzJJnfck33LsZHH8H54J/lUjG62DGMOGelzTcHx
	 vrOMZnCL4CS4WUh94bnJCngP/HNrW0b0O6hiT+lVYP3sFQhM4+cnsy8shO7fBjAmze
	 EXeZ39kY5rbpLV2ooPAJXld5FfwrpB2K04v7+XpkfDRGiQw7/XB9Ablf3VBbT7hCoz
	 N3BL3ArbbqJJQ==
Date: Tue, 22 Sep 2026 14:52:50 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 07/12] perf annotate-data: Show the sample count in the
 data-type browser
Message-ID: <arJ6IjbQb9TnShHn@x2>
References: <20260916114740.48230-1-acme@kernel.org>
 <20260916114740.48230-8-acme@kernel.org>
 <aqsJ6uQEEMBPtk-4@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqsJ6uQEEMBPtk-4@google.com>

On Wed, Sep 16, 2026 at 02:28:10PM -0700, Namhyung Kim wrote:
> On Wed, Sep 16, 2026 at 08:47:34AM -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > The data-type browser has a samples view, selected with -n (or with
> > annotate.show_nr_samples), in which browser__write_overhead() prints a
> > local nr_samples variable that is initialized to zero and never
> > updated, so every member is listed as having no samples while the
> > period and percent columns for the same entry are filled in.
> > 
> > Print the histogram entry's own count instead.
> > 
> > This predates the load/store counter split, so fix it ahead of that
> > patch: the split then only has to adapt a line that is already correct,
> > and this fix can be picked on its own.
> > 
> > Fixes: d001c7a7f4736743 ("perf annotate-data: Add hist_entry__annotate_data_tui()")
> > Assisted-by: LLM
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> This can be applied independently.
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>


Thanks, cherry picked into perf-tools-next, for v7.4.

- Arnaldo
