Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8860631D74B
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 05:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780205297; cv=none; b=cVwcr6SDiTlk8ST5Cg9ujDojup61Z0gnEV148cUhGXTlaaAvz+J8qGZ+7K164b0jSzzbKiNa9fL1BWEJ2ufHEegQtJ7lTX/sCIWT6mFd60EYbbQFisNrwVahx71ReQJBhgC3WybbTQsm3AHbtWb+HucRfuC3r3HDOE34jO84QBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780205297; c=relaxed/simple;
	bh=fceYlMYPSFIBhgKdtj2vldQcRO1z7pGUGyHIbbbwZFg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KweZspuEGe62QLgL6f1E/cyy135ovzLB5IB3Y3GdfO7AOWnxZGFOpNqxd05IFy4F5NAym/4x5AhBmIegRL29nda4dP4i95mAMV1LOXlqLumcLU+AH2EvCevSPnZpbivF5v67cANtEyohUYO7G4QtSj5zf7PBx2z/CT7LexPI+bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qKsk3/dO; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qKsk3/dO"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-13709ab38a8so8398242c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 22:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780205292; x=1780810092; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5fWSS6pmKaXR3mc2oxOogwkg8pn144sIhxDOKYQ4GWI=;
        b=qKsk3/dO+2nt3badMwXXMfU3lQVEztT3pfgBuuucomg3fS1yp/G3+x2lcxEHJbPY0D
         5Y5S5sSbRiUIwxroqz/w2mCi0l2M5fZAUzLHRqBv+5/PRl8sPnPkFeCwQhy4nkN63OpS
         rwZkVv5tMEdsFW2jbsXXpo90WFCT8/xEJk5sLOr7IwSWJhife+BYbdg80LNbZdlZpnKE
         lDxOS+0CXCiJWaBkYhdLnKBgk738M2JGVPL1rnCCaeOKerN7/8CZkfkRLdN8H7ULPbNP
         IQumBb9XlSblslt2/9q+UhmNLPD4tCPf0nIM6BQkfKvkbY6su82/Z+rYfhg1lKzNYHZO
         ef0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780205292; x=1780810092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5fWSS6pmKaXR3mc2oxOogwkg8pn144sIhxDOKYQ4GWI=;
        b=AwImiX+M+hMlWF2nWT/uK6tDE3cNp5ps3CDkWink3aAQM9yu33ICj7rXYZLm+HfpaB
         /5v/R9xkiSRPhgvx2Bb46axZdrDs0uJPD+yMyjIxAapktSVM6Ya9hegzJQQUrR+7jfq3
         8DRb7+BUOwfJn5FOywCBcJFvPj151FChx2hh5q0g98X4kmtdGEq2UP8x46pvav8bJx4a
         aNTPbQ3qjsa7/4t8J4NmuA5AMrcW8FokS/e2JJAfnaQ+oNotNv+ygnxN9FQloD+Kl1Dr
         1K0dzyWaxsim8CvOyMzJhF+OwJfQAJqNEpLmm8M7gCsepcVGzVrzOY4sLnCQhpgpUqU2
         /0pg==
X-Forwarded-Encrypted: i=1; AFNElJ//nCtJtwE8EFKCGpKzZ6PBTjY+eAXp38qWilhoegOqQ0FL0mUYPv3kWx5S5vP0z6SuV38yAGVGuUNU6ohze3Ln@vger.kernel.org
X-Gm-Message-State: AOJu0YySRqYUbCbWbZzueYRAjM+dqEWNzeHNAqz1qMq5Gn7hN3Defl+w
	72lzBkvnXxmsD+1chgOD80TIOvbNJyadDlSIJIZyVavAK/5nD+M4vTh04JzPlBcxK/MvXJeuG/Y
	nkjUCi/K6Gg==
X-Received: from dlbur19.prod.google.com ([2002:a05:7022:ea53:b0:135:518f:e3b9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:fa0b:b0:11a:342e:8a98
 with SMTP id a92af1059eb24-137d39c9db0mr2046710c88.0.1780205291546; Sat, 30
 May 2026 22:28:11 -0700 (PDT)
Date: Sat, 30 May 2026 22:27:39 -0700
In-Reply-To: <20260531052740.796087-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513230450.529380-1-irogers@google.com> <20260531052740.796087-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531052740.796087-14-irogers@google.com>
Subject: [PATCH v2 13/14] perf test: Add shell test to validate JUnit XML
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

