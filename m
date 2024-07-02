Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834E8191F78;
	Tue,  2 Jul 2024 22:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719958087; cv=none; b=gOYANS0ej/oG3ew78nRuPBZDhDF7/XBVISfEPtN3PzJQrfSRNym0ylL8XfpQQS7tcUzayST/W0ueVO0QXNg3XKgGdmfrsI9Fq3UwiLG6ggi6zziySZKbANqPPRRJ4x5l17daNLvrKs/yxZVBpBuF5fVtq+aN4TBDS0aEgk2v4oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719958087; c=relaxed/simple;
	bh=JpAWoEywdKvXlcM9uZ9uglnWMHdk9yJ7slIsntjFc5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZ7Ji7Xr5VZVc7CwXaryiBitsd4axg40giDLn/82MLLZ+ogDLT5SIiFIvgR2//0W0zep0NuWvSLsaOi29htLiXdouBR0W7R6U5GFajd+5syqnUF7NHTYcBdBLLyR5TiZ9qLpR8keclMXrwVYECX3zkHNmLCWJDKRIifilvYC1Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mTwOoSru; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mTwOoSru"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719958086; x=1751494086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JpAWoEywdKvXlcM9uZ9uglnWMHdk9yJ7slIsntjFc5o=;
  b=mTwOoSruTWePKXV6TuEWu3yZE4SvBCu5fMrCQeKYiS05T52/l0w94PvG
   8s0Og1aUeqh+qqHI1sCJtSb7W6TknzqerIoATHNPGvvPvuIR+FZwpVB17
   sFqVQ/f5ypdcrs+TN7E5Hd1XeZozmGMi/mwIEBHUWNTx1LRHHsQbQio7N
   d1XaLHb5VCkv92ovTiMcv7p1IwHu1D3Y2YhDgidNFTNnuRkjvJ17Of+GC
   wpPffOXYjW71QXm7yq8FMbNY/8XskOLXvRAA9b0zSy9JKe3WsG8jxZkCr
   CB01GwBnZvzCoS9paUbal4enBBoHs/fSCHQz6yZVsWD8M9nJZx12UQY9D
   A==;
X-CSE-ConnectionGUID: 5rD0vMQASXaOQVjv4qicHA==
X-CSE-MsgGUID: /0bO4C8/THKR8Z0Zyb42vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17296891"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="17296891"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 15:08:04 -0700
X-CSE-ConnectionGUID: VnP7QVEgRIqoeEWAYNdeBQ==
X-CSE-MsgGUID: i5fDMGe0TJC7hfqayyD39w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="50888192"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by orviesa003.jf.intel.com with ESMTP; 02 Jul 2024 15:08:03 -0700
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v15 1/8] perf parse-events: Add a retirement latency modifier
Date: Tue,  2 Jul 2024 18:07:48 -0400
Message-ID: <20240702220757.262825-2-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240702220757.262825-1-weilin.wang@intel.com>
References: <20240702220757.262825-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Rogers <irogers@google.com>

Retirement latency is a separate sampled count used on newer Intel
CPUs.

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/evsel.h        | 1 +
 tools/perf/util/parse-events.c | 2 ++
 tools/perf/util/parse-events.h | 1 +
 tools/perf/util/parse-events.l | 3 ++-
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 80b5f6dd868e..14f777b9e03e 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -98,6 +98,7 @@ struct evsel {
 		bool			bpf_counter;
 		bool			use_config_name;
 		bool			skippable;
+		bool			retire_lat;
 		int			bpf_fd;
 		struct bpf_object	*bpf_obj;
 		struct list_head	config_terms;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 321586fb5556..fab01ba54e34 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1811,6 +1811,8 @@ static int parse_events__modifier_list(struct parse_events_state *parse_state,
 			evsel->weak_group = true;
 		if (mod.bpf)
 			evsel->bpf_counter = true;
+		if (mod.retire_lat)
+			evsel->retire_lat = true;
 	}
 	return 0;
 }
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index e13de2c8b706..b735cd9e0acf 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -203,6 +203,7 @@ struct parse_events_modifier {
 	bool hypervisor : 1;	/* 'h' */
 	bool guest : 1;		/* 'G' */
 	bool host : 1;		/* 'H' */
+	bool retire_lat : 1;	/* 'R' */
 };
 
 int parse_events__modifier_event(struct parse_events_state *parse_state, void *loc,
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 16045c383ada..5a0bcd7f166a 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -209,6 +209,7 @@ static int modifiers(struct parse_events_state *parse_state, yyscan_t scanner)
 		CASE('W', weak);
 		CASE('e', exclusive);
 		CASE('b', bpf);
+		CASE('R', retire_lat);
 		default:
 			return PE_ERROR;
 		}
@@ -250,7 +251,7 @@ drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
  * If you add a modifier you need to update check_modifier().
  * Also, the letters in modifier_event must not be in modifier_bp.
  */
-modifier_event	[ukhpPGHSDIWeb]{1,15}
+modifier_event	[ukhpPGHSDIWebR]{1,16}
 modifier_bp	[rwx]{1,3}
 lc_type 	(L1-dcache|l1-d|l1d|L1-data|L1-icache|l1-i|l1i|L1-instruction|LLC|L2|dTLB|d-tlb|Data-TLB|iTLB|i-tlb|Instruction-TLB|branch|branches|bpu|btb|bpc|node)
 lc_op_result	(load|loads|read|store|stores|write|prefetch|prefetches|speculative-read|speculative-load|refs|Reference|ops|access|misses|miss)
-- 
2.43.0

