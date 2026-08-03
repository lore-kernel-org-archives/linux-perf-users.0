Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E2A1DFFB;
	Mon,  3 Aug 2026 12:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785758702; cv=none; b=Il+kWrgSm6tjqT463yg3q66FrfyLKB4EKMgj/loeCzLE8zEz0aCaDx6WvQXkTB2s90Ibpw3oqvz5SAtdvtypS8PBVzna0CZNUyYTA4bl3POXXAWJLqaVaNphXzYuQQLVerTe5yv1COoV7PHk5YYVwfEf9yqtzx9wmTew1CiPkD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785758702; c=relaxed/simple;
	bh=J2BFJLTmSZeVVon+FsFpBkszndwoJtsG3uOQxPSR5D8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pEOtfViBL0sRzsgETNPe9JTfdEjQ/j+6mrT3srU0atb9VHKIOiGDRrWVz45AISwu5O2QLliJrREyC78lT3TLTPtaccz50mzJZo7G6bgI8qmePDhOFUQjTw8PDO9ls0OZfxfiT9euWpiCWmpVi4Vz9mu+gObA0TSLVoDed3mir8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nk+U1xuj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nk+U1xuj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FF51F000E9;
	Mon,  3 Aug 2026 12:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785758701;
	bh=qhJdr3r263BIbGygmsZNMGE6hdaNV2jont70udzw8IA=;
	h=From:To:Cc:Subject:Date;
	b=nk+U1xujvEyO2Nuke4FYttiw8cgHQ+WxECjQ77CTTkwgjlAnC/REaw361nqThBXnS
	 GAF5tMXDEg83DF8qlfn9I+fl+ICKLoG5IEdB5WlByQv9gUOdll/qBqDYHu9Nng9TVn
	 C6xOTACzYEF7Jsm/PecdcOlxsUJ0UenyfznNG9WGZ280+PKz4VzIYugbZEdhxxlbaH
	 vHVynB5Pe/FS6HZmRTFzkql6g0l0BR0+gnuvQx/dnKxit+sXbSrNzg9BPCVjSvSRix
	 DOqKg7TY02NsFqzfC88fXliQMu928bhIn3g0rFAUNdMSLjhsAdjSFXtYKSYK5Ogseg
	 R3R3kUzj/tpvA==
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
Subject: [PATCHES v3 0/2] perf c2c hardening
Date: Mon,  3 Aug 2026 09:04:50 -0300
Message-ID: <20260803120452.181273-1-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Fixes for perf c2c found by the sashiko-bot AI reviewer.

Patch 1 fixes three silent failure modes in hpp_list__parse().

Patch 2 fixes a format list leak: when c2c_hists__init() fails partway
through, entries registered via perf_hpp_list__column_register() and
perf_hpp_list__register_sort_field() are left on the hpp_list.

Please consider merging,

- Arnaldo

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

 tools/perf/builtin-c2c.c | 88 ++++++++++++++++++++++++++++------------
 tools/perf/util/sort.c   | 38 +++++++++--------
 2 files changed, 84 insertions(+), 42 deletions(-)

-- 
2.55.0

