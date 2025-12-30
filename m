Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DD231ED8E;
	Tue, 30 Dec 2025 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767113546; cv=none; b=VYp3nBPukXDvtLXnU2gYWv+ajnNojaSIyCMJQ7SqF1DkIvF11gQn989wVLKOeKr+tSrwkUMfJMNbQw+3L+vACbJ/lhFTgF8XhPDm3SJzLnPc2K8uk8HZwtYBZR7G6D3THHWkE8pZIDO1iYp/ZSJ3ulquW0SzCOz1fVxNXCvNXKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767113546; c=relaxed/simple;
	bh=D/dBMDonlDLMGKEPvBvPow2MN4ClyWio2trDRETBmMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XmTIOF6t19nUU1DXM5UdAJ1Y6LAklf4aA0Xwe0I1E7tJs1kLPFoa9eV8FjBk6biWpo+3eb//Uyi10kBvqOOUuWWZ0fs1ZfkJ798QTmHOnsseBklWkWS97mxFXtr4mK1CzD35Ibws9S6msa65sWzcklv2Sc3mvtfCX7YcnvUcwGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=fLSK/HfZ; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="fLSK/HfZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HYSYgrvVps2W2lKeMqLs6ZuV0M/yrfGdcJmJkszcwvg=;
  b=fLSK/HfZiJugxpL1zXvfO5GQrHFMd8Sq01rtkwu3Gh7gvE7zMccIqVI6
   xRUhJjervBtfq2u+6mW+hfyQ52g+MQs7aVQX/0ZVZMbH2T3dJf01JN6IY
   d4PV7ZhFBOoH6gWcv6qztFRwuoAulwZwGeh/7fzoTsIJnOmYl2vQ1QwHH
   Y=;
X-CSE-ConnectionGUID: X9pPQWKjRyOA58+0cffd/w==
X-CSE-MsgGUID: PhBdai+TTHCyLyu5FSwBIw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.21,189,1763420400"; 
   d="scan'208";a="256363407"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.102.196])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 17:52:20 +0100
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Peter Zijlstra <peterz@infradead.org>
Cc: yunbolyu@smu.edu.sg,
	kexinsun@smail.nju.edu.cn,
	ratnadiraw@smu.edu.sg,
	xutong.ma@inria.fr,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/perf/util/addr_location.c: update outdated comment
Date: Tue, 30 Dec 2025 17:52:13 +0100
Message-Id: <20251230165213.102961-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function addr_location__put() was renamed addr_location__exit()
in commit 0dd5041c9a0e ("perf addr_location: Add init/exit/copy
functions").  Make the comment preceding the function consistent with
the function itself.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 tools/perf/util/addr_location.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/addr_location.c b/tools/perf/util/addr_location.c
index 007a2f5df9a6..81a0b79c5e10 100644
--- a/tools/perf/util/addr_location.c
+++ b/tools/perf/util/addr_location.c
@@ -24,7 +24,7 @@ void addr_location__init(struct addr_location *al)
  * The preprocess_sample method will return with reference counts for the
  * in it, when done using (and perhaps getting ref counts if needing to
  * keep a pointer to one of those entries) it must be paired with
- * addr_location__put(), so that the refcounts can be decremented.
+ * addr_location__exit(), so that the refcounts can be decremented.
  */
 void addr_location__exit(struct addr_location *al)
 {

