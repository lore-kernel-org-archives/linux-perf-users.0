Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C04F13280C
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Apr 2024 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713286836; cv=none; b=OFi+aV8PdE6p2xi7f5jkymX/AYl5rWmHymb9cThIgkKLQKmel8UskeLWnxvGuMrdOH5nzqgtWuwne9XQDsGVCI2AEgpPP5WelD8Mho8wC50WQFMNDTD2SyARz5baDj1q2zAj778gfT00npPIZ25sbdESKNGjya72kndW2uaIsFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713286836; c=relaxed/simple;
	bh=3azWwaKDy7OkYK9A/N5tN+0dZsIUgmKW69mfQHRw+84=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=aasnQgqi+nN7hWdrXIlt1NJmpJY6Pi/doXMV5G6wZsh0IRHZ35oOql79tPTcOoECyslZOPbS12+yGrcnK1FsR1Z3gbzF6dXtEFpgYJjSDHUUyk59+9lB7vP5Nl2MapjE7wgPUtLHHLMO7GoNKgIXrexcNO9IFlxZw7EVMxXfXz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=owrHO8Qr; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="owrHO8Qr"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc746178515so7255583276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Apr 2024 10:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713286834; x=1713891634; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gbNmO/QFS90hYQDF1r8HedKXiPrYZk/5X6GpWU+pA5c=;
        b=owrHO8Qr22XZD2IHadek7+8L74//qALlDJnrgYshOpWstWQeBNjcTnabgdayeaKKmj
         Efc2QyUzDVr4T/lws8wvhVdRpC3NsRUi9yvfs/8pdb1j7lsGcwyY2LLRL4XvvKJPQ/s3
         c/6E1Cj03Cx6YvLw8s26Yzyfkga/Mf0TqS8r1TOTXZdgJjAJkt539KGozZaQc3AYvsBW
         sTj5nGcvhlQ6hMf+vAvymQHRF9Ry5puxUZHtVAEJZPB4hG/2vgdfw5fbwPqb9lMx1AHO
         IyUtGAuqfIIjbK9756vWFpTo9C2Bm2lX8nB34FpbOfmLhHqTD8IuhWnStKZ+SWXBMssU
         LdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713286834; x=1713891634;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gbNmO/QFS90hYQDF1r8HedKXiPrYZk/5X6GpWU+pA5c=;
        b=RTB7J2oABZ8fnaeWu6WDw2mEyxBeH6mFtNHXdhIbAOhUEFvpTknPkWakeRaAAmo74V
         U4wpp9BrY2nUch+XiuIrwdoSv56U9rSt7SiIjhsfOBVVwlYY7MAd07QDKahWl5kFfyLf
         xVabDTNSIv+Ywg4gqVnt/Tj9YjkNEZW78Ok4wY53DYccH5efMY9DWxiHEPyH8hWIjmLp
         ZpOFY05MsnMoAN5tTUAHNZ5p3NNBcIIN9ojMyW/WSSY8+2wNH6Ukw/ZGbIZ0m9T2ITqF
         zdHHbcx52d7eGCGcziwrDYQ8SNJyUL2iOs89QW0cPBCq659qQEWHgwZ8+Cfx+6ecbYBB
         sF7g==
X-Forwarded-Encrypted: i=1; AJvYcCXPtN9Mz7Qd6MKxDBlXOR8r88ou7woYhMvrDovD9o6sHwcq9C3QHUeIGwlbkxWvBRfYFeGXqwxA+5eicMSeYRPPTtnsA/MJ3ThMRJsz+oTctw==
X-Gm-Message-State: AOJu0YwjIAAjLUA+Hm2IiSs/wtAiO4TGerlAtc+G8C6Oz9rCWmXz1J9d
	5X1oiqyN7OGJ6MC6AQp8B4xUkvYzIwzao0cs9HnqBYNp8Dlgpnq8M8a3yffeGOwyVh2AGKqseAn
	CiYxgdw==
X-Google-Smtp-Source: AGHT+IG8Yp5pxeh8BkvzQbDZZGXurtoM83UNZeLc4jlw+B1QTQ7IUSLyyyBZgMoIMefNj3PHuVs4AgR3BorK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:30c8:f541:acad:b4f7])
 (user=irogers job=sendgmr) by 2002:a25:addf:0:b0:dd9:1db5:8348 with SMTP id
 d31-20020a25addf000000b00dd91db58348mr3962354ybe.8.1713286834339; Tue, 16 Apr
 2024 10:00:34 -0700 (PDT)
Date: Tue, 16 Apr 2024 10:00:14 -0700
In-Reply-To: <20240416170014.985191-1-irogers@google.com>
Message-Id: <20240416170014.985191-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416170014.985191-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v1 2/2] perf test bpf-counters: Add test for BPF event modifier
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Song Liu <song@kernel.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Refactor test to better enable sharing of logic, to give an idea of
progress and introduce test functions. Add test of measuring both
cycles and cycles:b simultaneously.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_bpf_counters.sh | 75 ++++++++++++++-------
 1 file changed, 52 insertions(+), 23 deletions(-)

diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
index 2d9209874774..61f8149d854e 100755
--- a/tools/perf/tests/shell/stat_bpf_counters.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters.sh
@@ -4,21 +4,59 @@
 
 set -e
 
+workload="perf bench sched messaging -g 1 -l 100 -t"
+
 # check whether $2 is within +/- 20% of $1
 compare_number()
 {
-       first_num=$1
-       second_num=$2
-
-       # upper bound is first_num * 120%
-       upper=$(expr $first_num + $first_num / 5 )
-       # lower bound is first_num * 80%
-       lower=$(expr $first_num - $first_num / 5 )
-
-       if [ $second_num -gt $upper ] || [ $second_num -lt $lower ]; then
-               echo "The difference between $first_num and $second_num are greater than 20%."
-               exit 1
-       fi
+	first_num=$1
+	second_num=$2
+
+	# upper bound is first_num * 120%
+	upper=$(expr $first_num + $first_num / 5 )
+	# lower bound is first_num * 80%
+	lower=$(expr $first_num - $first_num / 5 )
+
+	if [ $second_num -gt $upper ] || [ $second_num -lt $lower ]; then
+		echo "The difference between $first_num and $second_num are greater than 20%."
+		exit 1
+	fi
+}
+
+check_counts()
+{
+	base_cycles=$1
+	bpf_cycles=$2
+
+	if [ "$base_cycles" = "<not" ]; then
+		echo "Skipping: cycles event not counted"
+		exit 2
+	fi
+	if [ "$bpf_cycles" = "<not" ]; then
+		echo "Failed: cycles not counted with --bpf-counters"
+		exit 1
+	fi
+}
+
+test_bpf_counters()
+{
+	printf "Testing --bpf-counters "
+	base_cycles=$(perf stat --no-big-num -e cycles -- $workload 2>&1 | awk '/cycles/ {print $1}')
+	bpf_cycles=$(perf stat --no-big-num --bpf-counters -e cycles -- $workload  2>&1 | awk '/cycles/ {print $1}')
+	check_counts $base_cycles $bpf_cycles
+	compare_number $base_cycles $bpf_cycles
+	echo "[Success]"
+}
+
+test_bpf_modifier()
+{
+	printf "Testing bpf event modifier "
+	stat_output=$(perf stat --no-big-num -e cycles/name=base_cycles/,cycles/name=bpf_cycles/b -- $workload 2>&1)
+	base_cycles=$(echo "$stat_output"| awk '/base_cycles/ {print $1}')
+	bpf_cycles=$(echo "$stat_output"| awk '/bpf_cycles/ {print $1}')
+	check_counts $base_cycles $bpf_cycles
+	compare_number $base_cycles $bpf_cycles
+	echo "[Success]"
 }
 
 # skip if --bpf-counters is not supported
@@ -30,16 +68,7 @@ if ! perf stat -e cycles --bpf-counters true > /dev/null 2>&1; then
 	exit 2
 fi
 
-base_cycles=$(perf stat --no-big-num -e cycles -- perf bench sched messaging -g 1 -l 100 -t 2>&1 | awk '/cycles/ {print $1}')
-if [ "$base_cycles" = "<not" ]; then
-	echo "Skipping: cycles event not counted"
-	exit 2
-fi
-bpf_cycles=$(perf stat --no-big-num --bpf-counters -e cycles -- perf bench sched messaging -g 1 -l 100 -t 2>&1 | awk '/cycles/ {print $1}')
-if [ "$bpf_cycles" = "<not" ]; then
-	echo "Failed: cycles not counted with --bpf-counters"
-	exit 1
-fi
+test_bpf_counters
+test_bpf_modifier
 
-compare_number $base_cycles $bpf_cycles
 exit 0
-- 
2.44.0.683.g7961c838ac-goog

