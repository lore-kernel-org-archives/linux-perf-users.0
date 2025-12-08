Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1173B8D76;
	Mon,  8 Dec 2025 06:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765174906; cv=none; b=r27KbihNJsR+Y9+MnWe/+A7J0SuKHjbD/u4tdbVZ4fgQdJJPNNwl7nqo7uy7HEO77bW51QUtgh24Adr6cwoEVKpC19128iyHN+fL5UVe0eE35wMdcK/14E2b9JFQTozfmvygJAcm5WUNoT6Ba5TFZ1JwZ7LOkdcbgaluFLBfW/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765174906; c=relaxed/simple;
	bh=Sgc22K+hqVWrKX9ZOMCFw+qe0JSLASptWWSFp3tUrDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=erIimMCIEribn5DspF4lK7/vP1zR9om0EGulGh0AheWmbTCX/vSf5dPbuq1k+0jKgoQLxD3mHtudAB3ahUEinJU6yNYKeF+FfOQPZtIBbTQxLCOzX93dgyMcnOkmZCH4Zr96qmMnSN01AEHmjDJItzUnPpvoO2zE5mLe44VhyA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZm04B3F; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZm04B3F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765174905; x=1796710905;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Sgc22K+hqVWrKX9ZOMCFw+qe0JSLASptWWSFp3tUrDM=;
  b=JZm04B3F7yZezoWMlc27o5XdXvLxs9eVlJupUHb63s+2f9EuX5dIz70l
   oj9AfyVAV09v7LzN/6cs/X0rYSKmG5jAZ/EeZLvo8JASFqKxVQS/nV6hK
   HEyXHAHTmMdLiAcQd/uUxoPd3n6h1Ln4Rxf4/LZqdWHG4waVOW9D8Nd2Y
   ZTbDOno8pqRzMvYrShTLiPtRbeQWbbs7NLcjvKntmfz52RZ9tl+01kod9
   gH2GbJaPDc8QYhUTyDQThTxw9jYMP3JY36yOCAl7BzIyVbpKUZj6RWRmh
   83fYe2x2J6GfYryf+BwT5XPxsqD5EMq+NcGoqqid0zr2Trl1msQ/VCJwl
   g==;
X-CSE-ConnectionGUID: 5uBkxPm6QgW5OfWCIeMT7Q==
X-CSE-MsgGUID: ixqT/qZ7QlKP5dWfX2NF5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67277599"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="67277599"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 22:21:45 -0800
X-CSE-ConnectionGUID: DWt7vcx2Sk+aloZNclKgAA==
X-CSE-MsgGUID: uzQspyGwTleiWfWJv1VyWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="200769782"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.12]) ([10.124.240.12])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 22:21:38 -0800
Message-ID: <1fddf87c-ea08-4cde-8851-526c6e672927@linux.intel.com>
Date: Mon, 8 Dec 2025 14:21:36 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 13/19] perf/x86: Enable SSP sampling using
 sample_regs_* fields
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
 <20251203065500.2597594-14-dapeng1.mi@linux.intel.com>
 <20251205122014.GX2528459@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251205122014.GX2528459@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 12/5/2025 8:20 PM, Peter Zijlstra wrote:
> On Wed, Dec 03, 2025 at 02:54:54PM +0800, Dapeng Mi wrote:
>> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
>> index ca242db3720f..c925af4160ad 100644
>> --- a/arch/x86/include/asm/perf_event.h
>> +++ b/arch/x86/include/asm/perf_event.h
>> @@ -729,6 +729,10 @@ struct x86_perf_regs {
>>  		u64	*egpr_regs;
>>  		struct apx_state *egpr;
>>  	};
>> +	union {
>> +		u64	*cet_regs;
>> +		struct cet_user_state *cet;
>> +	};
>>  };
> Are we envisioning more than just SSP?

No idea about this, currently only SSP is supported. 


>
>
