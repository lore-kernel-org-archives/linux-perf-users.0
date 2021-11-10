Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C57C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Nov 2021 02:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 527BD61181
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Nov 2021 02:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhKJC1s (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Nov 2021 21:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbhKJC1r (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Nov 2021 21:27:47 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90D3C061764;
        Tue,  9 Nov 2021 18:25:00 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so825397wmz.2;
        Tue, 09 Nov 2021 18:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TTkLFHcGvtH+pB13GJ0NadfjTaTC8FpUPnqsIBnvMb4=;
        b=cWS5tAL5aLeFhdVmI1OhD3cCg43m/oSbq+cFcLaTDxkJgDbU+YqbtglrGDWkcynju1
         KNN8Uf8+RDxHka85Q9CPkhY/YleqzKgF1PSqBdyARj4KUX/ZYtR23Aw2DdVRRg8qFy8D
         c1y1eHQeJvEhAXu9yh5ixbnurF30yFABZojhtbzlOgSes99j6PFWvH8mS/BBNk4GUaUv
         nkfNoWaizv8QPzCnHhUdprP+GLcYU7UuLju01oB5+kMyqmtjCpa6NcSMf9hBE9xNJQOx
         C8uHNCN2rDf3ev87xmMkt7wPR7UT5zpJzUrVcxVCINOUrcbr+VDWnvqL0SGzxN3osC/D
         53ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TTkLFHcGvtH+pB13GJ0NadfjTaTC8FpUPnqsIBnvMb4=;
        b=NmWf2HIZiiZl85yPZMD6Kk194xzfnd6XURbCEBVr4v+Uash1RSP8HgtN0CI8vFEBje
         FZBKMucmUEVrokSbrsLY9n5t6L/SK6G5W1uDWbErGcxajhyMDSN16Ya52YPYWtrSCghD
         +DbaClta20k+6lbAD63BmTmLltWwI876Tth5CY0+bLbWHDb72J+SoYNkKzq/rQOiIZZJ
         5FGvWhU0I5I3EqSXjDgbxXA/if8lPlkXK8sYy9vFhCzxyXtYO0/t5yYZLWXbAa0tAq6Y
         nUELPfYQuvC0WWgRiYlSM1+u2rHlSNmnAsrqZWf9mw8NzpMfJZRMG67Gu57AXRhYS1+1
         zamg==
X-Gm-Message-State: AOAM530oaAfF9lWWILnlzJqIQF3eDsTkmz8JwgpqnPzXZvuQTx0qO2+c
        q22c23dEXZSPL8AakCkFR6td8o5mLwWL3g==
X-Google-Smtp-Source: ABdhPJzVkybnhbbiylMGuVpKDnT4vmNArLyKUyyJI7Ez1O6Xmr5h/Z/dR9RHq7d8Wf5/S4087/HqSQ==
X-Received: by 2002:a1c:770e:: with SMTP id t14mr12342584wmi.173.1636511099468;
        Tue, 09 Nov 2021 18:24:59 -0800 (PST)
Received: from pc ([197.49.136.152])
        by smtp.gmail.com with ESMTPSA id o10sm13129089wri.15.2021.11.09.18.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 18:24:59 -0800 (PST)
Date:   Wed, 10 Nov 2021 04:24:56 +0200
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf bench: Fix memory leaks.
Message-ID: <20211110022456.yd5m5on7v2jbqyzg@pc>
References: <20211108044826.138781-1-sohaib.amhmd@gmail.com>
 <CAP-5=fUc1uPti1MN3BZJ1JFus=ZYU66+gjh3bW30pUkE2sUxBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUc1uPti1MN3BZJ1JFus=ZYU66+gjh3bW30pUkE2sUxBQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Nov 08, 2021 at 10:57:25AM -0800, Ian Rogers wrote:
> On Sun, Nov 7, 2021 at 8:49 PM Sohaib Mohamed <sohaib.amhmd@gmail.com> wrote:
> >
> > ASan reports memory leaks while running:
> >
> > $ perf bench sched all
> >
> > Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
>
> Acked-by: Ian Rogers <irogers@google.com>
>
> I think you can add:
> Fixes: e27454cc6352c ("perf bench: Add sched-messaging.c: Benchmark
> for scheduler and IPC mechanisms based on hackbench")
>
> This will then get the fix backported to older stable perf commands.

I just added these two lines to version 2:
https://lore.kernel.org/linux-perf-users/20211110022012.16620-1-sohaib.amhmd@gmail.com/

Thanks,
Sohaib

>
> Thanks,
> Ian
>
> > ---
> >  tools/perf/bench/sched-messaging.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
> > index 488f6e6ba1a5..fa0ff4ce2b74 100644
> > --- a/tools/perf/bench/sched-messaging.c
> > +++ b/tools/perf/bench/sched-messaging.c
> > @@ -223,6 +223,8 @@ static unsigned int group(pthread_t *pth,
> >                 snd_ctx->out_fds[i] = fds[1];
> >                 if (!thread_mode)
> >                         close(fds[0]);
> > +
> > +               free(ctx);
> >         }
> >
> >         /* Now we have all the fds, fork the senders */
> > @@ -239,6 +241,8 @@ static unsigned int group(pthread_t *pth,
> >                 for (i = 0; i < num_fds; i++)
> >                         close(snd_ctx->out_fds[i]);
> >
> > +       free(snd_ctx);
> > +
> >         /* Return number of children to reap */
> >         return num_fds * 2;
> >  }
> > --
> > 2.25.1
> >
