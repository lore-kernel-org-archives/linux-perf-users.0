Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6AAC433E0
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Feb 2021 10:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C321464F03
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Feb 2021 10:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhBZKKz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Feb 2021 05:10:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:36362 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229990AbhBZKIy (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Feb 2021 05:08:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 95F28ACF6;
        Fri, 26 Feb 2021 10:08:12 +0000 (UTC)
Subject: Re: [PATCH] perf config: add annotate.demangle{,_kernel}
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <deb2af9e-25dd-ac72-29f4-ab90c2b24237@suse.cz>
 <YDVcZJscuKIgShsm@kernel.org> <a4e687b9-f611-1b24-ae7c-2ecd93c42ea8@suse.cz>
Message-ID: <c96aabe7-791f-9503-295f-3147a9d19b60@suse.cz>
Date:   Fri, 26 Feb 2021 11:08:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <a4e687b9-f611-1b24-ae7c-2ecd93c42ea8@suse.cz>
Content-Type: multipart/mixed;
 boundary="------------7ED3ADB86AC31C7AA548F629"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This is a multi-part message in MIME format.
--------------7ED3ADB86AC31C7AA548F629
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/26/21 11:03 AM, Martin Liška wrote:
> On 2/23/21 8:49 PM, Arnaldo Carvalho de Melo wrote:
>> Please consider making this configurable (if not already) via
>> ~/.perfconfig, 'perf config', sure in a followup patch.
> 
> I'm doing that in the following patch.

The patch contained a typo, fixed in the V2.

Martin

> 
> Thanks,
> Martin


--------------7ED3ADB86AC31C7AA548F629
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-perf-config-add-annotate.demangle-_kernel.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="0001-perf-config-add-annotate.demangle-_kernel.patch"

From a29a6d3ae717f19774a430ccf9a63a452376f359 Mon Sep 17 00:00:00 2001
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
index 80542012ec1b..e35d56608986 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3142,6 +3142,10 @@ static int annotation__config(const char *var, const char *value, void *data)
 		opt->use_offset = perf_config_bool("use_offset", value);
 	} else if (!strcmp(var, "annotate.disassembler_style")) {
 		opt->disassembler_style = value;
+	} else if (!strcmp(var, "annotate.demangle")) {
+		symbol_conf.demangle = perf_config_bool("demangle", value);
+	} else if (!strcmp(var, "annotate.demangle_kernel")) {
+		symbol_conf.demangle_kernel = perf_config_bool("demangle_kernel", value);
 	} else {
 		pr_debug("%s variable unknown, ignoring...", var);
 	}
-- 
2.30.1


--------------7ED3ADB86AC31C7AA548F629--
