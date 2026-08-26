Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6387C31DDBF;
	Wed, 26 Aug 2026 23:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787786402; cv=none; b=SZM2FLv2ufDEbcULABuCY5IqoWmWQ3ScenhAsW5Tzrmln6vXLIq6HblQVqK6+G/8sicakYsVXOQcM0cHj4rYg2TM6/9/Lh9T0f1+oL7MSH/lHH8gJHZj8LDhr2KdR72DZpgQAt1RG0gDv9YWHE4j9MxHuSWaLyMPuJw/3cbORgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787786402; c=relaxed/simple;
	bh=Gi+veHaIdJkcoJ2ky7AoluO6xEQmdmLdq2CNhla9eHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZoSahCGAgYjx5N4fAC0NHLi+NZeOjG7laN7S73jigYlM6r3kZpiqUDgXJN9LxuRbxjl4WoCQhEbf4Cmey1yWMlP5Kx/GJ0spezGfXIjRqETh0iQpRsT8WqUV+KyS8pIbisRayfwHNDagZyTrIjli2Lhaepow2ZcH5MMv915FVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jI99VHBf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jI99VHBf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5AB1F000E9;
	Wed, 26 Aug 2026 23:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787786401;
	bh=sk1vPTGMkM7XXXwYGPRGhOvlPkcmKpLv375upyKHUvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jI99VHBfWGV6Uh3hIKTpChCRqY/yhMfQ+qFYpwPXWB6frAjkVUGvmgIx9fpd7SAPl
	 cf9iEL2DLIBOAK3gm/sW1zf73TEQHEpcSnB8UAhHj5xS46rFd4c2Xm1od8Te57Lqzg
	 HDxcyNdvmfK3tF9i2adzHeYL0qy26OmGMvBB+6ZKJhhoL2tJSa2VSaMlQXJt66CkQU
	 ABWrjygq8XIjGexdgCLKCkit3ZRgbI4s+eSDRfbpjppldy1lhG1t361Erleov9Sm8Q
	 qI3SGjRIMNjOWBo7NL4XrIIG/TACwxKyt7q8L01lpOc6Ut9fYAtU1Kw1m4mR08+qQ5
	 kgPZvoAqENRWw==
Date: Wed, 26 Aug 2026 16:19:57 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ian Rogers <irogers@google.com>, Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <ao90ncOA2Ce8ezIc@google.com>
References: <20260807071818.718751-1-irogers@google.com>
 <20260807111818.GN687043@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260807111818.GN687043@noisy.programming.kicks-ass.net>

Hello,

On Fri, Aug 07, 2026 at 01:18:18PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 07, 2026 at 12:18:10AM -0700, Ian Rogers wrote:
> > This patch series introduces PERF_SAMPLE_BUILD_ID_OFFSET to the
> > perf_event UAPI and implements full support across both the kernel
> > and perf tools.
> > 
> > Background & Motivation:
> > 
> > In order for perf to translate virtual addresses of samples into
> > symbols a file and offset within the file are needed. During event
> > synthesis perf will create mmap events to facilitate the translation
> > of a virtual address to a file and offset by modelling the address
> > space of a process. By directly recording in a sample the Build ID of
> > a file and the offset within it, no synthesis is necessary. The Build
> > ID and offset as a pair are much larger than a virtual address, so
> > there is a trade-off between synthesis cost and extra size for
> > samples. These changes just facilitate Build ID and offset as a choice
> > for perf samples and the user can have the choice to use it when they
> > believe it is advantageous.
> > 
> > In practice perf still needs to map a build ID to a file, so by
> > default this change keeps synthesis to allow this. It is expected a
> > user that knows their build IDs, say through debuginfod, will disable
> > this option with say --synth=no.
> > 
> > The kernel support uses the existing build ID and offset support used
> > by BPF stack traces.
> 
> That is still a giant stinking mess that needs to cleaned up.

Then we can discuss how we want to handle that as well. :)

I think this work would be useful on large systems with lots of tasks.
I've got reports it took too long on synthesis and timed out.  Also it's
racy and easy to miss new tasks..

So I think it's a good option to explore and maybe we can make default
once it turns out working great.  But I'm afraid it may need some kind
of optimization to handle multiple addresses like in callchains/LBRs.

Thanks,
Namhyung

