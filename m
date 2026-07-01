Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4374BC004;
	Wed,  1 Jul 2026 17:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782927814; cv=none; b=H47mId2tnzmmaOFayNvvneR+wP3WYuzVlhWzcSWHNAfljrmQ3xMVaTirfkzvdlpywGGPus6t4YcVpDIhiXIk16Ftowtfx9casoBEGXL9zpn4khv/L0YdOr1i4abbu+M8BRnZOlqHy5fsQ2+dgCcsEPW99Fcd21WLEuaQ5Bws2g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782927814; c=relaxed/simple;
	bh=42s+ba/skarRxspE1zkfbTpIMQm4i0cMT4RXNY6SBT0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jQ/FJ08jET2qR5aeIAdvUD1PR2jezYZoFKrQYURc8Wl6x7nBQvtAZAdI8QyDU18+b4A+4eaMaacwiHLgIHo7LoGPFRWshPLqx4uZu8L2vsHt6OekiTHH6KeunsgwG5SkKLE06ZWADERI4lExTW95324QQmDjjcsCTMRh/jIp9cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asWba2MR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asWba2MR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B891F00A3E;
	Wed,  1 Jul 2026 17:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782927812;
	bh=6E82IlZMeyVxzjVBybO0aS/92G2SUQNUTs8lxCI+aqk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=asWba2MRWRF/Q1aFIxPeAIrf79a0a3nfpRzQ7lNcAI0n2VDvgS8nNoJv+zXJCi353
	 ZL3KYPXuaY0Fkb+8a8eGC7AKJsvABrBrWuZ737HvBByiinlRUPbbcH6He/5dS17yvb
	 4ij3dvKGHUev8jJBYLgbuY/wQa7MZEVHYL9/kqUw54x7KQzV8jxh6OP4oJHMKJD+YX
	 oO7sLkMpaR3Dc2hCtAj/NLRg/ATMVQqAlB0DwItgyyJrV9wogae3DLJ64HO6x+oK7u
	 deUeb5aO+0jstvwYqX1dzpjIzrpCeAYwa8MMcIFPvzpR0WGml7lVdFpcfoHWEUS3fx
	 ISpmdPeaKsg6g==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
 leo.yan@arm.com, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
 thomas.falcon@intel.com, tmricht@linux.ibm.com
In-Reply-To: <20260623012758.2291858-1-irogers@google.com>
References: <20260616164819.370939-1-irogers@google.com>
 <20260623012758.2291858-1-irogers@google.com>
Subject: Re: [PATCH v4 00/13] perf tests: Robustness and performance
 improvements
Message-Id: <178292781264.3559466.14338601631249708304.b4-ty@kernel.org>
Date: Wed, 01 Jul 2026 10:43:32 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 22 Jun 2026 18:27:45 -0700, Ian Rogers wrote:
> This patch series introduces several robustness and performance
> improvements to the perf test suite, alongside fixes for long-standing
> flakiness.
> 
> Key changes across the series:
> - Introduces robust retry logic (`perf_record_with_retry`) to prevent
>   spurious test failures due to transient `EPERM` issues during
>   system-wide background profiling, safely extracting error messages from
>   the PERF_RECORD_LOGS array.
> - Significantly speeds up test execution across multiple scripts (such as
>   kvm, record, trace, off-cpu, and lock contention) by supporting
>   sub-second durations in the `noploop` and `thloop` workloads, reducing
>   unnecessary wait times.
> - Fixes flakiness in the BPF counters hybrid test by parsing `taskset` to
>   determine valid CPUs rather than relying on `shuf`, which can fail under
>   cgroups or missing binaries.
> - Fixes JIT dump file leaks and TOCTOU vulnerabilities by securely staging
>   with `mktemp -d` to guarantee cleanup.
> - Decouples format alignments in `builtin-test.c` to gracefully truncate
>   test descriptions without losing alignment or failing under non-TTY
>   environments.
> - Restricts uncore PMU bypass in event parsing strictly to `--cputype` to
>   prevent unintended metric evaluation impacts.
> - Injects trace output into JUnit XML `<skipped>` blocks to aid debugging.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


