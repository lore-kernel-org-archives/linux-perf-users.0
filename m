Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567B542076
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 10:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721386776; cv=none; b=LVx53ztip++f4VJ8A7yh9Li3mYe82JWoHERphfplBP23KIAcXfoN3CJbNx0t7IXV/QrEPMoPOsDFXVh1fqStWQTR8JLUmkS+ecDyafL0i/wuhyUi9XAEgcPe0VpjNw1MfejjP8JAKWhrBOyNtKDZgh0JwltWMbvMpgHk9BDforQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721386776; c=relaxed/simple;
	bh=+hL+ZGaJfZrCECNqLt2CP+y7qQbgeUny41yzTZrzuMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ulWGKHHXFsOblSoWGiouW3vIJ4acevOrViXrEOqbIxkUxbBftgDPJ8kbehxKgMxtM/FpA3LOw0I5XLkRcyVm4WyjMT1jbN0IjQCDDmUBQOlIugJnA+vCbo9Bjj9NUsswSUW1vJhKhHHF4YdXT6xWHxYXS5lFXHTMNGzZNxLT8s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pieLsA6o; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pieLsA6o"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4266b1f1b21so12232905e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 03:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721386773; x=1721991573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yqYbd30xrhHmWbB/SwQIS462wtk8d1XL/rLufJbQRJA=;
        b=pieLsA6oAvZNIAUHQgE21V8N5M1N8XRvSHE7CZ9t3p5L5B9C9F+yukUqz9i2qOSZrn
         ed1R7NXjaUhIX+7QMsQBw/hZYhjl6IHLyP72Nq+HI1JQNbq4OV4Ns5Zq/Aqb3tASpBjF
         TvF8lpU906shqIB4dN3H8QydAaEWp6A4CPG9yAM66msRez8tRYicdsWT7ZfZDW3emmzA
         cp3Lb4Zhs4k+M5tfGL7apejdgXTwvm26tH5V7Fxh4D9SAA020+E52NQiAIcKX3dllbAT
         9lTRLO0VQczssBI4WIYbQH/60cX1vgY833bcW5IPD1xJfwxB1mFpS9gy6uWjOHDnhKWv
         /+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721386773; x=1721991573;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yqYbd30xrhHmWbB/SwQIS462wtk8d1XL/rLufJbQRJA=;
        b=AoQO05YDuZUC/jHysA1IFP2X1itGiSjO3CPF9lcr+RuzTV01zmtOLNa/PTL8bFx53U
         AIlqcbYhHWoFBRfBNHu3kG3vrvJY1AARRceYBhnCU84ZcYuxIRVPzsymuVmdAEi2WypE
         SNwFzh2eoLNaHq9tfVLjeL9SVdSubeum5I2at9tg6oM4CwSlq9wd90IP9BhB4zFFimpv
         cnPDZPADBhl5GcIj+vJdwzAYFR0iNgX/qOw66GNTBJRjRcd31iT1jeELqiDoarbTRUMh
         OGeEj/VUeENWsxK2jV5+3af88EGToQjjF6P4dCWq34aRTXKxeQyJ0x5+sUhTqOKT7n7V
         8/Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUAjOGG41zlzGpf+Uzwx8a1g/Rjley0ja62pmHXicODj9t+zWjeaC8IvTSh3N9Ey591Jsct/itL+BMzWQAy2Gs/DwyrFGitG28TM0Qy9rtZOw==
X-Gm-Message-State: AOJu0YwdJhvQiIzHohePFkyBVqJ1o4IM6vTNdW0T5PaM9WRHy/aGVgRH
	0I1YaxNwW0ssYeZS/YfkDez7i6k573yviS0HVAwryAVo1kSqvBPRlAHZ2ab+CZE=
X-Google-Smtp-Source: AGHT+IEktBp/QZKt9ogbjsBHrll6cZxrmyD5aT9re7eNy2LMckfNIXxI9nkGTQ29AND6WtEKBtv0Gg==
X-Received: by 2002:a05:600c:3ca6:b0:426:61af:e1d6 with SMTP id 5b1f17b1804b1-427c2d1c665mr57081685e9.29.1721386772560;
        Fri, 19 Jul 2024 03:59:32 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d6929976sm20101115e9.29.2024.07.19.03.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 03:59:32 -0700 (PDT)
Message-ID: <5bda2d14-ed2c-4d2a-b5b6-e9eb292d4af0@linaro.org>
Date: Fri, 19 Jul 2024 11:59:31 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kselftest/arm64: Add coresight test
To: Jeremy Szu <jszu@nvidia.com>, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kselftest@vger.kernel.org
Cc: will@kernel.org, linux-arm-kernel@lists.infradead.org,
 james.clark@arm.com, bwicaksono@nvidia.com,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>, linux-perf-users@vger.kernel.org,
 coresight@lists.linaro.org
References: <20240710062732.18999-1-jszu@nvidia.com>
 <ZpAeZjNJLesSJqm1@arm.com> <12a84dc1-ad94-4546-ad3d-72f3e0b0bfab@linaro.org>
 <34327425-80c6-4346-95c9-fa15f9381e1e@nvidia.com>
 <b940e617-22b3-495b-a97e-42aad45f0ed6@linaro.org>
 <7c7e9337-bbf7-43f2-9b67-aa175b0c1b56@nvidia.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <7c7e9337-bbf7-43f2-9b67-aa175b0c1b56@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

+cc linux-kselftest@vger.kernel.org

On 19/07/2024 11:21 am, Jeremy Szu wrote:
> 
> 
> James Clark 於 7/17/24 10:48 PM 寫道:
>>
>>
>> On 16/07/2024 3:06 am, Jeremy Szu wrote:
>>> Hi James,
>>>
>>> Thank you for your reply.
>>>
>>> James Clark 於 7/12/24 5:01 PM 寫道:
>>>>
>>>>
>>>> On 11/07/2024 7:03 pm, Catalin Marinas wrote:
>>>>> On Wed, Jul 10, 2024 at 02:27:32PM +0800, Jeremy Szu wrote:
>>>>>> Add a script to test the coresight functionalities by performing the
>>>>>> perf test 'coresight'.
>>>>>>
>>>>>> The script checks the prerequisites and launches a bundle of
>>>>>> Coresight-related tests with a 180-second timeout.
>>>>>>
>>>>
>>>> Hi Jeremy,
>>>>
>>>> On the whole I'm not sure running the Perf tests under kself tests 
>>>> is a good fit. We're already running all the Perf tests in various 
>>>> CIs, so this is going to duplicate effort. Especially with setup and 
>>>> parsing of the results output.
>>>>
>>>> There is also no clean line between what's a kernel issue and whats 
>>>> a Perf issue when these fail.
>>>>
>>>> And thirdly why only run the Coresight tests? Most of the Perf tests 
>>>> test some part of the kernel, so if we were going to do this I think 
>>>> it would make sense to make some kind of proper harness and run them 
>>>> all. I have some recollection that someone said it might be 
>>>> something we could do, but I can't remember the discussion.
>>>
>>> The idea I'm trying to pursue is to use arm64 kselftest to run as 
>>> many test cases as possible for ARM SoCs across different designs and 
>>> distros. I believe it could provide an alert if there is an issue, 
>>> whether it originates from userspace or kernel, similar to how perf 
>>> is used in other categories.
>>>
>>> I'm not sure if all perf tests could be counted in soc 
>>> (selftests/arm64) category such as some tests may target to storage, 
>>> memory or devices. I 
>>
>> Could we not put the Perf tests in  .../selftests/perf.sh, then it 
>> doesn't really matter which subsystem they're targeting and we can run 
>> all the Perf tests?
>>
> 
> The .../sefltests/ seems for the kselftest framework only, not sure if 
> having a new .../selftests/perf will make more sense?
> 

Yeah that sounds better, but it probably requires changing the title of 
the patch to "[RFC] kselftest: Run Perf tests under kselftest" or 
something like that.

>>> could replace 'arm64/coresight' with 'arm64/perf' if it makes more 
>>> sense. I believe it could help users verify functionality more 
>>> conveniently.
>>>
>>>>
>>>> Ignoring the main issue above I've left some comments about this 
>>>> patch inline below:
>>>>
>>>>>> Signed-off-by: Jeremy Szu <jszu@nvidia.com>
>>>>>
>>>>> I have not idea how to test coresight, so adding Suzuki as well.
>>>>>
>>>>>> ---
>>>>>>   tools/testing/selftests/arm64/Makefile        |  2 +-
>>>>>>   .../selftests/arm64/coresight/Makefile        |  5 +++
>>>>>>   .../selftests/arm64/coresight/coresight.sh    | 40 
>>>>>> +++++++++++++++++++
>>>>>>   .../selftests/arm64/coresight/settings        |  1 +
>>>>>>   4 files changed, 47 insertions(+), 1 deletion(-)
>>>>>>   create mode 100644 tools/testing/selftests/arm64/coresight/Makefile
>>>>>>   create mode 100755 
>>>>>> tools/testing/selftests/arm64/coresight/coresight.sh
>>>>>>   create mode 100644 tools/testing/selftests/arm64/coresight/settings
>>>>>>
>>>>>> diff --git a/tools/testing/selftests/arm64/Makefile 
>>>>>> b/tools/testing/selftests/arm64/Makefile
>>>>>> index 28b93cab8c0dd..2b788d7bab22d 100644
>>>>>> --- a/tools/testing/selftests/arm64/Makefile
>>>>>> +++ b/tools/testing/selftests/arm64/Makefile
>>>>>> @@ -4,7 +4,7 @@
>>>>>>   ARCH ?= $(shell uname -m 2>/dev/null || echo not)
>>>>>>   ifneq (,$(filter $(ARCH),aarch64 arm64))
>>>>>> -ARM64_SUBTARGETS ?= tags signal pauth fp mte bti abi
>>>>>> +ARM64_SUBTARGETS ?= tags signal pauth fp mte bti abi coresight
>>>>>>   else
>>>>>>   ARM64_SUBTARGETS :=
>>>>>>   endif
>>>>>> diff --git a/tools/testing/selftests/arm64/coresight/Makefile 
>>>>>> b/tools/testing/selftests/arm64/coresight/Makefile
>>>>>> new file mode 100644
>>>>>> index 0000000000000..1cc8c1f2a997e
>>>>>> --- /dev/null
>>>>>> +++ b/tools/testing/selftests/arm64/coresight/Makefile
>>>>>> @@ -0,0 +1,5 @@
>>>>>> +# SPDX-License-Identifier: GPL-2.0
>>>>>> +
>>>>>> +TEST_PROGS := coresight.sh
>>>>>> +
>>>>>> +include ../../lib.mk
>>>>>> diff --git a/tools/testing/selftests/arm64/coresight/coresight.sh 
>>>>>> b/tools/testing/selftests/arm64/coresight/coresight.sh
>>>>>> new file mode 100755
>>>>>> index 0000000000000..e550957cf593b
>>>>>> --- /dev/null
>>>>>> +++ b/tools/testing/selftests/arm64/coresight/coresight.sh
>>>>>> @@ -0,0 +1,40 @@
>>>>>> +#!/bin/bash
>>>>>> +# SPDX-License-Identifier: GPL-2.0
>>>>>> +
>>>>>> +skip() {
>>>>>> +    echo "SKIP: $1"
>>>>>> +    exit 4
>>>>>> +}
>>>>>> +
>>>>>> +fail() {
>>>>>> +    echo "FAIL: $1"
>>>>>> +    exit 255
>>>>>> +}
>>>>>> +
>>>>>> +is_coresight_supported() {
>>>>>> +    if [ -d "/sys/bus/coresight/devices" ]; then
>>>>>> +        return 0
>>>>>> +    fi
>>>>>> +    return 255
>>>>>> +}
>>>>
>>>> The Perf coresight tests already have a skip mechanism built in so 
>>>> can we rely on that instead of duplicating it here? There are also 
>>>> other scenarios for skipping like Perf not linked with OpenCSD which 
>>>> aren't covered here.
>>>>
>>>
>>> Will it return the different error code to indicate if it's failed to 
>>> be executed or the coresight is not supported?
>>>
>>
>> I think the exit code is only used for more serious errors. For things 
>> like missing tests, SKIP and FAIL it still exits with 0 but you have 
>> to grep for the strings. Actually for a missing test it prints nothing 
>> and exits 0.
>> >>>>> +
>>>>>> +if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
>>>>>> +    [ "$(id -u)" -ne 0 ] && \
>>>>>> +        skip "this test must be run as root."
>>>>>> +    which perf >/dev/null 2>&1 || \
>>>>>> +        skip "perf is not installed."
>>>>>> +    perf test list 2>&1 | grep -qi 'coresight' || \
>>>>>> +        skip "perf doesn't support testing coresight."
>>>>
>>>> Can this be an error instead? The coresight tests were added in 5.10 
>>>> and I don't think new kselftest needs to support such old kernels. 
>>>> This skip risks turning an error with installing the tests into a 
>>>> silent failure.
>>>>
>>>> Also as far as I know a lot of distros will refuse to open Perf 
>>>> unless it matches the kernel version if it was installed from the 
>>>> package manager, so we don't need to worry about old versions.
>>>>
>>>
>>> The idea to skip it here is because I thought either a distro 
>>> (custom) kernel doesn't enable the kconfig or the distro built the 
>>> perf with CORESIGHT=0.
>>>
>>> I could make it as an error and put it after "is_coresight_support" 
>>> if it makes more sense.
>>>
>>
>> But the Coresight test already checks these things, which is my point. 
>> You can grep for "SKIP" which it will print for any case where the 
>> coresight test can't be run due to some missing config.
>>
> 
> Oh, I guess you mean to rely on something like the `perf list cs_etm | 
> grep -q cs_etm || exit 2`. Yes, that makes more sense.
> 

If we're leaning towards running all the Perf tests then none of this is 
required anymore.

This is another example of why it's better to run them all. We can't 
realistically hard code a kself test with loads of logic for each Perf 
subtest when Perf will happily run all the tests on it's own without any 
extra work.

>>>>>> +    is_coresight_supported || \
>>>>>> +        skip "coresight is not supported."
>>>>>> +
>>>>>> +    cmd_output=$(perf test -vv 'coresight' 2>&1)
>>>>>> +    perf_ret=$?
>>>>>> +
>>>>>> +    if [ $perf_ret -ne 0 ]; then
>>>>>> +        fail "perf command returns non-zero."
>>>>>> +    elif [[ $cmd_output == *"FAILED!"* ]]; then
>>>>>> +        echo $cmd_output
>>>>
>>>> It's probably helpful to print cmd_output in both failure cases.
>>>>
>>>
>>> ok, will do.
>>>
>>>>>> +        fail "perf test 'arm coresight' test failed!"
> 
> I think I should remove the `is_coresight_supported` there and checks 
> the output as a "else" to see if the test is PASS or SKIP. Does it make 
> sense to you?
> 

Same as above applies, the only thing that's really required is parsing 
for "FAILED".

>>>>>> +    fi
>>>>>> +fi
>>>>>> diff --git a/tools/testing/selftests/arm64/coresight/settings 
>>>>>> b/tools/testing/selftests/arm64/coresight/settings
>>>>>> new file mode 100644
>>>>>> index 0000000000000..a953c96aa16e1
>>>>>> --- /dev/null
>>>>>> +++ b/tools/testing/selftests/arm64/coresight/settings
>>>>>> @@ -0,0 +1 @@
>>>>>> +timeout=180
>>>>
>>>> I timed 331 seconds on n1sdp, and probably even longer on Juno.
>>>>
>>>> It doesn't need to run for this long and it's an issue with the 
>>>> tests, but currently that's how long it takes so the timeout needs 
>>>> to be longer.
>>>>
>>>
>>> ok, will extend it to 600.
>>>
>>>>>> -- 
>>>>>> 2.34.1
>>>>>
