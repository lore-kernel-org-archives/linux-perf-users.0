Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021251BBBF1;
	Tue, 22 Oct 2024 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612843; cv=none; b=HgiGeiPEEVGHxXrPH43McR4pMTKt4pcPPTET3PydZ8IlYBwrvJvWuv2wOg3Ml5l3LBz4m1drseyOKfeVGkWX7eMZT8jti5wmetqbjb9zPFVXqDXR+X48NV2eDJxzhsxfR2NGiSeI960zbMoBuKUsHjixg+mBRP0qL1FJchA3ba4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612843; c=relaxed/simple;
	bh=KWespt12ZpxgPDw6K3joQvQ6R1T4arlW4Liwkh6KyJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbIdIwOKXhIXoWcVmHut3Clfr6bmrX1zE3UDTallQhWuaaO2kw6SeY5YlMAkzyQRyTqlHrLMb9QFaoiA8Xtu5QyEWEChGV81SD1A31708oTIpRHZgB1ID/LYdGarK4aUNRqfKL21M/5Q7aphFZqcGBQOyQXbXZNwE1v5Oj+eJz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O4SnZaLA; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O4SnZaLA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729612841; x=1761148841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KWespt12ZpxgPDw6K3joQvQ6R1T4arlW4Liwkh6KyJc=;
  b=O4SnZaLA3OFSIW2Y6Onu0p1my/J6iTVQYBed+WX8/5HjQjnVZEaW2/mo
   ozwnsmQFErO68e+GNQDLakCbx9OM/2PqrNGk7vRsqcG9Ig5xScIMT3bwR
   /eECt2yCpHYJIj060AB5ApJejExkf++fjFOh0CpQOmCdXv5+TwSunCgYa
   gcwcBYQxjtEvYjCYE3drxDiIANTR4rMXg+/vXGh0sbQm6Wg79sMQXMPHt
   mxlZCBRGicvZ30oq+3Xds/OiOaDqAya2L9nWTKpRezhqsx1TWa6Z56fI9
   ptQuu9FStwaCa7yov5iTcnP7t3mdqey8JLxFRwgBWzjtj8r3S6zup69Th
   Q==;
X-CSE-ConnectionGUID: P3HqjIA5TGK92DYc85v0/w==
X-CSE-MsgGUID: 2IK6Ok7hQYGtNZ6oQ83Hfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="29271044"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="29271044"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 09:00:40 -0700
X-CSE-ConnectionGUID: 3WQCNMrzRIa/F8k5So1wvw==
X-CSE-MsgGUID: Y/SzASDFTe6WCIqjeAQATQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="79858679"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.ger.corp.intel.com) ([10.246.16.81])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 09:00:30 -0700
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
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	H Peter Anvin <hpa@zytor.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V14 07/11] perf tools: Parse aux-action
Date: Tue, 22 Oct 2024 18:59:13 +0300
Message-ID: <20241022155920.17511-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241022155920.17511-1-adrian.hunter@intel.com>
References: <20241022155920.17511-1-adrian.hunter@intel.com>
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


Changes in V8:
	Fix clang warning:
	     util/auxtrace.c:821:7: error: missing field 'aux_action' initializer [-Werror,-Wmissing-field-initializers]
	     821 |         {NULL},
	         |              ^


 tools/perf/Documentation/perf-record.txt |  4 ++
 tools/perf/builtin-record.c              |  4 +-
 tools/perf/util/auxtrace.c               | 67 ++++++++++++++++++++++--
 tools/perf/util/auxtrace.h               |  6 ++-
 tools/perf/util/evsel.c                  |  1 +
 5 files changed, 74 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 242223240a08..80686d590de2 100644
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
index adbaf80b398c..a7afde2fbebc 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -860,7 +860,9 @@ static int record__auxtrace_init(struct record *rec)
 	if (err)
 		return err;
 
-	auxtrace_regroup_aux_output(rec->evlist);
+	err = auxtrace_parse_aux_action(rec->evlist);
+	if (err)
+		return err;
 
 	return auxtrace_parse_filters(rec->evlist);
 }
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index ca8682966fae..4d1633d87eff 100644
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
+	{.str = NULL},
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
index a1895a4f530b..208c15be9221 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -579,7 +579,7 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr,
 int auxtrace_parse_sample_options(struct auxtrace_record *itr,
 				  struct evlist *evlist,
 				  struct record_opts *opts, const char *str);
-void auxtrace_regroup_aux_output(struct evlist *evlist);
+int auxtrace_parse_aux_action(struct evlist *evlist);
 int auxtrace_record__options(struct auxtrace_record *itr,
 			     struct evlist *evlist,
 			     struct record_opts *opts);
@@ -800,8 +800,10 @@ int auxtrace_parse_sample_options(struct auxtrace_record *itr __maybe_unused,
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
index 8f7932cd5550..95593b55d9a7 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1105,6 +1105,7 @@ static void evsel__apply_config_terms(struct evsel *evsel,
 			attr->aux_output = term->val.aux_output ? 1 : 0;
 			break;
 		case EVSEL__CONFIG_TERM_AUX_ACTION:
+			/* Already applied by auxtrace */
 			break;
 		case EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE:
 			/* Already applied by auxtrace */
-- 
2.43.0

