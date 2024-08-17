Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C73145B37;
	Sat, 17 Aug 2024 12:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723898499; cv=none; b=mdfVnECSGUf+grXVPZfOmxGqxqQU6M7HFdjMH2kjHj3PX+pNEzMUqhLoUSW36hue0K5yzk2C4hGrIAWbaAEvfWZg1uB6TVI1LMph5elsDLR76iWUus6QhDtkoc9bbwWPsLnjtqk4vGWQgp4O3RtUG8yceGyIQSybE0T+6st1xIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723898499; c=relaxed/simple;
	bh=VNuPAgxI8P5vCLJztz29EedhOgCl/W2GK21rdo1koRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ETeuOrNLhExCjWezqB0d+YGEG7Iji/cqjuyLVObZGDkvAcS3YrjaWmcU/bvMp1ITISR5hMYyX2obmLZ2jC4RUvHJKCJanr6TiQ+pqL7etXznrnzXq0yKR7a5H/0vWHuuMYhcMBUr4pXB3ozM/lvryUbQrpCUiWEc1jy7ZWh3SQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ci9E6VXF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ci9E6VXF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723898498; x=1755434498;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VNuPAgxI8P5vCLJztz29EedhOgCl/W2GK21rdo1koRI=;
  b=Ci9E6VXFZ+++nXYnaqXz9Pyf0SufBYDXtgGWpdhGtlWipUaIGGiu+nTk
   2NrxR93aEgEkgW0Le6pUGRtASgJjphmo1mLGeRSgGXwbwtgQsVwP6ui0z
   k3PzE+wOoC4iskDqQ9acTbsQR5fgH5G7pY8iZCPffrMqyzm5HKsbfhQzQ
   zlPdv144r5r7TgdndRE2fsxbGuQbgtBtKDhDWZotregUwczftM83w9p+I
   EZnlgwUa5jmqjtzm1/HQDj1jRiLvJidljhD5XjP7dyF4gK1SEyibjf7Uh
   FIftfgNyn2TAib2qvkA/NrG77hKXeoRUhwSpBWCgOPpcD+wdKSxgWtX2p
   Q==;
X-CSE-ConnectionGUID: Y43plSj0TuiMORVbn+lm0A==
X-CSE-MsgGUID: zqdOFdoaRnOh+12sY4FLjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11167"; a="13069756"
X-IronPort-AV: E=Sophos;i="6.10,154,1719903600"; 
   d="scan'208";a="13069756"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2024 05:41:37 -0700
X-CSE-ConnectionGUID: wzTGwqwLTWOxKYWyp0nxKQ==
X-CSE-MsgGUID: +c9znqAIQ4eEQVUlcxhGvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,154,1719903600"; 
   d="scan'208";a="60707501"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2024 05:39:43 -0700
Received: from [10.212.114.32] (kliang2-mobl1.ccr.corp.intel.com [10.212.114.32])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 0210D20CFED8;
	Sat, 17 Aug 2024 05:39:41 -0700 (PDT)
Message-ID: <df279b32-54f0-4aeb-894a-c06ef91b34f0@linux.intel.com>
Date: Sat, 17 Aug 2024 08:39:40 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v4 0/6] Bug fixes on topdown events reordering
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yongwei Ma <yongwei.ma@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
References: <20240816122938.32228-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240816122938.32228-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-08-16 8:29 a.m., Dapeng Mi wrote:
> Changes:
> v3 -> v4:
>   * limit metrics event searching inside group for group leader
>     sampling (Kan)
>   * add comments to illustrate supported and unsupported topdown events
>     regrouping formats (Kan)
>   * add more test cases to verify supported topdown regrouping
>     formats (Kan)
> 
> History:
>   v3: https://lore.kernel.org/all/20240712170339.185824-1-dapeng1.mi@linux.intel.com/
>   v2: https://lore.kernel.org/all/20240708144204.839486-1-dapeng1.mi@linux.intel.com/
>   v1: https://lore.kernel.org/all/20240702224037.343958-1-dapeng1.mi@linux.intel.com/
> 
> Dapeng Mi (6):
>   perf x86/topdown: Complete topdown slots/metrics events check
>   perf x86/topdown: Correct leader selection with sample_read enabled
>   perf x86/topdown: Don't move topdown metric events in group
>   perf tests: Add leader sampling test in record tests
>   perf tests: Add topdown events counting and sampling tests
>   perf tests: Add more topdown events regroup tests


Thanks Dapeng.

The series look good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
> 
>  tools/perf/arch/x86/util/evlist.c  | 68 ++++++++++++++++++++++++++++--
>  tools/perf/arch/x86/util/evsel.c   |  3 +-
>  tools/perf/arch/x86/util/topdown.c | 64 +++++++++++++++++++++++++++-
>  tools/perf/arch/x86/util/topdown.h |  2 +
>  tools/perf/tests/shell/record.sh   | 45 ++++++++++++++++++++
>  tools/perf/tests/shell/stat.sh     | 28 +++++++++++-
>  6 files changed, 201 insertions(+), 9 deletions(-)
> 
> 
> base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
