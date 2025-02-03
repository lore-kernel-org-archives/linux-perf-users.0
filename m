Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB07209F59;
	Mon,  3 Feb 2025 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738598763; cv=none; b=uejrHCJj/Sfw0+hCryQFfV9D14tlhR5bvL7tWT1XsApE+kiDKmf+2a7MyA9fawPWXUuM12z4/scsMFup2kEZq2BZedIX8KuB1K8xJJdk/9rpCrKnKSrAPTt6huW4ET6Ga1tLHNA5d9fGxMN9ZA5JiJqKdfHBm3LoJUDs96HYzbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738598763; c=relaxed/simple;
	bh=GMxT679nrKOSVT27eHqv8mA9W6VoZ8CApmuTH/wJ4xE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZUhCm5zrW3MKa5d88ryvHaVgww5ZUnOdOBHsfd+ANAkLkwfZz/bXbVt3MV89hLuRzRQt4v7VUTWrL8GIASmTfHvNIj9A2l3NR2LSu7kCx2L9wO3NqTVuCwsldggbAlfxF48dDAWxT9KlKeLg91zR1WYHFYe73acDpDSeygOXVOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GR+ZLyd5; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GR+ZLyd5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738598762; x=1770134762;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=GMxT679nrKOSVT27eHqv8mA9W6VoZ8CApmuTH/wJ4xE=;
  b=GR+ZLyd5jQtE4YunCqteLgXEumce+Ow4hgdfpd3oisrwTMmlUnC1VqlJ
   T9LhFgq0xmuwMLL2wzlr8WAfPeK2WaiiHg4gSJogMuvjGuhEd6Hz6U/5O
   wHRudSVlGnQD1tjei1Clx3UvuIAmLSxJQVon0ZjdwvnHaIKrFc9XlUT7c
   fcuo9HAeD5yfKczSBhfW50leBGJ/1f/m5GEPs6sJVVuT7BKvXL6Hr+gfG
   c3zpbTEUp3KHS4w/j/C8v/Y6j3RbWbezjkA115DaDMwtUVRiSODpvVFIx
   Wp5MotP9PawYobcRNa9oCx58HvfmzhtSBhEMQTPsiKmR8CDV5vVJyU/Vk
   A==;
X-CSE-ConnectionGUID: Jmabskc5RHm0eag1emrTFw==
X-CSE-MsgGUID: 4VIs8AoZTjK84o898vmtnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="50088713"
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; 
   d="scan'208";a="50088713"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 08:06:01 -0800
X-CSE-ConnectionGUID: M/1ygkzARymibtrYrdm3jQ==
X-CSE-MsgGUID: +LjIrMpMQMaE/mSZYcsywg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; 
   d="scan'208";a="141200470"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 08:06:01 -0800
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id F0EBE20B5713;
	Mon,  3 Feb 2025 08:05:58 -0800 (PST)
Message-ID: <b4fcdcb2-455d-4523-9a92-14dc9cc8be2b@linux.intel.com>
Date: Mon, 3 Feb 2025 11:05:57 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] perf hwmon related improvements
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>,
 Weilin Wang <weilin.wang@intel.com>,
 Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
 Junhao He <hejunhao3@huawei.com>, Yicong Yang <yangyicong@hisilicon.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250201074320.746259-1-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250201074320.746259-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-02-01 2:43 a.m., Ian Rogers wrote:
> Try to do less scanning of files/directories with or without hwmon
> PMUs. Don't merge all events with the same name, only merge those on
> the same PMU ignoring suffix. Tidy PMU name matching to distinguish no
> suffix or wildcard matching. Refactor uniquification so the evsels
> with the same name as other evsels in the evlist are uniquified.
> 
> v3: Address potential segv and styling nits from Kan Liang.
> v2: Rename ignore suffix PMU name matching that is really a
>     wildcard/prefix match. Use a proper ignore suffix when not merging
>     counters purely on name.
> 
> Ian Rogers (5):
>   perf evsel: Reduce scanning core PMUs in is_hybrid
>   perf pmus: Restructure pmu_read_sysfs to scan fewer PMUs
>   perf pmu: Rename name matching for no suffix or wildcard variants
>   perf stat: Don't merge counters purely on name
>   perf stat: Changes to event name uniquification
> 

I didn't do much tests on the hwmon. But it changes the common codes
which impact other PMUs. I did tests mainly on core, uncore and other HW
PMUs on a hybrid platform. No regression is found.
The patches look good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

>  tools/perf/pmu-events/empty-pmu-events.c |   8 +-
>  tools/perf/pmu-events/jevents.py         |   8 +-
>  tools/perf/tests/pmu.c                   |  85 ++++----
>  tools/perf/util/evsel.c                  |   4 +-
>  tools/perf/util/evsel.h                  |   1 +
>  tools/perf/util/parse-events.c           |   2 +-
>  tools/perf/util/pmu.c                    | 256 ++++++++++++++++-------
>  tools/perf/util/pmu.h                    |   7 +-
>  tools/perf/util/pmus.c                   | 146 ++++++++-----
>  tools/perf/util/stat-display.c           | 111 +++++++---
>  tools/perf/util/stat.c                   |  13 +-
>  11 files changed, 424 insertions(+), 217 deletions(-)
> 

