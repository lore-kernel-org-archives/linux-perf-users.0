Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DFFC432BE
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 16:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D4AE60F92
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 16:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbhHaQOR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 12:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239823AbhHaQOR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Aug 2021 12:14:17 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F1AC061575;
        Tue, 31 Aug 2021 09:13:22 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id h9so40014038ejs.4;
        Tue, 31 Aug 2021 09:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=2+L+wB0fnPlt/CRaJbJJjyyQujawdtG2naZwB/HENfw=;
        b=VK0imM80Bz7slqaDcXPMpShGFFNKBKHZG1KUYYcIno/WBJitmRfAE6N/5EMSNggkff
         YW1ImdRK5HjNK+PrOz6h4tWU6hJo938HjarBrxuTr+uZMImqUJpX8vQpPQphw82SRlJd
         1ddSt3GA+UXBnGfCYWuVRizpUDEjZP48ogvi8cLxGpYopC/sgsi9yRQJhdor1x4ehQ3Y
         bHNrEixqaZeh7m+RE28047S3a7X2deKMZ1dQFBLV234ncl73CWo1she6w7v6VxvZ4aF3
         J2dLWeABu0EnoEdMTl6dMjqPVkr9/dwanfNAx+tNT9CXDyh7k0dOXxsMyDL3/i55Y2Ai
         +Y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=2+L+wB0fnPlt/CRaJbJJjyyQujawdtG2naZwB/HENfw=;
        b=Zvp1+CCWPiFklnYeD/3mdZyPNeGTGweTfSDNW+E0ldZe6WqEayTP3PSG+791fk8se5
         V/z7WFiOOMIjux3MxSztEkv6uzcI263pkWZqNpwmo7l1T6lm7WKQFZ7kszWAY2GqdVRe
         WiNSTPMUyRWuQFzP7NC+kNQFsie2Xgcceq2BIw8WO/f+Q7ozV2jfKF3NHkt7sOIqlxVo
         SEGe5ynNzRQoBdwXjc3PyuezHizBce8hks4iJDEOZ9lhWHdmR8u76u6tM5XCb6KgMCX/
         mQAHLhOwteaA23Jp+oyodIQxvjyKI5f9bWscrKU6zOADzPZd0sOZU/oiNXt/nDWTYzPl
         U/SQ==
X-Gm-Message-State: AOAM532bDJkPyHIK9M1jlfKjJo0JkLIKCEN/OdLoD4Tu0hNJ9BM/0qEk
        HdTGikqk6IsdJ5JxczKs1cE=
X-Google-Smtp-Source: ABdhPJwDiXNRy+yWMSEjrOSNhAHom1LI3JbkIck12tvEczhbxMEK1E2V+2NuXfSwnhQlUYZHd3Pw/g==
X-Received: by 2002:a17:906:ce3a:: with SMTP id sd26mr12260355ejb.227.1630426400410;
        Tue, 31 Aug 2021 09:13:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6456:fd99:ced0:db1c:53e1:191e? ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.gmail.com with ESMTPSA id jz16sm6577903ejc.34.2021.08.31.09.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 09:13:20 -0700 (PDT)
Message-ID: <7c3d2688a1544eb5ea963cd2b07a2ff03d328c4a.camel@gmail.com>
Subject: Re: [RFC PATCH v3 06/15] perf workqueue: introduce workqueue struct
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Date:   Tue, 31 Aug 2021 18:13:18 +0200
In-Reply-To: <CAM9d7cjJuLdBtN_2it88v4VAmVZ5sSzcpDX-eU9A+hiyO3izaA@mail.gmail.com>
References: <cover.1629454773.git.rickyman7@gmail.com>
         <9dee672538967a3cf7e82ef194ebccc709b1af41.1629454773.git.rickyman7@gmail.com>
         <CAM9d7cjJuLdBtN_2it88v4VAmVZ5sSzcpDX-eU9A+hiyO3izaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Namhyung,
thanks again for taking your time to review.

On Tue, 2021-08-24 at 12:27 -0700, Namhyung Kim wrote:
> Hi Riccardo,
> 
> On Fri, Aug 20, 2021 at 3:54 AM Riccardo Mancini <rickyman7@gmail.com> wrote:
> > +/**
> > + * workqueue_strerror - print message regarding lastest error in @wq
> > + *
> > + * Buffer size should be at least WORKQUEUE_STRERR_BUFSIZE bytes.
> > + */
> > +int workqueue_strerror(struct workqueue_struct *wq, int err, char *buf,
> > size_t size)
> > +{
> > +       int ret;
> > +       char sbuf[THREADPOOL_STRERR_BUFSIZE], *emsg;
> > +       const char *errno_str;
> > +
> > +       errno_str = workqueue_errno_str[-err-WORKQUEUE_ERROR__OFFSET];
> 
> It seems easy to crash with an invalid err argument.

Yup, I should add a check in the next version.

> 
> > +
> > +       switch (err) {
> > +       case -WORKQUEUE_ERROR__POOLNEW:
> > +       case -WORKQUEUE_ERROR__POOLEXE:
> > +       case -WORKQUEUE_ERROR__POOLSTOP:
> > +       case -WORKQUEUE_ERROR__POOLSTARTTHREAD:
> > +               if (IS_ERR_OR_NULL(wq))
> > +                       return scnprintf(buf, size, "%s: unknown.\n",
> > +                               errno_str);
> > +
> > +               ret = threadpool__strerror(wq->pool, wq->pool_errno, sbuf,
> > sizeof(sbuf));
> > +               if (ret < 0)
> > +                       return ret;
> > +               return scnprintf(buf, size, "%s: %s.\n", errno_str, sbuf);
> > +       case -WORKQUEUE_ERROR__WRITEPIPE:
> > +       case -WORKQUEUE_ERROR__READPIPE:
> > +               emsg = str_error_r(errno, sbuf, sizeof(sbuf));
> 
> 
> This means the errno should be kept before calling this, right?

Yeah, I should make sure to preserve it, I think it's done this way in some
other functions.
Otherwise, I can save it in a struct attribute, which is maybe simpler.

> 
> > +               return scnprintf(buf, size, "%s: %s.\n", errno_str, emsg);
> > +       case -WORKQUEUE_ERROR__INVALIDMSG:
> > +               return scnprintf(buf, size, "%s.\n", errno_str);
> > +       default:
> > +               emsg = str_error_r(err, sbuf, sizeof(sbuf));
> > +               return scnprintf(buf, size, "Error: %s", emsg);
> 
> Newline at the end?

Forgot it, thanks!

Riccardo

> 
> Thanks,
> Namhyung
> 
> 
> > +       }
> > +}
> > +


