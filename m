Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86A712C486;
	Sat,  3 Aug 2024 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722700321; cv=none; b=IpJkIuUFYYWJhpv99w5KK8M0x3R6B6/cMLF9oh7dwsdApg05GRwYea2pWnBmkhPToZ1uK/M6MlLtF354hCeWpOtTjifk1cP2cWKDcDr0ZBoUZXM7/C95INTcAoYxQVlltca4xZZArpjXfo7Juaaqj2OlNR27ZtEi9cOxAy9HvTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722700321; c=relaxed/simple;
	bh=xWJoVsZrZl78o2c0CARv2yjpf/FWqpfmOHGEJ6iBdTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBtxSUBlDc4ezZJvDZJD8Sc8ovywEoEX2Ps5Ucp7Mae4RzXBtsOtol7HPGqL8qCJu7Wd464sUgKs9f00rQ/0/Ncl0jCqD3ZCJI0M0qiAdo/tseLP3N+O9VLn2qQxRSNrDjSi89NfhLA6KiuCn0ia+Otf3F0O8dNif55IB1p26X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71792FEC;
	Sat,  3 Aug 2024 08:52:23 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CDF23F766;
	Sat,  3 Aug 2024 08:51:55 -0700 (PDT)
Message-ID: <ce758ef7-142a-453d-a37e-f64268256f3c@arm.com>
Date: Sat, 3 Aug 2024 16:51:54 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/6] perf auxtrace: Iterate all AUX events when finish
 reading
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 Namhyung Kim <namhyung@kernel.org>, James Clark <james.clark@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240721202113.380750-1-leo.yan@arm.com>
 <20240721202113.380750-5-leo.yan@arm.com>
 <9f08c5cb-fb4b-4994-9128-0484aa6c06d7@intel.com>
 <9f301b09-e040-456c-9bd3-6d5e96ebc8f4@arm.com>
 <1cb6fdfc-0405-4bfb-acd4-ed3b24744c8b@intel.com>
 <951fc660-58a2-4b8a-a763-5a1e4d807c75@arm.com>
 <CAP-5=fWfU40-QO_TuUMd2KQprvxPOH2pnpKCUxJf1yoUsw-9mQ@mail.gmail.com>
 <Zquj9TJM8QQKkpYL@x1>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <Zquj9TJM8QQKkpYL@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/24 16:04, Arnaldo Carvalho de Melo wrote:
> On Wed, Jul 31, 2024 at 06:38:59PM -0700, Ian Rogers wrote:
>> Just a heads up. Arnaldo added this to tmp.perf-tools-next and it
>> caused the intel-pt tests to start failing:

Sorry for causing regression and thanks for reporting the issue.

> My plan right now is just to remove that cset that Ian bisected since it
> is not on perf-tools-next, just on the scratch branch
> tmp.perf-tools-next.

Please leave the patch 04 out. I have sent out v2 but Adrian pointed out a 
concern for per-thread mode, now I am working on this and after ready I will 
send new patches.

I have verified the latest perf-tools-next branch, it works well on Arm SPE 
(thanks for picking up patches 05 and 06).

> Trying to do that now as it will help us with bisection in the future.

I am not clear this. Could you elaborate a bit what I should follow up?

>> ```
>> $ perf test 118 -v
>> 118: Miscellaneous Intel PT testing:
>> --- start ---
>> test child forked, pid 148999
>> --- Test system-wide sideband ---
>> Checking for CPU-wide recording on CPU 0
>> OK
>> Checking for CPU-wide recording on CPU 1
>> OK
>> Linux
>> Failed to enable event (idx=0): -22
>> Failed to record MMAP events on CPU 1 when tracing CPU 0
>> ...
>> ```
>> It's likely Adrian's comments already address this but you may also
>> want to double check this test is passing with v2.

Sure. I will give a test for this test when I send new patches.

Thanks,
Leo
