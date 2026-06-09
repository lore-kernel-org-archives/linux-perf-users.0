Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E2D30CDB6;
	Tue,  9 Jun 2026 01:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780967168; cv=none; b=kUInD5i1paFPRgJYzSytdSHjUQL6229daoi2BEEoJQ2sL5vDGqIYQpZFqgJ/uCHTMuSk3cukYyzsH629ii9JJno/OgbD73rzpEomPbobkf2hYFTaN2BoFbYv3cnMn5PxXiy/+tgYXlE8CvyKZUz131PO6QgBXHgI+ho8+jDz1HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780967168; c=relaxed/simple;
	bh=/Z5LiUCuhlMu4aHE9dt/dvDudINzTIXzQYGOU3CXi5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INDPj1HzciYIOlKW+hirXJpxN9fDFuSJcpVD5MYSoIYyF/ICHPits5bt8/Ky0lZh7tH4R6fqxgiUJyyVpKop3KDoQUxil6Uob1kHQ7OnT7zkfL92ro+1O1R36csFFnyKqORr7L/SbuDRuk1KFAG8pumXlkk9In9rwve+IbYeFy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TI//E+ci; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TI//E+ci"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422661F00898;
	Tue,  9 Jun 2026 01:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780967167;
	bh=xPOd5l/FQtVQSkuZbsIYVpu5CaTNTCJKbbqXyN1aq10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TI//E+cirZehSD7YXTdmAf02Yfrl111Gl0eGolC2TbLgJtWyf9d+qMoqi7y+GWExh
	 IV4yYf02fX3d4M40MAYSIg3L8RmicdgJ68TDCl9KvDWymUrjFbsOOCsD7NwV9Sy6I/
	 0gxP4Kf0MseeRlIkKt8gM8CWOrOdxS3T82DdxV+WwVdodXCZvkBIPnjlrrtqhgLhwl
	 X7uiI6R8ofzFMgq3F7ssIeWoPJSorMYWVoQH26Cijhz0onHuiQGFXEZzCtCT8bMEQl
	 woZqXiJFRu5gIKLbcWFcRTKOu2dGFbZQcK5wKLr99B+GiFS816ukWPHxoBpDVcwF6u
	 P4tNOdu2mPe5Q==
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
Date: Mon,  8 Jun 2026 22:05:23 -0300
Message-ID: <20260609010526.1998472-10-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609010526.1998472-1-acme@kernel.org>
References: <20260609010526.1998472-1-acme@kernel.org>
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
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Reviewed-by: Ian Rogers <irogers@google.com>
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

