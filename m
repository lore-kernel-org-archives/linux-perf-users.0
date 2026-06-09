Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE22035DA56
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015492; cv=none; b=tmzXRUaBNnjWwKb1ewkGFvyXJCd6/+OVnXC8yLwEIKCbn0WxMaFQ8Zq19DeqHgUO8PaavClXS6LF6OeIjtaVxQHEa9fHwHXxG3zT5U7ZDNy4bATIP9aS2VdeUCKmzFGxV7D8vsGk+A7qiRAM5rx1uZlcluIyK9Dyal14RoKN0fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015492; c=relaxed/simple;
	bh=z/CK3SgmlZ9m2fa4g/8u8Ev0tF8YBHx5+5672AAbTpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AVQfQ0e/UmPKGvC4CHXUAoZjMSt0dZuDWmCM1eiPv2ZxW2t99xOtX6+UUl3g5PB71acmiK/Amf6X6pZ5tavbeA64tN1KgmxhEcY5JWtFtTxmLeRp8VQYneIZfeA5Q/6A3yTh8/8HSG4JoS9jTnB6x81kOkgtdXI9dC88A7+NnO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lM0tb1B3; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lM0tb1B3"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-46019b190b6so4210772f8f.3
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 07:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781015488; x=1781620288; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=26hfOEeOS0Wp3zVqiYKicdVNnt8eBmuZdvoqTuUrIFc=;
        b=lM0tb1B3qTslKooVKv2zQ/miywEtBFXTS/3TBPOofF6uYTYJixd9caB4Gkv7HKMHNb
         1uU9LFwZwQ8VV7N1bQOmZu2fZdUJ+BNe4pkLVCuHqgERgQLKsm0MK03BIzJXj3gOxvvp
         pPb9pfRmJN1H6wsvgX92tCDMroVixShtp5cNUfDKlKn+8/nRAjRcS81m8bP7Uq0hSq6I
         ykq0UwsH27zvVh01BcGTi26Vs72Nb2gN1FFbv/c74qgUxyFlpcoVujm4QmIM2WSKZGTg
         dimsfmPA4Rd4m1XRQHkOdMJdeL6akhMzBr6smUZPcHG2qN/tHQlhbKAJPVU+Hbsl1DjE
         Turw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015488; x=1781620288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=26hfOEeOS0Wp3zVqiYKicdVNnt8eBmuZdvoqTuUrIFc=;
        b=fRHBfpdIjYjvzNnHa+wrWNPdCN/egxBCEAbW2rS/L9g9lgpodXNMfyd6VGS55OgjsW
         Yu4bUNCuNXe2uccESy5Wwm8yh6Vzkb6R0WhWeDCo6xZDYWf+ZJuyC8OCdQEvBpdQLNco
         YahwVK6Z1/FbAw2KItY+8jHNRZEkopFnsODPt8i8SxZPqryihS10AFj0mScPD2zpBZxv
         ZoYmZ+QNB4i5l1drM5qm2Lg5MwfZJLP2dxYvGCNeasYbpiI19zZ8bpWtVGWWnC9S4Nw5
         M654TPdtUzk9r589a8Tq0U7/ugFkj4LtBgexEi4pMhuehUGAfDhSSyoDlxSJg6oBJhh9
         kXyg==
X-Forwarded-Encrypted: i=1; AFNElJ/CasNWw0d2MEnRlNZJLLczwlVdHMH9hK5OJjxihOlts5Ulzc1FbD1zlKKj+npFWM+JVmjhOH4wBzs/0nJERqQa@vger.kernel.org
X-Gm-Message-State: AOJu0YwmWdDfg5BZXCwpa8cZDJtD2mQDi8I3G5OjnRTvsO4vBKiaiJn4
	7u3BZTV2+I+mIsd3CNZFzAd/ZNdcT9MiAjgiWmQeQd8NAxkZ1cRwxjqU/rlcfubbKiQ=
X-Gm-Gg: Acq92OF9lVNpO/0HN3v7/dairAqKOfquTyr+ejWLht3jtE7jMkOE2PuRDARjP+jQjrq
	pQ8njCp/5wRGmsAHmf0fruk28Ylydc/Wj5od8Sof8GDgro8ccOSY6yWKQMYgBOiydLNLgvaLf4z
	ekrDQpJTJqTWNMU0/hVE4IUQwwg8nMjn926aFuPiwg6NHK0SBgWdaNuFodDyDEtwyx92CFdJNzZ
	VvN1g+Z2vf6XNSyIhCq0zC0NZBIw+8cQ0v25/nDTBAb4J85AiJteDAdPTFFF9j573Q5+Q8bnx35
	wrbF9lXMGKzZtBVtoUrY/1qZvjCp1eiF6CAES5fbofXU+stO4FtS3oie9CXLFHcWf7qIKXXy6LC
	tg+4tDVG9lhxTlkNXj8z0ZmezTfkIkNdbuvMAmCmGCwjFK4NBAJ3Gd33noTd9fS7ZN25zj9oG1w
	0KG1ALiDpSIidztLofVCWQCnmLvr8CYNsXBZ1wnNTukpU=
X-Received: by 2002:adf:fe01:0:b0:45e:ec18:f207 with SMTP id ffacd0b85a97d-460305061ecmr22846190f8f.25.1781015488377;
        Tue, 09 Jun 2026 07:31:28 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3444fesm62738388f8f.20.2026.06.09.07.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:31:27 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 09 Jun 2026 15:31:01 +0100
Subject: [PATCH v4 08/19] perf test cs-etm: Replace memcpy test with raw
 dump stress test
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-james-cs-context-tracking-fix-v4-8-44f9fb9e5c42@linaro.org>
References: <20260609-james-cs-context-tracking-fix-v4-0-44f9fb9e5c42@linaro.org>
In-Reply-To: <20260609-james-cs-context-tracking-fix-v4-0-44f9fb9e5c42@linaro.org>
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
 .../tests/shell/coresight/memcpy_thread_16k_10.sh  | 22 ----------
 .../perf/tests/shell/coresight/raw_dump_stress.sh  | 47 ++++++++++++++++++++++
 2 files changed, 47 insertions(+), 22 deletions(-)

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
index 000000000000..b4b4f2503fee
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/raw_dump_stress.sh
@@ -0,0 +1,47 @@
+#!/bin/bash -e
+# CoreSight raw dump stress (exclusive)
+
+# SPDX-License-Identifier: GPL-2.0
+
+if [ "$(id -u)" != 0 ]; then
+	# Requires root for larger buffer size
+	echo "[Skip] No root permission"
+	exit 2
+fi
+
+# If CoreSight is not available, skip the test
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

