Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1411302151
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Oct 2025 08:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120772; cv=none; b=t4jNctmQllBItayDG+qjWAAClp2lu+5zDsClxAjbVgHTmfCF9FVrR9SHY/RIQP9Ve25lKB3SI11diw5K7T+oF+Ji+6Ix9/cvSt4jJ3qAo5TxUfdGA58kCI2Bd3BdWyWSsyd9skk+Wd8Pfo6rlsqa+vL4CF7qP6Gu9FCpkte3nKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120772; c=relaxed/simple;
	bh=aE6IksWfngQvaq1q7RaQco4zB7M5qwaJaa+u+SyAI6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoMKrNxBkTZaLk1gHP95MVA52sFL9cFwAQ2CFfodISYFcXOEA1w9QEXwfts2CUOwZyxUWiQ8NmAMz5azBYzHdSGvpZxoZb58vnJ4/zptXcKnz52mqK1wKgIy922hbqmBNnK0Utn/xbhM84HXtIu9hf0DBdCXfblJsxb9hfpbL9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 296FE1063;
	Wed, 22 Oct 2025 01:12:42 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91F4F3F63F;
	Wed, 22 Oct 2025 01:12:49 -0700 (PDT)
Date: Wed, 22 Oct 2025 09:12:47 +0100
From: Leo Yan <leo.yan@arm.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@linux.dev>,
	Mark Rutland <mark.rutland@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [resend][PATCH] tools: arm64: Add Cortex-A720AE definitions
Message-ID: <20251022081247.GP281971@e132581.arm.com>
References: <877bwnyh6f.wl-kuninori.morimoto.gx@renesas.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877bwnyh6f.wl-kuninori.morimoto.gx@renesas.com>

On Tue, Oct 21, 2025 at 11:21:48PM +0000, Kuninori Morimoto wrote:
> Add cputype definitions for Cortex-A720AE. These will be used for errata
> detection in subsequent patches.
> 
> These values can be found in the Cortex-A720AE TRM:
> 
> https://developer.arm.com/documentation/102828/0001/
> 
> ... in Table A-187
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Acked-by: Will Deacon <will@kernel.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>
