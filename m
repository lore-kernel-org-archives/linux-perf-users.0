Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F7217C21C;
	Fri, 26 Jul 2024 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722009669; cv=none; b=sHD0nSwFsCElHY0VLZc3U4ltH2nrwQm463A4bpldnNhwvbq9houI6Hk4eAUXZ5cWQQBxnVkkbpTX/lujAFMa8fE0qO+W9MtRyWbTm1o5dM/rZvTf8rugGciVcP/rPY7BVlTybHPh39A4sbIC7AWVKjVOfgJgnuF3q90sjN09WtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722009669; c=relaxed/simple;
	bh=gLb23Bh8XMl/n/xLXzM+SFvWGrvJJ0r90hJ2q9/OMAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pTr04Gqe2pbi+yK0gLHUhWNDA0VDRj8bogcjP9pXAhdgP/5mVri9JZTebX9+9QFwYdkh5tvLV0yZDTcnjgxHTLIzLzoORTW3qeosuTnHUkbVrCf8beEGFv1NzaISlShD/l6TFSBbelWYvRkng7P/9BRP1nOLMOjxs2i3u41jtqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SztYG//F; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SztYG//F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722009668; x=1753545668;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gLb23Bh8XMl/n/xLXzM+SFvWGrvJJ0r90hJ2q9/OMAk=;
  b=SztYG//FzlwdPqZeciYhTDThWXJuz1KxJ0wW6c97qnzgpaaN0uqn9TW4
   GAK2gDgR7/1JRKXRb2OUOEz7uVx5im0jAHc+6IVXUyLpr8NBV/x77mbUz
   vqOm5gEDbyaojfinA9HiiGyzCbBPgTo4ZVkfbHWFQZw1JgU+qBsODz6Us
   NAtKpmkA5F+d8EIKtUtcqi+odSm6lmLE3YI1OvysMwYPXZ4PvSMWja8t6
   FAtn7yr9WW+vMdMjY7Uw/9xrPVse6nrh+qE/q/2+xpgjRO18K7y/F/pzX
   3ZkgZy0MyYtHkARCqY0Wd14ppD8JC2WT00vaLOLcXqaU+4maJMDLhG7rW
   Q==;
X-CSE-ConnectionGUID: Kxw6l7XFTwuMvXVTxROM9Q==
X-CSE-MsgGUID: kR3s3ZpaTFGFA9bf2RZAfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11145"; a="12731744"
X-IronPort-AV: E=Sophos;i="6.09,239,1716274800"; 
   d="scan'208";a="12731744"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 09:01:07 -0700
X-CSE-ConnectionGUID: 3v34ztMQS5e9V/+usAAA4w==
X-CSE-MsgGUID: Q4D1SZ7vTcewG/5kTgQ6cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,239,1716274800"; 
   d="scan'208";a="53917760"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.49.253])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 09:01:01 -0700
Message-ID: <137068c0-442b-4aba-8950-67828a15cda2@intel.com>
Date: Fri, 26 Jul 2024 19:00:55 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 02/13] perf/core: Add aux_pause, aux_resume,
 aux_start_paused
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Will Deacon
 <will@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20240715160712.127117-1-adrian.hunter@intel.com>
 <20240715160712.127117-3-adrian.hunter@intel.com>
 <20240718093846.GJ26750@noisy.programming.kicks-ass.net>
 <14cd68b2-eeee-42e3-87a6-c12d3814bd51@intel.com>
 <20240718115126.GK26750@noisy.programming.kicks-ass.net>
 <20240718125849.GI28838@noisy.programming.kicks-ass.net>
 <ef63885b-f762-4398-beff-c695b24304e6@intel.com> <ZqO1gBIYnLiDpQWv@x1>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ZqO1gBIYnLiDpQWv@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/07/24 17:41, Arnaldo Carvalho de Melo wrote:
> On Thu, Jul 18, 2024 at 06:06:16PM +0300, Adrian Hunter wrote:
>> On 18/07/24 15:58, Peter Zijlstra wrote:
>>> On Thu, Jul 18, 2024 at 01:51:26PM +0200, Peter Zijlstra wrote:
>>>
>>>> OK, let me do that and make a few more edits and see if I can stare at
>>>> that next patch some.
>>>
>>> I pushed out a stack of patches into queue.git perf/core
>>> Could you please double check I didn't wreck anything?
>>
>> Looks fine, and seems to work OK in a brief test.
>>
>> Thank you! :-)
> 
> So should I go ahead and pick the tooling patches since the kernel bits
> are merged?

Not exactly merged.  Probably should wait until it is in tip at least.

