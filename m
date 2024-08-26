Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E7019D074;
	Mon, 26 Aug 2024 22:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724710248; cv=none; b=SP+KSmNs6iG7M7qW5rbReB0/jUSGhtQ2IySl+unVBUBN4Pc2v3qmk2N1b9b4W1mSWMi8+fzJQcHMgJjeNJKdCW+olj49iuuDOuTFXjwHsDcJaOWBLmhx1nyDxL3+ht0UgngrwZgOk86sRxBpAgfX/KKAmfzCmgw9EJHU77hSlt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724710248; c=relaxed/simple;
	bh=eg+RpaI+kxukrhpWwDABFKaS8hD7evFQFlWQc7pH2CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSixNEyPZzhH0V5QOaShZHEYmhs5Iapxh1/N8bOf54T3MbfWtDC56t0OPJITs7iLfXpzxsef7j0h2oX6aQuxA8NOOOhxyaKEs4pXC1P16siLorBwSpV9SMvgav2yzssPmzWhbF2YYY8Joeolf4Q4GYNPVuZny1aJnZwLYzQLKZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcfsNLUh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcfsNLUh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E749C8B7C6;
	Mon, 26 Aug 2024 22:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724710247;
	bh=eg+RpaI+kxukrhpWwDABFKaS8hD7evFQFlWQc7pH2CE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OcfsNLUhDEEjvOhm4td22x9YiGv9VIgRBmVFRLr/Ge5m93hFZOZCVXx2Sm/Iei4VD
	 x588O+xBt/ngYnqXvnTF93ZIeM3D4StFpfJNTF2NokDlVqchub/h+Ktq30pN1msony
	 ySqvvAKwF/GUIJU2HxWzmru2zWOoeKgcVGRiOl8yV2hHQhj/bledJsZCdN+GUky+gh
	 Md4b/hM5+r5o6rI70oWTSdH29bLMGTs55iXd6BuIvIKBVAG6hYvoYszcq5OjtwIQeu
	 t2jPfct1EVEYGnSbjQYjHBDonSxQUuovbatsTkBhbV6Qx2TLwBIfFd+aP87JgGZEnH
	 9+rBsmleiXVXA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>,
	Matt Fleming <matt@readmodwrite.com>
Subject: [PATCH 1/4] perf report: Fix segfault when 'sym' sort key is not used
Date: Mon, 26 Aug 2024 15:10:42 -0700
Message-ID: <20240826221045.1202305-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
In-Reply-To: <20240826221045.1202305-1-namhyung@kernel.org>
References: <20240826221045.1202305-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fields in the hist_entry are filled on-demand which means they only
have meaningful values when relevant sort keys are used.  So if neither
of 'dso' nor 'sym' sort keys are used, the map/symbols in the hist entry
can be garbage.  So it shouldn't access it unconditionally.

I got a segfault, when I wanted to see cgroup profiles.

  $ sudo perf record -a --all-cgroups --synth=cgroup true

  $ sudo perf report -s cgroup

  Program received signal SIGSEGV, Segmentation fault.
  0x00005555557a8d90 in map__dso (map=0x0) at util/map.h:48
  48		return RC_CHK_ACCESS(map)->dso;
  (gdb) bt
  #0  0x00005555557a8d90 in map__dso (map=0x0) at util/map.h:48
  #1  0x00005555557aa39b in map__load (map=0x0) at util/map.c:344
  #2  0x00005555557aa592 in map__find_symbol (map=0x0, addr=140736115941088) at util/map.c:385
  #3  0x00005555557ef000 in hists__findnew_entry (hists=0x555556039d60, entry=0x7fffffffa4c0, al=0x7fffffffa8c0, sample_self=true)
      at util/hist.c:644
  #4  0x00005555557ef61c in __hists__add_entry (hists=0x555556039d60, al=0x7fffffffa8c0, sym_parent=0x0, bi=0x0, mi=0x0, ki=0x0,
      block_info=0x0, sample=0x7fffffffaa90, sample_self=true, ops=0x0) at util/hist.c:761
  #5  0x00005555557ef71f in hists__add_entry (hists=0x555556039d60, al=0x7fffffffa8c0, sym_parent=0x0, bi=0x0, mi=0x0, ki=0x0,
      sample=0x7fffffffaa90, sample_self=true) at util/hist.c:779
  #6  0x00005555557f00fb in iter_add_single_normal_entry (iter=0x7fffffffa900, al=0x7fffffffa8c0) at util/hist.c:1015
  #7  0x00005555557f09a7 in hist_entry_iter__add (iter=0x7fffffffa900, al=0x7fffffffa8c0, max_stack_depth=127, arg=0x7fffffffbce0)
      at util/hist.c:1260
  #8  0x00005555555ba7ce in process_sample_event (tool=0x7fffffffbce0, event=0x7ffff7c14128, sample=0x7fffffffaa90, evsel=0x555556039ad0,
      machine=0x5555560388e8) at builtin-report.c:334
  #9  0x00005555557b30c8 in evlist__deliver_sample (evlist=0x555556039010, tool=0x7fffffffbce0, event=0x7ffff7c14128,
      sample=0x7fffffffaa90, evsel=0x555556039ad0, machine=0x5555560388e8) at util/session.c:1232
  #10 0x00005555557b32bc in machines__deliver_event (machines=0x5555560388e8, evlist=0x555556039010, event=0x7ffff7c14128,
      sample=0x7fffffffaa90, tool=0x7fffffffbce0, file_offset=110888, file_path=0x555556038ff0 "perf.data") at util/session.c:1271
  #11 0x00005555557b3848 in perf_session__deliver_event (session=0x5555560386d0, event=0x7ffff7c14128, tool=0x7fffffffbce0,
      file_offset=110888, file_path=0x555556038ff0 "perf.data") at util/session.c:1354
  #12 0x00005555557affaf in ordered_events__deliver_event (oe=0x555556038e60, event=0x555556135aa0) at util/session.c:132
  #13 0x00005555557bb605 in do_flush (oe=0x555556038e60, show_progress=false) at util/ordered-events.c:245
  #14 0x00005555557bb95c in __ordered_events__flush (oe=0x555556038e60, how=OE_FLUSH__ROUND, timestamp=0) at util/ordered-events.c:324
  #15 0x00005555557bba46 in ordered_events__flush (oe=0x555556038e60, how=OE_FLUSH__ROUND) at util/ordered-events.c:342
  #16 0x00005555557b1b3b in perf_event__process_finished_round (tool=0x7fffffffbce0, event=0x7ffff7c15bb8, oe=0x555556038e60)
      at util/session.c:780
  #17 0x00005555557b3b27 in perf_session__process_user_event (session=0x5555560386d0, event=0x7ffff7c15bb8, file_offset=117688,
      file_path=0x555556038ff0 "perf.data") at util/session.c:1406

As you can see the entry->ms.map was NULL even if he->ms.map has a
value.  This is because 'sym' sort key is not given, so it cannot assume
whether he->ms.sym and entry->ms.sym is the same.  I only checked the
'sym' sort key here as it implies 'dso' behavior (so maps are the same).

Fixes: ac01c8c42465 ("perf hist: Update hist symbol when updating maps")
Cc: Matt Fleming <matt@readmodwrite.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index dadce2889e52..f387e85a0087 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -638,7 +638,7 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 			 * mis-adjust symbol addresses when computing
 			 * the history counter to increment.
 			 */
-			if (he->ms.map != entry->ms.map) {
+			if (hists__has(hists, sym) && he->ms.map != entry->ms.map) {
 				if (he->ms.sym) {
 					u64 addr = he->ms.sym->start;
 					he->ms.sym = map__find_symbol(entry->ms.map, addr);
-- 
2.46.0.295.g3b9ea8a38a-goog

