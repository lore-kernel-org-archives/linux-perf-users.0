Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620681C0047
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 14:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719584157; cv=none; b=GUypONJ/1H58ZBYlq3sbEa8mb5pPLaVRMxmgwCPkuy4lRkjg1CZf+HGqyY5jy6WUQJuvLP6mwK6d1/OZLfEkdwOcPe7+lDtv7UtIOZkrubRLRGLmVhnml4gI0Yk3TDGhlnSCGVBb02gMiBcI6KbCr1XthMJ5yjx87GPTio75qz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719584157; c=relaxed/simple;
	bh=fWL6V78amXf4jAp9PFCMo1LJzWOGyGoVb5V4zeRZRZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfxqtZhU8xY8yzrzH9eASWuIxr7TUPVSlaRuRWkQxEgkeg+827ZeJGfizlpzXLLNNY1WBzXtak5sO2i11j197GLzPGl4gbEbiSNqjgxRZWrBW69RzReQCSi5nfKq76q+ldx1a+cy0rvzW8mIyHVegoVcdkkXK5v2ZZoBdC/b/mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLPy2BY4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLPy2BY4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9E6C116B1;
	Fri, 28 Jun 2024 14:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719584157;
	bh=fWL6V78amXf4jAp9PFCMo1LJzWOGyGoVb5V4zeRZRZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sLPy2BY4PuqmIoCSKerVFm5Q0sRsCX/zmdxbmYIltYEhs2ge7JOb3ZPFyp/gBS9K7
	 6B6Cy5vA5m1OfViGMTtQrqzX0CssQ6sppbMbYLDfembxyrFXhg/XpPLJe1wyWoQV8b
	 BPiljS82tOwWid+XB4sCVPqSE7JcOFUM5j/Rb/IjeQXrBlKfSKxYNnSLOyqSMDXiIg
	 Jnvw3xM+FE8HujQCgsqFmwV76CVoiibaLjHWm8o3qqKBXV37fsEAWM8vibzK5YpmmR
	 jP+Ujm88YrTOg375j/WmK/aCxSM+6i8MoNUnRfKoSsbQ2i6J00MaQ6PCKcmANL4x7h
	 8/AcYr0nCsrBw==
Date: Fri, 28 Jun 2024 11:15:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: jolsa@kernel.org, irogers@google.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
	atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v11 1/4] perf check: introduce check subcommand
Message-ID: <Zn7FmltYgUzi6YvV@x1>
References: <20240627100644.772219-1-adityag@linux.ibm.com>
 <20240627100644.772219-2-adityag@linux.ibm.com>
 <Zn7EvDbsnlbLXj4g@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zn7EvDbsnlbLXj4g@x1>

On Fri, Jun 28, 2024 at 11:12:16AM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Jun 27, 2024 at 03:36:41PM +0530, Aditya Gupta wrote:
> > Currently the presence of a feature is checked with a combination of
> > perf version --build-options and greps, such as:
> > 
> >     perf version --build-options | grep " on .* HAVE_FEATURE"
> > 
> > Instead of this, introduce a subcommand "perf check feature", with which
> > scripts can test for presence of a feature, such as:
> > 
> >     perf check feature HAVE_FEATURE
> > 
> > 'perf check feature' command is expected to have exit status of 0 if
> > feature is built-in, and 1 if it's not built-in or if feature is not known.
> > 
> > Multiple features can also be passed as a comma-separated list, in which
> > case the exit status will be 1 only if all of the passed features are
> > built-in. For example, with below command, it will have exit status of 0
> > only if both libtraceevent and bpf are enabled, else 1 in all other cases
> > 
> >     perf check feature libtraceevent,bpf
> > 
> > The arguments are case-insensitive.
> > An array 'supported_features' has also been introduced that can be used by
> > other commands like 'perf version --build-options', so that new features
> > can be added in one place, with the array

Now testing it with just this first patch applied:

⬢[acme@toolbox perf-tools-next]$ perf check feature bpf
                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
⬢[acme@toolbox perf-tools-next]$ echo $?
0
⬢[acme@toolbox perf-tools-next]$ perf check bpf,libtrafs

 Usage: perf check [<subcommand>] [<options>]

    -q, --quiet           do not show any warnings or messages

⬢[acme@toolbox perf-tools-next]$


I don't see a way to list what features can be tested against, would be
great to have.

Also it just says that the usage is wrong, no indication as to why, I
think this would be more informative:


⬢[acme@toolbox perf-tools-next]$ perf check bpf,libtrafs
Unkown feature 'libtrafs', please use 'perf check feature --list' to see which ones are available.

⬢[acme@toolbox perf-tools-next]$

- Arnaldo
