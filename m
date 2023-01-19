Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0EAC00A5A
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Jan 2023 12:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjASMxI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 Jan 2023 07:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjASMvI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 Jan 2023 07:51:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DBC11EA7
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Jan 2023 04:51:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8052C60DBB
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Jan 2023 12:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD751C433EF;
        Thu, 19 Jan 2023 12:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674132664;
        bh=OzXm+bbkrmc47yMbZWYbVLwa5s7iiXkwx3w/RuvhnD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OkfTJetBBWLbc1lVJC6VcF8AWbbD5gKdE+vR146K21dXdcOaYJk3y3iFm0T2ZKl7N
         lGRlCkY02wp+vSSsFAYy/8bUsAE/vhfImVvh/hm48EOF9ih9tycDnqGAUG7qIaZgE/
         0OZd6+FP2LnYEGKt6cGP5f5UZ84GU6AA8zU+dIMr/w2AeyTiukDZZDS+unF78+dF9F
         NgWVnJYEIjeYcB380SsqTuwAd+OJVZYnwDXKM/GG/GPtXzTditL+lXnZNStZQfYZt5
         wp4S4EcPTWZqgl7jkxWZIIDPXcWv6aDJSe0HNCv5ESucTWhO5vEcc5pWXc2og7KmKP
         UZVFPY/hAN7hw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D5892405BE; Thu, 19 Jan 2023 09:51:01 -0300 (-03)
Date:   Thu, 19 Jan 2023 09:51:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     qinyu <qinyu32@huawei.com>, peterz@infradead.org, mingo@redhat.com,
        linux-perf-users@vger.kernel.org, hewenliang4@huawei.com,
        linfeilong@huawei.com
Subject: Re: [PATCH] perf docs: fix a typo in perf probe doc
Message-ID: <Y8k8tfd7YlZlYgHd@kernel.org>
References: <20230116012143.432435-1-qinyu32@huawei.com>
 <CAP-5=fV255AszHQAYFWjcEWkPCORyD35_4O+2Uxt0+4o2FyXjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fV255AszHQAYFWjcEWkPCORyD35_4O+2Uxt0+4o2FyXjQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sun, Jan 15, 2023 at 10:00:47PM -0800, Ian Rogers escreveu:
> On Sun, Jan 15, 2023 at 5:15 PM qinyu <qinyu32@huawei.com> wrote:
> >
> > fix a minor typo in perf probe doc.
> >
> > Fixes: 631c9def804b ("perf probe: Support --line option to show probable source-code lines")
> > Signed-off-by: qinyu <qinyu32@huawei.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/Documentation/perf-probe.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/Documentation/perf-probe.txt b/tools/perf/Documentation/perf-probe.txt
> > index 7f8e8ba3a..5c43a6edc 100644
> > --- a/tools/perf/Documentation/perf-probe.txt
> > +++ b/tools/perf/Documentation/perf-probe.txt
> > @@ -222,7 +222,7 @@ probe syntax, 'SRC' means the source file path, 'ALN' is start line number,
> >  and 'ALN2' is end line number in the file. It is also possible to specify how
> >  many lines to show by using 'NUM'. Moreover, 'FUNC@SRC' combination is good
> >  for searching a specific function when several functions share same name.
> > -So, "source.c:100-120" shows lines between 100th to l20th in source.c file. And "func:10+20" shows 20 lines from 10th line of func function.
> > +So, "source.c:100-120" shows lines between 100th to 120th in source.c file. And "func:10+20" shows 20 lines from 10th line of func function.
> >
> >  LAZY MATCHING
> >  -------------
> > --
> > 2.33.0
> >

-- 

- Arnaldo
