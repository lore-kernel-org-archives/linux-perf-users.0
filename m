Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3F0FBF6;
	Fri, 24 Jan 2025 22:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737756048; cv=none; b=fMnJT1+Z/6tDGvvjjidchrRbgvLSBm1U4j1mrSObCxgAmLTUAZomAy2rImNAXF3dw0KR8BIIqxkaAvWS8dEI2XGrIF5ZJ2YHJZZMsRtUGN2aX7Ha30N6D/dXad8Xa+B2DqF7dF6Z2D/jEVGCiqUspcCeMlMYquL3w/9/OcGJE0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737756048; c=relaxed/simple;
	bh=ocW0QHrHLA2keOhEunkKkNQ18McRRkljQW5O5h4kBUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iahg8RuCeS0D0aNpj84DBtwqmqPo3DvJx3q5xy5KVvSI8NU9EFwkE9Gsh3PWt9TfrLxPcSs8ialgC2VKrMTBc2IWhYcLRymGJHjHYV3E5AQ2+X4I5YFH6CBfXBcklfoKkR5Q3QTH0DLN1mlxQWK2g+7s+TBi9qcA/V/enloHnQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIrFDrji; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIrFDrji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FACCC4CED2;
	Fri, 24 Jan 2025 22:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737756048;
	bh=ocW0QHrHLA2keOhEunkKkNQ18McRRkljQW5O5h4kBUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EIrFDrjihPexKBMV6E5FMSG654Graa5cInGnIPWWWpgfyK+pJYDnau0Pd1BT0S2l0
	 wxCArJy2qMevwjGUJE5IfeR3Ks/5GUPEbO7q4tyaD/OCPwHojTKf27Jz25s8El/buv
	 dZzRSzgrpSl/wophPoZ9UiXhTgsuHjRcxDzgEv2miNBONLbxbmiI0jqPj1wRy1H79b
	 cB2YQo4VJRSbppsG8oB4mu2VAxREWDT4Kop3Bmgs1uGgf2cW2QA5FiUinNz3dDcIKF
	 aC0Bz//Y95KcvAVN8/aXp+j9cdsyusojI8fos40dcQWiGJgv8/aTFIFMstiF126J8s
	 RKwxBDXyStKbw==
Date: Fri, 24 Jan 2025 14:00:45 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 32/39] perf: Remove get_perf_callchain() 'crosstask'
 argument
Message-ID: <20250124220045.hduc3az4neoutebq@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <73229250c0279667f617c3d6da121c6621164e4d.1737511963.git.jpoimboe@kernel.org>
 <CAEf4BzYLqmhb11F8X96Ac03YErf2WrHq8D5EA_f-488ij9-jnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYLqmhb11F8X96Ac03YErf2WrHq8D5EA_f-488ij9-jnw@mail.gmail.com>

On Fri, Jan 24, 2025 at 10:13:23AM -0800, Andrii Nakryiko wrote:
> On Tue, Jan 21, 2025 at 6:32 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > @@ -430,10 +429,8 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
> >         if (task && user && !user_mode(regs))
> >                 goto err_fault;
> >
> > -       /* get_perf_callchain does not support crosstask user stack walking
> > -        * but returns an empty stack instead of NULL.
> > -        */
> > -       if (crosstask && user) {
> > +       /* get_perf_callchain() does not support crosstask stack walking */
> > +       if (crosstask) {
> 
> crosstask stack trace is supported for kernel stack traces (see
> get_callchain_entry_for_task() call), so this is breaking that case

Oh I see, thanks.

BTW, that seems dubious, does it do anything to ensure the task isn't
running?   Otherwise the unwind is going to be a wild ride.

-- 
Josh
