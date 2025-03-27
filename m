Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EAC4A21;
	Thu, 27 Mar 2025 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743073407; cv=none; b=Cb0hSINT2Mfjyb1ureEY3cPRAacIyMYyY3fRmmJquyHC30uLvzLFa0LzssDSvcOL6lgZ662dxM+365OobUWHjLaqVad3WE1YLcVk9Ek+S/OaHI+7F5Nu01tY13VDaqbLn6Vin1+Ep/iw56ghT4ZN3h2q94P8OS6hqTAyhbiTQNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743073407; c=relaxed/simple;
	bh=qoIoAvmMcofj5qQjQ2B6hzT1pzX0ML1/H4KRnnQjG6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uehnsnQcz/T+0iZhtrFhKSb16kczGXl5BEl6UqWqyzWwi5/ltANyBuPtWX98yTGFCkeYnb53kjL5rB0/NMKQA9+eUHr2v6sanN/1ckhwWK9ix2R/ZJJtN6qoI3Wp30nYS3q04f2A+k7uOz1NL5kCunKAblKJcSMkX1Au9fel6MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4D131063;
	Thu, 27 Mar 2025 04:03:29 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 168D23F58B;
	Thu, 27 Mar 2025 04:03:23 -0700 (PDT)
Date: Thu, 27 Mar 2025 11:03:19 +0000
From: Leo Yan <leo.yan@arm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, mingo@kernel.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, elver@google.com, james.clark@linaro.org,
	suzuki.poulose@arm.com, mike.leach@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] events/core: fix failure case for accounting
 child_total_enable_time at task exit
Message-ID: <20250327110319.GE604566@e132581.arm.com>
References: <20250326082003.1630986-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326082003.1630986-1-yeoreum.yun@arm.com>

On Wed, Mar 26, 2025 at 08:20:03AM +0000, Yeoreum Yun wrote:

[...]

> After this patch, this problem is gone like:
> 
> sudo ./perf stat -vvv -e armv8_pmuv3_0/event=0x08/ -e armv8_pmuv3_1/event=0x08/ -- stress-ng --pthread=2 -t 10s
> ...
> armv8_pmuv3_0/event=0x08/: 15396770398 32157963940 21898169000
> armv8_pmuv3_1/event=0x08/: 22428964974 32157963940 10259794940
> 
>  Performance counter stats for 'stress-ng --pthread=2 -t 10s':
> 
>     15,396,770,398      armv8_pmuv3_0/event=0x08/                                               (68.10%)
>     22,428,964,974      armv8_pmuv3_1/event=0x08/                                               (31.90%)
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Fixes: ef54c1a476aef ("perf: Rework perf_event_exit_event()")

Tested-by: Leo Yan <leo.yan@arm.com>
