Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7227718FC90;
	Wed, 25 Sep 2024 12:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266536; cv=none; b=B5ZsISOxt/qGcYT4n7ed8KXHw+xLOdMrn40PTZa0d6+GFch7nwiQR632vhxARpwzd0VNYJ87xCa2wbXCjitvbzY2MUK3glnyVHV0ofsD1JZYfdGs9ZJt7MrBRv+TuVWAXfP3YTxjKAemzY5hgAny5cwW5kBm1Xn0ZWHLsyXmnRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266536; c=relaxed/simple;
	bh=LAyZEYybAVkrpMxB8OhZGXg46DMOVw09blsQOKiw630=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XZi6geWKJuGA1YeCVHt1JOLqBooV6Q6VxJz31OtuxH2kc8BJV2ftg+lGHJBS/g9TDGXv4EdV6THKvMaxsKxD8j3hFdIvxI9DQG0A9OfmXmKqZRm4zT+iFTiBe1K++0uX44IGMlWx0vZ7SK0ZOg1dZmo6Wizj+wtLnZKoWg7yPNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AowY8iVA; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AowY8iVA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727266534; x=1758802534;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=LAyZEYybAVkrpMxB8OhZGXg46DMOVw09blsQOKiw630=;
  b=AowY8iVAOuaf7yrjxFQaPeiWUv0NnoLzZ8OKtncl9f6esgfjLSccsCH+
   t5FCRRayOPq6V0lOgEN2g3DoPsRyPqqsGpX+DM2a+4BWkyMxt8LS+zb24
   ufvoLj8NskIaV6VH6pOOMI9m1gzKOckx6YVma1NTOHr0OVnLvyFnW8wy7
   B7sSP05VjapjskpS7BjdCJJi06D/wble6VPZJevNA4byUoMkU9v3Lphg0
   xT9FMpDj7lbRx3Ekeq0ewmqgPhkBuwW0C3V4SRthJy+G1hhFsQ/fsm+w9
   yTN34DdjPmoVQaidqbP8R+sp6+4xIesjRWHRhha+pCRXJ2hUK1o3ncr8c
   g==;
X-CSE-ConnectionGUID: kbzgBfKLReWplj+oVw9HRw==
X-CSE-MsgGUID: KMRigXR3SUqT+qiKy384ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="37665386"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="37665386"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 05:15:32 -0700
X-CSE-ConnectionGUID: tKL70W03T2yFz7dfQhwkhg==
X-CSE-MsgGUID: WcGWDSS9SN2Dv5bCgcpJyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="71894911"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by fmviesa008.fm.intel.com with ESMTP; 25 Sep 2024 05:15:32 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id A3C5730183B; Wed, 25 Sep 2024 05:15:31 -0700 (PDT)
From: Andi Kleen <ak@linux.intel.com>
To: Levi Yun <yeoreum.yun@arm.com>
Cc: peterz@infradead.org,  mingo@redhat.com,  acme@kernel.org,
  namhyung@kernel.org,  mark.rutland@arm.com,
  alexander.shishkin@linux.intel.com,  jolsa@kernel.org,
  irogers@google.com,  adrian.hunter@intel.com,  james.clark@linaro.org,
  howardchu95@gmail.com,  nd@arm.com,  linux-perf-users@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] perf stat: Close cork_fd when
 create_perf_stat_counter() failed
In-Reply-To: <20240925110802.2620613-2-yeoreum.yun@arm.com> (Levi Yun's
	message of "Wed, 25 Sep 2024 12:08:01 +0100")
References: <20240925110802.2620613-1-yeoreum.yun@arm.com>
	<20240925110802.2620613-2-yeoreum.yun@arm.com>
Date: Wed, 25 Sep 2024 05:15:31 -0700
Message-ID: <87msjw2al8.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Levi Yun <yeoreum.yun@arm.com> writes:
> +void evlist__cancel_workload(struct evlist *evlist)
> +{
> +	int status;
> +
> +	if (evlist->workload.cork_fd > 0) {

Technically 0 is a valid file descriptor. Check for >= 0
And make sure the field is initialized with -1

The rest looks fine to me.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
