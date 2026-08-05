Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7613F346E7A;
	Wed,  5 Aug 2026 15:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785942655; cv=none; b=YOQdVvzXxS49FC16hVnMBQI7XgC1T1tI9Ssi3gxVvLnywW8l996EbQfIxEKjnR6g37Pvp1ccgpB9GrX/va8h7Xn+lvGwiTBnYi9GOzY2JLDmFaE4hKzt+RFUazjFScJV0IVp4GL7BZ9phtWxgC4rmuDxri7u975tO+K9i/0EAQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785942655; c=relaxed/simple;
	bh=M9KHj0L9UaKIIXEc9iMRpFt2TdGgPZ1PVvRWNOOStF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TFxelcBsAFizaXjQZrUtrrZhODS30a54aphxS7HW+5Q3AfYDYbYbjO0umInR9qZbHvKKHfjJpYTaYgLsv6IQ6EGM2aKsY0uTtVug+x7Kp/nTZr0Dg5YWfkalO4BjxDOsYgeZW4P2tHkhKZtEi7zagPstb9Sq3glP+rcga65hDGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXuq4OZM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXuq4OZM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6951F000E9;
	Wed,  5 Aug 2026 15:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785942654;
	bh=YLqfv2DFRgn0h7UBoehVIqPvT6aLt+n5JZhabuIEJG4=;
	h=From:To:Cc:Subject:Date;
	b=mXuq4OZM9Nmd/Eafcszj5BWGcN/iaTU3Gd1ipmj/BT952HjiaRAJA85fSUIQ2EHTY
	 bKfkcq99ikDfhmy5MwSGrJYYooH9qUK4sFQ8syNPp0H7p476sZOnstdYdNUFnmQC2v
	 XuVctPW/qZJ8sYqR+Nn9DGaaOkRwvkqowZDqxJkiFy3ipCJT8tdHG4pq2+yY1qO03e
	 hcIbfZn33ofTT78SgeCvO+YLngWOeu0A9OgrNKMQBDumLX8d87qsJUgzPuPq2at3dy
	 sx1nLbW337G8E3E5x0GVipIut9KAfZx9OlkE9CvY2MO0ycu3tvJjlfTiFWLcbg0Mur
	 08HTlw0b2gErA==
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
Subject: [PATCHES v8 0/2] perf c2c hardening
Date: Wed,  5 Aug 2026 12:10:41 -0300
Message-ID: <20260805151043.237233-1-acme@kernel.org>
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

Patch 1 fixes error masking, OOM, and unchecked caller errors in
hpp_list__parse(): the strdup() return values are now checked, PARSE_LIST
was turned into a function that bails out on any error returned by the
parsing callbacks (including -ENOMEM), and the two callers bailing out
with the newly propagated errors, setup_sort_list() and
setup_output_list(), now break out of their token loops and propagate the
error instead of silently overwriting it on the next iteration.

Patch 2 fixes a format list leak: when c2c_hists__[re]init() fails
partway through, entries registered via perf_hpp_list__column_register()
and perf_hpp_list__register_sort_field() are left on the hpp_list.  The
fix moves cleanup into c2c_hists__init()/c2c_hists__reinit() themselves
so all callers are protected.

This series was developed with AI assistance (Claude:Sonnet 4.6 and
Opencode:mimo-v2.5-free for the changes up to v7; the changes since v7,
including the setup_sort_list()/setup_output_list() -ENOMEM propagation
fix and the c2c_hists__reinit() cleanup amendment, with
Opencode:DeepSeek-V4-Flash-free).

- Arnaldo

Changes since v7 (20260804185830.228763-1-acme@kernel.org):

  Patch 1:
  - Addressed sashiko-bot [Medium] finding: with sort_dimension__add()
    and output_field_add() now propagating -ENOMEM (and other errors),
    the callers setup_sort_list() and setup_output_list() only checked
    for -EINVAL and -ESRCH, so an allocation failure was silently
    overwritten when the next loop iteration ran.  Both callers now break
    out of their token loops on any error and propagate it.

Changes since v6 (20260803180703.194916-1-acme@kernel.org):

  Patch 2:
  - c2c_hists__reinit() has the same leak: it clears the list then calls
    hpp_list__parse(), which can register formats before failing, and
    neither the function nor its callers clean up on failure.  Add the
    same cleanup-on-failure pattern to close this gap.

Changes since v5 (20260803180118.194519-1-acme@kernel.org):

  - The second v5 patch didn't go through, resending the same contents
    as v5.

Changes since v4 (20260803144119.185637-1-acme@kernel.org):

  - Replace %m with str_error_r(-ret) as suggested by sashiko.

Changes since v3 (20260803120452.181273-1-acme@kernel.org):

  - Use 'goto out' to break out from both the switch and the for loop in
    __hpp_list__parse() as noticed by sashiko.

Changes since v2 (20260803011140.179943-1-acme@kernel.org):

  - Added the string.h and stdlib.h missing headers.
  - Addressed sashiko comment on PARSE_LIST, turning it into a function
    and handling all errors returned from _fn().

Changes since v1 (20260802142313.154514-1-acme@kernel.org):

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

Arnaldo Carvalho de Melo (2):
  perf c2c: Fix error masking, OOM, and unchecked caller errors in hpp_list__parse()
  perf c2c: Clean up registered formats on c2c_hists__init() and c2c_hists__reinit() failure

 tools/perf/builtin-c2c.c | 105 ++++++++++++++++++++++++++++++----------
 tools/perf/util/sort.c   |  76 ++++++++++++++++++++++-------
 2 files changed, 130 insertions(+), 52 deletions(-)

---


Arnaldo Carvalho de Melo (2):
  perf c2c: Fix error masking, OOM, and unchecked caller errors in
    hpp_list__parse()
  perf c2c: Clean up registered formats on c2c_hists__init() and
    c2c_hists__reinit() failure

 tools/perf/builtin-c2c.c | 106 ++++++++++++++++++++++++++++-----------
 tools/perf/util/sort.c   |  76 +++++++++++++++++++---------
 2 files changed, 130 insertions(+), 52 deletions(-)

-- 
2.55.0

