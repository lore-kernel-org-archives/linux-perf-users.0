Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB923909AC
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489272; cv=none; b=Fb25WVNSECOiGMaFlE8Vy4gRZKizWm0BNtcsbY6cz3huh3bHq3JeT1Ah6bGukK1nr3oddx1fw8W4yx2GiAAp1TIwhB5JrDKOYPsHBtusEiUxyOl0RjlXzRT6+XotDforC3CsrHqaxPC9C3nbYe84JmRiycbnE1bY19xatXzQGHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489272; c=relaxed/simple;
	bh=QFMynWcJjkS5MnPj61sKETHhVCs6vtQC2XYtUOE/oe8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=WAwg8vsqx/k4dQx7oQXHjCgIFwZMir21/eOnqEy/jzy7vkMC/yzzplckfIRA971jd9KMNNNdkekmT/G0xFKaj0b8ea+M1WOJlARJ5I4AdRpsYcLrouqKgGKuC7ePhQxi0axJ0s73HZctBpIfZJJq9/tpTtxISkqwoqiUU1aSXAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=miE5ZThn; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="miE5ZThn"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304627c66ddso741285eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 15:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779489266; x=1780094066; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QhHSiOmkLS8o0pebuQEPSAqgSPXeTQRZXi8kWVXxgY0=;
        b=miE5ZThn2r7YdzDorYfp47YNxTTwcUOc3Rb72DtOVZN/VSDpj2x97oLjjt0kQ53nEa
         cteDRqMB6g9w+WQ3VxJgFoB4kid76tIdYz8NLFzT0H+KCbRksRcXla166Up5Q8F8Tn23
         2IafirabzdAdZ3ZPlD1uw/zLO6HQsd+tQV9tTMEuH8GEr5Oy/D3XNOB6eW2vVZrHkCob
         itgr/4pmCdAumrx6D3b8GTUHk72Pd7b3DAyrr4UqkWIB3Dj18AzSEG4i0Jli/Zi8kmkr
         wZQNip9Xc/sfg4uf5tj2+xMEp0UbOZxtN1l3Zw7Tb8aUSClAsRWR9vwcinEtO/i1Dhmw
         Ib7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779489266; x=1780094066;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QhHSiOmkLS8o0pebuQEPSAqgSPXeTQRZXi8kWVXxgY0=;
        b=Z2gQn35bygGrkLv288Ls5M1k4zeDtWIeT6YF9H5fd9bIk6Yf1uM+3VQLu367CNzBOh
         oe1hvBPdj3PiXWBjWelOTf+Up+8HH0ywsSqmpWnZZJ5ZKaBCGzQUHpV8aa2VmAkfgaf9
         5VvIqBymyYaSyLprq/XVMHTIBV8OszS20OwGql1ffy7D2bOLI3j45lV0dY7kZPN44y+5
         X4BQvPrwG1rekJChmUSFwt3q/Wgna29680FFoBRxlBFY8WIQN6YcnORSR9DZsvrFhmvf
         v+2sGEn+CGoOySR9LOLuWHPGahzIldta+8CkpuxlRnD9ivd+1rnDz1wAHHno7UlX1guP
         Tocg==
X-Forwarded-Encrypted: i=1; AFNElJ/2UHSqr699Fg81QnHpoF7P7WJRVmG0UEjX1skRkWT84jUX8TZRwNghEmTL8LfV5zBXHM666h3e2tMKuvSX9Mtn@vger.kernel.org
X-Gm-Message-State: AOJu0YxiO4MMBfg8zCRhTKbZjjOphiBaPqTx5X+8t3y/TAVB5bgI1/Y2
	NdUtds2kBEggT8TK8Y2GlIpL4lQsUagLkBPbQCs9bj1rgvtpDktAGv8bxEOvgCdMvk9BT+rT0GT
	EwY0knmfguw==
X-Received: from dybow8.prod.google.com ([2002:a05:7300:ec08:b0:2dc:7d1e:d0e7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2c92:b0:2c7:3a7:c7a7
 with SMTP id 5a478bee46e88-30449193190mr2615481eec.25.1779489265617; Fri, 22
 May 2026 15:34:25 -0700 (PDT)
Date: Fri, 22 May 2026 15:33:39 -0700
In-Reply-To: <20260522223342.2393553-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522223342.2393553-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522223342.2393553-12-irogers@google.com>
Subject: [RFC PATCH v1 11/14] perf stat: Extend JSON output linter to test
 core aggregation checks
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch extends tools/perf/tests/shell/stat+json_output.sh to run
all basic and standard CPU/thread aggregation checks under the --new
JSON print flag:

  - check_no_args
  - check_system_wide
  - check_interval
  - check_event
  - check_per_thread
  - check_per_node
  - check_system_wide_no_aggr
  - check_per_core
  - check_per_socket
  - check_per_die

This guarantees that JSON outputs produced by the decoupled, zero-allocation,
and streaming print callbacks are formally validated across standard and interval modes.

Signed-off-by: Ian Rogers <irogers@google.com>

TAG=agy
CONV=7c33d6a0-70a2-454a-82f7-4de2101a5b9c
---
 tools/perf/tests/shell/stat+json_output.sh | 43 +++++++++++++++-------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/tests/shell/stat+json_output.sh
index 85d1ad7186c6..d35098aae093 100755
--- a/tools/perf/tests/shell/stat+json_output.sh
+++ b/tools/perf/tests/shell/stat+json_output.sh
@@ -13,6 +13,7 @@ shelldir=$(dirname "$0")
 . "${shelldir}"/lib/setup_python.sh
 pythonchecker=$(dirname $0)/lib/perf_json_output_lint.py
 
+perf_new_opt=""
 stat_output=$(mktemp /tmp/__perf_test.stat_output.json.XXXXX)
 
 cleanup() {
@@ -36,7 +37,7 @@ function ParanoidAndNotRoot()
 check_no_args()
 {
 	echo -n "Checking json output: no args "
-	perf stat -j -o "${stat_output}" true
+	perf stat -j $perf_new_opt -o "${stat_output}" true
 	$PYTHON $pythonchecker --no-args --file "${stat_output}"
 	echo "[Success]"
 }
@@ -49,7 +50,7 @@ check_system_wide()
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	perf stat -j -a -o "${stat_output}" true
+	perf stat -j $perf_new_opt -a -o "${stat_output}" true
 	$PYTHON $pythonchecker --system-wide --file "${stat_output}"
 	echo "[Success]"
 }
@@ -62,7 +63,7 @@ check_system_wide_no_aggr()
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	perf stat -j -A -a --no-merge -o "${stat_output}" true
+	perf stat -j $perf_new_opt -A -a --no-merge -o "${stat_output}" true
 	$PYTHON $pythonchecker --system-wide-no-aggr --file "${stat_output}"
 	echo "[Success]"
 }
@@ -70,7 +71,7 @@ check_system_wide_no_aggr()
 check_interval()
 {
 	echo -n "Checking json output: interval "
-	perf stat -j -I 1000 -o "${stat_output}" true
+	perf stat -j $perf_new_opt -I 1000 -o "${stat_output}" true
 	$PYTHON $pythonchecker --interval --file "${stat_output}"
 	echo "[Success]"
 }
@@ -79,7 +80,7 @@ check_interval()
 check_event()
 {
 	echo -n "Checking json output: event "
-	perf stat -j -e cpu-clock -o "${stat_output}" true
+	perf stat -j $perf_new_opt -e cpu-clock -o "${stat_output}" true
 	$PYTHON $pythonchecker --event --file "${stat_output}"
 	echo "[Success]"
 }
@@ -92,7 +93,7 @@ check_per_core()
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	perf stat -j --per-core -a -o "${stat_output}" true
+	perf stat -j $perf_new_opt --per-core -a -o "${stat_output}" true
 	$PYTHON $pythonchecker --per-core --file "${stat_output}"
 	echo "[Success]"
 }
@@ -105,7 +106,7 @@ check_per_thread()
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	perf stat -j --per-thread -p $$ -o "${stat_output}" true
+	perf stat -j $perf_new_opt --per-thread -p $$ -o "${stat_output}" true
 	$PYTHON $pythonchecker --per-thread --file "${stat_output}"
 	echo "[Success]"
 }
@@ -118,7 +119,7 @@ check_per_cache_instance()
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	perf stat -j --per-cache -a true 2>&1 | $PYTHON $pythonchecker --per-cache
+	perf stat -j $perf_new_opt --per-cache -a true 2>&1 | $PYTHON $pythonchecker --per-cache
 	echo "[Success]"
 }
 
@@ -130,7 +131,7 @@ check_per_cluster()
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	perf stat -j --per-cluster -a true 2>&1 | $PYTHON $pythonchecker --per-cluster
+	perf stat -j $perf_new_opt --per-cluster -a true 2>&1 | $PYTHON $pythonchecker --per-cluster
 	echo "[Success]"
 }
 
@@ -142,7 +143,7 @@ check_per_die()
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	perf stat -j --per-die -a -o "${stat_output}" true
+	perf stat -j $perf_new_opt --per-die -a -o "${stat_output}" true
 	$PYTHON $pythonchecker --per-die --file "${stat_output}"
 	echo "[Success]"
 }
@@ -155,7 +156,7 @@ check_per_node()
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	perf stat -j --per-node -a -o "${stat_output}" true
+	perf stat -j $perf_new_opt --per-node -a -o "${stat_output}" true
 	$PYTHON $pythonchecker --per-node --file "${stat_output}"
 	echo "[Success]"
 }
@@ -168,7 +169,7 @@ check_per_socket()
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	perf stat -j --per-socket -a -o "${stat_output}" true
+	perf stat -j $perf_new_opt --per-socket -a -o "${stat_output}" true
 	$PYTHON $pythonchecker --per-socket --file "${stat_output}"
 	echo "[Success]"
 }
@@ -181,7 +182,7 @@ check_metric_only()
 		echo "[Skip] CPU-measurement counter facility not installed"
 		return
 	fi
-	perf stat -j --metric-only -M page_faults_per_second -o "${stat_output}" true
+	perf stat -j $perf_new_opt --metric-only -M page_faults_per_second -o "${stat_output}" true
 	$PYTHON $pythonchecker --metric-only --file "${stat_output}"
 	echo "[Success]"
 }
@@ -232,5 +233,21 @@ then
 else
 	echo "[Skip] Skipping tests for system_wide_no_aggr, per_core, per_die and per_socket since socket id exposed via topology is invalid"
 fi
+# Run New API JSON basic and standard aggregation checks
+perf_new_opt="--new"
+check_no_args
+check_system_wide
+check_interval
+check_event
+check_per_thread
+check_per_node
+if [ $skip_test -ne 1 ]
+then
+	check_system_wide_no_aggr
+	check_per_core
+	check_per_die
+	check_per_socket
+fi
+
 cleanup
 exit 0
-- 
2.54.0.794.g4f17f83d09-goog

