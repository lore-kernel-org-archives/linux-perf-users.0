Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA2B3D3312
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777828257; cv=none; b=IOTg3LctFa25mEkSQ8J7b/anGq7OCVVFh21Ur0Xv2BVEjbIV7gfPiddrJu39KoyAmtsAvAM7rkdtTLr5hRI8g30EjwPdaXRMECSvcnqMp8sC0pX/+Um6+CkIvVsowsojGk6ROmQkTP2g3UWtwyA+QCGPM0vkIZcw6sYBB1Ca9Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777828257; c=relaxed/simple;
	bh=TVHo9dnFcw/tGdRrYrVbasoITISy+2trrO5Bo/2ExRE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=co/bztEQO42MUIW+rEnLpmGUA6QHWamvByXRVtfjW13zOeKix/K5Pftm4/qmXHXfDMW4haVzxdUJZlUZKx1hAueYiuElislegi6/YV/WPly8mqejyOfDy4ww/XKPWr+T9j8ohFSdYge6D7w+Gm+PJWnnfuw5nZ2Y5yTMVuSnNOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P9dKItcx; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P9dKItcx"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c726f4055so5590233c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 03 May 2026 10:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777828255; x=1778433055; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N0tW0FxSBXoHGLy8UAyiIK3CDK7lkkw9WSavrtAU+9E=;
        b=P9dKItcxpVCMY5cMFHC0kQllnKMtIcU+8XCizQQjjJbcNKoIZRuCFU8KDlh/Vkt1Lm
         ZxBQh+s92fQVa3vS+8Ky1d2aaqcgAG2CLbcw8YHkh0+84FdtVQLklV7WPAmbKRX58leS
         W71cht323Y3W+2EiA//UTcCnSoRUX/ChSC2CBMA0rLKTC2GTdF0bGNMXCfHUA5xIFYXi
         do2UkOhyp6I8pNsugq4vfexkEMkKRv04wwhgW9JZ6tHWfODdXOheKa2WSLI562QJ/dEs
         qpWK1TETgv023IdxeOf+yVegl7Sfetps9EpbaNFWu7+R2SfehOTt4VgVb93IXkCIlQ8b
         JwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777828255; x=1778433055;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N0tW0FxSBXoHGLy8UAyiIK3CDK7lkkw9WSavrtAU+9E=;
        b=pVaO7pBNPYEV0MDpB5mIil7zLQf/ytMiNge6bntiulSgbK6/MwMZqMgQDNam1kthsT
         +PeYv5xj6ZYqldGgU1MY4JScRvoCNcHBvP1P5pYJNkDfladr1GSepjGwZwLYT16L5bei
         uxz6RJb5VZRGfbpzUu9GjAX/dZmTeM71rWx2/m5reqUPjl6vbsUT06ffGIAsRYZLkuKg
         XIlVqkzhRtxr6FjnaMH2HhgHmlbLzaIiHbUtftLYMXeQuj6h6WK7XY2MbDha/jbyno9C
         lsGVFlRkgcoPEEdcz6bkeX3EY91H/GDhrJv1+4zzNOIF+7apxmjG0yPL63pPJNdGv5eR
         7vTA==
X-Forwarded-Encrypted: i=1; AFNElJ8I/EW5wjciS1MSoTFIpQRXII1wcnUdITpWjol6Q4CouysJGFM2lx6w2ikydmiQ8hRHJL6a0TV/efC7XcrxLsU1@vger.kernel.org
X-Gm-Message-State: AOJu0Yxai81a641yU2TZMjskQB/oTiryxA421xbGlWYZqxB+EQsM9jU0
	qqJ67qRRQPiXa2jr2kA05yYnVO3ALnxXDCGF1vO28JuuCvPkjs4GP5GktbSKWDyRNgNWSGSVi92
	h3qmWB1eHCA==
X-Received: from dlbuu10.prod.google.com ([2002:a05:7022:7e8a:b0:12c:87ba:191d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1a85:b0:127:380e:ff5a
 with SMTP id a92af1059eb24-12dfd7f994bmr3060618c88.17.1777828255093; Sun, 03
 May 2026 10:10:55 -0700 (PDT)
Date: Sun,  3 May 2026 10:10:32 -0700
In-Reply-To: <20260503171032.1559338-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503003552.1063540-1-irogers@google.com> <20260503171032.1559338-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503171032.1559338-7-irogers@google.com>
Subject: [PATCH v4 6/6] perf debuginfo: Fix libdw API contract violations
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
Signed-off-by: Ian Rogers <irogers@google.com>
---
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

