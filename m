Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7A71DF970;
	Wed, 11 Jun 2025 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749668010; cv=none; b=A8Ts9zllufVgEAFPgxE3mImhCnZTzRLnyGAStQ7FNZfFa/QjuSzMtZex10FoAj683lQPHEO+cBJ3YWHfzOFOlW60EdpnHdJc1p8zqki2ooUuaXa3sVD9av8+/N09yP4bIPvLCHhA/0k753Cs+qRxqYOa39mIZN9EGngvH41clCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749668010; c=relaxed/simple;
	bh=K7MhSkF7SxF7ufllQxHFuRdtuvoj4RRa+0bILj4Fgf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j5MKqOvzPGRTxsU1asQI1nec05tsUxfZtsUpbdzUAYv1a/rnbp8Bk3JRj+ivWML19Ww8GY+IZGh2y18NCRnPO/ujRouOxEqxNoQa7aoMyMKy5WsHX6GBvQMbhw45MBXuR/JK+x78G2oKiCLl6cVda8ADBpvDrkR96nc+vc3gZk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sa+BkxyI; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sa+BkxyI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749668009; x=1781204009;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K7MhSkF7SxF7ufllQxHFuRdtuvoj4RRa+0bILj4Fgf8=;
  b=Sa+BkxyIvQkkGCI+pgKMS9PvZONrPcaDS8blFLHGICa7XgORdRGrFVcK
   4keDZZualHmV56SIuUQD6DpIXr9rrVrvfhcj5sYIL3H6qcA9C/6nlBD6B
   9E3MyCXMQW/p26zajQai9vPSo6oB7rxmBRZo22tOGRpA4xa9kF0FURKqv
   QOLRMJt2knj4NT8r3eFBFu9LxY1kgBWQKXU2CoIwY0wxJh66SdfmZlLcQ
   IB8RsoZJINpYgK6tcSMCjSGDSWJnlyvnjlH7w2Pe6qskaYnSR26mgJWKg
   CQ2RJ2rz1u/33HzWHCBE+SFGgmvqe1Xg3RVDfgZQ/hsaaKyuXRehlHUe7
   w==;
X-CSE-ConnectionGUID: B8R67JbYS+yruamsA6hhnA==
X-CSE-MsgGUID: elz9/HaJSU2lP4g7cH/RRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51922699"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="51922699"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 11:53:26 -0700
X-CSE-ConnectionGUID: PYxOXzNfTgqTZiUkuPjeCQ==
X-CSE-MsgGUID: hRtrYbu6RxGkWIfQ0FGYLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="147159241"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 11:53:26 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 9A45C20B5736;
	Wed, 11 Jun 2025 11:53:24 -0700 (PDT)
Message-ID: <d8c64a21-ed4e-4d37-8d4b-9d3a9857b7fd@linux.intel.com>
Date: Wed, 11 Jun 2025 14:53:23 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [perf] crashing bug in icl_update_topdown_event
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>
References: <352f0709-f026-cd45-e60c-60dfd97f73f3@maine.edu>
 <080706b6-ed21-540d-dfae-ae27d130d796@maine.edu>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <080706b6-ed21-540d-dfae-ae27d130d796@maine.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-06-11 10:57 a.m., Vince Weaver wrote:
> On Wed, 11 Jun 2025, Vince Weaver wrote:
> 
>> Oops: general protection fault, maybe for address 0xffff89aeceab400: 0000
>> CPU: 23 UID: 0 PID: 0 Comm: swapper/23
>> Tainted: [W]=WARN
>> Hardware name: Dell Inc. Precision 9660/0VJ762
>> RIP: 0010:native_read_pmc+0x7/0x40
>> Code: cc e8 8d a9 01 00 48 89 03 5b cd cc cc cc cc 0f 1f ...
>> RSP: 000:fffb03100273de8 EFLAGS: 00010046
> 
> one additional note that's probably relevant, this is on a hybrid CPU 
> machine, so CPUs 16-23 are atom cores that don't support topdown.
> 
> So the crash is probably because for whatever reason the kernel is trying 
> to read topdown events on an unsupported core and triggering a GPF.
> 

It seems an regression from the f9bdf1f95339 ("perf/x86/intel: Avoid
disable PMU if !cpuc->enabled in sample read").
The commit merged the intel_pmu_auto_reload_read() and
intel_pmu_read_topdown_event(). It's possible that a PEBS event 0x0400
runs on a ATOM CPU. So the PERF_X86_EVENT_AUTO_RELOAD is set for the
event. The is_topdown_event() also returns true.

Does the below patch help?
It checks the PERF_X86_EVENT_TOPDOWN flag as well before invoking the
topdown functions.

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c60b6f199f51..67f80a683234 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2826,7 +2826,8 @@ static void intel_pmu_read_event(struct perf_event
*event)
 		 * If the PEBS counters snapshotting is enabled,
 		 * the topdown event is available in PEBS records.
 		 */
-		if (is_topdown_event(event) && !is_pebs_counter_event_group(event))
+		if (is_topdown_count(event) && is_topdown_event(event) &&
+		    !is_pebs_counter_event_group(event))
 			static_call(intel_pmu_update_topdown_event)(event, NULL);
 		else
 			intel_pmu_drain_pebs_buffer();


Thanks,
Kan

