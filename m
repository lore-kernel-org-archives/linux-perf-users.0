Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546007;
	b=a1YPCguOkYMxY1SweSfnSd+s8QgBFkN7xUoA3Rw0Zdt0sMbN9bI8fsfiQO5Wms7OG9fc
	 JStqpin5OMl0tFramuVbF1znzSxQf1oACwWYgG6Gn1LXfrt1FzpI5IObmT2Cau8ta7PEp
	 6B6bQBe8f6lzO9llpwFEhFi79TQ59mRQJamqXKz5YX948+EcpUPAafAEzLS0ww+3N5ve3
	 LeCAfk+TGc2/4p9m/YE17pMx8VobcaLcaMVgqNJ8RSuW0luj87bTm/02K8Wnpv6i6nqI+
	 OvNSAv9SKuvbQV7IyTcpnLwx4eZeUfJ3qnCddKySkQrcV3p7cP9+WqsQvV6JOaMydPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546007;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Y07rvnXpl5j3vciZDLLjUOj8Z9XllNvNVJk0T21hQrs=;
	b=vrcpHYiqNndB+XQcOcsG0CtkznGKFCiiFCFkbSJGdfzX8oZYg8g+7MhhSUcTK7OXx+lz
	 DAn0XW1aJzyTaK4CcqDSRmxJG85DpFr0/nyp9K74spxdHwW/mafqWTIC/pKQqIYxO2Jpa
	 eIk1NIvPOMJm1OkKflTuPveB50mT7VlsMByIakRCurkvMuergGQP8+Z3U2hMm1uarG0x/
	 P4J+mg71n7ZknUxjiRjW5hcBFbKMbvsUIBj5KZ+KsoAymRT0huYxEzi7ybWhOenKm4jvc
	 /yO4X69ZY8EYI8B0FWXd7V4wG6RKa5Lv679/qWEb9crRtIoILP1Ne2xwuTN7N67vU4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lUHgi3hv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E973606A31E;
	Tue, 24 Nov 2026 18:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lUHgi3hv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490841F000C0;
	Tue, 24 Nov 2026 18:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795546006;
	bh=Y07rvnXpl5j3vciZDLLjUOj8Z9XllNvNVJk0T21hQrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lUHgi3hvcPe5B8uyleVxJ0w4R+b1jWIM9tecVkqPSrBAicgyEn1m7CTH/N12QfCdX
	 8btDasuBCEmcWwGDsJsG2GOPio0BbV6Y1dSoFmWz3GAKTSOI4ulCXZhN4+z0qwb+1T
	 6toNgaLWMY0PRpkrOfoweLNz4qFXRIkjjKnK3dqZqHvY5efB5+smKm2VxkQluggBnG
	 x5r9jm5AaIaghDhNg3EnXceZL7cdkfPcIJLNwWe1hdHIG3MBRZBxBgX1SIbMmRtoHJ
	 uPQTnxC1TNqWSuAHk9M/mM6zznCDawGzgX/kCutKGKh9A7/v+XbJF8255ivZ9yFN9X
	 vfhoO22dT1j9w==
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
Subject: [PATCH v1 10/17] perf tests record: Exercise more record options
Date: Tue, 24 Nov 2026 15:45:57 -0300
Message-ID: <20261124184604.24983-11-acme@kernel.org>
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

Add the dry-run, no samples, buildid, synthesis, sampling, buffering,
aio, affinity, delay, overwrite, callchain, mmap pages and clockid
variants.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/record_options.sh | 173 +++++++++++++++++++++++
 1 file changed, 173 insertions(+)
 create mode 100755 tools/perf/tests/shell/record_options.sh

diff --git a/tools/perf/tests/shell/record_options.sh b/tools/perf/tests/shell/record_options.sh
new file mode 100755
index 0000000000000000..b2bf51b5dc44c189
--- /dev/null
+++ b/tools/perf/tests/shell/record_options.sh
@@ -0,0 +1,173 @@
+#!/bin/bash
+# perf record option tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+temp_dir=$(mktemp -d /tmp/__perf_test_record_opts.XXXXXX)
+err=0
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
+	if ! perf record -q -e cpu-clock -c 1 --switch-output=size=64K \
+			-o "${temp_dir}/sw" -- sleep 0.2
+	then
+		echo "Record switch output [Failed: perf record failed]"
+		err=1
+		return
+	fi
+	if ! ls "${temp_dir}/sw".* > /dev/null 2>&1
+	then
+		echo "Record switch output [Failed: no switched files]"
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
+test_record "aio" "aio" --aio=2
+test_record "threads core" "threads-core" --threads=core
+test_record "threads package" "threads-package" --threads=package
+test_record "threads numa" "threads-numa" --threads=numa
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
+test_record_option aio-one --aio=1
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

