Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504C0136A;
	Tue, 17 Jun 2025 19:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750189629; cv=none; b=MSEYebBorZuC+VHG+Aw7xhH6Iqf1+yyfNXPYBtBmssP7YohKt5lfNguKH/wrjsn6KY3wMwKpIAsIAo2ubpzaIcKjvEgOAQVV9JsWF72nh1ZRox8zFi7Aolu8+34ufB4NGLlWk9jQjlFUNokV4KXhTtNvAM6qcZEWChxbVbqL5/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750189629; c=relaxed/simple;
	bh=6isCiZoF+g7lLxHT5Sbj99Y+eoDDrTIFdT8d+wyJydc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AilmPoq7F3APxdzXSRiA5HuB6E7YCeSOXN1E6HfZCYPbr6BfP9GhH8/Jf1dlEyaA4u9zV+mi12gMuTzJLb5KN5elrV83b5jQk/CzoLl0kZxV3075X085/HyTMcUWxSUwVUZulxauTPKFBMuRffBEt9sIZ2zvC43GMjIeA+U/8F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DWZlU6pq; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DWZlU6pq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750189627; x=1781725627;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6isCiZoF+g7lLxHT5Sbj99Y+eoDDrTIFdT8d+wyJydc=;
  b=DWZlU6pqJOCn+WdBKl8LldTJxIumaWEUQo/weevnY4miNNEy9m7b6XyP
   GKgl7JfRacR2hD5rBmmWu7zBGu6MahMoPN6Eu8W6t9oMCuSfibB5HTT4z
   YNTUKjx4H4EFZd320cy+x4/E/y77BiFZZOdDFWm0ZKxMt4lJJrnqaJ/NQ
   Y0isaWIozJJV3sKE3z5aMKPSXraGd9jJyQKWVZpxHqVdJNLyDsz4ercZS
   BRYVdjHaJGkZ1kFn8dbXx4NBHKPFRZFGnqgI10YAxDMx50B+hcAvvzaMF
   3Ba7OLL59OZhnbIBqYWpGFfsn8UlL544emi3JX/jzrMX5FlaxMqtUJJwL
   A==;
X-CSE-ConnectionGUID: OR+gRxrmRbu6ZwIh2rS5lg==
X-CSE-MsgGUID: D5I1tYekRyKtW55wmM2phg==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="63421116"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="63421116"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 12:47:06 -0700
X-CSE-ConnectionGUID: mGOyGjynQ4y19Ly0PQNJqQ==
X-CSE-MsgGUID: cxo73W0QQiqcTvXkmGkTng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="172161665"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 12:47:05 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 7360120B5736;
	Tue, 17 Jun 2025 12:47:04 -0700 (PDT)
Message-ID: <574b8701-9676-4aba-a85b-724c979b2efa@linux.intel.com>
Date: Tue, 17 Jun 2025 15:47:03 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [perf] unchecked MSR access error: WRMSR to 0x3f1
To: Vince Weaver <vincent.weaver@maine.edu>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>
References: <14d3167e-4dad-f68e-822f-21cd86eab873@maine.edu>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <14d3167e-4dad-f68e-822f-21cd86eab873@maine.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-06-17 11:39 a.m., Vince Weaver wrote:
> Hello
> 
> When running the perf_fuzzzer on a raptor-lake machine I get a
> 	unchecked MSR access error: WRMSR to 0x3f1
> error (see below).
> 
> A similar message happened before back in 2021 and was fixed in
> commit 2dc0572f2cef87425147658698dce2600b799bd3 so not sure if this is the 
> same problem or something new.

The commit 2dc0572f2cef was triggered by the fake event VLBR_EVENT.
But this error should be triggered by the Topdown perf metrics event,
INTEL_TD_METRIC_RETIRING, which uses the idx 48 internally.

We never support perf metrics events in sampling mode. The PEBS cannot
be enabled in counting mode. So it's weird the cpuc->pebs_enabled has
the idx 48 set.

The recent change I did for the PEBS is commit e02e9b0374c3
"perf/x86/intel: Support PEBS counters snapshotting". But it should not
impact the above.

Could you please help on the below questions?
- It only happens on the p-core, right?
- Which kernel base do you use? Is it 6.16-rc2?
- Can this be easily reproduced?
  Is it possible to bisect the error commit? (Maybe start from the
commit e02e9b0374c3?)

Thanks,
Kan>
> Vince Weaver
> vincent.weaver@maine.edu
> 
> [12646.001692] unchecked MSR access error: WRMSR to 0x3f1 (tried to write 0x0001000000000001) at rIP: 0xffffffffa98932af (native_write_msr+0xf/0x20)
> [12646.001698] Call Trace:
> [12646.001700]  <TASK>
> [12646.001700]  intel_pmu_pebs_enable_all+0x2c/0x40
> [12646.001703]  intel_pmu_enable_all+0xe/0x20
> [12646.001705]  ctx_resched+0x227/0x280
> [12646.001708]  event_function+0x8f/0xd0
> [12646.001710]  ? __pfx___perf_event_enable+0x10/0x10
> [12646.001711]  remote_function+0x42/0x50
> [12646.001713]  ? __pfx_remote_function+0x10/0x10
> [12646.001714]  generic_exec_single+0x6d/0x130
> [12646.001715]  smp_call_function_single+0xee/0x140
> [12646.001716]  ? __pfx_remote_function+0x10/0x10
> [12646.001717]  event_function_call+0x9f/0x1c0
> [12646.001718]  ? __pfx___perf_event_enable+0x10/0x10
> [12646.001720]  ? __pfx_event_function+0x10/0x10
> [12646.001721]  perf_event_task_enable+0x7b/0x100
> [12646.001723]  __do_sys_prctl+0x56f/0xca0
> [12646.001725]  do_syscall_64+0x84/0x2f0
> [12646.001727]  ? exit_to_user_mode_loop+0xcd/0x120
> [12646.001729]  ? do_syscall_64+0x1ef/0x2f0
> [12646.001730]  ? try_to_wake_up+0x7e/0x640
> [12646.001732]  ? complete_signal+0x2e8/0x350
> [12646.001734]  ? __send_signal_locked+0x2e3/0x450
> [12646.001735]  ? send_signal_locked+0xb6/0x120
> [12646.001736]  ? do_send_sig_info+0x6e/0xc0
> [12646.001737]  ? kill_pid_info_type+0xa6/0xc0
> [12646.001738]  ? kill_something_info+0x167/0x1a0
> [12646.001739]  ? syscall_exit_work+0x132/0x140
> [12646.001740]  ? do_syscall_64+0xbc/0x2f0
> [12646.001741]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [12646.001743] RIP: 0033:0x7efe86afd40d
> [12646.001744] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 18 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 9d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 1b 48 8b 54 24 18 64 48 2b 14 25 28 00 00 00
> [12646.001745] RSP: 002b:00007ffcd6444cf0 EFLAGS: 00000246 ORIG_RAX: 000000000000009d
> [12646.001746] RAX: ffffffffffffffda RBX: 000000000000000e RCX: 00007efe86afd40d
> [12646.001747] RDX: 0000000000000001 RSI: 00007ffcd6444d24 RDI: 0000000000000020
> [12646.001747] RBP: 00007ffcd6444d60 R08: 00007efe86bc625c R09: 00007efe86bc6260
> [12646.001748] R10: 00007efe86bc6250 R11: 0000000000000246 R12: 0000000000000000
> [12646.001748] R13: 00007ffcd64471b8 R14: 0000559eb2a2edd8 R15: 00007efe86c30020
> [12646.001749]  </TASK>
> 

