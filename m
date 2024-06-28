Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DC71E517
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719584435; cv=none; b=dA5PUq2rgTiTQiOe/ac5eymzxGmeA+sT/Qw0UW07URSNZx7zaUwoxAes1Cg6S/dF47BwIFt8kh/ak8NdJrckzxpSFmhOJyh0hLDf2s+4o4mzM3J2q2TkFoGee/CE5lunmZnCDOckbraGtP8zS0NPICPTl5LC/3h5if8xxEeeEBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719584435; c=relaxed/simple;
	bh=tiXByISLkcz5kW48hWx2nsYFm5gO0OeZsC6hUzwpwCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUQn/HHYQiR2NrEvOFpZVkfLDlft3aMjCZ/HRVmg3NdAyzL8xNCkYyowmCv/cK1AfSQxEDEpdGqAiPrVdiC2bzkTTvXeCncTWmiqp2YXFtbV+mxi5DLszTxx00BfuMR0ofLyz0NWCrCR7EUBffMgeHbcPR/BYUyeMECfcPuALCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcKCVJo0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcKCVJo0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2ADEC2BBFC;
	Fri, 28 Jun 2024 14:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719584435;
	bh=tiXByISLkcz5kW48hWx2nsYFm5gO0OeZsC6hUzwpwCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RcKCVJo0hzOwC5Es2BoqhBUOoJm+o1etNNxKXnwclgLMpsfxUyPH4C5ZiSyOsHjgs
	 lH3gwY0kKLVG7kg/uqJQdBFtfnKM98cljWXWr7wjpQ4wkCO4XDDw1JmDJd6XJvTDfh
	 TQmme0q93JNxMLYjxaOa+G+lRXUf6Y9J2RzqV7q1HvXxXU1JrXCUtNuZbfTwT8Fm3W
	 P1QdjEolEYRE8g4DT8c3O5+YxPatkmFF9HqCc1c434Tg5hoN2Hp7B3y2vDNVAgdRWx
	 xJUfj1QQFXAOHQxPohlNAhnnpCvxAoRRJSrldcnp1y4Dt6YYcrHHH3F2q8F9VdYP9i
	 azwlcGRyYpI5w==
Date: Fri, 28 Jun 2024 11:20:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: jolsa@kernel.org, irogers@google.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
	atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v11 1/4] perf check: introduce check subcommand
Message-ID: <Zn7GsEKwLxn5bMyN@x1>
References: <20240627100644.772219-1-adityag@linux.ibm.com>
 <20240627100644.772219-2-adityag@linux.ibm.com>
 <Zn7EvDbsnlbLXj4g@x1>
 <Zn7FmltYgUzi6YvV@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zn7FmltYgUzi6YvV@x1>

On Fri, Jun 28, 2024 at 11:15:57AM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Jun 28, 2024 at 11:12:16AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Thu, Jun 27, 2024 at 03:36:41PM +0530, Aditya Gupta wrote:
> > > Currently the presence of a feature is checked with a combination of
> > > perf version --build-options and greps, such as:
> > > 
> > >     perf version --build-options | grep " on .* HAVE_FEATURE"
> > > 
> > > Instead of this, introduce a subcommand "perf check feature", with which
> > > scripts can test for presence of a feature, such as:
> > > 
> > >     perf check feature HAVE_FEATURE
> > > 
> > > 'perf check feature' command is expected to have exit status of 0 if
> > > feature is built-in, and 1 if it's not built-in or if feature is not known.
> > > 
> > > Multiple features can also be passed as a comma-separated list, in which
> > > case the exit status will be 1 only if all of the passed features are
> > > built-in. For example, with below command, it will have exit status of 0
> > > only if both libtraceevent and bpf are enabled, else 1 in all other cases
> > > 
> > >     perf check feature libtraceevent,bpf
> > > 
> > > The arguments are case-insensitive.
> > > An array 'supported_features' has also been introduced that can be used by
> > > other commands like 'perf version --build-options', so that new features
> > > can be added in one place, with the array
> 
> Now testing it with just this first patch applied:
> 
> ⬢[acme@toolbox perf-tools-next]$ perf check feature bpf
>                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
> ⬢[acme@toolbox perf-tools-next]$ echo $?
> 0
> ⬢[acme@toolbox perf-tools-next]$ perf check bpf,libtrafs
> 
>  Usage: perf check [<subcommand>] [<options>]
> 
>     -q, --quiet           do not show any warnings or messages
> 
> ⬢[acme@toolbox perf-tools-next]$
> 
> 
> I don't see a way to list what features can be tested against, would be
> great to have.
> 
> Also it just says that the usage is wrong, no indication as to why, I
> think this would be more informative:
> 
> 
> ⬢[acme@toolbox perf-tools-next]$ perf check bpf,libtrafs
> Unkown feature 'libtrafs', please use 'perf check feature --list' to see which ones are available.
> 
> ⬢[acme@toolbox perf-tools-next]$

Ah, to clarify, these comments are for the v12 series even being replies
to the v11 thread, I'll move to the v12 e-mail thread. Using b4 I got
the latest version, v12:

Cover: ./v12_20240628_adityag_introduce_perf_check_subcommand.cover
 Link: https://lore.kernel.org/r/20240628064236.1123851-1-adityag@linux.ibm.com
 Base: applies clean to current tree
       git checkout -b v12_20240628_adityag_linux_ibm_com HEAD
       git am ./v12_20240628_adityag_introduce_perf_check_subcommand.mbx
⬢[acme@toolbox perf-tools-next]$        git am ./v12_20240628_adityag_introduce_perf_check_subcommand.mbx
Applying: perf check: introduce check subcommand
Applying: perf version: update --build-options to use 'supported_features' array
Applying: perf tests task_analyzer: use perf check for libtraceevent support
Applying: tools/perf/tests: Update probe_vfs_getname.sh script to use perf check feature
⬢[acme@toolbox perf-tools-next]$
