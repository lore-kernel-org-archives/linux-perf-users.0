Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47631FC7FB;
	Fri,  5 Dec 2025 04:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764910447; cv=none; b=Wy93vkNoSKF9iZzKMgKcbRWzqAYXqUHL2INP5u33M/DcaeUti549t+iNYgFOqw7o9Je+ecwd6yE4NxOLUm2vR4QxwUqhZxKzRaeUs2izO2jr4RR1fKkYT4rYobcl5BXT7fZJ7sdvzJFaZdl2Scki0WwjA9YK7fjovOYpnYmbq6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764910447; c=relaxed/simple;
	bh=fGLX4f9BliEq3ff+cYL7QS/mZsPXQVrIupq0uNqdeP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rh3Bc+SA2Xgo3xx8xsKkVCiGnZV7Q6jvgWIRARfquYTk9lwcP7pgjcKxnneD5EDWsglIcKjzwT9NX/ixbbGsHkp831vCzfv80wCl5sXd4rfjckNuglikvM9xA3VAM87b5QuenSTV3jG7rz05ZKQyS+LRt7K/dI5cC7dfuMpPZkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F012339;
	Thu,  4 Dec 2025 20:53:56 -0800 (PST)
Received: from [10.163.52.42] (unknown [10.163.52.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBD9C3F59E;
	Thu,  4 Dec 2025 20:53:57 -0800 (PST)
Message-ID: <ae9aacb1-29ae-4e05-ac55-0db555c3e455@arm.com>
Date: Fri, 5 Dec 2025 10:23:54 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/19] coresight: trbe: Support trigger and circle buffer
 modes
To: Leo Yan <leo.yan@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 Yeoreum Yun <yeoreum.yun@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Tamas Petz <tamas.petz@arm.com>,
 Tamas Zsoldos <tamas.zsoldos@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/12/25 4:51 PM, Leo Yan wrote:
> The current TRBE driver operates only in fill mode, where tracing stops
> at the top of buffer and a maintenance interrupt is raised.  Due to
> interrupt latency, tracing is halted while the program continues to run,
> resulting in trace data lose.
> 
> This series enhances the driver for the trigger mode to mitigate trace
> discontinuity.  The circle buffer mode is introduced to avoid any
> maintenance interrupts during the snapshot session.
> 
> It can be divided into three parts for easier review:
> 
>   Patches 01~05: Minor refactoring for disabling operations and
>                  clearing status.

Could these patches be posted first ?

>   Patches 06~12: Refactor fault action and trace size calculation.

Followed by this set which still keeps the existing functionality intact.

>   Patches 13~19: Support trigger and circle modes. To better utilize the
>                  new buffer modes, perf sets the watermark to
> 		 one-quarter of the buffer size.

Then finally all above changes which are newer functions and tests etc.

I guess that will be much easier to review.

> 
> This series is applied on coresight-next branch and has been validated
> on Orion O6 board:
> 
>   1) The trigger count and wrap mode are verified using Ftrace logs.
>   2) A new kunit test module verifies limit and count calculations.
>   3) Basic perf record / script commands and module load/unload have
>      been tested successfully.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
> Leo Yan (19):
>       coresight: trbe: Use helpers for checking errata
>       coresight: trbe: Remove redundant disable operation
>       coresight: trbe: Remove buffer disabling in trbe_handle_overflow()
>       coresight: trbe: Remove set_trbe_disabled() from the enable flow
>       coresight: trbe: Refactor status clearing
>       coresight: trbe: Refactor syndrome decoding
>       coresight: trbe: Refactor AUX flag setting
>       coresight: trbe: Use PERF_AUX_FLAG_PARTIAL instead of PERF_AUX_FLAG_COLLISION
>       coresight: trbe: Add fault action argument to trbe_handle_overflow()
>       coresight: trbe: Always check fault action when updating buffer
>       coresight: trbe: Apply overwrite erratum for only wrap event
>       coresight: trbe: Calculate size for buffer wrapping
>       coresight: trbe: Remove misleading comment
>       coresight: trbe: Refactor compute_trbe_buffer_limit()
>       coresight: trbe: Add static key for bypassing trigger mode
>       coresight: trbe: Support trigger mode
>       coresight: trbe: Enable circle mode for snapshot
>       coresight: trbe: Add kunit tests
>       perf: cs-etm: Set watermark for AUX trace
> 
>  drivers/hwtracing/coresight/Kconfig                |   9 +
>  drivers/hwtracing/coresight/Makefile               |   1 +
>  .../coresight/coresight-trbe-kunit-tests.c         | 536 +++++++++++++++++++++
>  drivers/hwtracing/coresight/coresight-trbe.c       | 440 +++++++++--------
>  drivers/hwtracing/coresight/coresight-trbe.h       | 111 ++++-
>  tools/perf/arch/arm/util/cs-etm.c                  |   7 +
>  6 files changed, 896 insertions(+), 208 deletions(-)
> ---
> base-commit: 9e9182cab5ebc3ee7544e60ef08ba19fdf216920
> change-id: 20251120-trbe_buffer_refactor_v1-1-8f8023105469
> 
> Best regards,

