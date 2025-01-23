Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB3620C02E;
	Thu, 23 Jan 2025 08:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737620751; cv=none; b=AFsPn55lR9VEjz5fZDgriBcNQhhMJ84XOBvIwYjF/tm3nJoK0S1bUXU68HjJh5zHv5oLLGe36QxoHXmPPtmtQrYLJlNsRAzIcJS80TAB6Uq0BypjrrViUNVEb6kulXbPgl4UCqa9DBVwDXyKTWtUD3ZhCPRFqiY4iQPHnFb8LSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737620751; c=relaxed/simple;
	bh=G+HbVLEKNbMvH1rlbAGCV/tmhZMIq8HDKJ/FXT5PQlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+Ft3tg2Bs8CNCm+iowAVq/6ELotwYSHDJT+OEREn79USvPsw74S0r/7trkbhzV0zeExptynGmcPYU4aILDxpyIg3WvxwBHFzV4Y5PPCMp9kzYjKafVdsKGUTLCtpiJ4lPN6UE3esrNu2PoUClZE6SvvnuLR8EY56iLcLbaLXbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ucrxVTim; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ucrxVTim"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jO5p1H+ukzz7o2pukE65/B5IqXkWWH/EDxemLRFTtB0=; b=ucrxVTim1kaFhSiDZXXzv0YnY3
	sBpQ52HHmYSnMzri/JjrwGT1ltCoLfxKhmBMKeFpyttEhoNc1xlsUQe3lWVH2/RcQzFcXjiaR/i5n
	vn0cm3JFmNSYpeg8aogJvHWJClebBIoqUHbOH9E4LH+ZGgUWZiRLpXCimZufBavT9MomQDVV4Rg18
	cb53yDLbBZrkeRsHteWhzEIznCXbhtqFOykh0MpluN0jv4WY8XJuTKsMDdFwGSeSyjXhz3Ab7KAl6
	z6rPNuqYKveqV23aRYqfCk5UqZORtWeRzItvubI8Sp3AvO434foWpgzOOgaFJX28s6+Xgp3SrBU6o
	6DGv427Q==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tasWt-00000008j1H-1xKL;
	Thu, 23 Jan 2025 08:25:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AF396300717; Thu, 23 Jan 2025 09:25:34 +0100 (CET)
Date: Thu, 23 Jan 2025 09:25:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
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
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 28/39] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250123082534.GD3808@noisy.programming.kicks-ass.net>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <6052e8487746603bdb29b65f4033e739092d9925.1737511963.git.jpoimboe@kernel.org>
 <e92fc832-ef46-4863-9316-24f30d8d82fd@efficios.com>
 <20250123040533.e7guez5drz7mk6es@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123040533.e7guez5drz7mk6es@jpoimboe>

On Wed, Jan 22, 2025 at 08:05:33PM -0800, Josh Poimboeuf wrote:

> However... would it be a horrible idea for 'next' to unwind 'prev' after
> the context switch???

The idea isn't terrible, but it will be all sorta of tricky.

The big immediate problem is that the CPU doing the context switch
looses control over prev at:

  __schedule()
    context_switch()
      finish_task_switch()
        finish_task()
	  smp_store_release(&prev->on_cpu, 0);

And this is before we drop rq->lock.

The instruction after that store another CPU is free to claim the task
and run with it. Notably, another CPU might already be spin waiting on
that state, trying to wake the task back up.

By the time we get to a schedulable context, @prev is completely out of
bounds.


