Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018983537F8;
	Wed, 10 Jun 2026 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110386; cv=none; b=ibQr2ewjtXCKk9vDL3Rrj653L2nmrHEE13pSP2yTtBnX2NDaZKDdS6xIB40GSWm+IDolX0xei3WjkGdjXWGNgylZMi+I1U9Lord7ERCOjNQ20lnS6qjEjDM/w05uzMxDC5lWnyARDPlCVzGBCAgkkim0TeyeagFN/LDV8A+YTzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110386; c=relaxed/simple;
	bh=Ao0pr5PgFb/7acac5QMQ2VYwhC/VuHpVSMrd3T6jF4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Me3pEmj6LnFP49sIcFk3A+tZhI4SNQlnbA8knJInw2CXaei86fBzykGVSJLopyMe2NLJ5Yss+TcUxPVgAmx1TK9RR9WJ9TYsum1N71XzaA2bNp2beIO903fv9C8So7pm/931R3h2LUJjgCo9i3wSUagGnRNoCyeuAb9VdPrWSUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/fXoqaA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/fXoqaA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0B21F00898;
	Wed, 10 Jun 2026 16:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781110384;
	bh=jSu3ugF2bQlEjkN56aaNfMrbvtlHHc0IVuql6K9Qrck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e/fXoqaANWckjmtRTgnNCLPbikvbpG/r0npIR5k66+BukBFQzLwddlZuLi4cD7mkE
	 NvVG3qtQ0v3+ftmKRh8haGwsxFOjcpCqDxJpRp5FHfUpSA3xO/lwcXzpHosapdrM0f
	 cv54S1i+kG1UraNhtLtxmD70mDILAs8FtMMqz7RUji3OvDXdJwYkfDOE5qv4iXHMFO
	 tGutoqWZtmDy+mkTtqebIP7BTBIhF/tuMBlEaYIzxOo4sfWsTRrDQHbQemy0DLv9Wp
	 xQJHOwPdIjGsyNJKqo5x/cTPK9ncYBRtrU7oH+lhEt35QAzXFgYUCnZ44Yd1v7twu0
	 F58mPLy0/j0iw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 09/11] perf hists: Fix snprintf() in hists__scnprintf_title() UID filter path
Date: Wed, 10 Jun 2026 13:52:03 -0300
Message-ID: <20260610165207.2077258-10-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610165207.2077258-1-acme@kernel.org>
References: <20260610165207.2077258-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

hists__scnprintf_title() accumulates formatted output into a buffer
using scnprintf() for all filter clauses except the UID filter, which
uses snprintf().  If the buffer fills up and snprintf() returns more
than the remaining space, printed exceeds size and the next 'size -
printed' underflows, causing later scnprintf() calls to write past
the buffer.

Switch the UID filter clause to scnprintf() to match the rest of the
function.

Fixes: 25c312dbf88ca402 ("perf hists: Move hists__scnprintf_title() away from the TUI code")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 811d68fa6770c5b7..df978c996b6c2262 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2963,9 +2963,10 @@ int __hists__scnprintf_title(struct hists *hists, char *bf, size_t size, bool sh
 			   ev_name, sample_freq_str, enable_ref ? ref : " ", nr_events);
 
 
-	if (hists->uid_filter_str)
-		printed += snprintf(bf + printed, size - printed,
-				    ", UID: %s", hists->uid_filter_str);
+	if (hists->uid_filter_str) {
+		printed += scnprintf(bf + printed, size - printed,
+				     ", UID: %s", hists->uid_filter_str);
+	}
 	if (thread) {
 		if (hists__has(hists, thread)) {
 			printed += scnprintf(bf + printed, size - printed,
-- 
2.54.0

