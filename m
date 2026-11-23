Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795418396;
	b=zqkfTBmvkGZ7dRcv8S8MIAMB8T1aPzgbGr+gXT8KMbDEA0KubIJGjzNACIWIHhlpjgAa
	 Ai0eFdR8XOtD9/j6Y2FMl8UGuRMHOuKtP6f5CZrWa9i/49HkwitKaIt2TTkG2Fw+MnvvQ
	 RouqHWQ02WFT/L/49Sud/oWKFHYHj7k6I4A4Rt7f4GpU2JUO7pdciAEiyEt/uwJRjlwA/
	 QWAEH7xoNdGtkgXHjf9QXGp7UC+ZWbIw0clsiQYcuyicWYrrx4r4OngBmdjOlflmzkCEA
	 0e5Mdul8myEuX7kgztmAEi4W+QiUCpAaNFjeLo0iZ4fEoV/4/2SyWcm7U6GLqkRG5pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795418396;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=yR0Cn8qSGWXI+eqarTOysMEcgExUMTEHpNE5KEC2kI4=;
	b=OkiCXVEPCO+kRLl5U9R3HDexvSzpWjaiVkMT3F8WAzUeC9T/tlxyIFBr5VemF8tBUoYX
	 stF72gn5A7SxMXOkFmxfv+2tU0qfikUScHRYCdr5lp2U6nbqp4EBR5dJsQP6QgkMP9JuO
	 wpY3aWajR/e9lwIJha03ZV+04QW4WduHvxtS3Z+Sfr7ABSfR7Ww0T9+fUQ/Qx0mvjN6NY
	 YjgkcK4vy79o+KIjU/VYgw1Ima/v/mciBZwVy4IOsFEs9ZuLcpAkyQX62nunHhPm4WaCc
	 VTj6z386P5MLgRhUzmLvfPzBNBlqWHS8z1Qqo60CXXfXH2Br2TxAIdI2VXDRoNw3HZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fABoZs88;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B594606A31E
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 07:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B594606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fABoZs88
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b45655b428so1882487a91.0
        for <linux-perf-users@vger.kernel.org>; Sun, 22 Nov 2026 23:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795418395; x=1796023195; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yR0Cn8qSGWXI+eqarTOysMEcgExUMTEHpNE5KEC2kI4=;
        b=fABoZs88sNFPRBWNg99rEtBGfqBiFlVqRzxZ8/Kt5UyH3q9jqjTGNWNeusaDWCP7ZK
         v5mqs6XWy/q1UugVnTXXxOpphGqHxj+Fz/u081I+9QfnIWTVKvhgRXbOvtUAUIn+ZPlL
         hGYZZJ45P3S+/mrnmqZSZTpiVlSX8TQC0F3NgDneYGpRVd1xecUkhxeP5xFAMvSKAQ9f
         TAcZWPvAJtBl8NeSrjgoK4P+dijKpMbsvpBNbwk9Yae6Fy6+yCuwvKUZPXWg14dk0C7J
         tCLpZOkOZZz0+FKAh6LsYFRQRpa6sHdMvuZAy5Jcvr4/Aj22h2yWIEyg+vU18DVrL+Jr
         w7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795418395; x=1796023195;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yR0Cn8qSGWXI+eqarTOysMEcgExUMTEHpNE5KEC2kI4=;
        b=ABzl2Iy/6if0D+lyO4jKLZ9GBYsrjuIIv1MA5UIbqqSDI3HYgvYz56fJY4g8RLUiNR
         QqkevyuGlSn7MhY3UnMncVB3zd9Ln4XD6vLZ+tBIM9yES0AQHjXWzNo7iY5PuRtH54vP
         qM7YQRvRT21jvq+fQvzYFpqj13uPKxM/OfMhuvMB2A0ON3XcXxAlFMx3+1UO9goRvJRl
         WaN0G+vdbdQFQtVd46LwHacnQ8H8FCc2XEppzZ1SvJ9Yj6+ZnE5F9aFOSI5onulEonNq
         8jHI4HeojMX1brWZFbFH46+FPiun/D+SIDP6MWvxA2pyBHjCWYecvsilIg6qr+LTRo3M
         swcQ==
X-Forwarded-Encrypted: i=1; AL+hErGImidGoJkhZJO77iKuUfO1LLbVAhPsI4XV5UwJh7HBcVNAAY08pxfgvq2Ay5enlFdJyu7uxqjJ8ZqghJGh8t9M@vger.kernel.org
X-Gm-Message-State: APuU4Z+9IL4kX4JNXMsUSIn6yJChDtTLc4i5HMbsK4nKYxaTqfZStdLr
	9wsN/M1/iHqtsSsWQGBEfODaTYc85GSshMTOX7rKmXkIWggIAqVLIYyaDBKsEXhf5ei/9N336oT
	osicEdj78lw==
X-Received: from pgig3.prod.google.com ([2002:a63:f403:0:b0:cc7:ad09:94b6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d8d:b0:3b3:b704:118c
 with SMTP id 98e67ed59e1d1-3b41cb4f321mr9578228a91.65.1795418395412; Sun, 22
 Nov 2026 23:19:55 -0800 (PST)
Date: Sun, 22 Nov 2026 23:19:07 -0800
In-Reply-To: <20261123071913.653315-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261123071913.653315-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123071913.653315-8-irogers@google.com>
Subject: [PATCH v1 07/13] perf evlist: Enable tool PMU events when starting a workload
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Song Liu <songliubraving@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When perf stat runs a workload, group leaders are opened disabled with
enable_on_exec set so that the kernel enables them when the workload
execs. Since tool PMU events were made to respect enable/disable they
are opened disabled too, but there is no kernel event to be enabled on
exec, so they are never enabled and count 0. For example:

  $ perf stat -e duration_time,user_time,task-clock -- perf test -w noploop
                 0      duration_time
                 0      user_time
          1,013.74 msec task-clock

Enable tool PMU events that are set to enable on exec when the workload
is started.

Fixes: 0b18bced5444 ("perf tool_pmu: Make tool PMU events respect enable/disable")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c | 15 +++++++++++++++
 tools/perf/util/evsel.c  | 14 ++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index c2402e4791b6..ec26064183b6 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -69,6 +69,7 @@
 #include "string2.h"
 #include "target.h"
 #include "thread_map.h"
+#include "tool_pmu.h"
 #include "units.h"
 #include "util.h"
 
@@ -1909,6 +1910,20 @@ int evlist__start_workload(struct evlist *evlist)
 	if (evlist__workload_cork_fd(evlist) >= 0) {
 		char bf = 0;
 		int ret;
+		struct evsel *pos;
+
+		/*
+		 * Tool PMU events aren't opened with perf_event_open and so
+		 * aren't enabled by the kernel on exec. Enable them as the
+		 * workload is started.
+		 */
+		evlist__for_each_entry(evlist, pos) {
+			if (evsel__is_tool(pos) &&
+			    (pos->core.attr.enable_on_exec ||
+			     evsel__leader(pos)->core.attr.enable_on_exec) &&
+			    pos->core.fd && pos->supported)
+				evsel__enable(pos);
+		}
 		/*
 		 * Remove the cork, let it rip!
 		 */
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index babeccfbecb5..d89087e295dc 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1914,6 +1914,8 @@ int evsel__enable_cpu(struct evsel *evsel, int cpu_map_idx)
 		struct evsel *member;
 
 		for_each_group_member(member, evsel) {
+			if (!member->core.fd)
+				continue;
 			if (evsel__is_non_perf_event_open_pmu(evsel) ||
 			    evsel__is_non_perf_event_open_pmu(member)) {
 				/*
@@ -1969,6 +1971,11 @@ int evsel__enable(struct evsel *evsel)
 		struct evsel *member;
 
 		for_each_group_member(member, evsel) {
+			if (!member->core.fd) {
+				if (evsel__is_retire_lat(member))
+					member->disabled = false;
+				continue;
+			}
 			if (evsel__is_non_perf_event_open_pmu(evsel) ||
 			    evsel__is_non_perf_event_open_pmu(member)) {
 				/*
@@ -2004,6 +2011,8 @@ int evsel__disable_cpu(struct evsel *evsel, int cpu_map_idx)
 		struct evsel *member;
 
 		for_each_group_member(member, evsel) {
+			if (!member->core.fd)
+				continue;
 			if (evsel__is_non_perf_event_open_pmu(evsel) ||
 			    evsel__is_non_perf_event_open_pmu(member)) {
 				/*
@@ -2065,6 +2074,11 @@ int evsel__disable(struct evsel *evsel)
 		struct evsel *member;
 
 		for_each_group_member(member, evsel) {
+			if (!member->core.fd) {
+				if (evsel__is_retire_lat(member))
+					member->disabled = true;
+				continue;
+			}
 			if (evsel__is_non_perf_event_open_pmu(evsel) ||
 			    evsel__is_non_perf_event_open_pmu(member)) {
 				/*
-- 
2.56.1.750.gf70dc682cf-goog

