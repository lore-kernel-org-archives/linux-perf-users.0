Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D1F185E;
	Mon, 13 May 2024 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715610958; cv=none; b=kiOwWDU+0O9KeHdUUJa6leqYil6HMc12eg1aWPEdzNpmQfKSAaHhyaZzF+59SRKc/SBlHrkA/8yPzCZRWn0wx8CUeojlEdB/7wbKwmmW7ySw73JUx8aHqRqfIY5IwoyGdRndKOgopw0q5On2JXUc66wgy+p39UCjsxYbvCxGUBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715610958; c=relaxed/simple;
	bh=WSXI9MXhlrXxHPeLSW0/uP1SfeIiG3D+XQjGy1TUxu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hEPnC0KkGagBEknkr1NQxMlzHZ3MruonsXOJBIyBqEkzQPFtmWn9GdLDXrXAE3Yc80JvhkC5S37gG8nFy5VhufpG4tpTV2Ps4iYw3UmuvXb0nJalhYXJMwM84BVMW9I6WV4fEY9NpJzgXiGg9Sqp93tXsdjn3r5bQdQHdY57pgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 170701007;
	Mon, 13 May 2024 07:36:19 -0700 (PDT)
Received: from [10.57.4.233] (unknown [10.57.4.233])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24FCF3F7A6;
	Mon, 13 May 2024 07:35:50 -0700 (PDT)
Message-ID: <34da7677-9c77-4efa-ae32-e0ef9a94013d@arm.com>
Date: Mon, 13 May 2024 15:35:43 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] perf pmus: Sort/merge/aggregate PMUs like
 mrvl_ddr_pmu
To: Ian Rogers <irogers@google.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Bhaskara Budiredla <bbudiredla@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 Stephane Eranian <eranian@google.com>,
 Tuan Phan <tuanphan@os.amperecomputing.com>
References: <20240505031624.299361-1-irogers@google.com>
 <CAP-5=fVSAQOXbSfpSLTVkWcZKGx+LqiuC_ZkCxnc0iPtyfrzvQ@mail.gmail.com>
 <CAP-5=fXuneU6ockdzFcnLGqATKkEfvEuTa778Hj92rBmkbiS1w@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAP-5=fXuneU6ockdzFcnLGqATKkEfvEuTa778Hj92rBmkbiS1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-05-10 8:15 pm, Ian Rogers wrote:
> On Fri, May 10, 2024 at 11:13 AM Ian Rogers <irogers@google.com> wrote:
>>
>> On Sat, May 4, 2024 at 8:16 PM Ian Rogers <irogers@google.com> wrote:
>>>
>>> The mrvl_ddr_pmu is uncore and has a hexadecimal address
>>> suffix. Current PMU sorting/merging code assumes uncore PMU names
>>> start with uncore_ and have a decimal suffix. Add support for
>>> hexadecimal suffixes and add tests.
>>>
>>> v3. Rebase and move tests from pmus.c to the existing pmu.c.
>>>
>>> Ian Rogers (2):
>>>    perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
>>>    perf tests: Add some pmu core functionality tests
>>
>> Hi, these patches have been hanging around since March [1], it would
>> be nice to either be landing them or getting feedback on what to fix.
>>
>> Thanks,
>> Ian
>>
>> [1] https://lore.kernel.org/lkml/20240329064803.3058900-1-irogers@google.com/
> 
> +Tuan Phan, Robin Murphy
> 
> Here is another PMU with the same suffix convention/issue:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/drivers/perf/arm_dmc620_pmu.c?h=perf-tools-next#n706

There are at least one or two more as well - certainly arm_smmuv3_pmu 
which I think may have been where this pattern first started. Now that 
we've finally done the right thing with the parent mechanism to provide 
a user-visible relationship of PMU instances to their corresponding 
Devicetree/ACPI devices, hopefully we can discourage any further use of 
this rather clunky trick of using the MMIO address as an identifier in 
the PMU name. However there's then also stuff like dwc_pcie_pmu which 
encodes a PCI ID as a hex suffix, so understanding hex suffixes in 
general might still be a reasonable idea for the tool, if the 
alternative would be maintaining a list of specific prefixes (even if 
that would be hoped to remain fairly small).

Thanks,
Robin.
