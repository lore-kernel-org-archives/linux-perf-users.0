Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA263C0A17
	for <linux-perf-users@vger.kernel.org>; Sun,  6 Sep 2026 18:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788719214; cv=none; b=dw0u6m4w5qpj3tHnbQ+jvtNTD5/ovIWbGlAUn0py00TVTVpzY+W9v2Inp+X+KZ4yyiedR/sXZYzGHjVAULew+YOd+0VOHGuEIuL5LoMZEt9BasqnGmVh2qDD9v9KNnG1t8Dzhq/xo3Zamrg/BelKovR4dlVicmG/Hi0iRKda+jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788719214; c=relaxed/simple;
	bh=SgX1YF5BinqnYgFFhO7dDlEYttQMLZuaOdTahuCoQno=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mcFqKl5LG9HAerV34nhZs0RwXV7MSuZ/OOVreSoHZyQByqHoH5F3NwHAZXaS3NUAJAfiPn8p+oiTEQzYvWFS2IObf7jyD+GNKizXkV9f0WLQc57WS0zlN7kqd34bLcDxiB9/Ynstqxf49psSeJcueL4rVqi+RSZWRVFKLj7dC90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anT2eLhr; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anT2eLhr"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66d1447e2b1so1977925d50.0
        for <linux-perf-users@vger.kernel.org>; Sun, 06 Sep 2026 11:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788719212; x=1789324012; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sKM47l7YkmZt/cmjld1HYUn2TA7R7T3CNQOleawZSeQ=;
        b=anT2eLhrEPpY2kPms8u2W2LEcbLVbZx6LRxybgjVugnFqR9EHhDuFzxsf2o+248ziM
         bB4OD0Mhvn3KTg96qj5jSsyw+Dxz0hALK782njJ7c8rHx7qppvKVXY2Uj/MXf8UQhb9s
         CItsKBsI+VrcKDzJ0FxYtRueL1i9a1uKosc8CNyHpIatuNykq0d4DGRfhm1Jt01uO+jp
         hQNwjZr4R9QXVlCIFoumus2rWGNLGt0xdagq+gEMMpQwtpcpJwhpfX7BOqk1qJ2WqJ1J
         KtVvSGYGM8HYY8OksZfr4dvVtlDYPaqzzhIIjXFYe86W1xVrE6i1LkMN8QdRrwkQ2FQy
         iLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788719212; x=1789324012;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sKM47l7YkmZt/cmjld1HYUn2TA7R7T3CNQOleawZSeQ=;
        b=nGu0r2GAIuhrNt4o32TqJO5vkXwBPCv9QewquHQop2HuYGTD3CwUwtjg2pUajxeImu
         DA8Zq6OnK+2if1Nj1S8b/rLUad3t5qxEr3Fo2+aCmObmro73SNsDRSorGhRXCYwWN8hb
         eBq2FqndKKt06Mmz6h9UxZcS1Ufstq28tPicWzv8OfavI4zwMCTGQQ8eZ3CNKyzuXHea
         EyIyncXNgxBus5pK2OFevhydywflHxGU+ZRxPsawXR9RCyKXZnFsZDcpl687Cd3ni71c
         6OMtxbS7ijyd/Be2mWBWauSapVNRERFk5kSCwrrMrK8Nz0NBJHykdzFDzLfZ7IbY04jV
         4OZw==
X-Forwarded-Encrypted: i=1; AKwUvBxtcMmW2BDJx1JO5URAW8sfsLfWRy9ZIvx042HVwmHmMJ8sxE3T6neDTunZ1ggZ/MWzmtJckV9BM663crvyAdqZ@vger.kernel.org
X-Gm-Message-State: AFuF++n5bSGuplfFmG0+FacXCzDu+7BDfd9LZPqVCb6VZdVWDxA07Fch
	Typ7xyyAtAs/Divb4t/LU4wQKrLJkpCjUqA2qZKbw1nbcKoqLYogc/VZ
X-Gm-Gg: AYBFou3+y0ymUFzW2cIfGfTbXZ3FIKKfTQAGXUkHfwC9HqVwjm5eJfFMHpKMn588HsE
	wU3JUBAY2KgXKIU4uLHwpv7ZLy9A2NUWTfR0IjsvlW4o/eWEoW4BczOUSGQZvk1MZblxgeaPxCS
	i6lXXas6kCsrQUqukW9LHPdK75DYtN1R9yMCKvxTlxaBMv75CBSdzDZWO1QiAXSccJX0MBOSNDk
	z/3xk+dO2v1qMtpQEAH5p7/jyhSSTxC1za52KNmzhM2qGsdbwhgCTW8WErir59mmHtlcNoT++FJ
	K0XI9hmRAztSR3X0Uuq/z5Mac6+MKOKjifyftz44hsvIPDVDP9Ss4n2IYrNrEymB4PYAuLJ23CG
	hQ9km6PgPmwcVNfL4w1M1yDT/kc9SirlWs0/T9DnGmXNqEhUsnUy49j9TyKEaLLF9kTMOB3SxW+
	9fBSAVjQjEcfyNlqg8LO/ummtks4wejvkPe6iUbyngytOeWwdyYyNflK1n7q7yFKA9wY3IbnM=
X-Received: by 2002:a05:690e:1a26:b0:66f:c1bc:404d with SMTP id 956f58d0204a3-66fc1bc448cmr1525418d50.46.1788719211893;
        Sun, 06 Sep 2026 11:26:51 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb48f1646sm6778111d50.9.2026.09.06.11.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 11:26:51 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v5 0/2] perf tools: port UI from GTK2 to GTK4
Date: Sun, 06 Sep 2026 14:26:49 -0400
Message-Id: <20260906-perf-gtk2-v5-0-e8747a65c240@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XMTQ6CMBCG4auYrq2ZTn8QV97DuChlCo0KpBCiI
 dzdwsoQWX6Ted6J9RQD9exymFikMfShbdLQxwNztW0q4qFMmyGggRwM7yh6Xg0P5FprZ0EVhdH
 I0n8XyYf32rrd065DP7Txs6ZHsVz/VUbBgWfaqMKfNUqbX6uXDc+Ta19sqYy4KzFJSc55D1q6U
 myl3JUySRIe4WxQKAtbqXalSjLPKEciyJL9lfM8fwGDyn+iUAEAAA==
X-Change-ID: 20260906-perf-gtk2-555ca04bb652
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 bpf@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4960; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=SgX1YF5BinqnYgFFhO7dDlEYttQMLZuaOdTahuCoQno=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLmbsgMTb//Q1PiFcOVVFcF0dcPTn02y3fsmvW7VzTWZ
 /adIwZyHR9ZGMS4GGaKKbLErVdkmdW2Y6nPaelfMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChYxQPkdNj0MgsLi5NLdJNKyhyyMsvSSzJzM8r1ssvSM0rSC/QS8tMK8nIyC8qTgUaoZeXWmL
 q6uhmZGhgYuloYeZk4Whq4uzsZOjk5ujo7OpkZGluYuBs6WjiamnOwMUpAHPNxB8M/ws1bqnv6z
 pzuefrtN7Nc9nvcCUfCLRYs8zOoPWB18XZv2oZ/qfOvhF/WNJ+9r79hZs2XQl8sFsiW8Nc+dqGo
 28FuNYrm7ABAA==
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

GTK2 is long dead upstream and increasingly hard to keep building on
current distros. This series ports perf's GTK-based report browser to
GTK4 and fixes it up so it's actually loadable at runtime after the
port.

Patch 1 does the mechanical port (build system, widget API changes),
including the leftover-GTK2-call and signal-handling fixes that were a
separate patch 3 in v4. Patch 2 fixes a runtime issue found after the
port that prevented the browser from loading.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
Changes in v5:
- Fold v4's patch 3 into patch 1, since sigprocmask() only blocks
  delivery to the calling thread: it did nothing to stop the signal
  handler from running concurrently on another thread and doesn't make
  the handler's GSList calls async-signal-safe either
- Defer perf_gtk__exit() on SIGINT/SIGQUIT/SIGTERM to a GLib source via
  g_unix_signal_add() instead of running it straight out of a real
  signal handler, so it always runs on the main-loop thread, serialized
  with perf_gtk__error()'s updates to perf_gtk__error_loops, instead of
  racing them from arbitrary signal-handler context
- Keep a real handler for SIGSEGV/SIGFPE, since those are synchronous
  faults with no "later" to defer to, but pare it down to reporting and
  reraising the default disposition: there's no safe way to run
  GTK/GLib code from the faulting context itself
- Link to v4: https://lore.kernel.org/r/20260906-perf-gtk2-v4-0-97e92ee07214@gmail.com

Changes in v4:
- Fix gtk_widget_show()/gtk_widget_hide() calls left over from the GTK2
  port: both were removed in GTK 4. Replace with gtk_widget_set_visible(),
  adding a small wrapper for the info-bar "response" signal callback
- Block SIGSEGV/SIGFPE/SIGINT/SIGQUIT/SIGTERM around the
  perf_gtk__error_loops list updates in perf_gtk__error(): the signal
  handler (perf_gtk__signal() -> perf_gtk__exit() ->
  perf_gtk__quit_error_dialog()) walks that same list and could fire
  mid-update, corrupting it
- Link to v3: https://lore.kernel.org/r/20260906-perf-gtk2-v3-0-e1f2086214a0@gmail.com

Changes in v3:
- Fix GMainLoop leak if perf_gtk__error() is called re-entrantly: track
  active loops in a list instead of a single global pointer
- Add explicit <stdarg.h>/<stdio.h> includes instead of relying on
  transitive inclusion, which musl doesn't guarantee
- Drop the gtk4-infobar feature check and HAVE_GTK_INFO_BAR_SUPPORT:
  GtkInfoBar has been unconditionally available since well before GTK 4,
  and the check was failing outright due to its deprecation warning
- Link to v2: https://lore.kernel.org/r/20260906-perf-gtk2-v2-0-3eccff053cd1@gmail.com

Changes in v2:
- Fix error dialog's nested GMainLoop hanging if the parent window
  closes or a signal arrives while the dialog is open (quit from
  "destroy", not just "response")
- Fix build with GTK_INFO_BAR_SUPPORT: gtk_info_bar_get_content_area()
  is gone in GTK 4, use gtk_info_bar_add_child() instead
- Fix use-after-free in the progress dialog on manual close
- Fix reuse of an exhausted va_list in the vasprintf() failure path
- Link to v1: https://lore.kernel.org/r/20260906-perf-gtk2-v1-0-7564bf8523a9@gmail.com

---
Matt Turner (2):
      tools: port perf ui from GTK 2 to GTK 4
      perf tools: make the GTK4 report browser actually loadable at runtime

 tools/build/Makefile.feature                     |  4 +-
 tools/build/feature/Makefile                     | 10 +--
 tools/build/feature/test-gtk2-infobar.c          | 12 ---
 tools/build/feature/{test-gtk2.c => test-gtk4.c} |  4 +-
 tools/perf/Documentation/perf-report.txt         |  2 +-
 tools/perf/Makefile                              |  2 +-
 tools/perf/Makefile.config                       | 27 +++----
 tools/perf/Makefile.perf                         |  6 +-
 tools/perf/builtin-annotate.c                    |  8 +-
 tools/perf/builtin-report.c                      |  8 +-
 tools/perf/scripts/install-build-deps.sh         |  4 +-
 tools/perf/tests/make                            |  4 +-
 tools/perf/ui/gtk/annotate.c                     | 35 ++++-----
 tools/perf/ui/gtk/browser.c                      | 96 ++++++++++++++++++-----
 tools/perf/ui/gtk/gtk.h                          | 16 ++--
 tools/perf/ui/gtk/hists.c                        | 41 ++++------
 tools/perf/ui/gtk/progress.c                     | 40 +++++++---
 tools/perf/ui/gtk/setup.c                        |  5 +-
 tools/perf/ui/gtk/util.c                         | 97 ++++++++++++++----------
 tools/perf/ui/setup.c                            |  2 +-
 tools/perf/util/annotate.c                       | 11 +++
 tools/perf/util/annotate.h                       | 12 +--
 22 files changed, 254 insertions(+), 192 deletions(-)
---
base-commit: 9f0346dcbea363787186c94ef94dd01aaa215afa
change-id: 20260906-perf-gtk2-555ca04bb652

Best regards,
-- 
Matt Turner <mattst88@gmail.com>

