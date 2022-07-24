Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6087C43334
	for <linux-perf-users@archiver.kernel.org>; Sun, 24 Jul 2022 02:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbiGXC3Z (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 23 Jul 2022 22:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbiGXC3Y (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 23 Jul 2022 22:29:24 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94A217592
        for <linux-perf-users@vger.kernel.org>; Sat, 23 Jul 2022 19:29:23 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id b11so14681471eju.10
        for <linux-perf-users@vger.kernel.org>; Sat, 23 Jul 2022 19:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PfMO/BGX2+jJxfN9ahYbmi/+LL8s/bQoBxmXikSDXCk=;
        b=afRW92YaBcZT+SnGG0a9yWoGr0mPAyyhrSY/yxzjFDRcCO0HuWxrgam/ZR2Qozj5uL
         DZ9KCBVwzbe+s+OBey5IG2kwx2/Ma6ltJUK+0N9pYYB9zJB3LCRk2HOTIW2rCtHGUsXy
         0smLXXaZZrjCqM13byw8vWPv8tyE8WbsqcRJDlOSh6CRaolMs4reaXrSd1yV7i+4GnCE
         YNV1ZYm0Scrv8Pqj4HfMfFzkaWdJvpr42sWmGwJSUXHBEkgwJS7ZjtelCeT2y13MJ/rf
         WMdvPhvaTxWtYZeXoy//hmgq7bfZsNSc1ag7xexoFHl7Ty6hxnhBKFR4ZBXnF6LM/6T/
         QB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PfMO/BGX2+jJxfN9ahYbmi/+LL8s/bQoBxmXikSDXCk=;
        b=X54hth+SC536dLcfH+uTQxrjON57y2Y0cjwixxlRUUhLTRGtLYoUPe3Fa2tNT0Ih0L
         mKqrUq6FjSyZLjLn4cosZkqw/FX+VJy17DQMf0SPp8Qwyv994Re7suwHyBJEoo6QzSdd
         iI7O/fdDkxFwR1h94NAjZqYHG9es/4TfHUAUAjehDqdDaSqCPtfawbGBzGNQEhM8ooXW
         qFsOo8ITLS5LLdFNz2kbAOCVRH4L+L1M5k74FRMafWZRiWlknm1WbTV4c/9JU322iVQt
         Ta6rqjHLp9ic+U1OCUvKYAFBuaqUM7cQmAY37g71s7O8IMazh70NJ4TCbuh1uYY6qcxA
         4l1w==
X-Gm-Message-State: AJIora/TKVyY1aSZlsz11C+VGJSElRRRfQHNfJ83GBz41KGCojLmWKWU
        G43UVrkR7tJyovcBP3QPJLOwCw==
X-Google-Smtp-Source: AGRyM1t1qvJDy/VhgGyRy+o0TM8z1YHIOxx+yvx2j34wNXfDx6shWP3Xxbi6F+KsHZfvjhVgk22O9A==
X-Received: by 2002:a17:906:ef8b:b0:72b:45a2:2232 with SMTP id ze11-20020a170906ef8b00b0072b45a22232mr5009261ejb.484.1658629762151;
        Sat, 23 Jul 2022 19:29:22 -0700 (PDT)
Received: from leo-build-box.lan (ec2-18-144-7-244.us-west-1.compute.amazonaws.com. [18.144.7.244])
        by smtp.gmail.com with ESMTPSA id 7-20020a170906318700b0072b31307a79sm3741524ejy.60.2022.07.23.19.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 19:29:21 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Fangrui Song <maskray@google.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 2/2] perf symbol: Skip recording symbols in '.gnu.warning.*' sections
Date:   Sun, 24 Jul 2022 10:28:57 +0800
Message-Id: <20220724022857.2621520-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220724022857.2621520-1-leo.yan@linaro.org>
References: <20220724022857.2621520-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Some symbols are observed their 'st_value' field are zeros.  E.g.
libc.so.6 in Ubuntu contains a symbol '__evoke_link_warning_getwd' which
resides in the '.gnu.warning.getwd' section, unlike normal symbols, this
kind of symbols are only used for linker warning.

This patch skips to record symbols from '.gnu.warning.*' sections by
detecting the sub string '.gnu.warning' is contained in section name.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/symbol-elf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index ef6ced5c5746..4b621e355c0e 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1277,6 +1277,14 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 
 		section_name = elf_sec__name(&shdr, secstrs);
 
+		/*
+		 * A symbol coming from ".gnu.warning.*" sections is used to
+		 * generate linker warnings, its 'sym.st_value' field usually
+		 * is zero, skip to record it.
+		 */
+		if (strstr(section_name, ".gnu.warning"))
+			continue;
+
 		/* On ARM, symbols for thumb functions have 1 added to
 		 * the symbol address as a flag - remove it */
 		if ((ehdr.e_machine == EM_ARM) &&
-- 
2.25.1

