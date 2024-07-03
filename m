Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C022BB13
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jul 2024 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720041966; cv=none; b=L/dKDZXtR57pd3ypMLceJaKQLW+g1J6/2WhFMFq9faZ3lnFPTDvvG7bkbRRaxduc4k500oTyC5IbVzBpXbjcd/qs17uhXRVT4CUbIhUfU6nMoJ8mvDlcYAN3HmngkI93QC3l7a+30xMH3kp6pfFaBUX2nlzHHWom+BuSeaOKUkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720041966; c=relaxed/simple;
	bh=C1xsj8A4qGisEnI8Pz4EWnv51TJpbbbu3l0pbO6sEPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tK5z+1SNm2sJGonfX7BAw8OAsdvux/35KBqUh7wdhfLr8pepbVdxpvXBnSpr4LymbXhW7zmXwwbORF9VQKH3pKwGM6WvuFI1ARSwdvaH+5YQAVzi/zYcnZAZEAwEGO0hesSLhv/M2Sa6CI3e2eUmCciLH4lb+vdMWNrhPFSKdwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPG0heSI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPG0heSI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A68C2BD10;
	Wed,  3 Jul 2024 21:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720041966;
	bh=C1xsj8A4qGisEnI8Pz4EWnv51TJpbbbu3l0pbO6sEPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CPG0heSIhcCxYC7+Cojis6233xFdolCd4u+lRcNIkI76C1s4XZigBGUft0hpRQPA+
	 ezpmBQVKraXcHIgaTfTp3Qisv5aYeIpDrUd+7FAfXGQCnrvju5JmRwLs9ivY5cVl49
	 OjxIjP+QV1FRnpV2U3jRKXiUp/qrOfzclIbqeEAiILQZsfr3IJ/GDeLkHsYAgB6V4V
	 Ukk2VSIaVUFVZlaXN5orFrD2SAOrvtOntxN6W1OUBBbTIPjlwYX7XuDtkNwDEC7xmo
	 osPgpAD2IfmAbgl8Mb9VVcqyRnBNh/A2PGdIi/85H2db/gVju7JakXlAuwSv10sbdX
	 ZE6wqIZMZyG8w==
Date: Wed, 3 Jul 2024 14:26:04 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, irogers@google.com,
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
	atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v12 1/4] perf check: introduce check subcommand
Message-ID: <ZoXB7GLL2-OY4uSS@google.com>
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

Yeah, but this should be a separate fix and it's ok to keep the usage
string like in your patch.

Thanks,
Namhyung

