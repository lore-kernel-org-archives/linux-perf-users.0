Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A0F3B8D76;
	Mon,  8 Dec 2025 06:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765174303; cv=none; b=hr/Ca4Tey02YPVk5sjeFaWVpTGrYpkpufYl7DdoC3JZWME2l8Soa0gay7a8MVe/KTnEVuhgfIn312aBWr2IqzAgavRuNmchI6fOEuI3sE8QD5EpVRv5bkeRk7rHUJ5tHKW4EIp4q3Kmp6coM1gGuAmhofae+sQBISzwA4tfJMvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765174303; c=relaxed/simple;
	bh=NNHbvxDhzJPO4gvJGYDIPmvAMuoO2GuM4NiUhDMlwI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mJMVU8jFHv8hSReAIxsiOA4Qt8V1IVA9tclMvKSWYN2kbL1Cyn3JX4J/WNvY8XME+PifBZnr9LWU+WlsWIud5MyEj26vIBESTZAJ3GHbTnTA9v9mhjFnGpv0yXwOnTaWjBnhmBYeFgi+2bCeAZNhTD0AuMTBw2buUx7cizdz/ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lf1aOCNe; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lf1aOCNe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765174301; x=1796710301;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NNHbvxDhzJPO4gvJGYDIPmvAMuoO2GuM4NiUhDMlwI8=;
  b=Lf1aOCNerjTtFJA6EAzJdYbzVZjf7G0LnlFdcbaCSME5z5fTeZsA9I7p
   wowgVZwZGbbJESyl66n4RBO2Ixf+6cEOsLgcrnwI5zODqXeIbcaxcsV/Q
   PUhTyAM0LqcSImoc97mlwodJsCY4D6/eDpG13iwNpkEYMuOq4n63FK7Zb
   KjboPdrPVLZ4WMCMmanbd6CzMmcWuMAz52Dg5qHy8UcaCJLkeCKr1Zc4n
   SvKws+VpQnuJ7jYwdTsc6VN4bg/3FViLf/eukUlzgYKvVDUi2xYxVzxVU
   VFLFTr6YkMVyRCu+b9+n1UR9lBQSgy9odnUfeTtyodtk1IQslhbdWzXJd
   Q==;
X-CSE-ConnectionGUID: uKuSUSAsQeeODb0fBT2xBA==
X-CSE-MsgGUID: ucZ1u9srQ929Su2+mLallw==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="66833865"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="66833865"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 22:11:41 -0800
X-CSE-ConnectionGUID: Ebq+UalAQsCkgCDK0Gromw==
X-CSE-MsgGUID: NrdjRIWBSCKI08ibgVB6UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="196616462"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.12]) ([10.124.240.12])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 22:11:35 -0800
Message-ID: <a7f46b5f-de62-4c4d-8c98-a8cf8d88ff4d@linux.intel.com>
Date: Mon, 8 Dec 2025 14:11:33 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 12/19] perf/x86: Enable eGPRs sampling using
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
 <20251203065500.2597594-13-dapeng1.mi@linux.intel.com>
 <20251205121651.GW2528459@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251205121651.GW2528459@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 12/5/2025 8:16 PM, Peter Zijlstra wrote:
> On Wed, Dec 03, 2025 at 02:54:53PM +0800, Dapeng Mi wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> This patch enables sampling of APX eGPRs (R16 ~ R31) via the
>> sample_regs_* fields.
>>
>> To sample eGPRs, the sample_simd_regs_enabled field must be set. This
>> allows the spare space (reclaimed from the original XMM space) in the
>> sample_regs_* fields to be used for representing eGPRs.
>>
>> The perf_reg_value() function needs to check if the
>> PERF_SAMPLE_REGS_ABI_SIMD flag is set first, and then determine whether
>> to output eGPRs or legacy XMM registers to userspace.
>>
>> The perf_reg_validate() function is enhanced to validate the eGPRs bitmap
>> by adding a new argument, "simd_enabled".
>>
>> Currently, eGPRs sampling is only supported on the x86_64 architecture, as
>> APX is only available on x86_64 platforms.
>>
>> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/arm/kernel/perf_regs.c           |  2 +-
>>  arch/arm64/kernel/perf_regs.c         |  2 +-
>>  arch/csky/kernel/perf_regs.c          |  2 +-
>>  arch/loongarch/kernel/perf_regs.c     |  2 +-
>>  arch/mips/kernel/perf_regs.c          |  2 +-
>>  arch/parisc/kernel/perf_regs.c        |  2 +-
>>  arch/powerpc/perf/perf_regs.c         |  2 +-
>>  arch/riscv/kernel/perf_regs.c         |  2 +-
>>  arch/s390/kernel/perf_regs.c          |  2 +-
> Perhaps split out the part where you modify the arch function interface?

Sure.


>
