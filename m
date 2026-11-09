Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794219455;
	b=s3Z6QQy7b7O9k3BL2nZ4/iURW8gqtisbKji96A24II3kFc3eojx3MeU5KLA0rqeQQw1v
	 bSKzVxUpDxrt5lGFzkjDQfHWb7jGs4YZtzpwn1qmcWQkUW5M5OVVSsQZ7onZ3c2hl8okP
	 qZoeeYVbynBk8TgRpr/OtujbreFpn5QC68pZQ0JX+TqcdlAumDhkXfk363R+eiDonMsk0
	 82xq0KBk9v0h8EMAB67Ul4SAegeMY614e8h1fhZphbXb/ri+L6MepzDii2P2xhTR6nroV
	 hHd5pE+4nryk9x9tvZtnJLt5tvo4T93atbXxI5sjAClcu1qOxNUgJGLGRg5O+yNszDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794219455;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=WIaieGGBZ//QGoNLj878zCBnNschlkTQti7AhZ3wdkI=;
	b=ZmBL9QBEAM6wMhVqlpPF0EYoMazNPSCSk3XpcD+Fi/e14VqmIsv3PEjb/zkTOh4q4yds
	 8mrDw1tU8xAI9Q0gWnbztXDwh/xIdM9TTvocPnidtQ1fW26nyIlPOScIUXGdTl4eUbhRy
	 d8l+zU7cf8fbhUqgsL3p+2NC+IBqG/xxGnquh1bI4MOdfPAEkMG7GzBwqNrjdrUeWoD39
	 F41Mh8JiiR61G//hkN4G4lC/P05KGSpYcSznVq/ViuX5JohUMIYT9RQS90RkILMX+K2Ra
	 5Ihv6grHX8n9worWwrl/x8SiocuKLq2Tr3u8kcpCIoQaBrzVAgEzmfh83JMO28fyLmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KbmTF0pB;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4D4606A326
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 10:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE4D4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KbmTF0pB
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso6659465e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Nov 2026 02:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794219453; x=1794824253; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WIaieGGBZ//QGoNLj878zCBnNschlkTQti7AhZ3wdkI=;
        b=KbmTF0pBknBeDwOEN7r0cHteYDa/vTyhn6x0Nd9IvVWy1J0cE3V8Pre6W8UpWPoTqb
         0TcIGXn5KsjZtiMF5LSq5h33pMTB2oDkym7mAiDju6tBfN9dhgMmX99/G7ut6msUmeJG
         56tWZjKTHjF1kX6z9m4o2jmVjsyvjWXsqFRnIdWAcyuLo8suFTc9tYi0TC+XDl7YHgFK
         WDT4V5NaFpGsSlqww02GtNWVmmVlnBUIPBDsHXhKA8UoRhcbd4n/qQ9H1M7I/JqRwxGo
         BxQm3ekGb9zAd4TetWohPwXVyVok4mXgL/u7UnP+3nq7V09fcWDNDY7or7FJbxfBQjtJ
         yzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794219453; x=1794824253;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WIaieGGBZ//QGoNLj878zCBnNschlkTQti7AhZ3wdkI=;
        b=oKPwCvRqoSuV3rqgcio4de+QE1WoBEr8VLkWbQkk6qLF2MiG8JIssL5C0KY+klW2eB
         YBaFSwFmvEAww9ZD38FNTNsjAphHlnOheQHFBj7M7qrCljzwaavfThQq7ebcGOQYFZEo
         BBE8+3oYARMDbBa5ye8gbeBlARyNaLTevp7xjJZnlRXeojiv+0zQ1PpxgqHU8y/Bs7aW
         1Q7u1lXpI6tuI4rsHtorN8c2Oe2nPW9n9YhpyGLdskT+I8XVLX4jJL5wwfZMmr7mqw4f
         k2tAtWUSJ+98zEmfb6WcC/NHGRQy6hb/hY+bIPbXMoy5tRZa3q8uvAp9uI1yLnzsSx3m
         gasg==
X-Forwarded-Encrypted: i=1; AL+hErEmKY+RHTh28GX3JiJszullva9oJjNebDbnBSfr22WukCt2W/cVN6i6byoYQeAFt/PwcdJWjMO9ulQaS8WgZsYm@vger.kernel.org
X-Gm-Message-State: APuU4Z8SCYKFof6fciKrd4JtyZRgB+HcFBNkJxTewPTXHV6eTNIGlWS1
	YYYPobrOfBVOwx35o1enLWV0FY/yJVoRX6TUBb9BYZCs8Fim+N23WuamP3atKzr1TKk=
X-Gm-Gg: AYBFou1yWLpAnnqO86GmT8Scl/CVZzIhpMY7XgobuRr9xmn43Z6md19Ky/N8KPo+iAU
	UZ98Ie22AUy+3caMj8UFq5ZN3XJc56SMff/IJhJimHugx2GEx0hVNiZgFpR8vQbYRbUlQtaMo8m
	4CzLJcoa/sgl+9kbU3009uUvP932yWmu2dmexSHJNlmTg6fn7Fh3seSIDKkK1nU8dqAWe1gU212
	PKwnYOEh9UwxzUIEaVNc/cUgDBgxpO69Juyd4m5QGpriNKh2ku9uaTTlIGG6s0l3vhAsoARqGW8
	cxiDHn/uydZtbVwn6ZQ/jb0Hjv0iYNDwNho3SO59dBgvM/Gq8zEnBqqODopIHXQUjfBAn2IdvN/
	D20teNS7UhrfKASlXsBZKBd/pgI0gL6afgNIdDEQbjmypYVH7UyVD7JFWSEo7140luGWnUeRGzf
	f05dUetrOSwY/yOMg6q46f0kW3+GoLxQ1I4COX8OwcvbYwCnzdGaLwXIzpGlusRPgp8BQGuQLh6
	3GqxOdLE8CeT8vdw1TUR5oBsrU/v0NkcdP5SQT95v16Ak7QKbpfYoMbOU5qoKxrBKtaA7+/qsjM
	uRG1MdpmPPhAN+//xSAylcCnXlXfRsiIlqwbDcscGP2TPnhyq0MCGQ==
X-Received: by 2002:a05:600c:8714:b0:4a2:1364:252a with SMTP id 5b1f17b1804b1-4b94d763291mr62542225e9.3.1794219453273;
        Mon, 09 Nov 2026 02:17:33 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b90ee1de2esm121575795e9.5.2026.11.09.02.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:17:32 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 09 Nov 2026 10:17:04 +0000
Subject: [PATCH v3 4/4] perf test: Don't starve per-process tests with
 system-wide events
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-james-perf-test-fixes-v3-4-e8d0a65e618a@linaro.org>
References: <20261109-james-perf-test-fixes-v3-0-e8d0a65e618a@linaro.org>
In-Reply-To: <20261109-james-perf-test-fixes-v3-0-e8d0a65e618a@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Jakub Brnak <jbrnak@redhat.com>, 
 Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

Some tests intermittently fail when run in parallel, for example "Check
branch stack sampling" fails with no branches recorded at all.

The default event is cycles:P which there may only be 1 or 2 HW counters
for on Intel because it's precise. System wide or per-core precise
events hog the HW counter leaving other per-process tests with no
samples. Rather than make all the tests that use default record commands
run serially, just make the system wide ones use a software event which
has the greatest possible compatibility. They don't need precise
sampling or HW counters anyway. The per-process tests can be left alone
as their events/processes never run concurrently on any one core.

The LBR filter is another resource shared by all events on a CPU, and
the system-wide LBR test uses different filters to the per-process
branch stack test, so mark the LBR test as exclusive.

This fixes the "Check branch stack sampling" test and other flakes when
a system-wide record from another test runs at the same time, for
example:

  $ sudo perf record -a -o /dev/null -- sleep 30 &
  $ sudo perf test -vvv "Check branch stack sampling"
  ...
  Testing user branch stack sampling
  ERROR: Branches missing ^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL/.*$
  ...
  Testing user branch stack sampling [Failed]
  ...
  Testing branch stack filtering permutation (call,CALL|SYSCALL)
  Testing branch stack filtering [Failed empty script output]
  ...
  ---- end(-1) ----
  138: Check branch stack sampling : FAILED!

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/record.sh          | 6 +++---
 tools/perf/tests/shell/record_lbr.sh      | 2 +-
 tools/perf/tests/shell/record_sideband.sh | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 01dc3e22fa73..e4789e2bcf43 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -388,7 +388,7 @@ test_system_wide() {
   echo "Basic --system-wide mode test"
   local ret=0
   perf_record_with_retry "${perfdata}" "check_system_wide" "perf test -w thloop" \
-    -aB --synth=no || ret=$?
+    -aB --synth=no -e cpu-clock || ret=$?
   if [ $ret -eq 2 ]; then
     echo "System-wide record [Skipped not supported]"
     return
@@ -471,7 +471,7 @@ test_cgroup() {
   echo "Cgroup sampling test"
   local ret=0
   perf_record_with_retry "${perfdata}" "check_cgroup" "perf test -w thloop" \
-    -aB --synth=cgroup --all-cgroups || ret=$?
+    -aB --synth=cgroup --all-cgroups -e cpu-clock || ret=$?
   if [ $ret -eq 2 ]; then
     echo "Cgroup sampling [Skipped not supported]"
     return
@@ -491,7 +491,7 @@ test_uid() {
   echo "Uid sampling test"
   local ret=0
   perf_record_with_retry "${perfdata}" "check_uid" "perf test -w thloop" \
-    -aB --synth=no --uid "$(id -u)" || ret=$?
+    -aB --synth=no --uid "$(id -u)" -e cpu-clock || ret=$?
   if [ $ret -eq 2 ]; then
     local logfile="${PERF_RECORD_LOGS[${#PERF_RECORD_LOGS[@]}-1]}"
     if grep -q -E "libbpf.*EPERM|Access to performance monitoring" "$logfile" || \
diff --git a/tools/perf/tests/shell/record_lbr.sh b/tools/perf/tests/shell/record_lbr.sh
index 8d51afeb437b..6b6af59db871 100755
--- a/tools/perf/tests/shell/record_lbr.sh
+++ b/tools/perf/tests/shell/record_lbr.sh
@@ -1,6 +1,6 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
-# perf record LBR tests
+# perf record LBR tests (exclusive)
 
 set -e
 
diff --git a/tools/perf/tests/shell/record_sideband.sh b/tools/perf/tests/shell/record_sideband.sh
index 2182551873be..f16889e3fa9a 100755
--- a/tools/perf/tests/shell/record_sideband.sh
+++ b/tools/perf/tests/shell/record_sideband.sh
@@ -22,7 +22,7 @@ trap trap_cleanup EXIT TERM INT
 
 can_cpu_wide()
 {
-    if ! perf record -o ${perfdata} -BN --no-bpf-event -C $1 true > /dev/null 2>&1
+    if ! perf record -o ${perfdata} -BN --no-bpf-event -e cpu-clock -C $1 true > /dev/null 2>&1
     then
         echo "record sideband test [Skipped cannot record cpu$1]"
         err=2
@@ -39,7 +39,7 @@ test_system_wide_tracking()
     can_cpu_wide 1 || return 0
 
     # Record on CPU 0 a task running on CPU 1
-    perf record -BN --no-bpf-event -o ${perfdata} -C 0 -- taskset --cpu-list 1 true
+    perf record -BN --no-bpf-event -e cpu-clock -o ${perfdata} -C 0 -- taskset --cpu-list 1 true
 
     # Should get MMAP events from CPU 1
     mmap_cnt=`perf script -i ${perfdata} --show-mmap-events -C 1 2>/dev/null | grep MMAP | wc -l`

-- 
2.43.0

