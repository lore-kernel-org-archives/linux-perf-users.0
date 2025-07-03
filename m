Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734912DE710;
	Thu,  3 Jul 2025 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751509232; cv=none; b=lHO9rh4Q+9tWqmOXsB6VNhHyMKvRVc7g7ujw8Tjv6u43OgkKlquescBj51Y0IJn8S6kJJxl8lt19kYS77r0yiZfK9iHIPTMzRnq9rPk84nxY346pii3YKtZ1aCjlcm0bGZm66+ef2fV0CDC58P4nPY4oL7FZULwoC6NPef+GQ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751509232; c=relaxed/simple;
	bh=3QGlA5N58P9kqAdo20UwxugIXkueW9CJqBSUBqsZqSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkw8nTXi0NSU89a/tQuOOLZt2dDiBnYvYf/EwrgW/F3Fb8mQJCN7QBPVZL9iFndlbpdst3WeWDfjmJxyK68uMfmfjzV01NDgkzlc2YEApME9L5T0dt8d52XYHBmdcTtlLLjWz2RQ+W7hvhI8+WmvnyzTDJSz53P21ckyrcQc5vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMXxgBMf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMXxgBMf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515EBC4CEE7;
	Thu,  3 Jul 2025 02:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751509231;
	bh=3QGlA5N58P9kqAdo20UwxugIXkueW9CJqBSUBqsZqSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JMXxgBMfIZt0C+oTsNCz0ROeqA9iCjcxzTCuFjgVvfu9NuUDnIDuWTpVKCRikVCUl
	 JWojCndGFXjKOUcGTnW8WGV1fJuZm0ufRfGxx8h/IDBvSCE3G89xpry2gn1BOttvJa
	 l/XLBw8mJ3wS6aAA9tWXy/eKLudME3MgTfpNUDaAIdxHzC95c3AvwkAUPPgGqoPaED
	 xt/JHGTnAyUkGDABObDm+2EyB6pzd8q+eFAcHUpXdkVsQxbLhzS+BKBzrKxM1PJHz+
	 KeeDsnE9ceV2lRG5npsnNGcgvCLMl2reb8PRlVLFHcc/V8l1qs5akcYxq1aLQdEl5f
	 rId+bByT4Qs8Q==
Date: Wed, 2 Jul 2025 19:20:28 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Junhao He <hejunhao3@huawei.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/5] perf test: Sanity check file descriptors are
 cleaned up
Message-ID: <aGXo7Hp31qZOTx9S@google.com>
References: <20250624190326.2038704-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250624190326.2038704-1-irogers@google.com>

On Tue, Jun 24, 2025 at 12:03:20PM -0700, Ian Rogers wrote:
> Some recent patches showed we were leaking file descriptors:
> https://lore.kernel.org/lkml/20250617223356.2752099-2-irogers@google.com/
> 
> When a test is forked the file descriptors >3 can be closed and then
> any file descriptors >3 left after the test are leaks. Add this
> checking to the forked test code. Prior to that clean up some file
> descriptor usage so we can assert that only file descriptors are
> cleaned up. Sometimes the file descriptor being held open is the
> result of a memory leak, so fix those.

Interesting, I can see a few more tests are failing with this.  But we
can figure it out later.

Thanks,
Namhyung

> 
> Ian Rogers (5):
>   perf dso: Add missed dso__put to dso__load_kcore
>   perf test code-reading: Avoid a leak of cpus and threads
>   perf hwmon_pmu: Hold path rather than fd
>   perf dso: With ref count checking, avoid dso_data holding dso live
>   perf test: In forked mode add check that fds aren't leaked
> 
>  tools/perf/tests/builtin-test.c | 69 +++++++++++++++++++++++++++++++++
>  tools/perf/tests/code-reading.c |  7 ----
>  tools/perf/tests/hwmon_pmu.c    | 11 +++---
>  tools/perf/util/dso.c           |  4 ++
>  tools/perf/util/hwmon_pmu.c     | 38 +++++++++++++-----
>  tools/perf/util/hwmon_pmu.h     |  4 +-
>  tools/perf/util/pmus.c          |  2 +-
>  tools/perf/util/pmus.h          |  2 +-
>  tools/perf/util/symbol.c        |  1 +
>  9 files changed, 112 insertions(+), 26 deletions(-)
> 
> -- 
> 2.50.0.714.g196bf9f422-goog
> 
