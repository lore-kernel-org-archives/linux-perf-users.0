Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E489E36AB50;
	Wed, 21 Jan 2026 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013247; cv=none; b=GWcYCN5+lF7aQkGeqlJR+NTYHAPEjVtijWOuviPv9PpHSmgdiKf1Hfx91OqygAKxotZZUsOo8YOWDyJq6ZOaAkW4kabSdh/ny9JrWM/QHFW1lP9FV0rQ1l41VL/P5Ids2HEkdsvGz/kD2vVOpEK5QFJH59PjiymB4mXv9jGu/aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013247; c=relaxed/simple;
	bh=FjYZ9mRZ18CFOgt5Ni2agOqZt9sSOJvZJXXpZWwBVZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmW0gq2rEBCo65D1rrHnnr709WsdNp3WfU0T3l0oQ+5ywaCHXo5OmcatUvlMjaqYSK5EdkNguGv402piQkbesoC3/WIrySS7w7BlZeoQltOseXxEpQt4v2lfQ5Zylx9PG5L4B9SvhKBf9wkbGxfokzUmpGrbUh9QKgOEJ3qvr6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IoXHtHNA; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IoXHtHNA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z6XMATG5PELf4FbWAT9LfU2im/gmQrESrrBPsvx1tzA=; b=IoXHtHNAOEkzgpZxzsUMG6kIeJ
	ywbr1XjSNyFU2sW0yfdv6rhRAM5n1jQgoGo74aPvF+pMmvNjeg0Csd8QgajwjwPLpPII4T/SuQUik
	NNjCU6AMg06ApiVT4R0XXqnmp1WEKMs1+EgHBkFyTdU0hRyHZn+YO13/cT1MZIBVr9yYuDy8ABorG
	FUh7EwelIshK408e45SKM/JGpGA0FnAgRknHS96m6njAyV2sbERmwScTeq2rd8qaL/iKdmjDG9iFx
	e4hGq7T9vAIndEuUPCmqn61zkfDnd2BOoK37jgChGw4NYem1cxuKrwatXCmHTt81PtFrzEBhdBd2V
	62amtwcQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vib9K-0000000GPQc-2I03;
	Wed, 21 Jan 2026 16:33:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1063E300329; Wed, 21 Jan 2026 17:33:42 +0100 (CET)
Date: Wed, 21 Jan 2026 17:33:42 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Swapnil Sapkal <swapnil.sapkal@amd.com>, ravi.bangoria@amd.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, rostedt@goodmis.org, vincent.guittot@linaro.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	gautham.shenoy@amd.com, kprateek.nayak@amd.com,
	juri.lelli@redhat.com, yangjihong@bytedance.com, void@manifault.com,
	tj@kernel.org, sshegde@linux.ibm.com, ctshao@google.com,
	quic_zhonhan@quicinc.com, thomas.falcon@intel.com,
	blakejones@google.com, ashelat@redhat.com, leo.yan@arm.com,
	dvyukov@google.com, ak@linux.intel.com, yujie.liu@intel.com,
	graham.woodward@arm.com, ben.gainey@arm.com, vineethr@linux.ibm.com,
	tim.c.chen@linux.intel.com, linux@treblig.org,
	santosh.shukla@amd.com, sandipan.das@amd.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, namhyung@kernel.org, irogers@google.com,
	james.clark@arm.com, acme@kernel.org
Subject: Re: [PATCH v5 00/10] perf sched: Introduce stats tool
Message-ID: <20260121163342.GI166857@noisy.programming.kicks-ass.net>
References: <20260119175833.340369-1-swapnil.sapkal@amd.com>
 <6a434657-5b5b-41ec-a79a-c648c2829602@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a434657-5b5b-41ec-a79a-c648c2829602@intel.com>

On Thu, Jan 22, 2026 at 12:09:25AM +0800, Chen, Yu C wrote:
> On 1/20/2026 1:58 AM, Swapnil Sapkal wrote:
> > MOTIVATION
> > ----------
> > 
> > Existing `perf sched` is quite exhaustive and provides lot of insights
> > into scheduler behavior but it quickly becomes impractical to use for
> > long running or scheduler intensive workload. For ex, `perf sched record`
> > has ~7.77% overhead on hackbench (with 25 groups each running 700K loops
> > on a 2-socket 128 Cores 256 Threads 3rd Generation EPYC Server), and it
> > generates huge 56G perf.data for which perf takes ~137 mins to prepare
> > and write it to disk [1].
> > 
> > Unlike `perf sched record`, which hooks onto set of scheduler tracepoints
> > and generates samples on a tracepoint hit, `perf sched stats record` takes
> > snapshot of the /proc/schedstat file before and after the workload, i.e.
> > there is almost zero interference on workload run. Also, it takes very
> > minimal time to parse /proc/schedstat, convert it into perf samples and
> > save those samples into perf.data file. Result perf.data file is much
> > smaller. So, overall `perf sched stats record` is much more light weight
> > compare to `perf sched record`.
> > 
> > We, internally at AMD, have been using this (a variant of this, known as
> > "sched-scoreboard"[2]) and found it to be very useful to analyse impact
> > of any scheduler code changes[3][4]. Prateek used v2[5] of this patch
> > series to report the analysis[6][7].
> > 
> > Please note that, this is not a replacement of perf sched record/report.
> > The intended users of the new tool are scheduler developers, not regular
> > users.
> > 
> > USAGE
> > -----
> > 
> >    # perf sched stats record
> >    # perf sched stats report
> >    # perf sched stats diff
> > 
> > Note: Although `perf sched stats` tool supports workload profiling syntax
> > (i.e. -- <workload> ), the recorded profile is still systemwide since the
> > /proc/schedstat is a systemwide file.
> > 
> 
> I found this is useful for load balance analysis on my
> 384 CPUs system with 6.19.0-rc1, please feel free to add
> 
> Tested-by: Chen Yu <yu.c.chen@intel.com>

Yeah, I've used a previous version for a while, was very nice.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
