Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020ED194138;
	Wed, 30 Oct 2024 17:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730310693; cv=none; b=F8okk+S66TQ6glIS2qL7L75g1J8JcAYfVSGUK7kYfpkYaVqSj8MqyFn4GWv9wvl7kPBIR1B1j3GcnLQIdqKAmlC/3lqH326d/BRIpcmhCrphRmKUGwT4v0dqY3J3UEtOiJ4OJR5Tl1/bkyMGjGdeEYOg3bnFt1nZTFQy4rzocNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730310693; c=relaxed/simple;
	bh=z8wTrdbbYIa07IBTnGdonMj6/c9OH8/gUjegMvN0tbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LV9w4fsnpfeTt6ki1XrmqOBoTorsrECI+lyXXi1b2Nrum4zAPsbvLAjdiMg+FzZZOTrZH7gPA/Ztvu/XdvG7m2J6f7d6moWNq/gtFdf0Com9rvPHHUev+SJjRDCsHATXpsFk2ND+hgubv81TjneaGV4ovzeyy0+5tywahl0uulA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9m+jaWS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9m+jaWS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7A7C4CECE;
	Wed, 30 Oct 2024 17:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730310692;
	bh=z8wTrdbbYIa07IBTnGdonMj6/c9OH8/gUjegMvN0tbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C9m+jaWSfHjLEnDT1wHd0fL8S9frSXyIjTeRil2B+Vpq8zJdbtzUAujedp8f/bT5a
	 0oXW+l4rxb9qSWf9kKt9w7g4XlDLo/ugr1Iw7hMF/TFynlH2ChTXrh1ZfIDP+HPDr+
	 lVlQ/IhK6w+O/py894ZZD2Qy7CE/S5Uu9MIeaLpThOdw/Kxe1TLQ/qJuLGpLHDWjkV
	 AM41tUF46yHqaNBC7+JIhz9oPgW/ZgqiVGdmMifc1PZyeCaErLAMyKge3BO2fil3pj
	 YJOI2D2N/cf8eAyQuFIuil2JsXbZ04IG0HxQ50w/MqEyWYdr8Wo8LjcN7n7I1Y8UlF
	 ZL+0IhpT7VpFg==
Date: Wed, 30 Oct 2024 10:51:30 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
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
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 02/19] x86/asm: Avoid emitting DWARF CFI for non-VDSO
Message-ID: <20241030175130.jbbpmqzghbh6gqop@treble.attlocal.net>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <f2dcdcf95240149bfd21e118209bf3b94efad857.1730150953.git.jpoimboe@kernel.org>
 <6796952b-22cf-4477-a4da-70ce9c3962eb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6796952b-22cf-4477-a4da-70ce9c3962eb@linux.ibm.com>

On Wed, Oct 30, 2024 at 06:19:43PM +0100, Jens Remus wrote:
> > +#define CFI_STARTPROC
> > +#define CFI_ENDPROC
> > +#define CFI_DEF_CFA
> > +#define CFI_DEF_CFA_REGISTER
> > +#define CFI_DEF_CFA_OFFSET
> > +#define CFI_ADJUST_CFA_OFFSET
> > +#define CFI_OFFSET
> > +#define CFI_REL_OFFSET
> > +#define CFI_REGISTER
> > +#define CFI_RESTORE
> > +#define CFI_REMEMBER_STATE
> > +#define CFI_RESTORE_STATE
> > +#define CFI_UNDEFINED
> > +#define CFI_ESCAPE
> 
> Don't all of the above need to be defined to "#", so that they change any
> parameters into an assembler comment? For example:
> 
> #define CFI_STARTPROC		#

Indeed.  Or maybe they could be .macros which ignore the arguments.

-- 
Josh
