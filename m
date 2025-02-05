Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06381FE457;
	Wed,  5 Feb 2025 19:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782511; cv=none; b=cRSX53xIh37ozpuvHx7adSS2cDB/HQcSbJenDEp7aoIcAtYiN6JTBiAxMwdlMzDonXFMVPj5rwYNBPMLhjt8JdPLiZgxpOtuaMMEnemz3HvCJsHVTLNlww/r57pXttHNmh4pg6QlLI/F7U+Y1s1e389RvtJWpoBSTVKJxdf8zI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782511; c=relaxed/simple;
	bh=dnJgMi4zg/epD10uQJ6bbgev+61srshHSuWv4akvbGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DO9JpdJdswhpBit8Subq8pOsP7rrmrihxLmWa+C2zTK1RnAneNJ1J91v3hWlrOTHzf3STMOeWa0cwqoGe1wvfgSGhofTgGMoQiwMWJRS2G+mOVKkA9yfU9L9BIB5P/O86XFS1oqrhZ29LOQYFZ/tQudxsxa4iV9awAYqZlYGuLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FRw8EnxO; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FRw8EnxO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738782510; x=1770318510;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=dnJgMi4zg/epD10uQJ6bbgev+61srshHSuWv4akvbGw=;
  b=FRw8EnxOfgEVQ3DOTtf7BWQ3zm2Rh47j4VeMImXpyfJEh84cE3EfKm2V
   uZ9YTbXtglL1WRQBbIsWoet7nGj8plM8GoRpA171wXBRa+sPRVrQBWlYL
   TiALaanuBcmyRpLnTbJOaTztBSl1H0P1uSIvns78EihJpPng/7LNLrNTu
   oKAu5Cybdrst/p1WMUS8fky0df5ElG9eDJ4ENkS6x8cbXDqIRwvMabz6I
   +wn55PS5F1VSVyZ4vaZlR9hPt1FaBp9HTFsumM7+3Ill1X0aXOcwiHmtS
   MXDT1LgZkfuureOgn8k6MaoPw5cRkIdefu9YkKfIQqq70sYgsispQgxjd
   A==;
X-CSE-ConnectionGUID: NJqDUSeZS3GYLZcLCglTKg==
X-CSE-MsgGUID: VZitAcs8SbKw6KvKQg7+yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="26968208"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="26968208"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 11:08:29 -0800
X-CSE-ConnectionGUID: 5TVZYAUYSZGl9vM8BqJdIA==
X-CSE-MsgGUID: uwjm7/IuQ7SdWutshFWmAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111880153"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 11:08:29 -0800
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id C083820B5713;
	Wed,  5 Feb 2025 11:08:26 -0800 (PST)
Message-ID: <53e43c87-9052-4e4a-88fc-a5bc3b713ae5@linux.intel.com>
Date: Wed, 5 Feb 2025 14:08:25 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/24] perf vendor events: Add Arrowlake events/metrics
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>,
 Samantha Alt <samantha.alt@intel.com>,
 Caleb Biggers <caleb.biggers@intel.com>,
 Edward Baker <edward.baker@intel.com>, Michael Petlan <mpetlan@redhat.com>,
 Thomas Falcon <thomas.falcon@intel.com>
References: <20250205173140.238294-1-irogers@google.com>
 <20250205173140.238294-4-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250205173140.238294-4-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-02-05 12:31 p.m., Ian Rogers wrote:
> +    {
> +        "BriefDescription": "Counts the number of issue slots that result in retirement slots",
> +        "MetricExpr": "cpu_atom@TOPDOWN_RETIRING.ALL@ / (8 * cpu_atom@CPU_CLK_UNHALTED.CORE@)",
> +        "MetricGroup": "TopdownL1;tma_L1_group",
> +        "MetricName": "tma_retiring",
> +        "MetricThreshold": "(tma_retiring >0.75)",
> +        "MetricgroupNoGroup": "TopdownL1",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },

The "Default" tag is missed at least for all TopdownL1 metrics on Arrow
Lake.

Thanks,
Kan
