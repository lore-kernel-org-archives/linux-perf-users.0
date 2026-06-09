Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAABC355819
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015488; cv=none; b=j49Imh30BhyDSHgQAQnNwfXlrmWvxrS/JOAHLQmypeFUQi0ABH5PvERdncbMzWLbH0X2nu+xv1erB8a9N6hsrHhOMbV1BchMAEbh9vuUWJnKLKs+/WBmi15PuvNiHQMrFGkhsDzxoBRbmbEd8AoYp4FHPXKCozTSaV9A1v+43yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015488; c=relaxed/simple;
	bh=2n7NJ22D4CS+P0i5+qEOUx8FKIjlEa2CLZ8182tHs0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eEoHdBF8Xd4AtI6ghFdRYpIdlINtL2f5A33iH1DbaO96CWkSmmJIXLw+NDP6JLzRJsKggehImWpKzdDdHQy0VJKgEPm2fPPMFWzO60vsKjSUR7tb4m8xes97AvdUsw7ODIbGqXy8smm2o9l6j5Fz0e5FriM1XP36ulO+QXwY/hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=USz6GKc2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="USz6GKc2"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so28075095e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 07:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781015485; x=1781620285; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+VAHnkL1slPIQmaFlO30PHwtm50BBgiqOE4SfSQTuk=;
        b=USz6GKc2BoZU+8xDN8mR1heECcY+zpmoT4KZafOB2RqHYqHy+5L/6BkQcIHF8T3VQe
         h0q6VD7KO6CsQYA/UTgYeOza5H67nevOTpDFZRt1ebf6hNODzBtJgSVGvKUuqbfZI6/B
         2svktL+X1+hLf0rKKX58Mp8lLS6p/wsRqrjj5cxhUn0mNfcZcAYiqLS9n9kF6BdbtWeS
         399ionh0NrtjjXkuMS0C0m2gUBauzdESQA5X4OMNLMiA2ogo8p7gWlscCJU+OoixblYi
         j6g90ZDXVCSnYjidtA0zixLfAuyJRW7dB8qFaLMy2WR6ZoYZym0S7V1efDqfhwPI0TDc
         aVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015485; x=1781620285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K+VAHnkL1slPIQmaFlO30PHwtm50BBgiqOE4SfSQTuk=;
        b=QC5wwbp5bXBQuR4IOKnYrEWQIZJ3+Zbo9YlFGjeq6JmvpTFjKdTuTXW7ct1PVneDb5
         7VKcLbzzc3gzkK8VGLpdZXzCabKY5n4T1i5CKnlFKrMYDC8D3BhcpEH7xDxUWPf0yckl
         suZu5Fh7bPeFvRqbsurFYo0zZZS3I/BqqrYzCbx/COt4473rJHeGHkG+190ZTes33Rmu
         6tgon9irE7dGXOspTeuIqbT2PI9LdcXsvsFPFFlBpbsc7FpF9i+knznyF70hl+/54eZU
         NXZiR9zyDZRqVZ5ve0Lene/jAz2fKjADYGJKP4PNgpqacK3xdkZ2S5y46GuMo3hWS3vt
         eNDw==
X-Forwarded-Encrypted: i=1; AFNElJ9fr2ZhIno76u91uyzI/AvnlmVqTi2F/VYB50Z7bdGzBPFyoL4/zoVrfO9yY7iLVk/HY7u16lXjhXaCAFpoSL1C@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9F2GIfFokEqhzzp0ZJ096EerV47SIk6KhQecuegAksMWeChM8
	apJrTOQj1mXlrWhEhlB5jjHC3UCk5TZoJnaZuh6gf2O2uR2nEe9Fcl24bRlPr1NnZSM=
X-Gm-Gg: Acq92OGiEJ5VnElkDMu8Hglh8FhBAc7z4z+8Rk0NfSgKA/EErfR9GZ9LZKTlFKPMPXm
	5CMFyC8WiXwraMEuuoHE+R+CAFN8LfZ4vq/wFnVh4uF9ip2vGTUB+ycMrUcPjSkeP501vGtKb6z
	JnO9ccc1vIyrl7aoiSHSsIlqgxiIdgxLRnPfKUw7XeWoa/vPp6dCQ2Q9zEgSuFdTUHq3tiWsXCv
	eZPbcpnJ6XZImwjKc7uQ9+/RrdXX4E+/vxnxuVcjBgE5mFb0chWCv9AhHxSX6E/maKM8wb8dQZd
	9SNTW1o3sxUfdu7VgtwQyxs2cZUQ4zqRHZUnXlG9QLhq2hvHoi0I9Rz0U61DGpa4SnxXZJEu/s7
	FkuoGS3vMFTsDJoy0g+AnCqaoO5q71pCXD4rh9T75V+fFaU2YEXIsGucgxaU3ouBmqv6HAw+Dl7
	GW855wiDSnCyjNc5zga6aNGtcZ0Eqd86WYr87JiYVVotE=
X-Received: by 2002:a05:600c:818c:b0:490:b0e1:2161 with SMTP id 5b1f17b1804b1-490c25b39fdmr371063965e9.2.1781015485062;
        Tue, 09 Jun 2026 07:31:25 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3444fesm62738388f8f.20.2026.06.09.07.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:31:24 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 09 Jun 2026 15:30:59 +0100
Subject: [PATCH v4 06/19] perf test cs-etm: Replace unroll loop thread with
 deterministic decode test
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-james-cs-context-tracking-fix-v4-6-44f9fb9e5c42@linaro.org>
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

Testing a long sequence without branches seems like it would be better
as a decoder unit test, and this test doesn't test decoding either, so
it's not clear what bugs this is trying to catch.

The new deterministic workload has somewhat long sequences when built
unoptimized, and we can always increase them later if we want to. But
now we test that decoding always gives the same result for the same
sequence of code which we've never had before.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/coresight/deterministic.sh  | 72 ++++++++++++++++++++++
 .../tests/shell/coresight/unroll_loop_thread_10.sh | 22 -------
 2 files changed, 72 insertions(+), 22 deletions(-)

diff --git a/tools/perf/tests/shell/coresight/deterministic.sh b/tools/perf/tests/shell/coresight/deterministic.sh
new file mode 100755
index 000000000000..75d4973056f0
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/deterministic.sh
@@ -0,0 +1,72 @@
+#!/bin/bash -e
+# CoreSight deterministic workload decode (exclusive)
+
+# SPDX-License-Identifier: GPL-2.0
+
+# If CoreSight is not available, skip the test
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
+	perf test --record-ctl fifo:"$cf","$af" -w deterministic > /dev/null 2>&1
+
+perf script -i "$tmpdir/data" --itrace=i1i -F ip,srcline | \
+	grep "deterministic.c" | uniq > "$tmpdir/script" 2>/dev/null
+
+
+# Remove brace lines and call sites as they may not be hit or may have
+# extra hits after returning, depending on the compiler.
+sed -i \
+  -e '/deterministic.c:8$/d' \
+  -e '/deterministic.c:12$/d' \
+  -e '/deterministic.c:15$/d' \
+  -e '/deterministic.c:19$/d' \
+  -e '/deterministic.c:23$/d' \
+  -e '/deterministic.c:28$/d' \
+  -e '/deterministic.c:34$/d' \
+  -e '/deterministic.c:36$/d' \
+  -e '/deterministic.c:37$/d' \
+  "$tmpdir/script"
+
+cat > "$tmpdir/expected" << EOF
+  deterministic.c:24
+  deterministic.c:25
+  deterministic.c:26
+  deterministic.c:9
+  deterministic.c:10
+  deterministic.c:11
+  deterministic.c:30
+  deterministic.c:31
+  deterministic.c:32
+  deterministic.c:16
+  deterministic.c:17
+  deterministic.c:18
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

