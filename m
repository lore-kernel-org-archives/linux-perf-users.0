Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4F247604C;
	Tue,  4 Aug 2026 18:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869929; cv=none; b=FtS2SbexW3KueQcvB14/sJmo6dPstSvc6Yl/+cDhPHeLY3A0KgoPA115dr6Eg0W6Pdx+ibRZz7YhbLtXuUay2iM3cHU2+XIH/5XlEUSJxngaazcMWMfOtKChbeTuxCfCbj003Mn/XcxdwpQNedW91so01utdS7lZN/540tURB+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869929; c=relaxed/simple;
	bh=KCcOjlzxqzd89KMQsuEdrd/66CNfWdc79nH3nU6f0L4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kw9RyCB10/FTC7i+S3UM8UezHZl9VTsSgycRTu+wrRO1kUe2L63uVcSrYZ7yDi7tCrDETNYPXBSYs/cpvQKDYQIWN5oX/wXKYiNNK5WEghQ68CKg0FhzIoXf+TXiFciKa2t2wG0B0O0zSaxpcfxRV3nuQBuhV1EIF/1ko9vs8YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIrj5uHi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIrj5uHi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE691F000E9;
	Tue,  4 Aug 2026 18:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785869927;
	bh=gW52zvIhvWcilLmaTDtal5tfapZ9T31ZUyIWaiBtJmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PIrj5uHijkQkjuGdawsyQXeAjxi3JhA+qpwhJWcw6ggxGCVMLDu90zwTBRiUm+nv2
	 Ua5pW5ntuIm1bXS2VPRgSQf/LDTGV4Gk7SQJTNpGlZXLAa+ghOfim07PkB4wXn6Wvs
	 LaaYT7Ko9+OqL1+wmy1Zxuotu3inCdCMHuGxGUgzboYf5FhphtnDd0FnkrWKlxED3V
	 8xj6w0ADAZV2ZtX7SYVSegyM1VhfBCsL9/GrPa+sIL5kRd16v5CoI/YgYeNEAGUtu8
	 09JFZRNMvWKA47OdmS/7VWPeRMsV71hALfODg775Pp3yZLJ3y40b6ZBZI0jaBMDpBU
	 6mC95Ei85TUqg==
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
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH 2/2] perf c2c: Clean up registered formats on c2c_hists__init() and c2c_hists__reinit() failure
Date: Tue,  4 Aug 2026 15:58:30 -0300
Message-ID: <20260804185830.228763-3-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804185830.228763-1-acme@kernel.org>
References: <20260804185830.228763-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When c2c_hists__init() or c2c_hists__reinit() calls hpp_list__parse()
and it fails partway through, format structures registered via
perf_hpp_list__column_register() and perf_hpp_list__register_sort_field()
are left on the hpp_list.

In c2c_hists__init(), the c2c_he__alloc_hists() caller handles this with
perf_hpp__reset_output_field(), but perf_c2c_report() does not, leaking
the partially registered entries.

In c2c_hists__reinit(), neither perf_c2c_report() nor resort_cl_cb()
clean up on failure.

Fix by adding cleanup inside both functions themselves, so all callers
are protected.

Fixes: 78b275437873 ("perf c2c report: Add sample processing")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Assisted-by: Claude:claude-opus-4.6
Assisted-by: Opencode:mimo-v2.5-free
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 160b82694d391c50..1856cccbee27818b 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2147,6 +2147,8 @@ static int c2c_hists__init(struct c2c_hists *hists,
 			   int nr_header_lines,
 			   struct perf_env *env)
 {
+	int ret;
+
 	__hists__init(&hists->hists, &hists->list);
 
 	/*
@@ -2159,7 +2161,13 @@ static int c2c_hists__init(struct c2c_hists *hists,
 	/* Overload number of header lines.*/
 	hists->list.nr_header_lines = nr_header_lines;
 
-	return hpp_list__parse(&hists->list, /*output=*/NULL, sort, env);
+	ret = hpp_list__parse(&hists->list, /*output=*/NULL, sort, env);
+
+	/* Unregister any formats added before the failure point */
+	if (ret)
+		perf_hpp__reset_output_field(&hists->list);
+
+	return ret;
 }
 
 static int c2c_hists__reinit(struct c2c_hists *c2c_hists,
@@ -2167,8 +2175,16 @@ static int c2c_hists__reinit(struct c2c_hists *c2c_hists,
 			     const char *sort,
 			     struct perf_env *env)
 {
+	int ret;
+
 	perf_hpp__reset_output_field(&c2c_hists->list);
-	return hpp_list__parse(&c2c_hists->list, output, sort, env);
+	ret = hpp_list__parse(&c2c_hists->list, output, sort, env);
+
+	/* Unregister any formats added before the failure point */
+	if (ret)
+		perf_hpp__reset_output_field(&c2c_hists->list);
+
+	return ret;
 }
 
 #define DISPLAY_LINE_LIMIT  0.001
-- 
2.55.0

