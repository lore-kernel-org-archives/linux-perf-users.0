Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792997465;
	b=rHrwWjqvs3ElZNyhHFdAK7uJ50+GQUWo1MZRzpc1LV1FyWMHyd23PjaFSl0VG/lGhepH
	 2IDUqOPzzKoHvsk8otRShsU3fMPcPURDvNlm9wJeHKdt/mdUuisq96XriBU89r+59Q+BY
	 BfnhqJy6xI6hPua/G88zZDoZugH96lmlEGhhbHUsLXPPtzS69dp82FhC0j6ui/2kmr1OC
	 LHiVvCsg8kO4wn0pLL0YfV9Z2j59+F30lfU8Vs3k+Wuz4eoUzEKu2Ji1XwPWLwiUmbCQ1
	 cx3zjb6E9dR1ejl26/QfD7u9A4KQGcMPv0x7ciVLFYm0JtM6bm9cvmpFij2tKuy2+uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792997465;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=63gX4GVlfNF6cXXZiGFc57UUZdEDSiFDHRSUW+70Tqk=;
	b=I3NFrspJvzLYF5dQA0TUeAs2INU4FmXGBa8qY1UL8/6xByg9U+AWtFvRcpYMh096Chd4
	 9il1yCyR9s1aqTq3Ok0nLJnfj6ectdSv9VqG6G2wammFwwbClQYeGrIPB5mvkHwhdbjw4
	 CZIh+qMgXqFgLA69angLU8BHI00tTVfPQWD9vLFfUvtC7nfBVqUMtoY3bXQ4KyOE78IaW
	 5wUoTKcPR75SyFDgTUIJLjDJ8+Zp5A5LYeioMEmA7AcXuzyauNXFiM8GlK9wOgXRg1PpM
	 Pvr69i7H2xsXkFs5CbP+2NX7wUkFs4aYh3nVtJj+lvuCnccBfbwNV8ccWS3S/RN5s3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="nsyXm4v/";
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40CA606A31B
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 06:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E40CA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=nsyXm4v/
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1383723dfddso5107632c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 23:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792997464; x=1793602264; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=63gX4GVlfNF6cXXZiGFc57UUZdEDSiFDHRSUW+70Tqk=;
        b=nsyXm4v/MfIn5SXVdF7MKZjIGc4COpg2NIjxZqdgN/PhnfjlD6pnHbRqvCfxIH6S/a
         Fii5nHI0Z6tPJONJM7OJPY895pFV0dJTDrgnYljz+vLWQywJ2AS4lEn9MQP9/TSuiaS9
         ZxNqPrlHCsJ2OfAliQya/5xIqMl36d+fLugQ92DguWTV3YA84whYFpQ+U6j3nOdmO3BK
         cP/Z4I7S3oLFKjb/3hLpSdbKzoepClPuTdxyWcevzldtf8ABHnRQ8FTGQjv7kfST1Ohc
         g8KPl62t98Bio86DCUvXuY/u7l7slMCbSYFpc5LqXK5R9QivoXV5WpTNJgyWbETvDROX
         UsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792997464; x=1793602264;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=63gX4GVlfNF6cXXZiGFc57UUZdEDSiFDHRSUW+70Tqk=;
        b=i+BH78+HUasQljo9SXywuMWlXB0z9r+OzZvTX5gEFXZhagDd8dzlwYNZ0NRax8R2dP
         qKKSNNfibQFfFb9d4nNF/MKz/5kX3jGNCj+ZLSfLRvrxBrSuBg68JddrK77GHuqDNaM4
         V8aZL6xuhLtXtCNha5iyvxoisQr1+0kMKROnuOMDxNFdIxotNX5Kby48TQUr39LOM6XC
         J0HKxUehmhbe7oeZi7RsJCmCEZj2yNMFdeIiHXsNDQUzIfbUHczHQXhAXGneQCDjxOw8
         dKgro/+X/rd0ANEj/pwOylRC/TIj4GgiVxqhLT7k+fOGwbkVIynWfgMJk1NAkTAhcoy4
         nL5Q==
X-Forwarded-Encrypted: i=1; AKwUvBwOxdVFPiPsQh7Wc6TUvBsyH9GzUPwdBszu1NuFAEUqQRdLTK31g0Pc6AwTaZoT1+jb4y/XeChxnLqaifdqpw0j@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/fblpzIgk0iavptLnm0SHkxC2QBvM0003pxuge4QHh8WmOC8J
	9yucNgZDanoka9M35WGOdvOyjxvntg/bIpIphU1MPCovkdm3VTjxktoZsjEzTTytejgxuD6fRtz
	QYgOIIfXX5w==
X-Received: from dled2-n1.prod.google.com ([2002:a05:701b:42c2:10b0:196:1ea7:17b6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b04f:b0:181:8948:f01f
 with SMTP id a92af1059eb24-19937309c99mr8536331c88.36.1792997463572; Sun, 25
 Oct 2026 23:51:03 -0700 (PDT)
Date: Sun, 25 Oct 2026 23:50:42 -0700
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <cover.1792995775.git.irogers@google.com>
Subject: [PATCH 0/3] perf: Fix libdw addr2line fallback, pr_debugN overhead,
 and cumulative hist decay
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alireza Haghdoost <haghdoost@uber.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alessio Podda <aleph.pi.gh@gmail.com>, Michael Liang <mliang@purestorage.com>, 
	Shimin Guo <shimin.guo@skydio.com>, Tanushree Shah <tshah@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Three standalone fixes found while profiling `perf top` and DSO symbol/DWARF
resolution:

1. **perf libdw: Optimize fallback logic for missing DWARF**:
   `libdw__addr2line()` previously returned `-1` when `dwfl_module_getdwarf()`
   or `dwfl_module_getsrc()` returned `NULL`, while `addr2line()` in
   `srcline.c` only stopped its fallback loop on `ret > 0`. This caused
   `perf` to fall back through `llvm`, `libbfd`, and the external
   `addr2line` subprocess on every stripped DSO or unmapped address, and
   kept the `Dwfl` ELF mmap open on stripped binaries. Standardize backend
   return values so `0` denotes conclusively missing DWARF/line info
   (stopping the fallback loop and freeing the `Dwfl` session when no
   DWARF exists), `< 0` denotes backend/initialization error, and `> 0`
   denotes resolved source line info.
   An earlier version of this patch was posted at:
   https://lore.kernel.org/linux-perf-users/20260824062841.1529489-3-irogers@google.com/
   This version addresses the review feedback from that thread.

2. **perf debug: Avoid calling eprintf() in pr_debugN() when verbose < n**:
   `pr_debugN()` unconditionally evaluated its arguments and called
   `eprintf()` -> `veprintf()` before checking `verbose >= n`, accounting
   for ~15% of total CPU time in `perf top` during ELF symbol loading even
   at default `verbose == 0`. Guard `eprintf()` with `unlikely(verbose >= (n))`.

3. **perf hist: Do not delete cumulative caller entries before stat_acc decays**:
   When `symbol_conf.cumulate_callchain` is enabled (`perf top -g`),
   callchain caller entries with `he->stat.period == 0` were deleted on the
   first `hists__decay_entries()` pass even while `he->stat_acc->period > 0`.
   Require `he->stat_acc->period == 0` before deleting entries in
   cumulative mode.

Assisted-by: Antigravity:gemini-3.1-pro

Ian Rogers (3):
  perf libdw: Optimize fallback logic for missing DWARF
  perf debug: Avoid calling eprintf() in pr_debugN() when verbose < n
  perf hist: Do not delete cumulative caller entries before stat_acc
    decays

 tools/perf/tests/pmu-events.c      |  5 ++-
 tools/perf/util/addr2line.c        | 28 ++++++++++---
 tools/perf/util/debug.h            |  5 +--
 tools/perf/util/dso.h              |  2 +-
 tools/perf/util/hist.c             |  6 ++-
 tools/perf/util/libbfd.c           |  6 +--
 tools/perf/util/libdw.c            | 25 ++++++++---
 tools/perf/util/libdw.h            |  5 ++-
 tools/perf/util/llvm-c-helpers.cpp | 66 +++++++++++++++++++-----------
 tools/perf/util/llvm.c             | 12 ++++--
 tools/perf/util/srcline.c          | 21 +++++++---
 11 files changed, 125 insertions(+), 56 deletions(-)

-- 
2.56.0.307.g5fe7bd680c-goog

