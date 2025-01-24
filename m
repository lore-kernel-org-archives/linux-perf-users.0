Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788511E990B;
	Fri, 24 Jan 2025 22:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737756368; cv=none; b=fdEjNq/lA3yTxTON3lZKdX64fxZagiQ+3Kdp8WQArfoNwUbk6WaIeKgKLos9iaH+sq4e2//ecERy/KiM7tlI518aBkWcgcUPg5RvA+GfhjhULBood94UnbM6gr35HdYRImby2mFKF3s2s1Xe6u6Id09wKD+hHTyrXlkci9LlvTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737756368; c=relaxed/simple;
	bh=cYCPJp4rQQuBTEPhskU18Lur3nzjJ+OOg0Jk2q3CMSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkxDm4iQHoP8oPSRHZfNLQIMXrVRY48NLUvc22M/S/+yaA7Z5YdOr31tLTJ2/PeJVHjZMYzd10SW8ot2b0FpKzgmiVLB0tH22lso3Y33rs7DF3ETqw9Fs0l7opauEonP2H2eh8T7DlyEUPn5G9dn8SpMflUGMryfhRy1foIF4OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6M6+/YO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6M6+/YO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C243C4CED2;
	Fri, 24 Jan 2025 22:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737756368;
	bh=cYCPJp4rQQuBTEPhskU18Lur3nzjJ+OOg0Jk2q3CMSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k6M6+/YOaUEPHRYtRb1nPgwqlE/KYPpje2z+4Kh4ga4HFHR/CL5oXmN1NaLrwmIbs
	 xQ4wmKLgbt38MEX6y5X/80T04MesYLZkMrqtzrKgt5itDn6ybonAB0x4htwLcOg6ms
	 smIi7dvR2//joQMhvDIaFLJNJoRPaW0VbvNgToSbvtfpZuQPImycES/uF/VHfLU0F8
	 TirL3kbFfnnKYp6h3CU28MSXejsNgwb31PJ+ONZQQSun3rbNPfd3MGisPkPwhO10eQ
	 hpE778rZmaKq+tr/1EFK3qdHFamb9LsDEzENu3hycq7Xt1mBRMqxbM2CepmgGVGX/U
	 hC64DDELRfmpg==
Date: Fri, 24 Jan 2025 14:06:05 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 14/39] perf/x86: Rename get_segment_base() and make it
 global
Message-ID: <20250124220605.xj7lgducutuglr63@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <e54e48ab228aa386fb4c5f64ee02ef5291f2d3da.1737511963.git.jpoimboe@kernel.org>
 <20250124150927.1f957483@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250124150927.1f957483@gandalf.local.home>

On Fri, Jan 24, 2025 at 03:09:27PM -0500, Steven Rostedt wrote:
> On Tue, 21 Jan 2025 18:31:06 -0800
> Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> 
> > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > index c75c482d4c52..23ac6343cf86 100644
> > --- a/arch/x86/events/core.c
> > +++ b/arch/x86/events/core.c
> > @@ -2790,7 +2790,7 @@ valid_user_frame(const void __user *fp, unsigned long size)
> >  	return __access_ok(fp, size);
> >  }
> >  
> > -static unsigned long get_segment_base(unsigned int segment)
> > +unsigned long segment_base_address(unsigned int segment)
> >  {
> >  	struct desc_struct *desc;
> >  	unsigned int idx = segment >> 3;
> 
> As this requires interrupts disabled, and if you do move this out of this
> file, you probably should add:
> 
> 	lockdep_assert_irqs_disabled();

Indeed...

-- 
Josh
