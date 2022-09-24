Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83305C32771
	for <linux-perf-users@archiver.kernel.org>; Sat, 24 Sep 2022 13:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiIXNeW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 24 Sep 2022 09:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiIXNeV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 24 Sep 2022 09:34:21 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A744F2D1D3
        for <linux-perf-users@vger.kernel.org>; Sat, 24 Sep 2022 06:34:20 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id b5so2677936pgb.6
        for <linux-perf-users@vger.kernel.org>; Sat, 24 Sep 2022 06:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=RY8LA3Ud6X3kkmJY3XlXNl8R73lTrsVPFHZT3EIEjMw=;
        b=abHBkWADIUZhsDUWWNdBgOqMUC4xkoKbE1xWNJ0bL0h0KZmI964q8CDk/G+XJJL0Oh
         YdkvjvfJYCQGXxgpHy/a2aZlbjxBSvEpkVvsMgu7TQMm755WvxiHmQ9YSZ+gyHh3wnox
         vKJrR1lBPPmAss3dLFGmYahGxSCdG++9IjT7SjWVCWWE8L4OnDzs3QwVgC9jCJJZKkUm
         MfBCOU63aUjzor2hVj1OU1TaFs399ScNQIYCkbAmSIHoJHiVfH1QRgBDtQJVEqIRCF28
         LB2F7PYxryWwvP+udXq+bC6NQx4N+Mtt9Hir5amgiVhhn06y9R5dugmoJeDAl6UdDlS0
         TAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=RY8LA3Ud6X3kkmJY3XlXNl8R73lTrsVPFHZT3EIEjMw=;
        b=XxD3Yr12sNCf22rRi9AwxEH3sU/+s13Keqld0P9gpV4htXB1FKhmYuvzveZepitSNZ
         juk+nwUu5l8DqBIOqQQP47TA5cFwcH7/p6007rlicA8lref5fEgDHyxhtEw+lhFCSGVm
         igmFk6MiTqYC4kcCNbu6/9qY9sO4cZsuLKMHxqIpdCPP0DqBHKjjZdHN4SXItQFuLUUs
         3Xs0fmoByonF0rI5lUCQI1PFW7cv88HXkHTZM1uhOqzZQsDW0pGC+V+Fc7CZJweCb1XL
         ewYQ7zEos+JTFnC5Y1U7fjuguwqFaSVrQ+37rjxgNxK+WdfcGvDMcMyGrbND5mq+pZxR
         12kg==
X-Gm-Message-State: ACrzQf2Afxl7b0bXzsPQPtQxidYAQl8uCzmTxScC2uu4ARyazRXdgICQ
        csQBpPT4At/liYHt8m8N6THFTw==
X-Google-Smtp-Source: AMsMyM4497AOaLk6YqcBrZG91dItIMz5oWLFUS2obpFljHDamo6wmK+rf4bRNY8FiOyCAG/KWNnQHQ==
X-Received: by 2002:a05:6a00:1a94:b0:548:8ce8:db93 with SMTP id e20-20020a056a001a9400b005488ce8db93mr14334148pfv.13.1664026460018;
        Sat, 24 Sep 2022 06:34:20 -0700 (PDT)
Received: from leoy-huanghe.lan (ec2-13-52-75-203.us-west-1.compute.amazonaws.com. [13.52.75.203])
        by smtp.gmail.com with ESMTPSA id b15-20020a63d30f000000b004393cb720afsm7456068pgg.38.2022.09.24.06.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 06:34:19 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3] perf test: Introduce script for data symbol testing
Date:   Sat, 24 Sep 2022 21:34:08 +0800
Message-Id: <20220924133408.1125903-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This commit introduces a shell script for data symbol testing.

The testing is designed a data structure with 64-byte alignment, it has
two fields "data1" and "data2", and other fields are reserved.

Using "perf mem" command, we can record and report memory samples for a
self-contained workload with 1 second duration.  If have no any memory
sample for the data structure "buf1", it reports failure;  and by
checking the offset in structure "buf1", if any memory accessing is not
for "data1" and "data2" fields, it means wrong data symbol parsing and
returns failure.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---

Changes from v2:
- Used 'symbol_daddr' sort key in report (Namyung);
- Didn't save source code into temp file and used pipe for compilation
  (Namyung);
- Polished the C test code included in the script (Namyung).

Changes from v1:
- Removed "killall" since the test has no child process (Ian);
- Used "char" instead of "long" in the buf structure.

 tools/perf/tests/shell/test_data_symbol.sh | 83 ++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_data_symbol.sh

diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/tests/shell/test_data_symbol.sh
new file mode 100755
index 000000000000..a153b0d84dc0
--- /dev/null
+++ b/tools/perf/tests/shell/test_data_symbol.sh
@@ -0,0 +1,83 @@
+#!/bin/bash
+# Test data symbol
+
+# SPDX-License-Identifier: GPL-2.0
+# Leo Yan <leo.yan@linaro.org>, 2022
+
+skip_if_no_mem_event() {
+	perf mem record -e list 2>&1 | egrep -q 'available' && return 0
+	return 2
+}
+
+skip_if_no_mem_event || exit 2
+
+# skip if there's no compiler
+if ! [ -x "$(command -v cc)" ]; then
+	echo "skip: no compiler, install gcc"
+	exit 2
+fi
+
+TEST_PROGRAM=$(mktemp /tmp/__perf_test.program.XXXXX)
+PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+
+check_result() {
+	# The memory report format is as below:
+	#    99.92%  ...  [.] buf1+0x38
+	result=$(perf mem report -i ${PERF_DATA} -s symbol_daddr -q 2>&1 |
+		 awk '/buf1/ { print $4 }')
+
+	# Testing is failed if has no any sample for "buf1"
+	[ -z "$result" ] && return 1
+
+	while IFS= read -r line; do
+		# The "data1" and "data2" fields in structure "buf1" have
+		# offset "0x0" and "0x38", returns failure if detect any
+		# other offset value.
+		if [ "$line" != "buf1+0x0" ] && [ "$line" != "buf1+0x38" ]; then
+			return 1
+		fi
+	done <<< "$result"
+
+	return 0
+}
+
+cleanup_files()
+{
+	echo "Cleaning up files..."
+	rm -f ${PERF_DATA}
+	rm -f ${TEST_PROGRAM}
+}
+
+trap cleanup_files exit term int
+
+# compile test program
+echo "Compiling test program..."
+cat << EOF | cc -o ${TEST_PROGRAM} -x c -
+typedef struct _buf {
+	char data1;
+	char reserved[55];
+	char data2;
+} buf __attribute__((aligned(64)));
+
+static buf buf1;
+
+int main(void) {
+	for (;;) {
+		buf1.data1++;
+		buf1.data2 += buf1.data1;
+	}
+	return 0;
+}
+EOF
+
+echo "Recording workload..."
+perf mem record --all-user -o ${PERF_DATA} -- $TEST_PROGRAM &
+PERFPID=$!
+
+sleep 1
+
+kill $PERFPID
+wait $PERFPID
+
+check_result
+exit $?
-- 
2.34.1

