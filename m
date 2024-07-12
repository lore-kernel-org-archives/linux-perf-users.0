Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D052013F439
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720774917; cv=none; b=ePNKhqYXXKM4zJCy+1liQn8IfO2/242GCeLWofjeLg7qvtJ5ww3l3Z/JE3LKPXtr/dJS+M08Ral10QZ0FOJax+usc+DpFfwoI/cBvWo1BUE0gJKKo9amHyiW1S7wwT+utGz8BPM0QNQHj+D1qIIJXVrdwpdryZvxG2zrlKlRpjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720774917; c=relaxed/simple;
	bh=hjJGDOfh25CPM575/k2LTXLurb5FUD/57srcflIYj2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s30fLxSg5kWFuIBVIraffCNpGtfNzI+YJ5qXewIHz1OBAHrhjBNrgGB5w3SFydih5r4OhuwoUDyQk1rhS1Q7yVQYj8q4MRGTNx0Gc+CKE7qv9Tqcfv8eFpBZ9y9+JJYGE+R/H4M4iOXVRrGQXe5gCxAbCd300Nx1NGD4sqcaao8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MJiW59n1; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MJiW59n1"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52ea5dc3c79so2543623e87.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 02:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720774914; x=1721379714; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YCqpFBBHuY6bJhtdiCpzRckkEm2LkY2rFSEybXBt5E8=;
        b=MJiW59n1o4RJzBVY7dDUaWAEIU3boVCmV8de4jFOpJNMrCInb2hjBDRiDXxRPxj+1M
         395YGzKsq7gv9EzKgL+RdjCfo5+6liNH/31JdOWltuC+ylsxtIGMaCkDiU03ycsosCiP
         sOSvu3j9QCvfR3rXQt8DntcLMXBYISpyHqcMjf3Fmz+r+bAIOeP4SHcC5SyPO0xX0VR0
         kLFO2UfClWt2Yq6K7NFXkfvhjnXTPihIB6v4fkDnP0Rg7pPJ7rfhlM4m7Irr34m1ti5y
         8BMO03SRfJ/iJtHQnV5nvWtzq5EpuHiGa1HSCHpXSMgfXtK5bfFzboDCmF+8UUtoQWpo
         EQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720774914; x=1721379714;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YCqpFBBHuY6bJhtdiCpzRckkEm2LkY2rFSEybXBt5E8=;
        b=KORGM5jtUAKnNkx63rNRY63bhdJvlLmtdD8rAR4sxLUGf2OlKrQ58Du+MaEJShUpKJ
         /92QozG+fUcIIInGg7JkNjcKu/91uv9GlpjO12Q0dJXK/IwrTeO3zdkFjuNPWHuaaEyA
         MMXiGkOJpgjlwgX0B+bJPYr0r6URgKXp1DnaedO6hR1m8WmlU38PDUnEeAKapjei9qMw
         lBOBw2ttDkfkVA0tDC2NpYhWNud/mRZGuZB+tUzHy7XcosImW/dLpAlwANhrKzoerGD7
         HV865quImfgAMq8t1cBWz8/XWCuH705KMw03I9kF99LYL8n5FvKyLAq/6/M+xG8xXl73
         usEw==
X-Forwarded-Encrypted: i=1; AJvYcCUYX+WP59knarYErvyb8h0m2BR7gPb/GReYz3Mggl9tA9KvJRyIbgcx2cZ6OjUBxYKrcOT8IEKRpKl5cU7k5CMqc2SeHYujhZLSsqMV1PVv+w==
X-Gm-Message-State: AOJu0YzjmtYf2k2uo0sAY79tvXypXWU7LgeIcYf+Wrn3t1BW1BqXjpEC
	ACys7xOqm5RPAfVVg8y6Zg3mVy32vzCcebTDOqg4CDwzjjga3jsHYnc4GFkfsGs=
X-Google-Smtp-Source: AGHT+IGp06kBGD4XxbAPT2xDExDDJVA09+NKrQxj4QceLJnaYW0BxpmSqDNUkl4dRqqW3ezZtfhgyQ==
X-Received: by 2002:a05:6512:3e02:b0:52c:e3bd:c70b with SMTP id 2adb3069b0e04-52eb99918a7mr6852031e87.1.1720774913868;
        Fri, 12 Jul 2024 02:01:53 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f28872fsm15647895e9.25.2024.07.12.02.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 02:01:53 -0700 (PDT)
Message-ID: <12a84dc1-ad94-4546-ad3d-72f3e0b0bfab@linaro.org>
Date: Fri, 12 Jul 2024 10:01:52 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kselftest/arm64: Add coresight test
To: Catalin Marinas <catalin.marinas@arm.com>, Jeremy Szu <jszu@nvidia.com>
Cc: will@kernel.org, linux-arm-kernel@lists.infradead.org,
 james.clark@arm.com, bwicaksono@nvidia.com,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>, linux-perf-users@vger.kernel.org,
 coresight@lists.linaro.org
References: <20240710062732.18999-1-jszu@nvidia.com>
 <ZpAeZjNJLesSJqm1@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <ZpAeZjNJLesSJqm1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/07/2024 7:03 pm, Catalin Marinas wrote:
> On Wed, Jul 10, 2024 at 02:27:32PM +0800, Jeremy Szu wrote:
>> Add a script to test the coresight functionalities by performing the
>> perf test 'coresight'.
>>
>> The script checks the prerequisites and launches a bundle of
>> Coresight-related tests with a 180-second timeout.
>>

Hi Jeremy,

On the whole I'm not sure running the Perf tests under kself tests is a 
good fit. We're already running all the Perf tests in various CIs, so 
this is going to duplicate effort. Especially with setup and parsing of 
the results output.

There is also no clean line between what's a kernel issue and whats a 
Perf issue when these fail.

And thirdly why only run the Coresight tests? Most of the Perf tests 
test some part of the kernel, so if we were going to do this I think it 
would make sense to make some kind of proper harness and run them all. I 
have some recollection that someone said it might be something we could 
do, but I can't remember the discussion.

Ignoring the main issue above I've left some comments about this patch 
inline below:

>> Signed-off-by: Jeremy Szu <jszu@nvidia.com>
> 
> I have not idea how to test coresight, so adding Suzuki as well.
> 
>> ---
>>   tools/testing/selftests/arm64/Makefile        |  2 +-
>>   .../selftests/arm64/coresight/Makefile        |  5 +++
>>   .../selftests/arm64/coresight/coresight.sh    | 40 +++++++++++++++++++
>>   .../selftests/arm64/coresight/settings        |  1 +
>>   4 files changed, 47 insertions(+), 1 deletion(-)
>>   create mode 100644 tools/testing/selftests/arm64/coresight/Makefile
>>   create mode 100755 tools/testing/selftests/arm64/coresight/coresight.sh
>>   create mode 100644 tools/testing/selftests/arm64/coresight/settings
>>
>> diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
>> index 28b93cab8c0dd..2b788d7bab22d 100644
>> --- a/tools/testing/selftests/arm64/Makefile
>> +++ b/tools/testing/selftests/arm64/Makefile
>> @@ -4,7 +4,7 @@
>>   ARCH ?= $(shell uname -m 2>/dev/null || echo not)
>>   
>>   ifneq (,$(filter $(ARCH),aarch64 arm64))
>> -ARM64_SUBTARGETS ?= tags signal pauth fp mte bti abi
>> +ARM64_SUBTARGETS ?= tags signal pauth fp mte bti abi coresight
>>   else
>>   ARM64_SUBTARGETS :=
>>   endif
>> diff --git a/tools/testing/selftests/arm64/coresight/Makefile b/tools/testing/selftests/arm64/coresight/Makefile
>> new file mode 100644
>> index 0000000000000..1cc8c1f2a997e
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/coresight/Makefile
>> @@ -0,0 +1,5 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +TEST_PROGS := coresight.sh
>> +
>> +include ../../lib.mk
>> diff --git a/tools/testing/selftests/arm64/coresight/coresight.sh b/tools/testing/selftests/arm64/coresight/coresight.sh
>> new file mode 100755
>> index 0000000000000..e550957cf593b
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/coresight/coresight.sh
>> @@ -0,0 +1,40 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +skip() {
>> +	echo "SKIP: $1"
>> +	exit 4
>> +}
>> +
>> +fail() {
>> +	echo "FAIL: $1"
>> +	exit 255
>> +}
>> +
>> +is_coresight_supported() {
>> +	if [ -d "/sys/bus/coresight/devices" ]; then
>> +		return 0
>> +	fi
>> +	return 255
>> +}

The Perf coresight tests already have a skip mechanism built in so can 
we rely on that instead of duplicating it here? There are also other 
scenarios for skipping like Perf not linked with OpenCSD which aren't 
covered here.

>> +
>> +if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
>> +	[ "$(id -u)" -ne 0 ] && \
>> +		skip "this test must be run as root."
>> +	which perf >/dev/null 2>&1 || \
>> +		skip "perf is not installed."
>> +	perf test list 2>&1 | grep -qi 'coresight' || \
>> +		skip "perf doesn't support testing coresight."

Can this be an error instead? The coresight tests were added in 5.10 and 
I don't think new kselftest needs to support such old kernels. This skip 
risks turning an error with installing the tests into a silent failure.

Also as far as I know a lot of distros will refuse to open Perf unless 
it matches the kernel version if it was installed from the package 
manager, so we don't need to worry about old versions.

>> +	is_coresight_supported || \
>> +		skip "coresight is not supported."
>> +
>> +	cmd_output=$(perf test -vv 'coresight' 2>&1)
>> +	perf_ret=$?
>> +
>> +	if [ $perf_ret -ne 0 ]; then
>> +		fail "perf command returns non-zero."
>> +	elif [[ $cmd_output == *"FAILED!"* ]]; then
>> +		echo $cmd_output

It's probably helpful to print cmd_output in both failure cases.

>> +		fail "perf test 'arm coresight' test failed!"
>> +	fi
>> +fi
>> diff --git a/tools/testing/selftests/arm64/coresight/settings b/tools/testing/selftests/arm64/coresight/settings
>> new file mode 100644
>> index 0000000000000..a953c96aa16e1
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/coresight/settings
>> @@ -0,0 +1 @@
>> +timeout=180

I timed 331 seconds on n1sdp, and probably even longer on Juno.

It doesn't need to run for this long and it's an issue with the tests, 
but currently that's how long it takes so the timeout needs to be longer.

>> -- 
>> 2.34.1
> 
