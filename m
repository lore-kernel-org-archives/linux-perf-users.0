Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1B015EFBF;
	Wed,  5 Jun 2024 20:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717619760; cv=none; b=THQXEquvGmcVewOYu+3pSg9xeFKS0pG1d0J03Xlflj/T5e9cQBTaUEG/50/3CPEWGeKKevoNGuGNAe7n/7BAJ8Lcp9cIY/4tPMZl4uMl+bO1TMKzpWGRFYTDXTtqgN2sqwh84g4po0v5CtTRm6dGrRcKgxNyi8X4Rgfn1+iW8JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717619760; c=relaxed/simple;
	bh=iO1QdpEIgNbHOwfHQbT27Mjp9EoD/V8WtCBu2eMx0Ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gC1sKbRmqmbytoR8E/d/31AKCo51CFfqncmJcGV14BCft3AqEuR1RA+ng3xTszwcgjdxs9ESnTIygJzrkyjeg2YOlcirYOKh6OzpM7KgOOW9DBw+pVbUIAtFZDq0VzhmyFMtoU0EiC1yISKPOZKKq2sMqQGTWUPWyTEmB98uBoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88B0B339;
	Wed,  5 Jun 2024 13:36:15 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 536A23F64C;
	Wed,  5 Jun 2024 13:35:48 -0700 (PDT)
Message-ID: <d89cd4b3-5839-47ce-89e2-a1f0f4d2ed6c@arm.com>
Date: Wed, 5 Jun 2024 21:35:47 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] coresight: Use per-sink trace ID maps for Perf
 sessions
To: James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
 suzuki.poulose@arm.com, gankulkarni@os.amperecomputing.com,
 mike.leach@linaro.org, leo.yan@linux.dev, anshuman.khandual@arm.com
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, John Garry
 <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-perf-users@vger.kernel.org
References: <20240604143030.519906-1-james.clark@arm.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240604143030.519906-1-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/24 15:30, James Clark wrote:
> This will allow sessions with more than CORESIGHT_TRACE_IDS_MAX ETMs
> as long as there are fewer than that many ETMs connected to each sink.

I tested this patch set on Hikey960 with below combinations:

- Only applied the kernel patches;
- Only applied the perf tool patches;
- Applied both the kernel and perf tool patches.

All of them can pass the test for `perf record` and `perf report` 
commands, I think this patch series is promised on Armv8 platform with 
small amount of CPUs.

Tested-by: Leo Yan <leo.yan@arm.com>

As you said that there might be a concern for running this patch set on 
a system with big amount of CPUs. Once you think it's ready for merging, 
please share at here.

Thanks,
Leo
