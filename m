Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D071D54B;
	Wed, 12 Jun 2024 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718197974; cv=none; b=l88rF2rvGnTxMfWtFdx7sEh8+TfOLNQpip7dB4n6npjgqsz1D8QeJSd0kCwxLQIRQskcd4Kn2W1todUo8vyDr7x5W1Bu2wdes4671jYPAmGeEUAcnvdp+u4TzQfXMhqzMGFAVGSLBpfG6ZyTsAari0wPKgjABYxghHiFNKCKOQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718197974; c=relaxed/simple;
	bh=ekNK4exzHp7lebJSpQMmW+/s1FCkhYSD5M/Z+yOzaW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxGXbUmz0ljMqA6hRHZrNJ+mKX5/r10tFFMrLyfxQXirVqbn+3LyNsEevdgCtv4Rlm87Lpd9ua0NH+t6Vl5YeUrW+N3MYw4W2SzGD+aScjhZO9avYyM5sm/O5doNs409br0tSbZVIGovCFPLinpov0OB+nIhnwLWn5FJQGAEBPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B88771595;
	Wed, 12 Jun 2024 06:13:16 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69C143F64C;
	Wed, 12 Jun 2024 06:12:49 -0700 (PDT)
Message-ID: <27bd8527-4dfb-4078-8027-211dec1bc007@arm.com>
Date: Wed, 12 Jun 2024 14:12:37 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] perf pmus: Sort/merge/aggregate PMUs like
 mrvl_ddr_pmu
To: Ian Rogers <irogers@google.com>, Aishwarya TCV <aishwarya.tcv@arm.com>
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
 <CAP-5=fWxdZ1ibv7Pi0L38+NF-vNWZCtcDS9JVf6k3z9nDsrQQw@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <CAP-5=fWxdZ1ibv7Pi0L38+NF-vNWZCtcDS9JVf6k3z9nDsrQQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/06/2024 13:32, Ian Rogers wrote:
> On Wed, Jun 12, 2024 at 4:19 AM Aishwarya TCV <aishwarya.tcv@arm.com> wrote:
>>
>>
>>
>> On 15/05/2024 07:01, Ian Rogers wrote:
>>> The mrvl_ddr_pmu is uncore and has a hexadecimal address suffix while
>>> the previous PMU sorting/merging code assumes uncore PMU names start
>>> with uncore_ and have a decimal suffix. Because of the previous
>>> assumption it isn't possible to wildcard the mrvl_ddr_pmu.
>>>
>>> Modify pmu_name_len_no_suffix but also remove the suffix number out
>>> argument, this is because we don't know if a suffix number of say 100
>>> is in hexadecimal or decimal. As the only use of the suffix number is
>>> in comparisons, it is safe there to compare the values as hexadecimal.
>>> Modify perf_pmu__match_ignoring_suffix so that hexadecimal suffixes
>>> are ignored.
>>>
>>> Only allow hexadecimal suffixes to be greater than length 2 (ie 3 or
>>> more) so that S390's cpum_cf PMU doesn't lose its suffix.
>>>
>>> Change the return type of pmu_name_len_no_suffix to size_t to
>>> workaround GCC incorrectly determining the result could be negative.
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>  tools/perf/util/pmu.c  | 33 +++++++++++++--------
>>>  tools/perf/util/pmus.c | 67 ++++++++++++++++++++++++------------------
>>>  tools/perf/util/pmus.h |  7 ++++-
>>>  3 files changed, 65 insertions(+), 42 deletions(-)
>>>
>>
>> Hi Ian,
>>
>> Perf test "perf_all_PMU_test" is failing when run against
>> next-master(next-20240612) kernel with Arm64 on JUNO in our CI. It looks
>> like it is failing when run on JUNO alone. Verified by running on other
>> boards like RB5 and Ampere_altra and confirming that it does not fail on
>> these boards. Suspecting that the suffixed 'armv8_pmuv3_0' naming could
>> be the reason of test failure.
>>
>> Reverting the change (3241d46f5f54) seems to fix it.
>>
>> This works fine on Linux version v6.10-rc3
>>
>> Failure log
>> ------------
>> 110: perf all PMU test:
>> --- start ---
>> test child forked, pid 8279
>> Testing armv8_pmuv3/br_immed_retired/
>> Event 'armv8_pmuv3/br_immed_retired/' not printed in:
>> # Running 'internals/synthesize' benchmark:
>> Computing performance of single threaded perf event synthesis by
>> synthesizing events on the perf process itself:
>>   Average synthesis took: 1169.431 usec (+- 0.144 usec)
>>   Average num. events: 35.000 (+- 0.000)
>>   Average time per event 33.412 usec
>>   Average data synthesis took: 1225.698 usec (+- 0.102 usec)
>>   Average num. events: 119.000 (+- 0.000)
>>   Average time per event 10.300 usec
>>
>>  Performance counter stats for 'perf bench internals synthesize':
>>
>>         3263664785      armv8_pmuv3_0/br_immed_retired/
>>
>>
>>       25.472854464 seconds time elapsed
>>
>>        8.004791000 seconds user
>>       17.060209000 seconds sys
>> ---- end(-1) ----
>> 110: perf all PMU test                                               :
>> FAILED!
> 
> Hi Aishwarya,
> 
> Thanks for reporting an issue. The test should be pretty self
> explanatory: it is doing a `perf stat -e
> armv8_pmuv3/br_immed_retired/` and then looking for that in the
> output. The event armv8_pmuv3/br_immed_retired/ comes from running
> perf list. As you can see in the output the event did work, so perf
> stat is working so nothing is actually broken here. What isn't working
> is the perf stat output matching the command line event and this is
> because of the unnecessary suffix on ARM's PMU name.
> 
> We have a problem that ARM have buggy PMU drivers, either from
> introducing new naming conventions or by just being broken:
> https://lore.kernel.org/lkml/CAP-5=fWNDkOpnYF=5v1aQkVDrDWsmw+zYX1pjS8hoiYVgZsRGA@mail.gmail.com/
> I've also asked that ARM step up their testing, for example in the
> event parsing testing the PMU is hardcoded to the x86 PMU name of
> 'cpu':
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/parse-events.c?h=perf-tools-next#n2317
> On a cortex A53, then PMU is named 'armv8_cortex_a53':
> ```
> $ ls /sys/devices/armv8_cortex_a53/
> caps  cpus  events  format  perf_event_mux_interval_ms  power
> subsystem  type  uevent
> ```
> This name appears better, so what's up with ARM's core PMU name?
> Anyway, I'm tempted to fix this by just skipping the test on ARM given
> ARM's overall broken state.
> 

No need to skip the test, I'll take this one [1]. I think we're on the
same page that it's probably a test or cosmetic issue rather than
anything being broken in Perf.

[1]:
https://lore.kernel.org/linux-perf-users/8112b2bf-3950-4889-96bf-2317fbfb4bee@arm.com/

> Further, can we escalate matters? It isn't right that these ARM issues
> are coming back to me. ARM aren't stepping up to fix not just the 2

I wouldn't read into it too much, I think this is just a courtesy email
pointing out that we're aware of an issue and tracked it back to a
particular commit. I don't think there is any expectation that it has to
be you that makes the fix and I'm happy to look into it.

> issues above but:
> 1) the broken Apple M? issue (ARM asked I fix this as it regressed due
> to my fixes for the Intel hybrid code):
> https://lore.kernel.org/lkml/20240525152927.665498-1-irogers@google.com/
> 2) opening events on BIG.little doesn't open the event on all core PMU types:
> https://lore.kernel.org/lkml/20240510053705.2462258-4-irogers@google.com/

As I mentioned in that thread I'll fix that one too at some point, I'm
just finishing off some other stuff first.

> 3) the broken 'cycles' event name in the arm_dsu PMU:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/arm_dsu_pmu.c#n177
> 4) the ARM memory controller PMUs lacking cpumask causing events
> opened on them to be opened on every CPU and thereby induce
> multiplexing..
> and so on..
> 
> Thanks,
> Ian
> 
>> Thanks,
>> Aishwarya
