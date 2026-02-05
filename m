Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04E9262A6;
	Thu,  5 Feb 2026 10:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770287446; cv=none; b=Rb8dqfhXcSHUyL/xYWmDIOV5v4Vv39ibrUboqAsMFDb2ROAr6hB6fdQopEyLmB0sl1jnM/inBRcQz1Jt6KQsf3bqR+EjUMc0sAe0a8SAGlmniDe6gOlDWIVwvKiIP/s57NfQEHCeBYzjCDWPprN22ZEAWgNkFMhv06VFG18Kn/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770287446; c=relaxed/simple;
	bh=MamGoCccRVcqxD2GEkYRzgaINikGn9m+zyDtjQ1fxyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXtr019QO8BNaUxCuinsHTGQeXhk7sr42Pn4P389VcVEJqHn0FZLbXSufUAKN7jbGb68V+r9TnjtuLTc6RypCVv5uDH+656Q7jOi9lHxPiLBg3DbVdcY4XAAxASmyzyIEIykyETazfdLrQE6z2yOIzOuN6P7RNrss+5F5BGbguM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38D33339;
	Thu,  5 Feb 2026 02:30:33 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A4EC3F73F;
	Thu,  5 Feb 2026 02:30:39 -0800 (PST)
Date: Thu, 5 Feb 2026 10:30:36 +0000
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf record: Make logs more readable for event open
 failures
Message-ID: <20260205103036.GF3481290@e132581.arm.com>
References: <20260204-perf_improve_log_for_open_event_failures-v1-1-150245792810@arm.com>
 <CAP-5=fUQxuVK+6GObmqVdBmTLzu06FyNaLdLsW6tcgNv5=7gxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUQxuVK+6GObmqVdBmTLzu06FyNaLdLsW6tcgNv5=7gxw@mail.gmail.com>

On Wed, Feb 04, 2026 at 09:29:14AM -0800, Ian Rogers wrote:

[...]

> > This commit restores evsel__open_strerror() to generate a readable error
> > message and print it out:

> Lgtm and sorry for making things worse - I believe it was motivated by
> trying to avoid spammy warnings.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks for review, Ian.

Just wander if we can go a bit further.  My understanding is that now we only
handle the special case of duplicate "cycles" naming on Arm/Arm64, it is
not necessarily to tolerate other failure cases.

So could we report errors and directly bail out for other PMU event failure?
This somehow reverts to old neat log rather the duplicated error logs for
each events.  Something like:

---8<---

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 2584d0d8bc82..ca7d6805840a 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1404,10 +1404,21 @@ static int record__open(struct record *rec)
                        }
 #endif
                        if (report_error || verbose > 0) {
+                               evsel__open_strerror(pos, &opts->target, errno, msg, sizeof(msg));
                                ui__error("Failure to open event '%s' on PMU '%s' which will be "
                                          "removed.\n%s\n",
                                          evsel__name(pos), evsel__pmu_name(pos), msg);
+
+                               /*
+                                * Only tolerate Arm cycle failures and bail out
+                                * on any other event failures.
+                                */
+                               if (report_error) {
+                                       rc = -errno;
+                                       goto out;
+                               }
                        }


If this is okay for you, I can send a updated patch.

Thanks,
Leo
