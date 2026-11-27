Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795743537;
	b=qo5Yp3C7u0XN+F4bBiCa1or30N/LVB88Nu+XFUKGOZw1gViJ8Mhwg4R0p0lJooLqLJde
	 jRMUzqzYHiwm2xBFKZaibGxu03WPqFxU4DW4mWVltCSsnatK8riZ2En8R5yIv+4G3HwQu
	 ZnByFiMHF7ijsLzClCme0F1thOMKE7VSFhxCp7qq8kF4F4g6Jd6F29NR7ZF5LiCCX5uaJ
	 BZ0vK+5u69FemYxC2XxHV9ojraXcRHOdJkYra3aNyD4/ce79GAgUHI4KiSsu0r1Fu4XeU
	 XGDTPjFj5ygMDX+ns4BWg+Uu7OYvvpM4iGlzPDfpHBmkCnAoB1difw+Q8uR6/3bjTUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795743537;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=g/TBK80yUbD4foEex18EOrXvxR5DjUVSSFLkBoVPaQs=;
	b=VJTAPnnaZNfQP151t8WsyZuyCQhd/1qq2DomIIhwZQd7Oiyjb6svqx2unq4N9GkzINJR
	 jerKlX3DJXD6OWBs+j8zNcQoWFIkZ0ZxVcolS2WhvaKfcl1l9T8xriHRkXlNOhg4bCjvi
	 ubucAzz5sV+/hRne/K/hkuK+Z58w0nEn5cbJNm6bigKEixfGuh3cSbwPGjlg08G0TaQWI
	 K37CUuMXP/wqLC/yWoCAPSCXTzJfQyChkMUwsnQEhHhapf6beE8txxWOqizWHxzehhsx7
	 niZzHk3NW+i0rM6o/sY7yXUznd93xSlg2btR8f9p52J3QYEwqnt3NqW7B4S0Z8VOyjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M8iwU4gF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A05606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 01:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M8iwU4gF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98361F00893;
	Fri, 27 Nov 2026 01:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795743537;
	bh=g/TBK80yUbD4foEex18EOrXvxR5DjUVSSFLkBoVPaQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M8iwU4gFZCtxshNhhiDyamJHGtmlvcSY/2XjxwZ6m/nJSVr8geYB+R+0N9liwMGL/
	 bipJArCqgxaUw8WMz9UC2VxqvYZgao4jLAnZpCrSqgQKU+lqAeS0TlYjytx+FAwR63
	 9gG8VmBfOOW1uDwUvUW8LiFD4+V5Tq63Pba1rn+c36wwEioW637cwIIGocd2RDyUJs
	 kLaC1s8gFbnLeItHQhUvxsDhbwmnysFgVvBf+c5pFhPB6qdvDjzUFCGl7GJTcfGHW0
	 DADQNcsVZ152hT30UY5YxrVOMZubWAj49nc0AB0GOn88NoLwXME/X/Nx1tZFpfGxBG
	 hQLXmcQJw7PSw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2 13/18] perf tests timechart: Exercise the report options
Date: Thu, 26 Nov 2026 22:37:56 -0300
Message-ID: <20261127013801.14841-14-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127013801.14841-1-acme@kernel.org>
References: <20261127013801.14841-1-acme@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Run the report with width, process count, topology, highlight,
process, power and tasks only, io and force options.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/timechart.sh | 46 +++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/perf/tests/shell/timechart.sh b/tools/perf/tests/shell/timechart.sh
index 40072b32171a9a1c..c55ddc5f923b2bcc 100755
--- a/tools/perf/tests/shell/timechart.sh
+++ b/tools/perf/tests/shell/timechart.sh
@@ -59,6 +59,33 @@ test_timechart() {
 	echo "perf timechart ${NAME} test [Success]"
 }
 
+test_timechart_report_option() {
+	NAME=$1
+
+	shift 1
+	echo "perf timechart report ${NAME} test"
+
+	if ! perf timechart -i "${perfdata}" -o "${output}" "$@" > /dev/null 2>&1; then
+		echo "perf timechart report ${NAME} test [Failed: perf timechart command failed]"
+		err=1
+		return
+	fi
+
+	if [ ! -s "${output}" ]; then
+		echo "perf timechart report ${NAME} test [Failed: output file is empty or missing]"
+		err=1
+		return
+	fi
+
+	if ! grep -q "svg" "${output}"; then
+		echo "perf timechart report ${NAME} test [Failed: output doesn't look like SVG]"
+		err=1
+		return
+	fi
+
+	echo "perf timechart report ${NAME} test [Success]"
+}
+
 if ! perf check feature -q libtraceevent ; then
 	echo "perf timechart is not supported. Skip."
         cleanup
@@ -69,5 +96,24 @@ test_timechart "Basic" ""
 test_timechart "IO-only" "-I"
 test_timechart "Backtrace" "-g"
 
+if [ ! -s "${perfdata}" ]; then
+	echo "perf timechart report options [Skipped: no recorded data]"
+	cleanup
+	exit 2
+fi
+
+# Reuse the data recorded by the last test to exercise the report options.
+test_timechart_report_option "width" -w 1024
+test_timechart_report_option "proc-num" -n 4
+test_timechart_report_option "topology" -t
+test_timechart_report_option "highlight time" --highlight 1
+test_timechart_report_option "highlight name" --highlight true
+test_timechart_report_option "process" -p true
+test_timechart_report_option "power-only" -P
+test_timechart_report_option "tasks-only" -T
+test_timechart_report_option "io options" --io-min-time 1us \
+	--io-merge-dist 1us --io-skip-eagain
+test_timechart_report_option "force" -f
+
 cleanup
 exit $err
-- 
2.56.0

