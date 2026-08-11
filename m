Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7654499BD
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462275; cv=none; b=WDtqfl0mLatXdbfrjHKyUSjmsDvPW2lEVrFocx6U6Csp0Y8nnUWFvM1ArCpt38CGFzf0wLR4d51EIjl39hBa8MMJ0tsamFQbtSS8NnhJfraW32ugJ1RNuzN14RZJMWFarU/9aKGhft+NVPPHch+tQQlRffNuc2arzTBV3Q1fqss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462275; c=relaxed/simple;
	bh=45ewM2dvFaY12LY151swUHBTvievnc3sust8Ep02uoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KkDzUJMkuyp8ftQoZ6aCuJVN/6ALuDRHw2DeobVkqKonLGSZJWF4HzC06VLM4IyEJBMbJoGr1L+PFvz/C9GMWfFiq75UyR8EuUhE8HLQD1EQL3Bi1pZ8BvAtvfhNHGiD7lhaxGjpwiEyjZlcE1fbWOHofAwBC1KMjL1nxW4FT4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XKhHoCze; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XKhHoCze"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so28814945e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 08:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786462271; x=1787067071; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ghssS34122+SF9JGQaRPjJsmiH0qvioNjK1NWp3olSk=;
        b=XKhHoCzeSiBQhbZ2h0qABiKAZFCt84kDfp3UQatAapL0fLX4CXM53CcuhBTL+lmDYH
         JntksQ1zn0P9dw/moBLZs+UzvO/o46NOc4NeXzE0NKNK12s3f05CzS5SKaBVtw1hf8pB
         a3uY0VLfVLCe7r23INbhZRBFTQ6JRDHdMxCHqKkorB0D6GU0DLbW0hrybiv3iXKufLsX
         ADzSlcYnlk07b7ref+v/qZrklxGf+/HAgq7dHwk1yzrea/sPSJFf1Z4rU8jSVcvazM3B
         wr9tqBws3K1cJdSjI7NAdSaTtnFue3W/jeaYDTrZgXBihtQhPnWtH6yAwvleVsUx6MNQ
         42/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786462271; x=1787067071;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ghssS34122+SF9JGQaRPjJsmiH0qvioNjK1NWp3olSk=;
        b=Gdjwb+T6O9kLLFjfz+JP25ecGAXSSktwBYNeoJxrUOqYml7Lp55wFY9p4aR1uKj6tX
         MxdP/FPE9NW1dlODVTUlP6e3k8GAw+aFe7hUP6/Tw6RzAZSfqRVyTFAe4qxLcHmBnuvC
         C6k735ZemOBtUZFcg7nrewAZ2BUKoPf/n+Uxww12zK/qyFtF9Iz312x/l/h0Ylr/6y9w
         Rb4n7zekRvYn6zUOTOelzDt+bGnYHXva1aEe4tRUEchJfcDmV4FKDvtfaVGHKdCeFynS
         T9yNAwYElBVwkK8gR2T0Gu8udgVgttb78x0hMvdbcZscuB9e/JM64TJ9HAIsAGOZgc1k
         yzZw==
X-Forwarded-Encrypted: i=1; AHgh+Rr8IYkHvYWw+bfr25zHIEQnr4qguR67dnlL8IvpJlB77UvE4WG8qriZohJIg7FuzDT+VcfvO9R77S/EHnLGRdkv@vger.kernel.org
X-Gm-Message-State: AOJu0YxxW0GUofOWdWWD7wiBoapNJPtPb3fNg325s4mYQEh4ao6D11Sx
	ogRH5cy6UMoGEqfxQHf2Tp2dznxaBIjW+YmyV3w2eMqgrsTX3N3zR19zNjgsAmxq8AfH0uOPcPQ
	n3YoJI6M=
X-Gm-Gg: AR+sD12/uUF/Cz2bm+qNoDnwu+2wGKlsjyxMtaVN2ebKtYuoxkiBhHOCAGser3nWy3V
	1VjKSo1Xg7e1MgLB9rubcT//y5HiKY71Fx7dahgaj7RqrpDfDBcqiNyGldh2s7HxkR/nh34VnEJ
	dMQ3HpO1yr2YIMe7GGgPM765AaQwWZtb6exev6iM274whR3ilcMxUbiV1QLVnYAJJK9SJxSb3BS
	5pM1F9i5GaH3+oQLKZUDyk3ls3xSUyp8ND2wjrhLCPQPF8eIuKRaz3hNOCsyALM+VtWrEGQF5wa
	2VbvImiccgvc+2EmWseC7dJkZ5dwejQCD8MNyblebgqO2GsFy7o9bMipr9gu5DejvImZGpZEb7E
	FtJ+Oo0dcHzdhrjucB/0vYFA9tA09RBqUWAAwyAwWZ1KMYp+kDN7QgzbCggoxQuViDHt344UXRx
	bGbBXJVBm7zTmRQGoAKMsGEfS11/n0sajVUAznsDZYRjRF+tItWuhIwgqiPC2hpAQP
X-Received: by 2002:a05:600c:35c8:b0:498:28b:1025 with SMTP id 5b1f17b1804b1-49978433a49mr60012655e9.5.1786462271236;
        Tue, 11 Aug 2026 08:31:11 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49977dfacb6sm49865395e9.1.2026.08.11.08.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 08:31:10 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 11 Aug 2026 16:30:17 +0100
Subject: [PATCH 14/14] perf cs-etm: Test multiple per-thread threads
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-james-cs-unformatted-per-thread-fix-v1-14-90565318f5f8@linaro.org>
References: <20260811-james-cs-unformatted-per-thread-fix-v1-0-90565318f5f8@linaro.org>
In-Reply-To: <20260811-james-cs-unformatted-per-thread-fix-v1-0-90565318f5f8@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>
Cc: Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org, 
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-doc@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

Launch something that has multiple child threads, attach to it and
make sure that all child threads are present in the samples

Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../perf/tests/shell/coresight/per-thread-multi.sh | 78 ++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tools/perf/tests/shell/coresight/per-thread-multi.sh b/tools/perf/tests/shell/coresight/per-thread-multi.sh
new file mode 100755
index 000000000000..ea525ed5e18b
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/per-thread-multi.sh
@@ -0,0 +1,78 @@
+#!/bin/bash -e
+# CoreSight per-thread multiple threads (exclusive)
+
+# SPDX-License-Identifier: GPL-2.0
+
+# If CoreSight is not available, skip the test
+perf list pmu | grep -q cs_etm || exit 2
+
+if ! tmpdir=$(mktemp -d /tmp/perf-cs-callchain-test.XXXXXX); then
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
+perf record -o "$tmpdir/data" -e cs_etm//u --per-thread -Se -m,64K --pid $parent > /dev/null 2>&1 &
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
+# Exit early unless there is a dedicated sink per core which only TRBE
+# guarantees. This is because shared sinks will report BUSY if two threads try
+# to use them at the same time
+if ! ls /sys/bus/coresight/devices/trbe* > /dev/null 2>&1; then
+	echo "No TRBE sinks, skipping output validation"
+	exit 0
+fi
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

