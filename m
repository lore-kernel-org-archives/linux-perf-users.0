Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433BCC11F6B
	for <linux-perf-users@archiver.kernel.org>; Fri,  2 Jul 2021 04:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2453F61422
	for <linux-perf-users@archiver.kernel.org>; Fri,  2 Jul 2021 04:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhGBEMi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 2 Jul 2021 00:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbhGBEMe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 2 Jul 2021 00:12:34 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E43C061762;
        Thu,  1 Jul 2021 21:10:02 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id j24so7845191pfi.12;
        Thu, 01 Jul 2021 21:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Avhze0JY3EGyG+atvGonsZuB3bCR0nJRnR7q8SaTvw4=;
        b=hhcOw27iixZCfqWzudCtsmYm5jJ06SWUuGjsV4TKVwPF20w3NfITlsMoHDPxgz//66
         65TTHdQewGL5Z/wJkwqfL6M5yzk6UGdiQkxAUdtR05tGSo222Zseslx2DEW6V+zm66xZ
         StxXW+lGrBkvTAL/dA/yr/eMKHIHhOsmyJ8nRxEErtVXfTHie8kM4UmfchDyOqj8l9j0
         lH9edcupGDTaFYNWBhth9eTJYxDv2J9H+WAXcr8je58zPlOh01A9GmCgHaPKWx2FZfa/
         Dw0y+q2gz2TubS7+Nbj0gEsC8PRYcURWQMSFYOhQLc10D4w8VH1TtHeAdj57wa3dc6MG
         aIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Avhze0JY3EGyG+atvGonsZuB3bCR0nJRnR7q8SaTvw4=;
        b=agtQTD17YnLTpO8DDF4F3DXIgq+/sNzHBDQfghsVs5rytMckp/V/fIefOkqwZwvKfn
         LyUpXibvjSJsKLP0ut9AU8lx574ry/aANS70U0Hk9H0U2/zHxm+dX9TPRx6jciBsw0zY
         0HerOi/mJUay+V9jvSgjuo4cr3lthrv1WckK2DZDE9ds/dFAqTIO1n49/azlvVAOHI1H
         jqN76FZcBiXLNq0oP4/1jyacjdM6mm8/FL6WjKpjFg8ltxtInNeXUGvrlaWjqbH1nN3t
         nhGue8j1VDGKMeIrlUFZh3ixGxQuqf8zyQOzstSXXSj6wqGKxiykgp06F27mwIyDgcwS
         uBOQ==
X-Gm-Message-State: AOAM532/Wn0uz/e9F2VGs31YYgY6nDmN9fC3ivy1ZKlXcYUrJsdY+Kxt
        Zqm2DfQT4rXg1z5hrsRlSOE=
X-Google-Smtp-Source: ABdhPJzvuIXVfByf5ziQV4tnLKfeHAnWE5LpBjywZL0Jvsg+uOJlURh+fYq5ZVd9osKhBuKX1ESu9w==
X-Received: by 2002:a63:1226:: with SMTP id h38mr3075223pgl.376.1625199002287;
        Thu, 01 Jul 2021 21:10:02 -0700 (PDT)
Received: from ubuntu.localdomain ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id y3sm1634732pga.72.2021.07.01.21.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 21:10:01 -0700 (PDT)
From:   gushengxian <gushengxian507419@gmail.com>
To:     will@kernel.org, mathieu.poirier@linaro.org, leo.yan@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>
Subject: [PATCH] perf: tests: fix some mmemory leak issues
Date:   Thu,  1 Jul 2021 21:09:55 -0700
Message-Id: <20210702040955.631618-1-gushengxian507419@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

Some memory leak issues should be fixed by free().
Reported by cppcheck.

Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 tools/perf/arch/arm/tests/dwarf-unwind.c     | 1 +
 tools/perf/arch/arm64/tests/dwarf-unwind.c   | 1 +
 tools/perf/arch/powerpc/tests/dwarf-unwind.c | 1 +
 tools/perf/arch/x86/tests/dwarf-unwind.c     | 1 +
 4 files changed, 4 insertions(+)

diff --git a/tools/perf/arch/arm/tests/dwarf-unwind.c b/tools/perf/arch/arm/tests/dwarf-unwind.c
index ccfa87055c4a..f2541d1dbb02 100644
--- a/tools/perf/arch/arm/tests/dwarf-unwind.c
+++ b/tools/perf/arch/arm/tests/dwarf-unwind.c
@@ -39,6 +39,7 @@ static int sample_ustack(struct perf_sample *sample,
 	memcpy(buf, (void *) sp, stack_size);
 	stack->data = (char *) buf;
 	stack->size = stack_size;
+	free(buf);
 	return 0;
 }
 
diff --git a/tools/perf/arch/arm64/tests/dwarf-unwind.c b/tools/perf/arch/arm64/tests/dwarf-unwind.c
index 46147a483049..ecd25c77a71f 100644
--- a/tools/perf/arch/arm64/tests/dwarf-unwind.c
+++ b/tools/perf/arch/arm64/tests/dwarf-unwind.c
@@ -39,6 +39,7 @@ static int sample_ustack(struct perf_sample *sample,
 	memcpy(buf, (void *) sp, stack_size);
 	stack->data = (char *) buf;
 	stack->size = stack_size;
+	free(buf);
 	return 0;
 }
 
diff --git a/tools/perf/arch/powerpc/tests/dwarf-unwind.c b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
index 8efd9ed9e9db..e57a8ca52ce7 100644
--- a/tools/perf/arch/powerpc/tests/dwarf-unwind.c
+++ b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
@@ -40,6 +40,7 @@ static int sample_ustack(struct perf_sample *sample,
 	memcpy(buf, (void *) sp, stack_size);
 	stack->data = (char *) buf;
 	stack->size = stack_size;
+	free(buf);
 	return 0;
 }
 
diff --git a/tools/perf/arch/x86/tests/dwarf-unwind.c b/tools/perf/arch/x86/tests/dwarf-unwind.c
index 478078fb0f22..da90b33a1e28 100644
--- a/tools/perf/arch/x86/tests/dwarf-unwind.c
+++ b/tools/perf/arch/x86/tests/dwarf-unwind.c
@@ -47,6 +47,7 @@ static int sample_ustack(struct perf_sample *sample,
 #endif
 	stack->data = (char *) buf;
 	stack->size = stack_size;
+	free(buf);
 	return 0;
 }
 
-- 
2.25.1

