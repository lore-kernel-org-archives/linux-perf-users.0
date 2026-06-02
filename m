Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883043EDAB8
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410452; cv=none; b=jjCbvThxcEp+ObOTgIc4gGgUzoSTtO8GBjlUZHgJnS1gqWSkmEnJIW/J0flfCBptGV1QS0vqLK1kZNv9n5V4sDGh+vWS4/wma+ED1yatbmBkAgX2qNLaCzqyG9FGsqA/pbKbTXeX0Ea2X7JVquCZqL1UaGOD95sMD5rMF29tLRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410452; c=relaxed/simple;
	bh=M0DBrbePhZZ9AcxL0wzd3eII2+Wy6jGLW0uhbY83wV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JlBql2nW5BjT2MjCs6vHfT3KvS0vyBf+eMh7lDD4TSUfBuWKoqlLOYQL8yy6Pqjr0DpwkoRKqXRNDFxLYM9T2EAEvLblMhXr01SKdKUuh39j332QwHnRFrm72W/OpiSfaN2+9iUxllcpQC7tL+JnQdBD8+fsQGu8GaYDHlW/hmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fCNqifA2; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fCNqifA2"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490b211ee6aso6995475e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 07:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780410449; x=1781015249; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K8cRFQhUyrwRmvsS4WIe5Iy8r1Z7mMJ0S3vhGU6hRi4=;
        b=fCNqifA2Ge+bh4ToY7XRKEK3wTL6XYlEV9uEXFDiSOfCwk7lNWu15611po8+uz4lLj
         0S9gtJT/wh9LWjC5zYfWpUE67iRmcsiJ8RoBR5lMod2wFMIuWYkPWq7t3Cyp9ZJ4dqGC
         UmrBgezcOCXLMxDMr7rLf3TIdEZVcPAY3viA9jp14+jPM3c5giejEiFgUPwPxgyVFu7m
         FSrNxdaxfRalFsDjc600CZP27SryRw9T27XSx3rOXiq1qQVbMDhid0qLiUVzdWa/NeKH
         S1KfVqYqMfwzrEzoYE0vBmErINtl6nyh52sbF41GOydNGdFARMd17PLEE38QnW37GOKi
         nHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410449; x=1781015249;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K8cRFQhUyrwRmvsS4WIe5Iy8r1Z7mMJ0S3vhGU6hRi4=;
        b=S3Jc2J6gwb5BGHZSCRoMcn5nvE5ivLCik8WiWtwmAxlDFNLZvYRLxcWm0IOTq55oSg
         YRd8pXmp0F2N2eXkJpklbI6wEDDkPruKBU+UL4nTcoWUW7Gqqhp0tuGhdB4XQIpyV1qo
         l+1Oy6YXFYD+RNlrnWhc1cRmU6iyMoRcRI5eVM7+N0ndjf88TyR2BASVFlhOCopRFgSO
         lGc8Bhk4tTTTEQhXxoOUQxHXo3FP5MIOgyl8wBpKRYdZYCw2R7eOwSabegrbVs5lm7gL
         REouePq3XmUG3/3bg0EWHBBhCG+RypVhfqvxLjjy//WtJ+Uq4LfYcjW8Z78hHB1Kqk8z
         Il9A==
X-Forwarded-Encrypted: i=1; AFNElJ+JSbjpPK8f9EQeTp4oZclXbZLgpS7Sn+B9y5/8yDvKRqOL3EraX8y0XsQg0UHF9RHBmsGadIUDh0BOJJfXZ1xF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Qr3q7/UCr+pOQg6BWIM9GjCwXbRV/+L5+XqSVaQeXOUrwiRw
	U1YQjeHIhGnU9SKQ6/v4oNcvpjb/u0bSNvSrJD1OpuNkZRWNnEHto9ZEKjg8zmkc+hA=
X-Gm-Gg: Acq92OG7YbcI26DrOjInLP2GCIW1RMaZ4Cs40/NpJ49L4SW0k6OVqNTMOQVzxmaqMHG
	kWrv6aYnz5XiqqZ/jcW4uVKuTzVvB9NOLi215O1cR8BSLguXCsaOanTmtFJORLw7BeHaajHUhW5
	1jCY1AKjKeN/mWU7jIELoD7MoeFi3vHZJk8+FpP51a7p977p42+iFAp7r400ofGfNYR14FgL0zN
	yCM51BoZGTzH7JQVFI3kN98g/IVQ/WMb5RwXu4qCzSXNBjacf5bCyAtYJpbvrR1vPbZQb7Fh98h
	v0C+4Mz1ckY/J6qVixz0TtKBAE9LJJ3tdzPg+78RSfasuVGT4to1u7/5MXDOJt6srKDU4+XoUrr
	UYScmJ/AvVanCnjPlPNJzVwMsI4tHJoxHyO/L4npDxO8XPEK+hItM6v6xzDhN7dbIgU9OC5GwoM
	rPkMFWPe+3QXM8tzzkcP+YrnBeb5rKt3n8qkROJ/9iGZo=
X-Received: by 2002:a05:600c:c108:b0:48f:d612:3c4a with SMTP id 5b1f17b1804b1-490a2923a71mr217561125e9.1.1780410448893;
        Tue, 02 Jun 2026 07:27:28 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e18e1csm66771965e9.4.2026.06.02.07.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:27:28 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 02 Jun 2026 15:26:50 +0100
Subject: [PATCH v2 08/18] perf test cs-etm: Replace memcpy test with raw
 dump stress test
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-james-cs-context-tracking-fix-v2-8-85b5ce6f55c6@linaro.org>
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

Like asm_pure_loop, this memcpy test only checks that 10 of each of a
few trace packet types occur after recording a lot of trace, which isn't
more specific than other existing Coresight tests.

Assume it was supposed to be a stress test for dumping and replace it
with one that doesn't require a custom binary and checks for a specific
amount of raw output. Don't bother checking for packets because the
other tests that test decoding will catch issues with malformed data.

This also adds coverage for exit snapshot mode which was missing.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../tests/shell/coresight/memcpy_thread_16k_10.sh  | 22 ---------
 .../perf/tests/shell/coresight/raw_dump_stress.sh  | 54 ++++++++++++++++++++++
 2 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh b/tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh
deleted file mode 100755
index 1f765d69acc3..000000000000
--- a/tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh
+++ /dev/null
@@ -1,22 +0,0 @@
-#!/bin/bash -e
-# CoreSight / Memcpy 16k 10 Threads (exclusive)
-
-# SPDX-License-Identifier: GPL-2.0
-# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
-
-TEST="memcpy_thread"
-
-# shellcheck source=../lib/coresight.sh
-. "$(dirname $0)"/../lib/coresight.sh
-
-ARGS="16 10 1"
-DATV="16k_10"
-# shellcheck disable=SC2153
-DATA="$DATD/perf-$TEST-$DATV.data"
-
-perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
-
-perf_dump_aux_verify "$DATA" 10 10 10
-
-err=$?
-exit $err
diff --git a/tools/perf/tests/shell/coresight/raw_dump_stress.sh b/tools/perf/tests/shell/coresight/raw_dump_stress.sh
new file mode 100755
index 000000000000..eb5a5e5e1be6
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/raw_dump_stress.sh
@@ -0,0 +1,54 @@
+#!/bin/bash -e
+# Coresight raw dump stress (exclusive)
+
+# SPDX-License-Identifier: GPL-2.0
+
+if [ "$(id -u)" != 0 ]; then
+	# Requires root for larger buffer size
+	echo "[Skip] No root permission"
+	exit 2
+fi
+
+# If Coresight is not available, skip the test
+perf list pmu | grep -q cs_etm || exit 2
+
+tmpdir=$(mktemp -d /tmp/__perf_test.coresight_raw_dump_stress.XXXXX)
+
+cleanup() {
+	rm -r "${tmpdir}"
+	trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+	cleanup
+	exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+# Use exit snapshot to record 2M of trace to make about 80MB of raw dump data.
+echo "Recording..."
+perf record -e cs_etm/timestamp=0/u -m,2M -Se -o "$tmpdir/data" -- \
+	perf test -w brstack 20000 > /dev/null 2>&1
+
+# Test raw dump runs to completion but don't decode because that's too slow for
+# a test
+echo "Dumping raw trace..."
+perf report --dump-raw-trace -i "$tmpdir/data" 2>/dev/null > "$tmpdir/rawdump"
+err=$?
+
+if [ $err -ne 0 ]; then
+	echo "FAIL: perf report failed with error code $err"
+	cleanup
+	exit 1
+fi
+
+size=$(stat -c%s "$tmpdir/rawdump")
+if [ $size -gt $((50 * 1024 * 1024)) ]; then
+	echo "PASS: Raw dump file is larger than 50MB"
+	cleanup
+	exit 0
+fi
+
+echo "FAIL: Got less than 50MB (${size} bytes)"
+cleanup
+exit 1

-- 
2.34.1

