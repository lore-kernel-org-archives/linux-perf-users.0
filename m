Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E399C49EB9
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 07:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 016996108E
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 07:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhFVHq7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Jun 2021 03:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhFVHq6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Jun 2021 03:46:58 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02892C061574;
        Tue, 22 Jun 2021 00:44:43 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id y13-20020a1c4b0d0000b02901c20173e165so1616768wma.0;
        Tue, 22 Jun 2021 00:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=oevnkpVwo0gswfiZaChLi9Eb9KJdRrYh4UHDd/tcJwc=;
        b=I1oVSWuGUxPKt2YBvP4LOyOGdRykhWI3mROUYdmVGIn+1j9DL/mleckPF/EcOSiRd0
         mWK+bJpLOShkgpp7FXW6oF5xrzpruJr7s6+XfKnGe2FfVV0AXp47O344QpQFNUTllRf5
         V3iYtR15juSnWO2SN/qde0WaoxVjjGrZvpUhXbvcddu9cyC/JeQBlsh9I2GHm8M2Njnh
         TAMYCJeAv41HU8qnVzZl7pwFr8xXx37J/rzeuDCWI9Pd7OPLtcHecfVJxbFLXPKdqkX+
         KGzxtxm8HkBowkU9g7hbdydnUNH0cBPCw0DfJ+8Ft6vDy8j1ATsueJgqSqxEoim1CmCS
         9Arg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=oevnkpVwo0gswfiZaChLi9Eb9KJdRrYh4UHDd/tcJwc=;
        b=pEvbjMteIGP7crNMR4PEhuBlVBLUx5Acq9aoAf2DJuq+qgaezVEyfm/w19Yrw4FvdE
         8fcrSi5qEIL/AbbsWv6ZXUN2feN+7NVnqCvrs27NKfCgGpW3KJ4baZm6UUjFNhI3iIUj
         QN6+R0WtmGrOhSWbBDxMOUnVs65VqoXP+PjcTgtzamrFvxx136aAJC/jgug1qiCm98CN
         CMyrX/sJayg9eWR2slRRQT2mr3spQsmbR0kbyFL9+iN3N7eeDKk4W6vslNOG2kBdEhZV
         pme5QAnQvjK0SQhHKhLdKHRqIPej9p2lPMCnCGsZTGn9/zbIOJpEg2Unp1DpJ4OocZU8
         dRsw==
X-Gm-Message-State: AOAM532mqjQGJSqJmS5XNMjLZoCI71KPqOZIbEo0Q0OozchsIJ1p2TIH
        nEaJK9vbO6p5I1O64ZSVnq8=
X-Google-Smtp-Source: ABdhPJxRqPbwS/zh+n5GZ0ZxNKdIX7lmjf2wemXEP7smR0ME9xEbZWemrolT7HvgF147NL0CcAaTdQ==
X-Received: by 2002:a1c:1d07:: with SMTP id d7mr2986670wmd.42.1624347881489;
        Tue, 22 Jun 2021 00:44:41 -0700 (PDT)
Received: from [192.168.1.15] ([151.29.45.200])
        by smtp.gmail.com with ESMTPSA id r2sm21157207wrv.39.2021.06.22.00.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 00:44:41 -0700 (PDT)
Message-ID: <d4921abf8dcff02245ccf7ad8edfd8048e926936.camel@gmail.com>
Subject: Re: [PATCH 2/2] perf script: delete evlist when deleting session
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 22 Jun 2021 09:44:39 +0200
In-Reply-To: <CAP-5=fUGRdj=G6=srwoATWMimK5tB4X2Sxa64tTVk_JRwMJdWg@mail.gmail.com>
References: <20210621234317.235545-1-rickyman7@gmail.com>
         <20210621234317.235545-3-rickyman7@gmail.com>
         <CAP-5=fUGRdj=G6=srwoATWMimK5tB4X2Sxa64tTVk_JRwMJdWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

thanks for your comments.

On Mon, 2021-06-21 at 22:14 -0700, Ian Rogers wrote:
> On Mon, Jun 21, 2021 at 4:44 PM Riccardo Mancini <rickyman7@gmail.com> wrote:
> > 
> > ASan reports a memory leak related to session->evlist never being deleted.
> > The evlist member is not deleted in perf_session__delete, so it should be
> > deleted separately.
> > This patch adds the missing deletion in perf-script.
> > 
> > Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> > ---
> >  tools/perf/builtin-script.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index 1280cbfad4db..635a1d9cfc88 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -3991,7 +3991,7 @@ int cmd_script(int argc, const char **argv)
> >                 zfree(&script.ptime_range);
> >         }
> > 
> > -       evlist__free_stats(session->evlist);
> 
> Should this be removed?

Probably not. I originally thought this was already taken care of by
evlist__delete, but it's not. 
Oddly, this issue is not causing a memory leak in my simple test.

> 
> > +       evlist__delete(session->evlist);
> 
> If the perf session "owns" the evlist, would it be cleaner to add this
> to perf_session__delete?

I thought about that too, but that's not always true.
E.g., in perf-record, __cmd_record calls perf_session__delete,then cmd_record
calls evlist__delete on rec->evlist, which points to the same location to which
session->evlist pointed. 

Thanks,
Riccardo

> 
> Thanks,
> Ian
> 
> >         perf_session__delete(session);
> > 
> >         if (script_started)
> > --
> > 2.31.1
> > 


