Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F297402B96
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410450; cv=none; b=KzpdmHdTM3GWnmUBU2Z5WBfiteWblMlaHzzx26kxBNhqzFhEOQ+BfcIgn6uF7gHMXXdk9A3PkFHHXA3JpIaLseA0I5fPsJh8doQZbX0i9fuB0IF4OhhwiIs4fx209nDqHrb5dYTf9NpcUAbskkJfBhW4ZclGcFGw3H0bdUl+71c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410450; c=relaxed/simple;
	bh=ESmfjIh7MN23IeBJPxwPdBU7xBIa18aM//caXhGjZcM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ER4SQ32Yetw1h/HUQoMI5kZo+5tmpTNFXnV2kq0UhZJV64YmP1c06vuqWIccoi7jRasPgx9bzJzIUR2B6r2l6w76bU4BrVKRlG8val9J/UkV3WvrOTwbv6/xEdJ3BHwZ+Zposn6Ncq/v5r4XZVcwZU2TWpEMZ90qKB8Ppdb7egI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nKb6xbwj; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nKb6xbwj"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45ef1629ff4so3334615f8f.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 07:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780410447; x=1781015247; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXjR0tiVSlnNG0AciIMM1oZd4f63sbXFpo0GMT42zX4=;
        b=nKb6xbwj3tP8iZMpReZNNT6dFQ54cs+fIsXJZzkzEpY/L9cznx0sOzeoS/3ITOlc1B
         73QsScaMkcLsA0Dro4o9UWHyKZPKZb3ba9yTo8rPrzY1VAbqwayCwOvm0sEJSl3iO5HN
         OAlbVFU8fqgufRBsw7s73OIDFakRQJAJEdkEiVOsgFPpnnbG3S6lyNDGsf27E/dQa85n
         PacYZcthUKtgIvSPJLX0GDBeGSxH00Yafn0kvj9BHRG0otz+jUn93XbW1Gg2p2OpqJA8
         0P0+Xf1fMuVxG1zJsKTRO8EEqN0OUNsEGaac8zEm0DgQuOHf/nx/Yq0jA5PKMWJpshQ2
         10MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410447; x=1781015247;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pXjR0tiVSlnNG0AciIMM1oZd4f63sbXFpo0GMT42zX4=;
        b=HrUQOxPt4ijIfDGQBvAPeNuEscw+yGghW1Dy3bmBj4NBlqlXFfoPcmH+MxkoH7J6PY
         YFPALhZ+yV0iv/KKrVfirdXtE5Y4JpoKN/N0zY/wuHia1wMfAkcRQ/9RKYhuBOdTa3w8
         3VFE8RbY0l53jMwLGaIEWsvTIKhT86tWsiGDnfBSi++w9m9euWBw6Zu3+2dtZI6eatGD
         9BbXaU0K+GLSMKc6NWJ4sxhNMMG5MWRAm5bBEBcVWp0DRQnuxyPSqrgQIjfWBkdKMeiw
         5l8Pt4SS5gTAaI8/6UXUWwPl159xHRIUhkghJ9zfZjrkSj3IUJrwzuA84Ozca0z+XhXU
         rODw==
X-Forwarded-Encrypted: i=1; AFNElJ9/hyiTIA13Wb1HkcAiPzd4V20sLMoHA7IrKhpbInyQalx7/2nhmw4EmOn0CCI4GtME10JwT6NzhROxUOHM2ZW8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx84jwEVzPHhu8h+bXUeA4HUQ2Oi2dS6QaHe5uTb/Og0qmvZg5H
	Pqo6ZtZA3zTzkgh302qXxSotg1z63//+VWqAUDFgahAtE2pyS+lKcU2dsPHLGzPv39I=
X-Gm-Gg: Acq92OHn0n2OLbIuEdovWIqJ9DXrN3shWITuR7rz7Xyc9zBN7pllrWi7XPdHhpemT7W
	DMcV7DmRcH/KLjOQ6lqiDn0YGgQKP6BGGBPLpaMshXAfmEJ1QN5sct4GuqpgFVymG5o2FkwfeYC
	xXZPJzwrvBaZOFlGkrTaSHBSMKH0jQJkuH6ZkIxEVqOMS+RzFEABXnr2gh3EqU+0+85RSciSMvo
	iPBOAu/wYXXMQqz9kMRKtE+ofGos9erLTs9Tdf9R3z+Lx7adkcaqdy2zO9ZMrzU59VqkDn1PytQ
	8ctFAfNjnZoU0V+nBOGZuTdpblKDC3lx+1S/HXHZpkpYXur4avsUGBn3wiXPfXIpy+xUERbualD
	EKemC8lwUka5kVuT3oyNCHG23p2/Ly+WDZZ6Rw+qS/V/7Kj9qQMJ4TRgYdCjx7gtF73ORtXw3kg
	m3Cr/mZsqZyUk4U4xw7HCfKdgPaE8HYEg7pcQT1KwLOKU=
X-Received: by 2002:a05:600c:6098:b0:490:b1b8:95f5 with SMTP id 5b1f17b1804b1-490b1b89725mr62646115e9.15.1780410446812;
        Tue, 02 Jun 2026 07:27:26 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e18e1csm66771965e9.4.2026.06.02.07.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:27:26 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 02 Jun 2026 15:26:48 +0100
Subject: [PATCH v2 06/18] perf test cs-etm: Replace unroll loop thread with
 deterministic decode test
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-james-cs-context-tracking-fix-v2-6-85b5ce6f55c6@linaro.org>
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
In-Reply-To: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Paschalis Mpeis <Paschalis.Mpeis@arm.com>
Cc: coresight@lists.linaro.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-doc@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Testing a long sequence without branches seems like it would be better
as a decoder unit test, and this test doesn't test decoding either, so
it's not clear what bugs this is trying to catch.

The new deterministic workload has somewhat long sequences when built
unoptimized, and we can always increase them later if we want to. But
now we test that decoding always gives the same result for the same
sequence of code which we've never had before.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/coresight/deterministic.sh  | 71 ++++++++++++++++++++++
 .../tests/shell/coresight/unroll_loop_thread_10.sh | 22 -------
 2 files changed, 71 insertions(+), 22 deletions(-)

diff --git a/tools/perf/tests/shell/coresight/deterministic.sh b/tools/perf/tests/shell/coresight/deterministic.sh
new file mode 100755
index 000000000000..52e033fd6b82
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/deterministic.sh
@@ -0,0 +1,71 @@
+#!/bin/bash -e
+# Coresight deterministic workload decode (exclusive)
+
+# SPDX-License-Identifier: GPL-2.0
+
+# If Coresight is not available, skip the test
+perf list pmu | grep -q cs_etm || exit 2
+
+tmpdir=$(mktemp -d /tmp/__perf_test.coresight_deterministic.XXXXX)
+
+cleanup() {
+	rm -rf "${tmpdir}"
+	trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+	cleanup
+	exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+cf="$tmpdir/ctl"
+af="$tmpdir/ack"
+mkfifo "$cf" "$af"
+
+# Start disabled and use the control FIFO to only record the workload and not
+# startup.
+perf record -o "$tmpdir/data" -e cs_etm//u -D -1 --control fifo:"$cf","$af" -- \
+	perf test --workload-ctl fifo:"$cf","$af" -w deterministic > /dev/null 2>&1
+
+perf script -i "$tmpdir/data" --itrace=i1i -F ip,srcline | \
+	grep "deterministic.c" | uniq > "$tmpdir/script" 2>/dev/null
+
+
+# Remove open brace lines as they may not be hit depending on the compiler
+sed -i \
+  -e '/deterministic.c:8$/d' \
+  -e '/deterministic.c:15$/d' \
+  -e '/deterministic.c:23$/d' \
+  "$tmpdir/script"
+
+cat > "$tmpdir/expected" << EOF
+  deterministic.c:24
+  deterministic.c:25
+  deterministic.c:26
+  deterministic.c:28
+  deterministic.c:9
+  deterministic.c:10
+  deterministic.c:11
+  deterministic.c:12
+  deterministic.c:30
+  deterministic.c:31
+  deterministic.c:32
+  deterministic.c:34
+  deterministic.c:16
+  deterministic.c:17
+  deterministic.c:18
+  deterministic.c:19
+  deterministic.c:36
+  deterministic.c:37
+EOF
+
+if ! diff -q "$tmpdir/script" "$tmpdir/expected"; then
+	echo "FAIL: line numbers don't match expected: "
+	head -n 100 "$tmpdir/script"
+	cleanup
+	exit 1
+fi
+
+cleanup
+exit 0
diff --git a/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh b/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh
deleted file mode 100755
index cb3e97a0a89f..000000000000
--- a/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh
+++ /dev/null
@@ -1,22 +0,0 @@
-#!/bin/bash -e
-# CoreSight / Unroll Loop Thread 10 (exclusive)
-
-# SPDX-License-Identifier: GPL-2.0
-# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
-
-TEST="unroll_loop_thread"
-
-# shellcheck source=../lib/coresight.sh
-. "$(dirname $0)"/../lib/coresight.sh
-
-ARGS="10"
-DATV="10"
-# shellcheck disable=SC2153
-DATA="$DATD/perf-$TEST-$DATV.data"
-
-perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
-
-perf_dump_aux_verify "$DATA" 10 10 10
-
-err=$?
-exit $err

-- 
2.34.1

