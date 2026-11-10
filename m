Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313818;
	b=1NkU6aDxbn5LQAeSzbM1EtiJ50y6EcSFCAe83Ankcl8FYInAdsynCfk2T4CC7/aXLa7t
	 Y4ZtaToJ//7VU3KWNubE1mT5AXn/P7yTRFfsOhoHH7do5dQ/Bbq39AwpLI8660Z0nQFO2
	 NIzO+FzN+RvvYoizrkShI+b+XGE9QP/JCk8mLg+A+T8gKO96gUynwl+quho8pNGmr7oDX
	 h6Pah1fo5y/7p1GvZjETBMhjuPrOz+y+/x9iDQLhdr+COR0i+HJKpJ+3/FAc0Cm6JDdUk
	 UkMu+oPMa/y5QDxrcJ5/xRw/7ianjczLHnwB7OKYqi9s/BycnVYO5ClAxi0pX4mTUBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313818;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=JP/dGdfwWQydgthlrN6yeuOBqNKzMLjOTRv8+TWyZKU=;
	b=ZfU4dVO8QSCNHWAenl+byHjF40/88QBbPsC/YFrRJfENBGMJJRcxaVh4Y6PFlOCDIgw4
	 fx5AFEZJLu5Byj8jsGRIA43VFDWb1veSrcmBE76xTb9edlg14+aXov8vB3YIspAp/IC39
	 X2ZHSYPlSwCOGsHXq12jGegFGCmwXBsN50hMl7arCLloVXXyPA4M3M+Pi0B0vAOWy7/fV
	 /GHZcBjX45P3h1q7gu66gnRWlmdE9lZ3fi3VDXxxbvp/ONluazrwzBdy/ag5/3OYxhldo
	 dem/FkhWtI7lao5jA7wkw3cBttgsW/Z1aU8jVjyhi2hflAOtlJu1sAykLlH/sq9ShPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Xk36xlTE;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5D4606A32A
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 12:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C5D4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Xk36xlTE
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-492690dd5daso1373496f8f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 04:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794313817; x=1794918617; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JP/dGdfwWQydgthlrN6yeuOBqNKzMLjOTRv8+TWyZKU=;
        b=Xk36xlTEF0ioEKjMvXNMUkuhrhkvit9edCIpjSWLn78+65cAYcZdm5OIYmME6njfGa
         I3PmrHoIWWSyVNpweNH2lPo1asDUPFgCzu+QmNUBHFYTch+b/ggeQC1Cm/0oAtExwIRN
         TkyyvUtS6zCX226E4p3QzDH5tjvzsFOIH9Jpjs8m6iA/nYfuTEOXShHCNouQhvuDuTt6
         17x9Dbo3JsJnq3pj2H88SE+iRji/ophutrTUrnn2e2m6CLxs5QFssMYXSNzQrfVvQmIL
         rp5nFPGrbC+JoVQUCIKKzNKpWqc9XEU+OxX7UpxzMW7geLDuY1BE5OZ5lRPZw3wUOnA0
         PNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794313817; x=1794918617;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JP/dGdfwWQydgthlrN6yeuOBqNKzMLjOTRv8+TWyZKU=;
        b=K+l+hMVuZfdXP7l3aEKq6BDL0vaLkYtrydu/qJjjOaeCFoRsSqx3sui5iMSqu+AApI
         S71IGf4PJQhzQl4U7BBdGzteoycYnIdC7gY262Jf/d6HTsdsFh9F8LiX1hcLNQ8OQ8FM
         YYBPe4PUFrwoKd47BLgsQudHzuQDE0xTa/rWPSvUxiD4vnXxZRkQ8d+W6EQ5MFyS/7pi
         uqOisGKjnix6LQDDzUHKjXc4zfheXTiNmlyA7kOX3+GXE07ZwgF/YyGdGYVhMO2fiB8V
         Xy0wGC82Rn9b510VsW3gcrjpyq4Fj2NhxCjT04p3r/RtHFFYva0E81uV9xQLt+t2HU5I
         E4Pw==
X-Forwarded-Encrypted: i=1; AL+hErFxfP3qsTJPUoH/6ABQDAmqxfFvvlMBomdLzdRio0PT8SC95sHyN+Np3sx1DnZXSAu1vNPObnS2An3nbtglvR/a@vger.kernel.org
X-Gm-Message-State: APuU4Z9iqXb680rZfjHgT2mfrC12ERSYzxte2vWwu2oRLsWHw5sckolT
	n1SwySbcBOSKgtnsLGy+ygzYcIKCARwaZ9VVBjEStS3DOxICHDEmfpY7MdIt1PEdIe0=
X-Gm-Gg: AYBFou1gMWkYO/E0+OiKVgumA0jpFdoZ1QNskVVUBHnyXdzolxzWT24qaTvuyFymoLz
	gvwnBImBkhrr6cDozMyZTwoZI8bg74thrDUNm0/O/02xv1gYf/hqmlrGuus+jFAamNdMqmrKo6F
	AOs+zIlnZyoXnvWjWxuBnWElqAquLdr82j/2oZ45uGcO/Rpd5TOo3R6nFStnYu4qlWrMXgGK7gL
	n7fMogSM/Wko+Ye72gnkHIrheM3KhdxWOZgNX4B6/UfLVS45B+M5W+MG1Fp4osNF0vHnxZDPGJC
	CHcoZIcfX0Z7XCzG5kiRZxZuTVOfAsnsrcPvFiUH3xgNi0cKJp2g6qhxM3rKFuaHhSbDj+fp5oi
	73OxbBB5m06U53MDdlfkGk51XiifbhoeLpknFAgORXqHghKhbZzV8u119oVI0xwWNh1OaXohlSh
	simRkWMYuUpmbu9ehfGIDMoCl62KjKW5agVy4Jyz8wj4h0gIlNoKvRYckeYqLo5iS4GZaspyexf
	kZOiPL9/gT1t6rZmaKdtZmk/ESyQ7+IfJCU/WLpnPBZWI8pNwO7Gk0ImEye+m5b1ZUnBytIbmY1
	ooyHx1JKUELwudA3utmWxOisvk2vFrOUIQ==
X-Received: by 2002:a05:6000:2212:b0:48b:9ed:b81f with SMTP id ffacd0b85a97d-4982e641b33mr4399759f8f.10.1794313816583;
        Tue, 10 Nov 2026 04:30:16 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983f7801bbsm4692945f8f.5.2026.11.10.04.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 04:30:15 -0800 (PST)
Message-ID: <2c48c893-9ab5-4883-bafb-a2580b76c4c1@linaro.org>
Date: Tue, 10 Nov 2026 12:30:14 +0000
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
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fX-AuoMOL+yPXw2FsdcC5Xg7qkb-Q038U3BeB+P+Rf_Yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 09/11/2026 17:47, Ian Rogers wrote:
> On Mon, Nov 9, 2026 at 5:48 AM James Clark <james.clark@linaro.org> wrote:
>>
>> Some tests intermittently fail when run in parallel, for example "Check
>> branch stack sampling" fails with no branches recorded at all.
>>
>> The default event is cycles:P which there may only be 1 or 2 HW counters
>> for on Intel because it's precise. System wide or per-core precise
>> events hog the HW counter leaving other per-process tests with no
>> samples. Rather than make all the tests that use default record commands
>> run serially, just make the system wide ones use a software event which
>> has the greatest possible compatibility. They don't need precise
>> sampling or HW counters anyway. The per-process tests can be left alone
>> as their events/processes never run concurrently on any one core.
>>
>> The LBR filter is another resource shared by all events on a CPU, and
>> the system-wide LBR test uses different filters to the per-process
>> branch stack test, so mark the LBR test as exclusive.
> 
> Thanks for deflaking the tests! Making the LBR test exclusive is
> pragmatic; however, it also feels like a shame since recording LBR
> data in parallel should be something we expect users to do.
> 
> For PMUs that can have a single user we have logic which prints
> conflicting users in dump_perf_event_processes:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/evsel.c?h=perf-tools-next#n4519
> 
> I wonder if, when we get zero counts or no samples we could perform a
> similar analysis and report conflicting users—though this would
> inherently be racy. If we had that, maybe we could just repeat the LBR
> tests until there are no conflicting users and not need the exclusive
> tag.
> 

Yeah re-running the test for certain failures would probably work well. 
But at the same time if we know certain resources are limited and we're 
running per-CPU and per-thread events at the same time in a way that we 
know won't multiplex at all, maybe it would be better to re-write the 
parallel tests to only use per-thread events.

Even when multiplexing works there can be issues. For example another 
flake I looked at was in the metrics tests. Some of them test that the 
ratios don't exceed 100% for example, but multiplexing can break this 
assumption if all the counters in the metric are only in a weak group 
and they aren't always scheduled at the same time. There was a lot to 
unpick in that one so I dropped it. But it's a similar problem.

I think some of the kernel PMU scheduling and sharing decisions expect 
that any root user running things per-CPU is "well behaved" or 
understands the impact to other users that their events might have. And 
we're probably not doing that enough in the tests to honor that.

Another example for this is with Arm BRBE. There are multiple counters 
on the PMU, so you can have multiple events, but there's only one BRBE 
and one filter, and the branch history is limited. The driver takes the 
union of filters for all the PMU events running and then post processes 
the branch buffer for each user to not leak anything from the other 
event's filter. But imagine that one test gives a certain restricted 
filter and expects to completely fill up the branch buffer, and that 
exact full buffer is required for the test. When another root event runs 
in parallel on the same core, the filter can be widened and the buffer 
gets blown up with other branches that weren't interesting to the other 
test, and are filtered out by the driver anyway making it fail.

> Anyway, doing all of that is a bigger project.
> 

Yep. and maybe something to keep in mind for any new tests or when doing 
further flake investigations.

> Reviewed-by: Ian Rogers <irogers@google.com>
> 

Thanks!

> Thanks,
> Ian
> 
>> This fixes the "Check branch stack sampling" test and other flakes when
>> a system-wide record from another test runs at the same time, for
>> example:
>>
>>    $ sudo perf record -a -o /dev/null -- sleep 30 &
>>    $ sudo perf test -vvv "Check branch stack sampling"
>>    ...
>>    Testing user branch stack sampling
>>    ERROR: Branches missing ^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL/.*$
>>    ...
>>    Testing user branch stack sampling [Failed]
>>    ...
>>    Testing branch stack filtering permutation (call,CALL|SYSCALL)
>>    Testing branch stack filtering [Failed empty script output]
>>    ...
>>    ---- end(-1) ----
>>    138: Check branch stack sampling : FAILED!
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   tools/perf/tests/shell/record.sh          | 6 +++---
>>   tools/perf/tests/shell/record_lbr.sh      | 2 +-
>>   tools/perf/tests/shell/record_sideband.sh | 4 ++--
>>   3 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
>> index 01dc3e22fa73..e4789e2bcf43 100755
>> --- a/tools/perf/tests/shell/record.sh
>> +++ b/tools/perf/tests/shell/record.sh
>> @@ -388,7 +388,7 @@ test_system_wide() {
>>     echo "Basic --system-wide mode test"
>>     local ret=0
>>     perf_record_with_retry "${perfdata}" "check_system_wide" "perf test -w thloop" \
>> -    -aB --synth=no || ret=$?
>> +    -aB --synth=no -e cpu-clock || ret=$?
>>     if [ $ret -eq 2 ]; then
>>       echo "System-wide record [Skipped not supported]"
>>       return
>> @@ -471,7 +471,7 @@ test_cgroup() {
>>     echo "Cgroup sampling test"
>>     local ret=0
>>     perf_record_with_retry "${perfdata}" "check_cgroup" "perf test -w thloop" \
>> -    -aB --synth=cgroup --all-cgroups || ret=$?
>> +    -aB --synth=cgroup --all-cgroups -e cpu-clock || ret=$?
>>     if [ $ret -eq 2 ]; then
>>       echo "Cgroup sampling [Skipped not supported]"
>>       return
>> @@ -491,7 +491,7 @@ test_uid() {
>>     echo "Uid sampling test"
>>     local ret=0
>>     perf_record_with_retry "${perfdata}" "check_uid" "perf test -w thloop" \
>> -    -aB --synth=no --uid "$(id -u)" || ret=$?
>> +    -aB --synth=no --uid "$(id -u)" -e cpu-clock || ret=$?
>>     if [ $ret -eq 2 ]; then
>>       local logfile="${PERF_RECORD_LOGS[${#PERF_RECORD_LOGS[@]}-1]}"
>>       if grep -q -E "libbpf.*EPERM|Access to performance monitoring" "$logfile" || \
>> diff --git a/tools/perf/tests/shell/record_lbr.sh b/tools/perf/tests/shell/record_lbr.sh
>> index 8d51afeb437b..6b6af59db871 100755
>> --- a/tools/perf/tests/shell/record_lbr.sh
>> +++ b/tools/perf/tests/shell/record_lbr.sh
>> @@ -1,6 +1,6 @@
>>   #!/bin/bash
>>   # SPDX-License-Identifier: GPL-2.0
>> -# perf record LBR tests
>> +# perf record LBR tests (exclusive)
>>
>>   set -e
>>
>> diff --git a/tools/perf/tests/shell/record_sideband.sh b/tools/perf/tests/shell/record_sideband.sh
>> index 2182551873be..f16889e3fa9a 100755
>> --- a/tools/perf/tests/shell/record_sideband.sh
>> +++ b/tools/perf/tests/shell/record_sideband.sh
>> @@ -22,7 +22,7 @@ trap trap_cleanup EXIT TERM INT
>>
>>   can_cpu_wide()
>>   {
>> -    if ! perf record -o ${perfdata} -BN --no-bpf-event -C $1 true > /dev/null 2>&1
>> +    if ! perf record -o ${perfdata} -BN --no-bpf-event -e cpu-clock -C $1 true > /dev/null 2>&1
>>       then
>>           echo "record sideband test [Skipped cannot record cpu$1]"
>>           err=2
>> @@ -39,7 +39,7 @@ test_system_wide_tracking()
>>       can_cpu_wide 1 || return 0
>>
>>       # Record on CPU 0 a task running on CPU 1
>> -    perf record -BN --no-bpf-event -o ${perfdata} -C 0 -- taskset --cpu-list 1 true
>> +    perf record -BN --no-bpf-event -e cpu-clock -o ${perfdata} -C 0 -- taskset --cpu-list 1 true
>>
>>       # Should get MMAP events from CPU 1
>>       mmap_cnt=`perf script -i ${perfdata} --show-mmap-events -C 1 2>/dev/null | grep MMAP | wc -l`
>>
>> --
>> 2.43.0
>>

