Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FA42E5B05;
	Fri,  6 Feb 2026 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770368034; cv=none; b=XfY7cZXJlDV/mu4h5NnT74VnWEkixDsiWUnacLw+O0W+k5IC9jqh04eevZ5g5ZpCsHfki5W6MJiyNguo3REK563NInSwGVf9PFHHe4DY7ZnylvWCVEjEfVxke7idvqxov/ekPGhYbg9z8ebP4bUZ63a48LxwrRyK0E7AMl0/9f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770368034; c=relaxed/simple;
	bh=HIyLaIurqL1M1iJhTTJ0cX/i3VNy5oGj2UYBFgRxbug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSvYeaLmiZRVl9yZT4b5qIuOC81DCJS2eWRKi8Qv57WxTgl5535AYbL9kEnUuJON1gqXU+5lAjbWbqTYJDY3E/0u7pWmm2z0nICpdECHVyqTF0yOkh9IZ+rHcoAvRCscXs8HUNhCurP5uM+KPanR9Glr5AqXOIRGj4F/+UASPw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EAE9339;
	Fri,  6 Feb 2026 00:53:45 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79FC23F778;
	Fri,  6 Feb 2026 00:53:51 -0800 (PST)
Date: Fri, 6 Feb 2026 08:53:49 +0000
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf tests: build-test coverage for NO_JEVENTS=1
Message-ID: <20260206085349.GD3529712@e132581.arm.com>
References: <20260205183603.459363-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205183603.459363-1-irogers@google.com>

On Thu, Feb 05, 2026 at 10:36:02AM -0800, Ian Rogers wrote:
> Leo reported the NO_JEVENTS=1 build being broken and this highlighted
> it being missing from the build-test, add it.

To be clear, I did not say the build is broken.

The issue I reported is that `perf stat` is broken, both with
NO_JEVENTS=1 enabled and without that configuration.

With updating the commit log, this patch LGTM:

Reviewed-by: Leo Yan <leo.yan@arm.com>

> Reported-by: Leo Yan <leo.yan@arm.com>
> Closes: https://lore.kernel.org/linux-perf-users/20260205175250.GC3529712@e132581.arm.com/
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/make | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index eb41516c0562..6587dc326d1b 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -70,6 +70,7 @@ make_python_perf_so := $(python_perf_so)
>  make_debug          := DEBUG=1
>  make_nondistro      := BUILD_NONDISTRO=1
>  make_extra_tests    := EXTRA_TESTS=1
> +make_no_jevents     := NO_JEVENTS=1
>  make_jevents_all    := JEVENTS_ARCH=all
>  make_no_bpf_skel    := BUILD_BPF_SKEL=0
>  make_gen_vmlinux_h  := GEN_VMLINUX_H=1
> @@ -144,6 +145,7 @@ ifneq ($(new_libbfd),)
>  run += make_nondistro
>  endif
>  run += make_extra_tests
> +run += make_no_jevents
>  run += make_jevents_all
>  run += make_no_bpf_skel
>  run += make_gen_vmlinux_h
> -- 
> 2.53.0.rc2.204.g2597b5adb4-goog
> 
