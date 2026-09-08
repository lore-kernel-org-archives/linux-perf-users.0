Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532904ACC9C;
	Tue,  8 Sep 2026 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857800; cv=none; b=t/ZVZeeNLiPURFzNNUsM8VSInlKqvn1+msuJPihO8EKEB46RNCYyma9fV4Kg9Ro8cSeP3TlLw56Tnv7vAGXlCIvwpFLnKwim4tkro8UWy1gvfTXwzzZTgwNgd52gdqh+FEGk5oWEAaEEpXy8iMFzpzzxSzEc+9OlQwCoAj5cLLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857800; c=relaxed/simple;
	bh=Ahro2Srr+Bq9W6hD+AEH/Tw4GZscKYZxe91BI8YjBF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KHMk2K9JHF8/T+v6KawbmCnvR/pOcCgnVsxHuUQ544ix83Rz1qDQCbxLmSgQyShFLlfp8GKlmaxPeni6rfYxBSNSSyvpTqSNEV7/PxOHUjzuGQ/KGVjsy72zTh3ugTg1xPlxMCnftnsiC+m6M+gX7sEFnbhSbMrN9isanIYwCJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GPaSlxFT; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GPaSlxFT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788857795; x=1820393795;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ahro2Srr+Bq9W6hD+AEH/Tw4GZscKYZxe91BI8YjBF4=;
  b=GPaSlxFTwM8iHg+FleBy6ncQUPdlRyJMdyJqwi7ui/lHBf3/zxRZAp92
   a78RyI1BCciKG4HDXVOA55mmfDVsVkFBJMJKuNqimRb/G3cBiEnOusZKC
   znVEZJ844FKwqgGx8ddW5N93F7He6GQCVEUCRCVRDXqaNFT/MN90xrXGF
   LO2fqXZkCkSqdHzlt32EczABAKzRp+J+IP7MyWKbexFvChWjuFng6AH9r
   NJxdtDIUiq059/Cn4gYioRfrZfC0FxBHPPGxDlPi0jDhFtNYI1/tuO2W7
   Nm+oECR0Ao4rTpGIqULeoUI4YVibpVLkf33bMyf/pdo8d0KAj9b3bW3mi
   w==;
X-CSE-ConnectionGUID: njSgW8llQdSVlND7d4H7dA==
X-CSE-MsgGUID: fXMmZBihQSOpDveRvGQKuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89010480"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="89010480"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 01:56:29 -0700
X-CSE-ConnectionGUID: YYYg/G2oSzypNapTAlU4bw==
X-CSE-MsgGUID: BazvbqrfRQC/IF6oAMkTGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="264735949"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 01:56:24 -0700
Message-ID: <1691a05c-49a6-4b16-8bad-cb3c004ed07c@linux.intel.com>
Date: Tue, 8 Sep 2026 16:56:22 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf/x86: Disable precise sampling for
 PERF_SAMPLE_STACK_USER
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Gennady Kupava <gennady.kupava@gmail.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20260908075102.540715-1-dapeng1.mi@linux.intel.com>
 <20260908075102.540715-2-dapeng1.mi@linux.intel.com>
 <20260908084906.GO4121339@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260908084906.GO4121339@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 9/8/2026 4:49 PM, Peter Zijlstra wrote:
> On Tue, Sep 08, 2026 at 03:51:02PM +0800, Dapeng Mi wrote:
>> PERF_SAMPLE_STACK_USER needs to return the user stack and user registers
>> to user space when the PMI exits. Since the skid from the PEBS/IBS sample
>> and PMI delivery, the PEBS/IBS register snapshot (especially IP/SP/BP)
>> can diverge from the user stack at PMI return. That mismatch breaks DWARF
>> unwinding.
>>
>> Precise sampling provides no benefit in this case, so disable PEBS/IBS
>> precise sampling and allow only PMI-based sampling when
>> PERF_SAMPLE_STACK_USER is requested.
>>
>> Reported-by: Gennady Kupava <gennady.kupava@gmail.com>
>> Closes: https://lore.kernel.org/all/CAPu-DQqF0aF6=GS8Z6KKWeeX_V5LiXeKU_rJQZC+uGg8zuTPNw@mail.gmail.com/
>> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
>> Fixes: c5ebcedb566e ("perf: Add ability to attach user stack dump to sample")
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> This breaks long standing existing behaviour.

Yeah, but it seems there is no better way to fix this issue.

An alternative way to fix this issue is still to return the PMI context register state rather than the PEBS precise registers for user stack sampling, but this actually falls back the imprecise PMI-based sampling. In my opinion, it could even make the thing worse. User requires to get precise samplings, but perf silently returns imprecise records, this would mislead user. 



