Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97971B0F01;
	Thu, 28 Nov 2024 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732805996; cv=none; b=m1aa8omR/os6Kj4Np8AF9rdeMNgILTTS7ADvSginhrmNtMOCfsrq3KGOAAtJaSwl62qGq9y1i/sA0Stjkj41npV+oEeORatGqlP/ZAlK2eCF+zqxPsPKmr1zTNVs0oKWWXEFn9tdAl/WbQgez98nSBWZZ2jK3ivhNV4W0MAHVs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732805996; c=relaxed/simple;
	bh=6f6MLMpau+B/8Ci0FW+Nc7bb32EL3D9jNH6aMfLE/X0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJgSty+rGM+wUDFlcZ2vcuep6GuYJsvEmISGrb/zWwydFEg+WR8qk+Xf8pwz4boHdZIgd+IWZ1nXML86NPJLfP/TPArw2Ch4F6behCXZILYMyHBliTweQBtNUQNBWysFeREynznsOOUmHfIUB8ER1XuEy3LGYqeiyaS8yceWRtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T3IdE1Q9; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T3IdE1Q9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732805995; x=1764341995;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6f6MLMpau+B/8Ci0FW+Nc7bb32EL3D9jNH6aMfLE/X0=;
  b=T3IdE1Q9yK97Zhd8Fhq/y2D7bsYyL7AyhMK/NxI66G4B6a81Rq8AHrgP
   mdrjr52JDtkRL35FQUT9RaEqYSuM61pV9goXQ5h64KXIwoKKjfGPD1C1w
   xQSx+cRQUkvExxIoIcfcvO5AUU8FZvz9CxxXsXkphwChBVvKgCRwpx7s3
   ZapOxzwcvOdh8UY3aV9YvgZW4xvdvNgDaDg3wREah2DbUDyoFb+B0rTCO
   3nW+0CV+x2IDRwm4G4Dn0GX2q6XM7em7NAtbrllYFa1cIMFn0Hi3s04gR
   cqa3cJs5vNjrJkMrS/J8oaZyWXZsvIcKEN7rmwD2bm9kr3pIm15qtQ7q9
   w==;
X-CSE-ConnectionGUID: lZxUBYxVRQyR9+34shixdw==
X-CSE-MsgGUID: FOQikDf/RO+oeFDHgDZU1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="43530728"
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="43530728"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 06:59:54 -0800
X-CSE-ConnectionGUID: HOXG+o28SF6UECOTsGN/Gw==
X-CSE-MsgGUID: lKZo8xPgRq2k7se68ERlwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="97016246"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 06:59:54 -0800
Received: from [10.246.136.4] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id C831F20B5705;
	Thu, 28 Nov 2024 06:59:52 -0800 (PST)
Message-ID: <d40c6d0e-3755-4cfa-bb9e-e2aa520edb0f@linux.intel.com>
Date: Thu, 28 Nov 2024 09:59:51 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf tools: Avoid unaligned pointer operations
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
References: <20241128010325.946897-1-namhyung@kernel.org>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20241128010325.946897-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-11-27 8:03 p.m., Namhyung Kim wrote:
> The sample data is 64-bit aligned basically but raw data starts with
> 32-bit length field and data follows.  In perf_event__synthesize_sample
> it treats the sample data as a 64-bit array.  And it needs some trick
> to update the raw data properly.
> 
> But it seems some compilers are not happy with this and the program dies
> siliently.  I found the sample parsing test failed without any messages
> on affected systems.
> 
> Let's update the code to use a 32-bit pointer directly and make sure the
> result is 64-bit aligned again.  No functional changes intended.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
> v2) use '%' instead of '/' to check alignment
> 
>  tools/perf/util/synthetic-events.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index a58444c4aed1f1ea..6923b0d5efede4a7 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -1686,12 +1686,16 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
>  	}
>  
>  	if (type & PERF_SAMPLE_RAW) {
> -		u.val32[0] = sample->raw_size;
> -		*array = u.val64;
> -		array = (void *)array + sizeof(u32);
> +		u32 *array32 = (void *)array;
> +
> +		*array32 = sample->raw_size;
> +		array32++;
> +
> +		memcpy(array32, sample->raw_data, sample->raw_size);
> +		array = (void *)(array32 + (sample->raw_size / sizeof(u32)));
>  
> -		memcpy(array, sample->raw_data, sample->raw_size);
> -		array = (void *)array + sample->raw_size;
> +		/* make sure the array is 64-bit aligned */
> +		BUG_ON(((long)array) % sizeof(u64));
>  	}
>  
>  	if (type & PERF_SAMPLE_BRANCH_STACK) {

