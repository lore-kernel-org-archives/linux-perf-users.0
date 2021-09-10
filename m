Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1791CC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 08:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2791611C5
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 08:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhIJI6w (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Sep 2021 04:58:52 -0400
Received: from smoke.leastfixedpoint.com ([81.4.107.66]:37662 "EHLO
        mail.leastfixedpoint.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbhIJI6w (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Sep 2021 04:58:52 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.leastfixedpoint.com (Postfix) with ESMTPSA id 5BBEE67EB0;
        Fri, 10 Sep 2021 09:57:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leastfixedpoint.com;
        s=default; t=1631264260;
        bh=0sqfmE4alz8WzJPy5hKzsRjOVj0a0R7i3bjjbCRAnlQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LQEdGiOwm7jWKTvdwU/LdVOp24Ub9hk+xMJsCYhZjcUSaw6Uo4B2wyaF474JdzelR
         aL7F/vbZZRY9LYfhnxVuAeHdU6JcxCrc8nwxGrRwIL1Px9PgYDTaJ0gjlmlMphmPP/
         tuwWDSFzZ9854IDWzzRbduwQxd2A793nx+PcI7qI=
Subject: Re: [PATCH] tools/perf: Use long-running addr2line per dso
To:     Ian Rogers <irogers@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org
References: <20210909112202.1947499-1-tonyg@leastfixedpoint.com>
 <CAP-5=fVOSzzsDfzYYm_GOAVrAEtGrre1KgjA0rSnQAgmnf9c7Q@mail.gmail.com>
From:   Tony Garnock-Jones <tonyg@leastfixedpoint.com>
Message-ID: <a18ec37c-77a5-2538-5278-fab9b9100f75@leastfixedpoint.com>
Date:   Fri, 10 Sep 2021 10:57:40 +0200
MIME-Version: 1.0
In-Reply-To: <CAP-5=fVOSzzsDfzYYm_GOAVrAEtGrre1KgjA0rSnQAgmnf9c7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 9/9/21 9:05 PM, Ian Rogers wrote:
> This is very cool and the performance wins in the bug report are
> impressive! Could some of the process management functionality in the
> change make use of start_command and similar code in
> tools/lib/subcmd/run-command.h ?

Excellent! I didn't know that was there. Yes, that would be a good idea, 
and would remove much of the popen(3) ~reimplementation code from the 
patch. In fact, looking at the code, it's the same general shape, and 
has improved error handling around waitpid(2) (though it's not critical 
in this case), so the patch would certainly be better expressed with 
that code. Thanks for the pointer, I'll revise and resubmit.

Regards,
   Tony
