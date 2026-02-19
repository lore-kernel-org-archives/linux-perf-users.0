Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F32341AA0;
	Thu, 19 Feb 2026 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771513381; cv=none; b=pp/LfLn3N34oVnyOldWgrgCf34/Nuj/TQCwdB6+/LFULNYl+9FG7DNnGxn6kpGbd2itmONzSeUKq2YnSu2s5ohRXdoAUB6sEZilo+QOLcZYui6ORguIV/BVXpa4kU5MgvXFgeyoqBwNOAV3nylDDBiwwyntIevGKtV56R3ayc40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771513381; c=relaxed/simple;
	bh=FXZGlCRKH+OwoyyTXtOHnMSoPAK/4q2jipZeNtsZxmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hziuXkgh0U+zH8nKn6wW/gTKsI7HJkSjQj5OSFwUGdEAzx1ilh21EyUpIGpJnr+qYzPqool2YrA/dT2OIrS3hOKUDN7UvVwnVUKvABNylyL222DIElAc6Bs3Rf1iI7YBT+0n+VMTCKKM0ITAX+aqdSZxKbQzk4+Zrs/pdrRShIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69C03339;
	Thu, 19 Feb 2026 07:02:52 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42D9D3F7D8;
	Thu, 19 Feb 2026 07:02:58 -0800 (PST)
Date: Thu, 19 Feb 2026 15:02:56 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf bench: Fix initialization of union
Message-ID: <20260219150256.GC136967@e132581.arm.com>
References: <20260219004417.188434-1-namhyung@kernel.org>
 <a91a44a4-a918-4edd-9fe2-2274d5213dcf@linaro.org>
 <ea82e2ab-ddb5-419b-aa70-49b28f18383a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea82e2ab-ddb5-419b-aa70-49b28f18383a@linaro.org>

On Thu, Feb 19, 2026 at 10:38:57AM +0000, James Clark wrote:
> 
> 
> On 19/02/2026 10:36 am, James Clark wrote:
> > 
> > 
> > On 19/02/2026 12:44 am, Namhyung Kim wrote:
> > > Recent compilers don't initialize all members (or the largest member) in
> > > an union.  Instead it seems to set the first member only.  So some perf
> > > bench output shows invalid numbers like below on my system with GCC 15.
> > 
> > I couldn't find V1 of this so I wasn't sure if it was discussed already,
> > but wasn't the plan to fix this with a compiler option:
> > 
> > https://lore.kernel.org/linux-perf-users/20250319110454.3230687-1-leo.yan@arm.com/
> > 
> > and
> > 
> > https://lore.kernel.org/linux-perf-users/20250320105235.3498106-1-leo.yan@arm.com/
> 
> Oh I see V1 was only the second patch, that's why I couldn't find it.

Thanks for bringing up this, James.  The latest patch would be:

https://lore.kernel.org/lkml/20250402173056.829400-1-leo.yan@arm.com/

This patch intends to apply the option across tools, but no response
from the maintainers.  Seems to me, it may be good enought to apply the
option to perf first.

Thanks,
Leo
