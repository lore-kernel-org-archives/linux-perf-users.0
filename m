Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471274;
	b=ZOWPEpEQgA3AkZd8qtwet0JEQL4UDdqmUQph/j/2IzQFkbQ8qb16tjiiLNGax5rBZquP
	 3ZE6T4bnExJYijJ2ro2o0M9cw8iA1MjO1Vb1hdYYaD4tlIsm/HMgqabC94vSJ8H/4yDOi
	 VqOhNe33DE3bQTqR8GnjQtqaILXpg3ryB1+I2pWLaypa3jz7N4qRqeDU93s3zXAMVHSQ5
	 ++xeEDVddKwel+KBiuTVGdBFqfGVieL9nm1vp+c5B8MPnJqEFQPonEPq8gZ01l+7hMA6v
	 fCCc8IQz7J66YDu+RCHgD8sF0bZyyuIo18wgp6OjUgHmcxl7bphT8ZDVIcIlGpq+Nxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471274;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KGmUhDDN0UG2rp9CP1JqbUp2tr3lxr0jBQoyS/TZUB4=;
	b=vGGaWpmtIUaJRGt3QCOYfYXaLb+sGxH6QdhugnD3jbH/GY5b/2qsVKlMebzduUlE8Zdk
	 Kj6l46soOUr/+irUsCM2b0yXrgr2DNjKKwB/hdG9Xb2Rngrp9uIuFhZwlUGHlaC65FdA/
	 OzfFlI3zAyY/YFPV/spfat+yPTBxLshOLtuJcg8K3gRGCifTXD+M0ynvnHSwmV+lWXc4z
	 UfZxjA9379y5BDuH7faObZWij8/AX3O02qpsZbHfKT53NMaX2w7KLaAE8l7mZbI4veHce
	 /hF7YrXalytqA/ZRUQ/qndds6+lMPJY1yUfwmHDk4mEvVIIMxkrBEVaFAJgkYFv/yRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B8DaVIG6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D5D606A321;
	Mon, 23 Nov 2026 22:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B8DaVIG6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E301F000C0;
	Mon, 23 Nov 2026 22:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795471274;
	bh=KGmUhDDN0UG2rp9CP1JqbUp2tr3lxr0jBQoyS/TZUB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B8DaVIG6JB7JNcfGRSFVW469+My0NQDIYm1bmtd/AEsTUeFTcYfogtvVXYAUUk0kG
	 4O0dW3E03BvKH8KyiVcj8fTAbVbGIPyvyMndysLogMx+sHEeMjVFOfkpLO4ktETeah
	 v4+u9y9UaiV/fTfS8XgIy2IDWolM7QnwqH6loMEgUgBjzhGHxh6ftzF5ni7Jeugqre
	 iQANxM2p7C4PQ1aZZ6VPcocvS+T5k1D7YVzxHSI0lZMOXo3pD0nSzX7w0RmbLJ2X4j
	 CgZYylJOoJUdzU3x7wteZvnT6lmP+gZG1B6PVhhA3q/v+F7Wo1xnQ4P1J7RnJ75yAt
	 UqUzcX9BTwAJA==
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
Subject: [PATCH v12 13/19] perf test: Fix the Intel PT virtual LBR check
Date: Mon, 23 Nov 2026 19:00:18 -0300
Message-ID: <20261123220024.14891-14-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123220024.14891-1-acme@kernel.org>
References: <20261123220024.14891-1-acme@kernel.org>
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
2.56.0

