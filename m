Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A3135C183;
	Thu, 23 Apr 2026 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776936637; cv=none; b=QhummEYJq/6xvBrUlbS2wwVjV8dJOunNDwcfV1PFQWBZwxSZanIjkK4W80sGegadoDA6wj6Pl6uPKs2QEqbkG7OA43ZLKNAza35UsvaOAnNZX3QfRfrmM8Z8p13IobPSmh6MyU2osOQTkpoqLqkaTh3Og4WCVMKrPF3Ok7B57Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776936637; c=relaxed/simple;
	bh=Lw5CoPM3yw6I/ruCGCCd366Q19a0AsNp39fk5OWzGVU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BxpooB4y1uK+mkDECDIGDtbqiIi119fiyjP6TpGER11ZjH4cPLRsw35/iw0XnOZEa18gcVuruglNUHmE+Ow2SlaJ/rVESwHd7G3hL+qref/FDvZzhkNasz4fpLkRCZW/fSSqqOY3M7eVwurA7KUpw7CRRatclN2tgPuImVZGcnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dikejyKK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dikejyKK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776936636; x=1808472636;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=Lw5CoPM3yw6I/ruCGCCd366Q19a0AsNp39fk5OWzGVU=;
  b=dikejyKK3ZRIxRV3VfYioBJLR27kiZlrBJGScb3SqeAZII4FjYEHqn75
   yup5Zq1vDW6Awaa3jHuaRbYlVpBA4tfHTQ6aPyIk+F1Yu95yX6dcY71tV
   oK6TW+BM3luD1EEPM2IOAHzJyXI9Wza0kJpRhbrvPBUJi/GzeTMP105Vt
   tmo2u4r6HhvMJJ0ogLFMMqYWJww4G4xGF1soYKTEqc7R7V7nbska7hBJ8
   mpiSeFVk765De8B739mq9aXkrOeP8Md1xq+3kQBNiPc47rCfUenvM25pH
   AR5LBd3602k8J9LTMtoQ1ERfsf2fd35pQUPI3P9san13qLYdi2M08sGkG
   g==;
X-CSE-ConnectionGUID: wz252mQ8TgqX6BH0/XxR6Q==
X-CSE-MsgGUID: Io/2PEyGQGmpuLqdUdBKyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77784671"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="77784671"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 02:30:34 -0700
X-CSE-ConnectionGUID: +eplm5smQu61G0DcQrX+8g==
X-CSE-MsgGUID: w1QmiCopTbSIvsQci7p5Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="263001252"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 02:30:24 -0700
Message-ID: <4dc87e05-7a94-4f8b-a31a-b9be7183f483@linux.intel.com>
Date: Thu, 23 Apr 2026 17:30:21 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 2/4] perf/x86/intel: Disable PMI for self-reloaded ACR
 events
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
To: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
 Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, stable@vger.kernel.org
References: <20260420024528.2130065-1-dapeng1.mi@linux.intel.com>
 <20260420024528.2130065-3-dapeng1.mi@linux.intel.com>
 <aef8InBGlZaXNuPk@tassilo>
 <f1cb6c84-d8ff-46a0-a062-816fce9fc164@linux.intel.com>
 <aekAUXkbHfOfPxX1@tassilo>
 <4b7e6df6-3a9c-45c2-84ae-f738e5741bb6@linux.intel.com>
Content-Language: en-US
In-Reply-To: <4b7e6df6-3a9c-45c2-84ae-f738e5741bb6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/23/2026 9:01 AM, Mi, Dapeng wrote:
> On 4/23/2026 1:07 AM, Andi Kleen wrote:
>>>> Are you sure this doesn't conflict with some other non ACR usage of config1?
>>> Yes, currently hw.config1 is only used to store ACR  event indices.
>> Thanks. Should probably rename the field to make that clear.
> Yeah, would do. Thanks.

Just look the code again, the config1 is defined in hw_perf_event structure
which is a generic structure used by all kinds of different architectures.
Although currently it's only used to save the ACR events index mask by x86,
it could still be used for other specific usages on other architectures in
the future. So we'd better keep this generic name "config1" then. 

Thanks.


>
>
>> -Andi
>>
