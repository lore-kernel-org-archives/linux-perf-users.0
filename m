Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA5AC433C1
	for <linux-perf-users@archiver.kernel.org>; Tue, 30 Mar 2021 18:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38F816192C
	for <linux-perf-users@archiver.kernel.org>; Tue, 30 Mar 2021 18:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhC3SyE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 30 Mar 2021 14:54:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:42828 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232901AbhC3Sxj (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 30 Mar 2021 14:53:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4D038B34F;
        Tue, 30 Mar 2021 18:33:56 +0000 (UTC)
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Subject: [PATCH] perf annotate: add --demangle and --demangle-kernel
References: <2327ca98-f2ee-3a9a-0e24-d52fc90bcf9b@suse.cz>
To:     linux-perf-users@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>
Message-ID: <c3c7e959-9f7f-18e2-e795-f604275cbac3@suse.cz>
Date:   Tue, 30 Mar 2021 20:33:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2327ca98-f2ee-3a9a-0e24-d52fc90bcf9b@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Perf annotate supports --symbol but it's impossible to filter
a C++ symbol. With --no-demangle one can filter easily by
mangled function name.

Signed-off-by: Martin Liška <mliska@suse.cz>
---
  tools/perf/Documentation/perf-annotate.txt | 7 +++++++
  tools/perf/builtin-annotate.c              | 4 ++++
  2 files changed, 11 insertions(+)

diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index 1b5042f134a8..80c1be5d566c 100644
--- a/tools/perf/Documentation/perf-annotate.txt
+++ b/tools/perf/Documentation/perf-annotate.txt
@@ -124,6 +124,13 @@ OPTIONS
  --group::
  	Show event group information together
  
+--demangle::
+	Demangle symbol names to human readable form. It's enabled by default,
+	disable with --no-demangle.
+
+--demangle-kernel::
+	Demangle kernel symbol names to human readable form (for C++ kernels).
+
  --percent-type::
  	Set annotation percent type from following choices:
  	  global-period, local-period, global-hits, local-hits
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 0f3a196e5d6e..021d974c978e 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -538,6 +538,10 @@ int cmd_annotate(int argc, const char **argv)
  		    "Strip first N entries of source file path name in programs (with --prefix)"),
  	OPT_STRING(0, "objdump", &annotate.opts.objdump_path, "path",
  		   "objdump binary to use for disassembly and annotations"),
+	OPT_BOOLEAN(0, "demangle", &symbol_conf.demangle,
+		    "Enable symbol demangling"),
+	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
+		    "Enable kernel symbol demangling"),
  	OPT_BOOLEAN(0, "group", &symbol_conf.event_group,
  		    "Show event group information together"),
  	OPT_BOOLEAN(0, "show-total-period", &symbol_conf.show_total_period,
-- 
2.30.2

