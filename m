Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D04487CCB;
	Fri, 16 Oct 2026 21:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185707; cv=none; b=krrAP1U++TVFisIrHryRJu9xjTybwPQKziTnCw40rlQeWKKAl6Z3Sr7k2mlKLkJm+h1sq20Ffp+4rEzqRJkxVDgoy2qIBErC019CkSd2nj7fqD3rCpJSgaNOL6yAqqb2EGioagifTD3ruC9hwJH6aNIzRD3XhE75CsfNMwaDj8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185707; c=relaxed/simple;
	bh=J1ANDjFW3B/OVcU+v+e7FHQc8GZMSZ+NJ3zYi4+AsuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmhhGIf3EYJg++xnmGoMVprofvh7Xt+ou0kqx60vQploOVCj9GzUZEaN30VReG0UJu3r3MQZmiGPLuRHbz9s7eVCwyM0A6XR3dLjAc+HhJnKilOUBv6d6RMU5YMJmy9E2ltCABES4FXkuhgqTyX86Lh8Oug5pB5k1+Prv8VKb9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hoyh35Ir; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hoyh35Ir"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388891F000C5;
	Fri, 16 Oct 2026 21:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792185705;
	bh=xh/fOWK01/mrtVy7URa7Zle8xiDCJNDmcmJINOhtI4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hoyh35Ir2Nue1JrNOalPCMXDYzbHZUv4Iwc4BSZH5vHexJuAl7lx8sx4UDtfuyz4e
	 PdvzpVcjR88eAU6ZO2TQcVORqf9hCrKoGyeR+qz2FaMFAJe+ikmR5fy9QpZAXUym5f
	 mWlFlFvzO7wHggNkw/HZqPfZrP8nGAA4CsKO4MsL+XOBY/3TvGCummpS3RFhdXXbIU
	 TaObBwMAOx5MkJOOmdAlWu1FVwqsDj8erY67xiJTB1m/PpDHtVcYC8Fy64nFk5QvKp
	 4Mxx+K3jmpC0ZqOU5+lBbOYtSnSEBrTSkraVKUa5QsnzzUoqL2b/3teBTq78YIly7P
	 KmN+1uLMkcLCw==
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
Subject: [PATCH v4 11/21] perf test attr: Introduce mask_bits(), generalizing hide_core_pmu_type()
Date: Fri, 16 Oct 2026 18:20:52 -0300
Message-ID: <20261016212102.76550-12-acme@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016212102.76550-1-acme@kernel.org>
References: <20261016212102.76550-1-acme@kernel.org>
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
index fb866fb75175dc95..ee55fbe6f07bd7b5 100644
--- a/tools/perf/tests/shell/lib/attr.py
+++ b/tools/perf/tests/shell/lib/attr.py
@@ -80,24 +80,31 @@ PERF_TYPE_HW_CACHE = 3
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

