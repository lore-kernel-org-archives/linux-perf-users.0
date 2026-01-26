Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59A82AF1B;
	Mon, 26 Jan 2026 20:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769460759; cv=none; b=e7IWg1DXTtT3O5chfdXd0CzORmLvftk177uwyaCRqfvmvZbOScc+2EPhEu7FWrFEGf/49oWxAL6oVBWfz+Vl7GJOBfHH+w+eu7pzinU67TLwKB84quApjBt1S9X5V3+Ai8Vu6tlcm99x2xXGx+JHUWoplUy6lFHPmStqi2bG6d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769460759; c=relaxed/simple;
	bh=skGttQC4rJoM8W4yDBCx3djKpe6LiRktG8NNE7H7KOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U19JUvL1qTYoig0KhUqrF/Frun8yFrP3GUB0VQydSD7wbn89/csNMScFNr7ySnn6mhy7lQIzEKPhRH68IVQI1Y1yOoJECHqe3iBQpWKJ1HwcTsZtQ/psPNvU+TmJtaC4kBIPRdZDuWOHrl3SiIvZdUucJurSg5Xf0N/AoMrUXNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyTGUNay; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyTGUNay"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1774BC116C6;
	Mon, 26 Jan 2026 20:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769460759;
	bh=skGttQC4rJoM8W4yDBCx3djKpe6LiRktG8NNE7H7KOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DyTGUNay+KhtkPgorQIZxjVYDlQH6j/GVRasc1S9ex9I1lLaJDJaw8sM/zm+zz0tg
	 B0Nh08po0aP5kTZLfkNo7bclzhcCDsBVauPUkaLxxAX7zeVST1Pgm6e7vEz2AdkLxl
	 n3R/knDIQ6dTkvXKMoTkos7gxG1knnVmRRqdiKPpxORvTlbTnwvXGnsVenJuXoBaRy
	 f98gaW+mLZsLo5+hNzGPtYuAfNTxEskk6mB3yQTTtxlXLuGZ31JZQrB3ZJ+zNetAkf
	 S+1ZUEis2tezkYALankwZwJGNpk3W80EAFXG3dMo1NIxPQ6Tr/BevwB4rqLYB0JNk7
	 zWfT+ddPEvM6w==
Date: Mon, 26 Jan 2026 17:52:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Shimin Guo <shimin.guo@skydio.com>, Andi Kleen <ak@linux.intel.com>,
	Leo Yan <leo.yan@arm.com>, Yujie Liu <yujie.liu@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 0/3] perf more ELF machine usage
Message-ID: <aXfUFBfCQ4m_DFrx@x1>
References: <20260124001611.1332019-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124001611.1332019-1-irogers@google.com>

On Fri, Jan 23, 2026 at 04:16:08PM -0800, Ian Rogers wrote:
> Switch 3 more cases where the perf_env arch was being used to
> determine the architecture type and switch to using the ELF
> machine. This includes the addition of minimal instruction parsing in
> perf script for architectures other than x86, or x86 when
> cross-platform.
> 
> Note: this series will conflict with the e_flags series:
> https://lore.kernel.org/lkml/20260123222209.1181249-1-irogers@google.com/
> that adds an additional out argument to thread__e_machine. In all the
> cases here that argument should be NULL. So:
>   thread__e_machine(thread, machine)
> becomes:
>   thread__e_machine(thread, machine, /*e_flags=*/NULL)

This one isn't applying.

- Arnaldo
 
> Ian Rogers (3):
>   perf script: Fix script_fetch_insn for more than just x86
>   perf callchain: Switch callchain_param_setup from an arch to an
>     e_machine
>   perf thread-stack: Switch thread_stack__init to use e_machine
> 
>  tools/perf/arch/x86/util/Build                |  1 -
>  tools/perf/arch/x86/util/archinsn.c           | 27 -------
>  tools/perf/builtin-report.c                   |  6 +-
>  tools/perf/builtin-script.c                   | 20 +-----
>  .../scripts/python/Perf-Trace-Util/Context.c  |  2 +-
>  tools/perf/tests/dlfilter-test.c              |  1 -
>  tools/perf/util/archinsn.h                    | 12 ----
>  tools/perf/util/callchain.c                   |  5 +-
>  tools/perf/util/callchain.h                   |  2 +-
>  tools/perf/util/dlfilter.c                    |  3 +-
>  tools/perf/util/sample.c                      | 71 +++++++++++++++++++
>  tools/perf/util/sample.h                      |  7 ++
>  tools/perf/util/thread-stack.c                |  4 +-
>  tools/perf/util/trace-event-scripting.c       | 16 -----
>  tools/perf/util/trace-event.h                 |  3 -
>  15 files changed, 91 insertions(+), 89 deletions(-)
>  delete mode 100644 tools/perf/arch/x86/util/archinsn.c
>  delete mode 100644 tools/perf/util/archinsn.h
> 
> -- 
> 2.52.0.457.g6b5491de43-goog
> 
