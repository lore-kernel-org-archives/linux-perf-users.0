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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0993FC4320A
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5CF061156
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbhHUJUg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbhHUJUe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:20:34 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A136C061575;
        Sat, 21 Aug 2021 02:19:55 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id s25so4932649edw.0;
        Sat, 21 Aug 2021 02:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ztxai8Rgcye1ZeVdGSiAJDplMB1xLc+6qAy/h0sNGyQ=;
        b=ry5UiqSSViLUEQhMPbeM21Qc07fR3RQphsgTnszjsYqIV8K8CHVbWMCmRAed5yqJIC
         R8QCFtOvUeuMDhaUeL5NbpnKQ1GbJ9Yn9IWnm77rw/+4zoUegax9qCvCwTISmjwQrf+8
         BC0QyYoqKNjE7YBoMPKBf2w8hlLJvZXJIqc5zG5Kgf/9INffANI5klEzpR/BdUMZfNpR
         fWvU7qzSdnRQ7JIjCukRzKYjpaLr/EF5Y076ZjJpp+LuZv3K60dvFBjO+QJxkqYTo9Wr
         Wmwh2ndTpwoDjPeS4LZguWSzvilEm9n7Cj++Lav4Gw25HAxkA+wIiC3Xq2TxbM7P+9B7
         7W+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ztxai8Rgcye1ZeVdGSiAJDplMB1xLc+6qAy/h0sNGyQ=;
        b=cThlETs7AiyBvu/Yut0v2pf+kjtG3CinaXIG6bOHIYqPGLzZcJvyeNmy3vnFzW/kFH
         MrYazrEdRZOq+ZjcM1xSkUflAoYZlgjCqSGFyheFHSoLDWDpvlH2HsK0Vw2pweKxc2gj
         1O0EnuE+6TyVPjzJt5vZQ4e2a5nuTuU2uhmyfP8iyefyGXxpTXjwytVgw78duKlDKTTu
         WXdw5ww+nv4R1j0ma/faucW0oywg3eCjKelVWz3UptP7VBp7of+TNZOY0hGGs8mQDJ9J
         neflLmX0SK1doXV/QFZNZ2dR1Xr1693gAeKHdPnY1eYaV1DwDNE0YMph1bTzRfAB6RkT
         lI8g==
X-Gm-Message-State: AOAM533KIBOaGQIc3OiOTMHb2erQKBJXPxbq1MyP0O1HPoWkW4LiyGzn
        z4wHyIJJTxt/XV/OUn3RKlE=
X-Google-Smtp-Source: ABdhPJy9UE3YTgazmcyHnwa2Vj5VYh2+1ThgjYgmGDAk1K9iCbZc1ZpR9/3NBra+XcGOcl2CTc4Cpw==
X-Received: by 2002:a05:6402:220f:: with SMTP id cq15mr5376364edb.142.1629537593755;
        Sat, 21 Aug 2021 02:19:53 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:19:53 -0700 (PDT)
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
Subject: [RFC PATCH v1 05/37] perf util/mmap: add missing bitops.h header
Date:   Sat, 21 Aug 2021 11:19:11 +0200
Message-Id: <c5b91ee432a2e28e7f16337c740b43b4d0b0e86c.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

MMAP_CPU_MASK_BYTES uses the BITS_TO_LONGS macro, which is defined in
linux/bitops.h.
However, this header is not included directly, but gets imported
indirectly in files using the macro.
This patch adds the missing include.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/mmap.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index b4923e587fd7749c..8e259b9610f83c96 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -6,6 +6,7 @@
 #include <linux/refcount.h>
 #include <linux/types.h>
 #include <linux/ring_buffer.h>
+#include <linux/bitops.h>
 #include <stdbool.h>
 #include <pthread.h> // for cpu_set_t
 #ifdef HAVE_AIO_SUPPORT
-- 
2.31.1

