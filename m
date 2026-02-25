Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15564A0C;
	Wed, 25 Feb 2026 00:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771980952; cv=none; b=ov06VazKR6JstMVGvBrID3CXlYTGyzjJ7KdoM8dhdscEZItVrUN31q+tmX1wcyXi9kTKpw8TE0mhgMIlWlejKNimEk9Hjtv1UZMfTPkIwdTCf/EcCmnQ+Acwl/X/1FJLE/rC1dXASQ0MtbB9nr7UymegrareCSUHgxhGwK5Vxlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771980952; c=relaxed/simple;
	bh=XzYlzouyKPKYpK7gYE6MgeC4F1szB33u/1VmBHLOkDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aXy2ZGjfZot197FwEdqtjmVSm+wF3iC1+nD5fFvMP68AvTgCvcsNpbD4ThNKEmVl87i5Yeh6jSI4pz+dWp5+CO9vJGvKS0gsQK9p8QE1Y3r5fJtog2lZ1LdGrTbzFrH7B30sGKkGr4ok1Jhlyhr8q4na05I6MoHuXK0fFLN0uFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cH2gcYi2; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cH2gcYi2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771980950; x=1803516950;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XzYlzouyKPKYpK7gYE6MgeC4F1szB33u/1VmBHLOkDc=;
  b=cH2gcYi2mvnSFMQGM5C3hfDsdVHpIQKek4l/G7enRjbuBhcD7i/bVGX9
   83gfeGmq3wKk3PX1gEbw5Go0pm9Hp2ot+Trz/Rd5YrNJbRvPo1Yofz65O
   gMX2Dt2+WPrCCRH/J1WqB3ABsHAhZtjdHuipAeVsrhoVO7ozOh/TYYoax
   FxHxyyj+ZFtU4C3+4/NIhHbIZvhZQPsBD0o/seFBQRMf/6OvcoSHJNT/c
   M8clOR+sbNTSFvmM2tKVpQPAdQuXI5eGpfCDOxJTo0Q2s9oniQUS18zy7
   b20iGqRCklLPjUFeNIOoYNZfVdP6iQRYCDmgIzQp+G1DFgY9piBc6NZGf
   g==;
X-CSE-ConnectionGUID: EAi/6GNMRla/itTS1Tl8KQ==
X-CSE-MsgGUID: ahm4wrG/RvOe+j3C+pmWRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="83723771"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="83723771"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 16:55:49 -0800
X-CSE-ConnectionGUID: VkyIKaZmT/OqGa333fpWmw==
X-CSE-MsgGUID: SIebFE9BSW6VDVKE0I0BzQ==
X-ExtLoop1: 1
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 16:55:43 -0800
Message-ID: <a8a35490-994c-498a-acab-478795c868b0@linux.intel.com>
Date: Wed, 25 Feb 2026 08:55:41 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v6 10/22] perf/x86: Enable XMM Register Sampling for
 Non-PEBS Events
To: "Chang S. Bae" <chang.seok.bae@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, Kan Liang <kan.liang@linux.intel.com>
References: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
 <20260209072047.2180332-11-dapeng1.mi@linux.intel.com>
 <c287e7fb-d504-46fe-b6dc-af28c3532be6@intel.com>
 <e57a249b-ce70-4f5a-86f5-cd86bc477546@linux.intel.com>
 <f48500c5-dfaf-4ca2-9f9d-3d3b1e9f2299@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <f48500c5-dfaf-4ca2-9f9d-3d3b1e9f2299@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2/25/2026 3:13 AM, Chang S. Bae wrote:
> On 2/23/2026 11:11 PM, Mi, Dapeng wrote:
>> intent of this whole function is to sample the required SIMD and APX eGPRs
>> registers by leveraging xsaves instruction in a NMI handler context. All
>> the SIMD and eGPRs registers are collectively called "extended registers"
>> here. Not sure if the "extended registers" is a good word, please suggest
>> if there is a better one.
> They are sometimes referred as 'xregs' in short. Also this is a local 
> function. Following the do_something() style, perhaps just 
> update_xregs_state() or update_perf_xregs()

Thanks, 'xregs' is a good word. But considering current naming convention
in arch/x86/events/core.c, I would add the "x86_pmu" prefix and name the
function to "x86_pmu_sample_xregs". In the Perf/PMU context, "sample" is a
more precise word than "update". 


