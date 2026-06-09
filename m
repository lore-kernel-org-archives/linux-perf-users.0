Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9663335E1A4
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016038; cv=none; b=NwMNWlXLdvoll5tn/5CvCDMajGwqgggAMILbAP2z0il2WVISbl6gJEM3thsJOIFbPObZorj4rienoH2SaFaVMnphisAaTPRgO1T4giM8qaZy2W9AchoJOdngX0tpp0U5qp6G+Wg2MXZo4XbZ1+5M1b2ossMT0zk4ihl0Gogx5kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016038; c=relaxed/simple;
	bh=F2wNljY7pGDf8SSMy7XsjQ1Brf2XH3gvhmbnZIrOtSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y0ZhpdDVaxJs7U80k1G+uz4FTDXnHaYnE8724m2i+NnBv+FDxEWS7tNKK17vv8jLH54izdV4zWL5OWfxB6g9McqmKyOuAh++MzhseVOzsdi3PrugBhwGugM/qZ0B2YnR7llFeS5bUzffC2IQ6ncSra8eutGAOExkIPBp2ssgD7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G+jkv2IG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G+jkv2IG"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490b613a17bso55407745e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 07:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781016035; x=1781620835; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=joyQ3Os7Olu2QxTrG0edDw8dpFFKX7es87b0fsuebZM=;
        b=G+jkv2IGxZbM+X6pyyloDVznQjaTbMebpgK84WLDwMe70DU/FA/IzB3+8Ejh2uNpkV
         RSaqkXz/azOB22otJnSeQ7noBRhi5tfpwTgUN4tInPb/OOaPEhyH6Cwdhb/VCFluEqni
         HD6EWjLC6nVOI9jl+MzvBoczycNnKAFHY1bI9MuB72sqQSpAQ/nY0JKgQu2SaebltGv2
         1lHHIfM2pG5kzVpYnOGg8fneWhYnYDioUfjAzQ2iY4uxA1Mjt465b666kMhIPHO7FUkb
         pY9eWEbKl51tea2tEd0vE0cGRaMLS+9CvH68Het2RubQGqT8fcltAPPdn8bExpjimpz3
         oong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016035; x=1781620835;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=joyQ3Os7Olu2QxTrG0edDw8dpFFKX7es87b0fsuebZM=;
        b=QjETpN4q3EfWBbaaa9TjQtEtXr41hfRvdLoEi2L5u/C0VmECUnlGNi7GaBlmwRzeah
         Mfa2+SvWP3Gb/C2lMNOSBjnQS8lNpLUeq/u7Pos+ioD/T7DcaS6LIbCZV+cRIFbiuo2c
         finDryOer/d3QZ76ADy7+0TFD5gSFXC8EZgeY8xaDGZ/0iIxnrv9kBTj+aAAZiyjuKiU
         G3mtBij7YpM7lb2uE23cCWMpwJeKQ0RAM46G/LlnAKxK0ly0iDxlomI4UENHc9RExV3q
         unryyPsxkfqQ+myu3VgoEp/iVPHJaH9rCvrr+FDztbWUiKaaV44jdwswSVaiFGYGbOSA
         NulA==
X-Forwarded-Encrypted: i=1; AFNElJ8KG0IYxLnIK42/SqwzuqtbJKzd3zHUKZY+ht4dZ0HIsK9VzdNcOhtknkXAfvT/ekx+zRYKgUIaOZs0SWS+FuSy@vger.kernel.org
X-Gm-Message-State: AOJu0Yz359gQKh/CM2F9JnGian/jA94O1PpllQMuDf9rUatl36QuaZzB
	hWdQEh5GHXooKioJcgnKE3ZWBuXiz1Dwdad0/ZEAYXhPygMDMa11Y5+fUfznArpdfws=
X-Gm-Gg: Acq92OE39zdihbPM1eNSywi/Scgi5C6HRvWEgX8JSAYde5Fvd09ZvVlUk3s2wNppKbu
	YWb7lTFmUinre7krsCGPJFn8VAaSrIcdSdy3bdKD4RwH0XMc6GfajJo5ZWm2sL/2RYVwba90O55
	i1fkmSMKaEMi/e0B42OOrVRipfMJjrw6vVsxxQfWrtYsS8dShFdDt4oyw5xLNKrtizVj9Spk0Hi
	fffp2HZck/TATlNyC/0hnszo71khx/CkINt+o9Wn858N/q4HtYcPsgCJwR5wb7/jxY6ok4C+nem
	sJnMj13rgD2k1JKxHXcvu3sA+UrTR0oui/44mBef9Q8cXl61rgt9rTVUqyWZMm68dAGJSZH9WhD
	9mOuZ7NWkxqYKo+mMpibaD/TzUfcxA8FWG5wKUbrwVXjXuHZXUsZXjgqA5MxxfCGRELVGhz0i5v
	bVnxAWeBvael5pXk9t2ve8hruQfB9vZ8/aKHN5CwkKa5w=
X-Received: by 2002:a05:600c:1d0a:b0:48e:5d91:cfe3 with SMTP id 5b1f17b1804b1-490d71ecbe8mr42059245e9.1.1781016034975;
        Tue, 09 Jun 2026 07:40:34 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c1149sm428411935e9.4.2026.06.09.07.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:40:34 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 09 Jun 2026 15:40:13 +0100
Subject: [PATCH v5 08/19] perf test cs-etm: Replace memcpy test with raw
 dump stress test
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-james-cs-context-tracking-fix-v5-8-d53a7d096a19@linaro.org>
References: <20260609-james-cs-context-tracking-fix-v5-0-d53a7d096a19@linaro.org>
In-Reply-To: <20260609-james-cs-context-tracking-fix-v5-0-d53a7d096a19@linaro.org>
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
 .../tests/shell/coresight/memcpy_thread_16k_10.sh  | 22 --------
 .../perf/tests/shell/coresight/raw_dump_stress.sh  | 65 ++++++++++++++++++++++
 2 files changed, 65 insertions(+), 22 deletions(-)

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
index 000000000000..bea70d825596
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/raw_dump_stress.sh
@@ -0,0 +1,65 @@
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
+# Get the size and offset of the first AUXTRACE buffer and the index of the last
+# packet in the raw dump.
+read -r size offset last_idx <<< "$(awk '
+	found && /PERF_RECORD_/ { exit }
+	/PERF_RECORD_AUXTRACE / { found = 1; size = $7; offset = $9; next }
+	found && /Idx:/ { last_idx = $1; gsub(/Idx:|;/, "", last_idx) }
+	END { if (last_idx) print size, offset, last_idx }
+' "$tmpdir/rawdump")"
+
+# The last Idx minus start offset should equal the size of the buffer if
+# everything was dumped. Allow 48 bytes difference to cover 3 frames: current
+# frame length, a partial frame and a final empty one, all of which aren't
+# dumped.
+#
+# TODO: for a single snapshot, offset should always be zero. However, we
+# currently output AUX records in snapshot mode when we shouldn't, which
+# increments the offset. Allow for that until it's fixed so we can test raw
+# dumping.
+decode_size=$((1 + last_idx - offset))
+if [ "$decode_size" -gt "$((size - 48))" ] && [ "$decode_size" -le "$((size))" ]; then
+	echo "PASS: AUXTRACE buffer length matches dumped packet index"
+	cleanup
+	exit 0
+fi
+
+echo "FAIL: AUXTRACE buffer length mismatch: size=$size offset=$offset last_idx=$last_idx decode_size=$decode_size"
+cleanup
+exit 1

-- 
2.34.1

