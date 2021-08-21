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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22572C4338F
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02FAD61156
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbhHUJUf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhHUJUc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:20:32 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648ABC061575;
        Sat, 21 Aug 2021 02:19:53 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id dj8so17662535edb.2;
        Sat, 21 Aug 2021 02:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N+nB96fRRhC53bAnF/MrlsVfe1VX/CDYmRy1kac/YlM=;
        b=UeWjhOKTJ6BHy7tzxslYFw7fz+/yWLcuxUdQmQimsGL+iLQ3RVtyUdWpUmXVZ9gt+s
         2QYwCffKwklia9A73rJMbGdpvH/gImOT3KNGnuVQ1VozjMdXrzVGH1/2DpNhf+VGeoju
         XeFWkjXjvud6NqzjKlHa4OiS3oCYbjTPLWm5MXbfDuxV2oTT4O2sNcvLjBcoy3CmY1uX
         +bYnvjwJkZf5/O3H8XA4avMZ9tjlOO3cI/awoviknHU8/KYlr1AlJJqO7QCWslzTrJyB
         5fT9ueXPCwSgr4knh/t+dLdnISxSwDnsVnhB3neq+hXd0OgZFfCeGJ2d1+L/BoJVO+iV
         6pQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N+nB96fRRhC53bAnF/MrlsVfe1VX/CDYmRy1kac/YlM=;
        b=CKJmyCAFlOUqdE53+eUxuXncCokX68KLFAyUYfu2eiZEd5bK9G/kaXZfJPb5sObvCj
         cCYgEq7hcIjxXMMWGZP4QU4mTjB+grgwrF7an4gfI07iSQ/iA2E5ZxPrwQkuHHLmVGU0
         8iAr+tYJf1lLI0NAfDwaG9E0+RqROx5GKFsVcLLe0OhVWOVtjh4fulcZKAQvGKVpr4bn
         rf+ceTdY+9VcE3qdgJ1ccknUpv6SWkEFfrM9Lg6wQnR/gXjLqfm/F0cHHBlrhMjScrwl
         3nhiPPi+oVxYMJQuxr37xCm820UNv/E9ADg4RsZbnXGxOVuWaxac3qE4wUz7qR7CuRea
         aY1w==
X-Gm-Message-State: AOAM533ZLzv7IoyT38Ov82Iq/U27k4ASQxxlgFuampheiYUV3vmFM3bR
        /mPQAkIoEhwL/vrtSeKmIY0=
X-Google-Smtp-Source: ABdhPJxp2/wUJQzfbLz6rIo+2jvkaIAe6L9SpBwIrcWcrvhvRFPIylffTp+VR6GlhdvMSGxjllpihw==
X-Received: by 2002:a05:6402:7ce:: with SMTP id u14mr26542422edy.61.1629537591966;
        Sat, 21 Aug 2021 02:19:51 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:19:51 -0700 (PDT)
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
Subject: [RFC PATCH v1 04/37] perf util: add mmap_cpu_mask__duplicate function
Date:   Sat, 21 Aug 2021 11:19:10 +0200
Message-Id: <8943a548ef7a3dd3e015095afad7e9a8b2154c05.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch adds a new function in util/mmap.c to duplicate a mmap_cpu_mask.

This new function will be used in the following patches.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/mmap.c | 12 ++++++++++++
 tools/perf/util/mmap.h |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index ab7108d22428b527..9e9a447682cc962c 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -350,3 +350,15 @@ int perf_mmap__push(struct mmap *md, void *to,
 out:
 	return rc;
 }
+
+int mmap_cpu_mask__duplicate(struct mmap_cpu_mask *original,
+				struct mmap_cpu_mask *clone)
+{
+	clone->nbits = original->nbits;
+	clone->bits = bitmap_alloc(original->nbits);
+	if (!clone->bits)
+		return -ENOMEM;
+
+	memcpy(clone->bits, original->bits, MMAP_CPU_MASK_BYTES(original));
+	return 0;
+}
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 9d5f589f02ae70e1..b4923e587fd7749c 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -63,4 +63,7 @@ size_t mmap__mmap_len(struct mmap *map);
 
 void mmap_cpu_mask__scnprintf(struct mmap_cpu_mask *mask, const char *tag);
 
+int mmap_cpu_mask__duplicate(struct mmap_cpu_mask *original,
+				struct mmap_cpu_mask *clone);
+
 #endif /*__PERF_MMAP_H */
-- 
2.31.1

