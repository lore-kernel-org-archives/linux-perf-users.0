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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54CCC07E96
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92B93613FB
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhGOQKY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhGOQKY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 12:10:24 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C406C06175F;
        Thu, 15 Jul 2021 09:07:30 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id g16so8484190wrw.5;
        Thu, 15 Jul 2021 09:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6YzVVQ9raikcD7O+6r9jzZj7DG69dggdUsdgRvtHtj8=;
        b=llsk1gEkjbRzG7MxDrSgNOKvNugN1EirLisTysCRv0bRlCjuB1XCV0+PPjdcHNoG/I
         CSpJT/WRj/BBwKOaBK+dfqMx+Js+SWHK1kb+W3b12NtKsS+3jIZWVm1JWGjAtVOPPeGd
         atie9nNTkayfbP6dLGYPUAFqazDStGkEH5VBoTsVFdhHOeq5NHGgWEhxBrBytAEkZAMy
         d8nokdOFkRHaavO8Yd+UGtviZN4TaBa0acYu8hMxOoQecHSoF74dVpNM+X7ajINmT9u3
         8Y4YIOj7m4FBJYmxe5eOIs3nilQdvBrrDtg64qCKDBQn4CxM7qRK1bNq5Z6Y0cWepP77
         If+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6YzVVQ9raikcD7O+6r9jzZj7DG69dggdUsdgRvtHtj8=;
        b=rUcl311UhapAoL5+hfRttgWOM6abYW9s28XuqckaFp2jOjPmo8XhmSnwFo0t4cjqYn
         zTNz78KhCZ53YimXfX6JyxkIQgxZld6UMEUHHr5NSHH4+j1VqeAphJ/Jwf9O3iesv/Cq
         h3pIp8qPhLXAZeIKGKbww1GgiqvRsZwa129t2jquAllprDkJjCZiVhvik8I7NaqiWj2P
         ZA8HQP1Ny/lQRWkp4jlCGAUpberezEPL9SEftCw7TZctBbDDRvjzN/00xq6asQ6dJlvy
         jv0TQitn3SCZE+UFO3IwS2Afz7b4N0KIdZTgTYDw3IVugXAd915zEseAZrok6qkkGoOt
         HVvg==
X-Gm-Message-State: AOAM530iSGCtz7O8e2sKLz2H5L+InEMr84hNsqJE99izU49Eof1Vja7u
        6PGuWYPuY9LY0PCutrZiCFA=
X-Google-Smtp-Source: ABdhPJySrfy+vaD2JFQh37j535QO6MbFKw9goIbS2l2hIgAYc4GT1yUsRAjJtVxpy+IeAp1GkiDnpw==
X-Received: by 2002:a5d:408d:: with SMTP id o13mr6699077wrp.246.1626365248614;
        Thu, 15 Jul 2021 09:07:28 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id k13sm7446952wrp.34.2021.07.15.09.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:07:27 -0700 (PDT)
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
Subject: [PATCH 01/20] perf nsinfo: fix refcounting
Date:   Thu, 15 Jul 2021 18:07:06 +0200
Message-Id: <55223bc8821b34ccb01f92ef1401c02b6a32e61f.1626343282.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626343282.git.rickyman7@gmail.com>
References: <cover.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ASan reports a memory leak of nsinfo during the execution of the perf
test "31: Lookup mmap thread".
The leak is caused by a refcounted variable being replaced without
dropping the refcount.

This patch makes sure that the refcnt of nsinfo is decreased whenever
a refcounted variable is replaced with a new value.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/builtin-inject.c   | 5 +++--
 tools/perf/util/map.c         | 2 ++
 tools/perf/util/probe-event.c | 4 +++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 5d6f583e2cd35be0..ffd2b25039e36e1d 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -361,9 +361,10 @@ static struct dso *findnew_dso(int pid, int tid, const char *filename,
 		dso = machine__findnew_dso_id(machine, filename, id);
 	}
 
-	if (dso)
+	if (dso) {
+		nsinfo__put(dso->nsinfo);
 		dso->nsinfo = nsi;
-	else
+	} else
 		nsinfo__put(nsi);
 
 	thread__put(thread);
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 8af693d9678cefe0..72e7f3616157ead4 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -192,6 +192,8 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 			if (!(prot & PROT_EXEC))
 				dso__set_loaded(dso);
 		}
+
+		nsinfo__put(dso->nsinfo);
 		dso->nsinfo = nsi;
 
 		if (build_id__is_defined(bid))
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index c14e1d228e56b1c6..e05750cea34c3a95 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -179,8 +179,10 @@ struct map *get_target_map(const char *target, struct nsinfo *nsi, bool user)
 		struct map *map;
 
 		map = dso__new_map(target);
-		if (map && map->dso)
+		if (map && map->dso) {
+			nsinfo__put(map->dso->nsinfo);
 			map->dso->nsinfo = nsinfo__get(nsi);
+		}
 		return map;
 	} else {
 		return kernel_get_module_map(target);
-- 
2.31.1

