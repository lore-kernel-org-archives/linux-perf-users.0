Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7253126AF6;
	Fri, 13 Sep 2024 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726238877; cv=none; b=BDtGGb0DzQoYPkhdLvzYb8XSeaZyMh64u5ebV+dhCoSDkOHP3zA19Ikq7fHw1I2rBvekugJCeuWqQTp2uOe3XNJdk2D7bdUJpj9NK1qBU4U184lDLdiLPIUd8fq8cExLhNc1tchViAv12WDVtjt1UCEkv98jM+IXPPi5ibEH2Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726238877; c=relaxed/simple;
	bh=G1xAwMubqFsP8C8l7FuEtkaPUesz1Iaoant89FJb0K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqNO4tZJqljegtoRbPII5xORcmGlSJ7zIAOen+5VMrNCnVo5KkDWhcUS1ts47JGl/Qtb/D/PM7E51sA2puZDFJMP3jAdBWdfYI1Y1ACCgNkhQYPGqqi8/bSO1h7ZXoXFJ9FZmYh2UdXvqglF9AW1alQm8ndfKtntZSsJ8Z/nsZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKBV0PrO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKBV0PrO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0971BC4CEC0;
	Fri, 13 Sep 2024 14:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726238876;
	bh=G1xAwMubqFsP8C8l7FuEtkaPUesz1Iaoant89FJb0K8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BKBV0PrOL0Nf+Qh/qhAVtUf1QGN/B04lO/OauRFsRjhbeo045Cl5dENFpse7GiVY4
	 dLcrZRlE8P4cPTLOZ0LzVbFuZbuw01IfXSDSZdrMdVFy6JFGR5EPPcou3FQjybJT1w
	 H/i2XJPkdV5rQH0MCqbKJ2waY/E1Oqmhkvj1PrpsLlM7lNfc/hV/E/44WgzpJcPcqJ
	 MaMCDlm1iRH4/8VJfyxHZDfsHQxpPFkPWkJLOBTx/EAJTPZw69pJquvLdGNQMj/ZFu
	 kU3nYihPbzbSV6lL0lCvwaK3OidRIxxul41W0HZPK//2wsU8FqaRg/1A9FaC2qQHfk
	 bnvwF7N96CFPQ==
Date: Fri, 13 Sep 2024 07:47:14 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org
Subject: Re: [PATCH RFC 04/10] perf: Introduce deferred user callchains
Message-ID: <20240913144714.gkksyfk242w3fvh4@treble>
References: <cover.1699487758.git.jpoimboe@kernel.org>
 <d5def69b0c88bcbe2a85d0e1fd6cfca62b472ed4.1699487758.git.jpoimboe@kernel.org>
 <CAM9d7chZcqR8WCEYtjpP4KzUOeNdJ=kSvae0UrjsO8OgsepjDw@mail.gmail.com>
 <20231111184908.ym4l6cwzwnkl7e6m@treble>
 <CAM9d7chgoiwc3ZfQ8SzO7gV0oQOKMK3bJAdxa63Pzgcqo4i7tQ@mail.gmail.com>
 <ZVTuK5VRQfY1JOEY@google.com>
 <20231120140334.GW8262@noisy.programming.kicks-ass.net>
 <20240913130834.hq4gj27fcklakkzb@treble>
 <20240913133629.GV4723@noisy.programming.kicks-ass.net>
 <20240913135351.tyjuekjzvb5xtawn@treble>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240913135351.tyjuekjzvb5xtawn@treble>

On Fri, Sep 13, 2024 at 06:53:58AM -0700, Josh Poimboeuf wrote:
> On Fri, Sep 13, 2024 at 03:36:29PM +0200, Peter Zijlstra wrote:
> > On Fri, Sep 13, 2024 at 06:08:34AM -0700, Josh Poimboeuf wrote:
> > > On Mon, Nov 20, 2023 at 03:03:34PM +0100, Peter Zijlstra wrote:
> > > > On Wed, Nov 15, 2023 at 08:13:31AM -0800, Namhyung Kim wrote:
> > > > > +	/*
> > > > > +	 * Deferred user stack callchains (for SFrame).  Previous samples would
> > > > 
> > > > Possibly also useful for ShadowStack based unwinders. And by virtue of
> > > > it possibly saving work when multiple consecutive samples hit
> > > > the same kernel section, for everything.
> > > 
> > > [ necroing old thread as I'm finally working on a v2 ]
> > > 
> > > Peter, can you elaborate?  What did you mean by "same kernel section"?
> > > 
> > > Like if there's a duplicate kernel callchain?  Or something else?
> > 
> > Yeah, multiple samples hitting the same syscall invocation will, by
> > necessity, have the same user callchain.

If duplicate user space stacks were removed then would that not give a
skewed perf profile?  Or at least a less detailed one?  i.e., it might
be good to know if a certain system call was taking forever.

If that's not an issue, I was also wondering if we would want deferred
even types for the other user options like PERF_SAMPLE_STACK_DEFERRED
and PERF_RECORD_USER_REGS_DEFERRED?

Or if it would instead make sense to combine all the deferred user
options into a single variable length PERF_RECORD_USER_DEFERRED event
type?

-- 
Josh
