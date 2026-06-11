Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0CF40D576;
	Thu, 11 Jun 2026 06:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781158646; cv=none; b=Idp41BQgZ6bs9siih4anANjxn0RwunSXsNU+KGwits6yfcl43J9cLwL8+V4RRTADtlrDqWyd6Hhzg5bocVAuNIU1g61GcHpkQn7JFrm8cQy1abTdmIIzukehOoK1S8ceme3TGOYWM7CvPHyfWosodjSjuKvu/FfYe3aYFoxYl3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781158646; c=relaxed/simple;
	bh=4V+S9fWTmJJOm4C50tCarN3J4FFa5XfmrT2pkh8/x0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sGUNu1Zfg5Q8sQJzHwnCZh1RedpX1H18QADZz0sxU58Jm2h+DDPFdS8GYVrtKsGRa6VcS4y0XOPaS1xe5hhZztfycctVDEkvrd6WgMUM4eqgLodJK8G6kNwzobXhzlqS2JgndIed/07IdGF+sadGpbqNCeVgc1XptC6uXWIFO+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E2CBfApS; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E2CBfApS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781158644; x=1812694644;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4V+S9fWTmJJOm4C50tCarN3J4FFa5XfmrT2pkh8/x0M=;
  b=E2CBfApSWaLLJp+7BWNEFFagn/mh7r3R+4svw98yzq99VPgr1UWB3poD
   o+Z1aYXD8hm8xNmhEMDh0+m72U5WVQox4atMSOlANYT2uIfp97JYYdagz
   /CSyxjCchhyAszhAWi32Xe1ttZovrRoNb6Ig2OoRCVPcyJ6EOWNUpnOHM
   5xpV6V/zXyIgU8HAQV5QkzasCFTOe5PGZ7nn/j1KAcx0DKsO05zdN7XYr
   RZIBHL96l/XQZGUTG7tFygcTO7REPwTFh92cFAn+yY7HJjLT9ChGDR8ng
   dy4vorhN3hNVJL9yBnWT+m825L6FA00nBwLXr3NjYE1c+dS6q+HIKyvRW
   g==;
X-CSE-ConnectionGUID: WMmAI89UT3yUOWuFWG6StQ==
X-CSE-MsgGUID: MRtbqhC5SSqC/t+zXS+5bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81944639"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="81944639"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 23:17:23 -0700
X-CSE-ConnectionGUID: JV4MQKaNQNay95S0Fx7lLw==
X-CSE-MsgGUID: r+nwfcFwT6myw972UKm64g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="250667256"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 23:17:20 -0700
Message-ID: <49a4a4f9-8de6-469c-b66d-160b124cd50c@linux.intel.com>
Date: Thu, 11 Jun 2026 14:17:17 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 8/9] perf/core: Fix kernel register info leak via
 hardware skid
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Mark Rutland <mark.rutland@arm.com>
References: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
 <20260609050222.2458129-9-dapeng1.mi@linux.intel.com>
 <20260610091625.GE48970@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260610091625.GE48970@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/10/2026 5:16 PM, Peter Zijlstra wrote:
> On Tue, Jun 09, 2026 at 01:02:21PM +0800, Dapeng Mi wrote:
>> An unprivileged hardware perf event using exclude_kernel=1 can leak kernel
>> register data to user space via PERF_SAMPLE_REGS_INTR or PERF_SAMPLE_IP.
>> Due to hardware skid, a PMI may trigger after the CPU has already entered
>> kernel space (Ring 0), bypassing the perf_allow_kernel() privilege
>> barrier.
>>
>> This security vulnerability is severely exacerbated by upcoming support
>> for SIMD register sampling via XSAVES, which could expose sensitive kernel
>> FPU states (such as active cryptographic keys).
>>
>> Fix this by ensuring that sampled register data is dropped if the event's
>> exclude_kernel attribute is set but the PMI catches the CPU in kernel mode.
> There is history here, see for example:
>
>   https://lore.kernel.org/r/CAP045Ap8cMx6mzSgcQ3n3bnh_8GJuCp7_KZe_5ZTCR_K6cPTLw@mail.gmail.com

Thanks for the information. What a long discussion!


>
> So your earlier patches also sanitize the branch stack, but not in
> generic code.
>
> PHYS_ADDR already requires privileges
> ADDR comes from PEBS on Intel, and IBS on AMD (iirc) and should be
> reliable.
>
> So yeah, I suppose IP and REGS_INTR are the big ones.

Yes. Besides IP and REGS_INTR, callchains could be another risk. Currently
SAMPLE_CALLCHAIN doesn't explicitly require the perf_allow_kernel() check,
which could leak to kernel callchains to user space. This would be fixed in
next version.

As for the branch_stack, it should be reliable since it comes from LBR
which already has correct CPL configuration.

Thanks.


