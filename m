Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4F644682B
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462273; cv=none; b=pNOPV9OzHEDIthXRvxPg3VZ6XRtWGvGUxIvFXivtU1Ms6f+poUARfRGdO1h54WI6dWTiEPzaTNwD7zrhMfeT6lVOisK8Ag2+i2zkGl7BcCOu7++0auOJtGhSboIvif3108uQOFJcX6a2gqrztlPVpk/Ny2WFOmLWkeWuMOj7TUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462273; c=relaxed/simple;
	bh=oUg7RFIUnB5PZ229CdzPdEVvo+kzyf00RHPUIVcKnFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T6Qo7GqAr/+M5difcTLJLrhu9IRdx/p4D443JpZIe3C4J/f1vtwA3I9RDgC0R+YFGjf3WPpnpeJl2uZ/YjO1Qde9ZmIOIU5gFI2ijD2SDunMjJDY7vtqAgw3VSo6/+MJpQI7Lza+YefqpzVNuhOkYiOaNGnRtk6xRGLpFI3yTVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y7Lszj0H; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y7Lszj0H"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49553515a8bso51318135e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 08:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786462270; x=1787067070; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XCKgmnJbp7mmf0EumlB0lo4QQt9rPy5YuLxw+XknrhY=;
        b=Y7Lszj0H27SmfxlrUZIWt+HWf+SEXJE95/R33dWh5KuM7sI4JVHDzLCxoTyvTqzmF9
         VGQcA+CP9T8J7fyOk9UxJxUQEE9Z3DtrBzSgD8XZiReyIJ6A3LrUcy81kLgyFDOXf1rl
         Iafvyrb2D2KJkip/MIlysM4XX3FcmP0V63Mb/0Av+AzGq5vIGWWABED5W0QmNQ1w+PB4
         gMWU0vW88R7k+ZfZSPItzVoUYGoc22Y/2+I7tWjMxhCb36JAXTGtVk0VmKEYVROpX04D
         fm2tp2C2JuoRTaKmpkTZkJKtAmju8xr1IvJlpca4ROxZK5LiMtzId/L9IWB1WFvmi2o4
         2Blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786462270; x=1787067070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XCKgmnJbp7mmf0EumlB0lo4QQt9rPy5YuLxw+XknrhY=;
        b=khhdtRy5qNpjutQJTSaM1rPiLPOFetl5KqLcsm4mQEplaL7PzfrzVIeysA2JqKYAvU
         f21F/PH8GiM5X/v+yqv13/xBknuAkDVvLqGXeHVzZfYjBgE0idqRaFArUgvA4nno0waI
         hhmb/oLhpBXjNHHKqpdqxU0EriRqRDPrJlCA6PD+astsKTmwndM521R++Ocl6+ezEbac
         6LXwp9axQfin6wX4jjbrXQvJ4c0d3Gw6p8zUBTLk2J4d0eh/nEAUWVvEzEIrzNyV0CFF
         gWeINYeROPN2IKInqVLmfB4+GnBFVrQOFEjnnhdHtBhWIh/QM/oODePpp83ZZaOrFQRT
         GHhA==
X-Forwarded-Encrypted: i=1; AHgh+Rq/RYI0lPvgGEvugW+7eqLy6bwogUYmou1xU4bkP1gCVLBfVwHox/Cilh38muqLTr4b8gDhiN1nrXwMfN78ccF0@vger.kernel.org
X-Gm-Message-State: AOJu0YwGvBi3pIWg7GcmjGBQqTNuA6UvqY6XXfXC+g/BRH48xy4sz0gZ
	nza+9rA8gAYAxx40L4Avj8Z7dfQrll8IIFcNJYz6bopV1O8fATnrqPnPY0m/HlKNXw0=
X-Gm-Gg: AR+sD12ur4hzvZvXFqFuVucNLOmVkPnA+38BC6OFdWVOK6VwKlNeh2k0mWMZcgjtkZf
	McAqo8DY0TCYCJkSgc88lsV7j5Ay2TtRPhT1bK58QKTXNk80t+IymBPrGbwKEqQD0e8ORimCk1P
	YNDsyG9UcqCCm6hTsu5EGF0rvAz4J7eIA9IXXTRIvKUEwU/hLVWhshArCPr/dePVc2jx4hAHjVE
	S8x+ORlpTV3dj+XrCJTpcV8FR+hKtV6nxmByX/PuYpqXizYIAkDr1/b94sqTcG/LRUv9BuDrnck
	LBZ7IgPgvtdLsdkBH1gp/3IPXWNVr1LH8OA1SwGmokXR/QCLqjNclP5BNdCg9yW3ib0HfL/jMvB
	i+GAzk+WVr8Q2f1Oy3SCqk5X9rT9FSp8c+fDWnVQHmFzoz9MhsFOur6L1uFYo5+FfrlbbflXARN
	Ie2mskGE+BuiDy2nZd5rFww36nrymiwUBHA/dDnU9gm0vUCfmqjjAX3Bvp6qrrqRGr
X-Received: by 2002:a05:600c:c162:b0:499:484a:7644 with SMTP id 5b1f17b1804b1-4997845f3e7mr63045865e9.9.1786462269793;
        Tue, 11 Aug 2026 08:31:09 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49977dfacb6sm49865395e9.1.2026.08.11.08.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 08:31:09 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 11 Aug 2026 16:30:16 +0100
Subject: [PATCH 13/14] perf test: Add test for per-thread mode
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-james-cs-unformatted-per-thread-fix-v1-13-90565318f5f8@linaro.org>
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

Test that per-thread mode works when the process migrates across CPUs
and that the decode happens in the correct order.

A TODO is left in for when support for decoding in order with Perf
records is added.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/coresight/per-thread.sh | 48 ++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/perf/tests/shell/coresight/per-thread.sh b/tools/perf/tests/shell/coresight/per-thread.sh
new file mode 100755
index 000000000000..77d1ed3405a9
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/per-thread.sh
@@ -0,0 +1,48 @@
+#!/bin/bash -e
+# CoreSight per-thread CPU attribution (exclusive)
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
+	rm -rf "$tmpdir"
+	trap - EXIT TERM INT
+}
+
+trap cleanup_files EXIT
+trap 'cleanup_files; exit 1' TERM INT
+
+echo "Recording..."
+perf record -o "$tmpdir/data" -e cs_etm//u --per-thread -- \
+	taskset --cpu-list 0 taskset --cpu-list 1 taskset --cpu-list 2 true > /dev/null 2>&1
+
+echo "Decoding..."
+perf script -i "$tmpdir/data" --itrace=b -F comm,cpu 2> /dev/null | \
+	grep -Eo '(taskset|true).*(\[[0-9]+\])' | \
+	uniq | tail -n 3 > "$tmpdir/script" 2>/dev/null
+
+# Check that the decode says it ran on CPU 0, 1, 2, in that order. TODO: The
+# correct result should be "taskset [0,1,2], true 2" but we don't decode trace
+# in order of the Perf events yet, so everything is associated with the last
+# exec.
+cat > "$tmpdir/expected" << EOF
+true [000]
+true [001]
+true [002]
+EOF
+
+if ! diff -q "$tmpdir/script" "$tmpdir/expected"; then
+	echo "FAIL: per-thread output doesn't match expected:"
+	cat "$tmpdir/script"
+	exit 1
+fi
+
+exit 0

-- 
2.43.0

