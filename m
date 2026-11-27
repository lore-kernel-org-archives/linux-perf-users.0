Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795743525;
	b=5VPIM40HTyvFxouEV4Vg9Tpsw0JBcVzX5o/WTfmNh2XF+7BPJIkxMcOj5ddFW1n9j2hC
	 D6W1x9iTlPP8s6jgfaI2XU+Kw9+7QdvY6dcF+w4b77qcACuMM5ERnZLkwjv+VP8kWm3Mb
	 eVpqM9e3GdumSk1P05nJTUmGP2Jr4L8WOgdm2OKA2FVl52DuFvWICwJpXM57LwwLAu6Wj
	 KEA9GWHA4/wn4vI+w/8EJFjuO0p45pMBj2DnpApwq44wRpIzz/SGe4xiAI2AhGWw2sVoI
	 t3VoaeveTiHXTsfVDL5x8CirbVflqXB6wak1QrrRSA7ZT+24PvKklfp/Kp9PLLcUqug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795743525;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TMiRfIRA0Tu1oy6Htb3mclDEbrrcXq0iN4bugKXLH94=;
	b=fXu8iewJBXVYZs9b+1JiHKNVBZwOSnvZEgK3tDDxrKYjTDBT9CggqATVMNWCXKukcp6D
	 casrayhwR76Ofn8mzPvJut6WOpwNzyUd0kVsO/xC9oIE1DF61eHSaFpFQ0d3yD34308Jk
	 ubj3XnEsdlCy2UWeB6djQysS6LP383orjmsuHgCGzZvxjKx5XIruzTaQkb2I9dMAPsPry
	 oFkCcRLAnLKAtiFk90suzbzxvHT3mDivS/IZ/cDw3LK92HoexFb9CtG4mbBPRBy9yooI8
	 m8M2V873fH6hcjkUyvuSVb35brEpwdlP5anQ5XRMiHByTMw0Kb4dgPPT/j/qY3QOFwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XN1Aq8n8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F177E606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 01:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XN1Aq8n8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92D91F008A0;
	Fri, 27 Nov 2026 01:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795743524;
	bh=TMiRfIRA0Tu1oy6Htb3mclDEbrrcXq0iN4bugKXLH94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XN1Aq8n8QNxdj9mZ/I0CtHKgIvR34fq9RHZK/v9DbNYuDrAmMJhF7inO7ZoSsGS9p
	 qHtaAlrOrFirSpvfW43XeyNSk262pf4jT17DKn/+E2tueWfpagYU2T4u9kWaJ6HCvR
	 /jc2bNkDzpHVKeGFh/MStPriY30bdHx/EUwQHEOhxFLWEgDq9caMW1jS63m8QmCRYC
	 5NYX/Ed+xTytForZNCg/wbGjylSt/CoVoNdpAvoqZg6JH7bPonIaYFjotvkAVVf72Z
	 HusIWExnwysWr89bAWgbSuP2klBN09K/ALoiwYSo9wjJaQ3Ol2kDTar/0VtW7Jykew
	 PxRn7X6++HdEg==
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
Subject: [PATCH v2 09/18] perf tests annotate: Exercise the output and filter options
Date: Thu, 26 Nov 2026 22:37:52 -0300
Message-ID: <20261127013801.14841-10-acme@kernel.org>
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

The annotate test covers the stdio and pipe modes.  Add the --stdio2
output, --print-line, --asm-raw with --show-total-period,
--show-nr-samples, --percent-type and the DSO filter, the last one
checked by also annotating through a DSO that is not in the data.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/annotate.sh | 64 ++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/annotate.sh
index 26411edf5cb4ece1..d799414690402fc0 100755
--- a/tools/perf/tests/shell/annotate.sh
+++ b/tools/perf/tests/shell/annotate.sh
@@ -105,8 +105,72 @@ test_basic() {
   echo "${mode} annotate test [Success]"
 }
 
+test_options() {
+  echo "Options annotate test"
+  perf record -o "${perfdata}" ${testprog} 2> /dev/null
+
+  # --stdio2 prints each instruction with the symbol header
+  if ! perf annotate -i "${perfdata}" --stdio2 -s "${testsym}" 2> /dev/null | grep -q "${testsym}()"
+  then
+    echo "Options annotate [Failed: missing --stdio2 output]"
+    err=1
+    return
+  fi
+
+  # -l/--print-line prints a summary of the annotated file with source lines
+  if ! perf annotate -i "${perfdata}" --stdio --print-line -s "${testsym}" 2> /dev/null | grep -q "Sorted summary for file"
+  then
+    echo "Options annotate [Failed: missing --print-line output]"
+    err=1
+    return
+  fi
+
+  # --show-total-period adds a period column; --asm-raw is the default
+  if ! perf annotate -i "${perfdata}" --stdio --asm-raw --show-total-period -s "${testsym}" 2> /dev/null | grep -q "Period"
+  then
+    echo "Options annotate [Failed: missing --show-total-period output]"
+    err=1
+    return
+  fi
+
+  # --show-nr-samples adds a samples column
+  if ! perf annotate -i "${perfdata}" --stdio -n -s "${testsym}" 2> /dev/null | grep -q "Samples"
+  then
+    echo "Options annotate [Failed: missing --show-nr-samples output]"
+    err=1
+    return
+  fi
+
+  # --percent-type selects the percentage type shown in the header
+  if ! perf annotate -i "${perfdata}" --stdio --percent-type global-period -s "${testsym}" 2> /dev/null | grep -q "percent: global period"
+  then
+    echo "Options annotate [Failed: missing --percent-type output]"
+    err=1
+    return
+  fi
+
+  # -d limits the annotation to the given DSO: perf has the symbol, a
+  # DSO absent from the data produces no annotation
+  if ! perf annotate -i "${perfdata}" --stdio -s "${testsym}" -d perf 2> /dev/null | grep -q "Disassembly of"
+  then
+    echo "Options annotate [Failed: missing -d output]"
+    err=1
+    return
+  fi
+
+  if perf annotate -i "${perfdata}" --stdio -s "${testsym}" -d nonexistent-dso 2> /dev/null | grep -q "Disassembly of"
+  then
+    echo "Options annotate [Failed: -d did not filter the DSO]"
+    err=1
+    return
+  fi
+
+  echo "Options annotate test [Success]"
+}
+
 test_basic Basic
 test_basic Pipe
+test_options
 
 cleanup
 exit $err
-- 
2.56.0

