Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7219F325491
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779129571; cv=none; b=osL4atP9Q6RRMohu7j5KhJaWm6cI5X+GsMwrpLrd4bD/6RkH9HX1hwbbKEu08Ko7Ja/sPswxR9Gw5myu6GA5Y3u3AN/ifP7Lv5ct34rY2qayAkAzoMuHq9/hr6mJ3IIdKmehcUGQ8G28lohwwHwCdI5ZyLN+bLsCVUAXkBYZcX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779129571; c=relaxed/simple;
	bh=XFDHjZs7ib/AZkcV51y1cZbqwQFeIAPBj3G+QAfL+hI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=vBXucDdg6bI68aw1CdMpDyxiJLJ9zJz5ga/UbIkx1pLKdR1nCO+Ftui/U8X2u7bWqLT+Doa8VLp2qha5JduUtje33/hBJtWhALfju9RVC5JHB6K7XdXAeXQ3uZxi9hcrC6VPyBTpQzwHeEEydA38OtnwiJEtXl/MhG6DBP8U9GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ob7WqipC; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ob7WqipC"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1329791f18fso4644196c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 11:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779129570; x=1779734370; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WjmjkNIBm6JKJOik2uUZR4eykueHeYyOAeYgNJxvIjk=;
        b=ob7WqipCLSaGd3sfn5MVtUN+fLw6P9pJRyEIpXy3nHpPEAakavEIEbP6M3qlXUMF1t
         hPRitsROPzgJX+hlGJ13067loKPfLm7M0AtvDlLA5Ema8CFsz3TFe2aWReP4GnV/LmRi
         Iv5l6iUq4zN+6HT04DtkOlqtRFYfd4pTz58yui48L5hk3yxnBan2dSoeW7m6XV5x+vYn
         wqmFRVgMIr8zxK2EwebZw74i6e3SD1iGl3lvIdOMbUy2HFHvYxCAqnJc9t1+j1BhA6PW
         /mKldUSd375PimNfN3RLFmLYTe81rIA4aLSKP4XrwBPV+Hup4zR7oLQ3HpJDy6hJadpk
         KLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779129570; x=1779734370;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WjmjkNIBm6JKJOik2uUZR4eykueHeYyOAeYgNJxvIjk=;
        b=oa+exF9baHD3e66ldd1LuTU0jAP08kNmNDasfldRT/B7tpvYUQAwhBtKpbJzTDWzyy
         tZHqxXDHzPhE+h3PV1eZbPTKYmg0g9UqpZajRu2Hju36xBGljacyuUVnfbNqt6Od9Hq0
         cWZSy7f4JhaU+Gv32opnpY24JMu2RVAeuqwKZpY0svpv33oSozYLilK5Y+ARhL+L9CoS
         Dhhh6mEET2jrOBUJmws0f5A0Rr073IgdUlMjAyPUEjP5ysReMzQGUeKxamo76/0rKhvq
         eZpg2sI5Tn7EKOW0iS7YC3QsbrwRtqkVhL5zjfC3XzOmFfmyPF6gh+d2Xwc1Nqo7GQUi
         W/Nw==
X-Forwarded-Encrypted: i=1; AFNElJ+RRddR0/aAxvhgtYjDWKhMXzmTwM0NN0NY/03haFxbeg+30IAfnNl86cUcS2KzPPnmNICHvgeJvuHT0sf7BOET@vger.kernel.org
X-Gm-Message-State: AOJu0YzaznMt3cECWV7iDT8FwGaTqkyonIgE/1BWrOSfI8G3G98tiTm7
	q09JMI4UW1re8CD7nCbOQQoOY3/OLv9V4uyj6QTnp0pmyZMngt/j7KCYf60uZzLVtej7xZxat4m
	OFc0BauUgsA==
X-Received: from dlbpt3.prod.google.com ([2002:a05:7022:e803:b0:135:3471:e411])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:419f:b0:128:ca83:5aa1
 with SMTP id a92af1059eb24-1350451b07dmr6514932c88.16.1779129568940; Mon, 18
 May 2026 11:39:28 -0700 (PDT)
Date: Mon, 18 May 2026 11:39:20 -0700
In-Reply-To: <20260518183920.2894502-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518183920.2894502-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260518183920.2894502-3-irogers@google.com>
Subject: [PATCH v1 2/2] perf tests: Add test for stat delay option with duration_time
From: Ian Rogers <irogers@google.com>
To: Francesco Nigro <nigro.fra@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a new test case `test_stat_delay` to `stat.sh` to verify that
`duration_time` correctly excludes the delay period when using the
delay option (-D).

The test runs `perf stat -D 1000 -e duration_time sleep 2` and
verifies that `duration_time` is ~1s (excluding the 1s delay), not
~2s.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3-flash
---
 tools/perf/tests/shell/stat.sh | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 4edb04039036..e9a9b2c91cae 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -483,6 +483,38 @@ test_stat_pid() {
   wait $pid 2>/dev/null || true
 }
 
+test_stat_delay() {
+  echo "stat -D test"
+  if ! perf stat -D 1000 -e duration_time sleep 2 > "${stat_output}" 2>&1
+  then
+    echo "stat -D test [Failed - command failed]"
+    cat "${stat_output}"
+    err=1
+    return
+  fi
+
+  duration=$(grep "duration_time" "${stat_output}" | awk '{print $1}' | tr -d ',')
+  if [ -z "$duration" ]
+  then
+    echo "stat -D test [Failed - failed to find duration_time in output]"
+    cat "${stat_output}"
+    err=1
+    return
+  fi
+
+  # duration is in ns. We expect it to be ~1s (1,000,000,000 ns) because
+  # sleep 2 runs for 2s, and we delay by 1s, so measured window is 1s.
+  # If it includes delay, it will be > 2s (2,000,000,000 ns).
+  if [ "$duration" -gt 1500000000 ]
+  then
+    echo "stat -D test [Failed - duration_time ($duration ns) includes delay]"
+    cat "${stat_output}"
+    err=1
+    return
+  fi
+  echo "stat -D test [Success]"
+}
+
 test_default_stat
 test_null_stat
 test_offline_cpu_stat
@@ -498,6 +530,7 @@ test_stat_no_aggr
 test_stat_detailed
 test_stat_repeat
 test_stat_pid
+test_stat_delay
 
 cleanup
 exit $err
-- 
2.54.0.631.ge1b05301d1-goog

