Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333363655E8
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 23:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779751183; cv=none; b=Sd1QWoj920gZNh4Bw2CXUO4euORxMjzjYALUXBoGs1H+g9TuI2On4oxFywR6o2YFu2k13BRwLojJwxYeGgLZRXw7n1c2bd8WW3LLSSZtWFtAbmQ9IRktWaMpPSQBqTN6AOIRiWiy6RwhpQHXGLawrkfNsjeBC2ZMYFUARGPdyK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779751183; c=relaxed/simple;
	bh=hxbLB2LEq8NNt0do8A4kQ52q5KzoHe/RBvk/H6KIoBs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RK6R4nF4JWf3ccMlpgFDx4rmwtaZ6h47Vpej/syAhRdEn9hbVlm9Q+A69tOck5QjJBEQ9YGkxHbNFT55XrNgZIihH99IwgRYpnC0CL5DTNTsZSj8yyFDnSIq3kcjB0DPTaMK6xGOw7+6YtQa4mP8F4Uoups35FNRVKmKoKTbw/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OKTOxB8T; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OKTOxB8T"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-3041ab826ddso8596951eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 16:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779751180; x=1780355980; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Npd//55GHZWJhH7nvE5upXpdkQJTmyWRacTGdZE3uoo=;
        b=OKTOxB8Tw6kMmfiBO5b25tVEi7XO6tKULfGUtRVfFEyQj/okF9SPtz0TsvTG1fgElH
         DRGUAsb0zBYmxFTY5e9e5Fr9rlHjcB/mqqaFVL/OE5bOfzCHIbWo63VL5s8DKJ0PJHrD
         R77Vw6UBzzUCA7aLVNalzMZP5HLa4H5Yf5A2VR/Bgppf2tIIR5H0K1+qaFDs9y9YdkL3
         3myFNuY0xnn01Hg5YKCBki29RRqgMK8IjGUnMr1rBVH+4Jr0pSWPvwA/x4T4AKHeM9Bw
         8CM7Rb8DdeocMX5Mu3NVuTOcqUTKlWA/U65MUQOhjhdBFXVIdfRUNpmV7eHDyMAypgMD
         Ex+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779751180; x=1780355980;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Npd//55GHZWJhH7nvE5upXpdkQJTmyWRacTGdZE3uoo=;
        b=k7oBY8vNRwM5HRfEex39w0v9mWGV1QM3zalLuEdjOc2AlPfFiQjtAFN271+K1QZGgQ
         Wi+n5aRaqlcAmeA9hvvg3BkbdBEBNUZbA1G4SHhztG8fpZcvNOx634PW13G9Ewk/Whsz
         VnGl6KHOojWf2uw+gyM+WzbUHfYuC/7JYOlRZ9fPVa9SjdLKuwhttVmh52a495EUw7Uc
         plqS6dgJj5kytSmLZU1z8zO8MUB9uDPoJic8oCo3PQ4kHP4fIWUo/gMW734NaRXDNM2x
         ZRKhMs/UOumE9eDHrzykxkG9kFOeycCOZqr+tiLDsvS6ORVNiyPknGnnkn4xBghyuzvT
         fVFA==
X-Forwarded-Encrypted: i=1; AFNElJ/dBsjIMYWqcM1Dw8Ty9lxdZwW9Phxg99Uj5S1lnXNUcs/3Bt/lIdhK7kuzqQyekuwdcxzjldOjJl1Qyd7nTRdf@vger.kernel.org
X-Gm-Message-State: AOJu0YzE6uG9rrU1WhKb10NcoGpLAytXUNuDzUxTHzLS+2m38kFS2QM9
	HEqU6vQXsS8cd92C7/UAQHLEoPfcbZUj+jFL+5nxsRypnRJHVtgAj6ZdVkEDCG9Pldw198eHMkk
	lBPp5/8+BwQ==
X-Received: from dycnn12.prod.google.com ([2002:a05:7301:140c:b0:304:6bd9:6beb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:430f:b0:304:5b0d:489b
 with SMTP id 5a478bee46e88-3045b0d4dd5mr6291926eec.27.1779751180073; Mon, 25
 May 2026 16:19:40 -0700 (PDT)
Date: Mon, 25 May 2026 16:19:00 -0700
In-Reply-To: <20260525231900.3527228-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522223342.2393553-1-irogers@google.com> <20260525231900.3527228-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260525231900.3527228-15-irogers@google.com>
Subject: [RFC PATCH v2 14/14] perf stat: Extend PMU metrics value linter to
 validate --new outputs
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, linux-perf-users@vger.kernel.org, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch updates tools/perf/tests/shell/stat_metrics_values.sh to run
the metrics value validation linter twice: once for the legacy path,
and once under the --new print flag using the newly introduced python
validator `-new` argument:

  $PYTHON $pythonvalidator -rule $rulefile -output_dir $tmpdir ... -new

This mathematically guarantees that calculated Intel PMU metric values
staged inside the decoupled streaming JSON callbacks are parsed and
validated cleanly against the formal rules engine.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.5-flash
---
 tools/perf/tests/shell/stat_metrics_values.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat_metrics_values.sh b/tools/perf/tests/shell/stat_metrics_values.sh
index 30566f0b5427..02c0bcf6e078 100755
--- a/tools/perf/tests/shell/stat_metrics_values.sh
+++ b/tools/perf/tests/shell/stat_metrics_values.sh
@@ -22,9 +22,20 @@ for cputype in /sys/bus/event_source/devices/cpu_*; do
 	$PYTHON $pythonvalidator -rule $rulefile -output_dir $tmpdir -wl "${workload}" \
 		-cputype "${cputype}"
 	ret=$?
-	rm -rf $tmpdir
 	if [ $ret -ne 0 ]; then
 		echo "Metric validation return with errors. Please check metrics reported with errors."
+		rm -rf $tmpdir
+		exit $ret
+	fi
+
+	echo "Testing metrics for: $cputype (New API)"
+	$PYTHON $pythonvalidator -rule $rulefile -output_dir $tmpdir -wl "${workload}" \
+		-cputype "${cputype}" -new
+	ret=$?
+	rm -rf $tmpdir
+	if [ $ret -ne 0 ]; then
+		echo "Metric validation return with errors (New API). Please check metrics reported with errors."
+		exit $ret
 	fi
 done
 exit $ret
-- 
2.54.0.794.g4f17f83d09-goog

