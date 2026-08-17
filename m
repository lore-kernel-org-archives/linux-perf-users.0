Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A173B19BB;
	Mon, 17 Aug 2026 22:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005378; cv=none; b=W50NWqXLgJPKOuOszagysbbQL6eA3yA81mFrBby4aQJwIInP9KdXV+ZsxsDU2cXbr7dZZ0Cr9dnTmT4P08iYUWANj+qdTJ9GZhWAGceAwfm6XZipk3hhv3GlGz1J0fAca9m1lqeQsJalmAtJi7/Wjt69yfZY2jmyMZY+3H/pfGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005378; c=relaxed/simple;
	bh=dBCfeQZBa11O4UvynjicwCswiTlthDg2IgJwrrlhHvc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0Yg+TcykDnPdmcUP2K000lq28kI2pGlsyYb/vUFPo9U6JyB2+ErbA/1WK6WvK1k07g8Zge/1uvO+ho7K7vWpbK7bDDqB1q59CeQ6JNWNL5G0kkq/JW17iEtFw57oR2+aHeMdOLPQ1BZ/rbJE60VRL5MlXq06/u3Are87tG+2xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=Vh0qPpC2; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="Vh0qPpC2"
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HLu3G81320479;
	Mon, 17 Aug 2026 15:22:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=CEPjQbeHraEvvO7RyMYKmDUudDYiUErL/oqHK
	Us7XhE=; b=Vh0qPpC26XbiBc0He4qmxZcKgEVc0N9kYYpMM1vF42978rlIaHY/4
	9dwLxkuXJuSn1yy6vP7Y/0Bn477X+LNDtqqO6N5Gpbj61gRSJ1ncPqE4N9cuN3CY
	WnvdeXAbhKLzGtJWTaoY/sUq0EYzLNUzDYil5fAmTOW5AjOCtZTXxs+jV1FpMLzp
	7Y2vR+ybyEi/mo4YM4nrO4DTaewtHaW4GsN4VU8mM9b+i8qg8NGFSnUUoqsIK4Oy
	+tPvRln+UbdN7XNGL1RLAna0NceqNZnxubumRN/r/BRmBUAJe79kLvoQO43Z0689
	7Zt47Ns11WPiWn+Be9IZLLolqzmHwegkA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4g39pf917t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 17 Aug 2026 15:22:25 -0700 (PDT)
Received: from localhost (2620:10d:c085:108::4) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.45; Mon, 17 Aug
 2026 22:22:24 +0000
From: Amir Ayupov <aaupov@fb.com>
To: <linux-perf-users@vger.kernel.org>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Suzuki K Poulose
	<suzuki.poulose@arm.com>,
        James Clark <james.clark@linaro.org>, Leo Yan
	<leo.yan@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim
	<namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander
 Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>
CC: <linux-doc@vger.kernel.org>, Mike Leach <mike.leach@arm.com>,
        Jonathan
 Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Swapnil
 Sapkal <swapnil.sapkal@amd.com>
Subject: [PATCH v2 4/5] perf test cs-etm: Test branch history on existing samples
Date: Mon, 17 Aug 2026 15:22:19 -0700
Message-ID: <70f7ccb31e81282212161177124dfc3beff24ad9.1787005265.git.aaupov@fb.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787005265.git.aaupov@fb.com>
References: <cover.1787005265.git.aaupov@fb.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE3MSBTYWx0ZWRfX/Ut4PHI0G7mK
 o7YrZpranXT0g301dJ2B3dG2OhYPv3ELk/Wmezvlco92FwfaRI4pL04kHsPkiSm23vJQ7aLB8dG
 CPi2fHf4vOJAIkh6QXpNnkJ8i9LdGXM=
X-Proofpoint-ORIG-GUID: 48iyRBJdgeKZr5VO2k5a1rQMVwSoklZ-
X-Proofpoint-GUID: 48iyRBJdgeKZr5VO2k5a1rQMVwSoklZ-
X-Authority-Analysis: v=2.4 cv=BvutB4X5 c=1 sm=1 tr=0 ts=6a8389a1 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=jCddH8ec0KUNCymVuxII:22 a=FOH2dFAWAAAA:8 a=MPi_nEwP9nz4_j2txOQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE3MSBTYWx0ZWRfX5OZoNH1bNnXK
 +PvgjdxrGVkhh3iyCERW1wInw9UqbbO3ZCE/poEKHe1Yit2UjXkiWiQbjrKBxc5fco1rDW1nCd9
 YAVFH0Opg2CnjFT8+t0ZnM3Hd8BcZfBpxdsObBL9lwR6iQwsJPDn8F6x6kSnFMQnlw3JthRNj3H
 wb/oN2zRMlARnjlX3YlXf34czJVM8Dz8aXyFLgwG4q7rpLeW6eFQiF34EP3aWmXkJep/J/aZHw5
 KzOWVkYpVAi5rukdLue/HL240OZx3aQEVqPTIpBXwgFJF/D+SiNpXSNiw+0iIuVQ3gNwuGoxESz
 ANSQy9HN4VJtRsTdOmrTmy6HfZr/ORM9XmcvGKDCXqMROjEfThdLWVb66tDZ2UEk3LS5QdM5mRq
 3SSdHor9mSiwHyrvUIoSjEHAY+sI/l6Rlkpd28XoBkTGKIX8VH1DkAUW47/d2cVlWZzTyobRBGE
 nc+R0G96+uxvcB55vcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01

Add a CoreSight shell test for --itrace=L. Record timestamped ETM trace
with explicit -T sample timestamps and AUX pause/resume events, then
check that the pause samples carry both a multi-frame callchain and a
non-empty branch stack for each of the workload's two processes.

Decode the same recording with L4 and L64 and reject any branch stack
deeper than the requested depth.

The test skips when cs_etm is absent, when not run as root, or when the
recording turns out to lack virtual timestamps. It exercises the
timestamp-gated path and the requested-depth bound; it does not attempt
to verify that the attached history is correlated to the sample.

Assisted-by: Devmate:GPT-5.6
Signed-off-by: Amir Ayupov <aaupov@fb.com>
---
 .../tests/shell/coresight/add_last_branch.sh  | 203 ++++++++++++++++++
 1 file changed, 203 insertions(+)
 create mode 100755 tools/perf/tests/shell/coresight/add_last_branch.sh

diff --git a/tools/perf/tests/shell/coresight/add_last_branch.sh b/tools/perf/tests/shell/coresight/add_last_branch.sh
new file mode 100755
index 0000000000000..6f09e720abe80
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/add_last_branch.sh
@@ -0,0 +1,203 @@
+#!/bin/bash -e
+# SPDX-License-Identifier: GPL-2.0
+# CoreSight branch history on existing samples (exclusive)
+
+perf list pmu | grep -q 'cs_etm//' || exit 2
+
+if [ "$(id -u)" != 0 ]; then
+	echo "[Skip] No root permission"
+	exit 2
+fi
+
+tmpdir=$(mktemp -d /tmp/perf-cs-add-last-branch.XXXXX)
+
+cleanup()
+{
+	rm -rf "$tmpdir"
+	trap - EXIT TERM INT
+}
+
+# shellcheck disable=SC2317 # Called through trap.
+trap_cleanup()
+{
+	cleanup
+	exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+record_data()
+{
+	local cf="$tmpdir/ctl"
+	local af="$tmpdir/ack"
+
+	mkfifo "$cf" "$af"
+
+	# Pin to one CPU so proc1 and proc2 alternate in one per-CPU trace
+	# buffer. Start disabled and use the control FIFO to record only the
+	# workload, not perf test setup and teardown.
+	if perf record -T -o "$tmpdir/data" -C 0 -D -1 \
+		--control fifo:"$cf","$af" \
+		-e cs_etm/aux-action=start-paused/u \
+		-e cycles/aux-action=resume,period=550019/u \
+		-e cycles/aux-action=pause,period=100003,call-graph=fp/u -- \
+		taskset --cpu-list 0 perf test --record-ctl fifo:"$cf","$af" \
+		-w context_switch_loop 10000 \
+		>/dev/null 2>"$tmpdir/stderr"; then
+		return 0
+	fi
+
+	echo "Failed to record ETM trace with AUX pause/resume" >&2
+	cat "$tmpdir/stderr" >&2
+	return 1
+}
+
+decode()
+{
+	local size=$1
+	local output=$2
+
+	if perf script -i "$tmpdir/data" --itrace="L$size" \
+		-F comm,pid,tid,event,ip,brstack >"$output" \
+		2>"$tmpdir/stderr"; then
+		return 0
+	fi
+
+	if grep -q "itrace=L requires virtual timestamped trace" \
+		"$tmpdir/stderr"; then
+		echo "[Skip] Virtual CoreSight timestamps are not available"
+		cleanup
+		exit 2
+	fi
+
+	cat "$tmpdir/stderr" >&2
+	return 1
+}
+
+check_process_samples()
+{
+	local output=$1
+	local comm
+
+	# Expect each process to have a pause-event sample followed by at least
+	# one branch entry in 0xFROM/0xTO/... form.
+	for comm in proc1 proc2; do
+		awk -v comm="$comm" '
+			$1 == comm && /cycles\/aux-action=pause/ {
+				in_sample = 1
+				next
+			}
+			!NF {
+				in_sample = 0
+				next
+			}
+			in_sample && /0x[[:xdigit:]]+\/0x[[:xdigit:]]+\// {
+				found = 1
+			}
+			END { exit !found }
+		' "$output" || {
+			echo "No pause-event branch stack found for $comm" >&2
+			grep -A 4 "^$comm .*cycles/aux-action=pause" "$output" \
+				| head -n 20 >&2 || true
+			return 1
+		}
+	done
+}
+
+check_callchains()
+{
+	local output="$tmpdir/script-callchain"
+	local comm
+
+	if ! perf script -i "$tmpdir/data" -F comm,event,ip >"$output" \
+		2>"$tmpdir/stderr"; then
+		echo "Failed to dump pause-event callchains" >&2
+		cat "$tmpdir/stderr" >&2
+		return 1
+	fi
+
+	# Expect a pause-event header for each process followed by at least two
+	# indented instruction-pointer frames.
+	for comm in proc1 proc2; do
+		awk -v comm="$comm" '
+			$1 == comm && /cycles\/aux-action=pause/ {
+				in_sample = 1
+				frames = 0
+				next
+			}
+			!NF {
+				if (in_sample && frames >= 2)
+					found = 1
+				in_sample = 0
+				next
+			}
+			in_sample && /^[[:space:]]+[[:xdigit:]]+([[:space:]]|$)/ {
+				frames++
+			}
+			END {
+				if (in_sample && frames >= 2)
+					found = 1
+				exit !found
+			}
+		' "$output" || {
+			echo "No multi-frame pause-event callchain found for $comm" >&2
+			grep -A 8 "^$comm .*cycles/aux-action=pause" "$output" \
+				| head -n 40 >&2 || true
+			return 1
+		}
+	done
+}
+
+check_branch_stacks()
+{
+	local output=$1
+	local max_entries=$2
+
+	local ret
+
+	if awk -v max="$max_entries" '
+		/0x[[:xdigit:]]+\/0x[[:xdigit:]]+\// {
+			entries = 0
+			for (i = 1; i <= NF; i++)
+				if ($i ~ /^0x[[:xdigit:]]+\/0x[[:xdigit:]]+\//)
+					entries++
+			if (entries)
+				found = 1
+			if (entries > max) {
+				status = 2
+				exit
+			}
+		}
+		END {
+			if (status)
+				exit status
+			if (!found)
+				exit 1
+		}
+	' "$output"; then
+		return 0
+	else
+		ret=$?
+	fi
+
+	case $ret in
+	1) echo "No ETM branch stacks found" >&2 ;;
+	2) echo "Branch stack exceeds requested L$max_entries depth" >&2 ;;
+	esac
+	# Expected decoded pause-event lines contain at most L<n> branch entries.
+	grep 'cycles/aux-action=pause' "$output" | head -n 5 >&2 || true
+	return 1
+}
+
+record_data
+check_callchains
+
+decode 4 "$tmpdir/script-L4"
+check_process_samples "$tmpdir/script-L4"
+check_branch_stacks "$tmpdir/script-L4" 4
+
+decode 64 "$tmpdir/script-L64"
+check_process_samples "$tmpdir/script-L64"
+check_branch_stacks "$tmpdir/script-L64" 64
+
+cleanup
+exit 0
-- 
2.52.0

