Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221C522D4DC;
	Mon,  8 Dec 2025 06:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765173657; cv=none; b=Gt81ICkDau41c6cevwTnJDyRSIKT51zKwakdDRu0BYGXNdbqbZ0BkvQH09XXsyCtQPbEcovzpMf2I5vNRq+PfZtphwxouMdBiUnWiZrt5k9tzOya4wqx4xabqW4VccwIFjWxVDQeB4hypUe8btNftHZ9sl+jhIsp0fFU4XF1YCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765173657; c=relaxed/simple;
	bh=vCzULPTWc7Q3dx9hLUV1hFVQFwFpyYJvUTxprmAzRPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qRjHZy4ORfeUjLYOxkBiL7beGC965NxWCc2dbuPkWAR7XiBTd5hyDgR4a1U/7pXkAVRGnYGKdv9EkfKkvJuUlq0QdFchxrIqsckGv9LbZVxpkjKvUB5iU0ZmtANhGx1dhWanKma+LuvYEJf9ZY2Aye3fLSXd5DITTz2MAy2a3Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=agqIUycS; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="agqIUycS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765173654; x=1796709654;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vCzULPTWc7Q3dx9hLUV1hFVQFwFpyYJvUTxprmAzRPU=;
  b=agqIUycSgr166L4pYLnF6/yhGNu2WsJHU1p5UkOx1q+aTpcbmcExBq2e
   SuroNGvUsTVucKsXGnueSwDF72VKiUEoDph7XbJV6FA+78+LXCtEPkpwN
   w3O0Fdg5d+o65qiPaJC0jRmL46FMXpO2UJDNYlIj+3PMeeiUGLFAIU4Iq
   dWUIfQmqsGJSAuFbdC4IcO8xhy1VUI9S0Usb722ldHw5y6aHhcJSkm01r
   +1iSyQ1TT4do1zOK9pnEKqZrpmcrTdN4o+HhOv5w9xYLliY/nTWxIhGPf
   OJRkE9C/Wxty8A2D38fQDKw2aOrocOK1Set3QOdsTFYSQ5zqnHEBzT411
   g==;
X-CSE-ConnectionGUID: 1OHL1NwBRga0KwXNzwlIBQ==
X-CSE-MsgGUID: 2bwTroldSzyUpa8jxqyPCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="66112400"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="66112400"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 22:00:53 -0800
X-CSE-ConnectionGUID: JAiwGYgTQC2c/DORcui6Iw==
X-CSE-MsgGUID: 8Q+Lfm/YQUmR+PDhow0HhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="196311128"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.12]) ([10.124.240.12])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 22:00:48 -0800
Message-ID: <2c057288-afe9-4117-8db3-5211fb82615c@linux.intel.com>
Date: Mon, 8 Dec 2025 14:00:45 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 07/19] perf: Add sampling support for SIMD registers
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, Kan Liang <kan.liang@linux.intel.com>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <20251203065500.2597594-8-dapeng1.mi@linux.intel.com>
 <20251205114006.GV2528459@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251205114006.GV2528459@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 12/5/2025 7:40 PM, Peter Zijlstra wrote:
> On Wed, Dec 03, 2025 at 02:54:48PM +0800, Dapeng Mi wrote:
>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 3e9c48fa2202..b19de038979e 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -7469,6 +7469,50 @@ perf_output_sample_regs(struct perf_output_handle *handle,
>>  	}
>>  }
>>  
>> +static void
>> +perf_output_sample_simd_regs(struct perf_output_handle *handle,
>> +			     struct perf_event *event,
>> +			     struct pt_regs *regs,
>> +			     u64 mask, u16 pred_mask)
>> +{
>> +	u16 pred_qwords = event->attr.sample_simd_pred_reg_qwords;
>> +	u16 vec_qwords = event->attr.sample_simd_vec_reg_qwords;
>> +	u64 pred_bitmap = pred_mask;
>> +	u64 bitmap = mask;
>> +	u16 nr_vectors;
>> +	u16 nr_pred;
>> +	int bit;
>> +	u64 val;
>> +	u16 i;
>> +
>> +	nr_vectors = hweight64(bitmap);
>> +	nr_pred = hweight64(pred_bitmap);
>> +
>> +	perf_output_put(handle, nr_vectors);
>> +	perf_output_put(handle, vec_qwords);
>> +	perf_output_put(handle, nr_pred);
>> +	perf_output_put(handle, pred_qwords);
>> +
>> +	if (nr_vectors) {
>> +		for_each_set_bit(bit, (unsigned long *)&bitmap,
> This isn't right. Yes we do this all the time in the x86 code, but there
> we can assume little-endian byte order. This is core code and is also
> used on big-endian systems where this is very much broken.

Oh, yes. Just ignored the endians. Would fix it in next version. Thanks.


>
>> +				 sizeof(bitmap) * BITS_PER_BYTE) {
>> +			for (i = 0; i < vec_qwords; i++) {
>> +				val = perf_simd_reg_value(regs, bit, i, false);
>> +				perf_output_put(handle, val);
>> +			}
>> +		}
>> +	}
>> +	if (nr_pred) {
>> +		for_each_set_bit(bit, (unsigned long *)&pred_bitmap,
>> +				 sizeof(pred_bitmap) * BITS_PER_BYTE) {
>> +			for (i = 0; i < pred_qwords; i++) {
>> +				val = perf_simd_reg_value(regs, bit, i, true);
>> +				perf_output_put(handle, val);
>> +			}
>> +		}
>> +	}
>> +}
