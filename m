Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E401D1C07CF;
	Mon,  4 Nov 2024 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730737051; cv=none; b=I5hcNZpHh5GrkD6qJVQTIprytBWn8BuICO7Kb1gvoqkzksP/hKI4Tq0hHOYQSuchYGJCTqqlH2ZVrrsL5xv0Aoy3J1rnp3JHLS4UC4arEaVdVKRTHPI9+HUm7C0O3PJS1TTgNFdS+n3RyPj/kWg1ieNeeoafF0umArztU8bXyfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730737051; c=relaxed/simple;
	bh=t3T04Wte+t+ObVSyXqcE2uwcXfkKIa22kFNTw53IGZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sbu0hZhHaTHD4OWgQQLy+H16Akrhy7QarcltDq6h003AsU/nZokzTuHZaxKYlXeUJE6QpSB+LXefsiohICQAFoeSjAl7UDphBDEMcBGsLb2RCMvAtCwTOGchYEQZ8jr9Q568d34XfcsATx3F7LAY4woLyO/mCexP3bY4Y0humks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpHA46wf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpHA46wf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FC3C4CECE;
	Mon,  4 Nov 2024 16:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730737050;
	bh=t3T04Wte+t+ObVSyXqcE2uwcXfkKIa22kFNTw53IGZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RpHA46wfQmfg7GQ7fqpUIldQARXWKLCmWlkovYqeE07kGwgvB9QdhLDjA7Z8GbD0c
	 48BeUf8UESVlcdYWtFf3klmza2ovzNxGMLTCvCZfb3oXQGybEyQM/KLPXzJ4/vmRML
	 f9ysVSZpZIZv8kLmFKPbeoyAY4cKiHQIJarUJO3TUNivu6BzbfIwZ3iAKOHu9a1JEk
	 4wT9mFQ0AxJCRP3axJaVQIvSD3H+JPrzPtqi00I4ye/MmQjx6EQjY8im8DIcRAP1f2
	 7dBx3kgQC+oDAm9m5z3l6YS7K9GLvmmVsJ0JpJPiaNkIsh3h3rx9jJjg7u+g1Z3oz8
	 sbXG9BXmiu2yw==
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
Subject: [PATCH 2/4] perf-probe: Require '@' prefix for filename always
Date: Tue,  5 Nov 2024 01:17:26 +0900
Message-ID:  <173073704685.2098439.2208365513857043203.stgit@mhiramat.roam.corp.google.com>
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

Currently perf probe allows user to specify probing place without '@'
prefix, for example, both `-V file:line` and `-V function:line` are
allowed. But this makes a problem if a (demangled) function name is
hard to be distinguished from a file name.

This changes the perf-probe to require '@' prefix for filename even
without function name. For example, `-V @file:line` and
`-V function:line` are acceptable.

With this change, users can specify filename or function correctly.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 tools/perf/util/probe-event.c |   31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 665dcce482e1..913a27cbb5d9 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1341,7 +1341,7 @@ static bool is_c_func_name(const char *name)
  * Stuff 'lr' according to the line range described by 'arg'.
  * The line range syntax is described by:
  *
- *         SRC[:SLN[+NUM|-ELN]]
+ *         @SRC[:SLN[+NUM|-ELN]]
  *         FNC[@SRC][:SLN[+NUM|-ELN]]
  */
 int parse_line_range_desc(const char *arg, struct line_range *lr)
@@ -1404,16 +1404,10 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
 			err = -ENOMEM;
 			goto err;
 		}
+		if (*name != '\0')
+			lr->function = name;
+	} else
 		lr->function = name;
-	} else if (strpbrk_esc(name, "/."))
-		lr->file = name;
-	else if (is_c_func_name(name))/* We reuse it for checking funcname */
-		lr->function = name;
-	else {	/* Invalid name */
-		semantic_error("'%s' is not a valid function name.\n", name);
-		err = -EINVAL;
-		goto err;
-	}
 
 	return 0;
 err:
@@ -1463,7 +1457,7 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
 
 	/*
 	 * <Syntax>
-	 * perf probe [GRP:][EVENT=]SRC[:LN|;PTN]
+	 * perf probe [GRP:][EVENT=]@SRC[:LN|;PTN]
 	 * perf probe [GRP:][EVENT=]FUNC[@SRC][+OFFS|%return|:LN|;PAT]
 	 * perf probe %[GRP:]SDT_EVENT
 	 */
@@ -1516,19 +1510,12 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
 	/*
 	 * Check arg is function or file name and copy it.
 	 *
-	 * We consider arg to be a file spec if and only if it satisfies
-	 * all of the below criteria::
-	 * - it does not include any of "+@%",
-	 * - it includes one of ":;", and
-	 * - it has a period '.' in the name.
-	 *
+	 * We consider arg to be a file spec if it starts with '@'.
 	 * Otherwise, we consider arg to be a function specification.
 	 */
-	if (!strpbrk_esc(arg, "+@%")) {
-		ptr = strpbrk_esc(arg, ";:");
-		/* This is a file spec if it includes a '.' before ; or : */
-		if (ptr && memchr(arg, '.', ptr - arg))
-			file_spec = true;
+	if (*arg == '@') {
+		file_spec = true;
+		arg++;
 	}
 
 	ptr = strpbrk_esc(arg, ";:+@%");

