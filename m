Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="csTA5Sv8"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131111709
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Dec 2023 09:41:03 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db54a19c7d6so1434983276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Dec 2023 09:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701970862; x=1702575662; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=niYg5A4Vl8wxZvl0dW0Aqla8QlNk079TUHdjvbyyS3A=;
        b=csTA5Sv80llF1L+RpndLQs6eQOSGNQQAPW/I60QLdwD7sxMVJ57OpaGkJkWUR6yroI
         2qRXjppG1hB/F54bppq/sZKLXEjpDPEjdmA00Ckl5S6dVjs8FOn6+Lb5OrS2SkkUruhE
         GbaXCeM5gyG/pwDWTw95hLKGx7ga5dJLApG/Vbpp3uFXmD7AlHY4aK0gdVxkbyeGuPAH
         /M0FJOHhzg8bK/dHVJgiw1l60I0snKbGAiDuWKBksoUwQugdoh7kJ9FAzRIbNzWCATAO
         JCszczlpqqq1dHOCir6p6t2xz/KQbi36ZgfkvgN5XeP5yshjJ1/UUiiXfu/0k3QcIpxH
         26tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701970862; x=1702575662;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=niYg5A4Vl8wxZvl0dW0Aqla8QlNk079TUHdjvbyyS3A=;
        b=jb+e5aX7RBsftCibK6aNeBL3hgc1MiDbRSi9Jt8nvoOEOTSeH/bFl0mee2phWZd6Xd
         UH3hSlrmdxpr2+tEdZKuCzZOE12pwjzTAp0GjxwXbvgAMxpYgOwizYYzlpI2a7vf8jXe
         otryu3NRKjeEu62ZfgD0IqdJLU9V71zRo+YiGUUCWVncBRJCp9gxw7sDiw3U7MpoFAEx
         7eKRas0IIikBAar5cZyi7/pgbRlCiu7HrVZlt3ANX+aEhV6tzxQxbL7tzy8C0wzXaIE2
         QS9TlM5R3UjlfqCju7QgYivfmI4JkBfoe6MqBovUvHIGTjRExgYfwd1akI9qKtiw0Lhi
         jnBA==
X-Gm-Message-State: AOJu0YxFE/s7ziioWmwhBrpIv9i1+1tPMqLe7zQXjru0O64pgtWLMLZU
	HgA9JpRxk3SMjuCDu8Z2QmilcgImnd2C
X-Google-Smtp-Source: AGHT+IG1uUHscqr78fzFiaNu9Xova/+Jee3jNfzWA/gZC7ueT8il/DECGiuPKk9ckx8PFtV46AStdGhgQHLV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a25:df06:0:b0:d9a:520f:1988 with SMTP id
 w6-20020a25df06000000b00d9a520f1988mr35484ybg.4.1701970862296; Thu, 07 Dec
 2023 09:41:02 -0800 (PST)
Date: Thu,  7 Dec 2023 09:40:57 -0800
Message-Id: <20231207174057.1482161-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v1] perf tests: Add perf script test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Ben Gainey <ben.gainey@arm.com>
Content-Type: text/plain; charset="UTF-8"

Start a new set of shell tests for testing perf script. The initial
contribution is checking that some perf db-export functionality works
as reported in this regression by Ben Gainey <ben.gainey@arm.com>:
https://lore.kernel.org/lkml/20231207140911.3240408-1-ben.gainey@arm.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/script.sh | 66 ++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100755 tools/perf/tests/shell/script.sh

diff --git a/tools/perf/tests/shell/script.sh b/tools/perf/tests/shell/script.sh
new file mode 100755
index 000000000000..5ae7bd0031a8
--- /dev/null
+++ b/tools/perf/tests/shell/script.sh
@@ -0,0 +1,66 @@
+#!/bin/sh
+# perf script tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+temp_dir=$(mktemp -d /tmp/perf-test-script.XXXXXXXXXX)
+
+perfdatafile="${temp_dir}/perf.data"
+db_test="${temp_dir}/db_test.py"
+
+err=0
+
+cleanup()
+{
+	trap - EXIT TERM INT
+	sane=$(echo "${temp_dir}" | cut -b 1-21)
+	if [ "${sane}" = "/tmp/perf-test-script" ] ; then
+		echo "--- Cleaning up ---"
+		rm -f "${temp_dir}/"*
+		rmdir "${temp_dir}"
+	fi
+}
+
+trap_cleanup()
+{
+	cleanup
+	exit 1
+}
+
+trap trap_cleanup EXIT TERM INT
+
+
+test_db()
+{
+	echo "DB test"
+
+	# Check if python script is supported
+	libpython=$(perf version --build-options | grep python | grep -cv OFF)
+	if [ "${libpython}" != "1" ] ; then
+		echo "SKIP: python scripting is not supported"
+		err=2
+		return
+	fi
+
+	cat << "_end_of_file_" > "${db_test}"
+perf_db_export_mode = True
+perf_db_export_calls = False
+perf_db_export_callchains = True
+
+def sample_table(*args):
+    print(f'sample_table({args})')
+
+def call_path_table(*args):
+    print(f'call_path_table({args}')
+_end_of_file_
+	perf record -g -o "${perfdatafile}" true
+	perf script -i "${perfdatafile}" -s "${db_test}"
+	echo "DB test [Success]"
+}
+
+test_db
+
+cleanup
+
+exit $err
-- 
2.43.0.rc2.451.g8631bc7472-goog

