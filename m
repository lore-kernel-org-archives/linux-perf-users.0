Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4C319C54E;
	Mon,  3 Aug 2026 01:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785719508; cv=none; b=FlDroWlWFd/FSoRxkYp+dTYqakSjqDr7/Sk+r3Vq4QwfPjsNRfB2sWXW3nMNwzZ1gSWpCjXkVFJ+kDokoQQiDzHbNaMRDccwfIJqwd9u4J+NirlKNpeffHorza8tYLPNT0iR11+/c/YGMwB2hpwKMSRGB0OcfvaEUg4GqIarcqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785719508; c=relaxed/simple;
	bh=8UtL6XGi7ltbCRdQjDxvcDKPnO0qrR5uCFF1vZLIofs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dwq0MWUG7z4JKmwMfQGRYdyi+91LLH72TrINXAZBTwkRzJesCOD3283H+mzQpqAYoXPJuC7qVcBm/7imNH/TeiMFny53gKPBEDSjnAZrkxIOZrB+MjJyLOmWjVZueH4pInjVJF21laKaVDd2vutp0Qjtd8NrAsu+Oh5z1ggz2ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbzieGWX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbzieGWX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DDF1F000E9;
	Mon,  3 Aug 2026 01:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785719507;
	bh=li5yfy9YaLQklyfVKZmjk+Fi5NuY5tY34V6+xUikyRM=;
	h=From:To:Cc:Subject:Date;
	b=dbzieGWX+HJgo5LTf5/D/W87pNs7HQAuTyeDhohJgQ0qkxGIlt4nn5N5LdImD5mVT
	 qtXDd8OFEr8jxik9S2ULU22dCdK8c/ZN4f0CrJ75hnw99DT2WrmWncPZfY0pVRl2BX
	 8k7tKBqIjkb6H0lJuWloCM9tJOX8p5gQbqFzVCh8YworgjxDeYtvr4eg1IVxyMxtaq
	 jCbH4mnY7DHwSClGLBiF1XhpNj8T5M45TRi+447WVvLy8jW/JrfugNOdFaLq7Jgpl5
	 DU6DnYLoZIEuwfSByaQeKqPC17UeY6LIj/LKkOXRk8AH1KKg31cbEvxI8xS0fy2/XB
	 6jsCwl0VDanaA==
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
Subject: [PATCHES v2 0/2] perf c2c hardening
Date: Sun,  2 Aug 2026 22:11:38 -0300
Message-ID: <20260803011140.179943-1-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

        Please consider merging,

Two hardening fixes for perf c2c found by the sashiko-bot AI reviewer.

Patch 1 fixes two silent failure modes in hpp_list__parse(): error masking
across successive PARSE_LIST invocations, and OOM from strdup() being
silently treated as empty input.  The fix adds early exits, which exposed
a pre-existing problem: both callers of c2c_hists__reinit() had always
discarded its return value, so errors would now go undetected.  Patch 1
also fixes the full caller chain: resort_cl_cb() now checks and propagates
the error, and perf_c2c__report() checks both c2c_hists__reinit() and
hists__iterate_cb() -- which already stops iteration on callback errors.

Patch 2 fixes a format list leak: when c2c_hists__init() fails partway
through, entries registered via perf_hpp_list__column_register() and
perf_hpp_list__register_sort_field() are left on the hpp_list.
perf_c2c_report() does not call perf_hpp__reset_output_field() on the
error path, so those entries leak.  The fix moves cleanup into
c2c_hists__init() itself so all callers are protected.

Changes since v1 (20260802142313.154514-1-acme@kernel.org):

  Patch 1:
  - Addressed sashiko-bot [Medium] finding: the early exits added by v1
    skip perf_hpp__setup_output_field(), making undetected errors in the
    callers consequential.  Fixed by propagating the error through
    resort_cl_cb() and perf_c2c__report() (hists__iterate_cb() already
    propagated callback return values).
  - Dismissed sashiko-bot [Low] finding (missing string.h/stdlib.h):
    strdup() and free() were already used in this function before this
    patch; string2.h (included at the top of the file) pulls in string.h.
    No new library calls were introduced.
  - Subject updated to reflect the additional caller fixes.

This series was developed with AI assistance (Claude Sonnet 4.6).

- Arnaldo


Arnaldo Carvalho de Melo (2):
  perf c2c: Fix error masking, OOM, and unchecked caller errors in
    hpp_list__parse()
  perf c2c: Clean up registered formats on c2c_hists__init() failure

 tools/perf/builtin-c2c.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

-- 
2.55.0

