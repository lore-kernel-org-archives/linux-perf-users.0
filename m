Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC0F38AC7D
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jun 2026 11:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781694720; cv=none; b=JZGTjmIhrVauWX8D+Ubg0VtfZFFNQbmn0odneG7O2zbQRW3/z3C5wuuBYBm12veMY9M7PToqNNGQxGlOcaB3xVCt6StTuqOJjUMXTPk3VMOh8bsMDG2OSFxfYsgrc3Zd4+xm5vcwvtIgdsEh2NkIT9eQAlGrYpNnLKdFqvH1wQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781694720; c=relaxed/simple;
	bh=sV4JLlxysKqqLtfS+lU5GOlCV5cwun57z/a79Z97I9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtJINdXh4xWORCVAmpk5e+XH4U8NWlCoNKvTlAWM0k+NrrN3+FjvR7KjZIYsheM4EUtaP9x8upiQ+4i6Z2bI3EsGbPds/ta7lGWe/YLgt5DRrJrQwx2GrDDfrIq7bGGtCnKpRFkbtUS2rGokuPawI3uwuQg5TFDHXBrjgWQD1v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Fuz4zdPN; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Fuz4zdPN"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 013972D97;
	Wed, 17 Jun 2026 04:11:47 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C4413F915;
	Wed, 17 Jun 2026 04:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781694711; bh=sV4JLlxysKqqLtfS+lU5GOlCV5cwun57z/a79Z97I9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fuz4zdPNdxaOaJJpgqLpgcyPxV6sWHE6vOdrGxcupMpy0DOg1Jty4hUHezyjcYd99
	 OGRLPz+mcBNKf5m0TajaNyE9SzRF/jre8UiRkNC9RiWLAFnnOSZBegyrXG5ziPJPcV
	 vuDlW/iS6Kmh6H8p45y57XbC/MNA1JiQmwfyr3+Y=
Date: Wed, 17 Jun 2026 12:11:49 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Al Grant <al.grant@arm.com>,
	Paschalis Mpeis <paschalis.mpeis@arm.com>,
	Amir Ayupov <aaupov@fb.com>
Subject: Re: [PATCH v9 9/9] perf test: Add Arm CoreSight callchain test
Message-ID: <20260617111149.GC31870@e132581.arm.com>
References: <20260616-b4-arm_cs_callchain_support_v1-v9-0-f8fad931c413@arm.com>
 <20260616-b4-arm_cs_callchain_support_v1-v9-9-f8fad931c413@arm.com>
 <00183ce3-e387-4ca3-9eb8-67aa6a1221e5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00183ce3-e387-4ca3-9eb8-67aa6a1221e5@linaro.org>

On Wed, Jun 17, 2026 at 09:38:42AM +0100, James Clark wrote:

[...]

> > +noinline void callchain_do_syscall(void)
> > +{
> > +	syscall(SYS_getpid);
> 
> I get this error when compiling for x86, but it works on Arm:
> 
> tests/workloads/callchain.c:17:10: error: use of undeclared identifier
> 'SYS_getpid'; did you mean '__getpgid'?
>         syscall(SYS_getpid);
>                 ^~~~~~~~~~
>                 __getpgid
> /usr/include/unistd.h:659:16: note: '__getpgid' declared here
> extern __pid_t __getpgid (__pid_t __pid) __THROW;

Thanks for finding this.

This is not the issue for program itself actually, it contains
tools/arch/x86/include/uapi/asm/unistd_64.h rather than uAPI headers
provided in toolchain or kernel.

At current stage, we can simply change to syscall(SYS_gettid) to
workaround the issue.
