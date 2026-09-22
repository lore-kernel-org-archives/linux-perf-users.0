Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CAE541E6D;
	Tue, 22 Sep 2026 12:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080044; cv=none; b=myPwOXXJk2r3ApiUn1GvKWXXVeZQ6zd6kgoPuNruRYugFcMGJpAj4cpfAQpO9abP7H4AbCnPn03/zykM0wWJsCDw8M+9LwfKTg5n8Hdb1M1vvdaWvSW6LC+tJJG6AMU6OWW93q/s03hr9nZp/N9nW2SvpxQJ/zoifIWbxIf1H3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080044; c=relaxed/simple;
	bh=DNopuPVnqP+asREDoo6vMJtkbDlJq9GpboXsXm1flyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rkB7+eRLeIo0Oqp47+QbhY8ejTrx26v12rO8pKDI1DZAmMIkWpAo9C9DMdYNk9oDCKhm7NV0Y4EUlWERH4xUfTt1BB88lTbq5q+z32HeeBv1LAT4QSoei2dUSw4A0UVpp9A0uk4BdU1vtKNFSJEReN1RSIqAR2gARriG6etgA3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjHQB2Qj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjHQB2Qj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8563B1F00899;
	Tue, 22 Sep 2026 12:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790080042;
	bh=ZLhEWeFQugaxDSS3tO5Vf31pY8c4lSsBqp2RGaQInkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WjHQB2Qj0hUzdB65DZFWBlTFvbqtcd//cyKHDQ+SVayHGAG7iRsOYa0gZ8eO79wVD
	 oT/O3k5bUZfLjd0q0jxHPsplv+Xog5oLRi28xf/8nmNPa6cXng90fCXtxyn797HXNF
	 FopTdEhF+Rzi4L1ZzLKoDq/lKWeIgJUI8z0AxEA1DSRijMF1Ed9i5TRB920+IgGH6M
	 fTYm8AJFw0LIHmYD0iOjffzYan4s4Tr8ptwrafD7Xh4G/iKcGxmfC9JRNr/GeqHQGz
	 iJXzZ1Gqmgta0xoeDW27Kki67wN7ZhacUB8NlzoDCRyE3aAlrtIhtC23ovss3vpt0E
	 eTplttHLqmgKg==
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
Subject: [PATCH v3 5/7] perf annotate-data: Show the sample count in the data-type browser
Date: Tue, 22 Sep 2026 14:26:21 +0200
Message-ID: <20260922122623.1029132-6-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922122623.1029132-1-acme@kernel.org>
References: <20260922122623.1029132-1-acme@kernel.org>
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
Acked-by: Namhyung Kim <namhyung@kernel.org>
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

