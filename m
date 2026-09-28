Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2463A8FE1
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620031; cv=none; b=nha82xKuysOkvmZPgGyJB1fVdutkpNqn2HtTTJsNYkKEqcNwsqF29K/OVqns2wJYT/jQZ4F9olUbl0/N3hOnnbl6fHROPWTvHCt0ma7f7dgG1XviBSPiXCz0nNLNI46/szzOfyPTLwIbCenQv0j6GH2lPgIefywZHVUQQDVyxa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620031; c=relaxed/simple;
	bh=LgtVYmYYjZGx2E5XEYwimEb1Rmmm58Jicr8ogBMYz7o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W1yyeZtWb0+JlQ00ec48SyZeB/dJwuYMxYg9w6hydG8Cs7xgryZCE0ePeNjQLpC2LOw0/4bDL1GC2Awo7H+YxG7Zab1iEhu6JUKzufbVpCi2gplz/Wpt8RdbkWSrfisOibRsqiDqeSsNKsHbM9gzPDvk8OGZ7pV0iKbuyiKmrwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jt8UK/CV; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jt8UK/CV"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-342a0e1d8c4so6345604eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 11:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790620025; x=1791224825; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FRQQMNhGkLmQqsTmp45ej8ZrRHZHm42lQ/FqMbIRTGU=;
        b=jt8UK/CVV0YhSzRQmSu9XOVafKDklVp//OMHwrHlNHlwQLo67fYPKgy+9zsc64x0aN
         elq8tQLHNUM+tEAUxiICp4d8uWHWcrg6nMYJyuzZJTafvGqq97f7TPlWI4FGPQCB7Y3/
         kj+1Njm+Tx7WCRdITAPbD6rthOJNYl/Vjae8z1Pp/ABmBm2rz296ODMT1CF3AbN5Ihto
         +yU3Fl9o6mZ09OQPSWtcY72hNz+LdA+2U+CYMYwgUWJAcXIvkqTTFaD3vUM73fxN+uJ2
         n0WwIV4jtkIMzpFQoW/YW6r+Oc1eH0OkLOfvFv+nrRLX187cifXSLQ4d0v8JrRDwaozj
         VRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790620025; x=1791224825;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FRQQMNhGkLmQqsTmp45ej8ZrRHZHm42lQ/FqMbIRTGU=;
        b=Pxp/oijW6ZSi2sA4+bTZvu/CDSKR59YBxvrP/JnYxNckRKr4b8XMFCYOtHzDcHnN+Z
         aiOavrHKZ4h/wFekrUhnr82XHiyhZDGPYY2qVi8oeq5osnwZQXBuuY71aDAyeeQJeVgQ
         kyQGPSS1RtDjLdap691GAdVEC/b/QhamS8FaLmznox+t3gY8zdNUHVa+Jw79pLH+J8x7
         SN/0RP+SlCgNQqQGsN2zh/MlCXHpUrEw2WARe2L9b3lpYZHQDyInJrPf58O7/PxTy9UB
         jQyRZrFcD8vpbtLMIa6MECWaC08Ba50X5HHuk1W8uRbLoEPOxaLfT6YITmzkR1wVu/yT
         gaNw==
X-Forwarded-Encrypted: i=1; AKwUvBw48qF6iTA394mx94zHNJ+T++r97OwVuAKY9F8HE2Q7ZAb1ve33+03aka7DAuKg6BR6bmjg61uNcx/pIZ8LjJ+l@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0jQYvg/oS/vBNRisdjd4Vp7NF6CeGQIU3wAUy2t0gVq+Abhyj
	h2Z0oIrFPttV1uzufjvhkaw2yGWsmS8PH3QMvQ8utEUxaFXdEpri6sCe462m9RCTo6PdAD/Ub2+
	9gED39/FEoQ==
X-Received: from dycns17.prod.google.com ([2002:a05:7300:f791:b0:341:5e3f:58de])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1c19:b0:33c:130b:457
 with SMTP id 5a478bee46e88-3427384926dmr10548504eec.38.1790620024077; Mon, 28
 Sep 2026 11:27:04 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:26:02 -0700
In-Reply-To: <20260928182605.3649015-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com> <20260928182605.3649015-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928182605.3649015-24-irogers@google.com>
Subject: [PATCH v6 23/26] perf test trace_summary: Improve error diagnostics
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>
Cc: Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

On a mismatch print the command, the match count, the matching lines and
the end of the output.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/trace_summary.sh | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/trace_summary.sh b/tools/perf/tests/shell/trace_summary.sh
index d5da1d7d8d88..273199a29a20 100755
--- a/tools/perf/tests/shell/trace_summary.sh
+++ b/tools/perf/tests/shell/trace_summary.sh
@@ -27,10 +27,15 @@ test_perf_trace() {
 
     count=$(grep -E -c -m 3 "${search}" ${OUTPUT})
     if [ "${count}" != "3" ]; then
-	echo "Error: cannot find enough pattern ${search} in the output"
-	cat ${OUTPUT}
-	rm -f ${OUTPUT}
-	exit 1
+        echo "Error: cannot find enough pattern ${search} (count=${count}) in output of:"
+        echo "Error:   perf trace ${args} -- ${workload}"
+        echo "Error: matched lines:"
+        grep -E "${search}" ${OUTPUT} || echo "none"
+        echo "Error: last 20 lines of output:"
+        # The summary comes last, after any -S trace output.
+        tail -n 20 ${OUTPUT}
+        rm -f ${OUTPUT}
+        exit 1
     fi
 }
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

