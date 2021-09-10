Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD7DC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 22:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 819E161206
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 22:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhIJW5I (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Sep 2021 18:57:08 -0400
Received: from smoke.leastfixedpoint.com ([81.4.107.66]:39440 "EHLO
        mail.leastfixedpoint.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbhIJW5H (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Sep 2021 18:57:07 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.leastfixedpoint.com (Postfix) with ESMTPSA id 8E92C67F25;
        Fri, 10 Sep 2021 23:55:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leastfixedpoint.com;
        s=default; t=1631314554;
        bh=R9n9eogSHCbjHG/TnL5nYfX32wDxuCc7YBrdGAn9FtA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JSKhBC/Hg2uU2Dki0VhGa2pb0CAr4WOUxm21t0pbvb3fOAddkg/QsBBG8mbXUeB2V
         4KB2AyRrBaojkH/whn9ku1P+3iuLCd7ZxhVtPLpecQTpLJ0ANteMLat6DlqRNQBsy5
         YxD2C0XgDjUBuZuYur+U2aOpn/XgFVWT7KXSsCu8=
Subject: Re: [PATCH v2] tools/perf: Use long-running addr2line per dso
To:     Ian Rogers <irogers@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org
References: <20210909112202.1947499-1-tonyg@leastfixedpoint.com>
 <20210910102307.2055484-1-tonyg@leastfixedpoint.com>
 <CAP-5=fXXyfWJLDMKZEfgu2RAkJrE45m3+3FYzE5xceMjcm1TEg@mail.gmail.com>
From:   Tony Garnock-Jones <tonyg@leastfixedpoint.com>
Message-ID: <77d5e86c-e02a-3462-3334-696b9933334d@leastfixedpoint.com>
Date:   Sat, 11 Sep 2021 00:55:54 +0200
MIME-Version: 1.0
In-Reply-To: <CAP-5=fXXyfWJLDMKZEfgu2RAkJrE45m3+3FYzE5xceMjcm1TEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Ian,

On 9/11/21 12:45 AM, Ian Rogers wrote:
> I tested with memory sanitizer and no issues.

Great!

> The assignments of 0 and NULL here are redundant.

Yes, ok. I usually spell these things out for the reader, but it makes 
perfect sense to let zalloc() do its job :)

> I'm not clear on the use of stanza here, it seems to imply reading >1
> line but the out arguments/function don't agree with this. I think
> this would read better by just dropping the word stanza.

It does read more than one line - it reads exactly two lines. But 
calling it a stanza is a bit silly, I agree; how about "record"?

I'm about to mail v3 of the patch incorporating your comments.

Regards,
   Tony
