Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4668B35336E;
	Wed, 20 Aug 2025 05:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755668684; cv=none; b=UNL1WhmjvZAlGAPHi/Klpv/aUSsOrFPCmS0YFFODLE/Bl+xnP47PVqsPLz2TqM9gxQ8cwN5hetsKdUp2Fnvf3zqQX19uF1EblMMNVMQpGWhm20g+AWNhwZP7FQ8G4AzdUueH7srYBppX7jjyaH9yY3tCm6A+jwO2zO0Zrk5MNlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755668684; c=relaxed/simple;
	bh=CG+3hWSdQblLlzUPHzF5sZZBhRC8Uyqp/2xytibp9dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnAcVGn5wWgumvx593hpgso2BConB7wuQ8NMESNK6inN2bOX80wqMX0qjOuNShxl3ochaDtLKJzteH6qJiWi4AxScrNfFvFzfTjd8e9a+yKj0bxdRCDvxBUMHHvFhcfJzgQ/j7Xq3jXl4jR7JRvVd6ZPL6S0743j31VlYNxFJrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nkHHoqj9; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nkHHoqj9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755668683; x=1787204683;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CG+3hWSdQblLlzUPHzF5sZZBhRC8Uyqp/2xytibp9dM=;
  b=nkHHoqj9p5TcG0bEk7K7lyOcM2Gt8STwV+HTcQ9xlQCdPP75SAbXEpOA
   hjfhmikrWhH5DJ3O8WnBytbdZhti7K3py51kKVvXGHn6ln27rAMS6eiKp
   oX/ljCJrSyMFjHYBa+rSFN3Y76Z3Z7BVwsGSkcei5uCMcEfr/ZJZhu/ui
   t6vmmXXIN7iLot/AvtPddRLrkDwNsh994ukFg+lzOsN3/nIuWurboQNR/
   U1KmRMUAcIQARlOalLjDOtURVoWNwhGYbYQXF6QjbWO2C1Xv6R6PEYy3Z
   ZxMGSPi9k7svENcgWAgjZRWvNFUgXPKlrbo1CgNZ4AuRvj+kO7FBU9zX7
   g==;
X-CSE-ConnectionGUID: 0zcBOrICS8GqHwtrvjys3Q==
X-CSE-MsgGUID: AnejP5ajTqO2rhAbpA3tYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="69023370"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="69023370"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 22:44:42 -0700
X-CSE-ConnectionGUID: mUm1pFzNTeqQ5B79w0AnfA==
X-CSE-MsgGUID: DwpOzdFPQAGfBQa0tBk2QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167223923"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 22:44:43 -0700
Date: Tue, 19 Aug 2025 22:44:41 -0700
From: Andi Kleen <ak@linux.intel.com>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [Patch v3 3/7] perf/x86: Check if cpuc->events[*] pointer exists
 before accessing it
Message-ID: <aKVgyV4XWfJGR6uK@tassilo>
References: <20250820023032.17128-1-dapeng1.mi@linux.intel.com>
 <20250820023032.17128-4-dapeng1.mi@linux.intel.com>
 <aKVD4ATXW4LmhDJm@tassilo>
 <aedbcbb5-f0b4-4bf6-bc33-c8c3bf3f20bc@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aedbcbb5-f0b4-4bf6-bc33-c8c3bf3f20bc@linux.intel.com>

> Andi, I didn't fully get the exact meaning about the "log" here. When
> throttle is triggered, perf_event_throttle() has already called
> perf_log_throttle() to log the throttle event although only for the group
> leader. Is it enough?

Throttle normally doesn't involve data loss, just less samples. But this
is data loss, so it's an overflow.

-Andi
