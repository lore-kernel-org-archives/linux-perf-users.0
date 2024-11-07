Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D060F2E3EB;
	Thu,  7 Nov 2024 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730991137; cv=none; b=I178MSLXytqun36SG2pNzP8xnFyYsSEx0f6532XugHBYodO3uIAHWc9nh+LQkFYlJWbTpmEvpj+lhO/QiYRR7+ZdCVW1LvB0qT/EWZdyELgOpOotUZ4wV24g/Tz6mEGH1eN/yJv30lWfXa2kvbOIscatERCFBUu89AVgyRS416k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730991137; c=relaxed/simple;
	bh=niKnau8xp0QGeojUctFEmxGVTs9K3dLLDDtVIkokeG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k7VT/PAPJ4Lff10hUXqUhCgzXNt7MD6DK4238nH+EYXZoL9H7+18wE/8x1jlTxMHhYcesDUG4Cm9lFoPF4G1sKcH3XxD+vKnpskQTqYci+ITY1oZWOk2VUazQnp7ETFXkySHSgQ7ys9Pu6DRFezd3mq6jwxhFilCNzcfTxCS2qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FegfRSTT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FegfRSTT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB155C4CECC;
	Thu,  7 Nov 2024 14:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730991137;
	bh=niKnau8xp0QGeojUctFEmxGVTs9K3dLLDDtVIkokeG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FegfRSTTTsWZJdQoc2IapAbPhkFlRztoK8nCtV+qxD/sdisvxOGZNN5JFfmO5m9Tn
	 Ky4Ts9lLxcRd2RIwXT1VghGkYkofEkRhZSt70/Owfy4RzXcxr+Hi9N+Qlpl1lqXl5O
	 mBtlLUzoGkKhLwiN/SzvZksawWEwnO3BdtchPacJ0WbDVmuSWewEX+vIw1QTL2x5xm
	 UvTuWFRldkYyclt7/7a12Tsagt87OcEyjTWJpJX99CEnwPY8ZUg5stcR7TONHuSvw7
	 2nhGLXRGRQyTKZFSYM0349XiDY1FZbcYKDcocGH95MhIKL0TdAYs9km9+f5jZ7zB5Z
	 fxHNSP3ZIwdqg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Dima Kogan <dima@secretsauce.net>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] perf-probe: Fix error message for failing to find line range
Date: Thu,  7 Nov 2024 23:52:13 +0900
Message-ID:  <173099113381.2431889.16263147678401426107.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
In-Reply-To:  <173099112488.2431889.1181692857521683304.stgit@mhiramat.roam.corp.google.com>
References:  <173099112488.2431889.1181692857521683304.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

With --lines option, if perf-probe fails to find the specified line,
it warns as "Debuginfo analysis failed." but this misleads user as
the debuginfo is broken.
Fix this message to "Specified source line(LINESPEC) is not found."
so that user can understand the error correctly.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v2:
  - Added new patch.
---
 tools/perf/util/probe-event.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index a17c9b8a7a79..6bfe7ead3681 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1036,6 +1036,17 @@ static int _show_one_line(FILE *fp, int l, bool skip, bool show_num)
 	return rv;
 }
 
+static int sprint_line_description(char *sbuf, size_t size, struct line_range *lr)
+{
+	if (!lr->function)
+		return snprintf(sbuf, size, "file: %s, line: %d", lr->file, lr->start);
+
+	if (lr->file)
+		return snprintf(sbuf, size, "function: %s, file:%s, line: %d", lr->function, lr->file, lr->start);
+
+	return snprintf(sbuf, size, "function: %s, line:%d", lr->function, lr->start);
+}
+
 #define show_one_line_with_num(f,l)	_show_one_line(f,l,false,true)
 #define show_one_line(f,l)		_show_one_line(f,l,false,false)
 #define skip_one_line(f,l)		_show_one_line(f,l,true,false)
@@ -1068,6 +1079,8 @@ static int __show_line_range(struct line_range *lr, const char *module,
 		ret = get_alternative_line_range(dinfo, lr, module, user);
 		if (!ret)
 			ret = debuginfo__find_line_range(dinfo, lr);
+		else /* Ignore error, we just failed to find it. */
+			ret = -ENOENT;
 	}
 	if (dinfo->build_id) {
 		build_id__init(&bid, dinfo->build_id, BUILD_ID_SIZE);
@@ -1075,7 +1088,8 @@ static int __show_line_range(struct line_range *lr, const char *module,
 	}
 	debuginfo__delete(dinfo);
 	if (ret == 0 || ret == -ENOENT) {
-		pr_warning("Specified source line is not found.\n");
+		sprint_line_description(sbuf, sizeof(sbuf), lr);
+		pr_warning("Specified source line(%s) is not found.\n", sbuf);
 		return -ENOENT;
 	} else if (ret < 0) {
 		pr_warning("Debuginfo analysis failed.\n");

