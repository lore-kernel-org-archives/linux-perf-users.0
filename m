From: Andrew Vagin <avagin@openvz.org>
Subject: [PATCH 2/7] perf: add ability to record event period
Date: Mon, 28 Nov 2011 12:03:30 +0300
Message-ID: <1322471015-107825-3-git-send-email-avagin@openvz.org>
References: <1322471015-107825-1-git-send-email-avagin@openvz.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mailhub.sw.ru ([195.214.232.25]:18875 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751070Ab1K1JEq (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 28 Nov 2011 04:04:46 -0500
In-Reply-To: <1322471015-107825-1-git-send-email-avagin@openvz.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu, acme@ghostprotocols.net, asharma@fb.com, devel@openvz.org, dsahern@gmail.com, linux-perf-users@vger.kernel.org

Signed-off-by: Andrew Vagin <avagin@openvz.org>
---
 tools/perf/builtin-record.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 6ab58cc..e3b7fc4 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -62,6 +62,7 @@ static bool			no_samples			=  false;
 static bool			sample_address			=  false;
 static bool			sample_time			=  false;
 static bool			no_buildid			=  false;
+static bool			period				=  false;
 static bool			no_buildid_cache		=  false;
 static struct perf_evlist	*evsel_list;
 
@@ -185,6 +186,9 @@ static void config_attr(struct perf_evsel *evsel, struct perf_evlist *evlist)
 	if (evlist->nr_entries > 1)
 		attr->sample_type |= PERF_SAMPLE_ID;
 
+	if (period)
+		attr->sample_type |= PERF_SAMPLE_PERIOD;
+
 	/*
 	 * We default some events to a 1 default interval. But keep
 	 * it a weak assumption overridable by the user.
@@ -803,6 +807,7 @@ const struct option record_options[] = {
 	OPT_BOOLEAN('d', "data", &sample_address,
 		    "Sample addresses"),
 	OPT_BOOLEAN('T', "timestamp", &sample_time, "Sample timestamps"),
+	OPT_BOOLEAN('P', "period", &period, "Sample period"),
 	OPT_BOOLEAN('n', "no-samples", &no_samples,
 		    "don't sample"),
 	OPT_BOOLEAN('N', "no-buildid-cache", &no_buildid_cache,
-- 
1.7.1
