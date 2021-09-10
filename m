Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C93C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 08:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DD0461153
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 08:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhIJI74 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Sep 2021 04:59:56 -0400
Received: from smoke.leastfixedpoint.com ([81.4.107.66]:37674 "EHLO
        mail.leastfixedpoint.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbhIJI7z (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Sep 2021 04:59:55 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.leastfixedpoint.com (Postfix) with ESMTPSA id 8676967EB0;
        Fri, 10 Sep 2021 09:58:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leastfixedpoint.com;
        s=default; t=1631264323;
        bh=/QjilGm/828vFR7BmizfNo3owyGsgFba5tc8qcwLGDQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ocoSzs1Kde+8hzq+bEpwbE+GIAWPG7O3Dw7xuozKm8aA5XP+b0NuetjSIw6RtMPd7
         Fmw69mfPP/g6EfSR95EX7dKb/t06Q9KFTDJeRDDeVfpmioq3KtrhbghHHdBNpTbUIF
         mQYkbTgyYq7gaD2GbgWjcsXrq6dQ27ck2OjVhDyc=
Subject: Re: [PATCH] tools/perf: Use long-running addr2line per dso
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-perf-users@vger.kernel.org
References: <20210909112202.1947499-1-tonyg@leastfixedpoint.com>
 <1631205749.uhek9ofd69.none@localhost> <YTpsTpyczphPtADn@kernel.org>
From:   Tony Garnock-Jones <tonyg@leastfixedpoint.com>
Message-ID: <213c29ab-5d17-82f7-7f56-b9b70f750fd9@leastfixedpoint.com>
Date:   Fri, 10 Sep 2021 10:58:43 +0200
MIME-Version: 1.0
In-Reply-To: <YTpsTpyczphPtADn@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 9/9/21 10:19 PM, Arnaldo Carvalho de Melo wrote:
> That would be better, indeed, but since nobody has worked on this area
> for white some time and we have it in a far worse shape right now, I'm
> inclined to accept his work after I have time to review it.

I'd like to see the patch land and *then* be replaced with something 
even better, so that sounds good to me :-)

> Valid questions, perhaps we can get what Tony did and improve it and
> then try working with the library.

(See my reply to Alex for answers!)

Regards,
   Tony
