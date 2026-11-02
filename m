Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621768;
	b=L5qXV1DzOidcsvxSJllfxb89tHJqaaqw7YR1N4q+dhC0gZy30NttHRYXjaSW194cabI9
	 JFFmIJeSORW5V+UNYQw5K4Q8UU1aY/okaGKzG05Mf6RQVOSVlm/LreTModronFsmjujas
	 NGjXua9wYs5a1sEN4Eq+uso96KewvPCzqQx0uEAOGIel+fWeJIxyp5wcNiCFTIuMkfu/z
	 Of/9JErGAmE2RREWynuuTKEE6RFyRBlmAOZVlxXV5sl71uRjYGzWCZGkd3W3DXqDWWHTD
	 y9cr5Pwziw/oM1I2/hd9Noz3nSkWKRsxBp7o1oHRGsjxKfis7FRatMuzeRRshjQlSfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=BoSygA+rSUd5kKs81oMTEOx8OUAzT9ufCoQu9dV/md0=;
	b=blw2RmSY+8mRY6yKV8gH5/2myhiQxAbsDf1vBYFHjRvTtSGJlZq99FN7BQwH5ll1tVl2
	 zGGwo3s86tJpLjFdvcuYgEzFZyapf/VJmuyBN17pM4LOkrUevbnCL1eXDobBJeU4Iz7so
	 ax52yOMyJ+UxMDbHAf0MlwCxzdXuNEgo2M6ehtEYItDM1C4P25CghcCnJkvm/iAGFYaxP
	 2CP++Z3Cn79WyDL3MrVKORC2lPJtPzM8ADb7fxj627w4WgMgCSo+Vl1jYKfkkXSicoHLH
	 EOtukW778EAhY/bEE1DAE7oSp6On+iDTvNeOd88pW64sG2bzQuUv5ggmrk09Q8CyA0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jWR6o5+Z;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7364A606C4E1
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7364A606C4E1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jWR6o5+Z
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a208d93758so31223105e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 04:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793621767; x=1794226567; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BoSygA+rSUd5kKs81oMTEOx8OUAzT9ufCoQu9dV/md0=;
        b=jWR6o5+Z+Jsc79bGAtocigWQs/3pIjO6vma7MnKXFqFTyhp9R9yMFyAsgUzCQ06TL2
         XqdBAnG4bgq+qvsAv7tHNDXBebqq0PeWNOIsoT7V3aZBvblJFR2UZrGFXb6Dlw8y0biW
         vJTyDq9oAiDJaM8+T+kAkJHmK1lLRKxMgFV6n7A70JJc3qvAOtt+kM+AoP12lhvJPLR7
         QX6+6smE5W6cz/L94nCXfjP7u9Uq5lGTcH67Cij+E9wcvIUveiPvd7q2USPiq9hxCYgA
         /8lRVci64n2ci5N9QYTkj0eh2rWQyoVamZatDnLigDAytv3DGtNDd6ScgEjs18s4onWV
         fXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793621767; x=1794226567;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BoSygA+rSUd5kKs81oMTEOx8OUAzT9ufCoQu9dV/md0=;
        b=LkfLbbxTAFqIs0JeSoMbOVsqtXzwSc1p1K04C1G5FHJ9lLK9uxchzB8mOE4iejrC9w
         1R+R9EPyCobb4MZUYLa8pS2cFwYtvwq7zg/mj8OQgH4kcvpAYelQcmARFegZxGJP8AxU
         ZXtehpFO2e2sJ+S60LDObisBDBX+d/Lra1DyKbx7hO79kYKIlDAFQmd7gl0e3c1btZER
         8QbvAT8Hjh/Hn+gw2UcDa6CcjiBr8Cl0oLR/O7m/Eg6oi2Eply2vOEHMkxC0M56MZsij
         vt2VxY8of5Nxo1HlF+0MZsaySksWgyRkiYDFGQeiss19HFgoV3uaQCbKi5fGKfPQrgNf
         QFIA==
X-Forwarded-Encrypted: i=1; AKwUvBw5dMg9xK3ZvlxaLq9elIIsByrCl+AnTBPyTsiI1efmlk9uxyIT3nqODO1iz4pXr/1nEkJW5u8EK6U41eTwG/Vs@vger.kernel.org
X-Gm-Message-State: AFq9FYK0+btrdHv1fqR2Px/lrECzpNbSLY1BhVdYcbmZW7BbO89cWRSq
	/Y2rnONhcSACdY3724iJJhhdyFTfN5gujgeIqrf42Cx+DuhSgtsSlkznrEf78AllsjU=
X-Gm-Gg: AYBFou22Yr8UgtRCInRlWYKMMPVvektSHKpsgtvtw8EpXVkDpyR+veqql5f/XtPVsQ7
	w/kLOXJEdRk1oxCUY0MlHTaXqLBFUd6fKiQqsZduUR7KpBMXOxzI9UDGEdtHCaaCRP/V7u0c4Ak
	+cPKCkTqKf8nQgZF0IBFvG36n3MP9JHQLmLyHXaxrPXNxgm5dygUzwHCWZUwbE/4Y9g4Mcsxyma
	fWNp4suaEyBpGbw+ERSnUxEm1T63clYNs9gYRCvTkH/I1bPhh24hBPRui3JRc4Yuo/78bc9GEMB
	N3c7PD0QuFPqvlXe00ZHDZA0MWk8Iv+dGjUWq3UGiCtlGGbtmRoc1bhBwuBFd5/RGhk4dp5+ERH
	bv5GAXK9Pg16zrKKaelTRDPxLY+/6Ya7xrhNiryBYFvUFgxpMQotS+Fb9NOSm+ejosWOTKUh20q
	L0zmkTj+/7WHbDXmSUcqFxEytiNOqfdBxB3UGTLVNtHSk+3Frc4InRVFISFr7qw4I3msfBXKkXa
	CljuLMMTiMGFYwrEgwrUqvKsxbQmPkSfuDqL3zyPvgxoOZOeUZ91aeaTGRhJL4c15Z7GU1z68RS
	EYD6ft2ueNHYdL5YTd2em82jvjDn+QqhYGdQGXFHh359iy1uRN+utw==
X-Received: by 2002:a05:600c:34cf:b0:4a2:fe3:121b with SMTP id 5b1f17b1804b1-4ac18d68ba0mr204596495e9.28.1793621766831;
        Mon, 02 Nov 2026 04:16:06 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b27e46sm434974855e9.3.2026.11.02.04.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:16:06 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 02 Nov 2026 12:15:32 +0000
Subject: [PATCH v3 18/18] perf test: cs-etm: Test multiple per-thread
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
Message-Id: <20261102-james-cs-unformatted-per-thread-fix-v3-18-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
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

Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../perf/tests/shell/coresight/per-thread-multi.sh | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/tools/perf/tests/shell/coresight/per-thread-multi.sh b/tools/perf/tests/shell/coresight/per-thread-multi.sh
new file mode 100755
index 000000000000..c6bf1ff2e53d
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

