Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nlthjmm8"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDFFB4;
	Mon, 11 Dec 2023 10:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702320300; x=1733856300;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rW8O1JlbKxw6zxat6uEpLm1yP0lFLD0RUbyyif5FFM4=;
  b=Nlthjmm81K1SbYih7o9d6UZ9PGBLUefcZ7wmaZ+yN9OuN4QI9Lt7zupG
   8gPnVAyuord8GO9qBtrpNIun3O+sHhWM6feH6Og/onPlpRxqlWX+N4NpA
   9G1tMCWfWoKrwWUlFd46/2wHWcPV92C6r9dS3Eh0xaH1Id9gAJ1gVYwXo
   YXMdCNYrehNowXLMtahT8lhA0KMYjiiiFFVXgUqyRX1GqzEsCB0KSDIdn
   2OWVwxB/yHxCptbA2dIapTlNxyKLqDjlJGy801StE4exuSDW3b5fn3Gk5
   oyKt9aaXldIM2vzImz1lvLKJY3bA6QZRDqijvFApcxagkLMha/4lRTm/g
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="480890620"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="480890620"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 10:44:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="766486035"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="766486035"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 10:44:59 -0800
Received: from [10.212.109.181] (kliang2-mobl1.ccr.corp.intel.com [10.212.109.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 1C8F5580DA9;
	Mon, 11 Dec 2023 10:44:55 -0800 (PST)
Message-ID: <2865c1b4-a003-44df-a734-1e1c90bfa14d@linux.intel.com>
Date: Mon, 11 Dec 2023 13:44:54 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 4/5] perf mem: Clean up perf_mem_event__supported()
Content-Language: en-US
To: Leo Yan <leo.yan@linaro.org>
Cc: acme@kernel.org, irogers@google.com, peterz@infradead.org,
 mingo@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
 adrian.hunter@intel.com, john.g.garry@oracle.com, will@kernel.org,
 james.clark@arm.com, mike.leach@linaro.org, yuhaixin.yhx@linux.alibaba.com,
 renyu.zj@linux.alibaba.com, tmricht@linux.ibm.com, ravi.bangoria@amd.com,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20231207192338.400336-1-kan.liang@linux.intel.com>
 <20231207192338.400336-5-kan.liang@linux.intel.com>
 <20231209061723.GC2116834@leoy-yangtze.lan>
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20231209061723.GC2116834@leoy-yangtze.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2023-12-09 1:17 a.m., Leo Yan wrote:
> On Thu, Dec 07, 2023 at 11:23:37AM -0800, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> For some ARCHs, e.g., ARM and AMD, to get the availability of the
>> mem-events, perf checks the existence of a specific PMU. For the other
>> ARCHs, e.g., Intel and Power, perf has to check the existence of some
>> specific events.
>>
>> The current perf only iterates the mem-events-supported PMUs. It's not
>> required to check the existence of a specific PMU anymore.
> 
> With this change, both Arm and AMD archs have no chance to detect if the
> hardware (or the device driver) is supported and the tool will always
> take the memory events are exited on the system, right?

Currently, the Arm and AMD only check the specific PMU. If the PMU is
detected, the memory events are supported. The patch set doesn't change
it. It just moves the check to perf_pmu__arch_init(). When the specific
PMU is initialized, the mem_events is assigned. You don't need to do
runtime sysfs check. It should be an improvement for ARM and AMD.

Thanks,
Kan

> 
> Thanks,
> Leo
> 
