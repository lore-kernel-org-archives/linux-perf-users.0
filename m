Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3755411F90;
	Mon,  3 Aug 2026 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768097; cv=none; b=kIgSiV462/fxTgx85WWzE9EQfs5E9bSDm4DqxH22yIJlNPP9y9vZrV/OVYoY3tRI68Fhce0wgsJmjBZHtHCvdm5fVgESin7SYTo5WQcnpv1/qFyt2SQKTzeilBl1jsNS5PkZKuibaviYaHKIv8A+XL+FDZbUsSRWBQIgKaRLmvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768097; c=relaxed/simple;
	bh=vc7gYcdQFEDn9ci+qu5/hW3QGRgUfqx+10xZ0dUcGR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lq0eHveSsfrfmFYHGZ2l6SQ6agBETZ1mCXrgt1stIVwRBlMf9GPJvRXbhE1M453wycE5jprB4PfLsTRct0WeQdahu30ZAZSaaVnnQs7focFCXGwIzD3P66UvhHJrOBO/ZAKdDKQNYhMzZUwH+fAgnmll/GNhGKZADUUp6UMh+pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLUjTVCU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLUjTVCU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447881F000E9;
	Mon,  3 Aug 2026 14:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768095;
	bh=JneKdVxKIq96qq+YAV4TqJWfzFUQ3GGGhSKlPDmyp+k=;
	h=From:To:Cc:Subject:Date;
	b=jLUjTVCUX/ys7JiSyAdXL0M5n+CT0yL50z2uIoXR29ZTlImQmXXeqPtGwmdwWcqgd
	 MaRyX0xi9X41CZb80ShggCIsshPMe7LjzIyiaRjOGJEWssCI4s3eMJbjNDcBz4OERL
	 5WmwmP+jcS5JtDg03gvbsCwmIDj6p8sXLODJUJEiBDSejaYY1UzQBHb/C7TnEJBdH+
	 p1b3v640sTfmMWEOiUgt2LXbsZraHAhgRgaBSdImke0JEJM8jTU944AQzxnpkeAKUa
	 leBmbqfHYZYLJwRRc62NN7Z2Lbuf4JSlh7KwyjTLo6cQFZmcjkoS/JJ24bfZKbiQSL
	 C9av7Jw2RN8IQ==
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
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCHES v4 0/2] perf c2c hardening
Date: Mon,  3 Aug 2026 11:41:17 -0300
Message-ID: <20260803144119.185637-1-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Fixes for 'perf c2c' found by the sashiko-bot AI reviewer.

Patch 1 fixes three silent failure modes in hpp_list__parse().

Patch 2 fixes a format list leak: when c2c_hists__init() fails partway
through, entries registered via perf_hpp_list__column_register() and
perf_hpp_list__register_sort_field() are left on the hpp_list.

Please consider merging,

- Arnaldo

Changes since v3:

 - Use 'goto out' to break out from both the switch and the for loop in
   __hpp_list__parse() as noticed by sashiko.

Changes since v2:

  - Added the string.h and stdlib.h missing headers.
  - Addressed sashiko comment on PARSE_LIST, turning it into a function
    and handling all errors returned from _fn().

Changes since v1:

  - Addressed sashiko-bot [Medium] finding: the early exits added by v1
    skip perf_hpp__setup_output_field().
  - Dismissed sashiko-bot [Low] finding (missing string.h/stdlib.h):
    strdup() and free() were already used in this function before this
    patch; string2.h (included at the top of the file) pulls in string.h.
    No new library calls were introduced.
  - Subject updated to reflect the additional caller fixes.

This series was developed with AI assistance (Claude Sonnet 4.6).


Arnaldo Carvalho de Melo (2):
  perf c2c: Fix error masking, OOM, and unchecked caller errors in
    hpp_list__parse()
  perf c2c: Clean up registered formats on c2c_hists__init() failure

 tools/perf/builtin-c2c.c | 90 ++++++++++++++++++++++++++++------------
 tools/perf/util/sort.c   | 38 ++++++++++-------
 2 files changed, 86 insertions(+), 42 deletions(-)

-- 
2.55.0

