Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795041490;
	b=YLwh0w/1m9SPPawlDaWTEoyjVbwch27Xkxe83s1HSTGTqH8iF4K3BVwQU2ccOpCkPX0v
	 wHPTVnKyZPGUKvJkvjZs5eiRrhWYD1qLzb5QMFgqAc2lTVh/QkFQhoG6hxsWcsZviff0g
	 hPn8S0Ej5kC6l9QnbpJrIqxROQ1iZ7IlXaE6A9VsVAQB0Ho0GfFnHCsppcARnFjyp15Ov
	 5aEkOvkClY60fjKHTed2Trl3TSnsiZ02BLZ98+nFKCaVK7SMY0lVHmbtDBqkQo0YsPEWO
	 pxpeMp9uRUMgnCV+WRRT0faP+ct8vvJkL2i5HJLgyYhACBPpzQhmbuqkDmSu0H1OOEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041490;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MdAXpGeuC0Zr1ucQ0vm0QgEFLGsNzUop+nl8yFYM4Q4=;
	b=2dQriwBRW53FGQs1m+cM1yaKvyNFiATF7fr1yayLolKxluL4Tno+ikjAaET/ZisWLVbA
	 qY9M22p7gkC6WpuJIeSdH/Uf7WzPk6cdrQImVidbvY4i7/Cvrv20Z3aM4HnoHwmMnqtbl
	 OynpZ9pQ6obdF3514YX9vrv0zeBxdkhZuw3XKLeCgKtRPVVYQRKh18Qw2s49VItwIcHRC
	 UdH4ZmNgXaZyQ5V8FzAwQm0yF8OBFzuPgV4UiGHY9pPm1FpfxG/yR2jPp7nOE6Vg5WCOt
	 plnqwBnKMF9FkehijUpHuTPYWPdQ2zmW9v+KDOz0u5glAkCd7zZtkcXs8JINNnW1sjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eSBbMM9h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435E360A2623;
	Wed, 18 Nov 2026 22:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eSBbMM9h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BA91F000CD;
	Wed, 18 Nov 2026 22:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795041490;
	bh=MdAXpGeuC0Zr1ucQ0vm0QgEFLGsNzUop+nl8yFYM4Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eSBbMM9hzHsVqst+ZlZoXUjKan6oo41kL74iuoN7jqQWTwlzF5cjNszCOjrIEp1sD
	 ngp7xS9DwyM5EykwXfJU6qlj/kmePRxIvFspQwwW8kL41QNRCqiN5HvWE4a/uuSSZ3
	 9eGZIAyfwTDjRGjax/HBhacoElnov0kyFdVazZw9o5ihfCgbKxtVr5XcPDJsQerUB4
	 7Qmt6fZG+MsVVLmqWWDGFJ2U7ZdmVgZnl1YrfvSRizQbl5muT4jrFPHaxVMtohTR2f
	 +zxAnCqNzawjjKMSQkCSMhr7XO8TN4A+Ea80NfNOjNbqnZiJ+g6hKk/hkgHe/aS0Ou
	 V2S4YRUfLOuoQ==
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
Subject: [PATCH v8 11/13] perf tests: Fix the Intel PT virtual LBR check
Date: Wed, 18 Nov 2026 19:37:22 -0300
Message-ID: <20261118223725.121500-12-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118223725.121500-1-acme@kernel.org>
References: <20261118223725.121500-1-acme@kernel.org>
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

