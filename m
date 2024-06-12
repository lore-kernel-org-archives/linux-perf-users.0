Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A0F16F0F3;
	Wed, 12 Jun 2024 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195301; cv=none; b=IrMMrqMG/dmbbSKcBhOgpI1HYUgfTEiBxDlxz5funbH3MkFfcKzQ7M1KBAPGf8fgYLucC+5cOuBuUfzvgMF8H4nIjM0sH+MiNkacZIiX5M46fGGqAP6SMKloguUaCWWez84jF/Uw1Mcsu1PV1/RVEd7Bt71kdVIG3+jv4nHQras=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195301; c=relaxed/simple;
	bh=CbHzrsS2xuvw8cRx5w/aRlruF8LSrUFindAXw2+MRag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rHTKtO25O8/DDcJcB7HUzH/p7bK/OeYMNUdotA1bXh3GpxNcA7DKx7hDNr5SSPUbZgCm3AaC8R9MMDXTTRO4X+DgoWK7o5ThL7oM++WEB/h3CEZFIpUJqUzpGAfiCaliYH3QOYihsDo4ocRBWbQ4XEaM8OoRVuNrtpzhpDtuycw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FBF11595;
	Wed, 12 Jun 2024 05:28:41 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EDF23F64C;
	Wed, 12 Jun 2024 05:28:14 -0700 (PDT)
Message-ID: <8112b2bf-3950-4889-96bf-2317fbfb4bee@arm.com>
Date: Wed, 12 Jun 2024 13:28:08 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] perf pmus: Sort/merge/aggregate PMUs like
 mrvl_ddr_pmu
To: Aishwarya TCV <aishwarya.tcv@arm.com>, Ian Rogers <irogers@google.com>
Cc: Tuan Phan <tuanphan@os.amperecomputing.com>,
 Robin Murphy <robin.murphy@arm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Bhaskara Budiredla <bbudiredla@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria
 <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 Stephane Eranian <eranian@google.com>, Mark Brown <broonie@kernel.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>
References: <20240515060114.3268149-1-irogers@google.com>
 <20240515060114.3268149-2-irogers@google.com>
 <ce31a50b-53db-4c6f-9cb1-242280b0951c@arm.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <ce31a50b-53db-4c6f-9cb1-242280b0951c@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/06/2024 12:19, Aishwarya TCV wrote:
> 
> 
> On 15/05/2024 07:01, Ian Rogers wrote:
>> The mrvl_ddr_pmu is uncore and has a hexadecimal address suffix while
>> the previous PMU sorting/merging code assumes uncore PMU names start
>> with uncore_ and have a decimal suffix. Because of the previous
>> assumption it isn't possible to wildcard the mrvl_ddr_pmu.
>>
>> Modify pmu_name_len_no_suffix but also remove the suffix number out
>> argument, this is because we don't know if a suffix number of say 100
>> is in hexadecimal or decimal. As the only use of the suffix number is
>> in comparisons, it is safe there to compare the values as hexadecimal.
>> Modify perf_pmu__match_ignoring_suffix so that hexadecimal suffixes
>> are ignored.
>>
>> Only allow hexadecimal suffixes to be greater than length 2 (ie 3 or
>> more) so that S390's cpum_cf PMU doesn't lose its suffix.
>>
>> Change the return type of pmu_name_len_no_suffix to size_t to
>> workaround GCC incorrectly determining the result could be negative.
>>
>> Signed-off-by: Ian Rogers <irogers@google.com>
>> ---
>>  tools/perf/util/pmu.c  | 33 +++++++++++++--------
>>  tools/perf/util/pmus.c | 67 ++++++++++++++++++++++++------------------
>>  tools/perf/util/pmus.h |  7 ++++-
>>  3 files changed, 65 insertions(+), 42 deletions(-)
>>
> 
> Hi Ian,
> 
> Perf test "perf_all_PMU_test" is failing when run against
> next-master(next-20240612) kernel with Arm64 on JUNO in our CI. It looks
> like it is failing when run on JUNO alone. Verified by running on other
> boards like RB5 and Ampere_altra and confirming that it does not fail on
> these boards. Suspecting that the suffixed 'armv8_pmuv3_0' naming could
> be the reason of test failure.
> 
> Reverting the change (3241d46f5f54) seems to fix it.
> 
> This works fine on Linux version v6.10-rc3
> 
> Failure log
> ------------
> 110: perf all PMU test:
> --- start ---
> test child forked, pid 8279
> Testing armv8_pmuv3/br_immed_retired/
> Event 'armv8_pmuv3/br_immed_retired/' not printed in:
> # Running 'internals/synthesize' benchmark:
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>   Average synthesis took: 1169.431 usec (+- 0.144 usec)
>   Average num. events: 35.000 (+- 0.000)
>   Average time per event 33.412 usec
>   Average data synthesis took: 1225.698 usec (+- 0.102 usec)
>   Average num. events: 119.000 (+- 0.000)
>   Average time per event 10.300 usec
> 
>  Performance counter stats for 'perf bench internals synthesize':
> 
>         3263664785      armv8_pmuv3_0/br_immed_retired/
> 
> 
>       25.472854464 seconds time elapsed
> 
>        8.004791000 seconds user
>       17.060209000 seconds sys
> ---- end(-1) ----
> 110: perf all PMU test                                               :
> FAILED!
> 
> Thanks,
> Aishwarya
> 

I can take this one, the test can probably be relaxed to not care about
the suffix. Or maybe change what we print in the stat output to match
the string that the event was opened with.

Not sure which way is best yet but it will probably become more obvious
after some digging.

James

