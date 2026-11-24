Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795545982;
	b=4PIARca68cuAUvUyY6r3i+NM63a+nmnqCaFsjn7A7k+nRXQzGZ2Ty5xhHVl6JzrhkDRM
	 9rVJKqxmvDk9g6rzynC0skMQ8oDlw18M+yJkE7Fl/tzkN0XntD9iIVP+K4DdVhul6A1wM
	 Cetup4ZivNDgI6PgMEnmsSDPgYG0sAHVmAwsQtw7nNgQ7mlFbFCdD9nGXZjpa8psiQiZA
	 OlCMJ0vLQsicc0GTJ7MtgPpbZ6mRQq9VuMaMItfrnJdy2QrAnqjqhAFxRtcxtei+G7ynk
	 fnj530twQhAEmr6IBGXeQxdC/O6PbNuh3zWh4f3MnuEx8OWw5phptBO5JRq9QCrZ5ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795545982;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fyk5LKGEWjy2lkASU4jC9uMiEcgBR5rlw/9C6JX5sZI=;
	b=wPIfohKe+fHAqa1z1FEuWPD+aNbZ/s0VJgTYHFCFSouBi9tP4YH6nWmYdq4RJqlGssnM
	 EF/lIP3E83ihVIo714Vr1MrHkCKm+ANx1yIPYEIkEScm+MUTZtIhfVCYhDD6OpagPOhop
	 OFm3aiu9NsaTvotJE5/z1olqCvVIA/cDT7TuFwvcnfpYOxwpbF06eb22XQJ1vl2Ra+Y3e
	 pg3qyj3CYipjza3FtFCsEk1NwQ1IXMGVqANa76XceM0Qoosy4BL7hr6xUAbt5kZ8oIRlP
	 6bRXXsIrPql0gkikiCOwIEeEYkiSC8f5Kvl+7XYnqR7hsFFtnjexxqzSUwOqQuHyTEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UwTt72g1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75A8606A681;
	Tue, 24 Nov 2026 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UwTt72g1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986361F000C4;
	Tue, 24 Nov 2026 18:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795545982;
	bh=fyk5LKGEWjy2lkASU4jC9uMiEcgBR5rlw/9C6JX5sZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UwTt72g12dsX0ERWyYecyjfZkL2EvPjYwcOTXTJmSY4fREA0TYeFjk52YWB51y6qn
	 G9cKQMHYzZ2UvYgvUMEfF90beiTlTyXs9VvPcavBeuoST/P4jQdHSpXNcsjIJeg4cp
	 TIxHGSpEMoQbqSZhG/OSHE4laE/Hmxnb/lblx7V81L4SUwufHy54GA+zA31rGoRGLx
	 tuHz4Faq2iyhMCmec4epeNGKKSKFJNpXR0rIm7HEHamgJU2H4GMlAJU683B/V0NAl4
	 fx+5kg6j10jcPYa+t48aRC/TmI28lpiwQaV2Bpm8EGw8VEQh2cxqsYwxBI4PsQ45cD
	 hX+E45jp/0vgA==
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
Subject: [PATCH v1 03/17] perf tests help: Add a basic perf help test
Date: Tue, 24 Nov 2026 15:45:50 -0300
Message-ID: <20261124184604.24983-4-acme@kernel.org>
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

perf help and its -a option were not exercised by the suite.  Check the
common command list and the command directory listing.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/help.sh | 80 ++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100755 tools/perf/tests/shell/help.sh

diff --git a/tools/perf/tests/shell/help.sh b/tools/perf/tests/shell/help.sh
new file mode 100755
index 0000000000000000..b7279a97a5615193
--- /dev/null
+++ b/tools/perf/tests/shell/help.sh
@@ -0,0 +1,80 @@
+#!/bin/bash
+# perf help tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+err=0
+out=$(mktemp /tmp/__perf_test_help.out.XXXXX)
+exec_path=
+
+cleanup() {
+	rm -f "${out}"
+	[ -z "${exec_path}" ] || rm -rf "${exec_path}"
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
+test_help_commands() {
+	echo "perf help commands test"
+	if ! perf help > "${out}" 2>&1; then
+		echo "perf help commands test [Failed: perf help failed]"
+		cat "${out}"
+		err=1
+		return
+	fi
+	if ! grep -q "The most commonly used perf commands are" "${out}"; then
+		echo "perf help commands test [Failed missing command list]"
+		cat "${out}"
+		err=1
+		return
+	fi
+	if ! grep -q "See 'perf help COMMAND'" "${out}"; then
+		echo "perf help commands test [Failed missing help hint]"
+		err=1
+		return
+	fi
+	echo "perf help commands test [Success]"
+}
+
+test_help_all() {
+	echo "perf help -a test"
+	# "available perf commands in" is printed only when the exec path holds
+	# perf-* commands, which a build tree does not have. Give help -a a
+	# temporary exec path with a dummy command to look for.
+	exec_path=$(mktemp -d /tmp/__perf_test_help_exec.XXXXXX)
+	printf '#!/bin/sh\n' > "${exec_path}/perf-dummy"
+	chmod +x "${exec_path}/perf-dummy"
+	if ! PERF_EXEC_PATH="${exec_path}" perf help -a > "${out}" 2>&1; then
+		echo "perf help -a test [Failed: perf help -a failed]"
+		cat "${out}"
+		err=1
+		return
+	fi
+	if ! grep -q "available perf commands in" "${out}"; then
+		echo "perf help -a test [Failed missing command directory]"
+		cat "${out}"
+		err=1
+		return
+	fi
+	if ! grep -q "  dummy" "${out}"; then
+		echo "perf help -a test [Failed missing command from exec path]"
+		cat "${out}"
+		err=1
+		return
+	fi
+	echo "perf help -a test [Success]"
+}
+
+test_help_commands
+test_help_all
+
+cleanup
+exit $err
-- 
2.56.0

