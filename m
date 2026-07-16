Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C0A38D68F
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784185420; cv=none; b=ukWfkYcFCuSceBBPEClqLMjpL4pokotVC9KrS/uMYcVy0e4fNSvB7MWZcfAPvZvx7pClnCqqNLAyvf5PVzwfAg0dBAUYCG45ag5F2cwYBlwwbdhKkiKSQTuB4MoFc0yaOdXG5QXG7b+RntKnY0Z06myaj9iVykZlhGCc4VU5yEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784185420; c=relaxed/simple;
	bh=Iy70ix2G6UJ2waMDQZdP0H/xHnMOXw4T4raHxlZze4E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sLzw7LstjmjUu0jG5LoYLeywQL1z5wRa6bR3e3koh5mgGq/3rablD2BWJko8cLZHaMNgPy8VMP8nxJF0aviVVf0kKiAcJkcmCf3SgJ8tnIDHMVRBnhSggajqjxNkFxsAAO+obU+M3j4WWDwT6zOEGRLb13bnM/VaBGKHWjM7SO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YzBNpDag; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YzBNpDag"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8894570b58so2330614a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 00:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784185419; x=1784790219; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y/A4YjzcgmgX8KmC+PM43mOtsoEDH1gz6SlFM8oolbM=;
        b=YzBNpDagf0EvcCJUdzxxnvXEYnY/k3JihbfTq6zkseXKderlM3xfq4AQRkZQSi+X9D
         /gLlauToU6Fv08eiQX9IsRMPGx69zmq3ov7H+kgjAuKDjdVOO2nYUo/LwzJr6WsKMnto
         wFO1NI+UJ+nmIChFYMc6ldKFqflcB/t8XnL2LcA46UBhXtD0joOnDBmtJNF/zTDV8/dD
         RZLKx2vy7ax2oKCipT898JXL8wsFqBvThN8fQl663bpm3Af3wZA4WEdRMktFgRdSAoQ4
         NibRMvoqMVZ5RljAbTAhTUoecDo4lZbfHCoFtpLiRl5t+un2CljuLPBiO6iu4Zs8MzXw
         cmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784185419; x=1784790219;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y/A4YjzcgmgX8KmC+PM43mOtsoEDH1gz6SlFM8oolbM=;
        b=XeTILh00uoLC0jo9TVjqB1eQzlvZJDMnOODs3atoijnWp0fYGqswnhe7m5S68pZT6E
         yprc28Ps+uRn79cNq85qizOeS8Udf8RyNC44fv1vHKFbi0OwtgVAsLi3Vi2rHHGnViHr
         cKNBhzCph2RwgV09imjkBQa7ODyE71dQrbYG00yi/o013Fg7NJxlAQBynckp0N6SqdQ4
         L2UhqjEItAfh4QFWPINrDGICV+5IzsWqhehu8phSVGlnbpYQKUtK16L8E+np4lSA0tXL
         5pZx+oxEtPCFnwJMBRDVmA3lBd5S4k95371uWma4dvwV6DyDDdjHeSPdfFRecieaNEdE
         xYOQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq8DMCPvblgIT8GAM0mosG/V1uNeLSH2mksWSyC3b/9xd3BEVGmq7pjU4VV5xyCmo8QjFoGQgdQjopOqilttUTC@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2uy3gWF0d81SJlsRVnuMmvLRC8aGlczLBkHjmcjxKSnjjJHLe
	LvqBak3NKzQB7RQqJ2Reo57ZlWDwR2MeDAUpaUOTw2t2tXwzBG0JxiTauWC5P+SzcRJbR6e2J05
	0obPMr1Pg3Q==
X-Received: from dlbek7.prod.google.com ([2002:a05:7022:c87:b0:13b:83ad:69bc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:d82:b0:3b3:2703:110
 with SMTP id adf61e73a8af0-3c110776c30mr24087912637.4.1784185418932; Thu, 16
 Jul 2026 00:03:38 -0700 (PDT)
Date: Thu, 16 Jul 2026 00:03:03 -0700
In-Reply-To: <20260716070303.507066-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716043223.388233-1-irogers@google.com> <20260716070303.507066-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716070303.507066-15-irogers@google.com>
Subject: [PATCH v4 14/14] perf stat: Extend PMU metrics value linter to
 validate --new outputs
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, ctshao@google.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch updates tools/perf/tests/shell/stat_metrics_values.sh to run
the metrics value validation linter twice: once for the legacy path, and
once under the --new print flag using the newly introduced python
validator `-new` argument:

  $PYTHON $pythonvalidator -rule $rulefile -output_dir $tmpdir ... -new

This mathematically guarantees that calculated Intel PMU metric values
staged inside the decoupled streaming JSON callbacks are parsed and
validated cleanly against the formal rules engine.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.5-flash
Acked-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/tests/shell/stat_metrics_values.sh | 22 ++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/stat_metrics_values.sh b/tools/perf/tests/shell/stat_metrics_values.sh
index 86c5c7f70933..3f545e88b69f 100755
--- a/tools/perf/tests/shell/stat_metrics_values.sh
+++ b/tools/perf/tests/shell/stat_metrics_values.sh
@@ -26,13 +26,29 @@ echo "Output will be stored in: $tmpdir"
 for cputype in /sys/bus/event_source/devices/cpu_*; do
 	cputype=$(basename "$cputype")
 	echo "Testing metrics for: $cputype"
-	$PYTHON $pythonvalidator -rule $rulefile -output_dir $tmpdir -wl "${workload}" \
+	mkdir -p "$tmpdir/legacy"
+	$PYTHON $pythonvalidator -rule $rulefile -output_dir "$tmpdir/legacy" -wl "${workload}" \
 		-cputype "${cputype}"
 	ret=$?
-	rm -rf $tmpdir
 	if [ $ret -ne 0 ]; then
-		echo "Metric validation return with errors. Please check metrics reported with errors."
+		echo "Metric validation return with errors. " \
+			"Please check metrics reported with errors in: " \
+			"$tmpdir/legacy"
+		exit $ret
+	fi
+
+	echo "Testing metrics for: $cputype (New API)"
+	mkdir -p "$tmpdir/new"
+	$PYTHON $pythonvalidator -rule $rulefile -output_dir "$tmpdir/new" -wl "${workload}" \
+		-cputype "${cputype}" -new
+	ret=$?
+	if [ $ret -ne 0 ]; then
+		echo "Metric validation return with errors (New API). " \
+			"Please check metrics reported with errors in: " \
+			"$tmpdir/new"
+		exit $ret
 	fi
 done
+rm -rf "$tmpdir"
 exit $ret
 
-- 
2.55.0.141.g00534a21ce-goog

