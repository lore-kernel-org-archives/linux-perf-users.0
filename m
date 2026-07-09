Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53893D34AB;
	Thu,  9 Jul 2026 22:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783635471; cv=none; b=Hxg9zXUVYkbB/cOH2aTXMu1kgrkswh7nUwnu9YQKt9ev22FudZjZHUEHmqTPebZDmf5d8Sr+9PesIDtbQQOPnHn5PGnHSgqFtUmq4GgvO0zbKTRoc5mqEtUyNfoPL4IRuEVT+NSqB0mU009aPX2nZrronTg9RVPjdgqdXS4z2ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783635471; c=relaxed/simple;
	bh=7K+mVOAfd7O7mBrvuCC+ocZBM74EZhw605+3UoxF3Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqJeVy2Zp43146e2nJNpZalxvQ9Hgias7cGh/98MEO8YSUX2NLFfGvv3RHMrFDkyLtAkayp2LezwCzifm+DiKgM0gVn5P2HwQ+QgdNx7fUblX95Z6rSqTw7dpa0UGB6hyTLNY5RaX7EYNhAQUdtEq3AeZjcQHRvsaFLiSejv1j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fnLjyAcv; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fnLjyAcv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783635470; x=1815171470;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7K+mVOAfd7O7mBrvuCC+ocZBM74EZhw605+3UoxF3Sg=;
  b=fnLjyAcv9XkhiejJvvClygrGEQ/IHW6U+mq6XM2ilEh7TH/ZJT/d7nq9
   3Oy2+pJyPcdpyAHMKJ8a7jHU9qQr/6hdgosOngQka8dpoAqu1W5X6FlOm
   tjTTXfzXYiDQrBOBQ8h9UY+gLmQhp6uH5wexNCSy6mOKbJvppWHBabVkk
   cCsG5tAtqPDrDIai7MgDlDE+ofm08yTtWubZ4SDkYce+9BsiKh9bfyK0L
   zTs/Z1jStGjxw/6/vmUn7k40VomfhK51wvdlar0bvKZp49KugVPnXK+W6
   fkpvRPaLqcVykh46UVSHF5lIyVirypMPvDdENxik1ALspGuTMU8d9XAoz
   w==;
X-CSE-ConnectionGUID: kulhTw4gRhi6KuB4J1oe+w==
X-CSE-MsgGUID: NSncNk5jQziX1MnymursDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88163366"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88163366"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 15:17:49 -0700
X-CSE-ConnectionGUID: nMtNcN1BRziGrTy6/l5pnA==
X-CSE-MsgGUID: p1FPGW+pSCWWG5nbJP56cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259620880"
Received: from khuang2-desk.gar.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.223.97])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 15:17:47 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 1/6] perf mem: Fix size tracking for mem_lvl's in perf_script__meminfo_scnprintf()
Date: Thu,  9 Jul 2026 17:17:31 -0500
Message-ID: <20260709221736.33446-2-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709221736.33446-1-thomas.falcon@intel.com>
References: <20260709221736.33446-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When printing memory info in perf script, the entire size of the
buffer is passed to perf_mem__lvl_scnprintf() instead of the remaining
size. Pass the remaining buffer size instead.

This issue was detected by sashiko during an internal code review.

Assisted-by: Sashiko:gemini-3.1-pro-preview
Fixes: fdefc3750e847 ("perf mem: Print memory operation type")
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/util/mem-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 0b49fce251fc..4e490f9cd348 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -610,7 +610,7 @@ int perf_script__meminfo_scnprintf(char *out, size_t sz, const struct mem_info *
 	i += scnprintf(out, sz, "|OP ");
 	i += perf_mem__op_scnprintf(out + i, sz - i, mem_info);
 	i += scnprintf(out + i, sz - i, "|LVL ");
-	i += perf_mem__lvl_scnprintf(out + i, sz, mem_info);
+	i += perf_mem__lvl_scnprintf(out + i, sz - i, mem_info);
 	i += scnprintf(out + i, sz - i, "|SNP ");
 	i += perf_mem__snp_scnprintf(out + i, sz - i, mem_info);
 	i += scnprintf(out + i, sz - i, "|TLB ");
-- 
2.43.0

