Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0D72AEFE;
	Tue,  1 Apr 2025 09:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743498869; cv=none; b=MeUiOFaeVfgvNg1rDzBnHqG/o6zUgq/HZ8sHtrbDMu0+MKVDHmr7/0U/K+HrXkdhH6ZrkmKWAfxbk3dhMQeekrYbpaME6k1eZzFaMyPQjyEof15khBG61WmU/NVEd31jOezoaI8CRoNH+cAvEk5tnlq0u5dVK7uR43suxFCi19w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743498869; c=relaxed/simple;
	bh=4A3rvVF9aE2vaR2QWrgljQmOr0ua8PY3wrAprQQTqac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JME3KEG+hO4RUvtbHTEibOkmBblESLATPgbTkm2h5Pi9jPDwCGwrZFkdMSPwoxmaJOYYMCA1vofObJ9nvrrVb8d7LKkb802HH1H196NCMeajuDj8ggHjM99vqXOem0ET0SCESQ2x6n8Skn3GUiJd0PXY7XfpDlp+WFxu1JgLYvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14EAF14BF;
	Tue,  1 Apr 2025 02:14:31 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 367B13F694;
	Tue,  1 Apr 2025 02:14:27 -0700 (PDT)
Date: Tue, 1 Apr 2025 10:14:22 +0100
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tests switch-tracking: Fix timestamp comparison
Message-ID: <20250401091422.GA115840@e132581.arm.com>
References: <20250331172759.115604-1-leo.yan@arm.com>
 <CAP-5=fVsgahBhOEOac52PmL0V+n1jqAxzf7n9PVWgWsxq9TvgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVsgahBhOEOac52PmL0V+n1jqAxzf7n9PVWgWsxq9TvgQ@mail.gmail.com>

On Mon, Mar 31, 2025 at 01:18:31PM -0700, Ian Rogers wrote:

[...]

> I'm reminded of a Java check I wrote for this:

Nice short article.

> In clang -Wshorten-64-to-32 looks to cover this. I'll see if we can
> clean those warnings up a bit.

I checked a bit and seems GCC has no this flag, but it makes sense for
me to enable the flag for Clang.

> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks a lot, Ian.

Leo
