Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D271D63C0;
	Mon,  3 Mar 2025 09:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740994740; cv=none; b=sUKEwKaCCrR1ZUUNeLFFCMQp4AyuC7XOKZ+AOkYDBFEQmokUfOPxdnS6kLZYplYTI/YEpWwS48GzXxMHFcxN1ybLFGpul3DiKOS6Y0BFgsOOveHcHqvum/adyaOZ+WqkFBNkCNiaCSb+Qp1w5KY2qiKE4KRQ5sQj0KjkicSP1bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740994740; c=relaxed/simple;
	bh=4wdFl9+UTq4usFH+JTIEK4HYfOFtQJ9UnIDCz0V5EbQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFVdhirBLqGnDnOQVRb2mV3NL1l7KmmOo/1wIKMPWBNhNYdI3FHLf02k5gYdCL2JStoL64lcHHPqy4H2+ryy/6vZp9AcZBCk9V22KVdX/ZCh79X3k2pUeZqqKAWkDo+M+uxrGvaPRMA7YjbLU2Q7XaU4mhKBnVBSAdcLs8O6cII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1F7E113E;
	Mon,  3 Mar 2025 01:39:11 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F9C83F66E;
	Mon,  3 Mar 2025 01:38:57 -0800 (PST)
Date: Mon, 3 Mar 2025 09:38:53 +0000
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Will Deacon <will@kernel.org>,
	Graham Woodward <graham.woodward@arm.com>, Paschalis.Mpeis@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 00/12] perf script: Refactor branch flags for Arm SPE
Message-ID: <20250303093853.GG2157064@e132581.arm.com>
References: <20250217195908.176207-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217195908.176207-1-leo.yan@arm.com>

Hi Arnaldo, Namhyung,

On Mon, Feb 17, 2025 at 07:58:56PM +0000, Leo Yan wrote:
> This patch series refactors branch flags for support Arm SPE.  The patch
> set is divided into two parts, the first part is for refactoring common
> code and the second part is for enabling Arm SPE.

James has given review tags (including the new added patch 06).  Could
you kindly pick up this series?

Sorry for pushing a bit, as we have dependency on it.

Thanks,
Leo
