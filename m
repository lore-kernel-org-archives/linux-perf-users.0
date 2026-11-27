Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795743507;
	b=i1bqClALMc8LTfzE59Ib1IPWf0jXW8DBzpUdIEpWFzM0Si/Ylz+58xL8NiE0FC7lgTJD
	 zJdTLoDmHaRaL67yaP+Jll3bpnWnqK7mkyUddBCpqAbxZ5JfMiWCvZuhk3dYVZFRCGfJG
	 QYB0EoVtohDi1++viyts1N2v6j7Vz0YTilLbx2gVrBAB15ztN3WEXqADMUZ7eRjVZN7/o
	 dDguHip9AQZDH9aOCGO/Lmxx5c1GJbeASLqhPxusc1N+RjyVEQgo9ikwqB/V3sGwJ2p5c
	 avTcKK2M0nH26B9FSBrP2P7psyzKIzFOko8tYVOHJH1kizqtPiJRQL0bw/qI128XcGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795743507;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fyk5LKGEWjy2lkASU4jC9uMiEcgBR5rlw/9C6JX5sZI=;
	b=EN1O8iOiBDBENptNbcsuU5+KfYp9wdeqthW6ySdOkWQHObzG7LdA2ZvD96DvqQFfs2ov
	 P6dlbJBgxckTDq3Yno+piESzoe78uV17e7pLYLX6zx1x/9pM0N8AtDsfFVGZv9ehS3dtQ
	 Y1b2yLdHHqy8iYfd6MyQRPTHhJvC5mSKSwCoxHvB3lod9c0ZQQ8IzRz4R6qZvZ0GEVzOz
	 8Uws3wM9lapkkjiRQi2QHEmwRcftytK//rLQyl7xgCzqRNaoMB72g/1fv1x3Y3vea+TE1
	 IZnm7lQCQdiFU8+rmjHszQr3VRUznbIwgdtmASp8SiOgvSlePjmVgojS+AOCrdXIhNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="R7PtPK/4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2A1606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 01:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R7PtPK/4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DC81F000C1;
	Fri, 27 Nov 2026 01:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795743506;
	bh=fyk5LKGEWjy2lkASU4jC9uMiEcgBR5rlw/9C6JX5sZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R7PtPK/400sBJFwHtQBkWvUds6FHRVrAyvywYBMVGNU1N/Vii/nnrlHPiFe5B5Dsi
	 UnS0gNLYqyuBXk6zEFjnMW7ccAy6wc//A6ixsG7pd1XEZjpZu2LddUb4dEBn19NP9v
	 /9w4Um9rhI3t2vzKc7geopwWnLDZ3x3KlqaPt1widcsXJSvolepZk6vnGYNTxEffSl
	 ibKTJx44XqghJbDyrr0CjFqyj9nIsHwxzYVfqtO5WWOo7EgcHh8lo/9/YFdNdlixVZ
	 jwavSL0xGkXktIGu0eyPpCBImG5zrDyWf3puKbiLyM1RtYiIQStUmHIkYY8qEvw7rc
	 To7ZbPtdo933g==
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
Subject: [PATCH v2 04/18] perf tests help: Add a basic perf help test
Date: Thu, 26 Nov 2026 22:37:47 -0300
Message-ID: <20261127013801.14841-5-acme@kernel.org>
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

