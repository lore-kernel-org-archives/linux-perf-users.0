Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945911;
	b=yohjdLSG47JE+PspCAzA0r+L8w+07vzujJUco3Di1d8islhgHpMRSqW4FrGPIq6D46jT
	 uHm6P5EGnTEzaLewGFL6nPTndphmC2q899c+oGdpY4y9IYnosQTIgZPyiG/TXD/kgdRQx
	 pgvBZF+M3theNIY0H1F5s4LHOjhBh5I2hEJePYXRb1ksW6fGM40akmRMGbf0VXxeebrh/
	 JEJf/jFTCl1JHi30DawuKhnMJlGXczZzWaWJbS9hVAiVnXjBvxLB8lUNm6oh1sJOXMFIO
	 J9jYFs8zvQQ/MOLHa6ZlFfh3/8hUoQ76VMbUlQIHDhZB9r3u67+6Js/ph3LQ8fV//5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945911;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=t/rnFKhT4uAc3ZKGLNaB7q+J2GxS6JwuzxOXDjLe2jk=;
	b=tg4RMPusazv8WB+RCO5Rn09cBMFFMBh5JB/UD1NdDYEG6qP53iSFzSOi4S+lJJU8DcEl
	 wSzYI01kExSlMvV7xZGjAD4eoxrNFdS8yJHDPkT9gglRcMIv4Ibr8gLSHGW+DhMeEa+1Z
	 1VSCjCumbepHH/kUAe4vZBi8Q1CP+Fsej0rVlK6+PMGHFP0K5/XeOeM30hOVJO3yk7JrT
	 f4KF+8oQ10jebgHzgFHRDC/5tcrqG8/qWSQZzPBd+3jsQ3OwI9NOC8lN8Rk04cFRhbVQH
	 +ZP/ZxMp6Vo/kTpf2mYfYagz0McaeAHvg4vylwADz9DqLV7UWvdHo4L2ZteKt9+BmFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M0qXkUwZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABB360A382A;
	Tue, 17 Nov 2026 20:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M0qXkUwZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4911F000D3;
	Tue, 17 Nov 2026 20:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794945910;
	bh=t/rnFKhT4uAc3ZKGLNaB7q+J2GxS6JwuzxOXDjLe2jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M0qXkUwZTC1iUDMJExezyBD9QaVGmk/5k7zIqq6ieeSwrA8Yc0t/OYF1o/l4TIAVx
	 zxNOYpgr+sUGS5BFohsGeAbii178xqtN2Jlwije/gEu36FUKV8Ga0ODY3He4tQwJ9+
	 BY/6E2mT0wfs+/e9exCXkmof0N3cgRYodgM1EnhCks8gIvcYqfMp9/emWzuMZhns5l
	 gaQ842+V+0VesaHhaUMcIW93rt7M0AeWYKcQqbiR/SYqFhou0wXv2SH/yqinS/0qK1
	 xEJ21/ZnZ7FPHuizvlYvxN9aGjqH3CSAhEaudDz4WKshw1tc4oPntgwYagDkaL3xHz
	 kmmGJJmsjy+pg==
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
Subject: [PATCH v6 11/13] perf tests: Fix the Intel PT virtual LBR check
Date: Tue, 17 Nov 2026 17:04:29 -0300
Message-ID: <20261117200433.45174-12-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117200433.45174-1-acme@kernel.org>
References: <20261117200433.45174-1-acme@kernel.org>
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

With one data page the virtual LBR record loses its AUX samples:

  Warning: Processed 29 samples and lost 100.00%

Use --per-thread with 4 data and 64 AUX pages. Its single 276 KiB
buffer (including metadata on 4 KiB pages) fits the default 516 KiB
mlock allowance, regardless of CPU count. Also require the Python perf
module to export session: importing an unrelated perf module used
to fail the check instead of skipping it.

Fixes: 915d6b14dc0c ("perf test: Migrate Intel PT virtual LBR test to Python API")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/test_intel_pt.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index c0ecece0a8255124..ba4ed6dc6dd87a5b 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -384,13 +384,14 @@ test_virtual_lbr()
 	# shellcheck source=lib/setup_python.sh
 	. "${shelldir}"/lib/setup_python.sh
 
-	if ! "$PYTHON" -c 'import perf' > /dev/null 2>&1; then
-		echo "SKIP: Python perf module not found"
+	if ! "$PYTHON" -c 'import perf; perf.session' > /dev/null 2>&1; then
+		echo "SKIP: Python perf module with session support not found"
 		return 2
 	fi
 
-	# Check if virtual lbr is working
-	perf_record_no_bpf -o "${tmpfile}" --aux-sample \
+	# A single data page overruns aux samples; use one per-thread buffer
+	# with 4 data and 64 aux pages, plus a metadata page (276 KiB).
+	perf_record_no_bpf --per-thread -m 4,64 -o "${tmpfile}" --aux-sample \
 		-e '{intel_pt//,cycles}:u' perf test -w brstack || return 1
 	perf inject --itrace=L -i "${tmpfile}" -o "${perfdatafile}" || return 1
 	output=$("$PYTHON" "${shelldir}/lib/perf_brstack_max.py" -i "${perfdatafile}") || return 1
-- 
2.56.0

