Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879149;
	b=HZXTbPclXBGqsGxH+W98Ld+pImCV/eH7oYxiXh9paL/Nd9ZkP9um2rXuIyaaYk2e4M7f
	 SUB3EI8BSyDhAZvG2ZrJR8pHcFL88GqWCSnXIGQzZ1SZKLq8GE0SuWnyMZ5DojmjsDZbM
	 q59oZamkkNGDXt4TMRwSShu2X1GcJxoUsEKCm22WH57WYH0a2ZV5xHY+PCaLJNMZjI9EG
	 K+RHHXcP82JVsPX5H2EgmZWIaN73CFJ7PInkfzCkQozB/UuhTNcUeZFXzegDUQ3ZgCU9M
	 g2laP4liPai3bmAdoQOanySEzRoMAlZHMEQyH5vivucTuYurDdwNU7xyFQBIZS5f6Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879149;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=urrgTOdhrZbA2FGtYgxftgMNBud/Y8/6+LuWZZfe/7k=;
	b=ZVCJTB6jHB9tQraPfOlQI7IyCLXqxf4aF2CviORW7Rmp//4/wP+DVqi2TacPjl1PoGrX
	 JHrXfYl3fpKkH3hxK0+RYf9Lo0o5qnORY0PEN/d1QxQad///gkL9yiwl2i6sGYWJ5n/6A
	 CX2z4OyKDGbmo/SU8dTRJK6ReSnoa2mAflbRQ/vxOfOsSlvH++ry2u+bIkM3rh+9Wu0al
	 fUiARM57/3dUFzyMZqkccWOs/uWsUKeK541nrcUZF6hH6RSHmQtL05GOepuiJ36svqQ1I
	 ffNzGQilPX86iFJpoX/2z93rvN00rZ40CncDyk5adIhqS5F+Ek4NTlqP1VXgseWyjgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=O7G21oQn;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CC7606AB18
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 11:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98CC7606AB18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=O7G21oQn
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so10754835e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 03:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793879147; x=1794483947; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=urrgTOdhrZbA2FGtYgxftgMNBud/Y8/6+LuWZZfe/7k=;
        b=O7G21oQnj5EJzLMX33JkomM0jG8TtAWCpdbH9a5JQ9LNoAwKNVCHbeWdzvN4aqIv8o
         e0i6mtuQjfheHG6pvcl7R7PuKXkw36xAPrRZynGhXNubC1q81XYCUwdjSzzOB4u0NXHL
         yqQsMbTEKxAhumaEEA8MLob0jiCe6+JyP5/y0kLzQjF3U4WpN9olH+b1d/7FevyDYzWD
         3Xs/zqsfTbDnbR7CPfq86qHpU1BJCRXYdDtqp2Td/3Oa0h2vT+HnHjtAuQE+OFFYBST7
         CIKEARQUuRGTQ8TErl2zwuYTXN59lN5TyCB/qRm69TqfrDaJ7jzJ8nv56HfTmVDmqSNc
         3w7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793879147; x=1794483947;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=urrgTOdhrZbA2FGtYgxftgMNBud/Y8/6+LuWZZfe/7k=;
        b=WCbxuL+DLXXH4R+iDFiF0ghYMdgOEmjQyaBgYwgTowlaqEen7jtVjsxHsPjL71iLw6
         B1wLdgDJsY06K5BPYfwh6hkIxa9LUCQs09/+1t7GybofQuPRTnDgA7QdQNLxU+d8RAPL
         e07Nn+UGdA9zYPwP5nOwVfbOafuV/vaOFi23cV2fPvBQIDJscRJa1ek6/pb4cyV4TzXD
         BjylX3MYCxMa+NioigWKw2bzd2hYVuBeYeDUma/MKYPCMSew5I9tB80Lk75is5H+U5jJ
         M4/feRY0yYij4OWatSXWfMZZOEwjwenS53kMTU+4KabvFip7/LlJK6xmqFm7Ip5FzNe/
         2RhA==
X-Forwarded-Encrypted: i=1; AKwUvBymnS2YLu9KIhy7j3/NFF+pEXAWjVMsZ+qUurq9CiaKJ9xD0hOx3UrnWt4Sz/UiRQBeBOu0XlqNGgPxxuN7Jc+F@vger.kernel.org
X-Gm-Message-State: APuU4Z9aPDVYuUQKGlDHNJEXEVZJX6gs1wIqgTPXfNLz0gYnczT96qK1
	6g4TLmB7KGt7WYFHATBkIY2a8YDWKBreytjKUvU0zxTBV7XJRmaz+F3pSIybUFTMslA=
X-Gm-Gg: AYBFou1ig1Oix9fJKF8+4lP81Zrpzc5DhJkS9b6KO6HBJKMPXQqw8vCukKPOGr2uF7R
	6kiwMde8+68dvJ9oO2cCAMaqxQdQWpxWwlW8CzkzK4WV20nnFMgcu8pCfdm9YxHrqX+YiSFmBD7
	FhG6QSIlg1Nr2f7gFyqwCmpYKqfIKAagmbXybhNzotKoiYjLeW0ueHm3GNRk7/Ced5uUPtOx2SC
	PaJxF8NiAcV/1CUKrGlFPyRwga6XFhTcyUSTh5bSrx26oNvcbFqiqQLGbfXU9/+kWyRN4wnqk8P
	v8CPML5ICuJik9XNvbVHko7iZFPPJhpu3ow4Zx7WhAqB+VH0nLAK6IZzzC9LO1cIZ7G2+H/hj8O
	OOlAmnWt01cGudxd8Dfd8uHWQUHp7qZHfbIpowfOdBRNnyeoovSecaWPcbXBShMRHre/efgYeLx
	4GdQABwDPjIZGIgIsAFhgBDskt4rNJMeKw5ssSqvB6KXgYfB6jBzYpjOb+zCBZECTxNZrfnllAb
	FhzPcGNalM7AxVaJnTR27PWbgja+vqSGCfjIr8QnipP4sOogqEbaqzjlLG7tgjwi9g/DNqlWlA2
	9GNrtTaYSiyqN5DY6fPvMT1WAAdf2lf0
X-Received: by 2002:a05:600c:608d:b0:4a2:1197:1de0 with SMTP id 5b1f17b1804b1-4ac18b7dcdbmr405802955e9.19.1793879147059;
        Thu, 05 Nov 2026 03:45:47 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b571f46538sm56679525e9.5.2026.11.05.03.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:45:46 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Thu, 05 Nov 2026 11:45:06 +0000
Subject: [PATCH v4 18/19] perf test: cs-etm: Test multiple per-thread
 threads
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-james-cs-unformatted-per-thread-fix-v4-18-7759e0ce2449@linaro.org>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
To: Leo Yan <leo.yan@linux.dev>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>, 
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, John Garry <john.garry@linux.dev>
X-Mailer: b4 0.15.2

Launch something that has multiple child threads, attach to it and
make sure that all child threads are present in the samples

This will only work with 1:1 sinks/sources, and looking for TRBE is an
easy way to guarantee this. In theory this could also work for ETR
sinks, but we'd have to attempt to record and skip if that fails, which
would make the test silently skip if the record command started failing
on TRBE too.

Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../perf/tests/shell/coresight/per-thread-multi.sh | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/tools/perf/tests/shell/coresight/per-thread-multi.sh b/tools/perf/tests/shell/coresight/per-thread-multi.sh
new file mode 100755
index 000000000000..bace76cb6a51
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/per-thread-multi.sh
@@ -0,0 +1,76 @@
+#!/bin/bash -e
+# CoreSight per-thread multiple threads (exclusive)
+
+# SPDX-License-Identifier: GPL-2.0
+
+# If CoreSight is not available, skip the test
+perf list pmu | grep -q cs_etm || exit 2
+
+if ! tmpdir=$(mktemp -d /tmp/perf-cs-per-thread-multi-test.XXXXXX); then
+	echo "mktemp failed"
+	exit 1
+fi
+
+cleanup_files()
+{
+	if [[ $parent ]]; then
+		kill -9 $parent
+		wait $parent || true
+	fi
+	if [[ $perf ]]; then
+		kill -9 $perf
+		wait $perf || true
+	fi
+	rm -rf "$tmpdir"
+	trap - EXIT TERM INT
+}
+
+trap cleanup_files EXIT
+trap 'cleanup_files; exit 1' TERM INT
+
+# Multiple --per-thread events are only supported with 1:1 sinks/sources
+if ! ls /sys/bus/coresight/devices/trbe* > /dev/null 2>&1; then
+	echo "No TRBE sinks, skipping"
+	exit 2
+fi
+
+# Launch 2 threads to run indefinitely
+nthreads=2
+perf test -w named_threads $nthreads 0 &
+parent=$!
+
+# While parent still exists, wait for the 2 children to spawn
+while kill -0 "$parent" 2>/dev/null; do
+  threads=(/proc/"$parent"/task/*)
+
+  if (( ${#threads[@]} >= $(($nthreads + 1)))); then
+    break
+  fi
+
+  sleep 0.1
+done
+
+echo "Recording..."
+perf record -o "$tmpdir/data" -e cs_etm//u --per-thread -Se -m,128K --pid $parent > /dev/null 2>&1 &
+perf=$!
+
+sleep 1
+
+kill $parent
+wait $parent || true
+unset parent
+wait $perf
+unset perf
+
+echo "Decoding..."
+perf script -i "$tmpdir/data" > "$tmpdir/script" 2>/dev/null
+
+# Check all threads were traced and they have the correct thread name and symbol
+for i in $(seq 1 $nthreads); do
+	if ! grep -q "thread${i} .* named_threads_thread${i}" "$tmpdir/script"; then
+		echo "Error: thread${i} missing" >&2
+		exit 1
+	fi
+done
+
+exit 0

-- 
2.43.0

