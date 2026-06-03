Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887473AE19B
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481860; cv=none; b=ITYnroEiXYQMiLiUxbGBs7PppV3TvY+r7vuBd7uVnszsuREI37Y3w1n5InQgQBrpfVnxMWqKlAFdD/PzBob/FJQMWo9LOEA5s+noZkFqrdBnZa/HzBnpNFAa5840VDFQgYoNZLJBg0rBiNP6CNBBKMVlLGd356RkubSMFNl7U8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481860; c=relaxed/simple;
	bh=+NVyoMoDiCeBbRcKsQIV0kaH0gzBxCHgeoMNyjllUrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BTjgJ1DLUeGjx/VrFK1A+I7aO/L9krbTM4SVUlxrZuaMSRWP8BmzkduMZncLFPGU1gSwW58Ww45tUe9v1q37ElK3LRJGkwd7KcBCxnHhLt3ZTmprhfac3iP7E7v/3SYRPM9BD9pOsyH83KC106lSBi3+Di/kv/SaAMjdJrygFYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rKg0UATc; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rKg0UATc"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso4515677f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 03:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780481853; x=1781086653; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBRnQlPosMN+k8SaoyM/0M+4oXOyWiGOMBDGTHkddk8=;
        b=rKg0UATcJ2Ntr8NWJiKo+qT1nE1mGGhEzHdTsNoelyMwxdoPtxQE5qb0LMeRLb+Esr
         1UGiCRWbzTRlvz4IFVBA+Gx6gPl8Q3AOREsjjNPR2OU05XwMGloFQV89McPVH2R+KCXJ
         nABv0SMICEGo6aTnfz1CAhQCvHjp6UQbn3CKyjxgyBo2lNEcvqJLkZYlrarkur0W0+5Y
         /0TkQ30PiZebzDgj22ezy4J9in7OdCmlEIlI9rVWeWIDloy4y7sbYjqfHR7WUFiwz31V
         JCLVFSY16yLCDSTLqDaF4fxVw9u6+ZT6oL9T+gLTKDmwTGt7tqNZG/0rv+LL/9E/VMvX
         439w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481853; x=1781086653;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lBRnQlPosMN+k8SaoyM/0M+4oXOyWiGOMBDGTHkddk8=;
        b=sSaBmwyXhqzMrfh6N0ufSpb6dcW14tf/A9rC2Ji50UWtbA8bsL2UT4uwAeBYed/EXY
         KnCxrw4XnAtViHHKtqlMOXLwX0VOrhHvZs5+SV7v3ss0x52tlKTHVDoGav03IKrZ3m/r
         mrdLnpsu9iNZmB2kSP3Mr+3sx/Vsp6jKUwSL4aaQC3jCr72ORsyyypTJUS0jT1Jge4k/
         fyWi+MRNMfT+AN/pFyJjmA0TsnYgukNsIT+E9BzyNWDpFAOeUKLI1L4onM+LPNRwQQEZ
         iP0OQupeXoTMdAmIwKzRF6bQGp49/0lTE6c7MP3EA90xrOFmoiTqsWCyfJteQvKyQdoV
         wL6g==
X-Forwarded-Encrypted: i=1; AFNElJ9iYQ2c3tsyfUH7UATYnTXNX3uLuaPv/xwHMqwNkCAn4GIBGhNgOAatxllpJB4Vw02utZPsRUiK0YQk8Zd12hNP@vger.kernel.org
X-Gm-Message-State: AOJu0YzJZZwM2sII+U6g45ZoeqsblC7iRdF7eYRyQpjJdO2eGxKSopRZ
	lSN2qysD+S+P00uEFSPikjue1+RDVC1f/wlzqLa96fMb/c4lWGt7iL3vZ/ZSIgsaH+w=
X-Gm-Gg: Acq92OErUrfegCl+CSonoQSOMeAFz6SVzcW72hVD16okCz97fLvDREcGCVpiyKgIQX7
	u1A2jCmN0p6HpKIwK++b55mm2fdj5HDVteeO/+iTzleeIHCJ8S6DAETjkcuWkKumIAhz33X+cSP
	YyVAZRYtqnRbbGJ5vXMEvrZ/+UCK9PPPqUlDLPytJQp0GNtGKHeJskyA6iqVRAJyUkRHUw49o5M
	bi6bAm6k4ozvSPHHddFn4xqD1mPkVEYxbej29kQcDTj7YA6KTgcgClL6bAD2qj5klx7UILUtv+n
	fpX/rMd0FosGimNQnn4qaKZsGpr31ns8z03F/ViDTBK2W3GprtdiYzkme6jjL5bGjEWlFRRZYyJ
	2E6DzPx9uprUwfPo9Oi6jhrGOGYcWXMsF/BG47yV1e6S5OKiNpHcGIslgFacPUrlfxRR1JdSk5C
	vMxOL6wnZHa3E/JkYFDUikWVoyiUy+GQRV6yzMjqEuMio=
X-Received: by 2002:a05:600c:3f18:b0:490:b2f2:9aac with SMTP id 5b1f17b1804b1-490b5d1a9b7mr57327915e9.0.1780481852836;
        Wed, 03 Jun 2026 03:17:32 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b63d8205sm38681875e9.11.2026.06.03.03.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 03:17:32 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 03 Jun 2026 11:17:14 +0100
Subject: [PATCH v3 10/19] perf test cs-etm: Test decoding for concurrent
 threads test
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-james-cs-context-tracking-fix-v3-10-c392945d9ed5@linaro.org>
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

