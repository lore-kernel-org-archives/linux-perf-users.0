Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF88322097
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 20:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720815733; cv=none; b=ZNmwSS5LkWqI8RMwCLqqXos+1ksKBnxPZ++H/Qy+s4MunGTI3/PTsX6OCerdKH/RDYopsoqkNrAFyblxNMPRb41hXQjr7BUIYBm9NjzZIl8/n62k6iKlmThKZPjP3HSho/sxFi27ElkByKDtGriRFs5xS2xBw5HjmgOfnicjxCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720815733; c=relaxed/simple;
	bh=N36GrIOLvMKFiq5drfSZ8wTiAWxLY+SMFrk1A+mnozk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcLvgTHgzoExvEcDFyysktb2ExsWIyIgk76sZMxQTo0aauPC8odmOLXKZUF1AhpLcCUcFjqJRBtbsukrCnsuyKkX9s8kPU9A8gxZF8O5K2h9l1pKZisAWFUoIpfUUH/SuWPdQA+p4UD7hhPkEy4g17Are4B/0YfbDZLg+w+oLLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbAtxn5S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbAtxn5S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90C4C32782;
	Fri, 12 Jul 2024 20:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720815732;
	bh=N36GrIOLvMKFiq5drfSZ8wTiAWxLY+SMFrk1A+mnozk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PbAtxn5SWPKJD/E6RzFiGUfoJ7hliqmz2Q3rSovuLLldjOU4JnmU5xVfEo2Aj8zML
	 bRR84UGVY4JYTjK9juMc8JI5n3aZMihE4HIsonE52OJofMWUCPG1UEGM6nuu4Fxeou
	 y64uGHvDVWbSgVo7cWlBDv9E2/+ivVmzEJhfTQWek+ztxIvz2RY2v/Qk2Z+KYbgB7x
	 ximX8jv9blYufEnGdYTCwSMhXhLc9Fw+7DzpD8GyIY9jQOP4CVZwS4TmUhup15+kJU
	 zy85l5nH/nehwN9PJvMvpGkWRCQ8/Hg7Nf7ooAuXdfKXolLReGMbsV8sFFWKkjIu67
	 JWCbFNOeniv2g==
Date: Fri, 12 Jul 2024 15:22:08 -0500
From: Namhyung Kim <namhyung@kernel.org>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, irogers@google.com,
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
	atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v12 1/4] perf check: introduce check subcommand
Message-ID: <ZpGQcN8RBHs6peFL@google.com>
References: <20240628064236.1123851-1-adityag@linux.ibm.com>
 <20240628064236.1123851-2-adityag@linux.ibm.com>
 <Zn8C-XpC1beIRN8t@google.com>
 <tylbo22m2koyrcypdykidcuzcwrtfqrzehcwwwmqkcqnbnhz2y@rnsy3gyfmzj4>
 <ZoSRiW1aVsV-xrur@google.com>
 <htq5vhx6piet4nuq2mmhk7fs2bhfykv52dbppwxmo3s7du2odf@styd27tioc6e>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <htq5vhx6piet4nuq2mmhk7fs2bhfykv52dbppwxmo3s7du2odf@styd27tioc6e>

Hello,

On Wed, Jul 03, 2024 at 04:17:09PM +0530, Aditya Gupta wrote:
> Hi Namhyung,
> 
> > > <...snip...>
> > >
> > > > > +static const char *check_usage[] = {
> > > > > +	"perf check [<subcommand>] [<options>]",
> > > > 
> > > > You can leave this NULL and parse_options_subcommand() will fill the
> > > > first element automatically using check_subcommands[].
> > > > 
> > > > Please see other commands like 'perf sched' how to handle this.
> > > 
> > > It doesn't seem to be working, hence added that check_usage in v12
> > > itself.
> > > 
> > >     $ ./perf check
> > > 	Usage: (null)
> > > 
> > >     -q, --quiet           do not show any warnings or messages
> > > 
> > >     $ ./perf sched
> > > 	Usage: (null)
> > > 
> > >     -D, --dump-raw-trace  dump raw trace in ASCII
> > >     -f, --force           don't complain, do it
> > >     -i, --input <file>    input file name
> > >     -v, --verbose         be more verbose (show symbol address, etc)
> > > 
> > > Debugging it further, this behaviour was changed in
> > > 
> > >     commit 230a7a71f9221: libsubcmd: Fix parse-options memory leak
> > > 
> > > Where the generated usage string is deallocated, and usage[0] string is
> > > reassigned as NULL.
> > 
> > Ok, thanks for the investigation.  It's a bug then.
> > 
> > > 
> > > If expected behaviour was allocation of the usage string, it should be
> > > okay for the buffer to not get deallocated for the entirety of the perf
> > > process's lifetime right ?
> > 
> > Right, it should not deallocate it in the parse_options_subcommand().
> > I think we need to change the exit path of the commands to free the
> > usage[0] manually.
> 
> Sure, I can implement that if you have things in hand, or I am fine with
> you implementing it since you will already have an idea what to do.
> 
> Maybe `free(command_usage[0])` or something like
> `parse_options_free_subcommand()` ?

It seems we don't have a place to mark whether it needs to free or not.
Let's go with free(command_usage[0]) for now.

Thanks,
Namhyung

