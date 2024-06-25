Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE0713B59B;
	Tue, 25 Jun 2024 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334164; cv=none; b=p8q0aCqa2de5S+KqvfuxtK3d+LlyCoiFFNeQcscferE2UScjJMEKiVJK141+GzXKGiP5rMnk8Ww9BxEIEXX2reCLFSlVXRxFUIVUcSFyNEvCutIzw3+6cNij3zUBP96c81vEsAaF76ZMlAHt+end49fpxHW5gRK2GavqvmPrza4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334164; c=relaxed/simple;
	bh=KU29cSyrpGCrZGGbLe3egrdUubbv/YWZgRMXLPSd0Fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m2GDrFXOOFhVo9r47BdHnxtSZO+fQB4zaIFrxYpsDfzD6WOZRhzpiYxbiu7eP2WLmIxBxYGxPzVPEBcX9PfCLVQXptl/yWtCVSCl2H0s/covINx/zTTstrZCNUMTJYFSlfxyOooYEGLevZq0nyXDJfh7maqSWP6otjX7G3UiLTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CA7B339;
	Tue, 25 Jun 2024 09:49:45 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CBC53F73B;
	Tue, 25 Jun 2024 09:49:18 -0700 (PDT)
Message-ID: <86fd1484-7b9a-4da3-8e1d-91e5881df832@arm.com>
Date: Tue, 25 Jun 2024 17:49:16 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] perf arm-spe: Support multiple Arm SPE PMUs
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 James Clark <james.clark@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240623133437.222736-1-leo.yan@arm.com>
 <20240623133437.222736-2-leo.yan@arm.com>
 <CAP-5=fWgGR-L6V5RNNpTHdHyT0wTOqKd3CQ8xQSQDAJ1D2edYA@mail.gmail.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <CAP-5=fWgGR-L6V5RNNpTHdHyT0wTOqKd3CQ8xQSQDAJ1D2edYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ian,

On 6/24/24 17:16, Ian Rogers wrote:
> On Sun, Jun 23, 2024 at 6:34 AM Leo Yan <leo.yan@arm.com> wrote:
>>
>> A platform can have more than one Arm SPE PMU. For example, a system
>> with multiple clusters may have each cluster enabled with its own Arm
>> SPE instance. In such case, the PMU devices will be named 'arm_spe_0',
>> 'arm_spe_1', and so on.
>>
>> Currently, the tool only supports 'arm_spe_0'. This commit extends
>> support to multiple Arm SPE PMUs by detecting the substring 'arm_spe'.
>>
>> Signed-off-by: Leo Yan <leo.yan@arm.com>
>> ---
>>   tools/perf/arch/arm/util/pmu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
>> index 8b7cb68ba1a8..29cfa1e427ed 100644
>> --- a/tools/perf/arch/arm/util/pmu.c
>> +++ b/tools/perf/arch/arm/util/pmu.c
>> @@ -27,7 +27,7 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
>>                  pmu->selectable = true;
>>                  pmu->is_uncore = false;
>>                  pmu->perf_event_attr_init_default = arm_spe_pmu_default_config;
>> -               if (!strcmp(pmu->name, "arm_spe_0"))
>> +               if (strstr(pmu->name, "arm_spe"))
> 
> Why not use strstarts?

Indeed, strstarts() is better, will spin for this.

Thank for suggestion.
Leo
