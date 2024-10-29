Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F491205E12;
	Tue, 29 Oct 2024 13:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730209703; cv=none; b=Tt4Q/rpqJrIzsGbtopzI3OxfAYCjnPcjpMF+GZLDnE9BzDiubr1ht5Pw+jrptIEvJzeA/50VoeXQfbLCGBZXoWIBOtCAH0qieReJLYgzJo+pJBc+QPPyOxQ26oOiPni5LdWtS/v2tXY0YztX8MCFPBYZtVIEK6qGSaoSrAqGixQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730209703; c=relaxed/simple;
	bh=I+EHbGr2mQRXlWga/E1SaEry12fnOHrzMXisiQcG8T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVSJsYddP4xVH61UN6HRjtO7zvoN8hbSWBYx0MhPYN22r5bNJGbSdqxspfwXCKS8D607xJ3SehujU+prHuCxKypNiHpQ+J19xVEdkGlYieExsXgopR7X0K7kDBOyBvVq6fAkwo2vOJZJR+pA8nA61efzquOAVGqyDqIL/TWj5u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QM/tp925; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QM/tp925"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oJ5DV/UcQ+ikEONgBc7qCDCzreaqUoflYR+9p1+c5Q8=; b=QM/tp925rD1E3VzhtXQIvDCuDe
	lfSjZV1aZeoLIepXZEmNnbKzfp3HJyo7W/g33Pw+pMWxOoBOTCJxIHoVCSVo/03cmm1y/ylxw8dqb
	Z0F+QZsdPZcxnYY+l4lOem+xgX4NPq6cki/GbMNalLL6tRN/co8R0jmDo5qZwzj+mlURSlSNP7X77
	aiCaCN9yRTcQlwurMpSF1Ief7Lu5Oi7PIzE3Djdc5DhUFWiCD+furCDXgZ+cqKZVJpY4xRxVJsFQM
	7gfB3wtVfg1U5HJ+6lbUSBo2YXw6t2mKVXuvtjQgHK4Ng5YUfnSXuOCvBk1EdTbVtEwgGrb0Gz0Qc
	LAqL3dbw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t5mZr-00000009kya-1pvw;
	Tue, 29 Oct 2024 13:48:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4CAFC30073F; Tue, 29 Oct 2024 14:48:07 +0100 (CET)
Date: Tue, 29 Oct 2024 14:48:07 +0100
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
Message-ID: <20241029134807.GZ14555@noisy.programming.kicks-ass.net>
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

> +/*
> + * The "context cookie" is a unique identifier which allows post-processing to
> + * correlate kernel trace(s) with user unwinds.  It has the CPU id the highest
> + * 16 bits and a per-CPU entry counter in the lower 48 bits.
> + */
> +static u64 ctx_to_cookie(u64 cpu, u64 ctx)
> +{
> +	BUILD_BUG_ON(NR_CPUS > 65535);
> +	return (ctx & ((1UL << 48) - 1)) | cpu;
> +}

Did you mean to: (cpu << 48) ?
