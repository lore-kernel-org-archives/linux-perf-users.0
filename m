Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA96C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 19:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E48461167
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 19:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhIITKU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 15:10:20 -0400
Received: from mail.aperture-labs.org ([94.130.126.186]:7906 "EHLO
        mail.aperture-labs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbhIITKU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Sep 2021 15:10:20 -0400
X-Greylist: delayed 379 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Sep 2021 15:10:19 EDT
Received: from mail.aperture-labs.org (localhost [127.0.0.1])
        by mail.aperture-labs.org (Postfix) with ESMTP id D4A7FC3D1A6
        for <linux-perf-users@vger.kernel.org>; Thu,  9 Sep 2021 19:02:49 +0000 (UTC)
Received: from [192.168.0.180] (ip-37-201-197-46.hsi13.unitymediagroup.de [37.201.197.46])
        by mail.aperture-labs.org (Postfix) with ESMTPSA id B3F0CC3D0F7
        for <linux-perf-users@vger.kernel.org>; Thu,  9 Sep 2021 19:02:49 +0000 (UTC)
To:     linux-perf-users@vger.kernel.org
From:   Timo Paulssen <timo@wakelift.de>
Subject: Make jitted assembly code available for annotation in "perf report"?
Message-ID: <cdf5252d-76af-9fb5-522f-206572b21807@wakelift.de>
Date:   Thu, 9 Sep 2021 21:02:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello perf users and devs,

I'm a contributor to the MoarVM project, which is the interpreter and 
jit runtime that powers the Rakudo compiler of the Raku language, which 
you may have heard of back when it was still called Perl 6.

We already output a file `/tmp/perf-%d.map` that contains the start and 
end addresses of jit-generated symbols, but I don't know how to tell 
perf where to look for the binary. Our current code will dump each 
compiled piece of code to a folder with an incrementing number. The perf 
report frontend will in its current implementation answer the request to 
annotate a function by just running objdump against the perf-%d.map 
file, which unsurprisingly doesn't work.

I would be glad to hear suggestions, especially ones that don't require 
me to generate a full elf file or similar to hold the symbols.

Thanks in advance
   - Timo

