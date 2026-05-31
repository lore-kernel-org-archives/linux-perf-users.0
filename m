Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9502F3C3D
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780215796; cv=none; b=dUseGoPP/FmdtMIO4qp9DLa9lqUwiw+iufEpT3NamKSoY9XUwGYzXT5MFxEItPsEfEDMmcWOMaNwx1Q2Eb++laK7jNnqyr7lfd50VGDxYKP+O1DM7PZJZA7vjlvp8txOV/8RbdOE8ZizNGpQo9DGPVDSuMii6O7upakGvQIqKoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780215796; c=relaxed/simple;
	bh=fceYlMYPSFIBhgKdtj2vldQcRO1z7pGUGyHIbbbwZFg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QXB4t580+UeIyO1Fw8tf31+oOqB0GhrSVUCPMg1Gdj0bi4xkbyN4T0vVoQUVuhGK01yxh0cFNflMwj4gYJZLIx3AMM/CWzeN5I6xP/JNiGAoNIJzz3BcEtPcblc17IxezGY+APTyCDBphmi3Xg9F/+lqml359n+M+dxSxPxgw7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KYgaGuL7; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KYgaGuL7"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304e3e3fba5so10665188eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 01:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780215795; x=1780820595; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5fWSS6pmKaXR3mc2oxOogwkg8pn144sIhxDOKYQ4GWI=;
        b=KYgaGuL7EPMwIRRFUmG7z7yeRwibSXGnOD8oXErLWR32yFuPzHyq7C2hdZktY8uDT9
         hKWkW6I0lgzXLKg47j3LQI4MeaMm7E/989udmKwU+1dcNuhp56oGi+rnahIze1rkd6Qi
         UhLhdmCG5FFtE94j8l9HwRwBUv8ZRJlLKHmjC351ayAbf/8RBRYarwjAxK+IUt6ngQR7
         E2av/E1Ue3Fp1vYVLOeg+Eh7GrgWoT+K8NpRIYRLoGabD6Gp5NDWtr7dlUY5y9oIW/Wa
         XvG1S7f2NkW/zn1UUotzUStsx9teqoOALkhFgMIXTYugCQ+kKDX9i27fiOKkaikk6qjV
         lCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780215795; x=1780820595;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5fWSS6pmKaXR3mc2oxOogwkg8pn144sIhxDOKYQ4GWI=;
        b=QgYtqhr3jon2bbiiDP6hp1NW/zNhtotXRhun4afXdbPSLOZsD8sM7zGczvNMnt/OvU
         HPZtVpZvXLN3WiLnDZYCaBX98sbODBdpzyRYYyKDxFa3S5cITxh9NlGau0JIL93o4rxh
         wi4U2WYDdJMV5wvJt7qjKCbYVASPo4SpjXr4JMY7SviQeAlDEiEhdR3ZrY9oQnw4QxB/
         RZZrdkvkR5OfnubpOjKtY4tqKJ2sItguWy1X4aqsmpV1rbVCxGMXwXUNcl640svUGJ2C
         HdSEAnfHWGFqhY6HOx9KglDiA8/3jkAs3IzeAK9BfX0+h+20EB5v2zl4sul1uyGC9/1M
         8BZA==
X-Forwarded-Encrypted: i=1; AFNElJ96GvqvkcRu4WBZKtS3LOX4Hrtsx55khlDKgT8Kemcy9VngrTP8PnFnjdriuboJadNnaffksTN567ejnNfhGrlh@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+dGql+CsIEBeUbT0X9JAaREQpL3lqTD5JYq3vTplopNbnhIt2
	H5n+jHSCTtQpU0SOSzODDLPdEvByBSOlXxG/RBez0J0RjUNWEoFRUMzt/Y+qRBsnVjuH03Rdv90
	amaEaBYEirA==
X-Received: from dlkk5.prod.google.com ([2002:a05:7022:6085:b0:135:dc3d:ab61])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b99:b0:128:bae0:e03c
 with SMTP id a92af1059eb24-137d42883b8mr2788021c88.30.1780215794542; Sun, 31
 May 2026 01:23:14 -0700 (PDT)
Date: Sun, 31 May 2026 01:22:34 -0700
In-Reply-To: <20260531082235.940833-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531063736.871777-1-irogers@google.com> <20260531082235.940833-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531082235.940833-15-irogers@google.com>
Subject: [PATCH v4 14/15] perf test: Add shell test to validate JUnit XML
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

