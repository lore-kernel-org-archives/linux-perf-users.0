Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0738AC6FA99
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Mar 2023 11:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjCJLKg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Mar 2023 06:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjCJLKc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Mar 2023 06:10:32 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08746101F10
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Mar 2023 03:10:26 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id s22so6095074lfi.9
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Mar 2023 03:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678446624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=soA2EB2gGXQTxlX+KWlwiR2YYPni6SS/X+kqgU7F+Vk=;
        b=ZJv6+g5ubjUa9ngUDDRRXMDFEe2SmmfFu5M2bsFwtTo41JFa5EB5ZcCodmVAM+ZjeP
         K78kjewNVZny1wsivYpBndCcww2MSI+g+XNMKBhEfEafN/rIV5qC6bUGo1A2/s/J+z9w
         OwiuLncx+1cP8GUsHIbU++NZV2V0ypgmIH6kFgx5I8VOa1qJc+zYjzyLJm/8wbli37an
         xdMtNCJSu/lhcBsynR7InvomkAWj2N+9/yT8of2XqYKCS4BuUWjqkTQd0Wpg1sLn/SIK
         zcFJMQAlo/rs6e7Xbm8S9zcK6GbNApy34OIrMxDfPoEVvvF4QllRWbwekbLGMJY5+OkG
         ECdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678446624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=soA2EB2gGXQTxlX+KWlwiR2YYPni6SS/X+kqgU7F+Vk=;
        b=r6TwSj5JkO5Sbpd6zPf4zTaIj+00W++ZxSAq/UKfDE93Sc1P5g4quelmrjX14kONeW
         93csPnm8DyYJEGDN4VDBjXmybJQKX2ojxyFVp4XKR48uH4glZJZtTVXtcFNdtfV8YPfu
         5bsJivdin3kLTTlkkg4ydyXRJB5cGUIf6pM1iXCmSkWBA1zqAyA8hTBQ8tJI4EjFfPBk
         W7X7OnDKS/mRhmL+pgjxbZeX8P1WyXcZt4hCKAXd/vMza8s0XM4fTb7idPPG7bteCe0L
         K09CMpepvnnxswx4gYMnKMvXhTenAo4LBcm10VWPFYQdfkj2KZlNRDbFFssmlepvfrKb
         Z7jg==
X-Gm-Message-State: AO0yUKWInBV9JjaciRwIPidOfpB3nSbqzq1O+Jmw1dUO3e/WmUhkTV+A
        HLeHpJkXJutaqv0CvggdRe41YsXms725A+ZD
X-Google-Smtp-Source: AK7set9mw8cQ6cfL2BpFCvox9XutRwEDvcHEkIG4H81JrAPxLBBX6bWrBxNUvUIs/Io3WciUojVt9Q==
X-Received: by 2002:a05:6512:516:b0:4cc:96f8:f9c6 with SMTP id o22-20020a056512051600b004cc96f8f9c6mr7224573lfb.5.1678446624129;
        Fri, 10 Mar 2023 03:10:24 -0800 (PST)
Received: from vm-ubuntu18-template.pine.ly ([95.143.1.11])
        by smtp.gmail.com with ESMTPSA id l24-20020a2e5718000000b00295a96a0f6csm195689ljb.102.2023.03.10.03.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 03:10:23 -0800 (PST)
From:   Roman Lozko <lozko.roma@gmail.com>
To:     adrian.hunter@intel.com
Cc:     linux-perf-users@vger.kernel.org,
        Roman Lozko <lozko.roma@gmail.com>
Subject: [PATCH] fix IPC output in perf intel-pt-events script
Date:   Fri, 10 Mar 2023 11:10:01 +0000
Message-Id: <20230310111001.2836295-1-lozko.roma@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Integers are not converted to floats during division in Python 2
which results in incorrect IPC values, convert to float explicitly.

Signed-off-by: Roman Lozko <lozko.roma@gmail.com>
---
 tools/perf/scripts/python/intel-pt-events.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/intel-pt-events.py b/tools/perf/scripts/python/intel-pt-events.py
index 08862a2582f4..26e840e17062 100644
--- a/tools/perf/scripts/python/intel-pt-events.py
+++ b/tools/perf/scripts/python/intel-pt-events.py
@@ -269,7 +269,7 @@ def print_common_ip(param_dict, sample, symbol, dso):
 	if "cyc_cnt" in sample:
 		cyc_cnt = sample["cyc_cnt"]
 		insn_cnt = get_optional_zero(sample, "insn_cnt")
-		ipc_str = "  IPC: %#.2f (%u/%u)" % (insn_cnt / cyc_cnt, insn_cnt, cyc_cnt)
+		ipc_str = "  IPC: %#.2f (%u/%u)" % (float(insn_cnt) / cyc_cnt, insn_cnt, cyc_cnt)
 	else:
 		ipc_str = ""
 	if glb_insn and glb_disassembler is not None:
-- 
2.25.1

