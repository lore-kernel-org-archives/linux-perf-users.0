Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAA33A8384;
	Mon,  3 Aug 2026 18:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780098; cv=none; b=pCmJIrZ4V6FeMa2/3vRZ8FhRLBJB17u9uUQQfYH2W93fgJxQAxlvATU5YPP13dSLkAmI/QGC8mqxJI6zHG8c3VmBCWLiYG/de6hrDFHClYYq9LUWThJc7A0bah3LyV1w8lwuodX3t34rhz7r8JK9FKST+czcilwK6nF12DZfnZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780098; c=relaxed/simple;
	bh=hbk8bWcEJNvY+yqDppcMWBbFZL3ihyUhBES1sems6Js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dZKeceAdqHTazpE/E2/chiuN19+LfVpgoFRfCPg1MjUQWyxfjgNbCbohDYXh5xAQBiNpuDGKhI8zxj6kZ48Kz4Qzp7fv5Y+J+d2ZN71Ng7EdW/ndTZpTpAsoQXzheiQ8AX2DpMkVsjJXlWn3E9jIUQ+j4dDMWM5S9pZcmHm/1BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFRY3a1k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFRY3a1k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768961F000E9;
	Mon,  3 Aug 2026 18:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785780097;
	bh=XX2apZ9q9fZXM1fWyYZAij6yjWpj4wE4EhWnX1yDJsQ=;
	h=From:To:Cc:Subject:Date;
	b=HFRY3a1kkKcQplM8LQWjiqFcFR5Bt2A5ORqkgSD594S3ej1v2FrdRa2jwG8KWxhl9
	 aS+4JyRD0pA2VuPKOwyul02csYCxLszz+eAt4Uqz52HN73dP3TPZ9WWmQU1SoXcwN/
	 io8YhTDjG7Ah/3hAmFxRirhzA6uVktZTu0vROdh1jBz/F4JdkqemF2fxlYVKi+Gx3P
	 IUjf2yYNbHYEYebpMjZa422bWkQq+uIXIW9IVZfE3k2Qi7DFE0Qy1moPNBC4lyBdcR
	 PZVdTHpdMQHPvqR1LzDA938w7HMUe1l0jfhbiZ9QOIDsO51CZjVmfsboNSlv+aO7sZ
	 daIWhf3pEYf+g==
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
Subject: [PATCHES v5 0/2] perf c2c hardening
Date: Mon,  3 Aug 2026 15:01:16 -0300
Message-ID: <20260803180118.194519-1-acme@kernel.org>
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

Changes since v4:

- Replace %m with str_error_r(-ret) as suggested by Sashiko.

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

 tools/perf/builtin-c2c.c | 95 +++++++++++++++++++++++++++++-----------
 tools/perf/util/sort.c   | 38 +++++++++-------
 2 files changed, 91 insertions(+), 42 deletions(-)

-- 
2.55.0

