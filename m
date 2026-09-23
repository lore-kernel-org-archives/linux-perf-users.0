Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1642847CA8A;
	Wed, 23 Sep 2026 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154485; cv=none; b=YYDGcowlssqtHVCKK8skm9Lm5PwvKA9M4ReZ97JyikAIbx1d/EgG4uXK8iJSwridSQE+gxR4wFVUnIYmSJmpbhsb8HTMbo9pKghPw7UEVy+eAt0UioVp0Zz4XkUHKXdMaMFmA+OIFJ12Ogc+aohqfxNTdXAVdeOzrYifwniyxcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154485; c=relaxed/simple;
	bh=QBT4a8K6CLN014JYcIX9WXhlkPXQIQy+9DLEU9gJhZE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oml1Ta+5NoJfbC8P9TgapYs9j2lFTNg1gOU0ceK+L9r0c7HR+q3YxS+qsvzE+nC5O4s00SdEYIhcGVwSvgopOcYIOL9yQPYULhkbKDHnNCBMth3pu/oL7ggOtSs4X3lAhicMjNVB3/iMfxpRZMzh4MDZJkCuzkGaPOifbpv8QzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OsuadX5h; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OsuadX5h"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED8311477;
	Wed, 23 Sep 2026 02:07:59 -0700 (PDT)
Received: from [10.2.196.114] (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E82C23F86F;
	Wed, 23 Sep 2026 02:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790154483; bh=QBT4a8K6CLN014JYcIX9WXhlkPXQIQy+9DLEU9gJhZE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=OsuadX5h2obBUQ54Vh78rdgkbMo/+oqCsi+x/aLPh/NciKiK4TL2jEifFVTnhWeJT
	 Da20IprKVxgSgV6gsSNiyDemT0Pup+l4EXK/0yZKCt+lpo+YyjmSeAuXEvMyQzNQeN
	 BpMDx/xTk7etydISgLy3kOATLfB5ARlsYJz0WMCk=
Message-ID: <b823478c-5799-4b23-9e63-774a02082dfc@arm.com>
Date: Wed, 23 Sep 2026 10:08:00 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 38/49] perf python: Port arm-cs-trace-disasm to perf
 module
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, alice.mei.rogers@gmail.com,
 linux-perf-users@vger.kernel.org, namhyung@kernel.org,
 adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, james.clark@linaro.org,
 leo.yan@linux.dev, linux-kernel@vger.kernel.org, mingo@redhat.com,
 peterz@infradead.org, tmricht@linux.ibm.com
References: <cover.1789966896.git.irogers@google.com>
 <f724b653476e2733c18b02268c57baaaa54870ba.1789966896.git.irogers@google.com>
 <20260923090007.GJ200420@e132581.arm.com>
Content-Language: en-US
In-Reply-To: <20260923090007.GJ200420@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/26 10:00, Leo Yan wrote:
> On Sun, Sep 20, 2026 at 10:06:56PM -0700, Ian Rogers wrote:
> 
> [...]
> 
>> ---
>>  tools/perf/python/arm-cs-trace-disasm.py      | 356 ++++++++++++++++++
> 
> A new script is added under tools/perf/python/, but I don't see the
> legacy script under tools/perf/scripts/python/ being removed.
> 
> Should we maintain two copies of the script for the same purpose?

Please ignore this question. I saw the patch 46 removes all legacy scripts.
