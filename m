Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5692F6919
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 08:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763799600; cv=none; b=lbuIA6M1A7Gm9QUDgdQaXO9BI9KL8FD8xRrVGtAe8b6/ExhrI/2HGZud8kwrimh6wbF0pkao8TFGvJZNT8QY9Zdv6ApGRsdbV5vlT6Zv43bhphAVcaPfdCzJSPuoyFH8JD2uRf7Ml7fPLJY811NgYF5lwNGSRFSl5v7Qt5i2tZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763799600; c=relaxed/simple;
	bh=JBjw+PRUV6q2F47suf3ArJnOY2FDBb1CgT20m/seTTQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=A6YiQfTdS0x5ZjZ0oygg6Xq/2aGNaVXKiLIDvyrWf+VuOR1nmSJb79bnVlqEE4alMAnUNEooJbOUyoVmBLK7+46RjuHsVm8J+WmVOCetXIVlikd7Q7dKMmBevvfHViXGAdi3y1H+obHzJiAgxu55zUCClnM7wHtAHY33KQKxIZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1W0Lgzf4; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1W0Lgzf4"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b609c0f6522so5289602a12.3
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 00:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763799598; x=1764404398; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M0dWtJ5ucKyEr5mZsYIfxNtzj/9j9IGrRpIHX7GVPKo=;
        b=1W0Lgzf4b8Il8b3nzf6P/AZNEquAGbKPwJN+eK3uLFEtZc9qKqabCjvB+9K0In1Zy1
         Figva2y24bjUZCJ1B2aRz+XFytmm0jWQankZs53mP/3/1nClewtGKhB51qjbsBtHBfRZ
         h3BZI1+DF503v82ptveRq54L5ct0+3UYGk+tQ1DyK+0B0HedETvZsXmsoPsjgDf7v0jl
         ye49d9WgK7rsyEqoUgRVtgeVYBKn6G8Qu4Aak2GnfkwOXroTxpAyUT99uU1096NGsKeE
         eKVZfZ+UcjYU1Q1rmyn8dV68oOhqPpiNuW4ZUYUEFe1pNdFi0xXTR/s+iKwLshFab1ww
         fb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763799598; x=1764404398;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M0dWtJ5ucKyEr5mZsYIfxNtzj/9j9IGrRpIHX7GVPKo=;
        b=gYA7cOrdp7NPf9/xbQuXaF9UaofyEjpak2Uld/autyedWCHfvtNMq2KfQn8XreoJqN
         TjYL1Fawxo06i9ajKrfJmYFYWNl1BrWwR4qbZs9mYSq9LKuYJ1jy2vWtRvBwHTfSh78J
         Xc7B+tw5LWhUghwXxIAwCLK+LM34mR4KVVs0wSrII2XT1HqNeVbHl+XxGMLmG6/mXqlo
         jLUR8xs8S4bLJ3bmz3WbxXAtJiggkJM+lyh8ENO6bIWxgUSIuizscT0JrxQLMGM6spXs
         aw0unN326KNCd4mH2TPZ3sLqdZnnINB8RS+t7mkXiAcIIUTy1YnAYFlUg9sOj4rqH/m/
         j2iw==
X-Forwarded-Encrypted: i=1; AJvYcCVccjyChbEnafv8nXWIBn4PPjzzEXRfqBsacKn5yAvxIULDQ6EYk/tQY+0nPabLParOwqPMKGJIOrBIMMg2GvJL@vger.kernel.org
X-Gm-Message-State: AOJu0YxbSFlQfFXQTNXDq9M+Z2YbwfAfsI2W60c6dZSuft8cIFFYsHZH
	9aODCJLzz5yd1dc3xT8S75ucB2po+pcmxwm6tAIve7xgIjfHVuXbg1/D95Kf1KubiyTH7Ng3KRP
	kesKgg752aA==
X-Google-Smtp-Source: AGHT+IFAGXYlBPql1dbEWe9YUydiaxbjL0B4NnfzOBkxsqqY08zoLFLB39IYs1W7Jzt5hllx6EUrxhkmTM6s
X-Received: from dyz20.prod.google.com ([2002:a05:693c:4094:b0:2a4:6419:6f8f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d10d:b0:2a4:65b5:9868
 with SMTP id 5a478bee46e88-2a719c2d0e7mr1509598eec.38.1763799598481; Sat, 22
 Nov 2025 00:19:58 -0800 (PST)
Date: Sat, 22 Nov 2025 00:19:24 -0800
In-Reply-To: <20251122081929.7588-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251122081929.7588-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251122081929.7588-13-irogers@google.com>
Subject: [PATCH v1 12/17] perf tests top: Add basic perf top coverage test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Collin Funk <collin.funk1@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Leo Yan <leo.yan@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The test starts a backgroup thloop workload and monitors it using
cpu-clock ensuring test_loop appears in the output.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/top.sh | 74 +++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100755 tools/perf/tests/shell/top.sh

diff --git a/tools/perf/tests/shell/top.sh b/tools/perf/tests/shell/top.sh
new file mode 100755
index 000000000000..768ebcf7a89c
--- /dev/null
+++ b/tools/perf/tests/shell/top.sh
@@ -0,0 +1,74 @@
+#!/bin/bash
+# perf top tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+err=0
+log_file=$(mktemp /tmp/perf.top.log.XXXXX)
+
+cleanup() {
+	rm -f "${log_file}"
+	trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+	echo "Unexpected signal in ${FUNCNAME[1]}"
+	cleanup
+	exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+test_basic_perf_top() {
+	echo "Basic perf top test"
+
+	# Start a workload that spins to generate samples
+	# thloop runs for the specified number of seconds
+	perf test -w thloop 20 &
+	PID=$!
+
+	# Allow it to start
+	sleep 0.1
+
+	# Run perf top for 5 seconds, monitoring that PID
+	# Use --stdio to avoid TUI and redirect output
+	# Use -d 1 to avoid flooding output
+	# Use -e cpu-clock to ensure we get samples
+	# Use sleep to keep stdin open but silent, preventing EOF loop or interactive spam
+	if ! sleep 10 | timeout 5s perf top --stdio -d 1 -e cpu-clock -p $PID > "${log_file}" 2>&1; then
+		retval=$?
+		if [ $retval -ne 124 ] && [ $retval -ne 0 ]; then
+			echo "Basic perf top test [Failed: perf top failed to start or run (ret=$retval)]"
+			head -n 50 "${log_file}"
+			kill $PID
+			wait $PID 2>/dev/null || true
+			err=1
+			return
+		fi
+	fi
+
+	kill $PID
+	wait $PID 2>/dev/null || true
+
+	# Check for some sample data (percentage)
+	if ! grep -E -q "[0-9]+\.[0-9]+%" "${log_file}"; then
+		echo "Basic perf top test [Failed: no sample percentage found]"
+		head -n 50 "${log_file}"
+		err=1
+		return
+	fi
+
+	# Check for the symbol
+	if ! grep -q "test_loop" "${log_file}"; then
+		echo "Basic perf top test [Failed: test_loop symbol not found]"
+		head -n 50 "${log_file}"
+		err=1
+		return
+	fi
+
+	echo "Basic perf top test [Success]"
+}
+
+test_basic_perf_top
+cleanup
+exit $err
-- 
2.52.0.rc2.455.g230fcf2819-goog

