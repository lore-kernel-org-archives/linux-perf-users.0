Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74631BDAA8;
	Thu, 10 Oct 2024 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572486; cv=none; b=HPMmlDVQB2WRRq/6cyRWYa5un2EQNhUp76w+QPPc2BOniuvq+EhHII6iNlZaxDtgs2CGdzhdQK2675CmAcfcDyh9/K27Aii5mf5Hs/v9TppiKco05l9KXbH95rWLsVWyP+8hrOZV38/3ZD2qJi994y2KYBaEnK3H2mG8xPCipzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572486; c=relaxed/simple;
	bh=OUE17Ygbyc99Zyqy5ssGIml3Abvij+h9GWMoFUHN6xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j6FNLlS6heYYc2tVKzEDXmHE3ZzTqD1Pzfaq0xXhUkGQ+qpECq65teb4gWRAaDAbx3IZI9SqRlJ0jmxjvYJ1rc3AxHS1idsVkki8gi1tN0eFPMwh2lDlBHI1kb9mpv0CObBAIlgE7VK+cpx6a73BSjNz7j+rT1sQ5G/pAoVKqNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFB1E497;
	Thu, 10 Oct 2024 08:01:53 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF93E3F64C;
	Thu, 10 Oct 2024 08:01:22 -0700 (PDT)
Message-ID: <0a0bebe6-b104-4a84-9415-68fdee086a5f@arm.com>
Date: Thu, 10 Oct 2024 16:01:21 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] perf cpumap: Correct for perf_cpu_map__merge()
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240925195325.426533-1-leo.yan@arm.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240925195325.426533-1-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/24 20:53, Leo Yan wrote:
> perf_cpu_map__merge() has two arguments, 'orig' and 'other', as
> described in its original comment:
> 
> "orig either gets freed and replaced with a new map, or reused
> with no reference count change (similar to "realloc")
> other has its reference count increased."
> 
> This causes confusion due to the different reference counting on the CPU
> map objects, which complicates its usage and makes maintenance
> difficult. We also discussed this in the email [1].
> 
> This patch series makes that a new CPU map is allocated for the
> merging result, or the reference count is increased if an existing CPU
> map is reused. This means that once perf_cpu_map__merge() is invoked,
> the caller gains ownership of the resulting map and must release it
> with perf_cpu_map__put().

Gentle ping ...

Thanks,
Leo
