Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8017B19D88A;
	Mon, 24 Jun 2024 22:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267649; cv=none; b=USI4T2hUPMsNUeTLXQXpXJCufIcuW7m8Xk96HxGKU9bnpdo+jHFRLKaQKcEU0rcIgWMSUrP6kWTyTxxKzjsUAVSEh+OQjAh7jySOJr9M5RPVe+14141IyAXznhwQrcyJJFxAOrqmpexleRiXjxVn8eRrHdtWJiBvGS6PZtOT3m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267649; c=relaxed/simple;
	bh=JpAWoEywdKvXlcM9uZ9uglnWMHdk9yJ7slIsntjFc5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbE6YOJZjLJukM12S5lGNMOle9ckzyIdeLwd0OnOvxzqj6CAtMol0dPDqbB6aWP7LprtzRmfqN7yBt5nrMrzqqFmdfroqURaBASYGs2pCpTPYc/nLwrIaeutAQC65w/uCvOWZTvlIqpHIyDlVo0Wtwlmf2e4mZ7Pzy6fpGyh9sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BRJRFdH8; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BRJRFdH8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719267647; x=1750803647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JpAWoEywdKvXlcM9uZ9uglnWMHdk9yJ7slIsntjFc5o=;
  b=BRJRFdH8KJDG0NSaNDQ5SX1cRdkqb0CfMHGDOuA5OTrxV9/Nh3cnJdYd
   fCVyU3yFaERx96Y/8LtWM6Vu2YN0Jvqa+lIdnVwGQCb6wW4yEOuobmSHQ
   X4IiWFzGmuy0MGkDJ3CJm5WQBYFa8sqa+mqpPbIEac07HlydBNf3j77xE
   CDrhtZmkr1sLLSGh2LXtDZEuGOw9XuuJvxJp5v/VcD3KtYLPzJ7SDZW4P
   AkGKvwnEgEyt9isaNyEmV7pozbB9ZUsKIysoSANBhD4jadkSlDVCwFkhY
   C0fwUXHbQYg/LIQZPSlrTjEv9y0KLW0iG+7uq5OaE/xNdI9W/tzDU0IqO
   w==;
X-CSE-ConnectionGUID: Z3hCcrwYR6W0stE+HfWtBg==
X-CSE-MsgGUID: dad01EeUSD+du4fMVVy7GA==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="41681605"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="41681605"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 15:20:45 -0700
X-CSE-ConnectionGUID: iaTIQS3IRQKer1H+wlfiSA==
X-CSE-MsgGUID: uyQorj4AQZSuZujjGWnwpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="48608217"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by orviesa004.jf.intel.com with ESMTP; 24 Jun 2024 15:20:45 -0700
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
Subject: [RFC PATCH v14 1/8] perf parse-events: Add a retirement latency modifier
Date: Mon, 24 Jun 2024 18:20:17 -0400
Message-ID: <20240624222026.229401-2-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240624222026.229401-1-weilin.wang@intel.com>
References: <20240624222026.229401-1-weilin.wang@intel.com>
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

