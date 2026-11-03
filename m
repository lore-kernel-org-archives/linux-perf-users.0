Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749617;
	b=43BOeLvtU+FGDLN2c+C2aUXBR3v3Dar818mwA+F2C+yWXvZ+red/XziJ3NMxmEl3lXsE
	 p+dk5HzggBSH43Qu0xMmyInEimiq7u/ZoycIfVoghIrpUzFvbouTC0FscWEOy1+eBGwXQ
	 0YQHQsE8aleyGk6eJ9VG3BaBws2DomYN+uDmwxWe9ds3CsTwR8cJ0w0g+ryYm/UB5z568
	 2RAad3pSQdONcOb2KNJujrHPv2yrrobaf+LyEz46QQg7sWNlctx5nc4/uGWtq6kR6Gp/o
	 qyWTZOUt5K/nAyIkJob0oR/rCCRxTYTa4/miBDDaNcdM0WwJHeX0lYtXQ+6HZu/tq0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749617;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=iUbENOe0+ZyGJ7lO4/Mfds7NTa8dcwMT09NdCLq1Cs8=;
	b=K/cC/sxKRflgD2xQJIVjTn9sV77c40DZNPKIY2PlDFvcainFx81/bKVLk2NOlDNo+nwx
	 QT/iJS+E9V4NXn1PPIiSwzoAV5rPYvQW5S7kUDx6nWqgn+HmS4W5QEQO8ECwJln1s1qK5
	 wk5kEmo4Cla3OqEIPrxWyJC6fbJe7RceNRo1TYcOvqCB9sF9kS+mRngL1e9bYxeZW7vys
	 P15bff0iRrSjFkhXKssejgMEuNg/Px8E8HMxZInaSceaLo+yk1UeZ7dm/un8ff6sXIu4Q
	 KxQ7HiEt9FntCNWBEOAs88G8MwXuJMb574mUS7HqvJQo9BcdaOqmmV9CrLdFxm2xQFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mXo3IAJW;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC933606EEAC
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 23:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC933606EEAC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mXo3IAJW
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30bcb065bfdso160921eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 15:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793749616; x=1794354416; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iUbENOe0+ZyGJ7lO4/Mfds7NTa8dcwMT09NdCLq1Cs8=;
        b=mXo3IAJWWW63P8MuW/7c50/agUwggJzJPE0jOXIEmgw8bhYwrxVbUv8OQCdo7oc50D
         Uog+xlDUV9T+lZA7Riv6kqWrzPONerBMJ+1C1CSl5xNO7zVnisumjOmYot6H88AQg+1D
         LwkuvWEMr95OHt7Q1Z9fMIpXOjy1+xrtTwCS0z/nMP5zyWZuwZee1/vOs2KwHQUkUkBv
         0mBZVuussytWvFssVxWS3DhvJzaUxi5Y+dSG8ZN2qUWH7dIlBerFIXxec6gtYiJ4WgW2
         Zx855knIaGZX4nlloxviIk1KupfMiToKGuB1hxPEH4gLRR7uM3JDcAX0Mv4FmaclFEhd
         Wuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749616; x=1794354416;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iUbENOe0+ZyGJ7lO4/Mfds7NTa8dcwMT09NdCLq1Cs8=;
        b=ytleUXDwxOYlgz0E7DsIHCFvw6FMUON0fS830hqYlqm4B7zpegX34Nkicw9gEnG2Oc
         GcmkbFDbY0woHZAdlGWMBgrpsmcR+Lyw6jbqhOwGlDQvnMLM7FTICm7+baWnl1grmdga
         nxdwtogyeNNtcpsqN0eW0ucJwRmMaTxe4YvZDbGARUjO+u5E/cE5f/URRFLlP+QuKzsF
         apdIoghjU4bHwx31PjHySfRMbdo3kOtpJBjH/zOMMIYXtZP+ArLcJgtJXwEPfkmE2WxC
         lsqrq3nq5crWRkXAKxRRaSYk/rfBNaN5Y4GkiM6b/hqJAPQmnCFpuMb4MHaetddSWGkV
         2fZw==
X-Gm-Message-State: APuU4Z8NlZonPmbqJ89EhuW1VvjZ0wj+g8nJuMIzFJPM+ge5NqkGmOJ4
	e+zymxEB4yf9boj4mA2KiUbrUTMYTFtim4head4+9hl5DdZWfc+/9MOvKkUJrr8s80ujziS2Jyu
	+BjXbbOVy9rSaH7wu+Ud2BohzNh82V8XoZZNTVIGFutyyPIKkvDCqHrevg15kZRc2L9AHQXt+9r
	qyKDyV4FHSPRuiygLiSKtxr3eLWV8kfjfCOW9VWGtnaCPPPEQfKOirtpQ=
X-Received: from dlbur23.prod.google.com ([2002:a05:7022:ea57:b0:185:5973:326c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b059:10b0:16a:8ffd:4977
 with SMTP id a92af1059eb24-1ac5e322661mr21999448c88.17.1793749615550; Tue, 03
 Nov 2026 15:46:55 -0800 (PST)
Date: Tue,  3 Nov 2026 15:44:57 -0800
In-Reply-To: <20261103234502.1008382-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103234502.1008382-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103234502.1008382-42-irogers@google.com>
Subject: [PATCH v1 41/41] perf test: Add perf sysinfo shell test
From: Ian Rogers <irogers@google.com>
To: linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, John Garry <john.garry@linux.dev>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@arm.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a shell test exercising default 'perf sysinfo' summary output,
'--pmus' per-PMU output, '-j' JSON validation, PMU glob filtering, and
'-i perf.data' inspection.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/sysinfo.sh | 83 +++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100755 tools/perf/tests/shell/sysinfo.sh

diff --git a/tools/perf/tests/shell/sysinfo.sh b/tools/perf/tests/shell/sysinfo.sh
new file mode 100755
index 000000000000..59091b4d750d
--- /dev/null
+++ b/tools/perf/tests/shell/sysinfo.sh
@@ -0,0 +1,83 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# perf sysinfo tests
+
+set -e
+
+shelldir=$(dirname "$0")
+. "${shelldir}"/lib/setup_python.sh
+
+sysinfo_output=""
+perf_data=""
+
+cleanup() {
+  rm -f "${sysinfo_output}" "${perf_data}" ${perf_data:+"${perf_data}.old"}
+  trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+sysinfo_output=$(mktemp /tmp/__perf_test.sysinfo_output.XXXXX)
+perf_data=$(mktemp /tmp/__perf_test.sysinfo.perf.data.XXXXX)
+
+test_sysinfo_default() {
+  echo "Default perf sysinfo output test"
+  perf sysinfo -o "${sysinfo_output}"
+  grep -q "^Summary:" "${sysinfo_output}"
+  grep -q "System rating:" "${sysinfo_output}"
+  perf sysinfo --pmus -o "${sysinfo_output}"
+  grep -q "^software (" "${sysinfo_output}"
+  grep -q "^Summary:" "${sysinfo_output}"
+  echo "Default perf sysinfo output test [Success]"
+}
+
+test_sysinfo_json() {
+  echo "Json perf sysinfo output test"
+  perf sysinfo -j -o "${sysinfo_output}"
+  $PYTHON -m json.tool "${sysinfo_output}" /dev/null
+  echo "Json perf sysinfo output test [Success]"
+}
+
+test_sysinfo_filter() {
+  echo "Filtered perf sysinfo output test"
+  perf sysinfo -o "${sysinfo_output}" software
+  grep -q "^software (" "${sysinfo_output}"
+  if grep -q "Modes:.*sampling" "${sysinfo_output}"; then
+    grep -q "Sample types:.*ip" "${sysinfo_output}"
+    if grep -q "Sample types:.*regs_user" "${sysinfo_output}"; then
+      grep -q "User registers:" "${sysinfo_output}"
+    fi
+    if grep -q "Sample types:.*regs_intr" "${sysinfo_output}"; then
+      grep -q "Intr registers:" "${sysinfo_output}"
+    fi
+    grep -q "Features:.*leader_sampling" "${sysinfo_output}"
+    grep -q "Features:.*sw_grouping" "${sysinfo_output}"
+  fi
+  echo "Filtered perf sysinfo output test [Success]"
+}
+
+test_sysinfo_perf_data() {
+  echo "perf.data perf sysinfo test"
+  if ! perf record -e software/cpu-clock/u -o "${perf_data}" -- true 2>/dev/null; then
+    echo "perf.data perf sysinfo test [Skipped: perf record failed]"
+    return
+  fi
+  perf sysinfo -i "${perf_data}" -o "${sysinfo_output}"
+  grep -q "^Summary:" "${sysinfo_output}"
+  perf sysinfo --pmus -i "${perf_data}" -o "${sysinfo_output}"
+  grep -q "software" "${sysinfo_output}"
+  perf sysinfo -i "${perf_data}" -j -o "${sysinfo_output}"
+  $PYTHON -m json.tool "${sysinfo_output}" /dev/null
+  echo "perf.data perf sysinfo test [Success]"
+}
+
+test_sysinfo_default
+test_sysinfo_json
+test_sysinfo_filter
+test_sysinfo_perf_data
+cleanup
+exit 0
-- 
2.56.0.385.gac671c819a-goog

