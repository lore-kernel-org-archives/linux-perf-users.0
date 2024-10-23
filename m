Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4C515B0E2;
	Wed, 23 Oct 2024 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676047; cv=none; b=JAifPdwFKTd2MBazfmsv9NwUBcgRHP5NDfAEFuz1LVn6biIU9LJX0YRarCm2Rh8v2BCiMAfk7FspRX2nv7l8BVI4NBYmGqlAf1q7tW+6FN4owU5e35eVhHVKuxfn56gu5RIhvRYh9pbc5Ga8lyeoqMGJQzFYlmPQPNtUuM7PvXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676047; c=relaxed/simple;
	bh=iHUY89vn25umH+1yGshHz52mTMNZow05R42xVeaG8HU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZpbpZtqXKYbqaBevtWT70ish5/dW42a+PpqYaqWvQwJjTBInCpZQes6VJ3EJMC/KOpqER/KgWBgXgf3g/1e/4dsJjtrx3jKrtgAQMRvEhw/ZHZsRYNyVOIl8H9Zte3v/b7hFFWVzt7j0aNYedvJAt+3qnqNyaihkzamYsL988U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9C5E497;
	Wed, 23 Oct 2024 02:34:34 -0700 (PDT)
Received: from [10.57.88.34] (unknown [10.57.88.34])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D2983F71E;
	Wed, 23 Oct 2024 02:34:02 -0700 (PDT)
Message-ID: <060b220d-f7d6-4594-9b2b-e878a2ba98c6@arm.com>
Date: Wed, 23 Oct 2024 10:33:54 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] perf Documentation: Describe the PMU naming
 convention
To: Ian Rogers <irogers@google.com>, "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>,
 Tuan Phan <tuanphan@os.amperecomputing.com>,
 Thomas Richter <tmricht@linux.ibm.com>,
 Bhaskara Budiredla <bbudiredla@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, Stephane Eranian <eranian@google.com>
References: <20240606044959.335715-1-irogers@google.com>
 <c7d6eedb-7c5e-4411-a83f-4328dc75ec46@linux.intel.com>
 <CAP-5=fXY2Ofr_GRc7Mq7BfoR+2150o8e1JeyGctcGPRG70DqPg@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAP-5=fXY2Ofr_GRc7Mq7BfoR+2150o8e1JeyGctcGPRG70DqPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-10-23 5:06 am, Ian Rogers wrote:
> On Thu, Jun 6, 2024 at 11:15 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2024-06-06 12:49 a.m., Ian Rogers wrote:
>>> It is an existing convention to use suffixes with PMU names. Try to
>>> capture that convention so that future PMU devices may adhere to it.
>>>
>>> The name of the file and date within the file try to follow existing
>>> conventions, particularly sysfs-bus-event_source-devices-events.
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>>> ---
>>>   .../testing/sysfs-bus-event_source-devices    | 24 +++++++++++++++++++
>>>   1 file changed, 24 insertions(+)
>>>   create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices
>>>
>>
>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> 
> Thanks for all the reviews. Could we land this?

Hmm, it's not always going to be strictly true as written though - we 
will also have cases where multiple PMU instances owned by the same 
driver don't all support the same events/filters/etc., and/or are 
entirely unrelated such that the same event encoding may mean completely 
different things. I've just landed a driver where not only are the 
instances going to be heterogeneous (since it's for arbitrary bits of 
interconnect), but for hierarchy reasons the most logical place to put 
the instance ID in the name wasn't even at the end :(

FWIW I think if we want to nail down a strict ABI, it would seem more 
robust to have an explicit attribute to describe underlying PMU 
properties like whether instances do represent identical "slices" or 
not. The hex suffix thing is already proving how fragile names alone are 
liable to be.

Thanks,
Robin.

> 
> Thanks,
> Ian
> 
>>> diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices b/Documentation/ABI/testing/sysfs-bus-event_source-devices
>>> new file mode 100644
>>> index 000000000000..79b268319df1
>>> --- /dev/null
>>> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices
>>> @@ -0,0 +1,24 @@
>>> +What: /sys/bus/event_source/devices/<pmu>
>>> +Date: 2014/02/24
>>> +Contact:     Linux kernel mailing list <linux-kernel@vger.kernel.org>
>>> +Description: Performance Monitoring Unit (<pmu>)
>>> +
>>> +             Each <pmu> directory, for a PMU device, is a name
>>> +             optionally followed by an underscore and then either a
>>> +             decimal or hexadecimal number. For example, cpu is a
>>> +             PMU name without a suffix as is intel_bts,
>>> +             uncore_imc_0 is a PMU name with a 0 numeric suffix,
>>> +             ddr_pmu_87e1b0000000 is a PMU name with a hex
>>> +             suffix. The hex suffix must be more than two
>>> +             characters long to avoid ambiguity with PMUs like the
>>> +             S390 cpum_cf.
>>> +
>>> +             Tools can treat PMUs with the same name that differ by
>>> +             suffix as instances of the same PMU for the sake of,
>>> +             for example, opening an event. For example, the PMUs
>>> +             uncore_imc_free_running_0 and
>>> +             uncore_imc_free_running_1 have an event data_read;
>>> +             opening the data_read event on a PMU specified as
>>> +             uncore_imc_free_running should be treated as opening
>>> +             the data_read event on PMU uncore_imc_free_running_0
>>> +             and PMU uncore_imc_free_running_1.

