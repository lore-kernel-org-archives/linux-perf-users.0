Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8000B317153;
	Tue,  9 Jun 2026 01:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780967176; cv=none; b=XW21stT6lxZeaz9sVbwFTRsE0D6dN0ZtbhPniHhDjVK0q+PimwUXw+DSk6C8b65oDUCYKzKhw6xxFJf3Sa3kThfbYyJTUmMZm+ClzkisRacQIDKuyKrsh4QS45PGxRoxRp5pDFKNkO5pA4sOu8QeoRTL2IRuVL+DMZR0t5oWtnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780967176; c=relaxed/simple;
	bh=whP9jx6KDB4/4o+dk2mUw7td7rlHM3I1owTU6AcY++Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BCx/wwLHJRWOUra7FcCp6fQ+UKctKpVNO6+PlTWqqR7DrASHjCKeI0tfekjozWtQR6sQkWXZB09lxQKjycRgRJSFFCi3ZvCAKTYXqjywkZK7uRHubpVkfRATwpHSoUHU9ZVxp95yIP41VTLO53x7eRiOJ5nMptTvosW8rDh/ltI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1JPDveD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1JPDveD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24491F00893;
	Tue,  9 Jun 2026 01:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780967174;
	bh=TyfKr8lVqchVJszhm+AWCn41Ltfy4bgQtnnQFKxtpF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X1JPDveDNc7Bz6itezO8Ml20k7+xovD5PRDyxbdjvBUtxCewtvaGaqxc+FZqHEePn
	 KlUiZ0xU6Rs+xXsa/zkKmLTPCO1NPTIIYsUw8rmI0+bx35PGNx/C0Xz1MMiAuiXxjx
	 H1m4s/aKrEAtRD4a+WbZmhXrijY+/3HGFcS9PGrAaIFmEZS40EgYIUCSGXQRXh98kr
	 3ayqXSooNldelutEN0LObOcn0GacBku/s/zDryWyR/Z9SBjv3ykgkLbyh2gB01urGX
	 wygWDnDou1WqmS05gJbLzeYsrswSIyQfgXQhP989SUS/UiOcpIqImHmzILEXw83+8R
	 37yBDA4gGyWpg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 11/11] libperf: Document code simplification case for widening struct perf_cpu
Date: Mon,  8 Jun 2026 22:05:25 -0300
Message-ID: <20260609010526.1998472-12-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609010526.1998472-1-acme@kernel.org>
References: <20260609010526.1998472-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add a bullet point to the libperf ABI TODO explaining the code
simplification benefit of widening struct perf_cpu.cpu from int16_t
to int: the narrow type forces defensive truncation checks at every
boundary where wider CPU indices are narrowed, and values > 32767
silently wrap to negative numbers (two's complement), bypassing
bounds validation without them.

Cc: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/perf/TODO | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/lib/perf/TODO b/tools/lib/perf/TODO
index 486dd95dc57208a8..e179728697d8c7c0 100644
--- a/tools/lib/perf/TODO
+++ b/tools/lib/perf/TODO
@@ -11,6 +11,14 @@ together.
      (x86_64 max is 8192, arm64 is 4096), but NR_CPUS limits keep
      growing.  perf clamps to INT16_MAX in set_max_cpu_num() as a
      safety net.
+   - Code simplification: the int16_t forces defensive truncation
+     checks at every boundary where a wider CPU index (int from
+     sample->cpu, al->cpu, etc.) is narrowed into struct perf_cpu.
+     Without these checks, values > 32767 silently wrap to negative
+     numbers (two's complement), bypassing bounds validation.
+     Widening to int eliminates this entire class of silent
+     truncation bugs and removes the need for the INT16_MAX clamp
+     in set_max_cpu_num().
    - Scope: struct perf_cpu is embedded everywhere — perf_cpu_map__cpu(),
      perf_cpu_map__min(), perf_cpu_map__max(), perf_cpu_map__has(), the
      for_each_cpu macros, and all internal callers.  The perf_cpu_map
-- 
2.54.0

