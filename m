Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0DB433044;
	Mon,  3 Aug 2026 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780444; cv=none; b=DJh1iUD/PJNM3I5Xya3RdPD1E1dZ+GNYpMhAE0IEXe00/vJJVwM8k8U7Bl/eNyYVI+FOvN7ZQeMA51P118M+g3mpMGaSx/zpt1rptzb3ZK01enRoFKecZXW7h0i1itXAIXk0/nSiy17J55CSdjIxV+lLsAloOaW0x95XdSQ5ozA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780444; c=relaxed/simple;
	bh=yUaHreOL7MghWvSbOCAeopP3WUIm3Dc8c6TLoDh1Qnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gan0rHGFPtMYpvuX6IugjBYyy9CcND0mqVUYR5bMYB9JKW9Pp6M80mkmVhVtEgrI5dRhviaCz6kG34iviUEZhvd3/4DzBQn/EAxw1SDT/L7TGe4/ZWnlHFzjfB5p/2t/waU+HjeyhQ/hT5BMeg/jtxrX8Ib0Yg1FesGhuYuOxAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxOJGcna; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxOJGcna"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0024A1F00A3A;
	Mon,  3 Aug 2026 18:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785780443;
	bh=oL1cR4cZ4Zt7DRrb5A7ev3rJUqcF7B8ndx/3s4eDM7M=;
	h=From:To:Cc:Subject:Date;
	b=PxOJGcna41jHOyMF2oFxm0U8cGZM9MuIF4UgGmO+Kvkef+PDJFq9tKwaYxYyq2gdG
	 HMJ9qVtEpJ9yKT55l2XmMbLYBBtelWyWEhIUonlKJ2vBl4bh9JdReDLPdCa95Q0B8O
	 +RQWqXFBGuNd+x0q1fdTdEJ02I9Lk/ksfhtrU0DK7eK4bTbK7fkIKmgGC5M+OTINVW
	 0PFeZfY3+x9Qlrn87iZSgZ1UB3lY3WhuMJ6XUeolCPGOq5+ZxGcQsMiEiyCEN6+6Hg
	 MP1Dux1aV+0lE+ZE0ncPt9Kuizh8wcCBWjQaNj334u3k9SrqxtrsfY+NbAcuZX79Xl
	 cSJaCiv91TfXQ==
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
Subject: [PATCHES v6 0/2] perf c2c hardening
Date: Mon,  3 Aug 2026 15:07:01 -0300
Message-ID: <20260803180703.194916-1-acme@kernel.org>
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

