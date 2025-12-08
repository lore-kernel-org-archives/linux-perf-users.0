Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E269279DAB;
	Mon,  8 Dec 2025 08:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765184040; cv=none; b=AWcV1cDf8RhZc4zjDvA6nT55TBsOLvCAkR7Mdqf/UUEVix9VC9DhGBIhLBXY7DYR7CmbhXe6F9WUxfAt30uDVOgEc9dEO6+7EFw4Ei96eQ26ZKJNb+PNvP1BUESky2DEZMAvVfG6YCxXOR5z2caZxDGHhy00LXLrrZGqXlBOAg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765184040; c=relaxed/simple;
	bh=6hA4lbLTOtXN7GpvM88ypDocoLkyNhzQXSFaQqOXqoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q+J8cNso/ulL3TVLufxaFjIfALP5j+TxJ1WuSxOTNP+XmM6vy4or848WogrpMQbPPTeUeFg/00O20TP4WqCXIai7Egq5u1Clzpk5y8/h9PXajazRfO9+U2mH9RHtfs8SS8gKy4YvYFNyY04jEENMdah6ojMYlPPZRJnnnICViUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AP157F0E; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AP157F0E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765184038; x=1796720038;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6hA4lbLTOtXN7GpvM88ypDocoLkyNhzQXSFaQqOXqoo=;
  b=AP157F0EJl6BrdclBvkeHqWpGt3CtWQzOpbKVhkdM3XzWjOihjLy9Pc2
   79VDeNXc/jiwbYI44Cw/u3B5SR7GoLggqWhBdjqAXSefNqv+j9mxbgrj2
   TQRGao4nY71PQ7xWLVZV3eKjGXvZseznx7yyNXtLlr4bLLuTnUL5RATkw
   YZuoOJydR5j3RS14yVm4SSPEEZzXrbTxSStJVYI2VRq/sOdZpTOZiZNBh
   CKrwvGo5iZ0yUrFsGjwdyv60+KeiTbGU5l9oIOOjOijHGJAE3KChpQAKQ
   KMz+r0ISUXr8WT0h6w5GDc8itR1f4CqfcXbP6SSvhq+1UX7MCPt/CR3pP
   w==;
X-CSE-ConnectionGUID: 7zksVHU8S7uHECQXfd4d1g==
X-CSE-MsgGUID: Q2m627JKTSW9wuyyUKgfuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="54663155"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="54663155"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 00:53:57 -0800
X-CSE-ConnectionGUID: nbYI9ZklSbeqUNeKgq7vNg==
X-CSE-MsgGUID: QcVo8SGnSbadMBZeZHxSJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="226895438"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.12]) ([10.124.240.12])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 00:53:51 -0800
Message-ID: <591264e1-0371-48ee-8509-554a05836189@linux.intel.com>
Date: Mon, 8 Dec 2025 16:53:47 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 16/19] perf/x86: Activate back-to-back NMI detection
 for arch-PEBS induced NMIs
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
 Xudong Hao <xudong.hao@intel.com>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <20251203065500.2597594-17-dapeng1.mi@linux.intel.com>
 <20251205123940.GY2528459@noisy.programming.kicks-ass.net>
 <5e808ff0-0107-4085-a1ab-ea1cfed4e0ca@linux.intel.com>
 <20251208085020.GA3707891@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251208085020.GA3707891@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 12/8/2025 4:50 PM, Peter Zijlstra wrote:
> On Mon, Dec 08, 2025 at 02:46:44PM +0800, Mi, Dapeng wrote:
>
>> This change only take effects for arch-PEBS. For the legacy PEBS, the
>> "handled" would still be added 1 unconditionally even the *_drain_pebs()
>> helpers always return 0.
>>
>>     /*
>>      * PEBS overflow sets bit 62 in the global status register
>>      */
>>     if (__test_and_clear_bit(GLOBAL_STATUS_BUFFER_OVF_BIT, (unsigned long
>> *)&status)) {
>>         u64 pebs_enabled = cpuc->pebs_enabled;
>>
>>         handled++;
>>         x86_pmu_handle_guest_pebs(regs, &data);
>>         static_call(x86_pmu_drain_pebs)(regs, &data);
>>
> Oh gawd. Please don't do that. If you change the calling convention of
> that function, please have it be used consistently.

Sure. I would do same change for legacy PEBS and make the behavior consistent. 


>
