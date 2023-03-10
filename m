Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665A9C74A44
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Mar 2023 15:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjCJPPR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Mar 2023 10:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjCJPO0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Mar 2023 10:14:26 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37E89E669
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Mar 2023 07:05:44 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id d36so6971606lfv.8
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Mar 2023 07:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678460688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=is74G5uiKrEOAJxt5kh88ZCB7lCqzlxjh/MQZMnOXhk=;
        b=CGrYnPXkY1v5UvyfGbSZXylsEXy4ta4vD1g/DPdo/7ocbF+kR47dkzoh3zatfWXoFA
         eqNNL1TuHEKWLprCbXPZ16hxjOG+DEkkQFOV2e9e6S1PcV1dUTy47knJn9aC5+7/S2Gx
         O7lredl/PDHdF1m+3vXhN+e5RpvAd49RID09G1HGoG86LLviF+wsyHAh9cdw9BvdLIH7
         fAWH51FpVw9WACSma6Imf/9F8LztZaVQSYw4zxH5o9YdmXLWPRge6Ra7vadhGp4Ix9MN
         JFodZC1NeGEpZSQG40Vbf2f4T/JiT3xw3GPXfUBqqEE4uld10/Mly5EwhPbxj+WcaXvD
         BFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678460688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=is74G5uiKrEOAJxt5kh88ZCB7lCqzlxjh/MQZMnOXhk=;
        b=wt3ju6TWs+mhhRAl4qAbL+ZuNfRPpUF9+kQXgrVbUgYfUAVHpuk3AicmM7dKLVYMH/
         OFNjHT4/99w0NsZsxcg1QzRrwLy55fMOsMRv1xkNnGy9jR/OC59XuatDizMS1F1ThLUL
         xvVCR19pEZ3EygQMQMXgm/mb6s+B8ZHHbkfe1SVjNc1Agzp6lyhEgaUuumjWPfJ1zbDb
         YToOKVYmirIjl/OkHt8IrHugABNfVscHSScu/D35A3LOXTuc8phHMiIC74C6uCw9d5gF
         Ck2xShRfxIT/DZPK90e0hxwi/u0CqFLYJoNdjVNLqjok+sIT26AsU3l0KhjlFoIBxTB9
         fL7A==
X-Gm-Message-State: AO0yUKXBn10iWqK6sNFN5xD7GRKzf53QWNc3NdDAYGS4Varf5gltq5kE
        Xgkm5OCiJYdHSDql3m8kkFs21i6fhzRQ9uOW
X-Google-Smtp-Source: AK7set8nsYOIx0tqeauNrUqm2K0xnwWDk3Y7mfUScvsxOzo/qkn+SIOc/khbQLYACPeH2UPXvYYhTQ==
X-Received: by 2002:ac2:559a:0:b0:4dc:53d8:58bb with SMTP id v26-20020ac2559a000000b004dc53d858bbmr6696878lfg.52.1678460688058;
        Fri, 10 Mar 2023 07:04:48 -0800 (PST)
Received: from vm-ubuntu18-template.pine.ly ([95.143.1.11])
        by smtp.gmail.com with ESMTPSA id z2-20020a2e9b82000000b00295b80aa93csm32545lji.110.2023.03.10.07.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 07:04:47 -0800 (PST)
From:   Roman Lozko <lozko.roma@gmail.com>
To:     adrian.hunter@intel.com
Cc:     linux-perf-users@vger.kernel.org,
        Roman Lozko <lozko.roma@gmail.com>
Subject: [PATCH v2] perf scripts: intel-pt-events.py: Fix IPC output for Python 2
Date:   Fri, 10 Mar 2023 15:04:45 +0000
Message-Id: <20230310150445.2925841-1-lozko.roma@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <01f16399-f600-2b45-766f-0b5e5f868345@intel.com>
References: <01f16399-f600-2b45-766f-0b5e5f868345@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Integers are not converted to floats during division in Python 2
which results in incorrect IPC values. Fix by switching to new division
behavior.
Fixes: a483e64c0b62 ("perf scripting python: intel-pt-events.py: Add --insn-trace and --src-trace")
Signed-off-by: Roman Lozko <lozko.roma@gmail.com>
---
 tools/perf/scripts/python/intel-pt-events.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/intel-pt-events.py b/tools/perf/scripts/python/intel-pt-events.py
index 08862a2582f4..1c76368f13c1 100644
--- a/tools/perf/scripts/python/intel-pt-events.py
+++ b/tools/perf/scripts/python/intel-pt-events.py
@@ -11,7 +11,7 @@
 # FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 # more details.
 
-from __future__ import print_function
+from __future__ import division, print_function
 
 import io
 import os
-- 
2.25.1

