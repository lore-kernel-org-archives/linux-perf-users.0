Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C4614431B
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Aug 2024 06:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723877117; cv=none; b=h1MC/ZvU+e0hj5AAC4NRQ7q5sSc/7EFTaQL6lr+aTT/MuPjdjpYg2b9WheeisOWornoPC6l9q5rcHShF0+8iI7JvKU910rCkc6Eahlthv/UojZG+NRrVn7DjD+mwV0FpuZgkoT7SMHI2aalJ0lEyUcxXxpUoP4bSDtwcGCT/J+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723877117; c=relaxed/simple;
	bh=svsXcTMaRqZcv7GQdX5SDwbX/PNPLJVnzNXlCv1HOwg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=OIaiYAd/D5CquVhnn4IwAQQPuMWkxZSne6S+1ZAg7JCiGjr9a+TFEmVF0tedjrWGsLd9H6vZyBT7KmbBNqX7AJBMK99IuNaxdnLsPP5ZHNozyPj5u6nziKzsqQ0oeevg5sva7988yh8GjO3g280gyWsDCfURY1A5FKscXICZtNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o7F4B4a7; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o7F4B4a7"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b351a76beeso18121957b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Aug 2024 23:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723877115; x=1724481915; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uiIb0LHFpPGuH8DbvZrhFnBLb6AIQ7thHhf5YFck8Ko=;
        b=o7F4B4a72LTF0ZtAZDSYFB+3PzHhy77VR9b9FUa0cGmPfKIU1iIk0Q6Pjt3IVk0oo+
         8wVCO6ZtlzbUh7gO93+SA3XsBMTaPBzliuHi6NJJFh0GiUnRfRaXy249BiFYo5Jkw6UO
         9h/a6/5E3PBS6hqH2f/x93+yoPKqi6FfvgQGVoiVVBEF+oZ4cjygUyMNiHVHwazWWtDZ
         TO4uzD4Zov4gKgJTYqrBpSf0c0uBgO4zILHyTtbWMOogZ/k9+oj2Wzg9bd/awnTWoYyv
         baKuHGAjDKyYPlWJEHYWX85UB+BFjkVMpUqN1OX5qNxse89Iihrd+Nr3izoxfdWITSAy
         hSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723877115; x=1724481915;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uiIb0LHFpPGuH8DbvZrhFnBLb6AIQ7thHhf5YFck8Ko=;
        b=i9BtbA8vsAv1mYFkS/B88hosinduUg0dKMn7ndNlkn+FKG/kCjxkmZeFXfyDW0OYfn
         IfZRwTZcqSegRPhvk/GEClGtW0ylf8DvwRoMhqIJqLPQWO7Rsndxqz7MYxKNp3udR2f8
         l8aKC+69d9jT2f7h/kjoSP7vd8Gb1/dCuFkiALGAWJ6am+nVo7TywcQ2QofdLl7/uabb
         jcp2DMd82meRQp02QAqRLNjNmn9+1kAG+SGXwT/006iF6T6I5wY3LLQ5wCPrVDxPzJkh
         5IC3sw63xwD8Xx6mINiFdbtT2h2A2jv8j73mhYuxub08XSw7nq68qvdba1MH7/c+Eupc
         aAuw==
X-Forwarded-Encrypted: i=1; AJvYcCXkuEoEl0oYAJY4OxGOrB3GHzLJBOBcraZfjOBXwV/J+C85eG6phcfjQFcrKBLkr5Wo4WIHCgN3Fr0erEPoYq5Y86OYoNTNxiZadIBViXP+Fw==
X-Gm-Message-State: AOJu0YwqGbfavOGg8ozxydyr0lQrRx2p6VUeBt24oAuVyBdUrMaWG3it
	ePh1gMdqdX0vHbNghkpt/pBVGvol5VceGOvPGyd4OFQ0cuoepLuT2K4cRbK+kwoOoZsnSByZflF
	jWTnWHg==
X-Google-Smtp-Source: AGHT+IHpIQH3Z4+neJvbwuE+BMqXxfg4n05M1ztGFk7NZrFg4BazntZ8QBZQfcIgDAHYHp5Rx83a8q7z27Ab
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:78c9:5e58:734f:c59f])
 (user=irogers job=sendgmr) by 2002:a05:690c:2f0b:b0:6ad:9825:6a2f with SMTP
 id 00721157ae682-6b1b6cb7a10mr534947b3.1.1723877115221; Fri, 16 Aug 2024
 23:45:15 -0700 (PDT)
Date: Fri, 16 Aug 2024 23:44:35 -0700
In-Reply-To: <20240817064442.2152089-1-irogers@google.com>
Message-Id: <20240817064442.2152089-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240817064442.2152089-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Subject: [PATCH v1 06/13] perf test: Expand pipe/inject test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Casey Chen <cachen@purestorage.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Yunseong Kim <yskelg@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Anne Macedo <retpolanne@posteo.net>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Test recording of call-graphs and injecting --build-all. Add/expand
trap handler.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/pipe_test.sh | 101 ++++++++++++++++++++++------
 1 file changed, 79 insertions(+), 22 deletions(-)

diff --git a/tools/perf/tests/shell/pipe_test.sh b/tools/perf/tests/shell/pipe_test.sh
index a78d35d2cff0..ad10012fdc29 100755
--- a/tools/perf/tests/shell/pipe_test.sh
+++ b/tools/perf/tests/shell/pipe_test.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # perf pipe recording and injection test
 # SPDX-License-Identifier: GPL-2.0
 
@@ -12,30 +12,87 @@ skip_test_missing_symbol ${sym}
 
 data=$(mktemp /tmp/perf.data.XXXXXX)
 prog="perf test -w noploop"
-task="perf"
+err=0
 
-if ! perf record -e task-clock:u -o - ${prog} | perf report -i - --task | grep ${task}; then
-	echo "cannot find the test file in the perf report"
-	exit 1
-fi
+set -e
 
-if ! perf record -e task-clock:u -o - ${prog} | perf inject -b | perf report -i - | grep ${sym}; then
-	echo "cannot find noploop function in pipe #1"
-	exit 1
-fi
+cleanup() {
+  rm -rf "${data}"
+  rm -rf "${data}".old
 
-perf record -e task-clock:u -o - ${prog} | perf inject -b -o ${data}
-if ! perf report -i ${data} | grep ${sym}; then
-	echo "cannot find noploop function in pipe #2"
-	exit 1
-fi
+  trap - EXIT TERM INT
+}
 
-perf record -e task-clock:u -o ${data} ${prog}
-if ! perf inject -b -i ${data} | perf report -i - | grep ${sym}; then
-	echo "cannot find noploop function in pipe #3"
-	exit 1
-fi
+trap_cleanup() {
+  echo "Unexpected signal in ${FUNCNAME[1]}"
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
 
+test_record_report() {
+  echo
+  echo "Record+report pipe test"
+
+  task="perf"
+  if ! perf record -e task-clock:u -o - ${prog} | perf report -i - --task | grep -q ${task}
+  then
+    echo "Record+report pipe test [Failed - cannot find the test file in the perf report #1]"
+    err=1
+    return
+  fi
+
+  if ! perf record -g -e task-clock:u -o - ${prog} | perf report -i - --task | grep -q ${task}
+  then
+    echo "Record+report pipe test [Failed - cannot find the test file in the perf report #2]"
+    err=1
+    return
+  fi
+
+  echo "Record+report pipe test [Success]"
+}
+
+test_inject_bids() {
+  inject_opt=$1
+
+  echo
+  echo "Inject ${inject_opt} build-ids test"
+
+  if ! perf record -e task-clock:u -o - ${prog} | perf inject ${inject_opt}| perf report -i - | grep -q ${sym}
+  then
+    echo "Inject build-ids test [Failed - cannot find noploop function in pipe #1]"
+    err=1
+    return
+  fi
+
+  if ! perf record -g -e task-clock:u -o - ${prog} | perf inject ${inject_opt} | perf report -i - | grep -q ${sym}
+  then
+    echo "Inject ${inject_opt} build-ids test [Failed - cannot find noploop function in pipe #2]"
+    err=1
+    return
+  fi
+
+  perf record -e task-clock:u -o - ${prog} | perf inject ${inject_opt} -o ${data}
+  if ! perf report -i ${data} | grep -q ${sym}; then
+    echo "Inject ${inject_opt} build-ids test [Failed - cannot find noploop function in pipe #3]"
+    err=1
+    return
+  fi
+
+  perf record -e task-clock:u -o ${data} ${prog}
+  if ! perf inject ${inject_opt} -i ${data} | perf report -i - | grep -q ${sym}; then
+    echo "Inject ${inject_opt} build-ids test [Failed - cannot find noploop function in pipe #4]"
+    err=1
+    return
+  fi
+
+  echo "Inject ${inject_opt} build-ids test [Success]"
+}
+
+test_record_report
+test_inject_bids -b
+test_inject_bids --buildid-all
+
+cleanup
+exit $err
 
-rm -f ${data} ${data}.old
-exit 0
-- 
2.46.0.184.g6999bdac58-goog

