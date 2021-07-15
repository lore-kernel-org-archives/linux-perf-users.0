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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FFCC07E96
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0116A613F1
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbhGOQKn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbhGOQKi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 12:10:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1DAC061762;
        Thu, 15 Jul 2021 09:07:45 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o30-20020a05600c511eb029022e0571d1a0so3987444wms.5;
        Thu, 15 Jul 2021 09:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A5GRbt29qAoVm0D0wGwcK31dyKDJYpMUl424OWXmdYE=;
        b=iL0Bbc2SAIlZEQdZI2a+opJ5YvSGOtTb8e//MvldIdVMgb89YwDd61ami5qZgClM5S
         pqrOTauaTyhOfU3GHgTi3iV90S5OzQNAFea0aYPlV5+XZEaxwiMnq7bU6iU23x4JKLhP
         ox9LrmLWrRVo2yOnj73oc0jtgE3WC0LLvQaWbs9m8vm0IEQDl2SMMlOwTU3I9D+m/Yat
         lFdsX66QWohwnZChiGnGQcorVKfPXBCtrXptZJlbHveAIstB/W6uC17rD2bUULHNpfxA
         CpiQpe74Nrfm0wKzBDjh7rRpDgCC7oAs1xKs2U25UZ1FP0FjvGmLQbVbKx7A3DrZvsD8
         NCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A5GRbt29qAoVm0D0wGwcK31dyKDJYpMUl424OWXmdYE=;
        b=jax9LAseahwBE6ps4JtssCoS8SSDI/SrUNa559GR9gc2H/5v4TtWGw6iXeYEWV8ywn
         E7K6Z9Moe8BAcit336017wKD+4Sp2k8wcqdf1aF11p2+irgGBA6ZkbyQ0ndQ4n/QhZdD
         KM7ILZn3kXeni1cnb21baad5BRZjnWSsENbiGs+DT/2XoNDJFEgY2606OMrNtrLw7W79
         X1Ya1wvWXRwuk98BSrkzQBGQ4xMpTKuO/KDF2auA0A4MnduzKfUzpUoZAri3KXbrYi10
         iXYLJ7ux2eZcyOKI3yPbw1GOzG3CMWu9rNxGAXUyn0zgsWpwkTWBAM+m+NxExWXqwjBO
         JJxw==
X-Gm-Message-State: AOAM532H3L8jlVxr77sIY/g4pV17MHCpwINO6Y2x3CJQ94zt93l++s2d
        /u7wVDSXna7exg6P3f7YoK+oSNbJkMiGWJvdO58=
X-Google-Smtp-Source: ABdhPJy+1Y4Mo6bnwwZC+r3s0DHrVGsINtFenFTGlan1RZvEO/zNg+CrRWFjdgstPhd+idfAovtBdw==
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr5420715wmk.146.1626365263876;
        Thu, 15 Jul 2021 09:07:43 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id k13sm7446952wrp.34.2021.07.15.09.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:07:43 -0700 (PDT)
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
Subject: [PATCH 14/20] perf util/lzma: close lzma stream
Date:   Thu, 15 Jul 2021 18:07:19 +0200
Message-Id: <aaf50bdce7afe996cfc06e1bbb36e4a2a9b9db93.1626343282.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626343282.git.rickyman7@gmail.com>
References: <cover.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ASan reports memory leaks when running the perf test
"88: Check open filename arg using perf trace + vfs_getname".
One of these is caused by the lzma stream never being closed inside
lzma_decompress_to_file.

This patch adds the missing lzma_end.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/lzma.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/lzma.c b/tools/perf/util/lzma.c
index 39062df0262915bd..51424cdc3b682c64 100644
--- a/tools/perf/util/lzma.c
+++ b/tools/perf/util/lzma.c
@@ -69,7 +69,7 @@ int lzma_decompress_to_file(const char *input, int output_fd)
 
 			if (ferror(infile)) {
 				pr_err("lzma: read error: %s\n", strerror(errno));
-				goto err_fclose;
+				goto err_lzma_end;
 			}
 
 			if (feof(infile))
@@ -83,7 +83,7 @@ int lzma_decompress_to_file(const char *input, int output_fd)
 
 			if (writen(output_fd, buf_out, write_size) != write_size) {
 				pr_err("lzma: write error: %s\n", strerror(errno));
-				goto err_fclose;
+				goto err_lzma_end;
 			}
 
 			strm.next_out  = buf_out;
@@ -95,11 +95,13 @@ int lzma_decompress_to_file(const char *input, int output_fd)
 				break;
 
 			pr_err("lzma: failed %s\n", lzma_strerror(ret));
-			goto err_fclose;
+			goto err_lzma_end;
 		}
 	}
 
 	err = 0;
+err_lzma_end:
+	lzma_end(&strm);
 err_fclose:
 	fclose(infile);
 	return err;
-- 
2.31.1

