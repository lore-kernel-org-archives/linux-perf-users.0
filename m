Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6B333FE18;
	Wed,  5 Nov 2025 19:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762370205; cv=none; b=nqTauhry7bRehzpuDyMgjK53qE2fA/0ojVAnpAjPU5zzT/J9JpPKWRxtovsQb1TO8k/gRRaSuGJg0hX8Q6WRxurFkTKDzaB5UwBMLqwtZ9q5ByQ1RqzigkU6XOsf6FhcGiuaxK/i76yUl4OI/FF2sq3n8qqBkPNtWK0s5Harfd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762370205; c=relaxed/simple;
	bh=22Z3mj1k3enKgJtEbBtMi+H4eLL7PQ660K2yzaiWT/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1EbqdPXGDbNVcKDbhZojZHSH+OfstLuVJDBGCagvuuUyEX4SoYDOELUD5SUArTEGrfbzjvX33tqlWNyvTUjh3y6io/plTomioMZZTsUwrkzCMPky385OzPM/vY8Wt6UaVfe5br6QgGZAiVnKa/beOmkMi3fT1ft+yXLkzXIx18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jx5wTg8d; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jx5wTg8d"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5D8jxl009411;
	Wed, 5 Nov 2025 19:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=oWL+2CjkMNbiQD1Rr
	qj0Z+xs4KQ7ALjD1Ir1gDVUNgw=; b=jx5wTg8dcFf4a5G9eSxwL2Y7cCZmvGQ8T
	6YNZpjB1gkyqcGMxpKOyoVCBGnpM0RD6Hu8avdl2FDt1XqMc4ASyzV5Xz+fm0n+P
	QODicHt7cfTwg25+l5be6B6BXRGALYwBu1wzdDOX2qqsgJ39qJP7XKGMWq30oEZx
	50a0vaOhPVB5zvgCV4WqpG22/9jSllJQYPGk9vdxx24rg5GT3NmUFwLD4vYo/KL+
	7dzbc4Op/r9zUa+rAnjEV0Rygu8jagYx/Pn1JcdbDBkNv9ofrJMlF4c+U09/4J9X
	TAPmC/uGZMwtZKbZ0P1dzRvZsh2EiXPzMwJdR6TxsJQ48dJC8LMzw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59vuk8xu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 19:16:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5GTgbu012974;
	Wed, 5 Nov 2025 19:16:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5y821h20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 19:16:39 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A5JGaIB41812392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 19:16:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17CCA20043;
	Wed,  5 Nov 2025 19:16:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9293420040;
	Wed,  5 Nov 2025 19:16:35 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.135.254])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Nov 2025 19:16:35 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 5/5] perf test java symbol: Add PID namespace variant
Date: Wed,  5 Nov 2025 20:10:28 +0100
Message-ID: <20251105191626.34998-6-iii@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251105191626.34998-1-iii@linux.ibm.com>
References: <20251105191626.34998-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 67HUu6tjUeQb4lMg6u_lCwGNJw0jhE5F
X-Proofpoint-GUID: 67HUu6tjUeQb4lMg6u_lCwGNJw0jhE5F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfXzDy4Duiq5+y4
 BvDOD0wgbvmFfzPl4+Ia9AexdU7Qsj3bXXt3EY7xMxt+2xAo0JBeuoYgcs1jU/rCc93q3LQwUN5
 SolwJy6WKUpT1IVzE/KGnA4xIvGQ7AZUfUq7NXQDlp8KQ6DVQRRaEthapseQ/8wOS9M8PXNDXln
 TqNrIse67F1EGQlVJMXsjolK7DPEYKME4wcYuoCneMKNaLWkQBNJBLiPV6trqmYvf5MeodMuWu7
 /y3uZWr/RutnLs6lV9ID98l3G5n25wqaRp9P05f4pafgAvkVOV0a3ZJIpR34+OPuWEFN7SI6KtV
 rlwRD4fgEGQRMAoTQa5aJrLewnkIUZFptjEQT7KalhsNhFSDaMkYPAMrmBG4dPwM9k0uajzX953
 gU3ERwXbw1XNllYksx4GcUhTJnIbfA==
X-Authority-Analysis: v=2.4 cv=U6qfzOru c=1 sm=1 tr=0 ts=690ba298 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=2i8RwoOR_BBpVC3p_GAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_07,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511010021

Add a PID namespace variant of test_java_symbol.sh. Compared to the
existing test, we must jump through two extra hoops here.

First, we need to check whether unshare is there an is usable, which
may not be the case either due to kernel config or permissions.

Second, we need to keep jshell running after perf record exits in order
to reproduce a real issue with this setup. This means we have to attach
perf after starting jshell, use ctl-fifo and ack-fifo, and work around
perf's inability to attach to existing children.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 .../tests/shell/test_java_symbol_pidns.sh     | 135 ++++++++++++++++++
 1 file changed, 135 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_java_symbol_pidns.sh

diff --git a/tools/perf/tests/shell/test_java_symbol_pidns.sh b/tools/perf/tests/shell/test_java_symbol_pidns.sh
new file mode 100755
index 0000000000000..afee6d055ad90
--- /dev/null
+++ b/tools/perf/tests/shell/test_java_symbol_pidns.sh
@@ -0,0 +1,135 @@
+#!/bin/bash
+# Test symbol resolution for java running inside a PID namespace
+# SPDX-License-Identifier: GPL-2.0
+
+set -u -o pipefail
+
+# shellcheck source=lib/setup_libjvmti.sh
+. "$(dirname "$0")/lib/setup_libjvmti.sh"
+
+JSHELL=(jshell -s -J"-agentpath:$LIBJVMTI")
+if ! command -v jshell &>/dev/null; then
+	echo "skip: no jshell, install JDK"
+	exit 2
+fi
+
+UNSHARE=(
+	unshare
+	--user --map-user="$(id -u)" --map-group="$(id -g)"
+	--fork --pid --mount-proc
+)
+if ! "${UNSHARE[@]}" true; then
+	echo "skip: unshare not functional"
+	exit 2
+fi
+
+if [ "$#" -eq 0 ]; then
+	# Verify isolation by running the test inside a separate PID namespace.
+	exec "${UNSHARE[@]}" "$0" "$@" stage2
+fi
+if [ "$1" != stage2 ]; then
+	echo "$0 must be started without arguments"
+	exit 1
+fi
+shift
+
+WORKDIR=$(mktemp -d /tmp/__perf_test_java_symbol_pidns.XXXXX)
+trap 'rm -r "$WORKDIR"' EXIT
+
+test() {
+	TEST_ID=jshell-exit-$JSHELL_EXIT
+
+	# Verify that perf inject can deal with JIT dump produced by jshell
+	# running in PID namespace that is different from its own one.
+	# Make sure jshell is still around when perf inject runs, so attach and
+	# detach perf manually.
+	# jshell is a shell script that runs java as a child process, and perf
+	# cannot attach to existing children. Therefore create a stopped
+	# process, which will exec jshell after it's resumed.
+	JSHELL_STDIN=$WORKDIR/jshell-stdin-$TEST_ID
+	JSHELL_STDOUT=$WORKDIR/jshell-stdout-$TEST_ID
+	mkfifo "$JSHELL_STDIN"
+	mkfifo "$JSHELL_STDOUT"
+	exec {JSHELL_STDIN_FD}<>"$JSHELL_STDIN"
+	exec {JSHELL_STDOUT_FD}<>"$JSHELL_STDOUT"
+	JITDUMPDIR="$WORKDIR" bash -c 'kill -STOP "$$" && exec "$0" "$@"' \
+		"${UNSHARE[@]}" "${JSHELL[@]}" \
+		<&"$JSHELL_STDIN_FD" >&"$JSHELL_STDOUT_FD" &
+	JSHELL_PID=$!
+
+	# Start perf record and wait until it attaches to jshell.
+	PERF_CTL=$WORKDIR/perf-ctl-$TEST_ID
+	PERF_ACK=$WORKDIR/perf-ack-$TEST_ID
+	mkfifo "$PERF_CTL"
+	mkfifo "$PERF_ACK"
+	exec {PERF_CTL_FD}<>"$PERF_CTL"
+	exec {PERF_ACK_FD}<>"$PERF_ACK"
+	PERF_DATA=$WORKDIR/perf-$TEST_ID.data
+	perf record --clockid=1 --delay=-1 \
+		--control="fd:$PERF_CTL_FD,$PERF_ACK_FD" \
+		--output="$PERF_DATA" --pid="$JSHELL_PID" &
+	PERF_PID=$!
+	echo "enable" >&"$PERF_CTL_FD"
+	while IFS= read -r LINE <&"$PERF_ACK_FD"; do
+		[ "$LINE" != "ack" ] || break
+	done
+
+	# Spawn jshell and ask it to run some CPU-intensive code.
+	kill -CONT "$JSHELL_PID"
+	cat >&"$JSHELL_STDIN_FD" <<EOF
+int fib(int x) { return x > 1 ? fib(x - 2) + fib(x - 1) : 1; }
+System.out.println(fib(44));
+EOF
+	while IFS= read -r LINE <&"$JSHELL_STDOUT_FD"; do
+		[ "$LINE" != 1134903170 ] || break
+	done
+
+	# Terminate perf record.
+	echo "stop" >"$PERF_CTL"
+	if ! wait "$PERF_PID"; then
+		echo "Fail to record for java program"
+		exit 1
+	fi
+
+	# Terminate jshell before perf inject.
+	if [ "$JSHELL_EXIT" = "early" ]; then
+		echo "/exit" >&"$JSHELL_STDIN_FD"
+		if ! wait "$JSHELL_PID"; then
+			echo "Fail to run java program"
+			exit 1
+		fi
+	fi
+
+	# Inject the JIT data.
+	PERF_INJ_DATA=$WORKDIR/perf-$TEST_ID.data.inj
+	if ! DEBUGINFOD_URLS="" perf inject --input="$PERF_DATA" \
+		--output="$PERF_INJ_DATA" --jit; then
+		echo "Fail to inject samples"
+		exit 1
+	fi
+
+	# Below is an example of the instruction samples reporting:
+	#   8.18%  jshell           jitted-50116-29.so    [.] Interpreter
+	#   0.75%  Thread-1         jitted-83602-1670.so  [.] jdk.internal.jimage.BasicImageReader.getString(int)
+	# Look for them, while avoiding false positives from lines like this:
+	#   0.03%  jshell           libjvm.so             [.] InterpreterRuntime::resolve_get_put(JavaThread*, Bytecodes::Code)
+	if ! perf report --input="$PERF_INJ_DATA" --stdio |
+		grep ' jshell .* jitted-.*\.so .* \(Interpreter$\|jdk\.internal\)' \
+			&>/dev/null; then
+		echo "Fail to find java symbols"
+		exit 1
+	fi
+
+	# Terminate jshell after perf inject.
+	if [ "$JSHELL_EXIT" = "late" ]; then
+		echo "/exit" >&"$JSHELL_STDIN_FD"
+		if ! wait "$JSHELL_PID"; then
+			echo "Fail to run java program"
+			exit 1
+		fi
+	fi
+}
+
+for JSHELL_EXIT in early late; do
+	test
+done
-- 
2.51.1

