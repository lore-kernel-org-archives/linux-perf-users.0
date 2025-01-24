Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA1E4A1D;
	Fri, 24 Jan 2025 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737719906; cv=none; b=cUv3txHSK5kxNxVyinGZK8Gukb1M2dKUFSYm2CKSPx0GR2I3+0dHW+VuSLshGudLM1gpY9wdk87OauTABA0wXa7ANqQgITz8LpB0N1KqlO+Xukgpn5kUhQFZjlbN/BVn5GlrOSTOCWAVGVp4WEqt4EzdrTlZgOgU+D8ZumHOp0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737719906; c=relaxed/simple;
	bh=X1S/2x/UzIFXU8YsUc3j3QV4J2BBm87Q1r0RObPQyQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAW1BupcSAiid4cRoH08MxcRj4YZlgFWYeOkz3guUTnQhY/0Ei0taBapk4BAOb7Zt6dOhW7McXjt/tKqmvXmt6xWyh77Tqq2DETH+Vu1rOILQepRRMWvwLvE2YB4ibZxlP+BfjlvYY65kiT95x0glSkWYptOD+hQIW6/PF0Oc2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hWeg8eHk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hWeg8eHk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sgYpbh1DfX8JZ/m/T6xAdzG9eIdqJ1ADdSM1jAgjGnk=; b=hWeg8eHkWCPDaXICzh0tOm+XWM
	QER0kThn8dmpMCIvp6RmmzMmrD5a8CPhdxPIT6YYr6dn277gy6G5MRd48gtdFpdXxLef5Ak3kK8ve
	Pny4MnTRhzebEomAcROSfuR3OOkpDjSnqZH6qT6/WEotDte+dB1UCJy/Axgfw5lwQhUJsl32ED6uF
	DZ2mBc2qgcQkctG9CH/4FG+CY1hGR0PIy9Q6F7i83f5Ownq5eo3JKoXEOG0/EtTdpYv3iDsL2S4N3
	952D4UnyAbTETGgOhU3mlBqeuj3q5PTN5ZkBoZ9+JRSUfHSCmqdY7FZ7vF9KUF+AYR1ePogQmAL0C
	bjurmsmg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tbIK9-0000000FXad-2VH4;
	Fri, 24 Jan 2025 11:58:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 27B03300619; Fri, 24 Jan 2025 12:58:09 +0100 (CET)
Date: Fri, 24 Jan 2025 12:58:08 +0100
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
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 30/39] unwind_user/deferred: Make unwind deferral
 requests NMI-safe
Message-ID: <20250124115808.GC15996@noisy.programming.kicks-ass.net>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <4ea47a9238cb726614f36a0aad2a545816442e57.1737511963.git.jpoimboe@kernel.org>
 <20250122141505.GT7145@noisy.programming.kicks-ass.net>
 <20250122224902.hhpmhi7r3azz3a4x@jpoimboe>
 <20250123084026.GF3808@noisy.programming.kicks-ass.net>
 <20250123194807.2mn54dsk2ef5i4iy@jpoimboe>
 <20250123221734.GE969@noisy.programming.kicks-ass.net>
 <20250123233445.qhgb76tj7tjiqagj@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123233445.qhgb76tj7tjiqagj@jpoimboe>

On Thu, Jan 23, 2025 at 03:34:45PM -0800, Josh Poimboeuf wrote:

> Here's what I have at the moment.  unwind_deferred_request() is vastly
> simplified thanks to your suggestions, no more NMI-specific muck.
> work->pending is replaced with work->cookie so the task work can use it
> in case it crossed the cookie-clearing boundary (return-to-user with
> IRQs disabled).

That looks a lot saner, thanks! I'll be waiting for the next cycle, not
sure I can track all the changes in me head.
