Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D707D2DEA95
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Dec 2025 21:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764798446; cv=none; b=H6wk16s93WouKJVNPhh0SYXzBTvidyq8/MbqX2I/0BRf+Dl8NkkNGiV4GiBJ37XAvgV7ZhaVrv4DJ1g66kZf+SpxIPbcLoKwOzXHz24+BSAEdn2qn2RgvzKSb1b6HdvJgBY8To2b5yLizsYjrzck/sFDQE3ScmiifeJsCF5CFFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764798446; c=relaxed/simple;
	bh=Gx3JjXPhyf4K31F1oSQwVaIDiiuTokaWZT2VKxSeKlU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=B5JbH0zwUg+0AtIT6FUF0jfWuF1SeuWjfRJruU50ztkZ2lLfxhrA20FMQEoR5tK/ELZPdbBBP+anmg4XlXu2dDHF5tgT668e54+ozGy1oewtolo4GYXsThj03gOISiSRLzZE7uqMPO/ACJxEEUsrhe9tcPx0FdfhGa+ZN2STMyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tI4GGQM0; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tI4GGQM0"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-bc2a04abc5aso164723a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Dec 2025 13:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764798444; x=1765403244; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cl5+8xbClVweIwNwbXuJK+Q4qhM9Nu7TLMnqmk8eKXk=;
        b=tI4GGQM0LcERqu5GoBHJmVW9dOAMYJtH0FhvLy5JyWyeQ2fBL8VOwXJke4RvjwyHfK
         JO5uuYnX5CWXvdk5BFsUlB04BQinqUY0ZRtX7bCR6GtYIM8gaLlekZFOwB/g7uFdwXKs
         ui0rxL3FwR1P1FbZ2Tu8BiEm+Zvmq0kIELovkXsd+k56LEyHF7GQLn7kNFcn/5BWfuwt
         VvH1u+sUEjH4dtj26rSDif1MKV9TaTV8GBRtEJDBG2LF7mJeZiNNsL27BbX/0mJHcqBB
         BF2EkXXi4iGn0XZXY3Re+JAv1dHMU3bAh1T6+TMQhWezmg1UAgZtLBnFSCkc15s5O5Jl
         HAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764798444; x=1765403244;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cl5+8xbClVweIwNwbXuJK+Q4qhM9Nu7TLMnqmk8eKXk=;
        b=bBW6O54FoVOZ2lbA31GglWDAmSd0eP0bLpbJUg7bVgMeGV6wMQRCz6/KkkUFxzfI/F
         PE8tBd4IQ9V3wKMQnb02FqnUp0uYoH9lPmiI3mTMODOLE85zhiZUgLLqgC+2bDQv2j6z
         w9mqNAucq+6jo7zfl5XS3wwMcgPTdUFYBvzTcBoLSWPfkMwIq8E+1I0ug/S0754UQL6H
         b8PqEpqe+hmQfWsN7RXBQByf8yFASwp8XCsWJz9pn42oH/Jxv+U+BbiwuYgj0EqIej+k
         0yIl2NMCdYC7rlGkTeTvvpAy2Ta9/cd4R+kdFG3Uq7DKp9XsX7Dq1caJQ84pwwxhDeic
         gc3w==
X-Forwarded-Encrypted: i=1; AJvYcCWGI9R2e3br14URjwim+o5wvPt3wCwCMJaLjG8ai+g2Q24NpdD3YP+X5ntqrtsttl+DZCHPzEOFx51gJqZ2S+Co@vger.kernel.org
X-Gm-Message-State: AOJu0YzyPsicfkQKD43y9iZO2U32W3K6sCvbfvlLq4ep6cLopY0LgEra
	AJENzqvwqW9KXhn7x1TDS+nEO4fNAHSS5C2Sg6tV3TuL2NkeyQcgEHXonGmOtKZuLhhkKYuHz7Q
	cW9357XRbQA==
X-Google-Smtp-Source: AGHT+IHoOO93hzmFFlcQIYCbtgZj5ffz/3Wxhh2XCDCoisunfP+n6KCvgGin6yHxpV1LaAnMC1gvdiILhBSD
X-Received: from dlbpk8.prod.google.com ([2002:a05:7022:3848:b0:119:49ca:6bb0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:18ad:b0:2a4:3593:466b
 with SMTP id 5a478bee46e88-2aba422c066mr382160eec.7.1764798444290; Wed, 03
 Dec 2025 13:47:24 -0800 (PST)
Date: Wed,  3 Dec 2025 13:47:05 -0800
In-Reply-To: <20251203214706.112174-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251203214706.112174-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.177.g9f829587af-goog
Message-ID: <20251203214706.112174-7-irogers@google.com>
Subject: [PATCH v2 6/7] perf tests stat: Add test for error for an offline CPU
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a test that if an offline CPU is requested perf stat will fail.

```
$ perf test -vv "perf stat tests"
101: perf stat tests:
--- start ---
test child forked, pid 46965
Basic stat command test
Basic stat command test [Success]
Null stat command test
Null stat command test [Success]
Offline CPU stat command test (cpu 8)
Offline CPU stat command test [Success]
stat record and report test
stat record and report test [Success]
stat record and script test
stat record and script test [Success]
stat repeat weak groups test
stat repeat weak groups test [Success]
Topdown event group test
Topdown event group test [Success]
Topdown weak groups test
Topdown weak groups test [Skipped event parsing failed]
cputype test
cputype test [Success]
hybrid test
hybrid test [Success]
---- end(0) ----
101: perf stat tests                                                 : Ok
```

Reported-by: Thomas Richter <tmricht@linux.ibm.com>
Closes: https://lore.kernel.org/linux-perf-users/94313b82-888b-4f42-9fb0-4585f9e90080@linux.ibm.com/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 7885e875caf4..0b2f0f88ca16 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -27,6 +27,32 @@ test_null_stat() {
   echo "Null stat command test [Success]"
 }
 
+find_offline_cpu() {
+  for i in $(seq 1 4096)
+  do
+    if [[ ! -f /sys/devices/system/cpu/cpu$i/online || \
+          $(cat /sys/devices/system/cpu/cpu$i/online) == "0" ]]
+    then
+      echo $i
+      return
+    fi
+  done
+  echo "Failed to find offline CPU"
+  exit 1
+}
+
+test_offline_cpu_stat() {
+  cpu=$(find_offline_cpu)
+  echo "Offline CPU stat command test (cpu $cpu)"
+  if ! perf stat "-C$cpu" -e cycles true 2>&1 | grep -E -q "No supported events found."
+  then
+    echo "Offline CPU stat command test [Failed]"
+    err=1
+    return
+  fi
+  echo "Offline CPU stat command test [Success]"
+}
+
 test_stat_record_report() {
   echo "stat record and report test"
   if ! perf stat record -e task-clock -o - true | perf stat report -i - 2>&1 | \
@@ -224,6 +250,7 @@ test_hybrid() {
 
 test_default_stat
 test_null_stat
+test_offline_cpu_stat
 test_stat_record_report
 test_stat_record_script
 test_stat_repeat_weak_groups
-- 
2.52.0.177.g9f829587af-goog

