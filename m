Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13C139F17F;
	Fri,  4 Sep 2026 14:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532870; cv=none; b=XZwxWYdwr1ttUz5/l0r1vvE8XC7uTEZ5SolbSmNkLu2jxQFxThORnsc6uekT6xuLguQnilTKkewRjC3SsH19cUyTUEV0ve+8JA+uibORjYOEzLxXQWwiygdMdlzC+AKUoOzZ2KyrsuUgGqw4VOO2zvljxwBZDQ5Mho9bYbLHknA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532870; c=relaxed/simple;
	bh=IDug8sq5AgYXtkMPYu0ttG9wU4RErryIqhBDWcQ4uo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VNy96/mrYWo3+Zg2rhseh5udRAWADO4s/OqoLi0k3+oY0neYEvHG2n+IZKpomCRIw95cf+mkfou2nFTpTA+CWGGzE8m9YgOv75Bhp/RGnRq/XM+jFjxYwhuCGAV0XFGNJZTevt2yGYkSo1+7VlSseT955Cd9akJC+EKbu7Pruw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeHWzI4S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeHWzI4S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F671F00A3D;
	Fri,  4 Sep 2026 14:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788532868;
	bh=Yckpavg65K5uR+Qj7vN9PcWBVj1XJ2qAo/S1hdmVLiU=;
	h=From:To:Cc:Subject:Date;
	b=WeHWzI4S0vhp6Dvhk0mFV/5zS5yiBMsCSMiZ3EvAyRH84qvRtLrsQTE+fmBJlHJgh
	 fN+n12wJvq74jTD2JxGeCgS3PLTi/oEd381eYfp7dn6Z/K+csGMjepFoL5+qAyCQqo
	 cBfn96Woy+Q//VfE5s2fc0qFEIs7tqU/ZuPDqEaofIpKIjLhLAPSyE7vBBDN+ofQyl
	 nkh9OLJMe+ht4kwTKGxvOeWVM7SfF2Kp8cC2eo7GvRMSygD05+iemhMrwZ3vDtc44N
	 d7RR5CdBSsuq38boDQfA6iRpvYUc9MymTlGj8OoVNz1/ISgeRr29yDe594x73gv5s9
	 BTK7cYlJ+mGFg==
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
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Stephane Eranian <eranian@google.com>,
	Stefano Sanfilippo <ssanfilippo@chromium.org>
Subject: [PATCH v2 0/5] perf jitdump: Fix debug entry access, unwinding state and sample id sizing
Date: Fri,  4 Sep 2026 11:40:52 -0300
Message-ID: <20260904144058.3341-1-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Five fixes for the jitdump/genelf code path, all reported by the
sashiko-bot AI reviewer while reviewing the hardening series that is now
in perf-tools-next:

  - struct debug_entry ends with a variable-length name[], so entries
    after the first start at addresses that are not naturally aligned.

  - jit_repipe_code_load() only released the unwinding state when both
    unwinding_data and eh_frame_hdr_size were set.

  - the sample id area appended to the synthesized mmap2 records was
    cast to a fixed {u32 pid, tid; u64 time;} struct.  That only matches
    what evsel__id_hdr_size() accounts for when PERF_SAMPLE_TID is set
    as well, since the fields are appended in a fixed order skipping the
    ones not requested.  Patch 4 walks the area in that order and patch
    5 sizes the allocation with idr_size instead of a hardcoded +16, so
    that what is written and what is allocated agree.

Patches 1 and 5 are unchanged from v1.

Best regards,

- Arnaldo

What changed from v1 (599fad82626e5eba):

  PATCH 2/5:
  - Kept lineno and last_line signed.  v1 read ent->lineno into an
    unsigned int, so the "lineno - last_line" delta handed to
    emit_advance_lineno() wrapped to a large positive value and, being
    widened to a long, zero-extended instead of sign-extending: a
    backward line jump became a huge forward one, corrupting the DWARF
    line number program [sashiko-bot review of PATCH 2/5].

  PATCH 3/5:
  - Added Reviewed-by: Ian Rogers.

  PATCH 4/5 (new):
  - Walks the sample id area in the order evsel__id_hdr_size() accounts
    for (TID, TIME, ID, STREAM_ID, CPU, IDENTIFIER — 8 bytes each)
    advancing only past the fields whose sample_type bit is set,.

    This is the [Critical] finding from the sashiko-bot review of v1
    PATCH 4/5: with PERF_SAMPLE_TID unset, PERF_SAMPLE_TIME belongs at
    offset 0 and idr_size is 8, so the old code stored it at offset 8 —
    past the end of the allocation, and corrupting what a reader
    expects to find at offset 0 besides.  It is split out from the
    sizing change so that 5/5 no longer removes the slack that was
    masking it, and so that the same latent bug in
    jit_repipe_code_load() — which already sized with idr_size — is
    fixed in the same place.

  PATCH 5/5 (was 4/5):
  - Unchanged, and now safe: 4/5 above keeps the writes inside idr_size.

  DROPPED (was v1 PATCH 5/5):
  - "perf dso: Defer dropping the open list reference until after the
    lock".  Ian Rogers is not a fan of the deferral mechanism and
    suggested instead allocating dso_data separately from the dso, so
    that the lock can be scoped without it.  Dropped from this series
    while that is worked out.

  - The pre-existing issues sashiko-bot raised that are outside the
    scope of this series are recorded in tools/perf/TODO.hardening for
    follow-up work: item 170 (jit_get_next_entry() lacks per-record
    size validation), 171 (jit_process_dump()/jit_inject() swallow
    callback errors), 172 (jit_emit_elf() truncates 64-bit unwinding
    sizes to u32), 173 (jit_emit_elf() opens a predictable filename
    without O_EXCL/O_NOFOLLOW) and 176 (buffer_ext_add() realloc
    failure ignored by all callers).  The two this series does address
    are items 174 and 153, now marked fixed.

  - Rebased onto the current perf-tools-next head (92d50319b4f0c0bb).

Arnaldo Carvalho de Melo (5):
  perf jitdump: Byte-swap debug entries via unaligned-safe accessors
  perf genelf: Use unaligned-safe accessors for debug entries
  perf jitdump: Free unwinding data even when eh_frame_hdr_size is zero
  perf jitdump: Write sample id fields in the order used by
    evsel__id_hdr_size()
  perf jitdump: Size code_move event allocation with idr_size

 tools/perf/util/genelf_debug.c | 28 +++++++-----
 tools/perf/util/jitdump.c      | 84 +++++++++++++++++++++++-----------
 2 files changed, 75 insertions(+), 37 deletions(-)

base-commit: 92d50319b4f0c0bbee8a236a09063272cd22faab
v1-head: 599fad82626e5eba485b4d4d188cbd34c0e12cbc
