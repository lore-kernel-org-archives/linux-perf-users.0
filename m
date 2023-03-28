Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB174C76196
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Mar 2023 23:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjC1Xoa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Mar 2023 19:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjC1Xo3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Mar 2023 19:44:29 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B829271C
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Mar 2023 16:44:27 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54196bfcd5fso134501087b3.4
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Mar 2023 16:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680047066;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HGJxUJerM1XBlH5Vw8yfDpIpiKjpGM+XvswwIO37cNI=;
        b=KkKnRjrfPFK7+Xl+tjPG9jVQoH2bB80Y0tg2xfkJKo72F2K0zWZ9FrecRBLygkiVBv
         0elf59nvBKOMPlLfHd4kP7ryzfT3GODP9Um5s/ZmGlSPz3czhx25lVi+3V1O+dTrodSc
         xvhXsG7cmCK8e5A7yFGkeZ1GhxhgA8Ct2wKl356bq4qPqGgOdsam7VN/g9yv/0vCFi7E
         ytJ6mSE1m5Ns9Y5Zj1bM9/GFUKegLifCX0XGTTW7e0NG9O1qBAxqACA0cfBECiGF7JvM
         d4/Es3Cn4AQfr7IRW2B5YUIUTjcymsX2NtZMAEXyk05LLnsz+DDFEei20tjYitxtA4F4
         gv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680047066;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HGJxUJerM1XBlH5Vw8yfDpIpiKjpGM+XvswwIO37cNI=;
        b=h6ZRkMsY3HWd4/v/XETNe9qBDW2DgqljYq5jJoI0kPfXpMK39Kp3FwX1r2m+8jHcNE
         vxBcqnCUEG2dAjI+jZYPnhnW88my05cOvf4EzFE1waMzqQH/7mi/yIsDiKURf3TiP4DZ
         5p6xOzKDerRjAq8crkUnCPFFTCIP7F++v/AuQV+1iY2anyYbHDFeSXdUK+C/p1bHbSwk
         JDIXDmpYk/DMDliQQXkBYOkMyEiozc6gnwD3lr0DdDYol76Z86g2JdXQyTxi3wZr/h4i
         akpJUXaempgVCQR4kFzvnZTdkFhlSPGf+swnW0a41uZfkTstDbPAhiLcToFrDVoWD4yc
         Injw==
X-Gm-Message-State: AAQBX9cYCohuVviGn8wMX79owl5hynKSbwTQDsuMvHjecYjR9JWf8FmW
        KLvHMKMahDo3ZNLgFGoXi3ixuKviqinF
X-Google-Smtp-Source: AKy350bHQnoarduuIqMQai9OcwRPrTrd+aPn1ERBPh86UBF49XcgTNH73+tztXFEwKvJTNfyyk9/QVtEtZQC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:6519:f0d3:9540:5c31])
 (user=irogers job=sendgmr) by 2002:a81:4516:0:b0:541:9b2b:8240 with SMTP id
 s22-20020a814516000000b005419b2b8240mr8126079ywa.6.1680047066718; Tue, 28 Mar
 2023 16:44:26 -0700 (PDT)
Date:   Tue, 28 Mar 2023 16:44:13 -0700
Message-Id: <20230328234413.1081014-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1] perf symbol: Avoid use after free
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If demangling succeeds then sym_name is set to the demangled string
that is freed. Rather than test if sym_name is empty and possibly
use-after-free on the return path, expand out the alternatives.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol-elf.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index c0a2de42c51b..b7e3e492bff3 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -577,15 +577,17 @@ static bool get_plt_got_name(GElf_Shdr *shdr, size_t i,
 	/* Get the associated symbol */
 	gelf_getsym(di->dynsym_data, vr->sym_idx, &sym);
 	sym_name = elf_sym__name(&sym, di->dynstr_data);
-	demangled = demangle_sym(di->dso, 0, sym_name);
-	if (demangled != NULL)
-		sym_name = demangled;
-
-	snprintf(buf, buf_sz, "%s@plt", sym_name);
-
-	free(demangled);
+	if (*sym_name == '\0')
+		return false;
 
-	return *sym_name;
+	demangled = demangle_sym(di->dso, 0, sym_name);
+	if (demangled != NULL) {
+		snprintf(buf, buf_sz, "%s@plt", demangled);
+		free(demangled);
+	} else {
+		snprintf(buf, buf_sz, "%s@plt", sym_name);
+	}
+	return true;
 }
 
 static int dso__synthesize_plt_got_symbols(struct dso *dso, Elf *elf,
-- 
2.40.0.348.gf938b09366-goog

