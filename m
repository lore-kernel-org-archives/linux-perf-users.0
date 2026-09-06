Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66314346FBC
	for <linux-perf-users@vger.kernel.org>; Sun,  6 Sep 2026 20:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788725592; cv=none; b=XjUHUEgmCt/FrvRc3on9tx5lYij74SPJG4c5ztsFyzg1oO4tO1XoxcXtdW1N3UO1jBV3wTxR0UxowEQlV86qKUnhZOLfgFx0Tkt1gQbrQX/VK1+bCYxJ7R5PrFV4ewMUlJwvxpKsQmKnNjmVxJQAl7z5b6C0DCx4VzMTR+z5S5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788725592; c=relaxed/simple;
	bh=iHGxIPRV+kOrhxuFYik+oYfKfBuKy1dWtX6Y8BNzY9Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q6N1ZofFEe69N8JbNv4pqjYJiWyBFHm3VPH1SsTsrovFp7CIZUd5e70BCCbHG1zW68uRl2FGZMjFbpSWhN3JNDPorSxWlIJYxAt3xRIcJ1LGQ7eeV8JjVl/SiRMvy4KcB4zoQXZ4HFZLWLserg/MqrH9qvFrKP3HFYuk6OhB1nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crxvRhUk; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crxvRhUk"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-86b03b75fecso43755747b3.0
        for <linux-perf-users@vger.kernel.org>; Sun, 06 Sep 2026 13:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788725588; x=1789330388; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C5kC7oy9blVAy2yIPa7qupg857DIbMAwvMw/piFMZ6E=;
        b=crxvRhUkqOac68vrnh9CLIhnZseq2uv0DUODGJe+NqOVZXSS83s++VY7kALKR1bHL9
         TdqVG9P1hqFXUkfWBGU5PYuoeFPg9ijalCcuo29a1pFgWHNQAvYmJky5FLLz+S/ANH9t
         upsfPbAFgg9aQSGIbjwPvKACIbbLJ5hyYhUgaYuSTvzWI7qAZSp9AcPGhjFX8gK6wzjA
         DyRWNZ2ZkmZzf19tlmsPrQkyzrIUFjZ7YGNkVvFwGm32ZJ58f9Ri0/c6lyh/LIpE599l
         tXIL3xT+HWrE4XYl6Ntp/CsfTnX1ghtRK/hsRzJ4fC9QSJjSDm2gwM1mvYC6l0vSB66q
         n/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788725588; x=1789330388;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C5kC7oy9blVAy2yIPa7qupg857DIbMAwvMw/piFMZ6E=;
        b=DJx0peEKlMv/e5GX7RYIag0DN6Cc0KUA0Bfe6SbgwP+8DtyBQNLiWZQw5VxDQ31beQ
         xsFSAqmPrFHVD4hFcBJhGWnQfbe9CiOk15MVKY7V4FUKn1ZqFMYI+NKTsS2dMzFekBvW
         xzkYbi3D9o+mwDEBU0+WQvqD7KhtoKx92QIXiloceZegBibkhqs+q+MlkxLm13p9pdRi
         UKDizQ5bmV7SppB9Ovkxgi38cHAJTucjUNG2Fy3VmlYu0hapXRQ+iL6DtSXOpymHmshj
         NA762eANNU+YBP4BtAo2NpUloaiAbGBHoNJGpUK9JlTIZrjomEvTKZ5jO+8JLyilAlf4
         6bPw==
X-Forwarded-Encrypted: i=1; AKwUvBwnA+cXZ2wm8bsU0DWYdZjoxdD9zgp5+7gQMfGEDb5ASiGXqoLyMZGNQve7eTxfBYZSpnVLIr9Le1GWmHDnBQwh@vger.kernel.org
X-Gm-Message-State: AFuF++l2ApU0BDWk4SUAuCyZ4dm1CwnHJIs8GiTrwtjkzrwulWM1MkC4
	U+d5oN7QYO0XelhW9beNXNoSutGuIIbNN19BAEAadM9BQClQ32/KvZ3a
X-Gm-Gg: AYBFou1tHmBRaMpIG3JhN98wnSVq5zQiAGevb1YIzljkbgj7Smc0evSN5vBPZ4FhxrX
	9LdDvDy0lOopjZeEersaO1xw/I11tRWiju4rZITFsGP3poKoE6rt2VbWzC7qSZJ3lIbh/fyyjBY
	tdUw+sDL5L24k2z3aYlsMBgySeVUYgmgnyY9hsXGUyBFTrwX28+gSw9WIG3A1bX1Ov9wY3xhV+f
	AXirgTPzSRCZXPJpGZja3XHOzjZ5wPY2+OSWyc5GevF1EqY628KJJOfOTMVp/iPE7W3G/zyiwWM
	RGIfy9ERtPrtJjH13ehEAS+R5HmmSlqkLa1X+sFCRCNNyTB9YEo8MDpBySkDE+YhQ+ofA5+/Jmf
	LE07PspbkfOwl9zZn7XidlFWShnrkh25MtAGyVe7qlrXzTO58P8AS2DJrp/dyH/Q67rbNRann5I
	p6W+o2QW61odzzUFrEYE0RDemwWIcq8w9DweVKKSsx5H0OM99mjeFKkcAZCuIMiVHXsYxwiD8=
X-Received: by 2002:a05:690c:92:b0:844:c27b:35dc with SMTP id 00721157ae682-87125fef551mr66545417b3.18.1788725588233;
        Sun, 06 Sep 2026 13:13:08 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714b62503dsm60679117b3.38.2026.09.06.13.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 13:13:07 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v7 0/3] perf tools: port UI from GTK2 to GTK4
Date: Sun, 06 Sep 2026 16:13:05 -0400
Message-Id: <20260906-perf-gtk2-v7-0-1ece839fbca0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XPwW7DIAwG4FepOI/JGAxhp73H1AMhJkVbm4pU0
 aoq7z7S27Jx/C1/v+WHmLlknsXb4SEKL3nO06UG93IQ8RQuI8s81CwQ0IIHK69ckhxvnyiJKAY
 wfW8JRd2/Fk75+9n1caz5lOfbVO7P6kVt0/9aFiVBOrKmTx2hDv59PIf89Rqns9haFmxKrFJzj
 CkB6TiovdRNqatklRA6i8oE2EvTlKZK79gjM7hq95KakrabnTMuWIpo/ty0TWmrtJ4GFUGFEH7
 9ua7rDzPz6xLEAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5785; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=iHGxIPRV+kOrhxuFYik+oYfKfBuKy1dWtX6Y8BNzY9Q=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLmngxsP6sWdDNkzfKoUNP8/hZZFr6TdybsVvoaMfPpN
 77oZ09qOz6yMIhxMcwUU2SJW6/IMqttx1Kf09K/YOawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyBDxygeIqfHoJFZXFyaWqSbVlDkkJdfkliSmZ9XrJdfkJpXkF6gl5aZVpKRkV9UnAo0Qi8vtcT
 U1dHNyNDAxNLRwszJwtHUxNnZydDJzdHR2dXJyNLcxMDZ0tHE1dKcgYtTAOaak/yMDDfXdrMcz/
 ylnnGuhbHqiYmvSYFiyALO8ij15a1sq2fbBDMyvC/skv5klTXj3qbXMzwbZuxUfnTz4hu7vjUPN
 zn6ppz2YQEA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

GTK2 is long dead upstream and increasingly hard to keep building on
current distros. This series ports perf's GTK-based report browser to
GTK4 and fixes it up so it's actually loadable at runtime after the
port.

Patch 1 does the mechanical port (build system, widget API changes),
including the leftover-GTK2-call and signal-handling fixes that were a
separate patch 3 in v4. Patch 2 fixes a runtime issue found after the
port that prevented the browser from loading. Patch 3 fixes two stack
buffer overflows in the hierarchy view that predate the port.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
Changes in v7:
- Add patch 3: fix two stack buffer overflows in the hierarchy view
  (perf_gtk__show_hierarchy()'s unbounded strcat() into a 512-byte
  buffer, and an advance_hpp() size_t underflow in
  perf_gtk__add_hierarchy_entries()). Both predate the GTK4 port
- Link to v6: https://lore.kernel.org/r/20260906-perf-gtk2-v6-0-695d1c01aaa1@gmail.com

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
Matt Turner (3):
      tools: port perf ui from GTK 2 to GTK 4
      perf tools: make the GTK4 report browser actually loadable at runtime
      perf tools gtk: fix two hierarchy-view stack buffer overflows

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
 tools/perf/ui/gtk/hists.c                        | 66 ++++++++--------
 tools/perf/ui/gtk/progress.c                     | 40 +++++++---
 tools/perf/ui/gtk/setup.c                        |  5 +-
 tools/perf/ui/gtk/util.c                         | 97 ++++++++++++++----------
 tools/perf/ui/setup.c                            |  2 +-
 tools/perf/util/annotate.c                       | 11 +++
 tools/perf/util/annotate.h                       | 12 +--
 22 files changed, 275 insertions(+), 197 deletions(-)
---
base-commit: 9f0346dcbea363787186c94ef94dd01aaa215afa
change-id: 20260906-perf-gtk2-555ca04bb652

Best regards,
-- 
Matt Turner <mattst88@gmail.com>

