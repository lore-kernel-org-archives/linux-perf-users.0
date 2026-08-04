Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24C94399E2;
	Tue,  4 Aug 2026 18:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869919; cv=none; b=NpvcnFO9WMD5nziuT4gBAnbzEObjwWgne0I7GG6NoUr4+UyMMa2Inbifu9pDNRv9eET0JKXlQXx6GcDK21iM/wje5D30+D9hqnclVp8oZmuTV0JLDOrvmGhsXYhm6MEMDA6EbxoNryKBMZvuB3AtAABmXL+4BvpbWV6Mtd9ME4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869919; c=relaxed/simple;
	bh=Mtilgw9XltsGkitoSMhYBfZX90qNZcgzJ/0NUG/7kCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OHW5r+mDVB036vMASSJUYjLvrUZTguhLmbwPXJhfJR3YSgl7tvmS23j5DqKVL24p2BbUMFAMBCaoPpV9GTfY1hykP/fvnVt6FKeVaGVC7fwww0vciT3oF5UL4k+ItgMBpSb7V1aSlh5+GGUUQPN/Gmu+nrDh+i/ZXQ+2Yjm9MhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohH24SLw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohH24SLw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD781F000E9;
	Tue,  4 Aug 2026 18:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785869918;
	bh=HdhZgtFPRsRML7NhR9NFapjBEdBx3GMjNZ+f5hhcv84=;
	h=From:To:Cc:Subject:Date;
	b=ohH24SLwu2Dv6Km5IBlc40Bwz1f9682Pc9hjOeYdr8N3JVeXt4zqtyOTdY7CvbXTf
	 W0Sx9VfoIu9jhZ1WXggoT713/f/OeKcYKprzcJoM+0QEmzJbn3FQJquvt0hyOswcIe
	 nttqE3c9UxRa0B96BKRhjRHLS3aTxder7LgsiUb99RQELWGKa63IlwAH8fIWL4FKKt
	 eVf26+os7xWNVfHB87bPADreNZwGSOI8L7x8114cfia8SN5gvspI51qcQcBLmTRdy4
	 Dq3GG9/bul4q9lpdZys56nHHNJ1Gy13jHorQmikUJOwssnUR9F14mkTHpcBwJpoYFC
	 q2VO9W99JT25Q==
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
Subject: [PATCHES v7 0/2] perf c2c hardening
Date: Tue,  4 Aug 2026 15:58:28 -0300
Message-ID: <20260804185830.228763-1-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Fixes for 'perf c2c' found by the sashiko-bot and
Opencode:mimo-v2.5-free AI reviewers, both using Chris Mason's
review-prompts:

Patch 1 fixes three silent failure modes in hpp_list__parse().

Patch 2 fixes a format list leak: when c2c_hists__[re]init() fails
partway through, entries registered via perf_hpp_list__column_register()
and perf_hpp_list__register_sort_field() are left on the hpp_list.

Please consider merging,

- Arnaldo

Changes since v6:

- c2c_hists__reinit() has the same leak: it clears the list then calls
  hpp_list__parse(), which can register formats before failing, and
  neither the function nor its callers clean up on failure.  Add the same
  cleanup-on-failure pattern to close this gap.

Changes since v5:

- The second v5 patch didn't got thru, resending the same contents as v5.

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

This series was developed with AI assistance (Claude:Sonnet 4.6,
Opencode:mimo-v2.5-free).


Arnaldo Carvalho de Melo (2):
  perf c2c: Fix error masking, OOM, and unchecked caller errors in
    hpp_list__parse()
  perf c2c: Clean up registered formats on c2c_hists__init() and
    c2c_hists__reinit() failure

 tools/perf/builtin-c2c.c | 105 +++++++++++++++++++++++++++++----------
 tools/perf/util/sort.c   |  38 ++++++++------
 2 files changed, 100 insertions(+), 43 deletions(-)

-- 
2.55.0

