Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8B212E1F6;
	Mon, 24 Jun 2024 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719222909; cv=none; b=gGhIKuxcn3ufBD8Re8D3qlt9UIfLhDqQdeE1UIrUzzuMsu1Jw/uYYd4vGqxhv+4upvHGh+YHRNsYbHL3EEAQDM3gOBzXsxwbLEi2eILWbYfqS3YnQxRVdrHGGxE5g86Y8cE2KusW1DHm9/UMMCk35a1goocDbLmXuv7uqFHMqys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719222909; c=relaxed/simple;
	bh=v/VLYrHvVkTUrCyMvPKpBePUaxRKbdUISF2/lIX6ftk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ila7rb/+Evubg8T7bko1pHzbfrUHjgQADOwoCzxpHSN+h9EzT1xDJacMc6qykPP61Lv1QxIGql4IOD8SMd0G1VQrauNx25w5IVqV2Du/Dqw9ajJhfoLwX2L+QFhfOzQMy41U1A/+rKTH1/qRZWHWr3l08Ujgu9dCZWfjOuigZAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABEB6DA7;
	Mon, 24 Jun 2024 02:55:30 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 687FC3F766;
	Mon, 24 Jun 2024 02:55:02 -0700 (PDT)
Message-ID: <7212d3ff-bbf8-43f2-835d-0a1289f1fed9@arm.com>
Date: Mon, 24 Jun 2024 10:55:03 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] perf mem: Support multiple Arm SPE PMUs
To: Leo Yan <leo.yan@arm.com>
References: <20240623133437.222736-1-leo.yan@arm.com>
Content-Language: en-US
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240623133437.222736-1-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23/06/2024 14:34, Leo Yan wrote:
> This patch series is to enable multiple Arm SPE PMUs.
> 
> The patch 01 is to enable multiple Arm SPE PMUs. The second patch is to
> print out warning if not all CPUs support memory events, this can give
> users a hint that the memory profiling is absent on some CPUs.
> 
> 
> Leo Yan (2):
>   perf arm-spe: Support multiple Arm SPE PMUs
>   perf mem: Warn if memory events are not supported on all CPUs
> 
>  tools/perf/arch/arm/util/pmu.c |  2 +-
>  tools/perf/util/mem-events.c   | 14 ++++++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 

Reviewed-by: James Clark <james.clark@arm.com>
