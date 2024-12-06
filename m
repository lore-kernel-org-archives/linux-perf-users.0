Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B64422C6E5;
	Fri,  6 Dec 2024 23:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733526243; cv=none; b=GZTiRU3XsGD8FdTqeYWFGcH1YelJuGfnxvcp2roHnyY+Y/dvxQRVfH+L0BxRqG6iSsPz7qxrWp5/yWhtYFqcMa3niCmn9vwnkFRMt/chOSu8AFRCUXeKtxa/krVghvlJJiYMspPiDaP/ubrLavpf8fpMO8Sezj8yHvf/MMNHjLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733526243; c=relaxed/simple;
	bh=p4EFccDucNVKIcFX7FJDu84xUmq+NZPYJp6PPyIdjio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2jKcVjZHXQsBoTVYBmZWjIyglV5m0YbvG2EuycJBry/SdtA/OaDCjV5Lwc1qYJ02AS76zGUELYsfryHnJKdI+9fRejSGKP1CEMVClOzVrCJSMxchbI2Hn7Rg7GCTtVJEH9xacbjsFbDByfEn/cQDwDTz7NZyHyNUgIVFy/6Ldw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E283D11FB;
	Fri,  6 Dec 2024 15:04:28 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E4A53F58B;
	Fri,  6 Dec 2024 15:04:00 -0800 (PST)
Date: Fri, 6 Dec 2024 23:03:58 +0000
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Kyle Meyer <kyle.meyer@hpe.com>, Ben Gainey <ben.gainey@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/8] Cpumap improvements for large MAX_NR_CPUS
Message-ID: <20241206230358.GB5430@e132581.arm.com>
References: <20241206044035.1062032-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206044035.1062032-1-irogers@google.com>

On Thu, Dec 05, 2024 at 08:40:27PM -0800, Ian Rogers wrote:
> 
> Prompted by Kyle Meyer's <kyle.meyer@hpe.com> report of the
> MAX_NR_CPUS value being too small, initiate some clean up of its
> use. Kyle's patch is at the head of the series. The additional patches
> hide MAX_NR_CPUS as exposed from cpumap.h, reduce its use by removing
> perf_cpu_map__read, and try to better size the temporary CPU array in
> perf_cpu_map__new.

Reviewed-by: Leo Yan <leo.yan@arm.com>
