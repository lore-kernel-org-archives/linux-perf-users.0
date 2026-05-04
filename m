Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA6A31F98E
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 08:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882372; cv=none; b=Q2iba4WuEJIW3tSwe5WpN4ZuHBG//XNcMsM8n8sXI0bQwS/nLk4fVC7KJ+hraZVTCIpeQ5fnsJv/+zqnp6PshOZ2b2zBXQJEB81VQtbCnGtc+z6QCIFH7Ob81xwEmtUqGrvZiKfd2Z0vzCI8butKzt/CSnBFfibdqLMT9ydlo30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882372; c=relaxed/simple;
	bh=86Fi8XgRbKLUoxAcrNtQ/NCYtxcmPhDpKOGB2wMyx9M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ky00csEpmT9/i4RcS1L24C0rnKMy9+sUGGk6BBZRu8pVs10e25AKYpJd4JMRtFz8ONFSbEFtDSdDViplN6armjMLT81jS0zIg3OStYLFFQWmz9WyDJIC2dhv+47+QU1dl98dBGwEg12swpqZ8/g+00jkb8RtWt+6LJHowlcA8AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MUZuLnAA; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MUZuLnAA"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12dba1e866dso3831106c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 04 May 2026 01:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777882370; x=1778487170; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ws2FlyxY3Py6KisW5mWMui419nDHfCw03Zt9ciWQIP4=;
        b=MUZuLnAAu/oOYxIZ1TQ/OUgzKDqIOirC+4mN1mJMyx6OQdWwYTPcHtyHWzfUYKlO15
         78YWRDU5xyKye5g5BJhF+qG0pXCN/Yr5NgxFCGqgASBCZ5pF07IOmGQ7YpqcmF/QnQjb
         V5LrYmRboRJLDTFQGJmtTXGJ+S5ISndT1Z7QqjKXS7EjfXNZGToO4rbO06MHQcmW+wck
         NjLfWOKSYf3LMHNwf+VCwAXWa/SG7W9p10J3u7Xp7vJlQDA8Suk4WZd50SMLWF7lAqj6
         +2xyDQuu6RpiiscBND9QhGd5DhcoolSpTt5p9GqyKBhhhkiHqWfOB0xsTUG1SNe4tA9J
         E4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777882370; x=1778487170;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ws2FlyxY3Py6KisW5mWMui419nDHfCw03Zt9ciWQIP4=;
        b=o/9798UIvC4CDWrV5m3Jr+E+5xi/SbDezDatBRmSyq6LG4q2o+GOyfelzsMhJiMJ9D
         7RjEMeEG1SHcdORa0ikjXsJqxoolbws8rs9AL2j0ZyokXHBsbNoFQYrTRv1Vu2KlK8RM
         UPDVbvwFCyGWmyMUSw08iLykcWtvlAdXNLZe0pwbqEtNVEmMuQeB+iKupKBpYVVU5UoW
         i+YOmSJWxyytX0ShOTrYoJnZ6ewTVNcPlE8WSE3mQMVbatsy4twupdQBbf/6CCHq2peJ
         jlIYfvbT3RHnYhccnilEcLLnT5g4G9xAgTmbkOjmZgvtzX6fl01ftDqJXdALWNKjMR9c
         am+A==
X-Forwarded-Encrypted: i=1; AFNElJ/OFzqXvyT/F4ghx8ewzANDJDKwXn8f+uZNNvDhXaQaauh0b9s5kc5/jslwnPoTwXyxxgOHnHCRfoYGS5RdNxoz@vger.kernel.org
X-Gm-Message-State: AOJu0YzHkeT2uTaq4yt++n5eNJJBx9jcAF0G8qO1f4UiocKYxM4zIdH1
	uF5CRPv0k+EfVqfBHDRjNNOxseh0ysMyPvUpYPiEnl9ZY1Z9i4OlZxoZupJIXH8ZypD5N9ZojHC
	NDlbAiECxnQ==
X-Received: from dlbps10.prod.google.com ([2002:a05:7023:88a:b0:12d:d43c:4120])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:68a9:b0:12c:aae:7b43
 with SMTP id a92af1059eb24-12dece4285bmr6819531c88.24.1777882370014; Mon, 04
 May 2026 01:12:50 -0700 (PDT)
Date: Mon,  4 May 2026 01:12:27 -0700
In-Reply-To: <20260504081227.2203848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503171032.1559338-1-irogers@google.com> <20260504081227.2203848-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504081227.2203848-10-irogers@google.com>
Subject: [PATCH v5 9/9] perf debuginfo: Fix libdw API contract violations
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Zecheng Li <zli94@ncsu.edu>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Check return value of `dwfl_report_end` during offline initialization.
Validate `dwfl_module_relocation_info` result before passing to `strcmp`
to avoid potential segmentation faults.

Additionally:
 - Fix a file descriptor leak in `debuginfo__init_offline_dwarf()` when
   `dwfl_report_offline()` or subsequent setup calls fail.

Fixes: 6f1b6291cf73 ("perf tools: Add util/debuginfo.[ch] files")
Assisted-by: Gemini-CLI:Google Gemini 3
Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
v5:
 - Added Acked-by tag.
v4:
 - Fix file descriptor leaks in debuginfo init paths.
---
 tools/perf/util/debuginfo.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
index 0e35c13abd04..84a78b30ceac 100644
--- a/tools/perf/util/debuginfo.c
+++ b/tools/perf/util/debuginfo.c
@@ -42,6 +42,7 @@ static int debuginfo__init_offline_dwarf(struct debuginfo *dbg,
 {
 	GElf_Addr dummy;
 	int fd;
+	bool fd_consumed = false;
 
 	fd = open(path, O_RDONLY);
 	if (fd < 0)
@@ -55,6 +56,7 @@ static int debuginfo__init_offline_dwarf(struct debuginfo *dbg,
 	dbg->mod = dwfl_report_offline(dbg->dwfl, "", "", fd);
 	if (!dbg->mod)
 		goto error;
+	fd_consumed = true;
 
 	dbg->dbg = dwfl_module_getdwarf(dbg->mod, &dbg->bias);
 	if (!dbg->dbg)
@@ -62,13 +64,14 @@ static int debuginfo__init_offline_dwarf(struct debuginfo *dbg,
 
 	dwfl_module_build_id(dbg->mod, &dbg->build_id, &dummy);
 
-	dwfl_report_end(dbg->dwfl, NULL, NULL);
+	if (dwfl_report_end(dbg->dwfl, NULL, NULL) != 0)
+		goto error;
 
 	return 0;
 error:
 	if (dbg->dwfl)
 		dwfl_end(dbg->dwfl);
-	else
+	if (!fd_consumed)
 		close(fd);
 	memset(dbg, 0, sizeof(*dbg));
 
@@ -167,7 +170,7 @@ int debuginfo__get_text_offset(struct debuginfo *dbg, Dwarf_Addr *offs,
 	/* Search the relocation related .text section */
 	for (i = 0; i < n; i++) {
 		p = dwfl_module_relocation_info(dbg->mod, i, &shndx);
-		if (strcmp(p, ".text") == 0) {
+		if (p && strcmp(p, ".text") == 0) {
 			/* OK, get the section header */
 			scn = elf_getscn(elf, shndx);
 			if (!scn)
-- 
2.54.0.545.g6539524ca2-goog

