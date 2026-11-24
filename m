Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546014;
	b=viZw79mjaTN3Bn4eI98USC/fjAtNTsgaaUG83UeMkK9O76jiy3gEssCHrWKlTNgyDEJf
	 lk91Z3jjGdwghv8lpv85aS05LH8ko7jTVYX/bXz+HdCIBwCz/0KfYXrpvGjaa0LwTRZw3
	 DnuDN2cNsYUvcIdHrCt0EtLMEHwK0YzolITgGxRCf03D44RAUdsUxOzyqiQF6V+PX8JA8
	 6Pn212Ok+bldXu44WEWbbKavPf/1bcXIZnXcuuvQOpbswE3pBibSbHuaD7rhL2SZnnh/e
	 vfF2ZmUyQj5vpKBUBG12vxd20AVO4sbTUCeCIc0wGh2bEz6MNPeqWpsGh3GxY4prpYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546014;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QvyEdwrAMP2lCmFAfksJVVycTqwR35YTVP+wei2fX2c=;
	b=srT6BDZg/8ja/H/gtFVihkdPhUyv7pFFN2HDKoDoBHRajymqW1oRO2AJui1NgO0WcJ3g
	 J5+c0wj7eRxlwRD8QtA/b8Y0Nf8Ah4PiV2kSahNDE+nSCk0QTd1WNPsznKpDO6yN0GPgY
	 CyoaX9jy6ji3b3pmKN05e83LiC+BsnehJ8GO4mPYfaAqlMtMrMWPuseXS+B2PMcmFDn61
	 Zjl2BfQwdLuYPMURFQGMjdNu5n1YWRVvx9wuQTZkagro048t1OrLbwzpRPDVJkJmQsv6o
	 lmrpWH3emi9gBZPfjkKUgqMVPqri05M103lxsI4lOXNqcky8Ev3ePbwyTQrnhnh3dEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GpjXgwyB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4840A606A323;
	Tue, 24 Nov 2026 18:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GpjXgwyB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611771F000C0;
	Tue, 24 Nov 2026 18:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795546014;
	bh=QvyEdwrAMP2lCmFAfksJVVycTqwR35YTVP+wei2fX2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GpjXgwyBaGQkN1al9qReUlgsvB8nidvkYun232dZBuzqqotdmShI7H3M6AQruGOFx
	 fm3qmNOatlcvgOzxJ9I2LNzir1Ux8IcZJsz5mWMODTQp51/reYiEXF06hM1S4VswqX
	 rrpM3oAmJ2PPFbiq28QSug8BaGFKW4QMd5FWElOOO/vuZJnkJY6BgY2+4Og084/Kc+
	 c1/jaSC/K7y+9j2JTLv2Mxlp7NBjRDfN7qHFFr6jRJZvv06HW++27mfNMVmNyBduoU
	 5co34ww+jhYZxct7O9mbb2eAXlZ8FOWacJcADnrq4rqa/Ox4wIOihUhp2mC+P9FV+/
	 wJHbA5H/8GhSg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v1 12/17] perf tests timechart: Exercise the report options
Date: Tue, 24 Nov 2026 15:45:59 -0300
Message-ID: <20261124184604.24983-13-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124184604.24983-1-acme@kernel.org>
References: <20261124184604.24983-1-acme@kernel.org>
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
index 40072b32171a9a1c..ec592e304cdedfd8 100755
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
+	exit 0
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

