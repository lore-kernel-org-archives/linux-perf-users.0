Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61AC372;
	Wed, 29 Jan 2025 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738172365; cv=none; b=dglAVygtnMeEBi5FY4gwTD1NS3juVflz5vkpVpbiTLJizCvwef2AvVPZWgcqMvN9aunjRJuHZQoKl/XNjwN3m7WrqGiSldapEkvJe34ouWbL53hzluOZNFH55MHQuMpKGvqayLX6m0mqN4W61l66txQ2B4SIUq8pPKTWZBjK8gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738172365; c=relaxed/simple;
	bh=OUcKoKwz4+cAo4QoML8nMwUAwHEHYbpyL2eh7nmMeWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fm+JPRL3ORJAw5xrEXec1j5zg9YqEHhdIEAz6nDrU/BYQ4oGPRflHqKyE2HwNue9PJMm6wfSIiNaWqH5SjHHABq4gcJMPt8v+p8YdGGkd90fQZoEo1KAmSar7ulU1EC5lVn/CJT5wvDebLje/RBQqw0qzLG7obyHKPzePSYL3Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWhkxoai; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWhkxoai"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AC3C4CED1;
	Wed, 29 Jan 2025 17:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738172365;
	bh=OUcKoKwz4+cAo4QoML8nMwUAwHEHYbpyL2eh7nmMeWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GWhkxoai5EqMLW3Yn2lUP5BpxpJWHYI0/xKobTOfVZ3WehsodI1hjQwCpedZZ6G2E
	 XZ3pv8ZuTSIhBImADAIOMjK5QAk6MC6dlJSNKyQNEj7fg6EIlM7z/N5/X6x/Bg+uof
	 lRVXB8c4qXRxZjbA2gvNxIk2l20aRKMjdoxEd0ITAibLFMXjLafT4/NVp4txvZwW/J
	 KMG2lpcCWHazUSRf1m+uir1iIW/pZkIqAjRWb+7qW1gsD1Mq0TDMafQDQl3ctVC3Xr
	 JTwy4jlWdEl9Ncvzd9VOgw4g3X0ZOyCR3NZ/AkzTwHl1Ec3KBzr+BrmOARn/HRsQgx
	 WqnncJpsLQbJQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tdC26-00000004SdQ-3X9a;
	Wed, 29 Jan 2025 18:39:22 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <mchehab+huawei@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <mchehab+huawei@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <mchehab+huawei@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 4/6] tools: perf: task-analyzer: drop support for Python 2
Date: Wed, 29 Jan 2025 18:39:06 +0100
Message-ID: <54d6cc84b9b8408b7857fb2a5d72994cd5acf196.1738171937.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738171937.git.mchehab+huawei@kernel.org>
References: <cover.1738171937.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

As stated at process/changes.rsy doc, the current minimal Python
version is 3.x, so drop support for EOL python 2.x.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/perf/scripts/python/task-analyzer.py | 23 +++++-----------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/tools/perf/scripts/python/task-analyzer.py b/tools/perf/scripts/python/task-analyzer.py
index 3f1df9894246..9dc18875630c 100755
--- a/tools/perf/scripts/python/task-analyzer.py
+++ b/tools/perf/scripts/python/task-analyzer.py
@@ -50,25 +50,12 @@ LEN_IN_IN = len("99999999999.999")  # 15
 LEN_IN_OUT = len("99999999999.999")  # 15
 
 
-# py2/py3 compatibility layer, see PEP469
-try:
-    dict.iteritems
-except AttributeError:
-    # py3
-    def itervalues(d):
-        return iter(d.values())
-
-    def iteritems(d):
-        return iter(d.items())
-
-else:
-    # py2
-    def itervalues(d):
-        return d.itervalues()
-
-    def iteritems(d):
-        return d.iteritems()
+# py3
+def itervalues(d):
+    return iter(d.values())
 
+def iteritems(d):
+    return iter(d.items())
 
 def _check_color():
     global _COLORS
-- 
2.48.1

