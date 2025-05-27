Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDDE1F4CAC;
	Tue, 27 May 2025 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748339372; cv=none; b=nXe4oRA+yyMNu5F0h413z1a/U6XAz/gnUwS3+8upmeG1mxizYBxynSchZwh4JgmIpXpOXL6DHpfK461KJuhmYifEaF0IqmKWoF8k3cl4+2lE2nR2GIaGQS65zwsG1Cw6rqVgWU+ZIlt7IMbgfI1Z0+kXSpeugwGIvPFzl9/sGWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748339372; c=relaxed/simple;
	bh=+h6UbpfiTWqp32wSjTJpECkbEu5qI0YU/w+MW0bl3ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czyXKAZg7k2G1vnSfZSveOgQ3L2dhMlfXJxR84B8kCepXl0hvJpGY/bhgfagw4klTBn5oyyMEGOgPAJoL9+7FS9Pp7+JOkRcqTrBZ7irOKcfCQMOMY6X2ifLeGkuSUCaHpSjsrqmYc22ZElnk1kzeVViqc499/thGz+fPG6bT5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FF7A14BF;
	Tue, 27 May 2025 02:49:13 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C6083F673;
	Tue, 27 May 2025 02:49:28 -0700 (PDT)
Date: Tue, 27 May 2025 10:49:24 +0100
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tests switch-tracking: Fix timestamp comparison
Message-ID: <20250527094924.GF2566836@e132581.arm.com>
References: <20250331172759.115604-1-leo.yan@arm.com>
 <aC_Vn95vYqcXul03@x1>
 <aC_WFRe_4HjVPUrM@x1>
 <20250523081036.GB2566836@e132581.arm.com>
 <aDCsmjb7Fex1ccOW@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDCsmjb7Fex1ccOW@x1>

On Fri, May 23, 2025 at 02:12:58PM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> Thanks for the extra info, I'll add it to the commit log message, and
> perhaps we could make this test exclusive and use stress-ng to generate
> some background noise in the form of a good number of processes, see:
> 
> root@x1:~# stress-ng --switch $(($(nproc) * 2)) --timeout 30s & for a in $(seq 50) ; do perf test switch ; done

Thanks for sharing the test command.

> Now with your patch it also fails, so its for another reason:
> 
> --- start ---
> test child forked, pid 1777071
> Using CPUID GenuineIntel-6-BA-3
> mmap size 528384B
> 45221 events recorded
> Missing comm events
> ---- end(-1) ----
> 113: Track with sched_switch                                         : FAILED!
> 
> Lots of short lived processes makes it fail as well :-\

I searched internal CI record, we also occasionally saw the error:

  Missing cycles events

I will find time to check if anything in test can be improved.  Seems
to me, the test is fragile if system has background activities.

> Your patch is correct, so I'll probably just add your comments and go
> with it.

Thanks!  Also thanks Ian's suggestion for the iteration command.

Leo
