Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039081;
	b=J+7qlOU0TYE919eOyHd11irBdeAI18XXVXw58lk5ZanM1bLhcde9TFIbmpvXoLNLxLyP
	 O+7dr2xTFWVK77Aub/lhF9i/u2gWjSA5WbjdQXDRRvkGBiM/Q99Q83PBzngy1Ipmox4bL
	 NIOGNfIue28udi8gILpLafo88iqDrobrcMBJeFS61GH0fwlB3y38v7QBytJlWQbgAbPc/
	 C/idb9bKyXbhwRmxe19FECD69XGM4ueq2EWOxyXcyNWMXrvsAzDuzLJ3AN3uyIfuM7q20
	 jbCuII+5OkmqRh8dJgZzD7CL9I+bO9IOo7Imsc6Q4gbOzGC7DfLpCpMw6DbpB1ng/GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039081;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MdAXpGeuC0Zr1ucQ0vm0QgEFLGsNzUop+nl8yFYM4Q4=;
	b=rDeXM0oBm57rjtgXj7+2PYFne8Kd5bipUTyl8KSxQ+ouOH8SIaox4RsNPskAoxAs9DFO
	 mzOLjeRSi/DvZ5bw4neJi4up75j+bf47OohdM+xQvj/AxRo3sFzQHTyj4mV0yxNI8OCuc
	 cy8/L4uz2/VPKWIRvIKIDin9awceQDaAcz22lr0M/Adst7qL1RtHmCHWbMv8n/4Wf4+kB
	 OI8u6kYpn+B6HBnlu/kOg37cEI21nbpS7KQyDilO6DMtACyPu+s+Wq+6Ra839RsWNSMns
	 I3TJmXKPsfpL/Bn2cTLSBwR3xuyhUF3PMaCedwL+KWTyWJzSWgfP0hX2YWUA3lS3UYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jjr4R7bV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29F6606A31C;
	Wed, 18 Nov 2026 21:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jjr4R7bV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720531F000C7;
	Wed, 18 Nov 2026 21:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795039081;
	bh=MdAXpGeuC0Zr1ucQ0vm0QgEFLGsNzUop+nl8yFYM4Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jjr4R7bVD1tjQGuDZHLKnGb03eAuR1lMnNIg+Nv0/9XrHE4ywgCLXzgEP8VWfAw2T
	 NetIe1ckjW6CqLQ4jdq1XqhqnwXK6wY89Ea90Vp5UT/3oxXQ9s//LwHeXnRVyW3LLr
	 pi5K+wD5o+P5rsVISxZs95o1UlywJf5an456p/hiNaVh23XCS+evEr6BE9zopymEfw
	 lROMEGaCAW5x8TTPfh8aWe+OzK623chQqvETUcl7oTy0GiWzdPl2hua5o8F66QnBD3
	 6YjUCktiysuvHq6GhEw1565fcOulidvzAdKcH3GJt8nBWDcybUDrU7hflU0oSPvGiB
	 lDV1E3OCVajzg==
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
Subject: [PATCH v7 11/13] perf tests: Fix the Intel PT virtual LBR check
Date: Wed, 18 Nov 2026 18:57:13 -0300
Message-ID: <20261118215716.114868-12-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118215716.114868-1-acme@kernel.org>
References: <20261118215716.114868-1-acme@kernel.org>
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

