Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D957E2DECDF;
	Fri, 28 Nov 2025 21:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764366667; cv=pass; b=PCJ2/cqRRGCKH87V+dJaLelSzeZBiz9KbNWTK0IQITm7WituiRY50EFPAelOZeGrRy/kGGMUBvUEgD/TSiXPhHEgk6l3tCVPEEasvTeqLZE45hvDEDgUuZgN2Fpks9lL9xPmQBrpHDChg62bbJDaKft/4jmliBS5/kRoiAG7FBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764366667; c=relaxed/simple;
	bh=lIp2uBTevkBuVJMEIw3YzD9FQdWFeCFZGN1MTRVAETE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H3DqHkLFt6ZNEcACPHqgZezAE02NT2PmW5pBc34kzk79QbdEHkOkuvP4EP2/hJm/2Xm5G4Z6b2r3oX7pnjtNN83PzXAmZ7Sx3s6v7ddTIBRgyvoVFrDpAqnAIH5mLuz7MaBgtm3aFbEQ0RP/H0Usm5vdGPsM3dZGuTcwfXbz8ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=derek.foreman@collabora.com header.b=Zo0YUcQW; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=derek.foreman@collabora.com header.b="Zo0YUcQW"
ARC-Seal: i=1; a=rsa-sha256; t=1764366637; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BPPBisUEBke+tsdZGNtJYxOnoVC4unN5IgZQ1DX7lSSYN/83z3qlxhNcQqxqRTKp8VbAAiZIIA1gqx37hC66Gr1PykXbzZeMM9NVXd1cAcHGGycs2mDPVCIhrKaqyj3ecqZtZIm3wKOsVjbjfXVgFHMpvQ+yPSNB/hYjzGxkKKU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764366637; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gDPZtVrdmfnUmrbgWxufw+aypr61D8gwaqNMB1yEAYc=; 
	b=YFhY98l4RBruSEBHSMWxVUlZhpALX2oh6CbMC4uV+2DS2eZQwFmznuO34OOiMYCQ4p3iIHdzZq0R2J6SZ4xGz4avcxy1gVSHTBXEWxYBji9ioNXaXSshef0b+tnBi50auiLLzBe/2y2WoINY8kKQSyBssQKjRw1iBOQ2iODpj6A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=derek.foreman@collabora.com;
	dmarc=pass header.from=<derek.foreman@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764366637;
	s=zohomail; d=collabora.com; i=derek.foreman@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=gDPZtVrdmfnUmrbgWxufw+aypr61D8gwaqNMB1yEAYc=;
	b=Zo0YUcQWPhSrHfruX+P/jEH3ZtgmdIp0cNnrep/EMhrCIn7dj3Z/KAURJ+zC0FM6
	Avh/nDTRhftmc8MqGYplrgKFLGHEvYP6GVK8lnze+0UN0rFLJzrU3q12J+YIPM3njQl
	fUvM67jHeH8AiiLuoyOyoTpTNDsowyMQDh7l/dH0=
Received: by mx.zohomail.com with SMTPS id 1764366634861372.0317758204576;
	Fri, 28 Nov 2025 13:50:34 -0800 (PST)
From: Derek Foreman <derek.foreman@collabora.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>
Cc: kernel@collabora.com,
	Derek Foreman <derek.foreman@collabora.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] perf data: Allow filtering conversion by time range
Date: Fri, 28 Nov 2025 15:50:17 -0600
Message-ID: <20251128215020.184466-1-derek.foreman@collabora.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This adds a feature to allow restricting the range of converted samples
with a range string like perf-script and perf-report --time.

Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
---
v2) Replace bespoke filtering with --time (util/time-utils.h)

 tools/perf/Documentation/perf-data.txt | 28 ++++++++++++++++++++++
 tools/perf/builtin-data.c              |  3 +++
 tools/perf/util/data-convert-bt.c      | 31 ++++++++++++++++++++++++
 tools/perf/util/data-convert-json.c    | 33 ++++++++++++++++++++++++++
 tools/perf/util/data-convert.h         |  1 +
 5 files changed, 96 insertions(+)

diff --git a/tools/perf/Documentation/perf-data.txt b/tools/perf/Documentation/perf-data.txt
index 417bf17e265c..20f178d61ed7 100644
--- a/tools/perf/Documentation/perf-data.txt
+++ b/tools/perf/Documentation/perf-data.txt
@@ -40,6 +40,34 @@ OPTIONS for 'convert'
 --force::
 	Don't complain, do it.
 
+--time::
+	Only convert samples within given time window: <start>,<stop>. Times
+	have the format seconds.nanoseconds. If start is not given (i.e. time
+	string is ',x.y') then analysis starts at the beginning of the file. If
+	stop time is not given (i.e. time string is 'x.y,') then analysis goes
+	to end of file. Multiple ranges can be separated by spaces, which
+	requires the argument to be quoted e.g. --time "1234.567,1234.789 1235,"
+
+	Also support time percent with multiple time ranges. Time string is
+	'a%/n,b%/m,...' or 'a%-b%,c%-%d,...'.
+
+	For example:
+	Select the second 10% time slice:
+
+	  perf data convert --to-json out.json --time 10%/2
+
+	Select from 0% to 10% time slice:
+
+	  perf data convert --to-json out.json --time 0%-10%
+
+	Select the first and second 10% time slices:
+
+	  perf data convert --to-json out.json --time 10%/1,10%/2
+
+	Select from 0% to 10% and 30% to 40% slices:
+
+	  perf data convert --to-json out.json --time 0%-10%,30%-40%
+
 -v::
 --verbose::
         Be more verbose (show counter open errors, etc).
diff --git a/tools/perf/builtin-data.c b/tools/perf/builtin-data.c
index ce51cbf6dc97..85f59886b5cf 100644
--- a/tools/perf/builtin-data.c
+++ b/tools/perf/builtin-data.c
@@ -33,6 +33,7 @@ const char *to_ctf;
 struct perf_data_convert_opts opts = {
 	.force = false,
 	.all = false,
+	.time_str = NULL,
 };
 
 const struct option data_options[] = {
@@ -45,6 +46,8 @@ const struct option data_options[] = {
 #endif
 		OPT_BOOLEAN('f', "force", &opts.force, "don't complain, do it"),
 		OPT_BOOLEAN(0, "all", &opts.all, "Convert all events"),
+		OPT_STRING(0, "time", &opts.time_str, "str",
+			   "Time span of interest (start,stop)"),
 		OPT_END()
 	};
 
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 3d2e437e1354..0bcbc0e309e0 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -34,6 +34,7 @@
 #include "util.h"
 #include "clockid.h"
 #include "util/sample.h"
+#include "util/time-utils.h"
 
 #ifdef HAVE_LIBTRACEEVENT
 #include <event-parse.h>
@@ -91,9 +92,14 @@ struct convert {
 	struct perf_tool	tool;
 	struct ctf_writer	writer;
 
+	struct perf_time_interval *ptime_range;
+	int range_size;
+	int range_num;
+
 	u64			events_size;
 	u64			events_count;
 	u64			non_sample_count;
+	u64			skipped;
 
 	/* Ordered events configured queue size. */
 	u64			queue_size;
@@ -811,6 +817,11 @@ static int process_sample_event(const struct perf_tool *tool,
 	if (WARN_ONCE(!priv, "Failed to setup all events.\n"))
 		return 0;
 
+	if (perf_time__ranges_skip_sample(c->ptime_range, c->range_num, sample->time)) {
+		++c->skipped;
+		return 0;
+	}
+
 	event_class = priv->event_class;
 
 	/* update stats */
@@ -1644,6 +1655,15 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 	if (IS_ERR(session))
 		return PTR_ERR(session);
 
+	if (opts->time_str) {
+		err = perf_time__parse_for_ranges(opts->time_str, session,
+						  &c.ptime_range,
+						  &c.range_size,
+						  &c.range_num);
+		if (err < 0)
+			goto free_session;
+	}
+
 	/* CTF writer */
 	if (ctf_writer__init(cw, path, session, opts->tod))
 		goto free_session;
@@ -1687,6 +1707,14 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 	else
 		fprintf(stderr, ", %" PRIu64 " non-samples) ]\n", c.non_sample_count);
 
+	if (c.skipped) {
+		fprintf(stderr,	"[ perf data convert: Skipped %" PRIu64 " samples ]\n",
+			c.skipped);
+	}
+
+	if (c.ptime_range)
+		zfree(&c.ptime_range);
+
 	cleanup_events(session);
 	perf_session__delete(session);
 	ctf_writer__cleanup(cw);
@@ -1696,6 +1724,9 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 free_writer:
 	ctf_writer__cleanup(cw);
 free_session:
+	if (c.ptime_range)
+		zfree(&c.ptime_range);
+
 	perf_session__delete(session);
 	pr_err("Error during conversion setup.\n");
 	return err;
diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index 9dc1e184cf3c..787039967916 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -25,6 +25,7 @@
 #include "util/session.h"
 #include "util/symbol.h"
 #include "util/thread.h"
+#include "util/time-utils.h"
 #include "util/tool.h"
 
 #ifdef HAVE_LIBTRACEEVENT
@@ -35,7 +36,12 @@ struct convert_json {
 	struct perf_tool tool;
 	FILE *out;
 	bool first;
+	struct perf_time_interval *ptime_range;
+	int range_size;
+	int range_num;
+
 	u64 events_count;
+	u64 skipped;
 };
 
 // Outputs a JSON-encoded string surrounded by quotes with characters escaped.
@@ -165,6 +171,11 @@ static int process_sample_event(const struct perf_tool *tool,
 		return -1;
 	}
 
+	if (perf_time__ranges_skip_sample(c->ptime_range, c->range_num, sample->time)) {
+		++c->skipped;
+		return 0;
+	}
+
 	++c->events_count;
 
 	if (c->first)
@@ -320,6 +331,10 @@ int bt_convert__perf2json(const char *input_name, const char *output_name,
 	struct convert_json c = {
 		.first = true,
 		.events_count = 0,
+		.ptime_range = NULL,
+		.range_size = 0,
+		.range_num = 0,
+		.skipped = 0,
 	};
 	struct perf_data data = {
 		.mode = PERF_DATA_MODE_READ,
@@ -382,6 +397,15 @@ int bt_convert__perf2json(const char *input_name, const char *output_name,
 		goto err_session_delete;
 	}
 
+	if (opts->time_str) {
+		ret = perf_time__parse_for_ranges(opts->time_str, session,
+						  &c.ptime_range,
+						  &c.range_size,
+						  &c.range_num);
+		if (ret < 0)
+			goto err_session_delete;
+	}
+
 	// The opening brace is printed manually because it isn't delimited from a
 	// previous value (i.e. we don't want a leading newline)
 	fputc('{', c.out);
@@ -411,7 +435,16 @@ int bt_convert__perf2json(const char *input_name, const char *output_name,
 			"[ perf data convert: Converted and wrote %.3f MB (%" PRIu64 " samples) ]\n",
 			(ftell(c.out)) / 1024.0 / 1024.0, c.events_count);
 
+	if (c.skipped) {
+		fprintf(stderr,	"[ perf data convert: Skipped %" PRIu64 " samples ]\n",
+			c.skipped);
+	}
+
 	ret = 0;
+
+	if (c.ptime_range)
+		zfree(&c.ptime_range);
+
 err_session_delete:
 	perf_session__delete(session);
 err_fclose:
diff --git a/tools/perf/util/data-convert.h b/tools/perf/util/data-convert.h
index 1b4c5f598415..ee651fa680a1 100644
--- a/tools/perf/util/data-convert.h
+++ b/tools/perf/util/data-convert.h
@@ -8,6 +8,7 @@ struct perf_data_convert_opts {
 	bool force;
 	bool all;
 	bool tod;
+	const char *time_str;
 };
 
 #ifdef HAVE_LIBBABELTRACE_SUPPORT
-- 
2.47.3

