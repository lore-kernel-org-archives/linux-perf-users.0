Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549DAC433E9
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Feb 2021 10:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1730F64EF0
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Feb 2021 10:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhBZKFt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Feb 2021 05:05:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:60330 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230492AbhBZKD5 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Feb 2021 05:03:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4C4A8AF33;
        Fri, 26 Feb 2021 10:03:15 +0000 (UTC)
Subject: [PATCH] perf config: add annotate.demangle{,_kernel}
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <deb2af9e-25dd-ac72-29f4-ab90c2b24237@suse.cz>
 <YDVcZJscuKIgShsm@kernel.org>
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Message-ID: <a4e687b9-f611-1b24-ae7c-2ecd93c42ea8@suse.cz>
Date:   Fri, 26 Feb 2021 11:03:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YDVcZJscuKIgShsm@kernel.org>
Content-Type: multipart/mixed;
 boundary="------------48B04AB51E95A819F275710C"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This is a multi-part message in MIME format.
--------------48B04AB51E95A819F275710C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/21 8:49 PM, Arnaldo Carvalho de Melo wrote:
> Please consider making this configurable (if not already) via
> ~/.perfconfig, 'perf config', sure in a followup patch.

I'm doing that in the following patch.

Thanks,
Martin

--------------48B04AB51E95A819F275710C
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-perf-config-add-annotate.demangle-_kernel.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="0001-perf-config-add-annotate.demangle-_kernel.patch"

From 797fcd73a3ecdabdf40ae054c1d4c2530fcf8203 Mon Sep 17 00:00:00 2001
From: Martin Liska <mliska@suse.cz>
Date: Fri, 26 Feb 2021 11:01:24 +0100
Subject: [PATCH] perf config: add annotate.demangle{,_kernel}
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Martin Liška <mliska@suse.cz>
---
 tools/perf/Documentation/perf-config.txt | 6 ++++++
 tools/perf/util/annotate.c               | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 153bde14bbe0..154a1ced72b2 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -393,6 +393,12 @@ annotate.*::
 
 		This option works with tui, stdio2 browsers.
 
+	annotate.demangle::
+		Demangle symbol names to human readable form. Default is 'true'.
+
+	annotate.demangle_kernel::
+		Demangle kernel symbol names to human readable form. Default is 'true'.
+
 hist.*::
 	hist.percentage::
 		This option control the way to calculate overhead of filtered entries -
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 80542012ec1b..6e9db717c3d8 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3142,6 +3142,10 @@ static int annotation__config(const char *var, const char *value, void *data)
 		opt->use_offset = perf_config_bool("use_offset", value);
 	} else if (!strcmp(var, "annotate.disassembler_style")) {
 		opt->disassembler_style = value;
+	} else if (!strcmp(var, "annotate.demangle")) {
+		symbol_conf.demangle = perf_config_bool("demangle", value);
+	} else if (!strcmp(var, "annotate.demangle_kernel")) {
+		symbol_conf.demangle = perf_config_bool("demangle_kernel", value);
 	} else {
 		pr_debug("%s variable unknown, ignoring...", var);
 	}
-- 
2.30.1


--------------48B04AB51E95A819F275710C--
