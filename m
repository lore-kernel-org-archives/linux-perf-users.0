Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C61F54A7FD;
	Tue, 13 Oct 2026 20:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922495; cv=none; b=sn1/xVd8ta6Vx9UStUWtKEgF/XJGvqQUtJSo9CQp3cDlStf33Pnw9SXYtPInA+SCtX/5poAxafrRAc/oE0VIH4E4V1fyQrZYXtJLgnVneV7AiuvdqYhqkPLIpvUVNPxQZwpSaf5EofQQiujtewYJOciBlhuM/lVs+JjGG9KQL6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922495; c=relaxed/simple;
	bh=2pah7aneRmk/VwD7rFZ651U2HVcO64QHZQpk6C/3s4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ME9JNHgRNEGhW9S5LUEUWv8kJ5CepE2I9YznP+wBnuDRE5aFp1t52J1wY878i0Shnv4dmyOXmGx+GU8HQ1D4DjKsLNciT57lQkI6t9TrXkDEQGSBqATCQ4mT74XeeBMP7rVSG/KtSDkX0eK2MY6TrL2Mo1rzrBtFqnh2uRNppho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWowsAdD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWowsAdD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2C21F000FF;
	Tue, 13 Oct 2026 20:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791922492;
	bh=1JHTAQY5lRazigJWTIbB4IaVqEjKG6H0hJaojh3mmZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CWowsAdDP9vD0ZBvE9O+s4T1PZpiPKwC3+iLucnwztz21CgHzbUEYRMJ3+PxZigMZ
	 yhHcQCA5Umewf7bhSNPL3pmd+7+bQ7gJqxC6NouRiV7gW82j7gxVbnpMrdvJZmMAd6
	 VW8A5I2F87wsGS0B8DYfUFQhJcKnTSPLe+x7+maEIxoKfBThK3RS+J0xXgBrNXsZTK
	 CD2S31Rc6J4H5XgV8Ci7RoQx4o+GozojMCfhEfH+78N6ATjftyUbojAzvGO3Sn0PBt
	 vb0d5nOMycJOov7cvXxsTrKz5TPthTqmnY2YczZk7w5630JvmlXfK6gyElWm9MIBgO
	 EAg3atkaBId5g==
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
Subject: [PATCH v2 09/19] perf test attr: Introduce mask_bits(), generalizing hide_core_pmu_type()
Date: Tue, 13 Oct 2026 17:14:04 -0300
Message-ID: <20261013201415.36428-10-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013201415.36428-1-acme@kernel.org>
References: <20261013201415.36428-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

What hide_core_pmu_type() does is take a set of bits out of each of the
'|'-separated alternatives in a value, wildcards included, keeping the
rest of the expression: extract that as mask_bits() and implement
hide_core_pmu_type() in terms of it, a prep for using the same thing to
ignore, when comparing expectations, the sample id bit perf ends up
asking for and the read_format group bit that a PMU count can remove.

No change in behaviour.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/lib/attr.py | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/shell/lib/attr.py b/tools/perf/tests/shell/lib/attr.py
index 70ff73585cb3ffa9..151b884670952e9f 100644
--- a/tools/perf/tests/shell/lib/attr.py
+++ b/tools/perf/tests/shell/lib/attr.py
@@ -64,24 +64,31 @@ PERF_TYPE_HW_CACHE = 3
 # type in its top 32 bits when there is more than one core PMU.
 LEGACY_TYPES = (str(PERF_TYPE_HARDWARE), str(PERF_TYPE_HW_CACHE))
 
-def hide_core_pmu_type(value):
+def mask_bits(value, bits):
     """
-    The kernel can be told which core PMU a legacy type event is meant for by
-    putting its type in the top 32 bits of 'config', which perf only does when
-    there is more than one core PMU, so take those bits out to keep the
-    expectations written for the single core PMU case matching on
-    heterogeneous machines.
+    Take the bits in 'bits' out of each of the '|'-separated alternatives in
+    'value', keeping the rest of the expression, wildcards included.
     """
-    hidden = []
+    masked = []
 
     for alternative in value.split('|'):
         try:
-            alternative = str(int(alternative, 0) & 0xffffffff)
+            alternative = str(int(alternative, 0) & ~bits)
         except ValueError:
             pass
-        hidden.append(alternative)
+        masked.append(alternative)
 
-    return '|'.join(hidden)
+    return '|'.join(masked)
+
+def hide_core_pmu_type(value):
+    """
+    The kernel can be told which core PMU a legacy type event is meant for by
+    putting its type in the top 32 bits of 'config', which perf only does when
+    there is more than one core PMU, so take those bits out to keep the
+    expectations written for the single core PMU case matching on
+    heterogeneous machines.
+    """
+    return mask_bits(value, 0xffffffff00000000)
 
 class Fail(Exception):
     def __init__(self, test, msg):
-- 
2.55.0

