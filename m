Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366C93438A5
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015494; cv=none; b=odnUw0dv5ztRJTCDg8VXHnYLVKNucPulIDXVF3sCVYssZFGVSgEbVnLcezlG8Ss9EIrwwbOLGetnoQVU5OIz5PLsp1/jHK551i2ukaJw5HCRcAe0FuVTbXncglHT+DUObRqVPRElx4V0vautdo2aUyMBYz0M/JrCwdV1kf5exEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015494; c=relaxed/simple;
	bh=JYW1wo5ab8agRdVZbjqrOWWaceuU0TjELaoVo7f/di4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n0IOfAqjSPglFQaQXlGRqLXU69GoD5ioGEy7o69UAGqFPV3p4/sxxRLby6NBUjCJiLitIOof0ikcdr9rjjfGk4AdJvYvqhgID2us84WJ4NLb+doAVgBIrZmsMplvuoADY3/BPPd1yLW/w4KtpbaUOKcTfExQf+cP2GtHVDJTto4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EjZ/pIYj; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EjZ/pIYj"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4600cbb06deso3088220f8f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 07:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781015491; x=1781620291; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AWKqHsTkFl2zrGvjPzv1+aBtZDDjn0PHucQTDAlzntI=;
        b=EjZ/pIYjNUEd1AE0INJ7Cit7NgCLPkwP6uWAJSBZq1lQVOqzusEgsCsMiY5OjYD6np
         ra+gGLPNcVuBEY7U7zeQDrLo3zlpZ/I7Cc76U3o+HOHppWbX6kzeeF7/yOQgQN7m1v4x
         nZdk01TcvOUKfd1WoSPhzidayWRhRkFrUj29IDFcmbzbGFMKsXhtnBcEBN/1AIxA8qoN
         iOlgtUN5s87V0STWjEqCOLU+v9kAa2FaSfFGG6FOqRwGz2POS4kR06tz2n2FeWUFaqrf
         zdJFzfu/sLgoRH6dM1YJ0UPCmnwtaZ/wR+Lt2rA+QkM1x7sScf9jjhIRxF0yJ5Z4/SLN
         g/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015491; x=1781620291;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AWKqHsTkFl2zrGvjPzv1+aBtZDDjn0PHucQTDAlzntI=;
        b=hCYa7kJtzYRTtA6MHqt1mLLgNw/nvNhbIeZ1OoHeQIco99Up1fofyJLD3jiEaYMHHV
         6cWNaxKOo3GqDca7EiZ7VX0/f/lcMTBgSP6XZ0OwMkcyzKmxXn1cKanC+2+4antHo9Xd
         60zVDyTGIT25PiNNBRfUqdtvJeHjCQuFbBAS0p2kaO5JYDijfm8RKZKloT1S/g5oAyNI
         xFhTwMFZxglVCqPGR/LpCGHYBUR3YNPNL89JqOGRULRZZFLWNjH+ZYljDlKKJ+1ZIoz/
         WAvySUPoO28cSFXNkC4bF9jNWs9BrhB+8EZeypvClVqBy8UfWIv9DdrR9iT1W3G9XpN8
         48kA==
X-Forwarded-Encrypted: i=1; AFNElJ8/5NsB5+duF3jUyYDt5MKp76jakJ0oo1nwNW19hhVaoE78z9WyIb3YJhpch2HfrdOzJl7ZZu6q+BWwOyW1XuGE@vger.kernel.org
X-Gm-Message-State: AOJu0YycFRAufnpdMaLMuhJ+aL1Cb5WoIV54vuwdExAQQB1gQb/A8vXN
	roz9mo6EbAlJS5nvQ8+CyQ7gCsCOn+B4lFOEqcGW89Z3QA5mAPdVEcXp71x0LnCC31o=
X-Gm-Gg: Acq92OEYOeGMe85klorHUBi3klonIr+uFENYtZhkGjv3N1zhJE4ES4w0QrN1GRnc0MT
	dFsDXlebFRuCQE1BGp1cthlr1AN7CeVX7zeBSpxprl30a09sDw5dHvV0M/EoUdVHQRlxgwCySi/
	B7nRYiCz0v4WK8mRzhlbgSA4SFTNeazBcWX0+Kv9qefmepW1IuSNddiVZKcL9V1xj8Ymq3x7RYG
	0KcAJ0oeboXXqUBWGC5rWNhXxezaERaJ8s29Li20npuPAA40PF51PAbFRhKyDzG3xsXm8sYed6U
	CPQ8TdRxpjiQzXUU0VNBy/Gqp3VdHvaccjjOHdw70V5BZxHjikh2Z+gEQ43VNi8lLOIZUSdRWwe
	/WVy/2ICq5uuIR+x97qErHsY0FsakGxbG8OyyFKkcXL1VWcghUHUrJ4EUbqzIrCGuiDcGmhonZe
	oUg6j4OlBMAwvHjn2wNONGqKdz6Al0pR6yO+SLBUjOyE8=
X-Received: by 2002:a05:6000:298f:20b0:45e:73a1:8d04 with SMTP id ffacd0b85a97d-46032b61217mr19196157f8f.1.1781015491574;
        Tue, 09 Jun 2026 07:31:31 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3444fesm62738388f8f.20.2026.06.09.07.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:31:30 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 09 Jun 2026 15:31:03 +0100
Subject: [PATCH v4 10/19] perf test cs-etm: Test decoding for concurrent
 threads test
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-james-cs-context-tracking-fix-v4-10-44f9fb9e5c42@linaro.org>
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

The thread_loop test only looks for context IDs in the raw trace.
There's a lot more that can go wrong when decoding these, so replace it
with a test that looks at the final output for matching thread names and
symbols.

In the future we might use timestamps and context switch events to track
threads, so looking at context IDs in the raw trace wouldn't always
work.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../tests/shell/coresight/concurrent_threads.sh    | 45 ++++++++++++++++++++++
 .../shell/coresight/thread_loop_check_tid_10.sh    | 23 -----------
 .../shell/coresight/thread_loop_check_tid_2.sh     | 23 -----------
 3 files changed, 45 insertions(+), 46 deletions(-)

diff --git a/tools/perf/tests/shell/coresight/concurrent_threads.sh b/tools/perf/tests/shell/coresight/concurrent_threads.sh
new file mode 100755
index 000000000000..3349fff8c767
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/concurrent_threads.sh
@@ -0,0 +1,45 @@
+#!/bin/bash -e
+# CoreSight concurrent threads (exclusive)
+
+# SPDX-License-Identifier: GPL-2.0
+
+# If CoreSight is not available, skip the test
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
+	-- perf test --record-ctl fifo:"$cf","$af" -w named_threads $nthreads 1 > /dev/null 2>&1
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

