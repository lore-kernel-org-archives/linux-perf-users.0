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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A8CC47E4B
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 435EF613F6
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbhGOQKk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbhGOQKh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 12:10:37 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B970C0613DB;
        Thu, 15 Jul 2021 09:07:44 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d2so8560394wrn.0;
        Thu, 15 Jul 2021 09:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O+9Ne/QX0Bs3iWrwgum6FPcBqk+/cS+YWhh75mjH/Og=;
        b=fwPRaLU7B1RgsPmB8i/mQv2O7dBKqe6ZIPqwBpz0easFPpclFZrpS+oMr6a9W1Pa/+
         cHm2G75FnSvTfGPsb7qwQEyiWG8hpGar+FilZVL/NVnUZLSpPumJfYwj9DP4MZKvGWnm
         pilg6VALYFOUtDkG/cUH8K5hm7lqnw2plLTSD90eRb4WOkuCamZ3X+Fzncyw3vp8MG0B
         C1d1+GWERnWkWSNh6JdVRt6At9vx1owfg15m6hC4nCiVxsycjNlJVi11iquBnYdBHJwg
         9rlFDvAYmHE6WHBLw6l77s6aY3Jp1fPihjP6pU+m+pdzzJHalfAqDXWzDYEsbyxkMpfc
         8KRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O+9Ne/QX0Bs3iWrwgum6FPcBqk+/cS+YWhh75mjH/Og=;
        b=pAkbE5VDOiunAUTLCp6imzvFAKhqxC4gZGiBeFso9l+gp5IQmxnY6vHPJfwu9gX3QY
         3vI+yGZ4/gOHScyQIb9vDsVADPOZW2npDLhpMIGneoVn8O5WudABF485bp9gUskDHbfv
         LGyfaqh88tFRvy5wC0ULaeoRqp80zUi9k7tYaDOJcnWKNYKJsVLKg/Re3QiDVLcvO+yU
         4Nq/iGyEMymaNAL9B+lKDSUgehDKQDaFnfOjTiwYAnOc5zFitNfB94ijc+WCIcbbiKuS
         ksiJ09nQXmrcpD+hNRb1Hn043+UnMH5f7LAnZLJL8rHXXnhozAbt8MzcHSXG8jVH0dKF
         shng==
X-Gm-Message-State: AOAM5330hpeTeEXWcQtWdw1XU14BUo2vrLiWraZmHruB9nA6ECfmPiMG
        BlWKYmk3IhivSX546sjzYds=
X-Google-Smtp-Source: ABdhPJwMNbDmfFrjyuuaOGW1KbJwJm/IV46kkmgcaDaaBs6CAvjUE5x8Y5RpC0l5mAoyv+ihQQHCIg==
X-Received: by 2002:adf:ea08:: with SMTP id q8mr6556959wrm.297.1626365262867;
        Thu, 15 Jul 2021 09:07:42 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id k13sm7446952wrp.34.2021.07.15.09.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:07:42 -0700 (PDT)
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
Subject: [PATCH 13/20] perf script: fix memory leaks in perf_script
Date:   Thu, 15 Jul 2021 18:07:18 +0200
Message-Id: <5ee73b19791c6fa9d24c4d57f4ac1a23609400d7.1626343282.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626343282.git.rickyman7@gmail.com>
References: <cover.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ASan reports several memory leaks while running the perf test
"82: Use vfs_getname probe to get syscall args filenames".
Two of these are caused by some refcounts not being decreased on
perf-script exit, namely script.threads and script.cpus.

This patch adds the missing __put calls in a new perf_script__exit
function, which is called at the end of cmd_script.

This patch concludes the fixes of all remaining memory leaks in perf
test "82: Use vfs_getname probe to get syscall args filenames".

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/builtin-script.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index bae0e5b72c0e6050..064da7f3618d39d8 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2601,6 +2601,12 @@ static void perf_script__exit_per_event_dump_stats(struct perf_script *script)
 	}
 }
 
+static void perf_script__exit(struct perf_script *script)
+{
+	perf_thread_map__put(script->threads);
+	perf_cpu_map__put(script->cpus);
+}
+
 static int __cmd_script(struct perf_script *script)
 {
 	int ret;
@@ -4146,6 +4152,7 @@ int cmd_script(int argc, const char **argv)
 	zstd_fini(&(session->zstd_data));
 	evlist__free_stats(session->evlist);
 	perf_session__delete(session);
+	perf_script__exit(&script);
 
 	if (script_started)
 		cleanup_scripting();
-- 
2.31.1

