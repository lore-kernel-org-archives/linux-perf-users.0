Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794884022;
	b=YvvfKWSWouEJQgYK/eGgMPrCnT2ogZRKEmakcua+vH5Nz/HtDeIeAgbhB4wRWwfKzJCa
	 u3fIaON/+gPeTQ8a1XgD0DHUNqadI1XrzTgC7LR5nhR4AZgVxB7sjPxBxdlfaFoSG7Hoc
	 pXjGB208wnxUeOx/GMfDC+JdC07IAC9QI04dB6TtjS6FLIOkv9kmtHiU8qbXfQL6iXs5K
	 uzZc2HmE3jcwx1bjtqn1zSnfWhgKb6rms0pXP5Yx75hiry7tXqSZdCtACfrRrxfIhm8Wb
	 YsBuN/PRVpzqRz/aP9tF7UE5BX83zaewNbV9/swU1hbCFOENZTbsyDCYVSnPmQTXxxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794884022;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Zv27WeyfKuHk934BOkoEy9pjYUUOCVBJyFWVBjr4R9k=;
	b=loLL8stqayW9cbBfi4UnsbD+pcWO/xVb+z+HSi1cA8bis9hDrUASoPvro425cBANPOWt
	 V+ayU4lGiPzW2hH1W8Nn3LvanyU/JcEJ4/XNj5ztoI7cYq8hvI6XU/CDr8seKpH6aNLvk
	 gzqPzuTar9gQjb6hUit2skOyUjFT4NI2Ombfp1Ba4I6dQ1M+5klrPUNy/ZqkIjmMb7Hyr
	 gdgalAbCyUmoBla5BChDtZ4juL5xvFPEBZ+OwnoO/4irgwJE1HqomK8IUpTiXtt1EoY8+
	 wiR46SQhhxGZM5M3LHQKs1Qj2cTijyC0cXmuol3ao4sYgPPcMHjwga41Fl0OkWHeOUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Qm/fwO52";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C419E606A32A;
	Tue, 17 Nov 2026 02:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qm/fwO52
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CD01F000C4;
	Tue, 17 Nov 2026 02:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794884022;
	bh=Zv27WeyfKuHk934BOkoEy9pjYUUOCVBJyFWVBjr4R9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qm/fwO52SUEZ3thSnUOAaa49n8tUY5c95cAzub02zgPj6rZwI43wezdDYfiWEtaTq
	 55GFevUfMLbtrAymslHa4f9jg6P4WPMF67QbxmjpD+UlHfqyTGbXBsQg/oZihpLHB/
	 hX7M96M1yHKA001nvWmHG9vafhrdnI/U6ykz/KmjKGRt3slJENHhH1FweHF7uv1Mo1
	 /57MZD2bsI1nWutkMeNF2rzEJTAZFwdFn3kpkpXM8sonBJLFm18HqAmDMtwR9SIe+N
	 +Lkmqyxqhh6LlmscVVNeSsTqFNZMHUBLne5ePiPEXdBRlyGzLFDY29XZGr/yGzINlW
	 FNNJYktrgrl0g==
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
Subject: [PATCH v5 10/12] perf tests: Fix the Intel PT virtual LBR check
Date: Mon, 16 Nov 2026 23:53:02 -0300
Message-ID: <20261117025305.3958882-11-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117025305.3958882-1-acme@kernel.org>
References: <20261117025305.3958882-1-acme@kernel.org>
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

The record this check uses writes aux samples, and with the single data
page the other tests ask for they are lost:

  Warning: Processed 29 samples and lost 100.00%

so no branches are decoded and the check fails with "Failed with virtual
lbr".  Record with 4 data pages and 128 auxtrace pages: the same trace
decodes 64 branches and still fits the mlock budget.

Require the python perf module to provide session, not just to be
importable: a perf whose python bindings are not found can pick up an
unrelated module and fail with

  Error processing events: module 'perf' has no attribute 'session'

instead of skipping the subtest.

Detected building perf on fedora:44 on the runner with Intel PT hardware,
where the subtest failed with "Failed with virtual lbr" in the container,
and with the python error when run as root on the same machine.

Fixes: 915d6b14dc0c ("perf test: Migrate Intel PT virtual LBR test to Python API")
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/test_intel_pt.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index c0ecece0a8255124..511440b5956a6897 100755
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
+	# Check if virtual lbr is working.  This records aux samples, which a
+	# single data page overruns, so give it more room than the other tests.
+	perf_record_no_bpf -m 4,128 -o "${tmpfile}" --aux-sample \
 		-e '{intel_pt//,cycles}:u' perf test -w brstack || return 1
 	perf inject --itrace=L -i "${tmpfile}" -o "${perfdatafile}" || return 1
 	output=$("$PYTHON" "${shelldir}/lib/perf_brstack_max.py" -i "${perfdatafile}") || return 1
-- 
2.56.0

