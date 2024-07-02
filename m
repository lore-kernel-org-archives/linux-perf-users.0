Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FDA1DA312
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jul 2024 23:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719964044; cv=none; b=fz1BzeNCzd5eveNFpn+sJGvvQvuM2J9bAxuIcOZxlw0RKgf9Mxh7BByBUWj4eWcHk0lkFgTlG0KeDFeg8SeB0E5D230mfWpHmXB28C39eIgIjSKeXZOCqfQVK6IRT/deCuhmbd0ySPsdyMpBA+/DdM2kFuKp7koOPKOMv+hTHKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719964044; c=relaxed/simple;
	bh=+EoE+E6pjz5BEuv7CHnzADCOs2bA5V91n+DzMpCWAVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOezsxOW/qLRYv/aYwhiZ2li+oZCFgbwB9pKrw3Ny8gzC59mvZbqmiI0DJtTwA/TjOqNpYhI1BWl7VA3f0HyzSKd7Ot+Dt5iCSHKMOc0Vd6C/ZfLgy3bDN2Sa0k+fRHocVd8eYcX/f3dbC+9rQSn60RGlObLw7MwXyr7HOEwmkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVUjVCaj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVUjVCaj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B356C116B1;
	Tue,  2 Jul 2024 23:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719964043;
	bh=+EoE+E6pjz5BEuv7CHnzADCOs2bA5V91n+DzMpCWAVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SVUjVCajjVdaoDxYBybddmpspz+E6/KAvxFfsLeMZUnBk9fQunQLtT+0+XKrAc4SW
	 PJtPsoRzHsHVgWD8TrWHK9Uh/WB8uzl821d7S8B2ikr9H/w9Y4WrtzeH4LDocD0Fta
	 pi63spdZPgjDAfO/cUW2LsICN+o/dbiFzW77OjgiIBJ4mZ7fPoUoWVOgvxPssI1Ppp
	 h+AFYfjFQV2NjHlIURattXqVCtcHEuxKhr6xMbqFBtSlz7U+3RH/3+ASBAG4RXBhpJ
	 8YpP0ixNvMHjDtVXbhEmJSlREtvAh7fdx2W5yk4mwS/buMWUrssZuGA9fq1znxX9gU
	 tMjH6sLJQwvIA==
Date: Tue, 2 Jul 2024 16:47:21 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, irogers@google.com,
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
	atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v12 1/4] perf check: introduce check subcommand
Message-ID: <ZoSRiW1aVsV-xrur@google.com>
References: <20240628064236.1123851-1-adityag@linux.ibm.com>
 <20240628064236.1123851-2-adityag@linux.ibm.com>
 <Zn8C-XpC1beIRN8t@google.com>
 <tylbo22m2koyrcypdykidcuzcwrtfqrzehcwwwmqkcqnbnhz2y@rnsy3gyfmzj4>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tylbo22m2koyrcypdykidcuzcwrtfqrzehcwwwmqkcqnbnhz2y@rnsy3gyfmzj4>

On Sun, Jun 30, 2024 at 05:07:10PM +0530, Aditya Gupta wrote:
> Hi Namhyung,
> 
> > > +static const char * const check_subcommands[] = { "feature", NULL };
> > > +static struct option check_options[] = {
> > > +	OPT_BOOLEAN('q', "quiet", &quiet, "do not show any warnings or messages"),
> > > +	OPT_END()
> > > +};
> > > +static struct option check_feature_options[] = { OPT_END() };
> > 
> > It should be OPT_PARENT(check_options) instead of OPT_END().
> 
> I did not know that. Thank you.
> 
> > 
> > > +
> > > +static const char *check_usage[] = {
> > > +	"perf check [<subcommand>] [<options>]",
> > 
> > You can leave this NULL and parse_options_subcommand() will fill the
> > first element automatically using check_subcommands[].
> > 
> > Please see other commands like 'perf sched' how to handle this.
> 
> It doesn't seem to be working, hence added that check_usage in v12
> itself.
> 
>     $ ./perf check
> 	Usage: (null)
> 
>     -q, --quiet           do not show any warnings or messages
> 
>     $ ./perf sched
> 	Usage: (null)
> 
>     -D, --dump-raw-trace  dump raw trace in ASCII
>     -f, --force           don't complain, do it
>     -i, --input <file>    input file name
>     -v, --verbose         be more verbose (show symbol address, etc)
> 
> Debugging it further, this behaviour was changed in
> 
>     commit 230a7a71f9221: libsubcmd: Fix parse-options memory leak
> 
> Where the generated usage string is deallocated, and usage[0] string is
> reassigned as NULL.

Ok, thanks for the investigation.  It's a bug then.

> 
> If expected behaviour was allocation of the usage string, it should be
> okay for the buffer to not get deallocated for the entirety of the perf
> process's lifetime right ?

Right, it should not deallocate it in the parse_options_subcommand().
I think we need to change the exit path of the commands to free the
usage[0] manually.

Thanks,
Namhyung

