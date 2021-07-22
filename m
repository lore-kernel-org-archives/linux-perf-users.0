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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74306C63797
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Jul 2021 15:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36E326052B
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Jul 2021 15:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhGVOxs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Jul 2021 10:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbhGVOxr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Jul 2021 10:53:47 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A287C061575;
        Thu, 22 Jul 2021 08:34:21 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id p15-20020a05600c358fb0290245467f26a4so3226721wmq.0;
        Thu, 22 Jul 2021 08:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xa7FzpBYUXmISMnIJxzW5ASV3zaOJFb+/T9sK/Wyh4s=;
        b=Bq8DlR8zBiP/nDa3QgvCWT6WN06iZ4Cy3cKi7abkdKshiVIWDsRmCP+HO2jhn350QT
         KimuTjdOoFqwai+veHIjJBQOymFbl+mbsl63vbodmusDgATZD/EhbzbzQ+S0Jpf7Y0gW
         pgQ7xUQRrGe8ZQG8NeqC7xeieJWWxDLqjXH8rUTrv0Y7/klsYL0F+d9b7QjRFz7l9HOf
         x6sfXaw0m4I9WRKY+jmLGEn7r3YOlI+WD84KTs6n8a+CUjrTF2qj3BV3qQ1ueap5KXyA
         VtIWYQ8KTZf2ZwXbhTfQv4WPdqXYf4qW11zHq/wckSJwoG0dC50lrqx3iM8PTcO2gXuq
         NtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xa7FzpBYUXmISMnIJxzW5ASV3zaOJFb+/T9sK/Wyh4s=;
        b=bIvcqnlldkqILk3S8EHEnW8lMeSHd3RAecBXYZi6DavL00LJ/YP8B3t/yC+EsP75Uu
         keumrsb7lpW+oIpPNOsS89auypFdAEEY7QDsCPAGzkje8nNRQH41CE0RkqSmd0479ZsP
         XI6NF+udE3Y0Q8CH3G5pMEQSHKPav+kEy4diAb/AS5J+XUVoUTVKXiZb7noWB6qy7T/o
         zSjG7ynohT7k4NSIS/TyJWqQ4j/Ej71RBI6KzYHtfSqjVEkglIHgZ7jFr2A0NUUipkSz
         qswGWLkwLVc4X6rNMcOpI3Ur2B2dNeSNy3+NdvIzaEXAZf6wFYxFD3Rl9U7yHThPf1RO
         Khjg==
X-Gm-Message-State: AOAM5312ZUMR28WU4dbw/S/4p2csiEgC16Hm+e5iYYIpLDqWnbZSRvH9
        1gW9jYgh1yfhjqvaeENRDK8=
X-Google-Smtp-Source: ABdhPJzgGsqlCoh9wVZfOw277bxAbX6rSaNskXmHIwzWENZIpI4FUNaO+Ytkb4wsgyxGTMNIcJF03A==
X-Received: by 2002:a05:600c:4c11:: with SMTP id d17mr9824591wmp.121.1626968060143;
        Thu, 22 Jul 2021 08:34:20 -0700 (PDT)
Received: from honeypot.. ([185.91.190.155])
        by smtp.googlemail.com with ESMTPSA id o29sm23735557wms.13.2021.07.22.08.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 08:34:19 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH 1/3] tools libc_compat: add gettid
Date:   Thu, 22 Jul 2021 17:34:14 +0200
Message-Id: <309becd325626e04015ad7b5f6fc701e569f918d.1626966805.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626966805.git.rickyman7@gmail.com>
References: <cover.1626966805.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch adds gettid to libc_compat.h, since it was added in glibc
2.30 and is not available in previous versions.
The function is defined only if the HAVE_GETTID is not defined.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/include/tools/libc_compat.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/include/tools/libc_compat.h b/tools/include/tools/libc_compat.h
index e907ba6f15e532b6..58762c9c49c22ef1 100644
--- a/tools/include/tools/libc_compat.h
+++ b/tools/include/tools/libc_compat.h
@@ -17,4 +17,11 @@ static inline void *reallocarray(void *ptr, size_t nmemb, size_t size)
 	return realloc(ptr, bytes);
 }
 #endif
+
+#ifndef HAVE_GETTID
+static inline pid_t gettid(void)
+{
+	return (pid_t)syscall(__NR_gettid);
+}
+#endif
 #endif
-- 
2.31.1

