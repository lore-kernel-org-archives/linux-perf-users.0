Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2933BB9FA
	for <linux-perf-users@vger.kernel.org>; Sun,  6 Sep 2026 17:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788715088; cv=none; b=fEexWiEACjaa0VmioML6PDlfoATmCIvv+wrbX/lSXhhnQBJW3QTNL6rxNvffejLlM+3whZTOUr8RrxaBQpUBik+bnzSCyU/uGHZBwgr2hUBuuCwtxgEByKOM1gVIEDWOENZk5Z2e/u7KEISqS+MaXo69cC6MMh0E0ahDF/Rv9OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788715088; c=relaxed/simple;
	bh=ozDii0ZAGC0yertNA+sp7mdYxRILfzkOWRFtuvaqkzs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rvHKK65609duGkHFTEYYaThQs9OYheJbsJCZD8GkdyBGW3QSYF7Q2ZqpF8RXZc6coK2RMbxTIs6fg492Brw9L4wyYNmfZQN4HVq3hLeH8NbdpAw7wfSSSdPjAHrPk/AY9XEnJjpdEOuOcgI9S7p40fMlBi06LjhdV/XrVF9yWz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bo9N27cc; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bo9N27cc"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66fcf87897fso733093d50.3
        for <linux-perf-users@vger.kernel.org>; Sun, 06 Sep 2026 10:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788715086; x=1789319886; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/ECa8FuQ7Uq8oYW8zJsXwLaJ422Dic/CtrDYCL3Er9M=;
        b=Bo9N27ccKvrJFX1KdktnqrB0793Y0ruU1Ro/rS940pP7moCD3bSmf+pPUjGWzjJZyp
         1Tln0wtzJWA4UTSD5RA9pNAH8ePrYy+CbhaMpe6XFXktfKlZjM0R/SzjKNKzIXw7Nh3M
         UGZeZfifQdbSdUBhza/akro9v2vnauewVSMSAWIqfACa9I9bP5rUn1XanLOvv6CFXARF
         +ahtZVf7tcfcikTg8uMJtoVeG1Hjt+vfNqlmvnLkAHWQcII42HErXORxYbga2NRmmpqI
         wpOdbJ9rhHnfZrTQMUmEwgvjy44vfRDXorZcZW27xb5Stwkqdm3SvYu4HFBpgJqqirCB
         8VPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788715086; x=1789319886;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/ECa8FuQ7Uq8oYW8zJsXwLaJ422Dic/CtrDYCL3Er9M=;
        b=racvH9r53wxplPmp0MFYdq0A8OJbSkIrN7ldLsj5P/wf8cc0bEWiye1/j4D/7jqrhR
         ITLeTi/LnNrT0d4AF0rXDYOsXnFqtqSXWpGO+W5Ey+X75YMmH2JCIIQ47GCXyiT8KHjs
         YincXpAJP0vtj7HCHFW3c4xhpo8gbLaGDXbsXI7AObVEjus57pMlRq60wl7kz4Mzror8
         2RcciFvKXrxyH941/86F7UvPb2LThp7GFqgXFGNTwEcnPgLa1BAYVBFaCGSbM1UY/Kcb
         eclgeWQho3b8JnPpuigIRrCok0rOonuowCnUiL5tXs3lxangTfOnFj7LS/gsGbsUvxNn
         RVxg==
X-Forwarded-Encrypted: i=1; AKwUvByljP4xU21+hRbqgyzDFEhorLKXe/zb2M6ZIouiaP6uAj3VAn9fTv6Ws/KNvXXH6mMWoJZ/sDI0lbl2+kmosEFF@vger.kernel.org
X-Gm-Message-State: AFuF++lLvQCXT4GPfibZKTA4wvSebnvqkMESZWGo0YNVcwh//IExGTrA
	MGYr82yJTi7BSLDRTpkVp48A8TOSG1DNSSp2ehO1iXfsG79aRoKGlQVI
X-Gm-Gg: AYBFou01ku5Zxl5dL4VYIL8Oh1Fp1HxVfg8WzVowrvMlAkqUA2s7E7gaKL7Q9HUiSK2
	/jliJOGrhs5rv5ssgLFWGoYNQC5+KW+yxhrlkkpty0Cd7TvRLZyxODUQMlt6JSVfRMuxe1k+sNq
	4BbKUAkDMuWfng2lT8KaBFITJeCfD8T29Jczf8aSLE2wqb6vGXJAHqX4lRW9sII3eViiZCd7UGX
	xWXh3dkJcSfnFusk41KXE7XB9gS0APvo+AQAwxkv9nfh8uthtl+P1oz0VVRrwfXiPrdAcj/V/ay
	/cUyIopiizXPlScwCbY0lpYvw/sOJwLmViZLZVRL43d28OC1/jJLChkOLmN9aaiYcbmXQ6qmrqp
	QQxWwUJbSSJqQzVkUibz6a7WSQvlsQzJ+Fj6l38VkJy0aho+datbZ764vdXgHc864SYGSCg5WlQ
	q67nxFQWSbDA/gtTdt7G4Wdd+hX/S//byPQDW4u+M9zADsuBYO3xMeWYJkaU/Xe5sff+vYBNo=
X-Received: by 2002:a53:c410:0:b0:66f:c1bc:409f with SMTP id 956f58d0204a3-66fc1bc4824mr2287739d50.98.1788715085697;
        Sun, 06 Sep 2026 10:18:05 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb497aec3sm6644839d50.20.2026.09.06.10.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 10:18:04 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v4 0/3] perf tools: port UI from GTK2 to GTK4
Date: Sun, 06 Sep 2026 13:18:03 -0400
Message-Id: <20260906-perf-gtk2-v4-0-97e92ee07214@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XMTQ6CMBCG4auQrq2ZTn8EV97DuCilhUYF0pJGQ
 7i7hZUxsvwm87wziTZ4G8m5mEmwyUc/9HmIQ0FMp/vWUt/kTRBQQQWKjjY42k53pFJKo0HUtZJ
 I8v8YrPOvrXW95d35OA3hvaUTW6//KolRoCepRO1KiVxXl/ap/eNohidZKwl3JWbJrTHOgeSmY
 b+S70qepWUOoVTIhIZvuSzLB4q5lGgWAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4092; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=ozDii0ZAGC0yertNA+sp7mdYxRILfzkOWRFtuvaqkzs=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLmLvAWeXZqc2Et26rQWxU7Osy95WJfnQ6We59297zH1
 IyJp15md3xkYRDjYpgppsgSt16RZVbbjqU+p6V/wcxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkCGjlE8RE6PQSOzuLg0tUg3raDIIS+/JLEkMz+vWC+/IDWvIL1ALy0zrSQjI7+oOBVohF5eaom
 pq6ObkaGBiaWjhZmThaOpibOzk6GTm6Ojs6uTkaW5iYGzpaOJq6U5AxenAMw1d/wYGZbbOtt7/l
 3rd3HHKkvu4tQJ01cKLmbTOCUxUefarUtyLbMZ/gfMUy5gD3BMv3c8sDvzrefkVVUGCyPut0txc
 z5/1DdrJycA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

GTK2 is long dead upstream and increasingly hard to keep building on
current distros. This series ports perf's GTK-based report browser to
GTK4 and fixes it up so it's actually loadable at runtime after the
port.

Patch 1 does the mechanical port (build system, widget API changes).
Patch 2 fixes a runtime issue found after the port that prevented the
browser from loading. Patch 3 fixes leftover GTK2 calls the port missed
and a list-corruption race with the SIGINT/SIGTERM/etc. signal handler.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
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
Matt Turner (3):
      tools: port perf ui from GTK 2 to GTK 4
      perf tools: make the GTK4 report browser actually loadable at runtime
      perf tools: fix GTK4 leftover show/hide calls and error-loop list race

 tools/build/Makefile.feature                     |   4 +-
 tools/build/feature/Makefile                     |  10 +-
 tools/build/feature/test-gtk2-infobar.c          |  12 ---
 tools/build/feature/{test-gtk2.c => test-gtk4.c} |   4 +-
 tools/perf/Documentation/perf-report.txt         |   2 +-
 tools/perf/Makefile                              |   2 +-
 tools/perf/Makefile.config                       |  27 ++---
 tools/perf/Makefile.perf                         |   6 +-
 tools/perf/builtin-annotate.c                    |   8 +-
 tools/perf/builtin-report.c                      |   8 +-
 tools/perf/scripts/install-build-deps.sh         |   4 +-
 tools/perf/tests/make                            |   4 +-
 tools/perf/ui/gtk/annotate.c                     |  27 ++---
 tools/perf/ui/gtk/browser.c                      |  66 +++++++++---
 tools/perf/ui/gtk/gtk.h                          |  13 +--
 tools/perf/ui/gtk/hists.c                        |  33 +++---
 tools/perf/ui/gtk/progress.c                     |  40 +++++---
 tools/perf/ui/gtk/setup.c                        |   5 +-
 tools/perf/ui/gtk/util.c                         | 122 +++++++++++++++--------
 tools/perf/ui/setup.c                            |   2 +-
 tools/perf/util/annotate.c                       |  11 ++
 tools/perf/util/annotate.h                       |  12 +--
 22 files changed, 242 insertions(+), 180 deletions(-)
---
base-commit: 9f0346dcbea363787186c94ef94dd01aaa215afa
change-id: 20260906-perf-gtk2-555ca04bb652

Best regards,
-- 
Matt Turner <mattst88@gmail.com>

