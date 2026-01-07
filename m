Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F5D34DB4E;
	Wed,  7 Jan 2026 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767798353; cv=none; b=Tul2GZHSkf9PdEplEmHaanghzer8NzMjLwmhNuwct0tdIzllVZO4M9CxQSCXhjLPjTN9gq2dLQF6TjGbtouTpS+wLRISqsAAl3E2boYn/XSYIk0b/JmqBEk7sw57KB63aJwWMtvHTuxA2B99jZKFtwg3OinQli2dDFTC6/ZiEBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767798353; c=relaxed/simple;
	bh=mcEKvCND03r52SOEa0CJ1xgCZUfc4qOr1bWcywaWG1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUMwB8kZgfuH3OosR5zTdYBr7Lqh3Pz9RlS67LeLAGy4I0j4peUroryYM2RnT7kvF2sR9kopcPhliOajSkTGfdbgqrpsb8EnLHWzjWjKTPT0kUSLPAvYNGbyOngPAMlGKzBv3QBz6Pk6k/NWIGGzODEPMdSYZL2yLYHnaj48EuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A8CB497;
	Wed,  7 Jan 2026 07:05:43 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E30D03F5A1;
	Wed,  7 Jan 2026 07:05:49 -0800 (PST)
Date: Wed, 7 Jan 2026 15:05:47 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3 3/3] tools headers: Don't check arm64's unistd.h
Message-ID: <20260107150547.GD336318@e132581.arm.com>
References: <20251222-perf_fix_syscall_header-v3-0-eb4a8b9dfe66@arm.com>
 <20251222-perf_fix_syscall_header-v3-3-eb4a8b9dfe66@arm.com>
 <69a098d8-ff54-4746-96d5-5ce5eb2a8a83@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69a098d8-ff54-4746-96d5-5ce5eb2a8a83@linaro.org>

On Wed, Dec 24, 2025 at 01:51:33PM +0000, James Clark wrote:
> On 22/12/2025 6:06 pm, Leo Yan wrote:
> > The arm64 unistd.h in tools now diverges from the kernel header.
> > Comparing the two headers is pointless, remove the check.
> > 
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > ---
> >   tools/perf/check-headers.sh | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> > index e0537f275da2f79ea9e05b91300aa1e2f996e9f1..da3aca87457fdc56c96d4184f2dee88dab026d98 100755
> > --- a/tools/perf/check-headers.sh
> > +++ b/tools/perf/check-headers.sh
> > @@ -54,7 +54,6 @@ declare -a FILES=(
> >     "arch/s390/include/uapi/asm/kvm.h"
> >     "arch/s390/include/uapi/asm/sie.h"
> >     "arch/arm64/include/uapi/asm/kvm.h"
> > -  "arch/arm64/include/uapi/asm/unistd.h"
> 
> Isn't this _more_ of a special case for arm64 than continuing to do the
> consistency check like in v2? It seems like the desire for consistency isn't
> taking the whole tools/ picture into account and we end up adding more
> inconsistencies than just the regular static copy + diff check that we have
> for all the other headers.

Ideally, the perf tool should not maintain UAPI headers. These headers
should be provided by the toolchain or generated dynamically.  From
this perspective, this patch is on the right way, as it avoids
maintaining special uAPI copies.

To be clear, I do not suggest removing all synced headers — only the
UAPI headers.

Thanks,
Leo
