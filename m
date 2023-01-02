Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F49C4708E
	for <linux-perf-users@archiver.kernel.org>; Mon,  2 Jan 2023 15:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjABPGP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 2 Jan 2023 10:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236079AbjABPGO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 2 Jan 2023 10:06:14 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73A7194
        for <linux-perf-users@vger.kernel.org>; Mon,  2 Jan 2023 07:06:13 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pCMOB-0007AE-VQ; Mon, 02 Jan 2023 16:06:12 +0100
Message-ID: <d372f704-fa4a-344f-7a15-d97bfb13ac1d@leemhuis.info>
Date:   Mon, 2 Jan 2023 16:06:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [v6.2-rc1] Regression with installing perf tool
Content-Language: en-US, de-DE
To:     Torsten Hilbrich <torsten.hilbrich@secunet.com>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     linux-perf-users@vger.kernel.org
References: <fa4b3115-d555-3d7f-54d1-018002e99350@secunet.com>
From:   "Linux kernel regression tracking (#info)" 
        <regressions@leemhuis.info>
Reply-To: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <fa4b3115-d555-3d7f-54d1-018002e99350@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1672671973;3af990c7;
X-HE-SMSGID: 1pCMOB-0007AE-VQ
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; all text you find below is based on a few templates
paragraphs you might have encountered already already in similar form.
See link in footer if these mails annoy you.]

[CCing Arnaldo]

On 02.01.23 14:16, Torsten Hilbrich wrote:
> 
> I recently tried a kernel build based on v6.2-rc2 and had some regression when trying to install the perf command. It seems that the commit:
> 
> commit 746bd29e348f99b44c14cb2b2a57f1d3efb66538
> Author: Ian Rogers <irogers@google.com>
> Date:   Tue Nov 15 23:22:11 2022 -0800
> 
>     perf build: Use tools/lib headers from install path
>     
>     Switch -I from tools/lib to the install path for the tools/lib
>     libraries. Add the include_headers build targets to prepare target, as
>     well as pmu-events.c compilation that dependes on libperf.
>     
> Causes the the following command to fail: "make -C tools/ perf_install"
> 
> Full logs are attached as file.
> 
> The basic error is that the adding of $(LIBAPI), $(LIBSYMBOLS) and others to the prepare target seems to has problems when the subdir variable is set by the tools/Makefile.
> 
> The call chains seems to include
> 
> - "make -C tools perf_install" which calls:
> - "make  subdir=perf --no-print-directory -C perf install" which then fails
> 
> The beginning of tools/scripts/Makfile.include then seems to construct a name like /build/git/linux/tools/perf/libapi/perf/ (when building in /build/git/linux) and this directory does not exist.
> 
> We only need the perf tool in this case, so we don't care much about the optional features which are missing.
Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 746bd29e348f99b44c14cb2b2a57f1d3efb66538
#regzbot title perf build: problems when trying to install the perf command
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (see page linked in footer for details).

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
-- 
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
