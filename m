Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB31AC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 08:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBE39611B0
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 08:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhIJIzl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Sep 2021 04:55:41 -0400
Received: from smoke.leastfixedpoint.com ([81.4.107.66]:37644 "EHLO
        mail.leastfixedpoint.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbhIJIzl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Sep 2021 04:55:41 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.leastfixedpoint.com (Postfix) with ESMTPSA id 1D9D167EB0;
        Fri, 10 Sep 2021 09:54:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leastfixedpoint.com;
        s=default; t=1631264069;
        bh=DxEV8RpR96AvQM/fYgbMJ4VgSedFIZCCeoHHd3nHUDM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=RrHUsmB+h3J0plFAdNdHc8jBUkW1zWMe8yajFsxaugt/8bu3P4gc53vBfkIobhgKb
         WBgnhqCnELnwCLKQPgQC7YeLFwVZTW0PVLZ7QvV25afrAzIDhV1JP1SbizLoq7wNeF
         IZJPuampBMxWcq7mp1K9rrpAgWrUxmcqj1JknGDc=
Subject: Re: [PATCH] tools/perf: Use long-running addr2line per dso
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>, acme@kernel.org,
        mingo@redhat.com, peterz@infradead.org
Cc:     linux-perf-users@vger.kernel.org
References: <20210909112202.1947499-1-tonyg@leastfixedpoint.com>
 <1631205749.uhek9ofd69.none@localhost>
From:   Tony Garnock-Jones <tonyg@leastfixedpoint.com>
Message-ID: <a5ab52f2-c898-d0fa-c2ec-0ee734ee9c0a@leastfixedpoint.com>
Date:   Fri, 10 Sep 2021 10:54:28 +0200
MIME-Version: 1.0
In-Reply-To: <1631205749.uhek9ofd69.none@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Alex,

Thanks for taking a look at the patch!

On 9/9/21 6:52 PM, Alex Xu (Hello71) wrote:
> This patch seems awfully complicated, especially considering it still
> uses relatively slow stdio instead of direct library calls.

It is comparable in speed to the libbfd variant, apparently: in 
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=911815#38, Steinar 
Gunderson reports that the bfd and patched non-bfd versions have similar 
run-times.

The complication is a bit of a shame, but I think it's reasonable given 
that it is essentially reimplementing a variant of popen(3) with 
bidirectional communication.

> Did you look
> into calling elfutils instead of libbfd if the latter is not available?

No, I didn't; I don't know the domain very well, so I adapted the 
existing solution to run more efficiently.

> On the patch specifically, why was popen changed to socketpair? It looks
> like it adds significant complexity, and the advanced features of
> socketpair are not being used (SOCK_DGRAM/SOCK_SEQPACKET, SCM_RIGHTS).

Because popen is unidirectional, and with a long-running process we need 
bidirectional communication. I could have used two pipes, but I figured 
socketpair was just sitting there and why spend the extra two fds if I 
didn't have to?

Regards,
   Tony
