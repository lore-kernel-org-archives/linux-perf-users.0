Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F64F4ED1B2;
	Thu, 17 Sep 2026 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789660569; cv=none; b=Ufy21fcU3tP1JS0drAbQfUtpOt6/7Me5PFgDYhfuWG13x6dZxO5JaR4WlBO0DtXmfui7GUP3TX7TWOm70CCepLKhXUYwdiULaXqgaJR235RTD4a+T+bThZCkINQZOmEunB5rjVoizQNRH0bkGAw6ZWQo69IiPlIvoG9d9Eg2hio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789660569; c=relaxed/simple;
	bh=sQ6irpPy9qg+KwS9ppQ29XA+Btr2M5iA8huAws5TNto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JqZgEBJqoSYp+oMEFepqPwDHTtSMi0MU3yvLPMZGpXrS0yV+WQu6peDAT2yrZMeu8J6JppdPrRzxWiSryQOLSp670IBUOA/CKmm5GycPhVnxg2JUWf3Kg4IGBdhxiSq700wnzrbOhNI1hbFSy3hQPEKVdmZJXari8zuSGEC+C38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jzt1EoJW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jzt1EoJW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D081F00898;
	Thu, 17 Sep 2026 15:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789660567;
	bh=yiamfbmklyaY8g3wHJHvEs97pXS5G54zTVCv5jS7mCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jzt1EoJWf4PiB9Bv8x1KPBhFOp1qewaXQi7VfW3/a2Yd0Svc1j1qsyghjQ8/tQVNU
	 ttrREQHilktgLKd8hHYEA0QknrB6YW85n1CoTv0jn1sVDM9Z/5/u3Xm8GfZ5hEFp1e
	 5NsshGs6tnEE6gYT5MLSjDpJr/MoFuQYGa8p7xQL7K06wIn+wz+jwEpe+Xu2ETeYJO
	 rTdLCVURb2nVaamGQk4LSJQIXTE2YRB5w0OphVTKzZg33BqCYP459+d1/qIQMCFbpD
	 IGErRMrkNINduEk4MA2tPTujiX9lpFMjcdswQT0h7L6568yibv/WSUJPeIUW8yF0/3
	 RC2PgG6tLnSLg==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/15] perf annotate-data: Show the sample count in the data-type browser
Date: Thu, 17 Sep 2026 12:55:18 -0300
Message-ID: <20260917155528.62607-8-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917155528.62607-1-acme@kernel.org>
References: <20260917155528.62607-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The samples view (-n, annotate.show_nr_samples) prints a local
nr_samples variable that is initialized to zero and never updated, so
every member is listed as having no samples while the period and percent
columns for the same entry are filled in.  Print the histogram entry's
own count instead.

Fixes: d001c7a7f4736743 ("perf annotate-data: Add hist_entry__annotate_data_tui()")
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate-data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/annotate-data.c b/tools/perf/ui/browsers/annotate-data.c
index c6e07a9b64089ab5..a15608f6ee53335f 100644
--- a/tools/perf/ui/browsers/annotate-data.c
+++ b/tools/perf/ui/browsers/annotate-data.c
@@ -374,7 +374,7 @@ static void browser__write_overhead(struct ui_browser *uib,
 	u64 period = hist->period;
 	double percent = total->period ? (100.0 * period / total->period) : 0;
 	bool current = ui_browser__is_current_entry(uib, row);
-	int nr_samples = 0;
+	int nr_samples = hist->nr_samples;
 
 	ui_browser__set_percent_color(uib, percent, current);
 
-- 
2.55.0

