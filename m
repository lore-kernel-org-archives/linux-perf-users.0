Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82327233735;
	Wed,  2 Apr 2025 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743584721; cv=none; b=hUqZcOBK1g+O6JVhvfffl8XI7SmbEoZWhIC95KZv6YtgkeJ5SFXcOVu6oE5S/4HZ2uXgTztYC51bMS8fMjIxSUtKRl8PA9HF/7SI7baciWOo725XQ+F3IclwchAEIvm2MAa2aXGKBYh0QASI9+NEPRJrlbSYXoEKyD4F1Ryz/RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743584721; c=relaxed/simple;
	bh=WIjK/QckphRthxHzdJMzRERbUuHAWoMS84T01vfg1/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFU9qJMM8drbF8J+HR3PMoNzBN+wQlEpv+Hk5gWJ6lbSP8ZJ9IJg7myv+xAQpDOkhWHnP8Y655Ea2FpfTkbyD8K4FTX8t6HY7VqUXJVZSRExWlPl9uu5Zy88VkNulFteSHl1ax1ulqXNqIrICO5WQMbDzu5Ge9t3uOeTHufmv7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B259412FC;
	Wed,  2 Apr 2025 02:05:21 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41B233F694;
	Wed,  2 Apr 2025 02:05:18 -0700 (PDT)
Date: Wed, 2 Apr 2025 10:05:16 +0100
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tests switch-tracking: Fix timestamp comparison
Message-ID: <20250402090516.GG115840@e132581.arm.com>
References: <20250331172759.115604-1-leo.yan@arm.com>
 <CAP-5=fVsgahBhOEOac52PmL0V+n1jqAxzf7n9PVWgWsxq9TvgQ@mail.gmail.com>
 <20250401091422.GA115840@e132581.arm.com>
 <CAP-5=fUGLy9xGmMO+6PXvfviB4U8Q8O7H3iTSSqEf72vin8gDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUGLy9xGmMO+6PXvfviB4U8Q8O7H3iTSSqEf72vin8gDA@mail.gmail.com>

On Tue, Apr 01, 2025 at 12:54:12PM -0700, Ian Rogers wrote:
> On Tue, Apr 1, 2025 at 2:14 AM Leo Yan <leo.yan@arm.com> wrote:
> >
> > On Mon, Mar 31, 2025 at 01:18:31PM -0700, Ian Rogers wrote:
> >
> > [...]
> >
> > > I'm reminded of a Java check I wrote for this:
> >
> > Nice short article.
> >
> > > In clang -Wshorten-64-to-32 looks to cover this. I'll see if we can
> > > clean those warnings up a bit.
> >
> > I checked a bit and seems GCC has no this flag, but it makes sense for
> > me to enable the flag for Clang.
> >
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> >
> > Thanks a lot, Ian.
> 
> I made a small variation to the change in:
> https://lore.kernel.org/lkml/20250401182347.3422199-10-irogers@google.com/
> to avoid a subtract and just directly compare the values.

Fine by me.  I reviewed your patch, the direct comparing LGTM.

Thanks,
Leo
