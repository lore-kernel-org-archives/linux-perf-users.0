Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0BD3AC0FA
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481859; cv=none; b=u7yPo3l18kRW3J1ZryyO8k6S+CKWIS+O3KryLiDL9Bg7Ku2Xmc+G/AIyA4izAzPFp94vyORsCCuXAUjfgq29QVyatTnS7QhZgklp1BF8M+egVy+B21g5phzbmA8/eMOrc17Cq41a2ORsRYMEFQPzMIBTIPuhO+zg6MUE9JZMIiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481859; c=relaxed/simple;
	bh=AU+sY8Tp8BoY/5+w+fRDQW7PbvnqFbEYKQkcr4EdCQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A9fzR8KA7QhqEHBItHYnbVslr5a2rOEncroiSpDiw/AqPGJkVeLZ5T46oGwfRl2HyF2sb8S0MEGW3cpa9g91Fc/a89dt+iAzoxhKlcdkyGW5kccXsoKiShrqjvNBKPfMIx7Q8WcLaVSRA6qAQhky3c10ETmiUXY9+gmLGRA1ep8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OFn9BEw4; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OFn9BEw4"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4906869f0cbso120902835e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 03:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780481851; x=1781086651; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+q+4Ed/TH/GWugEEpgBe8aXsgoIABynsgFsrNm9YETo=;
        b=OFn9BEw4HbeUrGBqquFQXvAXofh1eDoK3IzdPrBsa1Vxey2jj0XUhSO85tOQHDsES5
         WlscMkdaMDJADj5KSEzT6Si5h0Pq9q1sIIQg3m+BmGZ6Y7rdFEETNJ3I/QoUS/ctPleO
         vZfGKTeW+jafpLb/t0FPQL7hZUIyX/iYt+zf71jp80yVxiLXKK3GWjBOK9Twnjk0PGyU
         QEt+3XgirZ6Ve0cy/vQ9YeBGE10Anb7nJUNEwNWC2ACj0VdOa34epBE8M9QS7jFXGT2+
         MvbV70h7d8r1tCPV6Hb5mYQIK4xMV4biiuFMRDw1W20Xl5EeO95osUODFqZkDFf6mi03
         EzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481851; x=1781086651;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+q+4Ed/TH/GWugEEpgBe8aXsgoIABynsgFsrNm9YETo=;
        b=R+el2pz+YQBZNOlr8goJg0r3O0kvSL3KuK09KyR9rK1/DGAXffHk0fbs+Aq5P3uMRR
         H0kv0X1MuB3qeS4XwGsV3FkcAPAfMsQ6Wqe09VJTTL/oRg0JQcJcsb+G+c2B0ncEsre0
         QWaSEjKjcL8pnrLHLYTkePr/aML8/+l2lqov6IMDGYUa5ZzXQq0OEbGIORwhnFw3FKvN
         1fJ8ByWRCSDniUh06NTdXj4V7eh83TIfSycEAnaFE/PB6VkHSgsPUNb+VN8Wk4tSZkix
         NBVrn2Dj99Rcugwlw7aPcxW/gY0Dj05ptt8iygAVbbtD2bjC5e2ruFIRdYp1oNuLuWbf
         9hxA==
X-Forwarded-Encrypted: i=1; AFNElJ/xXH1y5F8JoqS/jlaHcA/PAVjKAbXxKeSliR4M2GBA1AclvTNoJJ30BsO0fNqTwE4WpYYCSvN+Xl240urpg22k@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ls7jv4bTpAwLy72OtVmnC+r/MsZi+O8yFx+of9w/m8cxFlZT
	EgZyx3OfIZp7xh/RNz4M8drRCZAUcuvjvJYr7Vvdloqwt7goJ4bszFR2CWClqZNDsKQ=
X-Gm-Gg: Acq92OH7Qyf2JbM3sKzKlD+rNGW1Ygd8xgjkMCrtZXHSyZZvCVUZeUXx70ijYfoN7nv
	1L+kAw5/3wwr15o4iG3xfmhe36WIFqAxIz1vuMusbdzSor5pI7WWu5Su9UV8FjwRVsAatQyir21
	SirADQIZzFfSANwKOLivxKBB/6e23H5jMRDvDyEC7hGFTMlovcCDvJ9owJOo2Y6IlkOmhf9zFIV
	2JC7RX7ZlwcqCEHS/BQVoWa0PWlkR1AzLCrPHSOZjYL0znpRwui8znpaOtE21dmOmlNMhYGqzah
	a/0rTGZftAmr61KM8mIOG7+xwbEfqoZk+XinRNPB8TzpCSIgqx1bjlb1/K1kuD9lcvQjh3eGIGh
	lM55fU4V9ZwBeCys3cgSLlzprLVSQoU3SzZSOs8drN8gmpfs64Rh0HP0Hjp+CYPxTryDLXxR+Nk
	VG4vxIC9RhdeQmQz5bJ+/gysfVfranLhAQHVMC3/F4Uqw=
X-Received: by 2002:a05:600c:5288:b0:490:9d1b:f06a with SMTP id 5b1f17b1804b1-490b5ecd8e2mr43354935e9.10.1780481850796;
        Wed, 03 Jun 2026 03:17:30 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b63d8205sm38681875e9.11.2026.06.03.03.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 03:17:30 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 03 Jun 2026 11:17:12 +0100
Subject: [PATCH v3 08/19] perf test cs-etm: Replace memcpy test with raw
 dump stress test
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-james-cs-context-tracking-fix-v3-8-c392945d9ed5@linaro.org>
References: <20260603-james-cs-context-tracking-fix-v3-0-c392945d9ed5@linaro.org>
In-Reply-To: <20260603-james-cs-context-tracking-fix-v3-0-c392945d9ed5@linaro.org>
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
 .../perf/tests/shell/coresight/raw_dump_stress.sh  | 48 ++++++++++++++++++++++
 2 files changed, 48 insertions(+), 22 deletions(-)

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
index 000000000000..025584472513
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/raw_dump_stress.sh
@@ -0,0 +1,48 @@
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

