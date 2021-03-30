Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00D0C433E0
	for <linux-perf-users@archiver.kernel.org>; Tue, 30 Mar 2021 18:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A356C619D1
	for <linux-perf-users@archiver.kernel.org>; Tue, 30 Mar 2021 18:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbhC3STi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 30 Mar 2021 14:19:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:58894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232844AbhC3STN (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 30 Mar 2021 14:19:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E9F1FAFCC;
        Tue, 30 Mar 2021 18:19:11 +0000 (UTC)
Subject: Re: [PATCH] perf annotate: add --demangle and --demangle-kernel
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <deb2af9e-25dd-ac72-29f4-ab90c2b24237@suse.cz>
 <YDVcZJscuKIgShsm@kernel.org> <a2349b3e-b3e2-f979-6bc5-a2cffbdd2d6a@suse.cz>
 <cad07055-620e-f0ce-9af2-a8a794bc47aa@suse.cz>
 <71d26f15-f0e8-adca-1e7c-46effcba913a@suse.cz> <YGNG9PLKEniErXwy@kernel.org>
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Message-ID: <2327ca98-f2ee-3a9a-0e24-d52fc90bcf9b@suse.cz>
Date:   Tue, 30 Mar 2021 20:19:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YGNG9PLKEniErXwy@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 3/30/21 5:42 PM, Arnaldo Carvalho de Melo wrote:
> Trying to find V2

It's this email:
https://lore.kernel.org/lkml/deb2af9e-25dd-ac72-29f4-ab90c2b24237@suse.cz/

Subject: Re: [PATCH] perf config: add annotate.demangle{,_kernel}
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <deb2af9e-25dd-ac72-29f4-ab90c2b24237@suse.cz>
  <YDVcZJscuKIgShsm@kernel.org> <a4e687b9-f611-1b24-ae7c-2ecd93c42ea8@suse.cz>
Message-ID: <c96aabe7-791f-9503-295f-3147a9d19b60@suse.cz>
Date:   Fri, 26 Feb 2021 11:08:12 +0100


Cheers,
Martin
