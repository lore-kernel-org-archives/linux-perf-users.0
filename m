Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757CD2C21C7
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781181739; cv=none; b=YZUVbFLMzdb138m8EtZn32AHGII32U+ZkQh6AYz8cO0KNAHBzayXhMCpE88MNs1LFw57c+ASa5vpCrNpuxRvgKBsVd/HQ+zWX0xQGC8KshmVMqniiyysanV3p0Z6d+78WmgxNsj44w2f0mDsfo4mBumF8Y9WEqU+eA8hf4q/o2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781181739; c=relaxed/simple;
	bh=MSudZ5zCzii3klUWWm5+I6Li1DcZAve7/o6hW7n+OBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8esJxEIzv9JkRD5iQOpIH1oC0GVcm4sfpGOlx+EicWe6slWsDBrB94v4UTWydztCZFTEgvojOgzWqqaTSLyKqpX1ZmF+C3u70wUXS1uoOaXOZU2D/gCR9GpOI39mkrUKRMe/TgdECfrL0Wdx5lMwK3vXhpT7aMhAlBKjA0z5fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DOYVnOIZ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DOYVnOIZ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0400C497;
	Thu, 11 Jun 2026 05:42:12 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B70E3FD88;
	Thu, 11 Jun 2026 05:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781181736; bh=MSudZ5zCzii3klUWWm5+I6Li1DcZAve7/o6hW7n+OBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DOYVnOIZVOG54P+iZ8fsBoQ2cxMCONmAJLNk1I8SaIdNqPXPXDbVUcxqZzugyRg57
	 rhMcfwNIOSoenHsMC4IXjirg3vrQb7kt8hIMkHrauLsJDwBvPUeV4m/9xI6KrnN4JU
	 +MQ9VgNXKuTTmwMeEhCLBTXMr3SlDemCyB0AmzUQ=
Date: Thu, 11 Jun 2026 13:42:14 +0100
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
Subject: Re: [PATCH v7 8/8] perf test: Add Arm CoreSight callchain test
Message-ID: <20260611124214.GX101133@e132581.arm.com>
References: <20260611-b4-arm_cs_callchain_support_v1-v7-0-1ba770c862ae@arm.com>
 <20260611-b4-arm_cs_callchain_support_v1-v7-8-1ba770c862ae@arm.com>
 <c6f6766b-ef3f-4260-9569-620d351027ff@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6f6766b-ef3f-4260-9569-620d351027ff@linaro.org>

On Thu, Jun 11, 2026 at 10:11:37AM +0100, James Clark wrote:
> 
> 
> On 11/06/2026 8:57 am, Leo Yan wrote:
> > Add a CoreSight shell test for synthesized callchains.
> > 
> > The test uses the new callchain workload to generate trace and decodes
> > it with synthesis callchain. It then verifies that the instruction
> > samples show the expected callchain push and pop.
> > 
> > Use control FIFOs so tracing starts only around the workload, which
> > keeps the trace data small. The test is limited to arm64 systems with
> > the cs_etm event available.
> > 
> > After:
> > 
> >    perf test 136 -vvv
> >    136: CoreSight synthesized callchain:
> >    --- start ---
> >    test child forked, pid 3539
> >    ---- end(0) ----
> >    136: CoreSight synthesized callchain			: Ok
> > 
> > Assisted-by: Codex:GPT-5.5
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > ---
> >   tools/perf/Documentation/perf-test.txt        |   6 +-
> >   tools/perf/tests/builtin-test.c               |   1 +
> >   tools/perf/tests/shell/coresight/callchain.sh | 168 ++++++++++++++++++++++++++
> >   tools/perf/tests/tests.h                      |   1 +
> >   tools/perf/tests/workloads/Build              |   2 +
> >   tools/perf/tests/workloads/callchain.c        |  24 ++++
> 
> Maybe "syscall" is a better name? There's not any difference between this
> one and others like the deterministic one I added with regards to the
> callchain.

The callchain workload has function calls in userspace and system call
for the switch between userspace and kernel.

Connecting to another comment for not static attribute to avoid LTO's
function name tweaking, I will rename functions with prefix
"callchain_", this can dismiss concern for naming conflict.

For above two reasons, I will keep the name.

Thanks,
Leo
