Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C457725E821
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2025 23:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740610875; cv=none; b=XAWWRwOr+41jUkAgso9UTzugh1N4O9/QGXWysAby89RQ+4AAo9wdkXBIz58cd6ev54+zl5rteCPYS2Y/bZ4b6cWIdh0KWnlqasDEphE2sMQj3JcyqNYP7v+MnGNTsWVZPFmmbhwztbLu12AYW1gpAcaezakUwsc+1CUI/Si4ho8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740610875; c=relaxed/simple;
	bh=f5oTp5SuUA9h/3I9N7juWjdnIYMZaPJU4Yhcj3JS9fo=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=RFum+lxUdLDNga8jpsL3Ogse84FqVEIPTo+72n5TzhtgEIoDRAME6zMmKnlHuURPo2qKdID1eSIabhS9wQ9aQ45olAwxw5qnNp7HQdP5zhsd4t3lq/4+v84ZLaStCt9GqEFYKvwOHBIyIrT8yh8GKvokqhX1y7sf8IW+jM5yBGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0EoOlfYR; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0EoOlfYR"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6f2a2ab50f6so5303387b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2025 15:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740610873; x=1741215673; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pu7sgl3+ZGn6x4LgYjWxEyBJxfFiut2VzzKduKXiRig=;
        b=0EoOlfYR13/et9JriALQWl9jHrEvGG+Z8mMe03V7QOIIjuCpuWDMmEtA1gA5QaTMZ7
         KxkJqC4K22vtVI3sylsxkrc2YxxDp87yPtlq+L00+BcQuGO3DnNDEY9l+E3LUwJ5CaD1
         JgoQ1I1JUarK9z6Vh775EYdE18GhB+35g327FA2lu7b/eVZxh6sOKiUgpfycy5e5ETKX
         oyOmJ1q2IfJ20UTeHyZAj9DCbpaQy/p/U2JxPQfnbVhvBH9/fQcRibhuKc/hSpKMSyil
         pdD12+AilvSblzyeOFu/zwP/9AaZOYyMBgyUg6N/iV5gPeLlnv1VeFaHjbr7U439Q5qB
         +MUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740610873; x=1741215673;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pu7sgl3+ZGn6x4LgYjWxEyBJxfFiut2VzzKduKXiRig=;
        b=pWs/SGWv6v/lO6B30Ttd2pBwWcorAHa43vmuIwFlIpkz7zLdcG67F9Fi3A6XeB1aWf
         Y5+vzNalOF1TYm1KD7IDFDkLP5eu2kEGoyA7fhGpPQv+XsypsU1kDvbEgZAcJFx4jfRC
         zY8Ds31E4eHrITEX4zJRbHvJYq1Tr3PzpMj7SVvZgQjIeSfZrk85LwEqmKHj6vf8XGhK
         n+vdMflJssDt/n3nJ0wbim1UDl+2u6T2LfloX7AvhPeeiY6+G/sUXPN8Px4N1cCVqZsX
         H70GSFGhoRNMH+AuwUJM0XbC7SgxS3CjUQTDL7hpfSH8xKkamTgEmSVzawONHkyWpHXI
         BM6A==
X-Forwarded-Encrypted: i=1; AJvYcCXe+1s1bZB5kIZb/mGNyQsOHphqo4pdQmAe1N0El206sFFwEzdOr2+n+v03N14mH5z/9mrpdmzR+U+hkbld3/9C@vger.kernel.org
X-Gm-Message-State: AOJu0YwWeQPtRXP1bYKZnYYOBYp4sc1Hu2v4YqoI4gsA3QowMGzOguO9
	LV3cKvoZMU6s3v5jft4NXvKKC1911UCBC6WHXKF8ntB5vTDcmohKiqv6wsnq+9MuKVv/ZtM9x/P
	9Aqj8bQ==
X-Google-Smtp-Source: AGHT+IGv/0M1hTuvLFKK/FXKEHNI8rjDJXfn4bhSsJ4gwLOvaZkwvEpf7LqbCKAYvnH4Li2SpWcUPsfMXWij
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ba33:e56c:ea26:80e7])
 (user=irogers job=sendgmr) by 2002:a05:690c:3809:b0:6fb:4f1a:42e0 with SMTP
 id 00721157ae682-6fbcc3785famr24379917b3.4.1740610872777; Wed, 26 Feb 2025
 15:01:12 -0800 (PST)
Date: Wed, 26 Feb 2025 15:01:09 -0800
Message-Id: <20250226230109.314580-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v1] perf tests: Fix data symbol test with LTO builds
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

With LTO builds, although regular builds could also see this as
all the code is in one file, the datasym workload can realize the
buf1.reserved data is never accessed. The compiler moves the
variable to bss and only keeps the data1 and data2 parts as
separate variables. This causes the symbol check to fail in the
test. Make the variable volatile to disable the more aggressive
optimization. Rename the variable to make which buf1 in perf is
being referred to.

Before:
```
$ perf test -vv "data symbol"
126: Test data symbol:
--- start ---
test child forked, pid 299808
perf does not have symbol 'buf1'
perf is missing symbols - skipping test
---- end(-2) ----
126: Test data symbol                                                : Skip
$ nm perf|grep buf1
0000000000a5fa40 b buf1.0
0000000000a5fa48 b buf1.1
```

After:
```
$ nm perf|grep buf1
0000000000a53a00 d buf1
$ perf test -vv "data symbol"126: Test data symbol:
--- start ---
test child forked, pid 302166
 a53a00-a53a39 l buf1
perf does have symbol 'buf1'
Recording workload...
Waiting for "perf record has started" message
OK
Cleaning up files...
---- end(0) ----
126: Test data symbol                                                : Ok
```

Fixes: 3dfc01fe9d12 ("perf test: Add 'datasym' test workload")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/test_data_symbol.sh | 17 +++++++++--------
 tools/perf/tests/workloads/datasym.c       | 11 ++++++-----
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/tests/shell/test_data_symbol.sh
index c86da0235059..7da606db97cb 100755
--- a/tools/perf/tests/shell/test_data_symbol.sh
+++ b/tools/perf/tests/shell/test_data_symbol.sh
@@ -18,7 +18,7 @@ skip_if_no_mem_event() {
 
 skip_if_no_mem_event || exit 2
 
-skip_test_missing_symbol buf1
+skip_test_missing_symbol workload_datasym_buf1
 
 TEST_PROGRAM="perf test -w datasym"
 PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
@@ -26,18 +26,19 @@ ERR_FILE=$(mktemp /tmp/__perf_test.stderr.XXXXX)
 
 check_result() {
 	# The memory report format is as below:
-	#    99.92%  ...  [.] buf1+0x38
+	#    99.92%  ...  [.] workload_datasym_buf1+0x38
 	result=$(perf mem report -i ${PERF_DATA} -s symbol_daddr -q 2>&1 |
-		 awk '/buf1/ { print $4 }')
+		 awk '/workload_datasym_buf1/ { print $4 }')
 
-	# Testing is failed if has no any sample for "buf1"
+	# Testing is failed if has no any sample for "workload_datasym_buf1"
 	[ -z "$result" ] && return 1
 
 	while IFS= read -r line; do
-		# The "data1" and "data2" fields in structure "buf1" have
-		# offset "0x0" and "0x38", returns failure if detect any
-		# other offset value.
-		if [ "$line" != "buf1+0x0" ] && [ "$line" != "buf1+0x38" ]; then
+		# The "data1" and "data2" fields in structure
+		# "workload_datasym_buf1" have offset "0x0" and "0x38", returns
+		# failure if detect any other offset value.
+		if [ "$line" != "workload_datasym_buf1+0x0" ] && \
+		   [ "$line" != "workload_datasym_buf1+0x38" ]; then
 			return 1
 		fi
 	done <<< "$result"
diff --git a/tools/perf/tests/workloads/datasym.c b/tools/perf/tests/workloads/datasym.c
index 8e08fc75a973..5074b3439835 100644
--- a/tools/perf/tests/workloads/datasym.c
+++ b/tools/perf/tests/workloads/datasym.c
@@ -7,7 +7,8 @@ typedef struct _buf {
 	char data2;
 } buf __attribute__((aligned(64)));
 
-static buf buf1 = {
+/* volatile to try to avoid the compiler seeing reserved as unused. */
+static volatile buf workload_datasym_buf1 = {
 	/* to have this in the data section */
 	.reserved[0] = 1,
 };
@@ -15,8 +16,8 @@ static buf buf1 = {
 static int datasym(int argc __maybe_unused, const char **argv __maybe_unused)
 {
 	for (;;) {
-		buf1.data1++;
-		if (buf1.data1 == 123) {
+		workload_datasym_buf1.data1++;
+		if (workload_datasym_buf1.data1 == 123) {
 			/*
 			 * Add some 'noise' in the loop to work around errata
 			 * 1694299 on Arm N1.
@@ -30,9 +31,9 @@ static int datasym(int argc __maybe_unused, const char **argv __maybe_unused)
 			 * longer a continuous repeating pattern that interacts
 			 * badly with the bias.
 			 */
-			buf1.data1++;
+			workload_datasym_buf1.data1++;
 		}
-		buf1.data2 += buf1.data1;
+		workload_datasym_buf1.data2 += workload_datasym_buf1.data1;
 	}
 	return 0;
 }
-- 
2.48.1.711.g2feabab25a-goog

