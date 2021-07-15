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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF13C47E48
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6B46613F6
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhGOQKu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234776AbhGOQKp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 12:10:45 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC43C0613DE;
        Thu, 15 Jul 2021 09:07:51 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u1so8529042wrs.1;
        Thu, 15 Jul 2021 09:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kkaTDFSjJN8jxx/BmLSTcWle3Y7NumKQn0PW5W5bpnw=;
        b=uXJIMVwqu0ei4HpVfxH9X4/MBgQSxhfjCJLRvlIQL3a0UjNTwwERb6Bnzu8nekob4G
         1EmJ9ChCikHpL9g2K1PrMwdxj1FFlLPNTdtFSg6Xyuh2tX9eAUII4cAoACXp7gWCHE9a
         3FfMrdC5X/FFBnCmI5L3faZGSJ8omhMMR8tNWRY0EQkHNenZjkYicurWiYvI5ULJKfql
         m4s8ETywKHT6cDbu5rR81f2kEB//9M/Uv4m+R3+QrLiRHBmqge6jKtMhMhHRISRVA/4w
         Mb6zFa8PHTQ9fh2pK4WQrn8kh4cBDYFc/4Ma+IGxUiiFxB/k9khSz6+3e2g/F5+z1yI9
         nzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kkaTDFSjJN8jxx/BmLSTcWle3Y7NumKQn0PW5W5bpnw=;
        b=f2BK2ZhxNOVASsqvrNW74S7hIhdGRcSsC0iqmNdyRL7K7Bu7frEzIz1+U23OqWmbAg
         T3B9qCWUnDbqKxRFi05dUZ5eLZeOtv+3nsq2ytWwYCwZhTEivu0MxU6oPZkIxFW2dtUo
         GXj0DvEQQdC6oM4FlF9E21Go0E1LtzmXZdvs7lETPjzKwgKMzd79B263imBXzSHQBG4W
         CqKiWFkQ879JVYOgTGK3gF5eFi3wBdN/dK/YCSowjpFqiR3A/7tdrbAtWTk+F94Qbzei
         uPi5J+xGNuqli3auCUglD4jHrGlNR/HDofhh48AOApLFQdr9gS23dALu+f2yrJFVWpTd
         bonQ==
X-Gm-Message-State: AOAM532nfWCJsYgZA+6W/TWjq1Eh/lxgePsy4TsjEXhDMakXfiQzxMZx
        hDjmmKB+SEXUJN7bzQJaqxc=
X-Google-Smtp-Source: ABdhPJw+Z8NmOHZicAtflaKCfefJdldIEo4obXkKfo6ydc0iq2P2717fbkY0fc6MWqcSgaCdts/+fQ==
X-Received: by 2002:adf:eb43:: with SMTP id u3mr6602612wrn.83.1626365269961;
        Thu, 15 Jul 2021 09:07:49 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id k13sm7446952wrp.34.2021.07.15.09.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:07:49 -0700 (PDT)
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
Subject: [PATCH 20/20] perf util/probe-file: delete namelist on error in del_events
Date:   Thu, 15 Jul 2021 18:07:25 +0200
Message-Id: <174963c587ae77fa108af794669998e4ae558338.1626343282.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626343282.git.rickyman7@gmail.com>
References: <cover.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ASan reports some memory leaks when running the perf test
"42: BPF filter".
This second leak is caused by a strlist not being dellocated on error
inside probe_file__del_events.

This patch adds a goto label before the deallocation and makes the error
path jump to it.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/probe-file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index f9a6cbcd641501b8..3d50de3217d50ae1 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -377,11 +377,11 @@ int probe_file__del_events(int fd, struct strfilter *filter)
 
 	ret = probe_file__get_events(fd, filter, namelist);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	ret = probe_file__del_strlist(fd, namelist);
+out:
 	strlist__delete(namelist);
-
 	return ret;
 }
 
-- 
2.31.1

