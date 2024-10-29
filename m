Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1B91DC739;
	Tue, 29 Oct 2024 18:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730225336; cv=none; b=Z4ToRxrozIQpMAqX5SEsqhk9/J+imfuxVEix0yV9ISkJAlT6TQgQxdykgVw4rtb6KWhS94BjKWMDZhfg8Jz18flcnMgox15EafIuMLFeHMjxWp4B+mfAUrkn9W2iMW3lvPPorfW2ZXuWrgW4q4367qVFqXaj9Enk20eqNMKAfUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730225336; c=relaxed/simple;
	bh=AN4iv66DentSAFq4QXzCCx3UrpDmKZxveFdmoxab1CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dt+iSigbMA4CsG89eq1v7MlMD/99IwIQqzkGXfLUMvDBjhwDXY4v4YIByMA3Jhnxwbj2MQiJyYaClbqy54WAtupoLbVpDd8YGyi62Z5EGn37oDI7n6Sic1jD2xBHy1rSsr9+OXDUW1fXW/bxAv4cWG6JxMXLpKl1q9vX8lBn/t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UfdF3Ces; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UfdF3Ces"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fgjuHQ78XGkZb7KcQM6xJQ3E19G0vHh//2ashTQs+PI=; b=UfdF3CessnVcHFTyrvbRreKgpW
	zkCjNxgvYtsONLHLEGf+1c7DAPcDhpOtPPZ4Z29zA5WQbxiEZKNvvd+h788o2FsRbnfxqCxwd/Akg
	ME79PR0vAHcIxj87B2lALKxmNrSCDL89JvNYrMH65Z5TwUV7IquwPR5MXk9nCLDTuvYuTG1030Cu9
	OmzDgsEMKOxjtVgJi17zKCw+pUBMf1/bCSO4EfqXbQfPo66gnABiVJeA6gPm0dLE1Wvys/rEQh/Kj
	T2pmdlhxz5d8W54OEOEmlo7S+G+XRBxj60ediRf6kGI+kqnaMRVy5WRH/2EikGfaZrB0D6G/OwjP2
	lsWE7YBQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t5qdy-0000000ABCN-48JX;
	Tue, 29 Oct 2024 18:08:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CAD0630073F; Tue, 29 Oct 2024 19:08:38 +0100 (CET)
Date: Tue, 29 Oct 2024 19:08:38 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
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
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 08/19] unwind/x86: Enable CONFIG_HAVE_UNWIND_USER_FP
Message-ID: <20241029180838.GF14555@noisy.programming.kicks-ass.net>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <2354d43022bd336c390e1e77f7cee68126d5f8c8.1730150953.git.jpoimboe@kernel.org>
 <20241029131303.GW14555@noisy.programming.kicks-ass.net>
 <20241029163110.xf5o2bvfbfcenlla@treble.attlocal.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029163110.xf5o2bvfbfcenlla@treble.attlocal.net>

On Tue, Oct 29, 2024 at 09:31:10AM -0700, Josh Poimboeuf wrote:
> On Tue, Oct 29, 2024 at 02:13:03PM +0100, Peter Zijlstra wrote:

> > > +#define ARCH_INIT_USER_FP_FRAME							\
> > > +	.ra_off		= (s32)sizeof(long) * -1,				\
> > > +	.cfa_off	= (s32)sizeof(long) * 2,				\
> > > +	.fp_off		= (s32)sizeof(long) * -2,				\
> > > +	.use_fp		= true,
> > > +
> > > +#endif /* _ASM_X86_UNWIND_USER_H */
> > 
> > What about compat / 32bit userspace?
> 
> Sframe doesn't support 32-bit binaries at the moment.  Does anybody
> actually care?

Dunno, I think the only 32bit code I've recently ran is in selftests and
wine32 -- because Monkey Island rules :-)

> You're right this regresses existing perf behavior for the frame pointer
> case.  I'll try to fix that.

Thanks, this patch is the frame pointer unwinder, that really should do
32bit.
