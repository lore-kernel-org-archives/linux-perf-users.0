Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795138391;
	b=VCgIHbXG1FrzEkSogcqnVgGXPgXqlmnGS8xvVz0+9QSIDHbCjMVSEv3UTOjx15k3rn+T
	 q5v+LJV73g02+sGbbermMqjiLGqdz7WYB77P8YhTKkV5ABtR3F5Us1zejLd997TMSnYn0
	 skEV2b+QhDadFE1Mnn2QswCWuF2Rcn8qKLvNUZhXdgcEVuUCvY44DI1USy90NMjPpZVJf
	 7Tn+ynStdtHyRkz3+kvMLZDS9MXzYQ93cSv7Yzgy5b+7BZCj8n0dr5MKjwZL1Wtr/bhrl
	 Qv0BTFao2W+fcDfunQi4VwbrzwTmZJAd8c7OePU+JPYQL9UPbbN4VWtH1+a/3y08ilg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795138391;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MdAXpGeuC0Zr1ucQ0vm0QgEFLGsNzUop+nl8yFYM4Q4=;
	b=zaARqAhrwbUEiJZAkFLfteapE4AVDYzHQJnpn/4CZs5qWjGS1uXFV5NsTKAe+67f9xLg
	 BouUu59j9uc9RxfyPt162UWfDIMSun1H8RofXTkIfAMJIF6zvceXTyTKQZ7tER50QpCKT
	 kjleuS3slp7DlZqDx9JRkxcaU/+4hXY7qxULo5HomCj5p8AnxMYzZXGozU410CyhGocAK
	 43iVmzPerXTVBKZySQab2YWEXUuD7pD+fFd/CvkAP2QftqaDB28+aiqpGiB5jDnZY4Vv1
	 4r/hI7OkElAXTsanPD88iF6YsX4cEmyN74kAwyfzij6kYDBTGk5M1zyb+zOrgECSCwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=faqKHzDq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41834606A330
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 01:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=faqKHzDq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4E11F000C6;
	Fri, 20 Nov 2026 01:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795138391;
	bh=MdAXpGeuC0Zr1ucQ0vm0QgEFLGsNzUop+nl8yFYM4Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=faqKHzDqhvR0TJ88zjrEgFqZfscBJtGYfHEkW9knFfNo36/luyMc8CG82Z7peBXlU
	 4Js+Su6gJFWIV+NsF6NhNEudik0V177wcSAAgbulxikJHy3rjkpqBAnKt7Y0LfmCo/
	 imAOqPDR4N/HNQ8TEwuvXhQXgE2nk3RfeRiT9rwTnFg1rp0VS3GSGzlkMI66QrG0Bs
	 JL/z5ljY5M+ZHCdAyoMI9bSNgvCQTsdUQN1guixQtmNEJLDS5OOvUFWAlHdqZJVsCT
	 rvhrKwsgSwfJ5Vzr5PYlwqPYSxu9YXblso3C9yE1KD2ukXPvjq3nv0FVqtzDFezin0
	 UNROzg7iUTZGQ==
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
Subject: [PATCH v9 11/13] perf tests: Fix the Intel PT virtual LBR check
Date: Thu, 19 Nov 2026 22:32:06 -0300
Message-ID: <20261120013211.1510-12-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261120013211.1510-1-acme@kernel.org>
References: <20261120013211.1510-1-acme@kernel.org>
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

