Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9851FCFF0;
	Wed, 16 Apr 2025 00:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744765201; cv=none; b=suFb668IOhLnjtTP317FPF1bUSDTPGZvcFHs0UVCcC+N/2KU9LT8+2EmZqiUQXXq+3fS7WgXYWmZBDKvP/JUlib+snMIBuf6ls/Xz5o5pq6mPScbLsRL2QgAkNsn3rYDT3r9EywP6//oiVGyb9V4L2Vy+iDRNEEXDRGq+Zh0g50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744765201; c=relaxed/simple;
	bh=WponkBbzhkgFsGM8q1hgh/COWKn40sENxqwpBm+JBr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f+F/+J4JySJtGCqKbJJCJtsLwgkiJHtwjdFE4DgfVOZ7iwxXwQeSZNFMtbjBPvz/zzQyAKv26Ei6tE1ZZvN2fL9+fEcVKI0SN+MNVoSWMHxKAvUMElecdveXvXQtl8fZtCy2YL3X5DObw0QBfh/I0004gZHySyk94EATbZTqp60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DXFmgOcb; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DXFmgOcb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744765199; x=1776301199;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WponkBbzhkgFsGM8q1hgh/COWKn40sENxqwpBm+JBr4=;
  b=DXFmgOcb5lh48+ReIzZyFDYpE/+t15+wUfzAp4WxCRl3K8o8RHaEvY9c
   9GaxAEIrv8bb/Rzk+1RRIvHfgPlftmEaM8sRl1dt/mznqo/Mv9QPTjclm
   iXHRJJEP0wS8DJ10Rgl3QPvvCbu8adLuUBzQSL1szcA/vAN0tDEdha1kR
   y7guQ6JbeuZZ7txjp5IuTp3Vt9tfa7aDUNX1rDxfDlEPZ3ENoPbD/plrp
   GRuKNXSS2m4nsZLzxLXU27YniiDRfKbj2IyMwOLK7Z1rr4GsYouLBVkAF
   87ZbgOICUplKj14VpqV+rKgLKsNGyWukdVCxAgPXioUM6cvaIEo2jvkpY
   Q==;
X-CSE-ConnectionGUID: j/4tFEDTQaSieNV+UgFbGQ==
X-CSE-MsgGUID: /Jm+0EPURa+0lvXcGBHQhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="50120332"
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="50120332"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 17:59:57 -0700
X-CSE-ConnectionGUID: myHvkvWQStuYu86/kbqlcg==
X-CSE-MsgGUID: c36WZ+J2SAGoCqT3D6DMuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="130297038"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 17:59:54 -0700
Message-ID: <93ebde20-0a1d-4356-872a-6820813c9fad@linux.intel.com>
Date: Wed, 16 Apr 2025 08:59:51 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 11/22] perf/x86/intel: Allocate arch-PEBS buffer and
 initialize PEBS_BASE MSR
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
 <20250415114428.341182-12-dapeng1.mi@linux.intel.com>
 <20250415134503.GA4031@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250415134503.GA4031@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/15/2025 9:45 PM, Peter Zijlstra wrote:
> On Tue, Apr 15, 2025 at 11:44:17AM +0000, Dapeng Mi wrote:
>> +	buffer = dsalloc_pages(bsiz, preemptible() ? GFP_KERNEL : GFP_ATOMIC, cpu);
> You were going to make this go away :-)

Yeah, since currently alloc_pebs_buffer() would be called in
xxx_cpu_starting() context, I ever thought we still need this, but it seems
I'm wrong. I just drop this change and run it in PTL and don't see any
warning. I would drop this change in next version.


