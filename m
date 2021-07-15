Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481FFC1B08C
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36FFC613F8
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbhGOQKa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbhGOQK3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 12:10:29 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDC8C061760;
        Thu, 15 Jul 2021 09:07:35 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id g12so4052101wme.2;
        Thu, 15 Jul 2021 09:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zODVNKHonSU3qYAwCTgn8Fil5BPscvRVeJSPN9g2BUw=;
        b=IZ1LtRA5qcAHvtJqVx7FrmUCOZhSd9C1k2MHghA/4JwXydzKrSAzg6nqj9bSZovTAd
         qZ0c3qOyrXbCcLRj8DQJORkhQSrp6j4CwIDDGaOJRYhP88VcD0+Ob7KfrcUbI02uySfI
         DheV+hzeEcSt7P7/cPOAjBriPqsf3J8Fq7NYBOik6Y2Ist4Qw3rXf3l5dDnL7dSJAnL/
         LJ/kCALOWMVMlinw3yzsznxo2tqtG9cooFAFc680o8jw3h6LsxFYS3+5YpOPsjWNQiBk
         zJeiEG6lzJUuTAWQXE5mzaUKR+TWsQSVYEgTntUdzdstS7r6/3ZOp68d0qONvX/urrHK
         e93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zODVNKHonSU3qYAwCTgn8Fil5BPscvRVeJSPN9g2BUw=;
        b=LDK/Vv6XV3Aafk8Ox3lLlv2KWSYR85tZMPSPZYdHN35nGFHWa0FMdFZ4AmvmPBYTfp
         Kzy8Gfu/HWeLalqbwOzAiA69KZsG5mKs0E9Y1lZyL7mqpRdPu/j3Iy96HOcQOP3kdS6P
         2/lfERGJ7xU5WFmRqDG1F1+moaPYLVmy6tXeZ4H8t8pRDwxJ/OLv3BqaXAnJd8bZTell
         UTcqwUgKYRECWEWBFzhvhLiYcV2Y27R0z8RQdDD6EfAbfw9QpTPhFscHdaVQ32A4VH3W
         oFgah7Ph/OHt0qgs4aSQIK+xRlILOTotMDEPKj7p78Gh4kMYJgnb4NuTwtt4ytDjduBk
         P1cw==
X-Gm-Message-State: AOAM530kuGvr5iHfR2wi+uZNuZQwCzhdhYRkJlS+dopQgUwuWIHjPsfj
        EPApGjjbh9KjF27bC/t4SF4=
X-Google-Smtp-Source: ABdhPJwdeXi0HllA/ZeR+1+SiJjTxrD+sLgbsPuyXITHOf8RYw+hHZdiKA3DtgaEdC1EdO6Hhyy93g==
X-Received: by 2002:a05:600c:20b:: with SMTP id 11mr11824111wmi.112.1626365254261;
        Thu, 15 Jul 2021 09:07:34 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id k13sm7446952wrp.34.2021.07.15.09.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:07:33 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [PATCH 06/20] perf dso: fix memory leak in dso__new_map
Date:   Thu, 15 Jul 2021 18:07:11 +0200
Message-Id: <60bfe0cd06e89e2ca33646eb8468d7f5de2ee597.1626343282.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626343282.git.rickyman7@gmail.com>
References: <cover.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ASan reports a memory leak when running the perf test
"65: maps__merge_in". The causes of the leaks are two, this patch
addresses only the first one, which is related to dso__new_map.
The bug is that dso__new_map creates a new dso but never decreases
the refcount it gets from creating it.

This patch adds the missing dso__put.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/dso.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index d786cf6b0cfa65f2..ee15db2be2f43403 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1154,8 +1154,10 @@ struct map *dso__new_map(const char *name)
 	struct map *map = NULL;
 	struct dso *dso = dso__new(name);
 
-	if (dso)
+	if (dso) {
 		map = map__new2(0, dso);
+		dso__put(dso);
+	}
 
 	return map;
 }
-- 
2.31.1

