Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B1E409104
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410454; cv=none; b=OPlVv7n1sEzA1EJnV97RAIKwx5PCA+f/Mw67lhne2wLbM7zj+8A94rjcmCsSJptqgDevrwh0/nZ89JvK+cEFr7n/+BoRWl+v8agscfl2yXrfjotPVh+d61Cbcmeap1KyaGQtipCuq3WFFsytqN4q7jIw5dZrzefb/3+Gh0bbByI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410454; c=relaxed/simple;
	bh=+NVyoMoDiCeBbRcKsQIV0kaH0gzBxCHgeoMNyjllUrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ry6qRfDVdaiB6Jl/JUL8b1xobDt7e4VAN1ijGI9eXNmw4V5Z/Blil9N+3x7Fa/V5FEXLLg5ZtjcfsKBEK4p1yzAR4h44izELZ3L7bCp3hi8x/St/kBnNAcARPqw5AoJc0EqYxzFvE939T6NDWJHDUoHNefAxcRaPVS2Lr5QTHnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hiGN6NE/; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hiGN6NE/"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490b12270b3so6504575e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 07:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780410451; x=1781015251; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBRnQlPosMN+k8SaoyM/0M+4oXOyWiGOMBDGTHkddk8=;
        b=hiGN6NE/8UOnpNIeNZPU13Iw2+1JZVGF0S3NWww55GJTk1tA4BHhHGUF5xzvGm0uKc
         UnapDNLw/2dk/Xr/7PS5qBlbURcM50krcq6v6nDE6O4AUfxJxZfUYM6veiADPGNyECV/
         k0wCrnOqKuITzFIOGThwwqKVIKB/8D/mUB+FQYhena3oMaOtWgbaT6vEdg7WQkoLtcxP
         M+BOhKFdMhibKq+VgY92g80Sf5ep5Bh6CTGlOSDHhYtBA3ny7OUFtG8d2zDPF7QXJYD2
         c4UbpohN8KmBSYBuIuJaA2iefcPzX91UEbRfiF2onwpyoo6TUYZdVKjKw98PDM98HYMM
         jyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410451; x=1781015251;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lBRnQlPosMN+k8SaoyM/0M+4oXOyWiGOMBDGTHkddk8=;
        b=E3rgXE9jR+kY2FpyJ5q9dHPv8nzUVE+kAAH4/GGkmJB/FJ/PKhCUXnbFvuQKD2HuID
         lHUHtn9UR5sjNzMHDl4Y1i+5kUvopE3z6lgkgvmLr5AZLfUAP7soBkYqCmO4MrTgWaCk
         UiwpEEtHcO/jxjSy3070Lp2KbMr2unuUDIF3mIC4mqPU7u6XDNn/2bjU2zlacrSYMxqv
         +0PpYOL9tyq0Guey2lssRE9ewDz6A9he/+2CaWyg5tW2oeUbL3RVGGxncseE0bQQNYrC
         YyED+y6U5/pdE6TG2kdek1c1GOkiMN0IDOzBculJ7UanJJAf5N/yj3G7HrfQohniVm0I
         FOHg==
X-Forwarded-Encrypted: i=1; AFNElJ/Oi8c+DHaKe7aN1vUKbuD1EDMKzNZeB/5xVFF4sGYhmhUfL8gZWfoHndP3OGd/qRINeawhuCI2f2dq+/6S6QQb@vger.kernel.org
X-Gm-Message-State: AOJu0YzeXYcVYjBhf0ow/gb5Z5PB33ka5d/73nwkUc4tZ6OAfg3h7UBH
	3HQWBP7HrOsG98to8emw8QhhZUjx0Rs/MSc+JfDA7vX9Y12+hs4wXi8LnOPfnT2R4bU=
X-Gm-Gg: Acq92OF7aVJRidZH2dRDyNzBe9m9WuWgrB3MuQutR9NgIQJsoZifFLsf3yHqleQMRuz
	3mxJJbzPuM748XLWhK/iX0oNaKzwozWAKTiFViXD910NCLJNPzxkZKPhHcUU1Re56MVANNXr9Qo
	uoL1BqOD3mYCxXUXu6ybI9Dlae5h9wOaR3qDnbpmhIYBIm+aYUjqq1Uwy0btnqDNvKA3XZJmnAe
	uV+vjX7RIiaa15ZmxXzfG0XfwcKjaZlrvcq1uMzte0Xq3aIVi2T9hzSLhHoz6uljYuiUkDJwHzU
	SfWRZK2C8cQMqQOsLLjDwpfaHUgs1jG12ysr5NAJDWEt4F1zEQR09Hd77GR4HHM0vgGlr4ANKui
	SvT77Box25JaYYq0Z1LjKyJH2us2iFN8Q2W7Tl70l4QEy9Z02nkwF4rdoSex+0YzTiUiVk6if/3
	eqk1SR6svPzw3ZdilsazdJdrhh7Niw+pD23/1NGk4VG9Q=
X-Received: by 2002:a05:600d:6454:20b0:490:9ea0:c11f with SMTP id 5b1f17b1804b1-490a2904d8amr208279205e9.5.1780410450823;
        Tue, 02 Jun 2026 07:27:30 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e18e1csm66771965e9.4.2026.06.02.07.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:27:30 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 02 Jun 2026 15:26:52 +0100
Subject: [PATCH v2 10/18] perf test cs-etm: Test decoding for concurrent
 threads test
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-james-cs-context-tracking-fix-v2-10-85b5ce6f55c6@linaro.org>
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

The thread_loop test only looks for context IDs in the raw trace.
There's a lot more that can go wrong when decoding these, so replace it
with a test that looks at the final output for matching thread names and
symbols.

In the future we might use timestamps and context switch events to track
threads, so looking at context IDs in the raw trace wouldn't always
work.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../tests/shell/coresight/concurrent_threads.sh    | 45 ++++++++++++++++++++++
 .../shell/coresight/thread_loop_check_tid_10.sh    | 23 -----------
 .../shell/coresight/thread_loop_check_tid_2.sh     | 23 -----------
 3 files changed, 45 insertions(+), 46 deletions(-)

diff --git a/tools/perf/tests/shell/coresight/concurrent_threads.sh b/tools/perf/tests/shell/coresight/concurrent_threads.sh
new file mode 100755
index 000000000000..bf34d4ee77a6
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/concurrent_threads.sh
@@ -0,0 +1,45 @@
+#!/bin/bash -e
+# Coresight concurrent threads (exclusive)
+
+# SPDX-License-Identifier: GPL-2.0
+
+# If Coresight is not available, skip the test
+perf list pmu | grep -q cs_etm || exit 2
+
+tmpdir=$(mktemp -d /tmp/__perf_test.coresight_concurrent_threads.XXXXX)
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
+nthreads=10
+
+# Timestamps off to reduce trace size, start disabled and use the control FIFO
+# to only record the workload and not startup.
+perf record -o "$tmpdir/data" -e cs_etm/timestamp=0/u -D -1 --control fifo:"$cf","$af" \
+	-- perf test --workload-ctl fifo:"$cf","$af" -w named_threads $nthreads 1 > /dev/null 2>&1
+
+perf script -i "$tmpdir/data" > "$tmpdir/script" 2>/dev/null
+
+# Check all threads were traced and they have the correct thread name and symbol
+for i in $(seq 1 $nthreads); do
+	if ! grep -q "thread${i} .* named_threads_thread${i}" "$tmpdir/script"; then
+		echo "Error: thread${i} missing" >&2
+		cleanup
+		exit 1
+	fi
+done
+
+cleanup
+exit 0
diff --git a/tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh b/tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh
deleted file mode 100755
index 7f43a93a2ac2..000000000000
--- a/tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh
+++ /dev/null
@@ -1,23 +0,0 @@
-#!/bin/bash -e
-# CoreSight / Thread Loop 10 Threads - Check TID (exclusive)
-
-# SPDX-License-Identifier: GPL-2.0
-# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
-
-TEST="thread_loop"
-
-# shellcheck source=../lib/coresight.sh
-. "$(dirname $0)"/../lib/coresight.sh
-
-ARGS="10 1"
-DATV="check-tid-10th"
-# shellcheck disable=SC2153
-DATA="$DATD/perf-$TEST-$DATV.data"
-STDO="$DATD/perf-$TEST-$DATV.stdout"
-
-SHOW_TID=1 perf record -s $PERFRECOPT -o "$DATA" "$BIN" $ARGS > $STDO
-
-perf_dump_aux_tid_verify "$DATA" "$STDO"
-
-err=$?
-exit $err
diff --git a/tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh b/tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh
deleted file mode 100755
index a94d2079ed06..000000000000
--- a/tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh
+++ /dev/null
@@ -1,23 +0,0 @@
-#!/bin/bash -e
-# CoreSight / Thread Loop 2 Threads - Check TID (exclusive)
-
-# SPDX-License-Identifier: GPL-2.0
-# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
-
-TEST="thread_loop"
-
-# shellcheck source=../lib/coresight.sh
-. "$(dirname $0)"/../lib/coresight.sh
-
-ARGS="2 20"
-DATV="check-tid-2th"
-# shellcheck disable=SC2153
-DATA="$DATD/perf-$TEST-$DATV.data"
-STDO="$DATD/perf-$TEST-$DATV.stdout"
-
-SHOW_TID=1 perf record -s $PERFRECOPT -o "$DATA" "$BIN" $ARGS > $STDO
-
-perf_dump_aux_tid_verify "$DATA" "$STDO"
-
-err=$?
-exit $err

-- 
2.34.1

