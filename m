Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D5014534D;
	Fri,  5 Jul 2024 07:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720166126; cv=none; b=B5NOTJVbavznZ/CMx4yv8GQoowei1Ze0FYudAhBXbBDKgCYq8ykaYC8JZ8BJnfd0uiURMWN2kIEt13qyB0+WyS31JeLHCBzLicdZsjB+Khgf1zYiByWyFERIImUXQ782mXM5c3fyZLcneMPeQ0T7LmFsRhaXlc8+UI8SZgi3uRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720166126; c=relaxed/simple;
	bh=rya7XAHaP5j6uu2/AKhsld9GcLoHOi/S9uDHD0YW9MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUfFcTdXqwTNk5l9xQX2FJWhdlwvjozqJ0mw+FrQKKgJrcaEBsjBBdXykphs8wskQ2567ca+NrvLiz7aSH2pc+4Isafs55wtlrCIiLUcLe0d4BEQt42kY0Vt4qFymUJTlYusl2dx/1xWhrn548a7l0XMshb/Lr1JaR+YJ8YFJ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jropIWxh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jropIWxh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rya7XAHaP5j6uu2/AKhsld9GcLoHOi/S9uDHD0YW9MU=; b=jropIWxhzP0ELupbmvgExoIg0Y
	kv3q3b0939Ad7GHXt+j1mpi8HitN2UXPpDVGKG3Au0A4uJkBtQnchAtnBVEAK2CqllijvBgh6dit1
	q/ojMqkhwz+KHIRQAw4483BCy5gK4L5jMkpzqyazYnA1Pr16+ysyATIWtwcovbN6hzrlZlSA0f6rY
	wzKh+JQJDSKxuHQUCjyHM+4OFGAEjHhOMwFI3CxLbQ5/zejyyPzp8xURQgtfIfjojgkbRj9+HPF7Y
	6HdXoalMjEtbI3GAzY/REO/FIk/+1/kRTmvnEA2eNC+PNd25/MlHxMBzv9DMAPRAA1RFsEHj79Y3x
	xROhbRJg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPdmk-00000003jpf-3x2O;
	Fri, 05 Jul 2024 07:55:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 35BDB3005AF; Fri,  5 Jul 2024 09:55:11 +0200 (CEST)
Date: Fri, 5 Jul 2024 09:55:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 0/6] perf: Make SIGTRAP and __perf_pending_irq() work
 on RT.
Message-ID: <20240705075511.GX11386@noisy.programming.kicks-ass.net>
References: <20240704170424.1466941-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704170424.1466941-1-bigeasy@linutronix.de>



Thanks, I'll go queue it for perf/core once the robot gets back to me on
the current pile.
