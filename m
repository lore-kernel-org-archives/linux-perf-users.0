Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C263D2FEC;
	Mon,  9 Mar 2026 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067316; cv=none; b=lODg89qvvVViwpBvdN8MJR/NUYTEsur/ehwRcuJ4pTY4G/YW0cWQfxw9mmTVAzNNIvLAfrpOu2V6CmwhkO6iOdUQlxBUQ92yh6apZSg6m4IpzNj9qKW7Nzd/qPjT1QYbO6w2+k0AsnRzn/SdNcW7RyMkc43kmop7oER9Xqfm9oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067316; c=relaxed/simple;
	bh=nY0yefsOgV5X12XzKflWqQ4ZP3A/fJd1njRAyfqGdOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FLULvYSDwS6Rnusgo0hQI8hqeWrT4ere4gkHDtDJmGEghZ8G4jzQyPEMBFL0QuiOIrnmWd6TVSWUDRZqEAiUN8fCnJurCOK3up86BqdepwVIt015CdFSb8MPO0dHZoBUg8SqlQqja70Z5I7UJdKdqVDmHDQo6DTPvfJ8XLHF4WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=CvjSunns; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="CvjSunns"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=r8H1HXbZxPVkEnzeYmiqVL1g+zE/V3u0QwhfcvUX2os=; b=CvjSunnsrTIg8kMAr5H+cmyKfd
	lNOQLP7GslfTPU9+jB0Gj4aSYaccfoPL7D2l/fCwGjWkCwUaGpe5tmoeNRM6mttw48oJ+4a7T23wf
	DJuHWBJW17LVgo5FalUc5aGmHELsP8Dfdtx87w8UtrFfCGNu5egrvpQdMnyCBKn0gHFTuAQ+5/a9B
	ZhPxJM4ZynmwskYnegN5jk/y++S4KdXMCHr48RHJnjRwHHZ++Gn70Vyo2QcjJYdX4RMcX8gvGodrc
	qQwlJVfVqp660TQ3H416fSW95FuAAoicgHxqokV1u+UY0z+NK89O3AFIyIrpKjajsRUlVvesoBkUp
	X+91sUDA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vzbne-002HzM-4o; Mon, 09 Mar 2026 14:41:38 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 09 Mar 2026 07:40:56 -0700
Subject: [PATCH] perf/x86: Restore event pointer setup in x86_pmu_start()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-perf-v1-1-601ffb531893@debian.org>
X-B4-Tracking: v=1; b=H4sIAPjbrmkC/6tWKk4tykwtVrJSqFYqSi3LLM7Mz1OyUjDUUVBKz
 kjMS0/VzUxRslJQMjIwMjMwNrDULUgtStNNSzE2Skk0MDY0T7RQ0lFQKihKTcusABsTHQvhF5c
 mZaUml4D0KtXWAgC5UEfraAAAAA==
X-Change-ID: 20260309-perf-fd32da0317a8
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-363b9
X-Developer-Signature: v=1; a=openpgp-sha256; l=4143; i=leitao@debian.org;
 h=from:subject:message-id; bh=nY0yefsOgV5X12XzKflWqQ4ZP3A/fJd1njRAyfqGdOQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBprtwb40mCxonZwLGJFdKvAOCNf9Z1ejF9h1QLc
 KbpEn/XCmSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaa7cGwAKCRA1o5Of/Hh3
 bT8zD/9PRj3adLVgcinUk4bxKws/7ijwXTW36Xv2kkWLNFX9pc22jayj/SCiPtS3M+gDgfJAIY2
 +Vw/EePc/2sj9bMdIpRIM0RIPC1HahEXpcW0lRANPtipVn65YtkGaAHD4nwmTR5XRF0FgxI7VSW
 FBCVbj3MHgUFBgp46CqRVnBJ2wJYzuAwJlrGFl7DhXS32c/YdrgImOBMbAlIeQDnU0qCbYMFqvi
 sTMhYpL9kQ/rnT3fystUMP1i6+64GLilQNMrtwJ3TeWheeNuRwa7Iz00iO8ksbpiR4GrkG9SfC9
 rWNQRzypsYy5uGoeIfela/cJhA5zQpDwwRv1KE8Q9lr0Cj37sQ/e7TOghVJBwQqErAli807FjW7
 RqwUQvWRuVu0LVRRah5q8vbry3zWoBKzrPPcOfttH9rPhQtA5aW/NIcHI3iuflJShrHxrRMiqf4
 4eRR68N3SC/8kACyX570wzTcr/Aa07SW/jy2YaR1sxr7zP3dxgx3p7dEHrfqrGBpR+czu74z/P9
 bgiJ0EdG1gmEjdziKkdBJ9OBQYseRFWiHjytPE7OT73dnONWqm2dkV7ZpcChhUdTTqfX0/calmW
 Wk/M5n7t9iG+jFUXf74EXt8KR5fbj0HrJK+ZkVN2Dv2iuPrs0Z5vXQyDI4Kfi41cYeYZ/j0YGO3
 /mEeqYcc8ua6G+Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

A production AMD EPYC system crashed with a NULL pointer dereference
in the PMU NMI handler:

  BUG: kernel NULL pointer dereference, address: 0000000000000198
  RIP: x86_perf_event_update+0xc/0xa0
  Call Trace:
   <NMI>
   amd_pmu_v2_handle_irq+0x1a6/0x390
   perf_event_nmi_handler+0x24/0x40

The faulting instruction is `cmpq $0x0, 0x198(%rdi)` with RDI=0,
corresponding to the `if (unlikely(!hwc->event_base))` check in
x86_perf_event_update() where hwc = &event->hw and event is NULL.

drgn inspection of the vmcore on CPU 106 showed a mismatch between
cpuc->active_mask and cpuc->events[]:

  active_mask: 0x1e (bits 1, 2, 3, 4)
  events[1]:   0xff1100136cbd4f38  (valid)
  events[2]:   0x0                 (NULL, but active_mask bit 2 set)
  events[3]:   0xff1100076fd2cf38  (valid)
  events[4]:   0xff1100079e990a90  (valid)

The event that should occupy events[2] was found in event_list[2]
with hw.idx=2 and hw.state=0x0, confirming x86_pmu_start() had run
(which clears hw.state and sets active_mask) but events[2] was
never populated.

Another event (event_list[0]) had hw.state=0x7 (STOPPED|UPTODATE|ARCH),
showing it was stopped when the PMU rescheduled events, confirming the
throttle-then-reschedule sequence occurred.

The root cause is commit 7e772a93eb61 ("perf/x86: Fix NULL event access
and potential PEBS record loss") which moved the cpuc->events[idx]
assignment out of x86_pmu_start() and into x86_pmu_enable(). This
broke any path that calls pmu->start() without going through
x86_pmu_enable() -- specifically the unthrottle path:

  perf_adjust_freq_unthr_events()
    -> perf_event_unthrottle_group()
      -> perf_event_unthrottle()
        -> event->pmu->start(event, 0)
          -> x86_pmu_start()     // sets active_mask but not events[]

The race sequence is:

  1. A group of perf events overflows, triggering group throttle via
     perf_event_throttle_group(). All events are stopped: active_mask
     bits cleared, events[] preserved (x86_pmu_stop no longer clears
     events[] after commit 7e772a93eb61).

  2. While still throttled (PERF_HES_STOPPED), x86_pmu_enable() runs
     due to other scheduling activity. Stopped events that need to
     move counters get PERF_HES_ARCH set and events[old_idx] cleared.
     In step 2 of x86_pmu_enable(), PERF_HES_ARCH causes these events
     to be skipped -- events[new_idx] is never set.

  3. The timer tick unthrottles the group via pmu->start(). Since
     commit 7e772a93eb61 removed the events[] assignment from
     x86_pmu_start(), active_mask[new_idx] is set but events[new_idx]
     remains NULL.

  4. A PMC overflow NMI fires. The handler iterates active counters,
     finds active_mask[2] set, reads events[2] which is NULL, and
     crashes dereferencing it.

Restore cpuc->events[idx] = event in x86_pmu_start() so that every
caller of pmu->start() correctly populates events[] before setting
active_mask. This does not reintroduce the PEBS issue that commit
7e772a93eb61 fixed, because that fix also moved the events[] = NULL
clearing from x86_pmu_stop() to x86_pmu_del() -- throttle/unthrottle
cycles no longer clear events[].

Fixes: 7e772a93eb61 ("perf/x86: Fix NULL event access and potential PEBS record loss")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/events/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 03ce1bc7ef2ea..fd82d1427b335 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1546,6 +1546,11 @@ static void x86_pmu_start(struct perf_event *event, int flags)
 
 	event->hw.state = 0;
 
+	/*
+	 * Ensure events[idx] is set before active_mask, so NMI handlers
+	 * never see an active counter with a NULL event pointer.
+	 */
+	cpuc->events[idx] = event;
 	__set_bit(idx, cpuc->active_mask);
 	static_call(x86_pmu_enable)(event);
 	perf_event_update_userpage(event);

---
base-commit: 0bcac7b11262557c990da1ac564d45777eb6b005
change-id: 20260309-perf-fd32da0317a8

Best regards,
--  
Breno Leitao <leitao@debian.org>

