Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794404990;
	b=jmKsnVTSzR/6PCgKQoBRAl8zp1DknHPXZXTXZ0QuaviVjTe4ftxk9Dj0+ydXX0qtzczp
	 oXu17Hvc2BavIn4CJe0DTR7lDhU97bkDcZ848aX6ApwJ2qxWRbnL/GAinq18U3+/v1v7J
	 rAcHdN8Dkm+Pw8V3yYr5V3xfixAfHC+jdh4cO4ckFhDGU86CNTY8D35XrG64vYt70N0Ig
	 cD8ZCJPTyLJDy0ym9vFBBZa7WRGW/h+AhZBwiYUF5Neaboix4e3hgof96HTgpSeXQd1K6
	 p0cyFac9qBPBCXfSIBEgloK5dd3vbLG5qRGM5/O1qO+wYiYyw76NBA0bwJ0+dh1MtjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404990;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=qJKHNv+tAuyzyTj7XvGyA33mQB+6F1DGY1SOqmvoOUU=;
	b=sgbUZKGQaUKneYzOi3fr6klDKvy3GtesTyMED+in7/W34hVFHssRnw3Mey55ZSTCNiOt
	 EKROcL6IDPKPnbPhPECuVt0QvDC93MB9T3R8eiKy3v+JN2xtk2Y258FbDmkpNoj/uS8dv
	 210Z5oxXXBm/RTMgPKkDj72f/eTkGvDFQM+RNKZdX0c5ikOLVyXlMk2lPKDNW4DKOTlSn
	 YO2SN2aOoQG/vJyZkH6yOC9Mt3EcIXR3nPSmXIFN3rKnlNgBtScf/hh3VRk9mhB78u52H
	 nYKcrhDHbwDzjIf1APNvNb91Mw1ZQdEXkE8mIAb9hfL8KDT4UcnwfZkmiAd54vHXYqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PjaBupv5;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936D0606A8B9
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 13:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 936D0606A8B9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PjaBupv5
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso464719766b.2
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 05:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794404988; x=1795009788; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qJKHNv+tAuyzyTj7XvGyA33mQB+6F1DGY1SOqmvoOUU=;
        b=PjaBupv597gve+P3p0HKEDwsGo7MTjnabd2s8GwMBu4Q9+LIAbCPisZr8vZph3zmQt
         onAjKYyZZqqgiN1lax7NSmTc1N4keivcwPylX18hnWSv1ee428rbXL4PVM2qatDgfzLT
         ffN2UDC8KB7y1JpJ8PrvgS5bqMOx4EyB0tUmbFKrSZMWuB8PDPsNThg7vFlSEza12Agy
         xWoX9q2MTSZhYv5MYaGqiD+seaybtDaZenDcI3jDFpDSCQc1tbB7yaI2BA9AOSPjPqer
         +3F6iNpqagkWHBVM8xJm9oE42XWGh58mzwRoC0Cswrr/uHcejGnw5Aziy69/GWosNCQA
         ewVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794404988; x=1795009788;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qJKHNv+tAuyzyTj7XvGyA33mQB+6F1DGY1SOqmvoOUU=;
        b=c10SvKxPGLJfcxTK+5qpvyOy6jnDSfz0Z43rEpXxhz9n72FwjkBu4ocv/vRAHVIjkX
         Rx+Awo7urtH6LuGT4zyJqi8biO0r4zJODay1L/m6EjHjs0NQUUGJlG1/EAC+3uKpv0YX
         UYWg5W/zARQ969NsIQNhNoVd7EtKF+sxgDzo8rmAnOt2s9h8aaS1gEGEmHYq+k4C88nr
         iwxplUu8fRa4VYv5s3BmYy4MQRKJcsnrE+EkVfYiDd59WLVu8kGKyARSuKtlsDFTtM1d
         JlSFJZcPhHF3T4Y10HkSI0W06bC3wl8VJfNaamn+xDxApbbxvyBqRH6yzUALZZAc8Kb4
         PE0g==
X-Forwarded-Encrypted: i=1; AL+hErFOh0HXc/A3dEL23tyjPYeV3/x87dQXXfvaZAV4D9ZJ5lnAvUwKPz1zxSpKzAIzxOWBooMUlT5jP9LQ0hzOxEhS@vger.kernel.org
X-Gm-Message-State: APuU4Z8O/oxjZVgsM4sQ8Q4KzNjC28uh8aBb8SbiK4r3tdO880ABT/ly
	VqTQLgsBa9uVtQ9YDh2I19DqQJRljMAe5fFKsQ4fY/vpvajHo6/1HjfvImuQ5dfugcA=
X-Gm-Gg: AYBFou2c7Jx2bLVewDQWbJmSMQ0ah4OeqYjWCcfpeLcVFEKI0uKVmBuFCRckFcLSceo
	6NCJgyBKSdN2o/06p26k6WjFRIpxrU+pTXTAxV/C64stD9h2WTc+E4Bc65StvAlrPReN5xmuWHT
	CJc/BBClO8nbOkGFp+gwqYnsm95HwlrYqXXUlPru+SQOb01PtJaEpKf4a2eBp7YsBRPUb1tAPqn
	IH2yPPWMSHRTDM3EEAA/sCe3zcQ1yqvj3VAVQ7mzcq7rXhlA0bKT6Rnz2DMRCuVSjQf/N2om/i2
	U5qLWO2a03LiyiEJPYgP6CrEUaY7ML2U4oCriKIaHu21WEeDaBFRuQbcplK7LqeGZgsaaaEAMZC
	lg5WqHeZEemuFFiFMoXPS7wQlUTN0JrD11WUpA+ioUKMrHCXnNYxJtGRIOze3UUmBl2n4QXoWRg
	G9HCwEokr5iqAFIENswawW6wp7y6fnrcyEfegdwUbEg0P7s9NUEUnYrSMPseLF1UiBjOBDl7tMN
	i4gT+ZEfUkVp6rxLhHkDJbhv37/ZXp7QMHi+d2fS/vHYbz1nA3AuKqiUcZTAhDixj4u0gaySWeb
	vLGVp/uXHt8vgC2DQsbaeLQA3+Y6Cj962ZhcEhLG782C/8oL2DeRDCM=
X-Received: by 2002:a17:907:c14:b0:c49:b8ec:a9e3 with SMTP id a640c23a62f3a-c5066d9f119mr224374866b.43.1794404987720;
        Wed, 11 Nov 2026 05:49:47 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a655217sm235293166b.67.2026.11.11.05.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 05:49:47 -0800 (PST)
Message-ID: <2b69425a-6c5d-4a6c-adc3-6f46999372f4@linaro.org>
Date: Wed, 11 Nov 2026 13:49:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] perf test: Don't starve per-process tests with
 system-wide events
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Jakub Brnak <jbrnak@redhat.com>, Leo Yan <leo.yan@arm.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261109-james-perf-test-fixes-v4-0-355ee6b81917@linaro.org>
 <20261109-james-perf-test-fixes-v4-4-355ee6b81917@linaro.org>
 <CAP-5=fX-AuoMOL+yPXw2FsdcC5Xg7qkb-Q038U3BeB+P+Rf_Yg@mail.gmail.com>
 <2c48c893-9ab5-4883-bafb-a2580b76c4c1@linaro.org>
 <CAP-5=fUEv49Yymvw+EOwQmmKyOHqSKhRexJG_PC6HRTtgCqR=A@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fUEv49Yymvw+EOwQmmKyOHqSKhRexJG_PC6HRTtgCqR=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/11/2026 16:49, Ian Rogers wrote:
> On Tue, Nov 10, 2026 at 4:30 AM James Clark <james.clark@linaro.org> wrote:
>>
>> On 09/11/2026 17:47, Ian Rogers wrote:
>>> On Mon, Nov 9, 2026 at 5:48 AM James Clark <james.clark@linaro.org> wrote:
>>>>
>>>> Some tests intermittently fail when run in parallel, for example "Check
>>>> branch stack sampling" fails with no branches recorded at all.
>>>>
>>>> The default event is cycles:P which there may only be 1 or 2 HW counters
>>>> for on Intel because it's precise. System wide or per-core precise
>>>> events hog the HW counter leaving other per-process tests with no
>>>> samples. Rather than make all the tests that use default record commands
>>>> run serially, just make the system wide ones use a software event which
>>>> has the greatest possible compatibility. They don't need precise
>>>> sampling or HW counters anyway. The per-process tests can be left alone
>>>> as their events/processes never run concurrently on any one core.
>>>>
>>>> The LBR filter is another resource shared by all events on a CPU, and
>>>> the system-wide LBR test uses different filters to the per-process
>>>> branch stack test, so mark the LBR test as exclusive.
>>>
>>> Thanks for deflaking the tests! Making the LBR test exclusive is
>>> pragmatic; however, it also feels like a shame since recording LBR
>>> data in parallel should be something we expect users to do.
>>>
>>> For PMUs that can have a single user we have logic which prints
>>> conflicting users in dump_perf_event_processes:
>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/evsel.c?h=perf-tools-next#n4519
>>>
>>> I wonder if, when we get zero counts or no samples we could perform a
>>> similar analysis and report conflicting users—though this would
>>> inherently be racy. If we had that, maybe we could just repeat the LBR
>>> tests until there are no conflicting users and not need the exclusive
>>> tag.
>>>
>>
>> Yeah re-running the test for certain failures would probably work well.
>> But at the same time if we know certain resources are limited and we're
>> running per-CPU and per-thread events at the same time in a way that we
>> know won't multiplex at all, maybe it would be better to re-write the
>> parallel tests to only use per-thread events.
>>
>> Even when multiplexing works there can be issues. For example another
>> flake I looked at was in the metrics tests. Some of them test that the
>> ratios don't exceed 100% for example, but multiplexing can break this
>> assumption if all the counters in the metric are only in a weak group
>> and they aren't always scheduled at the same time. There was a lot to
>> unpick in that one so I dropped it. But it's a similar problem.
> 
> So because events are grouped, they should be scheduled in and out
> together. Yes a weak group can be broken, but that shouldn't happen
> with some caveats:
> 
> 1) The NMI watchdog should be gone because the buddy watchdog is good
> and doesn't take a counter. There's still tech debt because the buddy
> watchdog calls itself the NMI watchdog in procfs and the perf tool
> warns accordingly. Hopefully we're defaulting to the buddy watchdog
> these days. Rather than a boot option I wanted the watchdog to be
> selectable at runtime: none, buddy or NMI. Again, the hardest problem
> in CS is naming things and the buddy watchdog people made some now
> questionable choices.
> 2) The scaling of events on hybrid/BIG.little systems is broken. I
> sent out this RFC and should really push on it more:
> https://lore.kernel.org/lkml/20250716223924.825772-1-irogers@google.com/
> .
> 
> So the value test should never flake, and the fact that it does points
> to real bugs, both of which are in the kernel.
> 

I looked into the failing test that I saw again, I don't think my one is 
related to hybrid or multiplexing anymore, so it was probably a bad 
example. The failure is because the tma_l2_hit_latency metric exceeds 
100% in the "metric value validation" test. There are two reasons.

First one is maybe a bug, but using '-a' sums one of the terms across 
all cores which gives huge values:

   $ sudo perf stat --cputype cpu_core -M tma_l2_hit_latency -a -- 
taskset -c 0 perf bench mem memcpy -s 256KB -l 100000


    ... 3410.8 %  tma_l2_hit_latency  ...

The other one is that even on a single core, it counts multiple loads 
waiting simultaneously, so it can exceed 100%, presumably by design. 
Maybe it needs to be added to SkipList in perf_metric_validation_rules.json?

   $ sudo perf stat --cputype cpu_core -M tma_l2_hit_latency -C 0 -- 
taskset -c 0 perf bench mem memcpy -s 256KB -l 100000

   ... 262.7 %  tma_l2_hit_latency  ...


>> I think some of the kernel PMU scheduling and sharing decisions expect
>> that any root user running things per-CPU is "well behaved" or
>> understands the impact to other users that their events might have. And
>> we're probably not doing that enough in the tests to honor that.
> 
> An area I think we're bad on is BPF perf event filtering. The tracing
> code has notions of instances, we lack similar concepts for perf
> events, so one profiler may derail another. I think we can improve
> multiplexing by taking inspiration from the EEVDF scheduler. Again, I
> have some plans and paper improvements in this area, but the challenge
> is getting feedback.
> 
>> Another example for this is with Arm BRBE. There are multiple counters
>> on the PMU, so you can have multiple events, but there's only one BRBE
>> and one filter, and the branch history is limited. The driver takes the
>> union of filters for all the PMU events running and then post processes
>> the branch buffer for each user to not leak anything from the other
>> event's filter. But imagine that one test gives a certain restricted
>> filter and expects to completely fill up the branch buffer, and that
>> exact full buffer is required for the test. When another root event runs
>> in parallel on the same core, the filter can be widened and the buffer
>> gets blown up with other branches that weren't interesting to the other
>> test, and are filtered out by the driver anyway making it fail.
> 
> I think we should avoid system wide profiling for the tests, that
> should mitigate issues like this. We need system-wide profiling for
> uncore events.
> 

I suppose if we went and converted them all to per-process some coverage 
could be lost though. We can probably keep chipping away at the flakes 
and judge it case by case.

> Thanks,
> Ian
> 
>>> Anyway, doing all of that is a bigger project.
>>>
>>
>> Yep. and maybe something to keep in mind for any new tests or when doing
>> further flake investigations.
>>
>>> Reviewed-by: Ian Rogers <irogers@google.com>
>>>
>>
>> Thanks!
>>
>>> Thanks,
>>> Ian
>>>
>>>> This fixes the "Check branch stack sampling" test and other flakes when
>>>> a system-wide record from another test runs at the same time, for
>>>> example:
>>>>
>>>>     $ sudo perf record -a -o /dev/null -- sleep 30 &
>>>>     $ sudo perf test -vvv "Check branch stack sampling"
>>>>     ...
>>>>     Testing user branch stack sampling
>>>>     ERROR: Branches missing ^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL/.*$
>>>>     ...
>>>>     Testing user branch stack sampling [Failed]
>>>>     ...
>>>>     Testing branch stack filtering permutation (call,CALL|SYSCALL)
>>>>     Testing branch stack filtering [Failed empty script output]
>>>>     ...
>>>>     ---- end(-1) ----
>>>>     138: Check branch stack sampling : FAILED!
>>>>
>>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>>> ---
>>>>    tools/perf/tests/shell/record.sh          | 6 +++---
>>>>    tools/perf/tests/shell/record_lbr.sh      | 2 +-
>>>>    tools/perf/tests/shell/record_sideband.sh | 4 ++--
>>>>    3 files changed, 6 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
>>>> index 01dc3e22fa73..e4789e2bcf43 100755
>>>> --- a/tools/perf/tests/shell/record.sh
>>>> +++ b/tools/perf/tests/shell/record.sh
>>>> @@ -388,7 +388,7 @@ test_system_wide() {
>>>>      echo "Basic --system-wide mode test"
>>>>      local ret=0
>>>>      perf_record_with_retry "${perfdata}" "check_system_wide" "perf test -w thloop" \
>>>> -    -aB --synth=no || ret=$?
>>>> +    -aB --synth=no -e cpu-clock || ret=$?
>>>>      if [ $ret -eq 2 ]; then
>>>>        echo "System-wide record [Skipped not supported]"
>>>>        return
>>>> @@ -471,7 +471,7 @@ test_cgroup() {
>>>>      echo "Cgroup sampling test"
>>>>      local ret=0
>>>>      perf_record_with_retry "${perfdata}" "check_cgroup" "perf test -w thloop" \
>>>> -    -aB --synth=cgroup --all-cgroups || ret=$?
>>>> +    -aB --synth=cgroup --all-cgroups -e cpu-clock || ret=$?
>>>>      if [ $ret -eq 2 ]; then
>>>>        echo "Cgroup sampling [Skipped not supported]"
>>>>        return
>>>> @@ -491,7 +491,7 @@ test_uid() {
>>>>      echo "Uid sampling test"
>>>>      local ret=0
>>>>      perf_record_with_retry "${perfdata}" "check_uid" "perf test -w thloop" \
>>>> -    -aB --synth=no --uid "$(id -u)" || ret=$?
>>>> +    -aB --synth=no --uid "$(id -u)" -e cpu-clock || ret=$?
>>>>      if [ $ret -eq 2 ]; then
>>>>        local logfile="${PERF_RECORD_LOGS[${#PERF_RECORD_LOGS[@]}-1]}"
>>>>        if grep -q -E "libbpf.*EPERM|Access to performance monitoring" "$logfile" || \
>>>> diff --git a/tools/perf/tests/shell/record_lbr.sh b/tools/perf/tests/shell/record_lbr.sh
>>>> index 8d51afeb437b..6b6af59db871 100755
>>>> --- a/tools/perf/tests/shell/record_lbr.sh
>>>> +++ b/tools/perf/tests/shell/record_lbr.sh
>>>> @@ -1,6 +1,6 @@
>>>>    #!/bin/bash
>>>>    # SPDX-License-Identifier: GPL-2.0
>>>> -# perf record LBR tests
>>>> +# perf record LBR tests (exclusive)
>>>>
>>>>    set -e
>>>>
>>>> diff --git a/tools/perf/tests/shell/record_sideband.sh b/tools/perf/tests/shell/record_sideband.sh
>>>> index 2182551873be..f16889e3fa9a 100755
>>>> --- a/tools/perf/tests/shell/record_sideband.sh
>>>> +++ b/tools/perf/tests/shell/record_sideband.sh
>>>> @@ -22,7 +22,7 @@ trap trap_cleanup EXIT TERM INT
>>>>
>>>>    can_cpu_wide()
>>>>    {
>>>> -    if ! perf record -o ${perfdata} -BN --no-bpf-event -C $1 true > /dev/null 2>&1
>>>> +    if ! perf record -o ${perfdata} -BN --no-bpf-event -e cpu-clock -C $1 true > /dev/null 2>&1
>>>>        then
>>>>            echo "record sideband test [Skipped cannot record cpu$1]"
>>>>            err=2
>>>> @@ -39,7 +39,7 @@ test_system_wide_tracking()
>>>>        can_cpu_wide 1 || return 0
>>>>
>>>>        # Record on CPU 0 a task running on CPU 1
>>>> -    perf record -BN --no-bpf-event -o ${perfdata} -C 0 -- taskset --cpu-list 1 true
>>>> +    perf record -BN --no-bpf-event -e cpu-clock -o ${perfdata} -C 0 -- taskset --cpu-list 1 true
>>>>
>>>>        # Should get MMAP events from CPU 1
>>>>        mmap_cnt=`perf script -i ${perfdata} --show-mmap-events -C 1 2>/dev/null | grep MMAP | wc -l`
>>>>
>>>> --
>>>> 2.43.0
>>>>
>>

