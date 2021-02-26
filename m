Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A319C433E0
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Feb 2021 10:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01A2F64EE2
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Feb 2021 10:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhBZKB5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Feb 2021 05:01:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:57896 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229990AbhBZKBy (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Feb 2021 05:01:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E667BAF3F;
        Fri, 26 Feb 2021 10:01:11 +0000 (UTC)
Subject: Re: [PATCH] perf annotate: add --demangle and --demangle-kernel
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <deb2af9e-25dd-ac72-29f4-ab90c2b24237@suse.cz>
 <YDVcZJscuKIgShsm@kernel.org>
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Message-ID: <a2349b3e-b3e2-f979-6bc5-a2cffbdd2d6a@suse.cz>
Date:   Fri, 26 Feb 2021 11:01:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YDVcZJscuKIgShsm@kernel.org>
Content-Type: multipart/mixed;
 boundary="------------BEDBFE0A2EDD88A4D15A7E96"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This is a multi-part message in MIME format.
--------------BEDBFE0A2EDD88A4D15A7E96
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/23/21 8:49 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Feb 22, 2021 at 09:29:22AM +0100, Martin Liška escreveu:
>> Perf annotate supports --symbol but it's impossible to filter
>> a C++ symbol. With --no-demangle one can filter easily by
>> mangled function name.
>>
>> Signed-off-by: Martin Liška <mliska@suse.cz>
>> ---
>>   tools/perf/Documentation/perf-annotate.txt | 7 +++++++
>>   tools/perf/builtin-annotate.c              | 4 ++++
>>   2 files changed, 11 insertions(+)
>>
>> diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
>> index 1b5042f134a8..80c1be5d566c 100644
>> --- a/tools/perf/Documentation/perf-annotate.txt
>> +++ b/tools/perf/Documentation/perf-annotate.txt
>> @@ -124,6 +124,13 @@ OPTIONS
>>   --group::
>>   	Show event group information together
>> +--demangle::
>> +	Demangle symbol names to human readable form. It's enabled by default,
>> +	disable with --no-demangle.
>> +
>> +--demangle-kernel::
>> +	Demangle kernel symbol names to human readable form (for C++ kernels).
>> +
>>   --percent-type::
>>   	Set annotation percent type from following choices:
>>   	  global-period, local-period, global-hits, local-hits
>> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
>> index a23ba6bb99b6..ef70a17b9b5b 100644
>> --- a/tools/perf/builtin-annotate.c
>> +++ b/tools/perf/builtin-annotate.c
>> @@ -538,6 +538,10 @@ int cmd_annotate(int argc, const char **argv)
>>   		    "Strip first N entries of source file path name in programs (with --prefix)"),
>>   	OPT_STRING(0, "objdump", &annotate.opts.objdump_path, "path",
>>   		   "objdump binary to use for disassembly and annotations"),
>> +	OPT_BOOLEAN(0, "demangle", &symbol_conf.demangle,
>> +		    "Disable symbol demangling"),
> 
> Nope, this _enables_ demangling, i.e.:
> 
> 	perf annotate --demangle

Oh, yeah, you are right.

> 
> Asks for symbol demangling, while:
> 
> 	perf annotate --no-demangle
> 
> As you correctly wrote in your commit message and on the
> --demangle-kernel case, enables demangling.

Fixed that in V2.

Martin

> 
> Please consider making this configurable (if not already) via
> ~/.perfconfig, 'perf config', sure in a followup patch.
> 
> Thanks,
> 
> - Arnaldo
> 
>> +	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
>> +		    "Enable kernel symbol demangling"),
>>   	OPT_BOOLEAN(0, "group", &symbol_conf.event_group,
>>   		    "Show event group information together"),
>>   	OPT_BOOLEAN(0, "show-total-period", &symbol_conf.show_total_period,
>> -- 
>> 2.30.1
>>
> 


--------------BEDBFE0A2EDD88A4D15A7E96
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-perf-annotate-add-demangle-and-demangle-kernel.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename*0="0001-perf-annotate-add-demangle-and-demangle-kernel.patch"

From 336233abae5c539d7b2730cbbe35d0c7528bccc2 Mon Sep 17 00:00:00 2001
From: Martin Liska <mliska@suse.cz>
Date: Mon, 22 Feb 2021 09:24:22 +0100
Subject: [PATCH] perf annotate: add --demangle and --demangle-kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
index a23ba6bb99b6..ea05d9f927cb 100644
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
2.30.1


--------------BEDBFE0A2EDD88A4D15A7E96--
