Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38452E229F;
	Wed,  9 Sep 2026 01:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788919188; cv=none; b=lUfj4k/mUCcO8hnQ482123fde+ZlxSPcXUbKBdKuDSSKkClqlcPiJa4e4to2kFXzhIBJsgtaH18zkNn5XGjWwfNIZ9K/ZBaozxB8GaiKSmTmLWX4NiT2LLj4HQ9cCYkIwwQ9y1+NvP7He1+83WWOiZDlwMZav3G7jlj6oHPXuJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788919188; c=relaxed/simple;
	bh=W9PtNPhk47k1jc5bdY2AOA4kbm34kk4RFI/75Z/CdNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W2VELzlJ05qrrMXfXMbazNMC/JLF52VzzQDWNZj8O0+Pxt+/F1irDVlYD3idmTX1naJE3LQ3ESdU1OZj9L6jQ/vvuul44+8TeY1Q10+JgE2cdh2VUMUt+QvOS4lmbWbJAVibjj50RQsz1uV4DrVpiu4oQkukkcvvP8xwtHxLS3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZQ5yUijL; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZQ5yUijL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788919187; x=1820455187;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W9PtNPhk47k1jc5bdY2AOA4kbm34kk4RFI/75Z/CdNs=;
  b=ZQ5yUijL1L5DeH5BXnbRtHCXtDmX4KlpMwb3jlVts0heYWq9gzq3kG1t
   Qi6u6A09csFK89RWpUoKFTU0QS1f10npuFS0APlKUR5xFzdC7KrtWhH8E
   VpG3rjTwh2EWhr/pKaiIgSTiBFa/qeyg7UbgD9PZ85MPpEE8C6mGOrNXD
   4ZU5+sWdlsd1wGJ3ilWx5pq6WnIpDo3gkinE3lTvwfzBmAZscfjX7LAXb
   y4PnNDTllMdCeApWiu+bq7RuO2FHmAUkLYCSfCbGdTkr3Bn3JKdJgvfRt
   //zV8NQeoF8Jg11QR127ExKMN7IiR7qYkUX3o+FyKZbF/wC2jJk30I7B+
   w==;
X-CSE-ConnectionGUID: rAjg3p5SQSSW3sUx0FG9nQ==
X-CSE-MsgGUID: jXIHUwcoTz2Cv49xAjFJkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="99927353"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="99927353"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 18:59:46 -0700
X-CSE-ConnectionGUID: pGfcIAxzQkO0EdJr298SpA==
X-CSE-MsgGUID: 1FnNQQKgQIGQJxuUFM7X8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="294682202"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 18:59:42 -0700
Message-ID: <a851b2e0-fcc5-452c-8e9b-3becece14f7a@linux.intel.com>
Date: Wed, 9 Sep 2026 09:59:39 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf/x86: Disable precise sampling for
 PERF_SAMPLE_STACK_USER
To: Ravi Bangoria <ravi.bangoria@amd.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Andi Kleen <ak@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
 Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, Gennady Kupava <gennady.kupava@gmail.com>
References: <20260908075102.540715-1-dapeng1.mi@linux.intel.com>
 <20260908075102.540715-2-dapeng1.mi@linux.intel.com>
 <20260908084906.GO4121339@noisy.programming.kicks-ass.net>
 <1691a05c-49a6-4b16-8bad-cb3c004ed07c@linux.intel.com>
 <20260908101914.GQ4121339@noisy.programming.kicks-ass.net>
 <aqAlddsFPYJvRhFr@tassilo>
 <CAP-5=fWbSNYpt8p3e+pqjY+xhqs8WrzsBfPaKB1NLBm88mH8Yg@mail.gmail.com>
 <ddd7d413-ed95-4c3f-9435-1a3e2c27cce2@linux.intel.com>
 <0c7c7902-e944-4c93-8188-6ca2f90b6795@amd.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <0c7c7902-e944-4c93-8188-6ca2f90b6795@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/9/2026 9:28 AM, Ravi Bangoria wrote:
>>> Having PERF_SAMPLE_IP be precise and the user registers from the
>>> interrupt I believe works for AMD IBS and ARM SPE, but for Intel PEBS
>>> there is the ability to use the PEBS register samples for other
>>> non-redundant registers. In the x86 driver could we disable PEBS
>>> sampling for these registers when doing user stack sampling, so that
>>> the sampled user registers match the stack sample? We can keep the
>>> PERF_SAMPLE_IP precise, and make all the registers precise when there
>>> is no stack sampling.
>> That sounds the best way to fix this issue by decoupling PERF_SAMPLE_IP
>> with PERF_REG_X86_IP. Then we can keep the precise SAMPLE_IP and the PMI
>> context user register snapshot simultaneously.
> With this, PERF_SAMPLE_IP and PERF_REG_X86_IP might be from different
> privileges. So, any perf code that depends on user_mode(regs) (e.g.
> perf_exclude_event(), _REGS_USER, _REGS_INTR, header->misc, etc.) also
> needs to be inspected/modified accordingly.

Yeah, this introduces the inconsistency between PERF_SAMPLE_IP and the
pt_regs, but I suppose it should be fine. I didn't look at the details yet,
but all places which call user_mode(regs) should not be impacted in theory.
As long as we ensure the PERF_SAMPLE_IP doesn't leak security information
like kernel address, I suppose it should be fine. 

Thanks.


>
> Thanks,
> Ravi
