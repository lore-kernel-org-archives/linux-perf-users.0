Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB81213E76;
	Wed, 22 Jan 2025 14:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555390; cv=none; b=qi36A6zISQx+VoNJ/pBFoVAXsXLBYjdK/Ndrjx1wwiMwFj175sqR8Xww+Jxavx8yBMMOjj1V5BMYGj/8Suc6t3UibCuLfUr9vb9bMRhzIpzr6VLvv8TfKMexzu4NarNmQdTxNR6nOvevAuCKSCamboIKoIuzZPzSTjv8oqEAlIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555390; c=relaxed/simple;
	bh=tHs6y4qvlG4b6NS1Cx8G9An7vpdnqIB39HJHt5VcwH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkoVNiE7l1u/9NDcBnh5XIoiWvDZSWhsNqnjYxFNOoItEWyCiT72V+Xd9V2/f6MiCHUVLRXptk6NcTYzZj3jCB7MJaGDy3W0+hczKIQPGCVYJvwdRhgqKxwGg3J8ezxB10Zr+f9vIlqu0YrlCNItX15qXLuvTEtTZHhS4wzfna8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RTIY9hke; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RTIY9hke"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=znr8wEH7iY38HBQMrtk9JsRdDCeHeefPno1hhfThrLc=; b=RTIY9hke9jzFgMn9lHfgCkIB2/
	0WBuftG1ZmTnJzeeAN0G8dKehLS1s5yi5l7Z+tY4da/andAz3ZyP378X5wieOOrTzdpwshcC+b6qy
	IOETEYk2M8OUY7Ct4gUHmHMsSAQBlwtqGK7f+ne1qXN+kpCjwXYGalHi/Ph4WHdC/OZPxTi8zC26h
	dG0DHuD8NxprkgcSDCbLfVruvysZa3uJUp60nGeHE2gikKqUrdN4gU21I+988cUZttAAwxHsFphgn
	WC6wzZQ9S82o7dmKcgLrPKzOvhgAoL9x7Zf8KSZ19Bphtqh+UvF1TqpEBuCt5b9Cpsn6Csy+FAZcy
	fsZNgWog==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tabWi-00000001H42-3HUR;
	Wed, 22 Jan 2025 14:16:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 53216300599; Wed, 22 Jan 2025 15:16:16 +0100 (CET)
Date: Wed, 22 Jan 2025 15:16:16 +0100
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
Subject: Re: [PATCH v4 28/39] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250122141616.GU7145@noisy.programming.kicks-ass.net>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <6052e8487746603bdb29b65f4033e739092d9925.1737511963.git.jpoimboe@kernel.org>
 <20250122133730.GQ7145@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122133730.GQ7145@noisy.programming.kicks-ass.net>

On Wed, Jan 22, 2025 at 02:37:30PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 21, 2025 at 06:31:20PM -0800, Josh Poimboeuf wrote:
> > +/*
> > + * The context cookie is a unique identifier which allows post-processing to
> > + * correlate kernel trace(s) with user unwinds.  The high 12 bits are the CPU
> 
> s/12/16/ ?
> 
> > + * id; the lower 48 bits are a per-CPU entry counter.
> > + */
> > +static u64 ctx_to_cookie(u64 cpu, u64 ctx)
> > +{
> > +	BUILD_BUG_ON(NR_CPUS > 65535);
> > +	return (ctx & ((1UL << 48) - 1)) | (cpu << 48);
> > +}

Also, I have to note that 0 is a valid return value here, which will
give a ton of fun.

