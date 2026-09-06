Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EBE34E744
	for <linux-perf-users@vger.kernel.org>; Sun,  6 Sep 2026 18:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788721058; cv=none; b=GZus3hsTsFBYvAPdAwQlyAXPEwGwMqUnKevtHUvRtda/X6Pvx0OKvcYMFz5JNIjqBD6JgREBcBTp6NCi5J7bNjeaDxRLDz8kw1DQb+O3yUjKcD+bsj7Kx+OIla/18VBjcRUqLZTeIRNnFKxoQsV4CCZJ04D8FbBdIbLg3ebDRfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788721058; c=relaxed/simple;
	bh=rJdDGuuLXwWwi0+YctgfhPVqqUuk5Zm+eKOhIzDmD3A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lCsGSCYmZKgxFnn1RUlhGpKoyBNwlakNfTNjJP/FG9lnxogW265La9ok4USAUG7pWqWl1s4IX1CAOpTzJfh7NGaBSlutArhTQdGudMea3YFz8ILcyrg2PLcltZdSzMeBNZON12iZ9dG+NVMANPoN8JldA9sROfAMqi+jsycFfis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjQ6pyDd; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjQ6pyDd"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-66fb8a78ad2so2897393d50.2
        for <linux-perf-users@vger.kernel.org>; Sun, 06 Sep 2026 11:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788721055; x=1789325855; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ooyeucvHNbUkHL36Nom6RqEKj60jDXRF1sRDnJESWo0=;
        b=XjQ6pyDdsQPQcinwY9cwmMC7Gep+gsR+Vr/2Mcu1keM7nL9lQ7rd0ReqZAbm50rR23
         FTO2bRy2BCkW+olPbWb5o3+N6G0ObBd656RGZSEbwWMVc3lE60W55y4rN+CveZ3N7tcu
         YGo9pMIclNRyA6Rx5bPpjxyDGOU79yZuHEguxaBW/7KV4mpajsuxyTHsmXlEWL7fe0Mq
         q+bjEKMuOFQJlEMlqvGAYQrntd7kUVwkjDsp9Ycqc2LnBz6TnjAmLsuTQ4jXEsBkxMAX
         /4rqf959W4vEXovmC+qfW3TGrtbvoDGL5/BgEQbMD4biQQoHwrjPU7ql3wd/eEDpvSp+
         /MsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788721055; x=1789325855;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ooyeucvHNbUkHL36Nom6RqEKj60jDXRF1sRDnJESWo0=;
        b=pKLyuf1fRNmw/HhfupsYvaAjgcA5UYJqNUllngMzmitCgtfhdKurY9QhDoLSmJaMV9
         9ScQ8em3m+SaQBi1ZQxslmHZcaGdj5ikvIZ6yYQuoy1Tx4qa54GX0cS1BBwS0Qifxp5n
         1FhB0/JleFp3KdRDD6SjscPl3erlXAYdlpR53+RWhlCgajdr/ZRegFhpoQeKBE+aE4ox
         /Y4JkQ0zunUNiFhtZ/fgEBRVki1sgv4ixkENAv3y84c33kgMAih9PAm3N6oFsLiMvNS0
         qdjRHcsGeq4dtujeNRh/g/JKKs9gUX3MLxdq0STu80q3TpHvV05HM9UXEcg/C2PBQijl
         /KRQ==
X-Forwarded-Encrypted: i=1; AKwUvBxPfO+mWANa+fu/tUvWJQ2wqWlR+0aitBFqCEtkvc3mHQw7oAedBqorJ6VTb5464/RSnxOoeKuSxEczLOBy1b83@vger.kernel.org
X-Gm-Message-State: AFuF++mrAjjXGuLr4yWAFP1lVxGW4oMXeazsWnZRAeonLhZAZ/6olVW/
	ONuTdX1YbPXp6vAky8wqwIFUc69VUf3Qy4MGyw3D4Vq87/AMvFrbS/5GOoeYJVhPu+k=
X-Gm-Gg: AYBFou0W/Wj411DAdC/Cw5zk66jN+2fE/OrD9+JkN/rOL4bt5iCcmvMCGGrtpXF6ZED
	uSRnbSBAFKtzXnpIbYDYOWieEKfbRtQgrPGXNk5NeresG9iXC0qcGTSyaxp80PvS+L+ZXsOE45j
	ivKPaWr/5JznCaEzEUNBWmjtdCH4F+OO7ACKfLMSwf43p/5KTs5mju8sC36PVLx+pCEgofm3j98
	8GbVlpci6ykt7iM0tgmOpsB/XSeptaxzkhHPF0Wtr0GQCIEZ4YDRk1NcJ5qI3GgkCIGNK1MyngW
	otC7/H/ORSvS8aaWIFI+Hepd5D3ifwWt5uZ8IphWworcJwvTb0mnVVFYMKq4sPy0WF8pfVvynKx
	AgvKWxWRWR9/Ui/CUF6sC4/pHIQkVS415Is7oxQAHqUbgdL90uLzKT3cNzmIasWdGUne1cg/bTP
	ksg0+Tcc853gU4QdSyAIA80RBqB2fFeyO447I+yhUjMOtEpZ6x0SYEiYrsx2hB
X-Received: by 2002:a05:690e:118e:b0:66f:c1bc:4072 with SMTP id 956f58d0204a3-66fc1bc49aamr3207402d50.53.1788721055402;
        Sun, 06 Sep 2026 11:57:35 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714bef8930sm59326237b3.46.2026.09.06.11.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 11:57:34 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v6 0/2] perf tools: port UI from GTK2 to GTK4
Date: Sun, 06 Sep 2026 14:57:32 -0400
Message-Id: <20260906-perf-gtk2-v6-0-695d1c01aaa1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNTQ7CIBAF4KsY1mKGgYHWlfcwLigOlfhTQ02jM
 b271J2NXb7JfO+9Rc85cS+2q7fIPKQ+dbcS7HolwsnfWpbpWLJAQAs1WHnnHGX7OKMkouDBNI0
 lFOX/njmm57drfyj5lPpHl1/f6kFN138tg5IgHVnTxIpQ+3rXXn26bEJ3FVPLgIsSi9QcQoxAO
 hzVXOpFqYtkFREqi8p4mEuzKE2RteMamcEVO5e0KGnarJxx3lJA87M5juMHuzc2J4oBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5263; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=rJdDGuuLXwWwi0+YctgfhPVqqUuk5Zm+eKOhIzDmD3A=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLmbp87y2HPjg9LzHf8ONYwZVHq7hmtd31S2AMyYo8IW
 r57VJcY3/GRhUGMi2GmmCJL3HpFllltO5b6nJb+BTOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GQIZOkbxEDk9Bo3M4uLS1CLdtIIih7z8ksSSzPy8Yr38gtS8gvQCvbTMtJKMjPyi4lSgEXp5qSW
 mro5uRoYGJpaOFmZOFo6mJs7OToZObo6Ozq5ORpbmJgbOlo4mrpbmDFycAjDXiD9i+B8cf06sdZ
 t2xct1xXw9gk/+fdpio5b5iS9xi9rHnoJ97E8Z/ulL5Pd6cK8J2HBj+pynt7pvS691q7uy4c06p
 nx9L43HUrwA
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
Changes in v6:
- Explicitly include <string.h> in annotate.c (strcpy()) and
  <stdarg.h>/<stdio.h> in hists.c (va_list, snprintf()) instead of
  relying on transitive includes, which isn't guaranteed on musl
- Link to v5: https://lore.kernel.org/r/20260906-perf-gtk2-v5-0-e8747a65c240@gmail.com

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
 tools/perf/ui/gtk/annotate.c                     | 36 ++++-----
 tools/perf/ui/gtk/browser.c                      | 96 ++++++++++++++++++-----
 tools/perf/ui/gtk/gtk.h                          | 16 ++--
 tools/perf/ui/gtk/hists.c                        | 43 +++++------
 tools/perf/ui/gtk/progress.c                     | 40 +++++++---
 tools/perf/ui/gtk/setup.c                        |  5 +-
 tools/perf/ui/gtk/util.c                         | 97 ++++++++++++++----------
 tools/perf/ui/setup.c                            |  2 +-
 tools/perf/util/annotate.c                       | 11 +++
 tools/perf/util/annotate.h                       | 12 +--
 22 files changed, 257 insertions(+), 192 deletions(-)
---
base-commit: 9f0346dcbea363787186c94ef94dd01aaa215afa
change-id: 20260906-perf-gtk2-555ca04bb652

Best regards,
-- 
Matt Turner <mattst88@gmail.com>

