Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021113A4F50;
	Thu, 16 Jul 2026 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784220378; cv=none; b=MSBGZRmmSdZwSkjN4F6h9X2FZuHynfk24zMYYniCZ8UR85+G9QPQ7UcUHZia6d4ozmadlPNgp4IinU9pHKhZM3QsH4hDvxpcgcOZU1RNdF1CyUOvcu/gkFZqPpGIoHAE1FliEonvgPUggs8/v0LzaAVGV9P2KDuOUCjTt8b6RS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784220378; c=relaxed/simple;
	bh=hseTz7znF+RCaYTB7SuHwroA9inc2h7JqiUSTe2rpok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=obnnbnde5gm9o+SmOyl4QiVO5i8Ymq6x3fZmYKqwQ5IO3Ee+qax8l0KgKzeMwMfyBAguACht3SPvy5LI8UTuqrRkjjheiKm8RDuRBUnAiDo3i5rk2IpCa+IU1vpDjMFjjFcd0SdCv6/SdHEhc4EkKVOOdesHb2Tv/KKBIy5g4iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CU7hvK9K; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CU7hvK9K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784220371; x=1815756371;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hseTz7znF+RCaYTB7SuHwroA9inc2h7JqiUSTe2rpok=;
  b=CU7hvK9Kade/tK5O6GNP4JE7LhjYg2ZlFd6D5OnhfERVwz4PDDSbM3VH
   +DZaqNOyvzTxhhmHErIQqf0YvOcYSbvX+yJTafsnCCNUyRp/d7GeaaZhB
   +DiHG8NdKJhv3OJKF+RJXAbNyvm6j71hxqcD12wDbeBpq2sOCvV3hxX1s
   HRLQ8cSq9pVsFE3I4x2InTMMcimlIWKiRgd8ZcRLcuy78pYBEGKV7p17J
   oibh0gNj5zZuN19seokR3orK2z5kjHqDOHH8CDPrxDZxraxyr5RtamQVb
   KiF4NA5Q4BQpBxzdUrUYuiYRVrvQPF166DlU9NJkrjknf0wmj5BIwGaLa
   Q==;
X-CSE-ConnectionGUID: yHM2eW54SiidRU7ylBLd+A==
X-CSE-MsgGUID: mPxj2gFjT1uOn+3Us9w80g==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="95487753"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="95487753"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 09:46:08 -0700
X-CSE-ConnectionGUID: QjdTWgk5Q4e/7dniLms4LQ==
X-CSE-MsgGUID: 2/b3izGFSzGuX1U432Kapw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="254791203"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.109.15]) ([10.125.109.15])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 09:46:07 -0700
Message-ID: <ecd7aea3-88c0-4f1c-8130-c3c9ef9e6869@intel.com>
Date: Thu, 16 Jul 2026 09:46:05 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] perf/cxlpmu: Misc updates
To: Davidlohr Bueso <dave@stgolabs.net>, jic23@kernel.org, will@kernel.org,
 mark.rutland@arm.com
Cc: harshal.t@samsung.com, icheng@nvidia.com, linux-cxl@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20260715191454.459673-1-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260715191454.459673-1-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/15/26 12:14 PM, Davidlohr Bueso wrote:
> Hello,
> 
> Changes from v3 (https://lore.kernel.org/all/20260713061112.105419-1-dave@stgolabs.net/):
>  - Validate the event vendor ID for CRB filtering, the Table 13-5
>    event groups are scoped by the CXL VID in patch 3 (Richard).
>  - Add Richard's Reviewed-by tag to patch 1.
> 
> Three patches for the CXL PMU driver.
> 
> Patch 1 is a standalone fix.
> 
> Patch 2 adds the CXL 4.0 events that hardware exposes but the
> driver did not. It now precedes the filter work as the latter
> refers to the new event group IDs.
> 
> Patch 3 implements Channel/Rank/Bank (CRB) filtering, now permitted
> for all event groups that CXL 4.0 Table 13-5 allows Filter ID 1 on.
> 
> v2 was tested on real hardware. The v4 changes have been exercised
> under qemu CPMU emulation (jic23 tree) + changes for the new events/Filter=1:
> 
>     https://lore.kernel.org/all/20260715190050.458288-1-dave@stgolabs.net/
> 
> Thanks!
> 
> Davidlohr Bueso (1):
>   perf/cxlpmu: Fix 64-bit write to 32-bit HDM filter register
> 
> Harshal Thakkar (2):
>   perf/cxlpmu: Add missing CXL 4.0 events
>   perf/cxlpmu: Support Channel/Rank/Bank filter
> 
>  drivers/perf/cxl_pmu.c | 119 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 116 insertions(+), 3 deletions(-)
> 
> 
> base-commit: d60ec36cab338dfe2ae40d73e9c8d6c4af70d2b8

For the series
Reviewed-by: Dave Jiang <dave.jiang@intel.com>


This is being picked up by the perf maintainer right?


