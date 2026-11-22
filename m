Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795383678;
	b=Ipkugr4aAhrh8wVR3ppPEX+AgeCzFmCRPMbUSQr1cqZ97zTcItP1tmpVhPuiWxiNc+yD
	 tkG0U89UQbFCvzIidob4ExV0RheZ97uhfWQWeOr0tIcdGaJlGUbt1BW2kvz7Mn4+KI+JZ
	 zt3t0Y61p7sLDI21hRB16vJpQekWP5YmCwvdRHLvV64ZAtwXa33PZgnMkJSc/WvZmfsn0
	 lAT1paRCpFutYUuiJtrIW520ZINfIm1SRccOL6oV78gn6Y7SJIRO5Y26WDK01RmQ87vZG
	 iuxLYF23qjmOC9ywc24GNLotlQwhDUkdERPhwcqTZ/VVDGyTM1MfbSMiaC+n/aItbyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795383678;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MdAXpGeuC0Zr1ucQ0vm0QgEFLGsNzUop+nl8yFYM4Q4=;
	b=ev/j4RQ+QSncBisb/ukR9JzHhrVwqtdBvOY+UWFE53EG1iB6NnzBqjj86MvWAduslWOw
	 jeVofXJeJraOZQo/fhteyncSEkCyFzVqj8ELddDjGBhWQ55UQDfdlyA7qPpFipYhUeylc
	 VqSSdCCenaIlmff1maISNZpxHxCPVCMsefQ2RN40PM/07AhxYKVxP60RjiyPkQU8wF86F
	 2zJdeJjVSzVCHc2U64zS8UxKL4doUKpwcuE3/LWgLJr3mDnlw3+85NmngBE7Yv18RirPm
	 ee7Gqe+XLkd0Vi5VVmdQlgZXNTHMrPx9HpqjDISF74a4SF72QqaR2BDs6gBYD8z824w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="on+/glrb";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEB0606A33F;
	Sun, 22 Nov 2026 21:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=on+/glrb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F021F000ED;
	Sun, 22 Nov 2026 21:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795383678;
	bh=MdAXpGeuC0Zr1ucQ0vm0QgEFLGsNzUop+nl8yFYM4Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=on+/glrbHrSewRqS2CkYmJS6DIfkNwZAU+eY+NL1MPCFj/zrjPgKELM9oiNuxdZpq
	 VpzEw2CpGoFjGftQrxCVsTADsiqZVsqDjU8wT0GriC2AD4esM4kTwl/CoGW8ziP/U5
	 GJy7tsRYk6NGRY2hdk/pFfO+9/0rB1SUKx1/bzUseHRxgoKnfeaYNj+4URD6b9PAwQ
	 /IC4Z9zkw+r+rH+ARACWP9FDfZzJ8Y8oIsejva51TFIznE7EQfyJ+xL/dHE/l94Goq
	 9IOAk4CNlvNniTBRMS8cVmWbC5MZCm8b8HJWCLlL0sJNa9HGFhv1PptwHsvF0H0XSo
	 LHVvQz5uQmi1w==
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
Subject: [PATCH v11 13/19] perf test: Fix the Intel PT virtual LBR check
Date: Sun, 22 Nov 2026 18:40:19 -0300
Message-ID: <20261122214025.16769-14-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261122214025.16769-1-acme@kernel.org>
References: <20261122214025.16769-1-acme@kernel.org>
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

On an Intel host the virtual LBR check failed with:

  Warning: Processed 29 samples and lost 100.00%

The record leaves the buffer sizes to the tool defaults: the data ring
follows perf_event_mlock_kb, and the runner's small value left a single
page, too small for the AUX samples.  Pin 4 data and 64 AUX pages, so
the test does not depend on the host sysctl, and give the AUX ring room
instead of the single page the tool sizes to the 4 KiB snapshot.  Both
fit in the default mlock allowance regardless of the CPU count.

Also require the Python perf module to export session: a perf module
without it, like the distro's python3-perf, made the check fail instead
of skipping.

Fixes: 915d6b14dc0c8971 ("perf test: Migrate Intel PT virtual LBR test to Python API")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/test_intel_pt.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index c0ecece0a8255124..96f5c132cebf23e6 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -384,13 +384,15 @@ test_virtual_lbr()
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
+	# The default data ring follows perf_event_mlock_kb and can be too
+	# small for the AUX samples; pin 4 data and 64 AUX pages, which fit
+	# in the default allowance.
+	perf_record_no_bpf -m 4,64 -o "${tmpfile}" --aux-sample \
 		-e '{intel_pt//,cycles}:u' perf test -w brstack || return 1
 	perf inject --itrace=L -i "${tmpfile}" -o "${perfdatafile}" || return 1
 	output=$("$PYTHON" "${shelldir}/lib/perf_brstack_max.py" -i "${perfdatafile}") || return 1
-- 
2.56.1

