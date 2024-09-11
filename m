Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEA35A117;
	Wed, 11 Sep 2024 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726064589; cv=none; b=jkyE+qvHYFbjpYFgBeh0CMTONTVyJQDTXjUbr1dJtg1Ze7SpWdx/4EWnW4FEllGauC/+OvYw9bC34iTVVG8DWkwHR612jTPgRB9zNX4IkVhOmg0cLqCxnYnupFfWh/J6XrZ3zrtCTWTE3oRYDkC4qyf8ReP2CDuFlDLdmRlk6mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726064589; c=relaxed/simple;
	bh=1exqtszE8qg/zfZb+SPj6gWdkiOR6leFN4ai47Xb0kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxSUZO48dba/JZONwrndw2Dx7fSjZC3C+ynlUepqhn5xYRDmcWWzMnwcbmRZP+8S9+a94guD4slcW5z9Un9ipd75ETNTKwawkjXQeLrQ+SFf4rR2mHxWhqGzZNnxLCtmtmW+6xm66rDjPTlyLud4VoQjf/h7R5MmVkjTA5rNjS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvHJwRjj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvHJwRjj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EEEBC4CEC5;
	Wed, 11 Sep 2024 14:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726064588;
	bh=1exqtszE8qg/zfZb+SPj6gWdkiOR6leFN4ai47Xb0kk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KvHJwRjjZH5cwboPM+g02ORXGnBqFqIm4SesJjZBJbVktyjXP2Mauteiw0enylzEA
	 juMyyCcedwHTpsN/EuJZxdvHXYnbEQMf6hPk9DAxPCIdv4+z7ttmitMAhgY7GkdAWO
	 WGhtlQb6qfq/G5BxnVxFyZ2erLIRwcQmZxwFl6Yd0e11QKty84GI29jTlZF+Cm54hb
	 WNuCDc5R+ty1KldeNCDOJGUKqFdSvmPO9k13fXAGlV87dE9qvmN1I6r8Sv5pWmng8O
	 c0W7dW8AcMGdxFtyzNojRX7rH2aTK3LeyOYo6ouVabBm+wXPHTWsDlM85cvPPiTDTf
	 M8+q8DT2yDdYw==
Date: Wed, 11 Sep 2024 11:23:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v3 6/8] perf trace: Collect augmented data using BPF
Message-ID: <ZuGnyURMLARy7Omu@x1>
References: <20240824163322.60796-1-howardchu95@gmail.com>
 <20240824163322.60796-7-howardchu95@gmail.com>
 <Zti6mc3Lt5jC1owY@x1>
 <CAH0uvojWQz_K5S7nLavGW6K6mU6Y7TKoZAWpcut=AgbXtr6Wng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvojWQz_K5S7nLavGW6K6mU6Y7TKoZAWpcut=AgbXtr6Wng@mail.gmail.com>

On Wed, Sep 04, 2024 at 02:11:35PM -0700, Howard Chu wrote:
> On Wed, Sep 4, 2024 at 12:53 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > On Sun, Aug 25, 2024 at 12:33:20AM +0800, Howard Chu wrote:
> > ⬢[acme@toolbox perf-tools-next]$ pahole -C syscall_enter_args /tmp/build/perf-tools-next/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o
> > struct syscall_enter_args {
> >         unsigned long long         common_tp_fields;     /*     0     8 */
> >         long                       syscall_nr;           /*     8     8 */
> >         unsigned long              args[6];              /*    16    48 */
> >
> >         /* size: 64, cachelines: 1, members: 3 */
> > };
> >
> > So the entry has the theoretical max limit for the augmented payload
> > which would be 6 * sizeof(struct augmented_arg) + the common header for
> > tracepoints (unaugmented), a lot of space, but...
> 
> Yes, if I don't use this much space, and try to do a flexible payload
> length, I won't be able to pass the BPF verifier. I will try to fix
> this wasting problem.

But then we don't use it, I need to look at the implementation of BPF
maps, to see how bad is this, but I doubt it is that much, well see.

- Arnaldo
