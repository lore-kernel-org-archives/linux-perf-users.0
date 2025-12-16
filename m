Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E68B2750E6;
	Tue, 16 Dec 2025 06:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765868397; cv=none; b=SaCdpZUM5hVDiGkkUBhaujVhCp891uHZYTvibZQ/34WJwMLHPaBA7SCvnKH7VK9O/ZYZ6CRlCX2LSHhwI0mw17s6SavqX2sj/hosrstgtR2Qs/IphVscd5e5LfbZyZ49xDU+vXyuakdks5SIeLacpW911BwungEffVGILH5/EP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765868397; c=relaxed/simple;
	bh=wjW212gumh3kw5PzOaX7J4zfFsANyVYVsOLFjjyO3oA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dlrcxLJ3AknM/H0h4w195f3usFOz/tVvEZSm1Tj1lolSshTVNv6l6Jdv89njZAfjN2bdPcL8bLc+nfAygtedoS5eEDRRCOhAISDcMLWUAEY2/dU5Rt7F78Z+u3AbzBxeAdshnUShu2HmIiPLBbqT8IyemuydayEj+MC88zKjcOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=esyXfgyf; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="esyXfgyf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765868395; x=1797404395;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wjW212gumh3kw5PzOaX7J4zfFsANyVYVsOLFjjyO3oA=;
  b=esyXfgyfHIk2jpdlrJ+hg7Hp3dR59qDzA5hviD90XhW/P/wHHi7pRm9M
   Zoy7uponjFDZ86XKl+JaHMyqw1GuZl5y4GvbeLUR2NAK592zh+wS+6/11
   r7UAi5IPHkncj/jjlccUvmD2o+Avlf5LJP1RlgaWJZEd2X6mXoUSjFqpf
   8hoBQ/HDL4UD/h7tP7E79kmlTuv5hH7TbBw4RsQn5LRUjfZKuD6CaFE59
   KEJrsSzSxkxFih1ziikWiHFFRKtK+41JC/JtXzfnhCiTWwgf9JL9ksurb
   nqpfcwZfGSV3ClprWPPmjF/cU8O9j9Hyxdu0mR+Xz/6h5k98Sjwsaa5Xt
   w==;
X-CSE-ConnectionGUID: Aj9EhpvvSxS2ksOOrc1pkg==
X-CSE-MsgGUID: vFS+NACeR/iL7Qm3x19iMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="67814179"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="67814179"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 22:59:54 -0800
X-CSE-ConnectionGUID: 6d5jH5UXS9GvwjL1QNA58w==
X-CSE-MsgGUID: 99wM7a+3RpWhvhhOwVnMTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="203043615"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 22:59:49 -0800
Message-ID: <e796ca6f-e031-4d9f-876e-e297f9623715@linux.intel.com>
Date: Tue, 16 Dec 2025 14:59:46 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 00/19] Support SIMD/eGPRs/SSP registers sampling for
 perf
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <c2892e7a-65c4-4744-a611-6fc3c1d37cd3@amd.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <c2892e7a-65c4-4744-a611-6fc3c1d37cd3@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 12/16/2025 12:42 PM, Ravi Bangoria wrote:
> Hi Dapeng,
>
>> While the hardware solution remains preferable due to its lower
>> overhead and higher accuracy, this software approach provides a
>> viable alternative.
> Lower accuracy in the software approach is due to the delay in an NMI
> delivery which will make the SIMD data misaligned a bit? Something like:
>
>    insn1
>    insn2  -> Overflow. RIP, GPRs captured by PEBS and NMI triggered
>    insn3
>    insn4
>    insn5  -> NMI delivered here, so SIMD regs are captured here?
>    insn6
>
> Am I interpreting it correctly?

Yes, there is always a delay with software-based (specifically PMI-based)
sampling. Hardware-based sampling like PEBS is preferable when available.


>
> Thanks,
> Ravi
