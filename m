Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EA330CD81
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Nov 2025 23:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762472240; cv=none; b=t8TPGDJknRFqGGue7QT8l7KiJ/RC+Y2KIoKpecJarAGki3SRyF7ASjS6iOF9PvICiXi6sZmOQPkhXPI0I4EpPD1AzNgaOF1h3omsfrXXI7yctRrZaMCrvK2kPrw7fHP2wnkXJNWU2TMLhYVnE61e18cPSLQkWm4HJPHlcvC3IoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762472240; c=relaxed/simple;
	bh=E8lCNBSq2zsUURqBHlWd2s81swXxbp5kFWyo3FBgAyY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=rnWJxnQLa8lEGXqdp3gAQaRn261XxV4dUurCFKHj3c7mMY7kcBRwNUKxmF3MGijtiF5+0oxD/m4afnEKSlP+Ph/uuVq8lY+hRzPV4Y4pJBuX7GkRrTw4505EqxEWF4fmpiNy9dxpQ8DiC2DGoHgqJN3VnKianMRpAudxbmUlIyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jiN+10x2; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jiN+10x2"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33baef12edaso265612a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Nov 2025 15:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762472238; x=1763077038; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UhPn371rRTmwpTgziL2vZff7wYdJsZbdvhfMPIsIcC8=;
        b=jiN+10x2dGeNZX/M9m3zLIM+bIVyU1PfeKiXkibaHtqhhkq+QT+4F4+emnvGMfC/bv
         TDCTDipuhDziqZ2li+exdcVysqZiJ+ZC1gA0fYiPOy9cHqJ6eEBSzgPpuMAe6aVwo1eC
         dTLnxU0mo8iGcHgNQ1jWK4aAOQFIwMwZ5L/QdrMixvWgWU/lWvwYsC9DwGVFaHc6yU0l
         diATrP66F93p16mrv+YUcJfJgn4ZIXVQJqR3z1zQfXWxnU64irjmKHL+QTL1oVURQxpw
         ++fbFg3TxWRm88z52izTJc7Nua7w8nlCPpvw+nJtVNCqh9LLrACyUKZRC5W53YS2PGWi
         9keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762472238; x=1763077038;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhPn371rRTmwpTgziL2vZff7wYdJsZbdvhfMPIsIcC8=;
        b=HXuZDPjNx3dLkUqn+IOKvr2yhI1A8R9GFy1F6uMHfJ+uDFJJZxk4yG7VsgjFZ1GIRD
         aa5a2sMvUmfjthpj6LiM7jgMBLSY+mW2W9UfT5mZQcneN/QXqDc30I1ZnFfRR4Ir+0U7
         wdUJ2Fj5eHH1EFF6eeLea9SOSDb7gz2kpjD9et7pJOP/+EKKf398aOssPhFDrlRqYQ0p
         iDxeSiiaQa7afrRd4j8bMcZ/ZjiyEsm4l5Ln93nFe2DDwHTPrh8VZoEKFBvoMATa5la6
         KWkjPhDvf3mkmqrMWfzer73+T4dvq5Kl0OdMFMr6v1NLL/RlIA5SMMsx7kGfP7b3vnIh
         PyHw==
X-Forwarded-Encrypted: i=1; AJvYcCWvzrVHOT4G8OzFsLWcAHfvfNpKdSZNNhqnnaTnFAqcMAaZflZhp83DLUj0GxanTxoGBtCLsHoXP5I0F9nZ0TzM@vger.kernel.org
X-Gm-Message-State: AOJu0YwSHZqgbsDfPkpo9IaCv7G/W4IAI+QPmFJEgQOFMvugAtCPdDhS
	yxz7Gi20dVoBhC2z7HKmAaSI4BjzpoqzGhpB5MM6JsbYrNj9+/E1OjwtlhNfzsCwgW0zSnyYNXs
	8L+a4D1UGww==
X-Google-Smtp-Source: AGHT+IGpF5GWmGf5z+TEaBLV/cYs/d1jA5D2wAFGypWU0OcKJl71hHdbhDQ+0Ga6hGEjOTNrUtC63lFPdH3d
X-Received: from dlae14.prod.google.com ([2002:a05:701b:230e:b0:119:49ca:6b9d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22cb:b0:269:ed31:6c50
 with SMTP id d9443c01a7336-297c03b66e9mr13552855ad.10.1762472238513; Thu, 06
 Nov 2025 15:37:18 -0800 (PST)
Date: Thu,  6 Nov 2025 15:37:10 -0800
In-Reply-To: <20251106233710.463949-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106233710.463949-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106233710.463949-2-irogers@google.com>
Subject: [PATCH v2 2/2] perf test: Add test that command line period overrides
 sysfs/json values
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The behavior of weak terms is subtle, add a test that they aren't
accidentally broken.

Signed-off-by: Ian Rogers <irogers@google.com>
---
v2: Add more comments to the test code and reduce the line length (Namhyung).
---
 tools/perf/tests/shell/record_weak_term.sh | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100755 tools/perf/tests/shell/record_weak_term.sh

diff --git a/tools/perf/tests/shell/record_weak_term.sh b/tools/perf/tests/shell/record_weak_term.sh
new file mode 100755
index 000000000000..ee4bcc792aeb
--- /dev/null
+++ b/tools/perf/tests/shell/record_weak_term.sh
@@ -0,0 +1,36 @@
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
+    if "Encoding" in e and "period=" in e["Encoding"]:
+       print(e["EventName"])
+       sys.exit(0)
+sys.exit(1)
+')
+if [[ "$?" != "0" ]]
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

