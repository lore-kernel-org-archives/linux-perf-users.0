Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AA72E88A1;
	Wed, 19 Nov 2025 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763566653; cv=none; b=TZJYL2xdJFpsLaJ0pg+9P019DC8ENJfMzlhVvc6vHyQidLnvsYfzb562ZwRbDuBo5GU15hJbBSPtDXp9ccMssx807JeiSWltr6BWlKujJ7WV7C4EtvuZs4ioB9B7khaz1dRLFADxOkNHlR40uJVXxvQQP/gTixRxxyVumTtfoYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763566653; c=relaxed/simple;
	bh=HcxzBQLMPYHAEcgfCujXydDawdv/QxWAklRiwtaVtRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwnLwSEQG4wcy5cpwGWqPqDx2Y+p3E44JzAIGAYOg2N/ieJPJYuwPH2ODbqkLfnz6yoz3niL8HPahTZxtM9tPQ1hOFu0YZsOIqcvLIqFO8n9bLvjykg2S9ddTXr2ZYszetxRc9ap8b685r7pU2yUi3AOAeqShJSRnNl4UkrzYRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BlrT9UIj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BlrT9UIj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763566650; x=1795102650;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HcxzBQLMPYHAEcgfCujXydDawdv/QxWAklRiwtaVtRI=;
  b=BlrT9UIjd6qbb/gNhgWsQyNwbhdd3ked18cTm8vVTDExOeGEK9G109GX
   zLYyO0HXR59HA5rJMy2uoxJXb5DeTSA+SxrLw7x5mLb4qiLcQqkk2RV0N
   UDyD/v57hHBJLRnCYR9SsKLC41+g6Apj1koRTHuWj5En/QQ2hFDfn6iG5
   XNar6g2uqI6VPv05zGlhEeolNHph8WNtDetz26M87BmzUyDT9451SaciG
   2nZqUovLcbvGa1VE4Mlzywf4CNX/L7enm06snSsYFc5Jnh7nQb8VqliUI
   SFbRJFEgV1ty/lSHb6WEsMIZzbjanT/CFLAXbD9YwrxXlARcYLwaJ94Mu
   w==;
X-CSE-ConnectionGUID: /vjoMohJQ9KQMcJkfuZOjw==
X-CSE-MsgGUID: dKTw69MNSoWjDxQHtrLVBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="69464605"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="69464605"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 07:37:29 -0800
X-CSE-ConnectionGUID: O53mlel7SQSLlW5+ToW5pw==
X-CSE-MsgGUID: vCqrMscuTvmyX6/+m+clSw==
X-ExtLoop1: 1
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 07:37:29 -0800
Date: Wed, 19 Nov 2025 07:37:27 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Yang Li <yang.lee@linux.alibaba.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v5 3/3] perf stat: Add no-affinity flag
Message-ID: <aR3kN1GiKki4AO9b@tassilo>
References: <20251118211326.1840989-1-irogers@google.com>
 <20251118211326.1840989-4-irogers@google.com>
 <aRz-6jQf9GH4JROi@tassilo>
 <CAP-5=fWSXboT2jEYtua_N8AnaXc0SUeoC2iBgxSz5QRF09bfoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWSXboT2jEYtua_N8AnaXc0SUeoC2iBgxSz5QRF09bfoQ@mail.gmail.com>

> Ack. This is only adding the flag to perf stat, are the storms as much
> of an issue there? Patch 2 of 3 changes it so that for a single event
> we still use affinities, where a dummy and an event count as >1 event.

Not sure I follow here. I thought you disabled it completely?

> We have specific examples of loaded machines where the scheduling
> latency causes broken metrics - the flag at least allows investigation
> of issues like this. I don't mind reviewing a patch adding real time
> priorities as an option.

You don't need a new flag. Just run perf with real time priority with
any standard wrapper tool, like chrt. The main obstacle is that you may
need the capability to do that though.

-Andi
