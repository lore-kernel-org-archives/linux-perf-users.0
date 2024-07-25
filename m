Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB5116B74C
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Jul 2024 07:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721891175; cv=none; b=CYTyo24vgUfDq2VJwjQ7IR0FSM2YxShFSPKErQr0x8DZ3A7YwwEFu9HGUS+ZowsWqYgp+oE2Sixb0hcMLaAaYyJ/Xx4kWhJ4FPFVQOJX/JqXj7zAhix6NAtsFMwPJenZjYOuZ26xgB5ytnM78mEThz7xxoZmgpoy14msUx1OTzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721891175; c=relaxed/simple;
	bh=Sj0fsVZuCwfTzcdeRTuu2y7nUshIYGCSbkWcepPlx7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lQtieDg1h/+hgVnF9HVtemOG//DtaagQTBHY/XSWkubr/kCUmuwImE/N/prtdfjMh6lNWavzayg5s379HWpgSN6O0gJElIELioJ/rSn8gLYEtyZiLf/B3Uh9DVcFu/+liK4r3xNCjGzQ8fvsgqECLT+t80YFHe+Sbvww8YUJjxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 035711007;
	Thu, 25 Jul 2024 00:06:39 -0700 (PDT)
Received: from [10.1.33.12] (PF4Q20KV.arm.com [10.1.33.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DBAC3F5A1;
	Thu, 25 Jul 2024 00:06:11 -0700 (PDT)
Message-ID: <95d79b2a-dd04-45a9-970a-83a755318505@arm.com>
Date: Thu, 25 Jul 2024 08:06:10 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] perf auxtrace: Support multiple AUX events
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 John Garry <john.g.garry@oracle.com>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org
References: <20240725064620.1651819-1-leo.yan@arm.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240725064620.1651819-1-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/25/2024 7:46 AM, Leo Yan wrote:
> This series is to support multiple events with the *same* type in Perf
> AUX trace. As the first enabled instance, the patch series enables
> multiple Arm SPE events (e.g. arm_spe_0, arm_spe_1, etc) in AUX trace.

Sorry I forgot to mention this series is dependent on
Adrian's two patches:

https://lore.kernel.org/linux-perf-users/e52c54a9-d34b-49a5-8c12-c609afcea1e6@arm.com/T/#mfe08431c03277cdef9c00fa42d86f6a42588de2a
https://lore.kernel.org/linux-perf-users/e52c54a9-d34b-49a5-8c12-c609afcea1e6@arm.com/T/#m519e5b2066333eb5f0bc3b7fd2dd89a8151e7b66

Thanks,
Leo

