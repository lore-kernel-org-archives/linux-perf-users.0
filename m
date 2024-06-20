Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC60B40858;
	Thu, 20 Jun 2024 11:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718883101; cv=none; b=Wn8i4ukvZYWcS4ajV921nSivvRB1PlfVg5doaTi9eElikwLRBlIY8LuYiu1DERC0pP3nnRQuEE1Dik0bTfOpvatd7/xBX0r59AFXBpoknWVgFFgnN6c3DBez3TnzXp9v8surq0I8DiiWTBnxyxQBIe9mZLRbzOz2fJMWM6wwQi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718883101; c=relaxed/simple;
	bh=2EUsRJP1y8Ffm/L1rJ/hNw8Xvk/M9bkzEuSmMifuQyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VqjEZSauL2aJGqw7rL7tW9Iv5miLEvrK9mtfES/c8ffYweeq3Y3p1WfA7n50p8LkjdHNBZB7x5XI4KWZ0Ul+GU8A4rcsWM0i2IYHCUq5CatNQlPNinnAZaJpTF4fuHKjyMwSMtc530XJ6wfSH7pWvhebD0PLx8Ak1NuFZyHgHd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95142DA7;
	Thu, 20 Jun 2024 04:32:03 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65CDC3F6A8;
	Thu, 20 Jun 2024 04:31:37 -0700 (PDT)
Message-ID: <3ab8410a-6c74-4dc1-997d-7b1a00fba877@arm.com>
Date: Thu, 20 Jun 2024 12:31:36 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: hw_breakpoint: Save privilege of access control
 via ptrace
To: Oleg Nesterov <oleg@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240618071010.11214-1-yangtiezhu@loongson.cn>
 <20240619151524.GB24240@redhat.com>
 <9cc6d314-2431-c1b5-3d46-63c0ac80ed4d@loongson.cn>
 <20240620090807.GC30070@redhat.com>
 <93d96e55-c180-444a-9b3f-f96db5f9e37d@loongson.cn>
 <20240620103600.GD30070@redhat.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240620103600.GD30070@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20/06/2024 11:36, Oleg Nesterov wrote:
> Again, I can't really comment, I know almost nothing about perf, but
> 
> On 06/20, Tiezhu Yang wrote:
>>
>> On 06/20/2024 05:08 PM, Oleg Nesterov wrote:
>>>
>>> But to me the very idea of arm64-specific and "kernel only" member in
>>> perf_event_attr looks a bit strange.
>>
>> I noticed that there is a similar arm64-specific change in
>> commit 09519ec3b19e ("perf: Add perf_event_attr::config3")
> 
> but this is another thing even if I have no idea what .config3 means.
> 
> If nothing else, what do you think, say, tools/perf can do with ->bp_priv?

Yeah, including the tools side change in the same series might help to
explain. It's not obvious what the end goal is from the commit message.

Thanks
James

> 
> What should sys_perf_event_open() do if bp_priv != 0 comes from user space?
> 
> Nevermind, please forget, I leave this to you and maintainers.
> 
> Oleg.
> 
> 
