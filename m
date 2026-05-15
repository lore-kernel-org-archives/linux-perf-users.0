Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C812F3F9A0D
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778868510; cv=none; b=AoL2hRVhGgHWAH5jvacYJ2kO3UugnkzLCusWmMXT7XgEX5hzCGvXRfmTQrhqWxoB4+2oWrn8XH87s+s4OqKnYAapplkBYwuJue9UjYHmWDBoVD/2BMTw9H73aU57r0qLXvrIGGXSKizSlf5Ktg9ceiIk4D6Erpzt63MM7ZKNoTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778868510; c=relaxed/simple;
	bh=uZ7ygsnr96oe6CK9wJ9zGBwa1AUV6F/q7+OBvaywCn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WNgePW5Ia/ITkWBhZzBPwvW9OD4GnuoAmOmSN2jlxY94QOgDXcwFiTqQC3/wIFhV6jjx5N3xkAHiZxsjkf5Hmplqwi1cHq54rSDAauKDPjGLpYKTqBQcMLvvHJTTtkDLDLkd8Todhw2o77ZrZoON6sjH0cwZlP0avvXoESXkuKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0iYix8s; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0iYix8s"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b936331786dso3963866b.3
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 11:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778868507; x=1779473307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=la+O/bFtpnyaY0c5pxjy6SLIjk1Ilk22rZ0fIeKn2mA=;
        b=U0iYix8s4BlXPNZghhnrG2fXfB2g4UqzAjTJFPYT82FOcQ5WbjPVrMPQKmb1L9SjrK
         EO4omDBZ9OdpRa+vNTJfqWl1UXepKYlPSxTOJxeswmSu732E/5yzPGWzEfk2frDFmHVk
         p+C15GIfwSJcNevKfX+lUcUUzZkGWcQbfsfUeNNag0mom4c80kxLIIob/O5/twwQArpj
         J2ez2w9Kqh5PqYhcP22X0A9YX9+pWAK2gbat9rrFdbGgGqFR2gH9fyd7LNqBxwEix36H
         vnGo7CiMYVfgwKcOdWnJLxvxs4Gwg8UQRX6Ic06KonTylMPsFMpHf3T0vqJAD42DMMeA
         V2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778868507; x=1779473307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=la+O/bFtpnyaY0c5pxjy6SLIjk1Ilk22rZ0fIeKn2mA=;
        b=Xn5OBQ9LxRJ4TLnq9MEEI/Zi6UsUQT9vTCsum7lY9dgEe+I45+EMe1Ic7yZOdSSp3Y
         GBcBH5mQ5iX2+rJJTgvrwNlaEkDtq/SHYEAZiEHvjAuBukCqP8BVgATY41MuOSnAWwJA
         YlRV7bhAgNtKY+/XD9ZpUeagL8HKEzsxDt1w+MlumW35bzpoaTMX0ajTJ5zeWxzpDsH4
         iQYdGMUfVwzqcWYBin2wYXvt3IfQvaD32qWj967HeWL8ErIbPkLz5QJMeY1RPnKXooiu
         LlqLkL28oU0zVHTnrzzc8ZWafV+4gVxNHbY8sV/Ueu8eBbBcJryoA50rWsHenws+QwEO
         38tA==
X-Forwarded-Encrypted: i=1; AFNElJ/FAkb6tK2uOCBYIoMrrfnYMEDN//m9Qr3+E+RGGXYu6yc9iIm1DKdex/ioL+kHpmyYoPUsxqQ4Hk5cUlQzbgk5@vger.kernel.org
X-Gm-Message-State: AOJu0YzDQqUUM46+Ihqt03WyxtO2TX0gv9Y11QmG2qHCkghoWQuM9bfF
	M5I/zFJwt+JSUsAU8VdpNFYCNsiKbiRMmRljpXFX8IM28oc9eTjbc6Uodgc5cOe5Jj4=
X-Gm-Gg: Acq92OHvIaSyOz5mQRKJarzrN6Zu5Tnb5vUqnIcEfNwvDfGc1WwCeAWgk55vChhKu44
	KobvAcbOR4IymubXoUq9UF3vh3iR7a4ZJEd/Rnwdh4vOVZ5RZAOfpRwLy3K+ZTQbI5SoUpQ0XN6
	JIhxjgXcpsc8dDjMu17bihkKAMTrlDYOTa7CAbPgrqXDFcz/OJBPIgAhvqyl9nFuRssuwhD91V4
	w/hmvmtVEDRRD28CP6BqG1ew0KjCEurddRGab8enLNw2vxpLP3ed+OTfTs4NNNIZFKLAPJ0jBhE
	U9vwWVByoukIuYmShL9yAGyETcW78RRK3Flve/I6fsvLPbUQLJtJ7qJ+a4T1mlDK5j8abGLEfbE
	A3a4Cc30zr96wQ+wq93D9Dtyjh4xIpAauEqcrI10wq1JblZIxXjXZyT7Ww+tdLRZlyzBPMFtQ8E
	VNu1VVPWNucpG1FBmWSh9CtQB1Wob+BnCx
X-Received: by 2002:a17:906:6185:b0:bd0:6dbe:22b1 with SMTP id a640c23a62f3a-bd5177ec5dfmr278321866b.12.1778868506983;
        Fri, 15 May 2026 11:08:26 -0700 (PDT)
Received: from pc-oliwiera ([2a02:2a40:4bf0:bd00:6130:de6:bb7:addf])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4bd1bc9sm263471566b.9.2026.05.15.11.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 11:08:26 -0700 (PDT)
From: Oli R <sigmatwojastara@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	linux-arm-msm@vger.kernel.org (open list:DRM DRIVER for Qualcomm display hardware),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVER for Qualcomm display hardware),
	freedreno@lists.freedesktop.org (open list:DRM DRIVER for Qualcomm display hardware),
	linux-kernel@vger.kernel.org (open list),
	linux-crypto@vger.kernel.org (open list:AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER - DB...),
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Cc: Oli R <sigmatwojastara@gmail.com>
Subject: [PATCH] treewide: replace /usr/bin/python3 shebangs with env python3
Date: Fri, 15 May 2026 20:07:59 +0200
Message-ID: <20260515180806.246914-1-sigmatwojastara@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use /usr/bin/env python3 instead of hardcoded interpreter paths
to improve portability across environments where python3 is not
installed in /usr/bin.

No functional changes intended.

Signed-off-by: Oli R <sigmatwojastara@gmail.com>
---
 drivers/gpu/drm/msm/registers/gen_header.py                     | 2 +-
 scripts/macro_checker.py                                        | 2 +-
 tools/crypto/ccp/dbc.py                                         | 2 +-
 tools/crypto/ccp/dbc_cli.py                                     | 2 +-
 tools/crypto/ccp/test_dbc.py                                    | 2 +-
 tools/perf/tests/shell/lib/perf_json_output_lint.py             | 2 +-
 .../selftests/devices/probe/test_discoverable_devices.py        | 2 +-
 tools/testing/selftests/rseq/rseq-slice-hist.py                 | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/registers/gen_header.py b/drivers/gpu/drm/msm/registers/gen_header.py
index 2acad951f1e2..10316f517a7d 100644
--- a/drivers/gpu/drm/msm/registers/gen_header.py
+++ b/drivers/gpu/drm/msm/registers/gen_header.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 #
 # Copyright © 2019-2024 Google, Inc.
 #
diff --git a/scripts/macro_checker.py b/scripts/macro_checker.py
index ba550982e98f..7dbb114a57d5 100755
--- a/scripts/macro_checker.py
+++ b/scripts/macro_checker.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 # Author: Julian Sun <sunjunchao2870@gmail.com>
 
diff --git a/tools/crypto/ccp/dbc.py b/tools/crypto/ccp/dbc.py
index 2b91415b1940..cd56a63aa8ce 100644
--- a/tools/crypto/ccp/dbc.py
+++ b/tools/crypto/ccp/dbc.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
 import ctypes
diff --git a/tools/crypto/ccp/dbc_cli.py b/tools/crypto/ccp/dbc_cli.py
index bf52233fd038..bfe34f01e619 100755
--- a/tools/crypto/ccp/dbc_cli.py
+++ b/tools/crypto/ccp/dbc_cli.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 import argparse
 import binascii
diff --git a/tools/crypto/ccp/test_dbc.py b/tools/crypto/ccp/test_dbc.py
index bb0e671be96d..0ee3da6c6be7 100755
--- a/tools/crypto/ccp/test_dbc.py
+++ b/tools/crypto/ccp/test_dbc.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 import unittest
 import os
diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
index dafbde56cc76..dccafd507bb7 100644
--- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 # Basic sanity check of perf JSON output as specified in the man page.
 
diff --git a/tools/testing/selftests/devices/probe/test_discoverable_devices.py b/tools/testing/selftests/devices/probe/test_discoverable_devices.py
index d7a2bb91c807..72a94bbfbc7b 100755
--- a/tools/testing/selftests/devices/probe/test_discoverable_devices.py
+++ b/tools/testing/selftests/devices/probe/test_discoverable_devices.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 #
 # Copyright (c) 2023 Collabora Ltd
diff --git a/tools/testing/selftests/rseq/rseq-slice-hist.py b/tools/testing/selftests/rseq/rseq-slice-hist.py
index b7933eeaefb9..2c43b2e2bf0d 100644
--- a/tools/testing/selftests/rseq/rseq-slice-hist.py
+++ b/tools/testing/selftests/rseq/rseq-slice-hist.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 
 #
 # trace-cmd record -e hrtimer_start -e hrtimer_cancel -e hrtimer_expire_entry -- $cmd
-- 
2.54.0

