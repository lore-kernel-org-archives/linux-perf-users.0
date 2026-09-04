Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DACD5221E2;
	Fri,  4 Sep 2026 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542976; cv=none; b=jGTtlDJ5bun54QBKlXm2DFj7iqKkhBvCKunK3AmbNB6jocEMQg4O2FSj3VyZ98iXHqOAEV6E9aLl9IldT3XDKWrRBn/WucpeymzC0icy5w7tCpWAPq4m0cBw0zbcxYsBZ604EQ5Y/cy7PMeIw7rpyNRP4C6xrh0fLTjndmR5VyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542976; c=relaxed/simple;
	bh=CYbT0EICvFO4nzwDktOwjU04hTdf9ERPnPZiM2RvGMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3pv6jMUbCw/yY9MbEkTZNWJCyZXitnc6QOg9zKL0UBGL2m0JBhzTpAGLKyedMAVs+mRGJLEojNl9/hlf4XLBYs2I1DijZFx7U0bCBE9CgFJ39sKbPkDgspwRJkc3TsKlTSkezTXJ1A4najA4neylN9urwAF3zcnfXSMrOfgeYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jeZ/UUEl; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jeZ/UUEl"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14F4D152B;
	Fri,  4 Sep 2026 10:29:23 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EBB33F7D8;
	Fri,  4 Sep 2026 10:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788542966; bh=CYbT0EICvFO4nzwDktOwjU04hTdf9ERPnPZiM2RvGMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jeZ/UUElAWPbfMSrDM69zqOygXdFNpkmGU5/g6AutxRHmWyRISel218LM1n6lT9PW
	 8bA5zE2ysLfJX5s6nPF0E2DKAi8VOGNh/2FDpJexjFBBSkxh8LA6Pmr3OxCg+pAf5k
	 vSi9ZHewySrYelJlDD3DhhGMqByrJQyyuPWzfmho=
Date: Fri, 4 Sep 2026 18:29:24 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@linux.dev>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] perf cs-etm: Synthesize missing HW_ID mappings for
 raw trace
Message-ID: <20260904172924.GB8904@e132581.arm.com>
References: <20260821-james-cs-hw_id-output-failure-v1-0-9d532ddabcc3@linaro.org>
 <20260821-james-cs-hw_id-output-failure-v1-3-9d532ddabcc3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-james-cs-hw_id-output-failure-v1-3-9d532ddabcc3@linaro.org>

On Fri, Aug 21, 2026 at 10:50:31AM +0100, James Clark wrote:

[...]

> +static int cs_etm__synth_unformatted_trace_ids(struct cs_etm_auxtrace *etm)
> +{
> +	struct auxtrace_queues *queues = &etm->queues;
> +
> +	for (unsigned int i = 0; i < queues->nr_queues; i++) {
> +		struct auxtrace_queue *queue = &queues->queue_array[i];
> +		struct cs_etm_queue *etmq = queue->priv;
> +		u64 *cpu_data;
> +		u8 trace_id;
> +		int ret;
> +
> +		if (list_empty(&queue->head) || !etmq || etmq->format != UNFORMATTED)
> +			continue;
> +
> +		if (!intlist__empty(etmq->traceid_list))
> +			continue;
> +
> +		cpu_data = get_cpu_data(etm, queue->cpu);
> +		if (!cpu_data)
> +			return -EINVAL;
> +
> +		ret = cs_etm__metadata_get_trace_id(&trace_id, cpu_data);
> +		if (ret)
> +			return ret;

Since this is an unformatted queue, can we simply ignore the trace ID?
Instead of fetching it from the metadata, we could insert 0 to create
the trace ID list.

This would also align with future refactoring to remove trace ID
handling for unformatted queues.
