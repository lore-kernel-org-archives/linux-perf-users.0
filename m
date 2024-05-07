Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3114342A97;
	Tue,  7 May 2024 04:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715055365; cv=none; b=rAFVGuZqwHyoKx/1RXHc3LnXfCsc6IUmCWKeECuAiKXjwTtna0dAXTvo+2TbzZjxiE5EV4THK3DvDIGp7UACUWGGMEQSO46C06uxsvaBLB+UUy4zJrbFkFh1cfwg9grbodf2tFm0ZYzKJpZfB0U9Q79QqFnAymyvduJNRPZ5UYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715055365; c=relaxed/simple;
	bh=nv1j0TM2FIZ3k+s9DgLwGe1aAMpX9+BEPJtHnDfw58o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C6VL5iG05nnRu8EP1ckHyLJOs13NgvAF7gBtOqckp9ylSfpsKetNev/75dC4nWbBzYvAQX1F6sre/ffdiwg36oEDiTvTdP3HCc5EeLjG7wWT6VKsTnzkFalFsESPERKix2ybimchxinJD9bckwHB/jGLvTUrBUsfKzKNo55PbU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47EB51042;
	Mon,  6 May 2024 21:16:28 -0700 (PDT)
Received: from [10.163.33.37] (unknown [10.163.33.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49A9A3F762;
	Mon,  6 May 2024 21:15:54 -0700 (PDT)
Message-ID: <387feec3-79de-4b28-b2d5-d70d05b151b7@arm.com>
Date: Tue, 7 May 2024 09:45:55 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] coresight: Remove unused stubs
Content-Language: en-US
To: James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
 gankulkarni@os.amperecomputing.com, scclevenger@os.amperecomputing.com,
 coresight@lists.linaro.org, suzuki.poulose@arm.com, mike.leach@linaro.org
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, John Garry
 <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20240429152207.479221-1-james.clark@arm.com>
 <20240429152207.479221-9-james.clark@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240429152207.479221-9-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Minor nit: Should the subject line be "coresight: Remove unused etm perf stubs" ?

On 4/29/24 20:51, James Clark wrote:
> This file is never included anywhere if CONFIG_CORESIGHT is not set so
> they are unused and aren't currently compile tested with any config so
> remove them.

Searching for this header's inclusion throws up the following source files,
all of which needs CONFIG_CORESIGHT to be enabled to be compiled.

git grep "coresight-etm-perf.h"

drivers/hwtracing/coresight/coresight-core.c:#include "coresight-etm-perf.h"
drivers/hwtracing/coresight/coresight-etb10.c:#include "coresight-etm-perf.h"
drivers/hwtracing/coresight/coresight-etm-perf.c:#include "coresight-etm-perf.h"
drivers/hwtracing/coresight/coresight-etm3x-core.c:#include "coresight-etm-perf.h"
drivers/hwtracing/coresight/coresight-etm4x-core.c:#include "coresight-etm-perf.h"
drivers/hwtracing/coresight/coresight-syscfg.c:#include "coresight-etm-perf.h"
drivers/hwtracing/coresight/coresight-tmc-etf.c:#include "coresight-etm-perf.h"
drivers/hwtracing/coresight/coresight-tmc-etr.c:#include "coresight-etm-perf.h"
drivers/hwtracing/coresight/coresight-trbe.h:#include "coresight-etm-perf.h"
drivers/hwtracing/coresight/ultrasoc-smb.c:#include "coresight-etm-perf.h"

> 
> Signed-off-by: James Clark <james.clark@arm.com>

LGTM, with or without the subject line change.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  .../hwtracing/coresight/coresight-etm-perf.h   | 18 ------------------
>  1 file changed, 18 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
> index bebbadee2ceb..744531158d6b 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.h
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
> @@ -62,7 +62,6 @@ struct etm_event_data {
>  	struct list_head * __percpu *path;
>  };
>  
> -#if IS_ENABLED(CONFIG_CORESIGHT)
>  int etm_perf_symlink(struct coresight_device *csdev, bool link);
>  int etm_perf_add_symlink_sink(struct coresight_device *csdev);
>  void etm_perf_del_symlink_sink(struct coresight_device *csdev);
> @@ -77,23 +76,6 @@ static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
>  int etm_perf_add_symlink_cscfg(struct device *dev,
>  			       struct cscfg_config_desc *config_desc);
>  void etm_perf_del_symlink_cscfg(struct cscfg_config_desc *config_desc);
> -#else
> -static inline int etm_perf_symlink(struct coresight_device *csdev, bool link)
> -{ return -EINVAL; }
> -int etm_perf_add_symlink_sink(struct coresight_device *csdev)
> -{ return -EINVAL; }
> -void etm_perf_del_symlink_sink(struct coresight_device *csdev) {}
> -static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
> -{
> -	return NULL;
> -}
> -int etm_perf_add_symlink_cscfg(struct device *dev,
> -			       struct cscfg_config_desc *config_desc)
> -{ return -EINVAL; }
> -void etm_perf_del_symlink_cscfg(struct cscfg_config_desc *config_desc) {}
> -
> -#endif /* CONFIG_CORESIGHT */
> -
>  int __init etm_perf_init(void);
>  void etm_perf_exit(void);
>  
