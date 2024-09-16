Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02691586CF;
	Mon, 16 Sep 2024 14:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495754; cv=none; b=E5+iTkRPYB8aA892qUZ6J9629vCKXPM+1e+9xS6PvUOwInhSVSBalm3j7iKXsLZEbp9mLRxnxv8d/xSyy2cwRmJNKHpKheUWcZTnOFxPCseh8/vjUPAEB+T2hh4GYeJHUIVyLapgpU5DXeXIL+uXa2uC61GGYi2JXigopMft3YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495754; c=relaxed/simple;
	bh=BDCYCMhbdeG1alA51XeFp/8kl4MzKsdoUxUf2SaAFQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRJlsCkHR0Mk9s62Af5ct6IkKCR2wIn0NxDQ6U3SiWIw1TPALyyD/y5BR0PYWTet48372+DE971fWdZfkOV2aQC5hNQztqaTAMmJdNnT/hsJ68XS+LdyPFcSOJHhxLxFen/OlSjPfkyrVQtzhTyRSzaHAKJHVxml9xYAjeMIZZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kjAF6Tr0; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kjAF6Tr0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZX5Ajj3jHf8WXguBa7KMbRkbGIupmkxkkRbafLZCYCY=; b=kjAF6Tr0lgCh2VUOb3ba0m/DlW
	OdPOVRrrXsBiiV8GFsultX7ADqhK+XwqPkLvmBljNIpHeMoSz5Heccy9fybsMvbP2gs/9efr7kItk
	pmEOA7KAIfcfEcTJScCBuiRIpNa3SYrMrp4tcPwd6FnKrm+44shC8DsChNXg1IrTbpS7EtjgUW1mS
	pbbi3wmeriA7eetLCUFIITz3Azq69pqFzNZfBUcSfgCYMLvYnQOELuSWhbLag22d23hho9su9sEUC
	8y7JjI+nQmN/VZZS/7YRkC/pCMGo4s3FSbQ3yImkU06V1SS+m8aZFevqacnGnHkRBQNRDv6PGEE2K
	EZHUVM1g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sqCPR-00000000OiX-2ell;
	Mon, 16 Sep 2024 14:08:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AB64930049D; Mon, 16 Sep 2024 16:08:56 +0200 (CEST)
Date: Mon, 16 Sep 2024 16:08:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
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
	Sam James <sam@gentoo.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 00/11] unwind, perf: sframe user space unwinding,
 deferred perf callchains
Message-ID: <20240916140856.GB4723@noisy.programming.kicks-ass.net>
References: <cover.1726268190.git.jpoimboe@kernel.org>
 <20240914081246.1e07090c@rorschach.local.home>
 <20240915111111.taq3sb5xzqamhb7f@treble>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915111111.taq3sb5xzqamhb7f@treble>

On Sun, Sep 15, 2024 at 01:11:11PM +0200, Josh Poimboeuf wrote:
> On Sat, Sep 14, 2024 at 08:12:46AM -0400, Steven Rostedt wrote:
> > I think the unwinder should have an interface itself that provides the
> > deferred unwinding, instead of having all the tracers to implement
> > their own.
> > 
> > The user space unwinder (regardless of sframe or not) should provide a
> > way to say "I want a user space stack trace for here, but don't do it
> > yet. Just give me a cookie and then call my callback function with the
> > stack and cookie before going back to user space".
> 
> We (Steven, Mathieu and I) have been discussing this at GNU Cauldron and
> I think we're in basic agreement on this.
> 
> I think the biggest tweak we decided on is that the context id (aka
> "cookie") would be percpu.  Its initial value is (cpuid << 48).  It gets
> incremented for every entry from user space.

Why? What's the purpose of the cookie? This scheme seems unsound, pin
yourself on CPU0 and trigger 1<<48 unwinds while keeping CPU1 idle.

> > That is, we should have an interface like:
> > 
> > typedef void (unwinder_callback_t)(struct user_space_stack *, u64 cookie);

Just make it a void* and let the consumer figure it out.
