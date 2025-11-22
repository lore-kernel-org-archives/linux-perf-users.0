Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043C62FD7D8
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 08:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763799611; cv=none; b=UnfmOZ3X7WhL4U6hTsdsNl59dEHWtGuYtvYa3DuRgl7DlmP3LaXohcBR9vOLfQ/DJunTrXG1C4LxayEQtQrBv4pmev2NnS/R5BixiFMr+7+hzAe5ThLyS9K1yb7EHU3U72VxeRgip/oLju48FuaCfUDFBNVbMtutdhqY4XV5ydw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763799611; c=relaxed/simple;
	bh=77y7tXutito3nnzAoc+ycFKKxLdAvlLV3iqcipeD6VM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=sU0vlQ9gx5loufrkhTbs78xKIh6JOAi+9zBJrPDsHDXrUR9SRfT/yg9bQLKtRc9gvT7jUBTI8ApRbqx6c1srCZfR8WC7OfnUCsg23hjxh8n5D6MJy4HttgQ1qnE3CJLs1F+w8trrPJs5OAbyzQjRpNFoZwgTgEXrQBmLdPKsgXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FO7VsXYc; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FO7VsXYc"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b9d73d57328so2953023a12.1
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 00:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763799608; x=1764404408; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I1FSqCMeHsL++g3NwVXFiLoHBKehFUPc0C8bNPag8O0=;
        b=FO7VsXYcDBug4auNy2umqJ9iF+h4/tfKAIz/VZ8X1/52OFBovZ523kvPWW1UNXtG92
         Q5/oj2dzi6yHTIf+ZZ9Sf96foP2vPKVw3XEF7JgCZUzCQF8NY42SHR3ERtWiV2Lz7834
         x6B5g3Z5/f+MhDlXSvCxEg2FEHjdbo6CCoD3DvEpOgqGMOuivHfLC4IGjs0eIsl30rgS
         OcoZemHX97tGQSPhMpVvsm+Vwkh74sad8qwG6aFdFVXKfyeVkqRh68u/NVGJ5YfuZmy3
         I396xoEEdgAFpZFOseiQW4bva4z5gK8VjcLsiy1OS607FJW3uT4IYi4RdHzUMpMgZcNO
         8+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763799608; x=1764404408;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I1FSqCMeHsL++g3NwVXFiLoHBKehFUPc0C8bNPag8O0=;
        b=bdovaOQ5HOOX+RFHk/F57jWziNIQD2wnmraH4/RppqN8r22+tD5x1RaQrX2cxryMmg
         LPomjpM1Mjb2joE3E98Tb25LZw0JxNmQi6X6qyxVlO6AqH3l20eFmq3wITzWvOmijIKf
         8SqZ5H3lSVhIEnC2F5MyBijzu15pMfx4cJaV82ZP/Maidb85rt/klhUUEE3nvRLC3JXN
         peM7tkNYHmcjEt3eXELSFkTnYy0G7ZItE3q9hll9+4ONxuo9kHGZ+CSGtzoHjUi4HMXF
         JUr+duSsMbq8L39G1XS8c4SSnsfrIFAl7aIjliu6CCX/WJlnMEICGy3zZJC4UrJVFlbA
         IHSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBWEdcmMXYSmdMBCOKGtniVMoPzpIxzh/pmFaBSmpdomcsGHvXy274m0IzwJsuVd0YcwnXLhwqtOZtxfCRUb1l@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/c7/cApG5nBlp/ilA0yQd5wuBMMseZeaWFX7BOY/lBUnxZECA
	Sqqdhp6uNP3XFp/H6U0eE1v/6E1RX7fjOQGgq1+h4ejQIN28LL2FqlkbgTb6agvwXP8A+ieyVGp
	Y7xW5nTMPGA==
X-Google-Smtp-Source: AGHT+IGflzDr78v/sru9qBkWDUDP31dQt3lOiXUHw56VDdhoXsu553xPZE3o+BNCwrkxSJyKbDjQLLqsDtJ2
X-Received: from dycog5.prod.google.com ([2002:a05:7301:9a85:b0:2a4:791c:9e95])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:7d0a:b0:2a4:3592:c5f7
 with SMTP id 5a478bee46e88-2a71907139amr1640322eec.8.1763799608188; Sat, 22
 Nov 2025 00:20:08 -0800 (PST)
Date: Sat, 22 Nov 2025 00:19:29 -0800
In-Reply-To: <20251122081929.7588-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251122081929.7588-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251122081929.7588-18-irogers@google.com>
Subject: [PATCH v1 17/17] perf test kvm: Add some basic perf kvm test coverage
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

Setup qemu with KVM then run kvm stat and some host
recording/reporting/build-id tests.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/kvm.sh | 154 ++++++++++++++++++++++++++++++++++
 1 file changed, 154 insertions(+)
 create mode 100755 tools/perf/tests/shell/kvm.sh

diff --git a/tools/perf/tests/shell/kvm.sh b/tools/perf/tests/shell/kvm.sh
new file mode 100755
index 000000000000..2fafde1a29cc
--- /dev/null
+++ b/tools/perf/tests/shell/kvm.sh
@@ -0,0 +1,154 @@
+#!/bin/bash
+# perf kvm tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+err=0
+perfdata=$(mktemp /tmp/__perf_kvm_test.perf.data.XXXXX)
+qemu_pid_file=$(mktemp /tmp/__perf_kvm_test.qemu.pid.XXXXX)
+
+cleanup() {
+	rm -f "${perfdata}"
+	if [ -f "${qemu_pid_file}" ]; then
+		if [ -s "${qemu_pid_file}" ]; then
+			qemu_pid=$(cat "${qemu_pid_file}")
+			if [ -n "${qemu_pid}" ]; then
+				kill "${qemu_pid}" 2>/dev/null || true
+			fi
+		fi
+		rm -f "${qemu_pid_file}"
+	fi
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
+skip() {
+	echo "Skip: $1"
+	cleanup
+	exit 2
+}
+
+test_kvm_stat() {
+	echo "Testing perf kvm stat"
+
+	echo "Recording kvm events for pid ${qemu_pid}..."
+	if ! perf kvm stat record -p "${qemu_pid}" -o "${perfdata}" sleep 1; then
+		echo "Failed to record kvm events"
+		err=1
+		return
+	fi
+
+	echo "Reporting kvm events..."
+	if ! perf kvm -i "${perfdata}" stat report 2>&1 | grep -q "VM-EXIT"; then
+		echo "Failed to find VM-EXIT in report"
+		perf kvm -i "${perfdata}" stat report 2>&1
+		err=1
+		return
+	fi
+
+	echo "perf kvm stat test [Success]"
+}
+
+test_kvm_record_report() {
+	echo "Testing perf kvm record/report"
+
+	echo "Recording kvm profile for pid ${qemu_pid}..."
+	# Use --host to avoid needing guest symbols/mounts for this simple test
+	# We just want to verify the command runs and produces data
+	# We run in background and kill it because 'perf kvm record' appends options
+	# after the command, which breaks 'sleep' (e.g. it gets '-e cycles').
+	perf kvm --host record -p "${qemu_pid}" -o "${perfdata}" &
+	rec_pid=$!
+	sleep 1
+	kill -INT "${rec_pid}"
+	wait "${rec_pid}" || true
+
+	echo "Reporting kvm profile..."
+	# Check for some standard output from report
+	if ! perf kvm -i "${perfdata}" report --stdio 2>&1 | grep -q "Event count"; then
+		echo "Failed to report kvm profile"
+		perf kvm -i "${perfdata}" report --stdio 2>&1
+		err=1
+		return
+	fi
+
+	echo "perf kvm record/report test [Success]"
+}
+
+test_kvm_buildid_list() {
+	echo "Testing perf kvm buildid-list"
+
+	# We reuse the perf.data from the previous record test
+	if ! perf kvm --host -i "${perfdata}" buildid-list 2>&1 | grep -q "."; then
+		echo "Failed to list buildids"
+		perf kvm --host -i "${perfdata}" buildid-list 2>&1
+		err=1
+		return
+	fi
+
+	echo "perf kvm buildid-list test [Success]"
+}
+
+setup_qemu() {
+	# Find qemu
+	if [ "$(uname -m)" = "x86_64" ]; then
+		qemu="qemu-system-x86_64"
+	elif [ "$(uname -m)" = "aarch64" ]; then
+		qemu="qemu-system-aarch64"
+	elif [ "$(uname -m)" = "s390x" ]; then
+		qemu="qemu-system-s390x"
+	elif [ "$(uname -m)" = "ppc64le" ]; then
+		qemu="qemu-system-ppc64"
+	else
+		qemu="qemu-system-$(uname -m)"
+	fi
+
+	if ! which -s "$qemu"; then
+		skip "$qemu not found"
+	fi
+
+	if [ ! -r /dev/kvm ] || [ ! -w /dev/kvm ]; then
+		skip "/dev/kvm not accessible"
+	fi
+
+	if ! perf kvm stat record -a sleep 0.01 >/dev/null 2>&1; then
+		skip "No permission to record kvm events"
+	fi
+
+	echo "Starting $qemu..."
+	# Start qemu in background, detached, with pidfile
+	# We use -display none -daemonize and a monitor to keep it alive/controllable if needed
+	# We don't need a real kernel, just KVM active.
+	if ! $qemu -enable-kvm -display none -daemonize -pidfile "${qemu_pid_file}" -monitor none; then
+		echo "Failed to start qemu"
+		err=1
+		return
+	fi
+
+	# Wait a bit for qemu to start
+	sleep 1
+	qemu_pid=$(cat "${qemu_pid_file}")
+
+	if ! kill -0 "${qemu_pid}" 2>/dev/null; then
+		echo "Qemu process failed to stay alive"
+		err=1
+		return
+	fi
+}
+
+setup_qemu
+if [ $err -eq 0 ]; then
+	test_kvm_stat
+	test_kvm_record_report
+	test_kvm_buildid_list
+fi
+
+cleanup
+exit $err
-- 
2.52.0.rc2.455.g230fcf2819-goog

