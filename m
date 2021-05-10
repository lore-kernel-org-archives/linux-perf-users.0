Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4990DC433B4
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 May 2021 22:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CDE761584
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 May 2021 22:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhEJWt7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 May 2021 18:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhEJWt6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 May 2021 18:49:58 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6CFC061574;
        Mon, 10 May 2021 15:48:53 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id w16so9122838oiv.3;
        Mon, 10 May 2021 15:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=thkJMcHHCAsqSjz7YO21xca2V6P/GtzMpLV1d3GmO28=;
        b=XecudtZNS9l0gNol4eKQ+Tsjg7dc0GPdo+UethNr0pFPa7y5ZdQOj5eiI+mKfaJcLI
         ilaLl38/dABmMK39SIudBop6Vzac8sSgKULiX6dNIbiFuys7KBr5OeaJtv8vjpMLFo1G
         +bIR5MxK1ohzS7qaHYc6PFow1PcXgsPbRXTgGDkgOHXLyqYoVwg20FxjClmQ8p+34CQZ
         Q2m/eWJrtp9nPSTLU70wN6yVdCYlXaQs8CFIq7goGzewd7SSKJmIJlbgJ5SOwRthJBLj
         9T11VVZ4xDvVLU9luiXiRSR8RuBU95WSCH3z0eMbFrt2AB4gJ6+3NKEs3s2cdvxKV2ym
         REFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=thkJMcHHCAsqSjz7YO21xca2V6P/GtzMpLV1d3GmO28=;
        b=nvSJvEVqfSpEOQUTjGNZZF0nDPksZFAzqZwRImw6OcV3hYEw7PUpc+fcptgHXk+gH8
         sn5DShjvcAfq+M4tdT6vl7fABLF7wl7m3EyZAXRpIw6ufdpEYKOOS7OKvMgcISn5Pipp
         YnN9uaKE1rZOl9HuZGqGHbIJ36xNfPjiVYh2gpP6XOwvnhhZ3qCocAm7flefcUpHUVOJ
         izLHKYqYaYhYGuLYdcgLnZ5H7v+biaG6kuq3MF2aRd5F78KKeMicpDqyFfc4TO/5i3D8
         ousw4kUZG5TpvIe0j6ltK9/lzmmZCvUulVKKvvTU4BOccROQtfAF6NL0CzEZyMPkR118
         KyOg==
X-Gm-Message-State: AOAM531wIPqr282Qmr+m1W+UnZHGYHOVFgvQku9qUpTXYkQstdZvweXN
        ARq3XrI0+3v+31Hz91Pri4JOr1u/b+8=
X-Google-Smtp-Source: ABdhPJzGaxX2Iye6HNTpB84/l4XA/WdIDFo/cfwTkls+ovcIptaW113puwjubW2NXMR6QXHc/TTHvw==
X-Received: by 2002:aca:d44d:: with SMTP id l74mr16413301oig.57.1620686933162;
        Mon, 10 May 2021 15:48:53 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h20sm2574605oie.33.2021.05.10.15.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 15:48:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] perf/x86/intel/uncore: Drop unnecessary NULL checks after container_of
Date:   Mon, 10 May 2021 15:48:49 -0700
Message-Id: <20210510224849.2349861-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The parameter passed to pmu_enable and pmu_disable functions can not be
NULL because it is dereferenced by the caller. That means the result of
container_of() on that parameter can also never be NULL. The existing
NULL checks are therefore unnecessary and misleading. Remove them.

This change was made automatically with the following Coccinelle script.

@@
type t;
identifier v;
statement s;
@@

<+...
(
  t v = container_of(...);
|
  v = container_of(...);
)
  ...
  when != v
- if (\( !v \| v == NULL \) ) s
...+>

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/x86/events/intel/uncore.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index df7b07d7fdcb..9bf4dbbc26e2 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -801,8 +801,6 @@ static void uncore_pmu_enable(struct pmu *pmu)
 	struct intel_uncore_box *box;
 
 	uncore_pmu = container_of(pmu, struct intel_uncore_pmu, pmu);
-	if (!uncore_pmu)
-		return;
 
 	box = uncore_pmu_to_box(uncore_pmu, smp_processor_id());
 	if (!box)
@@ -818,8 +816,6 @@ static void uncore_pmu_disable(struct pmu *pmu)
 	struct intel_uncore_box *box;
 
 	uncore_pmu = container_of(pmu, struct intel_uncore_pmu, pmu);
-	if (!uncore_pmu)
-		return;
 
 	box = uncore_pmu_to_box(uncore_pmu, smp_processor_id());
 	if (!box)
-- 
2.25.1

