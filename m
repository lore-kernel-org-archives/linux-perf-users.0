Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3DD1DD529;
	Tue, 29 Oct 2024 18:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730225511; cv=none; b=e6Qd86E8bWwBgvfcakL7apFxJJVHzEatnZwgaRZJ2qvjvNHYOu2kLdg8vAHAYoTR56hjiwv0jpyVyfELOxIzXL5Y3Tfh+MmPEj5+YosEFCD6jc/RLPXid1GEEglETrfKLRpzU1oXUmcL0RxAfoJqWxoCR+xT03fnHmNPsXuoMBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730225511; c=relaxed/simple;
	bh=8xw7z8CEUINWdxtHO9dShc2ndAJXdfyUhIINxW6T/9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGXOEQOM80Dgxg9ujgpCF6vRxBPJkd6bBrSU2b6l5rFDnPhXeTfBk+bjYZ+42cdpnodlgHBl0I6yUygX5AFEubYesWpJMuefLllP0347wjXRvzl/mjzGiKALfQEo6PvK2j+sA7p3YXo6BwhQToz2ara7sid9+zyRprFS7FeRBmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cqRBTFXM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cqRBTFXM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ktq3lkoSzGcMhJDlOopdwpiDj9Zb69SDMXTk4TVirW4=; b=cqRBTFXMWk7cjZyCinieivueln
	F4sK52aUG7au7xfGQZ0shuxU7b7yh4tx5Nfa3b3XLMG5hUNboLiB8UKQ9lSh+331Pho6S6RbGQrRb
	lFonZCvPLBHUsFYzd5lz4cBTrIk4RXp+qPm3QXKE6s1+5UVsXXQs+3TSkaYtGhe5Ftw1LcvbpRY8Q
	PG8rzN3v2+vi2GNLho8DFEYkzdabC3JxlD91bjjppuZHvP0GHtfCE4zt2M3FtazhqT5sM15VTQb/A
	WcUlsnZ02mWIbmoEwEG5cs9nMVXshzRgOiBmxC/HRm63+QWYH2uaiwiEuzegupVkhtzhZJWsopUc+
	PB1gcQag==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t5qgr-0000000ABjQ-1HTW;
	Tue, 29 Oct 2024 18:11:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8DB8630073F; Tue, 29 Oct 2024 19:11:37 +0100 (CET)
Date: Tue, 29 Oct 2024 19:11:37 +0100
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
Subject: Re: [PATCH v3 11/19] unwind: Add deferred user space unwinding API
Message-ID: <20241029181137.GH14555@noisy.programming.kicks-ass.net>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <a94eb70a80c4a13dedb2655b7848304a992cb1b0.1730150953.git.jpoimboe@kernel.org>
 <20241029134918.GA14555@noisy.programming.kicks-ass.net>
 <20241029170526.5gdnqdlnoqsd7pxh@treble.attlocal.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029170526.5gdnqdlnoqsd7pxh@treble.attlocal.net>

On Tue, Oct 29, 2024 at 10:05:26AM -0700, Josh Poimboeuf wrote:
> On Tue, Oct 29, 2024 at 02:49:18PM +0100, Peter Zijlstra wrote:
> > On Mon, Oct 28, 2024 at 02:47:38PM -0700, Josh Poimboeuf wrote:
> > 
> > > +static void unwind_user_task_work(struct callback_head *head)
> > > +{
> > ...
> > > +	guard(rwsem_read)(&callbacks_rwsem);
> > > +
> > > +	for_each_set_bit(i, &pending, UNWIND_MAX_CALLBACKS) {
> > > +		if (callbacks[i])
> > > +			callbacks[i]->func(&trace, cookie, privs[i]);
> > > +	}
> > 
> > I'm fairly sure people will come with pitchforks for that read-lock
> > there. They scale like shit on big systems. Please use SRCU or somesuch.
> 
> I'd expect that unwind_user_{register,unregister}() would only be called
> once per tracing component during boot so there wouldn't be any
> contention.

The read-lock does an atomic op on the lock word, try and do that with
200+ CPUs and things get really sad.

> But I think I can make SRCU work here.

Thanks!
