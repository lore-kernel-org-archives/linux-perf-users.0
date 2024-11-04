Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5241C07CF;
	Mon,  4 Nov 2024 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730737042; cv=none; b=btsFOjvUfsPtHGiES6RTZBtC8UvRqsv22Ua+VgAESjw7lqo2TbWT5g6jEZid7IYSY3Gfvzx9jdA+rrG1P0EIkqt+GIpk6d26oUu8hPwgnwrh67gNJXx4LCooLQ8EJYjKG9BmpF3wcUPM0ueAsuZmSOvaUkRsBRHaD8YGgsonTxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730737042; c=relaxed/simple;
	bh=eb4OfohM415xwWSX2GTo7qtBT4UuudlHKe11OO6YLzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJhrw5rTYsVapr/XWEAOnijJ2bWOWwn0zdJlpqG1+T9mHsJ2denyXL4R6vBLPGoJqkk/X/KTJ0uyQDgprBmJAlBCQSImZ6mWToNOAqImzzrcsvab4WrBg5fJ54XP2BhcZHbGKRYGCGGP1vFDQjFHZ8wvwHC06l5UIb7TuzR1FDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErPOQQuf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErPOQQuf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B08C4CECE;
	Mon,  4 Nov 2024 16:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730737041;
	bh=eb4OfohM415xwWSX2GTo7qtBT4UuudlHKe11OO6YLzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ErPOQQuftN/PNxxttrpC21fgyOuxkFmUo7C8V23N0jTh8XpHeMoGiYdMpdvrJXMSh
	 xKBAXHbnSBHLFDxnVIuU5y1buyAgcRvDPiZBhcN41kkPD3OiR1m90nXPAPygMfli54
	 qwhaZ2CR7LF43VJLnrlbBr03Yi0575mSkYP7f4laFWHyNeXdI72T7wC0kpLbVckQZ+
	 4FydJ+jWY10aV3a8JOKbEcWipgG4A/unAOva63klUpyUPyN08zRmVq3AtxiwCSbEdT
	 B5fJyEmEGO9xyCODginjhReOaw1ZWXRL7NJABa/1oOI6pk9mII3gGHv442cR6L1AqM
	 XgAWaR1CVWr3w==
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
Subject: [PATCH 1/4] perf-probe: Fix to ignore escaped characters in --lines option
Date: Tue,  5 Nov 2024 01:17:18 +0900
Message-ID:  <173073703801.2098439.2570890674739658493.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To:  <173073702882.2098439.13342508872190995896.stgit@mhiramat.roam.corp.google.com>
References:  <173073702882.2098439.13342508872190995896.stgit@mhiramat.roam.corp.google.com>
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

Use strbprk_esc() and strdup_esc() to ignore escaped characters in
--lines option. This has been done for other options, but only --lines
option doesn't.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 tools/perf/util/probe-event.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index a17c9b8a7a79..665dcce482e1 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1355,7 +1355,7 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
 	lr->start = 0;
 	lr->end = INT_MAX;
 
-	range = strchr(name, ':');
+	range = strpbrk_esc(name, ":");
 	if (range) {
 		*range++ = '\0';
 
@@ -1396,16 +1396,16 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
 		}
 	}
 
-	file = strchr(name, '@');
+	file = strpbrk_esc(name, "@");
 	if (file) {
 		*file = '\0';
-		lr->file = strdup(++file);
+		lr->file = strdup_esc(++file);
 		if (lr->file == NULL) {
 			err = -ENOMEM;
 			goto err;
 		}
 		lr->function = name;
-	} else if (strchr(name, '/') || strchr(name, '.'))
+	} else if (strpbrk_esc(name, "/."))
 		lr->file = name;
 	else if (is_c_func_name(name))/* We reuse it for checking funcname */
 		lr->function = name;

