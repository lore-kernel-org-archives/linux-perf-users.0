Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B721DB131;
	Fri, 28 Mar 2025 17:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743182186; cv=none; b=RiOlw6bdjEwN3DsBiiuFGRFLqqJbsMdN6pmIVX3Gp+rHBmxwmDDAE2uBXkMf2EjHm5HqgMnQyKmJ7UrDiN8k5XYz0Xvg7O7e+5lZa1nhptfbsNMGkLWpWOrlJtfMtbJFV6/TXC5InO5JR2Q76cc0Gu+O2Z1ZhoSxlHv45bT0o1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743182186; c=relaxed/simple;
	bh=ilWIASvvPY2byFQFQbMiPFgc7p8unwgqRQG/r4nZbR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pn4QSXv8Zp0qOE8SVro+mDRTWJrOuSgZqOB1gOJdgcYNG+rtaJ6axIj4aQQSHIvNUZse8NMpDNKuQ1pO+08U3yIObnK4gFtgA/VbELAHaU3yhp9nIl4wEAA3DYpq9UDu1940di9+B3JnR6MZU5bA67qRH1/au8kq8s/FVbnvZck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 616952B;
	Fri, 28 Mar 2025 10:16:23 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AB2B3F63F;
	Fri, 28 Mar 2025 10:16:17 -0700 (PDT)
Date: Fri, 28 Mar 2025 17:16:16 +0000
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] perf build: Remove unused LIBPERF_CLFAGS
Message-ID: <20250328171616.GA195235@e132581.arm.com>
References: <20250328122644.2383698-1-leo.yan@arm.com>
 <20250328122644.2383698-2-leo.yan@arm.com>
 <CA+JHD90hqsAQn8FcwdBnzU8aPOmey76MrUkGitu9E4i2sC2bWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+JHD90hqsAQn8FcwdBnzU8aPOmey76MrUkGitu9E4i2sC2bWw@mail.gmail.com>

On Fri, Mar 28, 2025 at 01:47:39PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Mar 28, 2025, 9:27 AM Leo Yan <leo.yan@arm.com> wrote:
> 
> > Since commit 91009a3a9913 ("perf build: Install libperf locally when
> > building"), the LIBPERF_CFLAGS flag is never
> 
> 
> I'll fix the summary, should be CFLAGS,

Sure.  Thanks for fixing up!

Thanks,
Leo
