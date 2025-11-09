Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38E42AD13
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Nov 2025 01:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762650022; cv=none; b=Q6nHIPBoL5BlHbzMEHDiGYCJwS3U6Uxv2YeC2+ExRrTxXwlcBWC2b/A4jWHrCu/TDrYkHWBf5kK7fDQQao+gQAFOideRWCO2OGpqWU7WlnV1CoeDCGusilSpx0uDySzhfj1ZGKO1QXJXMLrA5OC1bu7TH43HpfaZ0/fG9lDzne0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762650022; c=relaxed/simple;
	bh=YxvCs03ewNiGwh/gYtnUX+8yvLdOX7TFWZC1mF8j6dY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ori9luKWq0xo0+TN/J0nZX5r+ufwF/auSwYGlUk4VdZm9999EZm/AZ1Tc0dT0ekOnm8ry9SzJi/yHMGtZAhuQoVhM1lhi/RuDgv9EBP6x8xkJ4Uw6gtyZG+yRJWnOosjWhRsoQwR1l6Nyx0rKj4OdnNPmsFrW/guIqPywqiC+0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q+9/m0hI; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q+9/m0hI"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7ae220b9d18so1452224b3a.2
        for <linux-perf-users@vger.kernel.org>; Sat, 08 Nov 2025 17:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762650020; x=1763254820; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y75WeVh9hJ6IVQUJoOC/gRSUs+/cPxFQm1jQqSfBWSE=;
        b=Q+9/m0hIIw4fyNV+RPotm9WBmFuE4YGCytF0hGG3gFbu/uP7eVZDqwPGPmJqlODYNx
         O8GPeOmFraiSSdMD6VnkE4rJN2B5u3MasDj/WQLdeglVpVpYW5kdRZlNBGCWdw178UVI
         uEu8+hLpBo3YY4A+roMjWHw9pl79F5jpWajDg0aysGaEV2L8BQ5KfuVPq690CZlBwGAj
         kLSRIpRCbF13rbTzxoN4Au9y2EJ4LVAYi7/9GbWtHL9+1oaBWBeqjtdkcdOROLazLUyt
         vbfDrdZeVBpsTCGme1LmBKKlhfwKvyxJmZdq7aO6mmv3d1EkdymnzsF5ZukNWZq3+0O9
         AolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762650020; x=1763254820;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y75WeVh9hJ6IVQUJoOC/gRSUs+/cPxFQm1jQqSfBWSE=;
        b=f2A4Xre8lu+BLHBIN2TTe3RhoEiSpAsfb1cadxU1H/n1Eoz6vUbMIPd49n4NjaqCfV
         DLDbguJY+SvXg7+/9se/a7nmqRzQvt13nqN9El6KLCAcKb6KIwB5xx4XV2eaI9OQGxso
         YHQAAb1gVbF2+NVZtu8Uqe1re0cTgFqbtKD2tY60F1Viak1DqRl0q8I5aTcUHjJ0P4zx
         lZtzAdi3l5F0vnRljIYrEsWMYo5cAX4Um6DA3M2AKk3+mwk4bCFNjIM3vMeC2+dxq6bz
         xoLXH0yvcaR9uwLrSVdtNlJUsrKFq5OyLzij0xgWq5q+3ODFYMxl+PcDOes5QloYhQt7
         9uvw==
X-Forwarded-Encrypted: i=1; AJvYcCXGyTPQVlKFcEs3tiWXSgzVIpolEYthD0+/GNVgHKLp15m1wKoHsTLNpFU6+4mi88Ri7kEV5NNng4nLfSafdyhZ@vger.kernel.org
X-Gm-Message-State: AOJu0YznfHflKqPpbtqk/wLjQhcg67NZGN4I8QmTyukoM6quTjaz3yQD
	UNlGZUgWqLQXLh2gS6wTs01eaL/nxh6iHdcKzONh9uIXJIIzYe7L74LQdULE7dA+k0Kt5eCAWsw
	yO9dSr3HPAQ==
X-Google-Smtp-Source: AGHT+IFBWkwwvkk9VIwFOYjpj9Kza9G6P92OkFl1vCSi1xXLSNzNnEsJNGN3KkFU9gpd+OUj+2UuCJsfWjkC
X-Received: from pfay6.prod.google.com ([2002:a05:6a00:1806:b0:77f:6432:dc05])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2396:b0:7ae:d1d:d500
 with SMTP id d2e1a72fcca58-7b225b5b53emr4981014b3a.4.1762650020018; Sat, 08
 Nov 2025 17:00:20 -0800 (PST)
Date: Sat,  8 Nov 2025 16:59:59 -0800
In-Reply-To: <20251109005959.2540616-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251109005959.2540616-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251109005959.2540616-2-irogers@google.com>
Subject: [PATCH v3 2/2] perf test: Add test that command line period overrides
 sysfs/json values
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The behavior of weak terms is subtle, add a test that they aren't
accidentally broken. The test finds an event with a weak 'period' and
then overrides it. In no such event is present then the test skips.

Signed-off-by: Ian Rogers <irogers@google.com>
---
v3: Add workaround in case the raw event is matched (Namhyung).
v2: Add more comments to the test code and reduce the line length (Namhyung).
---
 tools/perf/tests/shell/record_weak_term.sh | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100755 tools/perf/tests/shell/record_weak_term.sh

diff --git a/tools/perf/tests/shell/record_weak_term.sh b/tools/perf/tests/shell/record_weak_term.sh
new file mode 100755
index 000000000000..811b00ffb47a
--- /dev/null
+++ b/tools/perf/tests/shell/record_weak_term.sh
@@ -0,0 +1,37 @@
+#!/bin/bash
+# record weak terms
+# SPDX-License-Identifier: GPL-2.0
+# Test that command line options override weak terms from sysfs or inbuilt json.
+set -e
+
+shelldir=$(dirname "$0")
+# shellcheck source=lib/setup_python.sh
+. "${shelldir}"/lib/setup_python.sh
+
+# Find the first event with a specified period, such as
+# "cpu_core/event=0x24,period=200003,umask=0xff/"
+event=$(perf list --json | $PYTHON -c '
+import json, sys
+for e in json.load(sys.stdin):
+    if "EventName" not in e or "/modifier" in e["EventName"]:
+        continue
+    if "Encoding" in e and "period=" in e["Encoding"]:
+        print(e["EventName"])
+        break
+')
+if [[ "$event" = "" ]]
+then
+  echo "Skip: No sysfs/json events with inbuilt period."
+  exit 2
+fi
+
+echo "Testing that for $event the period is overridden with 1000"
+perf list --detail "$event"
+if ! perf record -c 1000 -vv -e "$event" -o /dev/null true 2>&1 | \
+  grep -q -F '{ sample_period, sample_freq }   1000'
+then
+  echo "Fail: Unexpected verbose output and sample period"
+  exit 1
+fi
+echo "Success"
+exit 0
-- 
2.51.2.1041.gc1ab5b90ca-goog

