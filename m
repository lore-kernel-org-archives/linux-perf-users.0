Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795743531;
	b=FqjsetYc2CqGIN0xmBgP5r0sx8XJ/paxhlPz+03xJH/w9rfYA7UCCVOHCae5mklD09Lm
	 mqv6hoeCg57i2OxIZdMC6xT43IrLuMhiMautKIMx/u1eqBxrnhSOLXN7/1F3+oqBnypbb
	 SctBzgirYXqpdjUzJCWaqoZXYgy5KJ80cCaLFIxgU0G26yx02i++1cR1WNR79G723al4e
	 WvJPXjc5NkB0aM1F4ZWzsSlAHDh8KM7jd+fjfLeWkK9DJpg20BcqemJAh41+clWYmncxe
	 YXa7BhKpGNFmPTB5bDFlqTNH3G6N0RbCWkaBOKWEXPWV08sL+TaYTixQhcdR84OOuNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795743531;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0S20RyiVa7IMkShGkwbrovioNtHM5z0nVE0rxDZlEnA=;
	b=VU8ZnUEXZIpX/SKryG+mIi9VksJwxtj+pJUvs+N2PRind4DKjpsbr1agetOfmr8I9fpW
	 CzUTnyTXwgAislBubfW4uMDWFobOuHAVAxzm7iLwQPMHPcLyak8IZN7Hb7MTYMvaj2823
	 j+8YipiN+70H23Yrw2pGhZ5BqBVIZjJQXgwTHlhztkX/XbO68AX9oauISJZHQwSJnF9yT
	 /5XXgKafTcQ+Ri0HAJ6FTNHnvzaiovhnNTermAtZSYwyQ4TsCgJcR1LRHKZyxQMhwgOM7
	 F7j+JiWKb54c0AY0t4VqMBVGlh4I5xQcrcjV6PnXwQLQAfjlHIVyOlysR1JiPcbGNHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EbuLTnR9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5B8606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 01:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EbuLTnR9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4131A1F00897;
	Fri, 27 Nov 2026 01:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795743530;
	bh=0S20RyiVa7IMkShGkwbrovioNtHM5z0nVE0rxDZlEnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EbuLTnR9Xl2p44LUSBDy6EfUqGMnuymlU9wpY7gGi8/NvIAgCCrHY9xt7thaSslqN
	 oOa9lM3GuagjSCtTV1XwkNG+uAH886G3zxNTpMxViGk6A0aQ6FJaujUvng6o2tnolY
	 Hxn/kjcJ1N3SpPnaCJqDG3O5Dd2YTj1rHUDNjFxAthjeCkw0rq4lmYvvXssWHyXbt3
	 SBbj3TWyYNZstl+BJO+YJIQugtPSDaEsX0rB3tSUfMykphJv/RYrwXtIh2zMZZ7RQs
	 0fYAc3jjyButogpOfil8glFA3tvGLQp2vUXLSlxPBIZoSoqMCP4Ojlo18LW9os2+pU
	 o2CZwZjkJELLQ==
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
Subject: [PATCH v2 11/18] perf tests record: Exercise more record options
Date: Thu, 26 Nov 2026 22:37:54 -0300
Message-ID: <20261127013801.14841-12-acme@kernel.org>
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

Add the dry-run, no samples, buildid, synthesis, sampling, buffering,
aio, affinity, delay, overwrite, callchain, mmap pages and clockid
variants.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/record_options.sh | 215 +++++++++++++++++++++++
 1 file changed, 215 insertions(+)
 create mode 100755 tools/perf/tests/shell/record_options.sh

diff --git a/tools/perf/tests/shell/record_options.sh b/tools/perf/tests/shell/record_options.sh
new file mode 100755
index 0000000000000000..ccedb1ebc3dad8de
--- /dev/null
+++ b/tools/perf/tests/shell/record_options.sh
@@ -0,0 +1,215 @@
+#!/bin/bash
+# perf record option tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+temp_dir=$(mktemp -d /tmp/__perf_test_record_opts.XXXXXX)
+err=0
+
+# Parallel streaming opens per-CPU data files and pipes; raise the soft
+# fd limit the way record.sh does.
+default_fd_limit=$(ulimit -Sn)
+min_fd_limit=$(($(getconf _NPROCESSORS_ONLN) * 16))
+if [ "${default_fd_limit}" != unlimited ] &&
+   [ "${default_fd_limit}" -lt "${min_fd_limit}" ]; then
+	ulimit -Sn "${min_fd_limit}"
+fi
+
+cleanup() {
+	rm -rf "${temp_dir}"
+
+	trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+	echo "Unexpected signal in ${FUNCNAME[1]}"
+	cleanup
+	exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+test_record() {
+	local desc="$1" out="$2"
+
+	shift 2
+	echo "Record ${desc}"
+	if ! perf record -q -e cpu-clock -c 1 "$@" -o "${temp_dir}/${out}" -- sleep 0.1
+	then
+		echo "Record ${desc} [Failed: perf record failed]"
+		err=1
+		return
+	fi
+	if ! perf report -i "${temp_dir}/${out}" -q 2> /dev/null | grep -q sleep
+	then
+		echo "Record ${desc} [Failed: no samples]"
+		err=1
+		return
+	fi
+	echo "Record ${desc} [Success]"
+}
+
+test_timestamp_filename() {
+	echo "Record timestamp filename"
+	if ! perf record -q -e cpu-clock -c 1 --timestamp-filename \
+			-o "${temp_dir}/tsfn" -- sleep 0.1
+	then
+		echo "Record timestamp filename [Failed: perf record failed]"
+		err=1
+		return
+	fi
+	if ! ls "${temp_dir}/tsfn".* > /dev/null 2>&1
+	then
+		echo "Record timestamp filename [Failed: no timestamped file]"
+		err=1
+		return
+	fi
+	echo "Record timestamp filename [Success]"
+}
+
+test_switch_output() {
+	echo "Record switch output"
+	if ! perf record -q -e cpu-clock -c 1 --switch-output=4K \
+			-o "${temp_dir}/sw" -- sleep 0.2
+	then
+		echo "Record switch output [Failed: perf record failed]"
+		err=1
+		return
+	fi
+	# --switch-output also timestamps the file at exit, so checking for
+	# a sw.<timestamp> file is not enough, there has to be more than one.
+	if [ "$(find "${temp_dir}" -maxdepth 1 -name 'sw.*' | wc -l)" -lt 2 ]
+	then
+		echo "Record switch output [Failed: no switch happened]"
+		err=1
+		return
+	fi
+	echo "Record switch output [Success]"
+}
+
+test_clockid() {
+	echo "Record clockid"
+	if ! perf record -q -e cpu-clock -c 1 -k CLOCK_MONOTONIC \
+			-o "${temp_dir}/clock" -- sleep 0.1
+	then
+		echo "Record clockid [Failed: perf record failed]"
+		err=1
+		return
+	fi
+	if ! perf script -i "${temp_dir}/clock" -F tod 2> /dev/null | \
+			grep -qE '^[0-9]{4}-[0-9]{2}-[0-9]{2}'
+	then
+		echo "Record clockid [Failed: no wall clock timestamps]"
+		err=1
+		return
+	fi
+	echo "Record clockid [Success]"
+}
+
+test_record_option() {
+	local desc="$1"
+
+	shift 1
+	echo "Record option ${desc}"
+	rm -f "${temp_dir}/${desc}.data"
+	if ! perf record -q -e cpu-clock -c 1 "$@" -o "${temp_dir}/${desc}.data" -- sleep 0.1
+	then
+		echo "Record option ${desc} [Failed: perf record failed]"
+		err=1
+		return
+	fi
+	if [ ! -s "${temp_dir}/${desc}.data" ]
+	then
+		echo "Record option ${desc} [Failed: no data recorded]"
+		err=1
+		return
+	fi
+	echo "Record option ${desc} [Success]"
+}
+
+test_dry_run() {
+	echo "Record option dry run"
+	if ! perf record -q -e cpu-clock -c 1 --dry-run \
+			-o "${temp_dir}/dry-run.data" -- sleep 0.1
+	then
+		echo "Record option dry run [Failed: perf record failed]"
+		err=1
+		return
+	fi
+	if [ -e "${temp_dir}/dry-run.data" ]
+	then
+		echo "Record option dry run [Failed: recorded data]"
+		err=1
+		return
+	fi
+	echo "Record option dry run [Success]"
+}
+
+# perf record --threads=numa needs every online NUMA node to have CPUs,
+# a memory-only node (empty cpulist) makes the NUMA topology setup fail,
+# so only run the test when that is the case.
+threads_numa_supported() {
+	local range lo hi n
+
+	[ -r /sys/devices/system/node/online ] || return 1
+
+	local IFS=,
+	for range in $(cat /sys/devices/system/node/online); do
+		lo=${range%%-*}
+		hi=${range##*-}
+		for ((n = lo; n <= hi; n++)); do
+			[ -s "/sys/devices/system/node/node${n}/cpulist" ] || return 1
+		done
+	done
+	return 0
+}
+
+if perf check feature -q aio; then
+	test_record "aio" "aio" --aio=2
+else
+	echo "Record aio [Skipped: no aio support]"
+fi
+test_record "threads core" "threads-core" --threads=core
+test_record "threads package" "threads-package" --threads=package
+if threads_numa_supported; then
+	test_record "threads numa" "threads-numa" --threads=numa
+else
+	echo "Record threads numa [Skipped: no NUMA topology with CPUs]"
+fi
+test_record "affinity" "affinity" --affinity=cpu
+test_record "mmap flush" "mmap-flush" --mmap-flush=1
+test_record "max size" "max-size" --max-size=1M
+test_record "timestamp boundary" "ts-boundary" --timestamp-boundary
+test_record "user callchains" "callchains" --user-callchains --call-graph fp
+test_timestamp_filename
+test_switch_output
+test_clockid
+test_dry_run
+test_record_option no-samples -n
+test_record_option buildid-all --buildid-all
+test_record_option buildid-mmap --buildid-mmap
+test_record_option synth-no --synth no
+test_record_option synth-task --synth task
+test_record_option synth-mmap --synth mmap
+test_record_option sample-cpu --sample-cpu
+test_record_option weight -W
+test_record_option raw-samples -R
+test_record_option no-buffering --no-buffering
+test_record_option no-bpf-event --no-bpf-event
+test_record_option proc-map-timeout --proc-map-timeout 100
+test_record_option num-thread-synthesize --num-thread-synthesize 1
+if perf check feature -q aio; then
+	test_record_option aio-one --aio=1
+else
+	echo "Record option aio-one [Skipped: no aio support]"
+fi
+test_record_option affinity-node --affinity=node
+test_record_option delay -D 10
+test_record_option tail-synthesize --tail-synthesize
+test_record_option overwrite --overwrite
+test_record_option data -d
+test_record_option mmap-pages -m 4,8
+test_record_option clockid-monotonic-raw -k CLOCK_MONOTONIC_RAW
+
+cleanup
+exit $err
-- 
2.56.0

