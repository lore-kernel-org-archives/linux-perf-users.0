Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4992C237C
	for <linux-perf-users@vger.kernel.org>; Sun,  6 Sep 2026 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788703541; cv=none; b=fVCArxddXn5gKI5bKfKiRRhZxkhmpQS3IsP3uIOQlXZkG1xzJXxj1vJxA8nWD3rWZ/Zd7GIxaK77te84OFTvcoRwDdHhK+wTHvupPytoXfdyiw5wWACea6MpWyFIdoatWpCQ6G04aJyJeCs1VOdvKj7LrqRj08islCqhZQdUrng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788703541; c=relaxed/simple;
	bh=ABON75AhDambrtUbtXG4HfgRDu1+eqepUVf/JMe9ynk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z/ripGzDVrfH2u+5Xf6DCg2XrSH5865KUFK/HgHZqStBOpUDBRTNSfyGs1bZ7dRJ2ThWbSQ6q2znDMkCxhGBrlpins/MPFyli6cBbVnPcscOIjhW4JSQ7Yt9TGlyHFe1cecG9tShFy2FAT70xQ8u6dFAOpcgOVUUGWzTD+3dhjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5oB5Jhp; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5oB5Jhp"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8630c1503f2so20990407b3.1
        for <linux-perf-users@vger.kernel.org>; Sun, 06 Sep 2026 07:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788703539; x=1789308339; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=s/46oElF1tYdsElPkXygjprwzV3BhzjlPyWFudUQDWs=;
        b=Z5oB5JhpfosqQBpje3GMVC07B5e6fDHF3V5fsrXv8hhrY+mdcMyr8YYJGWKcDMEvIK
         hSd+cZnVyIloYHqf+JbLalW+6rmEAJJq7+Lftjo1nECaAkFYkyPTczQ3vs2nauNQeDF8
         ik8T4UbO/tuRhg/qaR6mWtk12wCxOuCgeSL/5c9jH7ec6xdgT5KD3lmKBH9aZK2ZxdEd
         32bQoMQLOOvH0WhPew+ggP7Km/QGRyHneRIOTSHybCS/FoChCiK9Mb63AET2/K6nE0cL
         MS0hnvCtn9BNZ/3gc/zvjw53N01L6jjHllfMOhCiA8TA1n4k+sZeei8YfqiGK0UAQn4w
         LSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788703539; x=1789308339;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=s/46oElF1tYdsElPkXygjprwzV3BhzjlPyWFudUQDWs=;
        b=VWMJ6PnT8W5cXNl3PINhB+hIEEGP7skmNxdT4nI8XM66A5oEXGIOVmLF0iWRVF9SXy
         bT/evngvaJPhX7dBszigWvi1uxw1NFRnmahOdDJ5je6FxjKvO4JNYu+yVgujlPTRNkpk
         xxC4rZWLn0XQJZ2vwmzTiuAgb5BSIOoRaoM0M7ImDc5bfxSYb54p/WbM2TaYhw17g0DW
         zzErxrRitIOzOjucoiUxzlY4q8Sdx2wzz90x7vhA4388j/+ypX5lLcYWa+zJ3xkt67rY
         JTIdeE3EbGKOpgp/ocENpcq+49oglqw/16cZAMVaOvFjGSwk1UO2AOnLBjDEiDng/0e/
         UyUQ==
X-Forwarded-Encrypted: i=1; AKwUvBxDCjVz7Kb+NC+LhshRCszpkK1jr8Q7c2kiQnY+rP5BnRmE+hWO3ueJLMWc0BElE2PWovw8G/kL8rJMgGBN2Ieu@vger.kernel.org
X-Gm-Message-State: AFuF++nXqZKM1K9JL2W3imudSz/kdqMcXhYFpQhkaETguISCwdc0DqRv
	oft3rG27/74b7430LRWHOF9nwguRhAi8pnh95EPsZZx+hGB2DRWOE0th
X-Gm-Gg: AYBFou2FHN3JmTHfKXgb1I5rKA/EtJI2SGkmD3cRJOtsUKBM+T/TuQuRP1yB3H00Qgb
	dIcfEwzvvXQFExNDMHg2pmVyZemWnRTfBvY1yqCHEhaI9ZyaMZ3l3GCH/TeNVtYpE9S4LuNi4pX
	ARrXdHKWzKtRXgy6mvA7SuVNhSxsIfl2tmUM4MVp1kVkfhY0VRjmXDaHV3kPXB5b7KT4DgOAZFL
	zx7SO8uJtS4glt9KO9NnFPpAH6H4KtU0QYS/YVaosADNPEZeEhDnEk7mkUeyU6eboXW+Qy/OV01
	hnMm3pA1lbchQ+U+VdMW+s8CEskPfDgrCk8m8YwVHSMpyKjPmSGYYGYKdgWQYa6Z2oUEJtQ4xHI
	04UvvgnObIFDPTmvC0Pf5n7wyEeRIGdSLBr3x/+nU5O4yugsk+Crj6egVEBh5xjJhUGFIM8QBK3
	teFfqvWTt6ZIJE1sdYlZdLqP0LABNWpUu61cYlhGw/12j9I8aPJAXRI3FD+TbjnA==
X-Received: by 2002:a05:690c:f02:b0:7e8:a091:6c4b with SMTP id 00721157ae682-8712a70a29emr74400167b3.24.1788703538809;
        Sun, 06 Sep 2026 07:05:38 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714a0b6179sm55278027b3.23.2026.09.06.07.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 07:05:28 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Subject: [PATCH 0/2] perf tools: port UI from GTK2 to GTK4
Date: Sun, 06 Sep 2026 10:05:26 -0400
Message-Id: <20260906-perf-gtk2-v1-0-7564bf8523a9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSwMz3YLUojTd9JJsI11TU9PkRAOTpCQzUyMloPqCotS0zAqwWdGxtbU
 AUqqe8FsAAAA=
X-Change-ID: 20260906-perf-gtk2-555ca04bb652
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2222; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=ABON75AhDambrtUbtXG4HfgRDu1+eqepUVf/JMe9ynk=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLmFqsfd9ytsH+2pN+7d/86n9XxGzX01O7KuReu9uD4X
 W1/TlnXjo8sDGJcDDPFFFni1iuyzGrbsdTntPQvmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 EMjQMYqHyOkxaGQWF5emFummFRQ55OWXJJZk5ucV6+UXpOYVpBfopWWmlWRk5BcVpwKN0MtLLTF
 1dXQzMjQwsXS0MHOycDQ1cXZ2MnRyc3R0dnUysjQ3MXC2dDRxtTRn4OIUgLnmhBgjQ2O/epmQ7u
 lt6w7Enf8gaO5v3h0/IWbV/O9Ttuzb4thScYSRoe9/84Y1sxPe6l91zNq9595CrjmHtfg/HtQ11
 JzXOLvsMBsA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

GTK2 is long dead upstream and increasingly hard to keep building on
current distros. This series ports perf's GTK-based report browser to
GTK4 and fixes it up so it's actually loadable at runtime after the
port.

Patch 1 does the mechanical port (build system, widget API changes).
Patch 2 fixes a runtime issue found after the port that prevented the
browser from loading.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
Matt Turner (2):
      tools: port perf ui from GTK 2 to GTK 4
      perf tools: make the GTK4 report browser actually loadable at runtime

 tools/build/Makefile.feature                       |  5 ++-
 tools/build/feature/Makefile                       | 12 ++---
 .../{test-gtk2-infobar.c => test-gtk4-infobar.c}   |  4 +-
 tools/build/feature/{test-gtk2.c => test-gtk4.c}   |  4 +-
 tools/perf/Documentation/perf-report.txt           |  2 +-
 tools/perf/Makefile                                |  2 +-
 tools/perf/Makefile.config                         | 27 ++++++-----
 tools/perf/Makefile.perf                           |  6 +--
 tools/perf/builtin-annotate.c                      |  8 ++--
 tools/perf/builtin-report.c                        |  8 ++--
 tools/perf/scripts/install-build-deps.sh           |  4 +-
 tools/perf/tests/make                              |  4 +-
 tools/perf/ui/gtk/annotate.c                       | 28 +++++-------
 tools/perf/ui/gtk/browser.c                        | 52 +++++++++++++++++-----
 tools/perf/ui/gtk/gtk.h                            |  2 +
 tools/perf/ui/gtk/hists.c                          | 32 +++++--------
 tools/perf/ui/gtk/progress.c                       | 28 +++++++-----
 tools/perf/ui/gtk/setup.c                          |  4 +-
 tools/perf/ui/gtk/util.c                           | 22 ++++++++-
 tools/perf/ui/setup.c                              |  2 +-
 tools/perf/util/annotate.c                         | 11 +++++
 tools/perf/util/annotate.h                         | 12 +----
 22 files changed, 166 insertions(+), 113 deletions(-)
---
base-commit: 9f0346dcbea363787186c94ef94dd01aaa215afa
change-id: 20260906-perf-gtk2-555ca04bb652

Best regards,
-- 
Matt Turner <mattst88@gmail.com>

