Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B73F2EAE5
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721227705; cv=none; b=RE4Mc7RZPSQ4hbOzn1Tfy0SXDCt9U65hxOGdx56B9dERNFwBApLFPo1fTrgoEkJkoI3CwkeEx6t8Gju58NHxDaetXZGCcn8HjQg2STcPQt7CQ4HPpi+8VQkOdRq4sY0X88bfHMLmsDbkkGkxKpe8vZStO8Mo/lAtp01PY9DwvGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721227705; c=relaxed/simple;
	bh=iLiaw1WoZSfbeDi0fG+BXZj5gvGbgz+47BdNKuLKLcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B5blTYXHdwzYBogEPPfXA/Wayrv+lPuudQFHP1qhUPJ5yq1U5Im4AzthvcPPv0NBQpeIcOe0kRTHQhAetYbwiS8fPyP8x3P3p8TFJnKfhgLDwvtBuRkkHaY65V/olx5Zq6IIEogxb/iB0tSSqa2ZBW4DdEsDXKPeBajPMOPI5Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uGipsnVr; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uGipsnVr"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-36805befd01so2946562f8f.2
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 07:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721227702; x=1721832502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6lrpNV6G/WyC2oxUgm1H5AgkS3P9JKM6bndZMs9Voao=;
        b=uGipsnVr4Sjui1QNg32L3Y4knUUeKtFv9AtqCeGd9I1qv9s9kY0+HWJayRalAXWhzg
         joWiwol9lu1qEBWSLP6K3ysbk1bwdEJDZgaiLvYu+JAcQqzDMw0AqgDBTkgjy8EfGAzG
         SWZCIi12AcsaHswUZYALD5vHNmqc4+T14DLrE2/pgHt4yyoFEPb22WY9PXpDMn27F4u+
         KoGXuPAHW5O6F0SM5eFF8aHHpojeHThCFNbbgqrH0BYOvG2bomIohcqBdbjeaj5jDjW3
         vdTpiOdppzGxm3S0gfoG6WMQ4gSUi8tZO83OL9A4PLYMhqIEPnZnckSqE8hf7/p/ewJM
         hOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721227702; x=1721832502;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6lrpNV6G/WyC2oxUgm1H5AgkS3P9JKM6bndZMs9Voao=;
        b=mmwcw4OnbN/d3KtDtcQWF3qFghzd+QcTF06hcSSJJ9Hd2HTLZC1qc7z8JovmuU1uuh
         azGGoB6M9qDYyl5ekeNsqi9wiU+C1iLcWwY5oaKW4gOwC81HNUS6aDgyEzCtx59+CkHl
         4o3N4XmCbGJHx99qXCM4AhH3AVA6/34/OK5H5QmEjCs5XExDA/Z5/bwkNeL6fsHmtegN
         ckhLtmLZSadZAvvG9XVsCnMSk+U4td09Ravr++iw8TC5Uc4L69yugPpwvMVVC1RYzw/I
         +8wAOh1pDfnf/7Tkjih3SPoTDUwepy18gQorgGH1E/vwuPTsptTSnrS1TzZORE3tOzDH
         v+sg==
X-Forwarded-Encrypted: i=1; AJvYcCVGcWz1xdVvWSvsMCgwNdpkPMMpnKKWjJJ+GvNTrvOgHA9j2/lxZ721v+NpAtKBSGMKAvOIDk9WLNpg28WbYTNBCHMSPAlplb08HRwGWzR3mA==
X-Gm-Message-State: AOJu0Yynol9NZzB3YM+0D8Y65kQ4Q+C7vPhYdfClox6RvFlBIpW2fE3a
	a4oGcisYfTm3++mxmsOO8XHkbCTXEPlwlsxuc2j5mRBHibCMN50rB3SPE6RSOKE=
X-Google-Smtp-Source: AGHT+IEBzD0DOKVyc5HpPBO/uDBFKmngePnpuxYjvo8vYjiD7EJS1Dtvtl02DN9tfBnNy/2EgukUFQ==
X-Received: by 2002:a05:6000:1283:b0:362:df5e:6807 with SMTP id ffacd0b85a97d-36831650cf9mr1594988f8f.28.1721227701563;
        Wed, 17 Jul 2024 07:48:21 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c77dcf80sm648105e9.23.2024.07.17.07.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 07:48:21 -0700 (PDT)
Message-ID: <b940e617-22b3-495b-a97e-42aad45f0ed6@linaro.org>
Date: Wed, 17 Jul 2024 15:48:20 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kselftest/arm64: Add coresight test
To: Jeremy Szu <jszu@nvidia.com>, Catalin Marinas <catalin.marinas@arm.com>
Cc: will@kernel.org, linux-arm-kernel@lists.infradead.org,
 james.clark@arm.com, bwicaksono@nvidia.com,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>, linux-perf-users@vger.kernel.org,
 coresight@lists.linaro.org
References: <20240710062732.18999-1-jszu@nvidia.com>
 <ZpAeZjNJLesSJqm1@arm.com> <12a84dc1-ad94-4546-ad3d-72f3e0b0bfab@linaro.org>
 <34327425-80c6-4346-95c9-fa15f9381e1e@nvidia.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <34327425-80c6-4346-95c9-fa15f9381e1e@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/07/2024 3:06 am, Jeremy Szu wrote:
> Hi James,
> 
> Thank you for your reply.
> 
> James Clark 於 7/12/24 5:01 PM 寫道:
>>
>>
>> On 11/07/2024 7:03 pm, Catalin Marinas wrote:
>>> On Wed, Jul 10, 2024 at 02:27:32PM +0800, Jeremy Szu wrote:
>>>> Add a script to test the coresight functionalities by performing the
>>>> perf test 'coresight'.
>>>>
>>>> The script checks the prerequisites and launches a bundle of
>>>> Coresight-related tests with a 180-second timeout.
>>>>
>>
>> Hi Jeremy,
>>
>> On the whole I'm not sure running the Perf tests under kself tests is 
>> a good fit. We're already running all the Perf tests in various CIs, 
>> so this is going to duplicate effort. Especially with setup and 
>> parsing of the results output.
>>
>> There is also no clean line between what's a kernel issue and whats a 
>> Perf issue when these fail.
>>
>> And thirdly why only run the Coresight tests? Most of the Perf tests 
>> test some part of the kernel, so if we were going to do this I think 
>> it would make sense to make some kind of proper harness and run them 
>> all. I have some recollection that someone said it might be something 
>> we could do, but I can't remember the discussion.
> 
> The idea I'm trying to pursue is to use arm64 kselftest to run as many 
> test cases as possible for ARM SoCs across different designs and 
> distros. I believe it could provide an alert if there is an issue, 
> whether it originates from userspace or kernel, similar to how perf is 
> used in other categories.
> 
> I'm not sure if all perf tests could be counted in soc (selftests/arm64) 
> category such as some tests may target to storage, memory or devices. I 

Could we not put the Perf tests in  .../selftests/perf.sh, then it 
doesn't really matter which subsystem they're targeting and we can run 
all the Perf tests?

> could replace 'arm64/coresight' with 'arm64/perf' if it makes more 
> sense. I believe it could help users verify functionality more 
> conveniently.
> 
>>
>> Ignoring the main issue above I've left some comments about this patch 
>> inline below:
>>
>>>> Signed-off-by: Jeremy Szu <jszu@nvidia.com>
>>>
>>> I have not idea how to test coresight, so adding Suzuki as well.
>>>
>>>> ---
>>>>   tools/testing/selftests/arm64/Makefile        |  2 +-
>>>>   .../selftests/arm64/coresight/Makefile        |  5 +++
>>>>   .../selftests/arm64/coresight/coresight.sh    | 40 
>>>> +++++++++++++++++++
>>>>   .../selftests/arm64/coresight/settings        |  1 +
>>>>   4 files changed, 47 insertions(+), 1 deletion(-)
>>>>   create mode 100644 tools/testing/selftests/arm64/coresight/Makefile
>>>>   create mode 100755 
>>>> tools/testing/selftests/arm64/coresight/coresight.sh
>>>>   create mode 100644 tools/testing/selftests/arm64/coresight/settings
>>>>
>>>> diff --git a/tools/testing/selftests/arm64/Makefile 
>>>> b/tools/testing/selftests/arm64/Makefile
>>>> index 28b93cab8c0dd..2b788d7bab22d 100644
>>>> --- a/tools/testing/selftests/arm64/Makefile
>>>> +++ b/tools/testing/selftests/arm64/Makefile
>>>> @@ -4,7 +4,7 @@
>>>>   ARCH ?= $(shell uname -m 2>/dev/null || echo not)
>>>>   ifneq (,$(filter $(ARCH),aarch64 arm64))
>>>> -ARM64_SUBTARGETS ?= tags signal pauth fp mte bti abi
>>>> +ARM64_SUBTARGETS ?= tags signal pauth fp mte bti abi coresight
>>>>   else
>>>>   ARM64_SUBTARGETS :=
>>>>   endif
>>>> diff --git a/tools/testing/selftests/arm64/coresight/Makefile 
>>>> b/tools/testing/selftests/arm64/coresight/Makefile
>>>> new file mode 100644
>>>> index 0000000000000..1cc8c1f2a997e
>>>> --- /dev/null
>>>> +++ b/tools/testing/selftests/arm64/coresight/Makefile
>>>> @@ -0,0 +1,5 @@
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +
>>>> +TEST_PROGS := coresight.sh
>>>> +
>>>> +include ../../lib.mk
>>>> diff --git a/tools/testing/selftests/arm64/coresight/coresight.sh 
>>>> b/tools/testing/selftests/arm64/coresight/coresight.sh
>>>> new file mode 100755
>>>> index 0000000000000..e550957cf593b
>>>> --- /dev/null
>>>> +++ b/tools/testing/selftests/arm64/coresight/coresight.sh
>>>> @@ -0,0 +1,40 @@
>>>> +#!/bin/bash
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +
>>>> +skip() {
>>>> +    echo "SKIP: $1"
>>>> +    exit 4
>>>> +}
>>>> +
>>>> +fail() {
>>>> +    echo "FAIL: $1"
>>>> +    exit 255
>>>> +}
>>>> +
>>>> +is_coresight_supported() {
>>>> +    if [ -d "/sys/bus/coresight/devices" ]; then
>>>> +        return 0
>>>> +    fi
>>>> +    return 255
>>>> +}
>>
>> The Perf coresight tests already have a skip mechanism built in so can 
>> we rely on that instead of duplicating it here? There are also other 
>> scenarios for skipping like Perf not linked with OpenCSD which aren't 
>> covered here.
>>
> 
> Will it return the different error code to indicate if it's failed to be 
> executed or the coresight is not supported?
> 

I think the exit code is only used for more serious errors. For things 
like missing tests, SKIP and FAIL it still exits with 0 but you have to 
grep for the strings. Actually for a missing test it prints nothing and 
exits 0.

>>>> +
>>>> +if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
>>>> +    [ "$(id -u)" -ne 0 ] && \
>>>> +        skip "this test must be run as root."
>>>> +    which perf >/dev/null 2>&1 || \
>>>> +        skip "perf is not installed."
>>>> +    perf test list 2>&1 | grep -qi 'coresight' || \
>>>> +        skip "perf doesn't support testing coresight."
>>
>> Can this be an error instead? The coresight tests were added in 5.10 
>> and I don't think new kselftest needs to support such old kernels. 
>> This skip risks turning an error with installing the tests into a 
>> silent failure.
>>
>> Also as far as I know a lot of distros will refuse to open Perf unless 
>> it matches the kernel version if it was installed from the package 
>> manager, so we don't need to worry about old versions.
>>
> 
> The idea to skip it here is because I thought either a distro (custom) 
> kernel doesn't enable the kconfig or the distro built the perf with 
> CORESIGHT=0.
> 
> I could make it as an error and put it after "is_coresight_support" if 
> it makes more sense.
> 

But the Coresight test already checks these things, which is my point. 
You can grep for "SKIP" which it will print for any case where the 
coresight test can't be run due to some missing config.

>>>> +    is_coresight_supported || \
>>>> +        skip "coresight is not supported."
>>>> +
>>>> +    cmd_output=$(perf test -vv 'coresight' 2>&1)
>>>> +    perf_ret=$?
>>>> +
>>>> +    if [ $perf_ret -ne 0 ]; then
>>>> +        fail "perf command returns non-zero."
>>>> +    elif [[ $cmd_output == *"FAILED!"* ]]; then
>>>> +        echo $cmd_output
>>
>> It's probably helpful to print cmd_output in both failure cases.
>>
> 
> ok, will do.
> 
>>>> +        fail "perf test 'arm coresight' test failed!"
>>>> +    fi
>>>> +fi
>>>> diff --git a/tools/testing/selftests/arm64/coresight/settings 
>>>> b/tools/testing/selftests/arm64/coresight/settings
>>>> new file mode 100644
>>>> index 0000000000000..a953c96aa16e1
>>>> --- /dev/null
>>>> +++ b/tools/testing/selftests/arm64/coresight/settings
>>>> @@ -0,0 +1 @@
>>>> +timeout=180
>>
>> I timed 331 seconds on n1sdp, and probably even longer on Juno.
>>
>> It doesn't need to run for this long and it's an issue with the tests, 
>> but currently that's how long it takes so the timeout needs to be longer.
>>
> 
> ok, will extend it to 600.
> 
>>>> -- 
>>>> 2.34.1
>>>
