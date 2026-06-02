Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9B83812EF
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385539; cv=none; b=lwqpt/uqd3/l4HQpg9D0l8Otbwiq1mB08p5vz8kHZu9TNBiN+GdJPMJgDcXZnMLu6rXjlnYPIn8/L+HpljkTAkpZ4uDXqGUPHCufP66/OuyZ/rG7pM2a+wb8P2GeSSOxv2uQLpV+WheHJ7mj1kNMjfqEi8koEM3B/6HT1dhrF3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385539; c=relaxed/simple;
	bh=i0xXVNWuYT1C8DsC3ftwc/I6Pi3yZQ/7czWZ2fzHOOI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m5Fl6RD3IEGC4Z5iidxixQJkDMoBMikueHiKDYbs72vIVIlPh7+ib4+MA2jdeJtu5wWnVFOr4oTYHxA+8LnPm90rdX/z8DGVQD5S9Xs7w47EW6z+fmZmDQPbiukGUx8DX1qrAtasHqvlTKPQGrA7BzgGypTLLzl7lRLxpwJ0ICQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aXycdwyy; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aXycdwyy"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304c652be4eso3833661eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 00:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780385531; x=1780990331; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3JwdhiNmbjqundikMObpt5WprN8LxssMnsDdN/mV/P8=;
        b=aXycdwyy8XuJY5CmtV5n2B/oQMxSfhf/+1/Eh5Af1lV4nj8XiIqK42CPxYCtmlRViY
         hWGw96iKsFlVOXCt1rxdom/AgQte/peb3kcBZrzuzPqMbE0jJe9XPhAtlzQrCEb48Wcu
         BaWI4vml+KOXueiOwEzDn2k47BGAUtA9Wzc5EqK+v2MXfOejzgZPzaaihT6yJAXDuI6n
         sYGjJrwAZjo2uDolreg2f0Fn95/SAkmeppgCntgUjdjOcHuAfCscS/x1nD3BRfIB6aCv
         mva1r9F6VReLiDGvNFEnwP4y1TSnBHumvVVqJM1RKIQnUMqYDh5I0zt1NqYoHadgNIk4
         CA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780385531; x=1780990331;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3JwdhiNmbjqundikMObpt5WprN8LxssMnsDdN/mV/P8=;
        b=BDTfsP/D+rC8jijWDrFI7N75ue3DNdQ5oSrlWCviYx3lQxs1Qf7A0afcwxjjBJRVqX
         1NkLN6etPZAdjr6gJJVBHeK3XZQGji46vcDxqS5E4CwFhiZw+nwdeuF5dW+wU7T4tuJH
         udmeUfGbUlMXbNsUwUE6tHQN6ClT7TLVh5K2GDTlnCruNx4HUY+jfA2T5Wv+LUiBTxLj
         QFVB6shkwYTOov3QWvTzld/0oRX+6VKFLpnMZJ8AL98cqZdFaYgHs0LyJDicdMjQPVGd
         0Me2Au9+a21b8P/999EYmUqkhIn59oHjBBAmPw1qSIHL+zliq5VhTRHJDmoNHwymWi1l
         ftjQ==
X-Forwarded-Encrypted: i=1; AFNElJ84j89co115Dct2JMJSGCYflRcQYWajE9G8tCUhIGHiHeXURltmfg4EKblN7YiSdJdak/5l+RG3H/EebnZL3162@vger.kernel.org
X-Gm-Message-State: AOJu0YxGy9ANz8taWSKgYVhEhRTdb9J8KAJPJAh2N4R74QtXEaNVnG3u
	gNBfFlBn/nvPLuHE2VP95x5OtP1aaAb3P5DEShT5upqFjseJd1OOZIvcqpPwGA/fDfsiptdO3fl
	mFZLltY8uFQ==
X-Received: from dlah4.prod.google.com ([2002:a05:701b:2604:b0:137:ee83:5523])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f318:b0:137:ee08:ad37
 with SMTP id a92af1059eb24-137ee1e01famr546980c88.13.1780385531032; Tue, 02
 Jun 2026 00:32:11 -0700 (PDT)
Date: Tue,  2 Jun 2026 00:31:30 -0700
In-Reply-To: <20260602073132.2653307-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601061401.1541457-1-irogers@google.com> <20260602073132.2653307-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602073132.2653307-16-irogers@google.com>
Subject: [PATCH v7] perf test: Add shell test to validate JUnit XML reporting output
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Add a shell test script (test_test_junit_output.sh) to execute perf test
with the -j/--junit option and validate that the generated test report
complies perfectly with standard XML formatting using Python's
ElementTree XML parser.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../tests/shell/test_test_junit_output.sh     | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_test_junit_output.sh

diff --git a/tools/perf/tests/shell/test_test_junit_output.sh b/tools/perf/tests/shell/test_test_junit_output.sh
new file mode 100755
index 000000000000..5104ac1e1e6d
--- /dev/null
+++ b/tools/perf/tests/shell/test_test_junit_output.sh
@@ -0,0 +1,63 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# perf test junit XML output validation
+
+set -e
+
+err=0
+
+shelldir=$(dirname "$0")
+# shellcheck source=lib/setup_python.sh
+. "${shelldir}"/lib/setup_python.sh
+
+result=$(mktemp /tmp/__perf_test.output.xml.XXXXX)
+
+cleanup()
+{
+	rm -f "${result}"
+	trap - exit term int
+}
+
+trap_cleanup()
+{
+	echo "Unexpected signal in ${FUNCNAME[1]}"
+	cleanup
+	exit 1
+}
+trap trap_cleanup exit term int
+
+test_junit_output()
+{
+	echo "Testing perf test JUnit XML output command"
+	perf test -v -j"$result" util || true
+	if [ -s "$result" ] ; then
+		echo "perf test JUnit XML output command [SUCCESS]"
+	else
+		echo "perf test JUnit XML output command [FAILED]"
+		err=1
+	fi
+}
+
+validate_xml_format()
+{
+	echo "Validating perf test converted JUnit XML file"
+	if [ -f "$result" ] ; then
+		if $PYTHON -c \
+		    "import xml.etree.ElementTree as ET; ET.parse('$result')" \
+		    >/dev/null 2>&1 ; then
+			echo "The file contains valid XML format [SUCCESS]"
+		else
+			echo "The file does not contain valid XML format [FAILED]"
+			err=1
+		fi
+	else
+		echo "File not found [FAILED]"
+		err=1
+	fi
+}
+
+test_junit_output
+validate_xml_format
+
+cleanup
+exit ${err}
-- 
2.54.0.929.g9b7fa37559-goog

