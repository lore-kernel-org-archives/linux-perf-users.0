Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D731435295C;
	Thu,  1 Oct 2026 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846463; cv=none; b=d5O4xIy0QqX+jTy0ZcHJ/VinyOvY69QD8G9EjrP5XZkTicrNhqwmKOodpfp5OtAfkNhK4n9VrWbywNw04ibL4jop4dSH32s3pKa8wuE4gGbzX3dwPED5lYlOwTyMR/tjk3RNHzx/qnoObp294pUOSHDPQUi0hkL0lDzXYmsiUqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846463; c=relaxed/simple;
	bh=njYanVLPlAem2c0zXBo9WBCHCDoClG/x7hrVtGipiDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8n9kKgH6hRFjqKKEi9v31s4Pp+N8DtieHio2L2YX1vMbqkSF9N+ObucZC4Fs6LSAm+4++CV6Io4AW8S8ebOdxxrI3x7vr5O54IJdULUpyhhnLq1USSodPA8N6shp6Xun/HwgnJsALPsLxfavoWWtlLvZLKS4TPpk+l+L9aYT5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSCsouq8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSCsouq8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3C41F00898;
	Thu,  1 Oct 2026 09:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790846461;
	bh=tmMg+2dUfFfQY8f7vhiLYbEk6LDfyadGi4lV+Q8PpEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XSCsouq8KVpRwc0xFNaev7AUrWdJ9N+acYSWG8ZCo0R8OahjJwosT2M5natza2B2j
	 UBDrMABv7ujD8pPdb5QiILpUacAaSgymxmLfcqORXGz0uEfVK/dso2bPyWyOrJCoxb
	 dP8ReK2EhqQK3+jeU9mKAt9AkpOo0LDBraA+7IeTtBV1HMqVDNp6g9bNNneqMNHngH
	 55G1YhXQEAI8devDxhXfj0zoXpLMnXLzFZZqqh79Q08KYxUnSNohOny8IrTVhZGudg
	 1l7Sh/N0gNDu1++lpk4FCDF4buwJ31WXJpQuIWSK/+X5F9AN0ZS9fcPNjEMdeiPgJ/
	 EyBGvUyP+ERxQ==
Date: Thu, 1 Oct 2026 11:20:58 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v6 3/5] perf report: Add --no-progress option
Message-ID: <ar4l-s_pniJSJW45@x2>
References: <20260930213716.2633750-1-acme@kernel.org>
 <20260930213716.2633750-4-acme@kernel.org>
 <ar4FRWnf6ZBFk7Rl@z2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar4FRWnf6ZBFk7Rl@z2>

On Thu, Oct 01, 2026 at 12:01:25AM -0700, Namhyung Kim wrote:
> On Wed, Sep 30, 2026 at 11:37:14PM +0200, Arnaldo Carvalho de Melo wrote:
> > +++ b/tools/perf/builtin-report.c
> > @@ -88,6 +88,7 @@ struct report {
> >  #endif
> >  	bool			use_stdio;
> >  	bool			progress;
> > +	bool			progress_set;
> >  	bool			show_full_info;
> >  	bool			show_threads;
> >  	bool			inverted_callchain;
> > @@ -1385,8 +1386,15 @@ int cmd_report(int argc, const char **argv)
> >  		    "Use the stdio interface"),
> >  	OPT_BOOLEAN(0, "weights", &symbol_conf.annotate_weight,
> >  			"Show or hide weight columns in annotation. Default show if non-zero."),
> > -	OPT_BOOLEAN(0, "progress", &report.progress,
> > -		    "Show progress while processing the perf.data file"),
> > +	/*
> > +	 * No --no-progress option to add: parse-options provides it as
> > +	 * the negation of this one, clearing report.progress, which is
> > +	 * also how it starts out.  progress_set is what tells the hook
> > +	 * below to stop the TUI and GTK browsers as well, they show
> > +	 * progress until asked not to.
> > +	 */
 
> Nit: I think we can drop this comment.
 
> > @@ -1796,9 +1804,13 @@ int cmd_report(int argc, const char **argv)
> >  	/*
> >  	 * For the stdio case: print the percentage of the perf.data file
> >  	 * processed so far for each processing phase.  --quiet asks for no
> > -	 * messages at all, so it leaves the phases uncounted.
> > +	 * messages at all, so it leaves the phases uncounted, and
> > +	 * --no-progress, progress_set with progress cleared, turns off what
> > +	 * the TUI and GTK browsers show as well.
> >  	 */
 
> Maybe this one too..

Will drop both.

- Arnaldo
