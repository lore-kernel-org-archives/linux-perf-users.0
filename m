Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DB0C46467
	for <linux-perf-users@archiver.kernel.org>; Tue,  3 Jan 2023 07:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjACH3S (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 3 Jan 2023 02:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236874AbjACH3Q (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 3 Jan 2023 02:29:16 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0B6DE99
        for <linux-perf-users@vger.kernel.org>; Mon,  2 Jan 2023 23:29:14 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pCbjV-0007Qt-41; Tue, 03 Jan 2023 08:29:13 +0100
Message-ID: <9560b967-a2ec-c370-7ec3-115295929e27@leemhuis.info>
Date:   Tue, 3 Jan 2023 08:29:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [v6.2-rc1] Regression with installing perf tool
Content-Language: en-US, de-DE
To:     Ian Rogers <irogers@google.com>
Cc:     Torsten Hilbrich <torsten.hilbrich@secunet.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org
References: <fa4b3115-d555-3d7f-54d1-018002e99350@secunet.com>
 <d372f704-fa4a-344f-7a15-d97bfb13ac1d@leemhuis.info>
 <CAP-5=fXkpbfxGo8ozTJRCXVm0eS6tZ+9XSLchTfcVHmvvhBq5A@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CAP-5=fXkpbfxGo8ozTJRCXVm0eS6tZ+9XSLchTfcVHmvvhBq5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1672730955;972deaac;
X-HE-SMSGID: 1pCbjV-0007Qt-41
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 03.01.23 08:13, Ian Rogers wrote:
> On Mon, Jan 2, 2023 at 7:06 AM Linux kernel regression tracking
>> [CCing Arnaldo]
>> On 02.01.23 14:16, Torsten Hilbrich wrote:
>>> I recently tried a kernel build based on v6.2-rc2 and had some regression when trying to install the perf command. It seems that the commit:
>>>
>>> commit 746bd29e348f99b44c14cb2b2a57f1d3efb66538
>>> Author: Ian Rogers <irogers@google.com>
>>> Date:   Tue Nov 15 23:22:11 2022 -0800
>>>
>>>     perf build: Use tools/lib headers from install path
>>>
>>>     Switch -I from tools/lib to the install path for the tools/lib
>>>     libraries. Add the include_headers build targets to prepare target, as
>>>     well as pmu-events.c compilation that dependes on libperf.
>>>
>>> Causes the the following command to fail: "make -C tools/ perf_install"
>>>
>>> Full logs are attached as file.
>>>
>>> The basic error is that the adding of $(LIBAPI), $(LIBSYMBOLS) and others to the prepare target seems to has problems when the subdir variable is set by the tools/Makefile.
>>>
>>> The call chains seems to include
>>>
>>> - "make -C tools perf_install" which calls:
>>> - "make  subdir=perf --no-print-directory -C perf install" which then fails
>>>
>>> The beginning of tools/scripts/Makfile.include then seems to construct a name like /build/git/linux/tools/perf/libapi/perf/ (when building in /build/git/linux) and this directory does not exist.
>>>
>>> We only need the perf tool in this case, so we don't care much about the optional features which are missing.
>> Thanks for the report. To be sure the issue doesn't fall through the
>> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
>> tracking bot:
>>
>> #regzbot ^introduced 746bd29e348f99b44c14cb2b2a57f1d3efb66538
>> #regzbot title perf build: problems when trying to install the perf command
>> #regzbot ignore-activity
> 
> Thanks, hopeful fix in:
> https://lore.kernel.org/lkml/20230103070916.2407873-1-irogers@google.com/

In case you need to respin that patch, please add a Link: tag to the
start of this thread to make things easier for future code archaeologists.

To explain: Linus[1] and others considered proper link tags important in
cases like this, as they allow anyone to look into the backstory of a
commit weeks or years later. That's nothing new, the documentation[2]
for some time says to place tags in cases like this. I care personally
(and made it a bit more explicit in the docs a while ago), because these
tags make my regression tracking efforts a whole lot easier, as they
allow my tracking bot 'regzbot' to automatically connect reports with
patches posted or committed to fix tracked regressions.

Apropos regzbot, let me tell regzbot to monitor that thread:

#regzbot monitor
https://lore.kernel.org/lkml/20230103070916.2407873-1-irogers@google.com/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

[1] for details, see:
https://lore.kernel.org/all/CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wjxzafG-=J8oT30s7upn4RhBs6TX-uVFZ5rME+L5_DoJA@mail.gmail.com/

[2] see Documentation/process/submitting-patches.rst
(http://docs.kernel.org/process/submitting-patches.html) and
Documentation/process/5.Posting.rst
(https://docs.kernel.org/process/5.Posting.html)
