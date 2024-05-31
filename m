Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D20B80C0B;
	Fri, 31 May 2024 05:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717135116; cv=none; b=se9Ok9R4zw0qllRTNNXoeHe33eom64CfO36SR/4Ayskg+QVtsXoqjYCOaNhp9s3l1YLBhDxg8oqIDiBvbstVpyZ98kF8JzPXdAr9fVpewWN1saPytqtgboVxyJK1IKkVofGVB0ilpHCTnApQ2MFsKn6ZH8g2a4DQWNS4Il422sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717135116; c=relaxed/simple;
	bh=slKNaYFCfCUVvUBWMNMRl7R/A0UfgEYQGrVlHTOPBNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=He49i4q18pCUmXJdnuZTmKRLrsgUFjQ3LGgo2TJMyQ91NseIglJC1ay6HIbhxPSpYg9YjjHC7Axi/eH6rUSs1rZMP1TQpduKVIb+aufxyhaFAhI7QfZoJ7GxyZoAHg2F3eQ5gEvw6Ze/XlOLcebhfTp67QUNCZkJzSC5VS3ilBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X2vmOLaG; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X2vmOLaG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717135114; x=1748671114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=slKNaYFCfCUVvUBWMNMRl7R/A0UfgEYQGrVlHTOPBNo=;
  b=X2vmOLaGhp/hdufqHz93DwxNDtmQ9hlESjjSaGTFzyYptkDlLPta4XRJ
   E4e0C89fQU4INDvuv5kCvf0jVecl0o8BLiTGT+gfmv0dEsOAwF7g4MYA2
   0ZC2jWhg7oiDuviFhbO4lxiJXHgGux7mt4RV74CZz2xaHJ35Df38p89WQ
   5AX67wqTNjJfoYiiaC5dRRS/KKsBLNzIr5oLg3KodGMl0EIMiKZi5XG/U
   XdUMHA2g7UkizP7qRTtAgu9JnUFVa5cJbK3YL31Wo52hX49PeU49hQotT
   KGdvsL2laJsDLW5bPf2NptDRKQR18KXrhek9Da98G6wJDVr7iT5kbDf7B
   Q==;
X-CSE-ConnectionGUID: mJWQJ3bIRp2KWW6AGofGwA==
X-CSE-MsgGUID: DclTtSCVSRC7r9mX8lVH4g==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="25068265"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="25068265"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 22:58:33 -0700
X-CSE-ConnectionGUID: rmn1dvi5R4mGJB4R93UO9w==
X-CSE-MsgGUID: m4LJU07hSn2Q1Cd1xF4TTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="40510958"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.246.41.28])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 22:58:29 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V7 08/12] perf tools: Parse aux-action
Date: Fri, 31 May 2024 08:57:27 +0300
Message-Id: <20240531055731.12541-9-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531055731.12541-1-adrian.hunter@intel.com>
References: <20240531055731.12541-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Add parsing for aux-action to accept "pause", "resume" or "start-paused"
values.

"start-paused" is valid only for AUX area events.

"pause" and "resume" are valid only for events grouped with an AUX area
event as the group leader.  However, like with aux-output, the events
will be automatically grouped if they are not currently in a group, and
the AUX area event precedes the other events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Ian Rogers <irogers@google.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-record.txt |  4 ++
 tools/perf/builtin-record.c              |  4 +-
 tools/perf/util/auxtrace.c               | 67 ++++++++++++++++++++++--
 tools/perf/util/auxtrace.h               |  6 ++-
 tools/perf/util/evsel.c                  |  1 +
 5 files changed, 74 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 6015fdd08fb6..ccdba551e52d 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -68,6 +68,10 @@ OPTIONS
 		    like this: name=\'CPU_CLK_UNHALTED.THREAD:cmask=0x1\'.
 	  - 'aux-output': Generate AUX records instead of events. This requires
 			  that an AUX area event is also provided.
+	  - 'aux-action': "pause" or "resume" to pause or resume an AUX
+			  area event (the group leader) when this event occurs.
+			  "start-paused" on an AUX area event itself, will
+			  start in a paused state.
 	  - 'aux-sample-size': Set sample size for AUX area sampling. If the
 	  '--aux-sample' option has been used, set aux-sample-size=0 to disable
 	  AUX area sampling for the event.
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 66a3de8ac661..55afac03c39f 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -850,7 +850,9 @@ static int record__auxtrace_init(struct record *rec)
 	if (err)
 		return err;
 
-	auxtrace_regroup_aux_output(rec->evlist);
+	err = auxtrace_parse_aux_action(rec->evlist);
+	if (err)
+		return err;
 
 	return auxtrace_parse_filters(rec->evlist);
 }
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index e2f317063eec..9b7c2c76eab1 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -810,19 +810,76 @@ int auxtrace_parse_sample_options(struct auxtrace_record *itr,
 	return auxtrace_validate_aux_sample_size(evlist, opts);
 }
 
-void auxtrace_regroup_aux_output(struct evlist *evlist)
+static struct aux_action_opt {
+	const char *str;
+	u32 aux_action;
+	bool aux_event_opt;
+} aux_action_opts[] = {
+	{"start-paused", BIT(0), true},
+	{"pause",        BIT(1), false},
+	{"resume",       BIT(2), false},
+	{NULL},
+};
+
+static const struct aux_action_opt *auxtrace_parse_aux_action_str(const char *str)
+{
+	const struct aux_action_opt *opt;
+
+	if (!str)
+		return NULL;
+
+	for (opt = aux_action_opts; opt->str; opt++)
+		if (!strcmp(str, opt->str))
+			return opt;
+
+	return NULL;
+}
+
+int auxtrace_parse_aux_action(struct evlist *evlist)
 {
-	struct evsel *evsel, *aux_evsel = NULL;
 	struct evsel_config_term *term;
+	struct evsel *aux_evsel = NULL;
+	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (evsel__is_aux_event(evsel))
+		bool is_aux_event = evsel__is_aux_event(evsel);
+		const struct aux_action_opt *opt;
+
+		if (is_aux_event)
 			aux_evsel = evsel;
-		term = evsel__get_config_term(evsel, AUX_OUTPUT);
+		term = evsel__get_config_term(evsel, AUX_ACTION);
+		if (!term) {
+			if (evsel__get_config_term(evsel, AUX_OUTPUT))
+				goto regroup;
+			continue;
+		}
+		opt = auxtrace_parse_aux_action_str(term->val.str);
+		if (!opt) {
+			pr_err("Bad aux-action '%s'\n", term->val.str);
+			return -EINVAL;
+		}
+		if (opt->aux_event_opt && !is_aux_event) {
+			pr_err("aux-action '%s' can only be used with AUX area event\n",
+			       term->val.str);
+			return -EINVAL;
+		}
+		if (!opt->aux_event_opt && is_aux_event) {
+			pr_err("aux-action '%s' cannot be used for AUX area event itself\n",
+			       term->val.str);
+			return -EINVAL;
+		}
+		evsel->core.attr.aux_action = opt->aux_action;
+regroup:
 		/* If possible, group with the AUX event */
-		if (term && aux_evsel)
+		if (aux_evsel)
 			evlist__regroup(evlist, aux_evsel, evsel);
+		if (!evsel__is_aux_event(evsel__leader(evsel))) {
+			pr_err("Events with aux-action must have AUX area event group leader\n");
+			return -EINVAL;
+		}
 	}
+
+	return 0;
 }
 
 struct auxtrace_record *__weak
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 8a6ec9565835..f99e53426528 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -580,7 +580,7 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr,
 int auxtrace_parse_sample_options(struct auxtrace_record *itr,
 				  struct evlist *evlist,
 				  struct record_opts *opts, const char *str);
-void auxtrace_regroup_aux_output(struct evlist *evlist);
+int auxtrace_parse_aux_action(struct evlist *evlist);
 int auxtrace_record__options(struct auxtrace_record *itr,
 			     struct evlist *evlist,
 			     struct record_opts *opts);
@@ -801,8 +801,10 @@ int auxtrace_parse_sample_options(struct auxtrace_record *itr __maybe_unused,
 }
 
 static inline
-void auxtrace_regroup_aux_output(struct evlist *evlist __maybe_unused)
+int auxtrace_parse_aux_action(struct evlist *evlist __maybe_unused)
 {
+	pr_err("AUX area tracing not supported\n");
+	return -EINVAL;
 }
 
 static inline
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 434fbc331cd0..297e3a0bcf82 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1008,6 +1008,7 @@ static void evsel__apply_config_terms(struct evsel *evsel,
 			attr->aux_output = term->val.aux_output ? 1 : 0;
 			break;
 		case EVSEL__CONFIG_TERM_AUX_ACTION:
+			/* Already applied by auxtrace */
 			break;
 		case EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE:
 			/* Already applied by auxtrace */
-- 
2.34.1

