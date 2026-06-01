Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC3263CB
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 00:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780272391; cv=none; b=aS2gI1slVPqLQ93lZ8HyqYAaMfcNQ1rtPWxM9k2JRIHY9CqBaP+EvSTlq8cyVJ/XVNbZV6ADYqeaxGKTtXp3cEmfhcz1qtCdDdJ82mohljL51G6//V5owfMbi3Sj3Yakf/kcSf7IiiluQKVCEFXYthtLtGGt9fA1KFNv5uzy1rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780272391; c=relaxed/simple;
	bh=fceYlMYPSFIBhgKdtj2vldQcRO1z7pGUGyHIbbbwZFg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sVflDLs+AT6JeoO0NWpuCv6n0DkA1PVoascPaCprox9dumqw/BofN5u7C+B9ARufGnt8pC0gun4JzK/J0WN84hQvZion+yrTsy99NDtbcH2m/fDE+cAX7QRLKOdx8JQLEZv9tgVM21HUd3B1j4f2tgU962QWYqAEdq94AhqBvXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OAysrWx3; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OAysrWx3"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137dd5171feso1172133c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 17:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780272385; x=1780877185; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5fWSS6pmKaXR3mc2oxOogwkg8pn144sIhxDOKYQ4GWI=;
        b=OAysrWx3+dM7HDyRsaDSU7/5of1kFP/EsB4adJV41NyYZRcHa/2E3jSoNGziJuRDJi
         KyRxKigOx3DqMSj0C9LXtLRI9IbLMMookBTpxT78euDpWCJuySwr1ZUIJ8ECPrWdifMY
         GSd9nkx10recCYmCJ8dF5b/+iqwKopvH7l/TFbZGX6V920kNnQowRtY41/0AOEanMZJs
         All4BdQ3UftcHji9i8AFCVXqjhc8NXuNNSuBvFohqfWH2a+OXRdJQKVvKYfoXvvo0EqF
         QuEbA77VB5Rfj4Ozt08rT0XXLCR1yYVthnoRrrFRiJeu9pY8qlgoaV1DkjHQW3T4LQFH
         S7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780272385; x=1780877185;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5fWSS6pmKaXR3mc2oxOogwkg8pn144sIhxDOKYQ4GWI=;
        b=lBPM0nsQgDlOJosHKAAUSYNxwgUdLS2qVkgh8X44RsGsCWe5JubE1B8YU/6FETTiXw
         MWThT8p/UGJXhJQvIaLJVRc6KNPc9EWPrXyZ6HCFo0k4PC69xufsvgftHW2Ao8hI71A3
         phxqcQ21vv7lA6msQuncdnwi577qNVIqJK6P8pvv/Cy6zweeUUKdLi4wJGSpp/8SLPJM
         NGWD2XvCq7jgydrzcYvf4HHebzbexkbDwJLkA03WsWHxvRGAaCSjaLmtWqzcZVMUKWeo
         d9AzqdPfktliK6YBSHD+tjdXo2TqMM9ZGTiFPUZ09z5w2yLeuJwdY26GJ6sV6Irr1tEH
         mAjw==
X-Forwarded-Encrypted: i=1; AFNElJ/5fPT065TZB5pz56QdlWJkEh0CdAIHMHmTpNhbLi2ZqbniSWGClKFNc3nJTNxn30A4gs5PQOMeazcW3SpofS8Y@vger.kernel.org
X-Gm-Message-State: AOJu0YwddnpDnGBAR9Ys58yQqHIRsi4h0I7FVJOWag/uiBuwIjY9OGW1
	Xo9LQNwCLqySEyuw2X1IJKD7Rt6zaSJpLy2QIcXmP7WrXcbIK2s+Wr9dT2l+VpCYbo1CIoycO1I
	Ih+X/hwjBdA==
X-Received: from dll6.prod.google.com ([2002:a05:7022:206:b0:132:9fc5:59aa])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3804:b0:137:e6a9:b986
 with SMTP id a92af1059eb24-137e6a9bc7amr15990c88.18.1780272384773; Sun, 31
 May 2026 17:06:24 -0700 (PDT)
Date: Sun, 31 May 2026 17:05:47 -0700
In-Reply-To: <20260601000548.1195604-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531082235.940833-1-irogers@google.com> <20260601000548.1195604-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601000548.1195604-15-irogers@google.com>
Subject: [PATCH 14/15] perf test: Add shell test to validate JUnit XML
 reporting output
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Add a shell test script (test_test_junit_output.sh) to execute perf test
with the -j/--junit option and validate that the generated test report
complies perfectly with standard XML formatting using Python's ElementTree
XML parser.

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
2.54.0.823.g6e5bcc1fc9-goog

