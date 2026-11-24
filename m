Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795545989;
	b=ia+qdWvl/0Kq0lQVLAYJvZTMvOoMaUSV4+KHYYm6PQfjb04wFt+bsFpUsNaJKZJs6hNU
	 rJDczPsArcdeUqp6PyPA+XImUDoPyYqCHjaSaYBloE+cVMJhwKWa4Ckou04lsv5ooclU4
	 tFhFj8fQzHBqpr6oNOhdq00tct3LFMqjaLSMy3nL0nN5mSiwyIAQ9rFUEBh5LRQI+KCnb
	 OCmx/lQDqJZUQesbbsxA+Y2PHOvhzHrxI7y5+BPykbFSPoLsoI0D1dItEWWzHfK/p5tta
	 Cp7cgMKj1V3Ddp2w07VrXkSLonwfMXSOGMouWFPIlIs6fttLQJQw2cuABqeg++vS5Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795545989;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=q32ZEjmAhbYGRnxvPoGOlTyZFe+mKK/CAqGk+Zvy/mI=;
	b=P1xOkzD4EhxQTwL1Otht+hxRydhVE7PDfTyUZimX0fFL291OqUS5FHXYZx5xoBzUEl3R
	 KdJqeN6JZusLHnll90fWXwtzankHfW5E3P6ZgjoGzNEZLXxRwl0fVNoAw6c1ryb68JusD
	 JPIwZOs6c7mBdnm2EUpnTda6CBoOz+Epwz9tbTlchU5clu7QGgEHn8ZrSX8ExpDEOA986
	 7Ytyr9fggrgoIzwrFBAuTwC28IA8jaOpR03jzFf++nY7fJseU/H5suxKZCUiJVvYtZ7EV
	 /kRUKYzMUZQSB4EDfGoX3hx0mmBUGAD0z1WIq9uSz90KxCY52ipPk2DeusGd0SXI7CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WdTnlLMV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2FA606A32C;
	Tue, 24 Nov 2026 18:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WdTnlLMV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCD51F000ED;
	Tue, 24 Nov 2026 18:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795545989;
	bh=q32ZEjmAhbYGRnxvPoGOlTyZFe+mKK/CAqGk+Zvy/mI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WdTnlLMVYv+zwBVeivVtn+DOeTeNzT2eXcruxYwFsVG79gX9POCHVoa7+CePF02Nc
	 iqhKHCLxiFhyKwiM9bwy5nrLXStBmQQ7YsmYrMmgJyK8WqiWuWjlKgnKwLBV2BA5fS
	 e5vmEFuDyYuJScRXTW7BKMPPA1HJsElcwva1t4OLB8sFv9KWc0Y1trFz/21LDG9n3U
	 a9CSDOTbjvHWJ9/dm4Kab81ru3tAHSRPC1meYLbsvpmhFYi+xIgciKejIIzTxHytlq
	 gLbymi6noBO7QBZABFsoAcRrPSl4yj62eqWTBIYfLlkI0ViB/Nh2pVQZGaNpLrUMMP
	 xk5++MV1OVAZg==
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
Subject: [PATCH v1 05/17] perf tests script: Exercise the list, fields and dump options
Date: Tue, 24 Nov 2026 15:45:52 -0300
Message-ID: <20261124184604.24983-6-acme@kernel.org>
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

The script test only runs the parallel-perf script.  Cover the script
list, a wide -F field set and the +field/-field syntax, per-event dumps,
the data file header, the task and mmap event display and the reltime,
deltatime, show-info, latency, ns and raw dump options.

The list is read from the scripts dir in the perf exec path, which in a
build tree points at a prefix that was never installed, so point
PERF_EXEC_PATH at the source tree when it is unset.  A missing python3
or parallel-perf.py is a skip only when nothing failed above, otherwise
the exit status hides the failure behind an exit 2, which perf test
reports as skipped.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/script.sh | 131 ++++++++++++++++++++++++++++++-
 1 file changed, 129 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/script.sh b/tools/perf/tests/shell/script.sh
index af687c7cfe44c2c6..a74d45d51ae47cb1 100755
--- a/tools/perf/tests/shell/script.sh
+++ b/tools/perf/tests/shell/script.sh
@@ -4,6 +4,22 @@
 
 set -e
 
+shelldir=$(dirname "$0")
+# shellcheck source=lib/perf_has_symbol.sh
+. "${shelldir}"/lib/perf_has_symbol.sh
+
+# perf script -l reads the scripts directory from the perf exec path,
+# which in a build tree points at a prefix that is not installed
+if [ -z "${PERF_EXEC_PATH}" ] && [ -d "${shelldir}"/../../python ]; then
+	PERF_EXEC_PATH=$(cd "${shelldir}"/../.. && pwd)
+	export PERF_EXEC_PATH
+fi
+
+testprog="perf test -w thloop"
+testsym="test_loop"
+
+skip_test_missing_symbol "${testsym}"
+
 temp_dir=$(mktemp -d /tmp/perf-test-script.XXXXXXXXXX)
 
 err=0
@@ -27,18 +43,123 @@ trap_cleanup()
 
 trap trap_cleanup EXIT TERM INT
 
+script_data="${temp_dir}/script-perf.data"
+
+test_script_list()
+{
+	echo "perf script list test"
+	if ! perf script -l | grep -q "List of available scripts"
+	then
+		echo "perf script list test [Failed missing list header]"
+		err=1
+		return
+	fi
+	if ! perf script -l | grep -q "export-to-sqlite"
+	then
+		echo "perf script list test [Failed missing export-to-sqlite]"
+		err=1
+	fi
+}
+
+test_script_fields()
+{
+	echo "perf script fields test"
+	perf record -o "${script_data}" -e cpu-clock --sample-cpu ${testprog}
+	if ! perf script -i "${script_data}" -F comm,tid,pid,time,cpu,event,ip,sym,dso,dsoff,symoff,period,machine_pid,vcpu,ipc,insn,insnlen,disasm,misc,metric,synth,callindent,flags | grep -q "${testsym}"
+	then
+		echo "perf script fields test [Failed missing ${testsym}]"
+		err=1
+		return
+	fi
+	if ! perf script -i "${script_data}" -F +cpu | grep -q "${testsym}"
+	then
+		echo "perf script fields test [Failed to add the cpu field]"
+		err=1
+	fi
+	if ! perf script -i "${script_data}" -F -comm | grep -q "${testsym}"
+	then
+		echo "perf script fields test [Failed to remove the comm field]"
+		err=1
+	fi
+}
+
+test_script_per_event_dump()
+{
+	echo "perf script per-event dump test"
+	if ! perf script -i "${script_data}" --per-event-dump > /dev/null
+	then
+		echo "perf script per-event dump test [Failed to write the dumps]"
+		err=1
+		return
+	fi
+	if ! grep -q "${testsym}" "${script_data}".*.dump
+	then
+		echo "perf script per-event dump test [Failed missing ${testsym}]"
+		err=1
+	fi
+}
+
+test_script_header()
+{
+	echo "perf script header test"
+	if ! perf script -i "${script_data}" --header | grep -q "captured on"
+	then
+		echo "perf script header test [Failed missing the header]"
+		err=1
+		return
+	fi
+	if ! perf script -i "${script_data}" --header-only | grep -q "captured on"
+	then
+		echo "perf script header test [Failed missing the header only output]"
+		err=1
+	fi
+}
+
+test_script_events()
+{
+	echo "perf script events test"
+	if ! perf script -i "${script_data}" --show-task-events --show-mmap-events | grep -q "PERF_RECORD_"
+	then
+		echo "perf script events test [Failed missing the events]"
+		err=1
+	fi
+}
+
+test_script_misc()
+{
+	echo "perf script misc options test"
+	for opt in --reltime --deltatime -I -L --ns
+	do
+		if ! perf script -i "${script_data}" ${opt} | grep -q "${testsym}"
+		then
+			echo "perf script misc options test [Failed ${opt}]"
+			err=1
+		fi
+	done
+	if ! perf script -i "${script_data}" -D | grep -q "PERF_RECORD_SAMPLE"
+	then
+		echo "perf script misc options test [Failed --dump-raw-trace]"
+		err=1
+	fi
+}
+
 test_parallel_perf()
 {
 	echo "parallel-perf test"
 	if ! python3 --version >/dev/null 2>&1 ; then
 		echo "SKIP: no python3"
-		err=2
+		# Don't turn a failure in the tests above into a skip
+		if [ ${err} -eq 0 ]; then
+			err=2
+		fi
 		return
 	fi
 	pp=$(dirname "$0")/../../python/parallel-perf.py
 	if [ ! -f "${pp}" ] ; then
 		echo "SKIP: parallel-perf.py script not found "
-		err=2
+		if [ ${err} -eq 0 ]; then
+			err=2
+		fi
 		return
 	fi
 	perf_data="${temp_dir}/pp-perf.data"
@@ -50,6 +171,12 @@ test_parallel_perf()
 	echo "parallel-perf test [Success]"
 }
 
+test_script_list
+test_script_fields
+test_script_per_event_dump
+test_script_header
+test_script_events
+test_script_misc
 test_parallel_perf
 
 cleanup
-- 
2.56.0

