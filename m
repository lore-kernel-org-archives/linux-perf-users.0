Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D62451060;
	Tue, 16 Jun 2026 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624388; cv=none; b=iZ4zQs9FwkdHUxtX9oLAcg3HjM6+/fo+8GtrADvtHmBIZE+oG1QWq0HM9935LIvk4U2cQiWFp1KXvgBU0ewC1JlcLQo0Jhmfvs9XsKFTkH4kRtyhIA+6HS52jEebye2IgHNrUsZ6w/pKLQE/NtD2Pg+p8OjicOH2UUdWnGdYhtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624388; c=relaxed/simple;
	bh=iZcqG58TA5LGQvJYby9/qaw07A039ETs3uwWOc5UV8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tzt2jWuSZCkiHyioOW5YACwen3KWHXOa1lET0iHzgXq33ZVYTAtilt4WCnrQiTqwmP9ubh+WZiiXxcKZDS2DdE0syQypcVoL4OTtrLYGZjbSdtuQi99DssBi7WLCCp8VcJhmerJdPFNNFEkGAILAuT7JlzKLZQ3Xm1r9Pu49Zc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EN+j8JYG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EN+j8JYG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DDA1F000E9;
	Tue, 16 Jun 2026 15:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781624387;
	bh=kgJYoHlcqFV+eugqlEuDQnuZ+mPxNa7dqap9zdwn9z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EN+j8JYGf8OM7W+uOgBh9AKavnwC6VNj2yDGqs9mnXBy2sYtg0lQ0AeUm2hzD9uYX
	 GUcTVvUOLFi3q8/bo7U8wfdvY9B9A5g1vsXNpkyhm9WwUc3R2YzpUl/Xd1rQ3mo8p1
	 ENw4mLCDTDub4n3fPF5K5MnFfibf7LfjoyZrRauEEHdsA2vwrazOFkOWAfBnF0Z79f
	 alAkURxChBp8wDtUH95Cg8L0ERr5JSmBWSOQiq2drHiCg4hRti0IUk5vphH8iXTRSL
	 gNwx6lrBt9pC4b8mTa6XSUbLu/9M1tk75ftOMtcUouGTWC7C/tkTBhSVRLjMPpbI0c
	 XNV1ZTiptUE6A==
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
	Claude <noreply@anthropic.com>
Subject: [PATCH 6/9] perf c2c: Free format list entries when c2c_hists__init() fails
Date: Tue, 16 Jun 2026 12:39:17 -0300
Message-ID: <20260616153920.6852-7-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616153920.6852-1-acme@kernel.org>
References: <20260616153920.6852-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When c2c_hists__init() fails partway through hpp_list__parse(),
dynamically allocated format structures that were already added to
hists->list are leaked because he__get_c2c_hists() frees the hists
container without first unregistering the format entries.

Call perf_hpp__reset_output_field() before freeing the hists container
on the error path, matching what c2c_he_free() already does on the
normal destruction path.

Fixes: 17a7c5946d79a12c ("perf c2c report: Decode c2c_stats for hist entries")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Assisted-by: Claude <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 07c7e8fb315e6cf3..eabb922ef295ef86 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -226,6 +226,7 @@ he__get_c2c_hists(struct hist_entry *he,
 
 	ret = c2c_hists__init(hists, sort, nr_header_lines, env);
 	if (ret) {
+		perf_hpp__reset_output_field(&hists->list);
 		c2c_he->hists = NULL;
 		free(hists);
 		return NULL;
-- 
2.54.0

