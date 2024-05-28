Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EB317083D;
	Tue, 28 May 2024 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716911760; cv=none; b=LR8lNK3GhZP6DDN1sDYNNfeWqSddLVrlxncSHGGQh+MbrhBL04nkwPUV0p03ajVu9tMkaHMIT5cImoBs/BxITYJurMs5KKECFzI63ON81sdpm+9Re+uVZto5r0BlqQADBfwF1E40KG1qZyoEoesArixNqgHX4HbWuCYiyPYICps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716911760; c=relaxed/simple;
	bh=E7KVZO5kycrqp2EazwtlquGxInXGIMTLxcstfVZyAMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=o+5RSlFLWCf+vfT2vpKVAcGNf75g+yzqbDE57FVyJgVAW+Gr8GIHeBwCAgKxADA4FaIplVjQ4qz3SXk88gDQuYm+vd8xhGkza9c4b93g5lZx8F87/+/u9RwGgNh6/ebU+Q6HCckDHx4MZ2y752rpk+8I44OglSvus4fpRnLjwsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25A05339;
	Tue, 28 May 2024 08:56:22 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F0643F762;
	Tue, 28 May 2024 08:55:56 -0700 (PDT)
Message-ID: <669d0fcf-5afa-45c5-a836-eccad0884d33@arm.com>
Date: Tue, 28 May 2024 16:55:57 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf docs: Fix typos
To: Ian Rogers <irogers@google.com>
References: <20240521223555.858859-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Changbin Du <changbin.du@huawei.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240521223555.858859-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21/05/2024 23:35, Ian Rogers wrote:
> Assorted typo fixes.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: James Clark <james.clark@arm.com>

> ---
>  tools/perf/Documentation/perf-kwork.txt  | 4 ++--
>  tools/perf/Documentation/perf-mem.txt    | 2 +-
>  tools/perf/Documentation/perf-record.txt | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-kwork.txt b/tools/perf/Documentation/perf-kwork.txt
> index 109ace1d5e90..21e607669d78 100644
> --- a/tools/perf/Documentation/perf-kwork.txt
> +++ b/tools/perf/Documentation/perf-kwork.txt
> @@ -1,4 +1,4 @@
> -perf-kowrk(1)
> +perf-kwork(1)
>  =============
>  
>  NAME
> @@ -35,7 +35,7 @@ There are several variants of 'perf kwork':
>          perf kwork top
>          perf kwork top -b
>  
> -   By default it shows the individual work events such as irq, workqeueu,
> +   By default it shows the individual work events such as irq, workqueue,
>     including the run time and delay (time between raise and actually entry):
>  
>        Runtime start      Runtime end        Cpu     Kwork name                 Runtime     Delaytime
> diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
> index 19862572e3f2..47456b212e99 100644
> --- a/tools/perf/Documentation/perf-mem.txt
> +++ b/tools/perf/Documentation/perf-mem.txt
> @@ -21,7 +21,7 @@ and stores are sampled. Use the -t option to limit to loads or stores.
>  
>  Note that on Intel systems the memory latency reported is the use-latency,
>  not the pure load (or store latency). Use latency includes any pipeline
> -queueing delays in addition to the memory subsystem latency.
> +queuing delays in addition to the memory subsystem latency.
>  
>  On Arm64 this uses SPE to sample load and store operations, therefore hardware
>  and kernel support is required. See linkperf:perf-arm-spe[1] for a setup guide.
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 6015fdd08fb6..77578c0a142a 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -311,7 +311,7 @@ OPTIONS
>  	User can change the size by passing the size after comma like
>  	"--call-graph dwarf,4096".
>  
> -	When "fp" recording is used, perf tries to save stack enties
> +	When "fp" recording is used, perf tries to save stack entries
>  	up to the number specified in sysctl.kernel.perf_event_max_stack
>  	by default.  User can change the number by passing it after comma
>  	like "--call-graph fp,32".
