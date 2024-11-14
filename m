Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535771FCF5B;
	Thu, 14 Nov 2024 10:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731579457; cv=none; b=eduJARzTilgDe3PgTg/OUc8GHSvbdhfHEE6o/JU/uYAp9rqW8C4raFVSP7fSTadAt+EwF9WP7VWGKxrz9NXUDKl98xDEdXORelEf52H8aPCEEzjYhlKrXIe/NmFXn3HOYz3xqYls6Y51SQvVhXQuTxC7U+GrFEI6kYSLj9yR3/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731579457; c=relaxed/simple;
	bh=RYQmAW0/WxNKlis/R8jRVnI3QK9po7ymrTybzUTjbYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=heGECo/eyCTPMCOo9wUPdvmHRNOExhN7NDPbPKnENalgw1qftjPx2UhCyKkpO50cXzYP0nw9e1NFvTh25pdfEg009zxAbWQSuKMd2psYu9L/G6icHlUSbzoFGCnwQNFgdWFOO4VG7A5Nhsl9PWScKWwi+i0K1R8jMRaGy+jGNBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j9BnGuzL; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j9BnGuzL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731579456; x=1763115456;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RYQmAW0/WxNKlis/R8jRVnI3QK9po7ymrTybzUTjbYo=;
  b=j9BnGuzLl8OPhLNbD5d+AIO+tLMOzYEpDx4hqWKKjpkqItK5peVFujQh
   PLmqw7Tl0d0dzGo1dG1AMINs6x8e32rV0giFBlvW43x+fZaEAmWlzgUD/
   GaU7D8oooz2BTX+oreoZP3WzcU+VBxXaYivbk/87P7o345+eN38231A+E
   Cdjy1WH8y22orq7FCGurjyTkBWNw9LDkM3dTF5Ob+X4OTFv98SLiYY48D
   9R4+i2LKoRhg/mp5LfbsnGxhBP9JW65LWP554LWuB0+ijWrMg8xLMD2iE
   1j53ep6K+8GE9yRtoDVRQn5Qx3CxPh4RY0c7sUS9OaP9Pv/J2pjM6ORZ3
   w==;
X-CSE-ConnectionGUID: m44T3l4IR9Kgx8zMoD90rA==
X-CSE-MsgGUID: 0JNYPLZ1T169nhwg73NqYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31290514"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31290514"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 02:17:36 -0800
X-CSE-ConnectionGUID: e0nX0VxyQuiTL3oe0GaZuQ==
X-CSE-MsgGUID: Kr5YYi0ZTbW1Or3UA3//LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="88588008"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.ger.corp.intel.com) ([10.245.99.46])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 02:17:32 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Leo Yan <leo.yan@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V15 3/7] perf tools: Parse aux-action
Date: Thu, 14 Nov 2024 12:17:06 +0200
Message-ID: <20241114101711.34987-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114101711.34987-1-adrian.hunter@intel.com>
References: <20241114101711.34987-1-adrian.hunter@intel.com>
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
index f83252472921..49361c5b2251 100644
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
index dddaf4f3ffed..b0db84d27b25 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -578,7 +578,7 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr,
 int auxtrace_parse_sample_options(struct auxtrace_record *itr,
 				  struct evlist *evlist,
 				  struct record_opts *opts, const char *str);
-void auxtrace_regroup_aux_output(struct evlist *evlist);
+int auxtrace_parse_aux_action(struct evlist *evlist);
 int auxtrace_record__options(struct auxtrace_record *itr,
 			     struct evlist *evlist,
 			     struct record_opts *opts);
@@ -799,8 +799,10 @@ int auxtrace_parse_sample_options(struct auxtrace_record *itr __maybe_unused,
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
index 531987cfd14a..bda1b7994df8 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1104,6 +1104,7 @@ static void evsel__apply_config_terms(struct evsel *evsel,
 			attr->aux_output = term->val.aux_output ? 1 : 0;
 			break;
 		case EVSEL__CONFIG_TERM_AUX_ACTION:
+			/* Already applied by auxtrace */
 			break;
 		case EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE:
 			/* Already applied by auxtrace */
-- 
2.43.0

