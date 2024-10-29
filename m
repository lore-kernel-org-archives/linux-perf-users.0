Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D379E206E8C;
	Tue, 29 Oct 2024 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730210190; cv=none; b=ZBmmkEXc8VnwuIs8XVNDofQ1x3IOQJvhhQcCZ7gPxwIqT9oyhf1B2rsTOfTsdk98HoVg82/e4rKD71CBAnpiE+EcyibPKmCR3dFLfB8guHEOiUs6dFe/tNxh6MWh08u0DvR8AiFPlfWev1+9W52h72hpKEKWBq+cr02IYimpn5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730210190; c=relaxed/simple;
	bh=jynsvAvrGbtnR9bvdxcKgx9zssZ8yKm36m3n0txm+MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kp2pT1jBbGxY3rSSi60ihlmJ7tHJEcODn34+KRnjqgBoGghG/2ogrMUNPcdMQAUW91F9UNWC0pEazv/kmAaSBtIrPjQikOF2TGOCk2ZAUPjYDgeq/LFoC3Aog2bjOy+RoewKNIdhAR9+Wf9CR019aABUbisfeltcs535u6YcLig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jZg1Bkey; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jZg1Bkey"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=REL+CDla42GHqCu6Ej1ygD7q7qNI9MNoCRQcBNqG/XA=; b=jZg1BkeyyPokWmL/sLYRA5zT0K
	VnrrpONpfrBhzjG6/n7Dbd5zKeMtiqTV4gVRio58s5sWVjybu23OvGkIJ5DIc5trVSsW2BSPti9ix
	dENSrocOp2ymm3U1eL0MmvHvAczSgfGpWFH/1UL72uRxk8l1Jorc/n8ULW/W5GhGyrUGP086u8LDf
	Cg9xi0S2lWUh3lBu/FOlPWGRshrDlhndq5SjphsnvverhwRSWs+PjoI3heI/fxpRFGz5q0wKIiQsI
	9ZKduMTAotXWsHiPxkRCabbl6CtI1EgqJTyO6HZRF0kwJ3Zu42VOBZt5QPJnSsG4DsyMLO81f2ovO
	1OLktgJw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t5mhm-00000009uVh-0q4w;
	Tue, 29 Oct 2024 13:56:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 990FF30073F; Tue, 29 Oct 2024 14:56:17 +0100 (CET)
Date: Tue, 29 Oct 2024 14:56:17 +0100
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
Message-ID: <20241029135617.GB14555@noisy.programming.kicks-ass.net>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <a94eb70a80c4a13dedb2655b7848304a992cb1b0.1730150953.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a94eb70a80c4a13dedb2655b7848304a992cb1b0.1730150953.git.jpoimboe@kernel.org>

On Mon, Oct 28, 2024 at 02:47:38PM -0700, Josh Poimboeuf wrote:

> + * The only exception is when the task has migrated to another CPU, *and* this
> + * is called while the task work is running (or has already run).  Then a new
> + * cookie will be generated and the callback will be called again for the new
> + * cookie.

So that's a bit crap. The user stack won't change for having been
migrated.

So perf can readily use the full u64 cookie value as a sequence number,
since the whole perf record will already have the TID of the task in.
Mixing in this CPU number for no good reason and causing trouble like
this just doesn't make sense to me.

If ftrace needs brain damage like this, can't we push this to the user?

That is, do away with the per-cpu sequence crap, and add a per-task
counter that is incremented for every return-to-userspace.
