Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBB236826A;
	Fri, 16 Jan 2026 11:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768561805; cv=none; b=WDXi1A8TiwCb2UfauZKn/DitBai2s6xm0BSGTVodF8zbLktLABa8cuxyryP5H3G0ZG8Xt/N+SlsfspPb5LplkQLf93GaVctIeo214D4jPfnwJDNmbBP7RUAF4aeaa50knXCevNFfoww7biPT/puz2St7uqReoGu0d9RjNFm5wnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768561805; c=relaxed/simple;
	bh=BY4aJJmJM8NNSksueGBqL8soif8zIEyq1UvsJXQpGAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2Cp0u5X4C3AFuKEMG6NjSEvy/6/5/TS0PGXa5AymvccyhKS0Tu8VedLO7Fo/PotcQKJ0JIBQsCD1aFwLFp288nsbVG/oUdL5YRk7TNelDDyNJyd2TLnHOqho+Se+x3qH7oxzb3GFjx2qqAwfJC5PkF/Bh6Fu9hrQdQ3wIAs4DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 366C41515;
	Fri, 16 Jan 2026 03:09:43 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CBCC3F59E;
	Fri, 16 Jan 2026 03:09:49 -0800 (PST)
Date: Fri, 16 Jan 2026 11:09:47 +0000
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Al Grant <al.grant@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] perf arm_spe: Minor event configs housekeeping
Message-ID: <20260116110947.GB1286628@e132581.arm.com>
References: <20251212-perf_c2c_update_event-v2-0-27df9a6cb1d4@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212-perf_c2c_update_event-v2-0-27df9a6cb1d4@arm.com>

On Fri, Dec 12, 2025 at 05:24:58PM +0000, Leo Yan wrote:
> This series is to clean up event configs and update the doc for the
> memory events and related options on different archs.
> 
> A quick verifying on Orion6 board with commands:
> 
>   perf c2c record -e spe-load -- test
>   perf c2c record -e spe-store -- test

Gentle ping for this short series, thanks!
