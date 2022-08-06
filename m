Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F26FC19F29
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Aug 2022 03:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241603AbiHFDe4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 5 Aug 2022 23:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241428AbiHFDeu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 5 Aug 2022 23:34:50 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A151A395
        for <linux-perf-users@vger.kernel.org>; Fri,  5 Aug 2022 20:34:48 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id b133so3751670pfb.6
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Aug 2022 20:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=veTkeUGSJq9jMSOq4JnTF8x9RpEtNY0/cp/aCVznyBY=;
        b=IRgcX2QBJmTmSAKUtZ0uQNVBj7qlsfOun1GCR49m3iaW7fWTNGm+5+nXVRLmh/NJEg
         DHdK4Q/rM0186FUA+qD/PAudlZ57QKpqe5TEtCy3l7cathatehpmOcYsRRp31tbEQ3P9
         MPW6F9v28NTleDQJU0cbpVje+NFBoAVCQzFUa4of65BFkcar/5/5xDXJXV8rB3Yl/5r7
         av+3F4XY9d8M5aNP7uuuxFr3IQzmQfSpBG2sKVb2PiFw0Fa8kef6DOZcxv7QXeGIYm3w
         qB1gr7zBKojfHyH5H1VxoRMDBBUuQ34tDcp4aLaZ6QjIdHMjGAynKKlbYvXjVdFr86zy
         3uYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=veTkeUGSJq9jMSOq4JnTF8x9RpEtNY0/cp/aCVznyBY=;
        b=dfJdGZC9Ka3Mf9grwfSJObfxYn2uOfu9de79wXBsclNZWRuX4P2DLxaycnwmR93y+S
         IZm/nz1e+syUnqg2eaxOukoQat6ME25+hzThn65Pb9ik7lcz168AzQCIzNESIi09PQMd
         bQnaDv5DCgogcEGTnEVbBgZnMZqF3jjw8aRmQ3Eyz0QaHeqnk+w7HkT3wsmXXc4crHlG
         Pif3BpDDWoH7oHMWBniqPshho2+t0BleL/MkJ4wMvLKMnWD650c/HbpSILgBcDWEXQ5L
         wE0RmCMotLW7eL8rU9i8JjvwaJFIea/yeTeTqTURdcogl7V7YjbsvqKrC0Qi678Rp0nG
         gJTA==
X-Gm-Message-State: ACgBeo2i0v/doN0AjTFsBqofH2bzDjY0nn3XYbxEoBj1DEk6rHdo9VLP
        VCsD8cRg++j0yyAiCozTQlxsdw==
X-Google-Smtp-Source: AA6agR7fDAyrYuGF7xqBwFwu6zL+LJDQGsjlG2R05LyVt0bWfwRFhrFmtGs+L82WEzACNPjV9NFbAA==
X-Received: by 2002:a63:5626:0:b0:41b:576d:6f33 with SMTP id k38-20020a635626000000b0041b576d6f33mr8191745pgb.131.1659756888125;
        Fri, 05 Aug 2022 20:34:48 -0700 (PDT)
Received: from localhost (ec2-18-144-7-244.us-west-1.compute.amazonaws.com. [18.144.7.244])
        by smtp.gmail.com with ESMTPSA id e14-20020a17090301ce00b0016dc26c7d30sm3882135plh.164.2022.08.05.20.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 20:34:47 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 2/2] perf test: Introduce script for java symbol testing
Date:   Sat,  6 Aug 2022 11:34:34 +0800
Message-Id: <20220806033434.121908-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220806033434.121908-1-leo.yan@linaro.org>
References: <20220806033434.121908-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This commit introduces a script for testing java symbols.

The test records for java program, inject samples with JIT samples, then
check specific words "Interpreter" and "jdk.internal" in the report, the
test will pass if these two symbols are detected.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/tests/shell/test_java_symbol.sh | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_java_symbol.sh

diff --git a/tools/perf/tests/shell/test_java_symbol.sh b/tools/perf/tests/shell/test_java_symbol.sh
new file mode 100755
index 000000000000..45d42a9fdca5
--- /dev/null
+++ b/tools/perf/tests/shell/test_java_symbol.sh
@@ -0,0 +1,66 @@
+#!/bin/bash
+# Test java symbol
+
+# SPDX-License-Identifier: GPL-2.0
+# Leo Yan <leo.yan@linaro.org>, 2022
+
+PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+PERF_INJ_DATA=$(mktemp /tmp/__perf_test.perf.data.inj.XXXXX)
+
+cleanup_files()
+{
+	echo "Cleaning up files..."
+	rm -f ${PERF_DATA}
+	rm -f ${PERF_INJ_DATA}
+}
+
+trap cleanup_files exit term int
+
+if [ -e "$PWD/tools/perf/libperf-jvmti.so" ]; then
+	LIBJVMTI=$PWD/tools/perf/libperf-jvmti.so
+elif [ -e "$PWD/libperf-jvmti.so" ]; then
+	LIBJVMTI=$PWD/libperf-jvmti.so
+elif [ -e "$PREFIX/lib64/libperf-jvmti.so" ]; then
+	LIBJVMTI=$PREFIX/lib64/libperf-jvmti.so
+elif [ -e "$PREFIX/lib/libperf-jvmti.so" ]; then
+	LIBJVMTI=$PREFIX/lib/libperf-jvmti.so
+else
+	echo "Fail to find libperf-jvmti.so"
+	exit 1
+fi
+
+cat <<EOF | perf record -k 1 -o $PERF_DATA jshell -s -J-agentpath:$LIBJVMTI
+int fib(int x) {
+	return x > 1 ? fib(x - 2) + fib(x - 1) : 1;
+}
+
+int q = 0;
+
+for (int i = 0; i < 10; i++)
+	q += fib(i);
+
+System.out.println(q);
+EOF
+
+if [ $? -ne 0 ]; then
+	echo "Fail to record for java program"
+	exit 1
+fi
+
+if ! perf inject -i $PERF_DATA -o $PERF_INJ_DATA -j; then
+	echo "Fail to inject samples"
+	exit 1
+fi
+
+# Below is an example of the instruction samples reporting:
+#   8.18%  jshell           jitted-50116-29.so    [.] Interpreter
+#   0.75%  Thread-1         jitted-83602-1670.so  [.] jdk.internal.jimage.BasicImageReader.getString(int)
+perf report --stdio -i ${PERF_INJ_DATA} 2>&1 | \
+	egrep " +[0-9]+\.[0-9]+% .* (Interpreter|jdk\.internal).*" > /dev/null 2>&1
+
+if [ $? -ne 0 ]; then
+	echo "Fail to find java symbols"
+	exit 1
+fi
+
+exit 0
-- 
2.25.1

