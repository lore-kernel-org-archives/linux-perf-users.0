Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B5534CC4;
	Thu, 26 Sep 2024 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727367654; cv=none; b=JAf+mXbipLOZpFYxPOuthhA06mwTz0lWfcQRVzMaZdRVp6IpPvjif62OyS/0ZPpt+sdUnHKdqFBStcWWeViuS6GVGmjHf/Aa3Bh4owXiWlpyRHjSjZaaANO7hQsDk4K9zlaHj4RNs4R/WHZulHkOb/gv42zoK/38qrM0vgNzOyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727367654; c=relaxed/simple;
	bh=Y2G/WXuKiqm9T1EpZsV8QDwOciR45eh0MwY7zfNYeug=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H62kBhO2AKBwewbhEEUBKH40HFILmCXzWydSMQDK5DOms5QQMF5S4u8NgUUEfDit0+ppe+cubzdeuiWXjHpuer5lwxHeD9Y1c/s6nCOck5+sREMIP0lo2BevHSq8d3Lk+NQYX6BntUaR/uZ878pbnGigOTtCbD5q5r4wDe9MdUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47E1214BF;
	Thu, 26 Sep 2024 09:21:21 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EC473F587;
	Thu, 26 Sep 2024 09:20:50 -0700 (PDT)
Message-ID: <61d9e213-d2ca-48c9-b176-03e7d01524c9@arm.com>
Date: Thu, 26 Sep 2024 17:20:49 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] perf arm-spe: Introduce metadata version 2
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>,
 Will Deacon <will@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240914215458.751802-1-leo.yan@arm.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240914215458.751802-1-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/24 22:54, Leo Yan wrote:
> This patch series enhances Arm SPE metadata in the Perf file to a
> version 2 format and maintains backward compatibility for metadata v1.
> 
> The version 2 metadata contains a global structure with fields for
> metadata header version number, header size, CPU numbers. It also
> expands to store per-CPU metadata, which includes the CPU logical
> number in the kernel, MIDR, and capacity values associated with Arm SPE.
> 
> This patch set has been tested the perf to decode the Arm SPE metadata
> v1 and v2.
> 
> Changes from v1:
> - Dropped LDS bit exposing from Arm SPE driver (Will Deacon).
> - To simplify the change, this series did not include multiple AUX event
>    support.

Hi Arnaldo, Namhyung,

Gentle ping. There is a bit backlog for Arm SPE patches, so I would
like to bring up this series and the series [1] for the Arm SPE data
source refactoring (which is dependent on the current series).

Please kindly review and pick it up if it is fine for you.

Thanks,
Leo

[1] https://lore.kernel.org/linux-perf-users/20240914220901.756177-1-leo.yan@arm.com/


> Leo Yan (5):
>    perf arm-spe: Define metadata header version 2
>    perf arm-spe: Calculate meta data size
>    perf arm-spe: Save per CPU information in metadata
>    perf arm-spe: Support metadata version 2
>    perf arm-spe: Dump metadata with version 2
> 
>   tools/perf/arch/arm64/util/arm-spe.c | 106 ++++++++++++++++++-
>   tools/perf/util/arm-spe.c            | 151 +++++++++++++++++++++++++--
>   tools/perf/util/arm-spe.h            |  38 ++++++-
>   3 files changed, 281 insertions(+), 14 deletions(-)
> 
