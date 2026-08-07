Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2403641DDE0;
	Fri,  7 Aug 2026 11:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786101509; cv=none; b=gX980/CVVgOZUu5QREtvDtbpBq5HoaERgyNgUbKFwYNeOplT8W9uyUy/LSTn7CUES094f+XTNHhkLKt8GRUFoLT8xba0uVFNv44qgIt8zhNL6xqT+QK4H+ZO/fErxpc/gFDv3LzmtzadttNLxZxNraEdf3KQl5vgyVMXhx0FY78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786101509; c=relaxed/simple;
	bh=UyGvst7gzz8aMp7NaIlca5Hlj4nQIZzAQEyNUPlvs9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8Ea8WpeGfI9wsaVnnxAnjOp7IUYVCI3RLXbFrelHrXfOlyL5x1heO/KvzgiZCON9omTxcQVPebdimVbXAHfGBXYk+NmRtfhMN197IdZzXmPcYgoFSIexk8/z0j3qRB8/ZFppoMFg07bgNPPWSF8wFvUf/6NbTlI1Fz2ePLYDYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GLLHEh9B; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GLLHEh9B"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XugU5f9n5F8bRW8RWLCJjZoXjblijUIJs+6+P1YYKYA=; b=GLLHEh9Bkt7kMsvaMs+LNTXL8U
	XUsVeW6lHX6X0JMNAvX3Q3xl8q98g0uw8b5wRpr5lRxdPIqqdKmxsQ5YVjbvOeZAMtFuPxBQB7wQO
	jqZgKBMyL57jFqmYxPDMZutbb34vqFmISHbfTP6mUqITv9DdUt9R0/pGVHIJtQsm1YS3oWrj42WyI
	bVg2aWhQ57L5pL6UXGZF2Yo2dxO3WP+ikx0WAF0TOVjLhDwgulMd8QJbnJgsT7/Uang/6o2reW7w5
	xloKKV3/r3nBKEslZ1JwaxtJsjuPCQ+rs5hSNo6KKGdPGMRmtsOm3Prio+iynqnZbCDoH0H7Fi1ki
	ZsqYB5mQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsIaj-00000008tUp-0wd7;
	Fri, 07 Aug 2026 11:18:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4464A30045A; Fri, 07 Aug 2026 13:18:18 +0200 (CEST)
Date: Fri, 7 Aug 2026 13:18:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ian Rogers <irogers@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Dmitrii Dolgov <9erthalion6@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>, Zecheng Li <zli94@ncsu.edu>,
	Gabriel Marin <gmx@google.com>,
	Tengda Wu <wutengda@huaweicloud.com>,
	Derek Foreman <derek.foreman@collabora.com>,
	Tanushree Shah <tshah@linux.ibm.com>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Aaron Tomlin <atomlin@atomlin.com>, tanze <tanze@kylinos.cn>,
	Rui Qi <qirui.001@bytedance.com>,
	Howard Chu <howardchu95@gmail.com>, Chuck Lever <cel@kernel.org>,
	Shimin Guo <shimin.guo@skydio.com>,
	Alessio Podda <aleph.pi.gh@gmail.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v1 0/8] perf/core, perf/tools: Add
 PERF_SAMPLE_BUILD_ID_OFFSET support
Message-ID: <20260807111818.GN687043@noisy.programming.kicks-ass.net>
References: <20260807071818.718751-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807071818.718751-1-irogers@google.com>

On Fri, Aug 07, 2026 at 12:18:10AM -0700, Ian Rogers wrote:
> This patch series introduces PERF_SAMPLE_BUILD_ID_OFFSET to the
> perf_event UAPI and implements full support across both the kernel
> and perf tools.
> 
> Background & Motivation:
> 
> In order for perf to translate virtual addresses of samples into
> symbols a file and offset within the file are needed. During event
> synthesis perf will create mmap events to facilitate the translation
> of a virtual address to a file and offset by modelling the address
> space of a process. By directly recording in a sample the Build ID of
> a file and the offset within it, no synthesis is necessary. The Build
> ID and offset as a pair are much larger than a virtual address, so
> there is a trade-off between synthesis cost and extra size for
> samples. These changes just facilitate Build ID and offset as a choice
> for perf samples and the user can have the choice to use it when they
> believe it is advantageous.
> 
> In practice perf still needs to map a build ID to a file, so by
> default this change keeps synthesis to allow this. It is expected a
> user that knows their build IDs, say through debuginfod, will disable
> this option with say --synth=no.
> 
> The kernel support uses the existing build ID and offset support used
> by BPF stack traces.

That is still a giant stinking mess that needs to cleaned up.
