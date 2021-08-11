Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EF2C4320A
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 Aug 2021 17:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A5C96104F
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 Aug 2021 17:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhHKRz4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 11 Aug 2021 13:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhHKRzz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 11 Aug 2021 13:55:55 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD85C061765;
        Wed, 11 Aug 2021 10:55:31 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id q3so918090edt.5;
        Wed, 11 Aug 2021 10:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=C06n6gHg6YJWBZfHbRSueQw+91Fo4dmr2ttTA5pTkj0=;
        b=p+0G66gS4a8BosocdUTmtDslCZmCFHfvGnZwUTE2dmuP5+EFGK+VA7QbGpsGXTCeje
         3A5zpYABjAeR9+ToVAa05A26vEpT7RVzmn5Wy0C5bgDfUMBUQm65tEWeT6zHpM+YfCKQ
         BYFwJ/mc8u7LC9ulgfry0tT9kqKv/9VfPQOU+UkibmSCl18+4OYJ++yLuLTZvUtE1K4+
         6iNwx/jaHJsej2fR3XfVuVnRhPw/5Pi7qNvzvFHvJuJQJTIc2qgYMhfEAkQ9Q0xm4SCV
         0YHdvbGOOw6zl4+mF9YGtYJRXLyyeAiZWVqSx+6FtNc4j11/PcF+50qruX3ck3VTUdKy
         j0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=C06n6gHg6YJWBZfHbRSueQw+91Fo4dmr2ttTA5pTkj0=;
        b=UVbbZ9hFamNzDvegGrGzNUUWsgrFfOFERgUL3mHEpj8iJCKM2Zy6E3ethfTu/a+Dkd
         Dnz/676VAkuf7OqU/TW4+VMrpW4di4j+rQWNRiEmha+6zfIGSqt763aB70qZsMR3cP8T
         6hBsfitLMCV2m6BrK3LnOnDH02I+yqXE7SNUl7d8PordYyldO9aq1qbZTkhCPDpyzKr+
         i9aukf1Ddxu/LQXC0nlYL7mVwk9zNB6Lme07YuXQSLRo0GN8RsXACugSuLRue8IogpbJ
         MvMfMPRCINEQ7ar0xdzg5P3SZomI/1aCQleou1F1ZScedmijo1D3vFmXoH6IXi6jIuDl
         PrQQ==
X-Gm-Message-State: AOAM530B6oe4D1xgx+S8h7Q+mtxt3kECnOrR+fHnWopa9/auKlvW2u8B
        FiXOzCrBkABAZcs0XXLzZgE=
X-Google-Smtp-Source: ABdhPJy/8EXE+UItm/1fWxAOhRuoGvVr/4810qekCrPve43Ly3fOnPEzw3MLXJZ+4KQMv4ZKVBTAJA==
X-Received: by 2002:a05:6402:11c6:: with SMTP id j6mr76774edw.349.1628704530193;
        Wed, 11 Aug 2021 10:55:30 -0700 (PDT)
Received: from [172.16.0.82] (nat-allievi.sssup.it. [193.205.81.9])
        by smtp.gmail.com with ESMTPSA id g26sm40239ejr.48.2021.08.11.10.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 10:55:29 -0700 (PDT)
Message-ID: <4941e4a6d898a4545ff319b6b74442e18ca8025a.camel@gmail.com>
Subject: Re: [RFC PATCH v2 01/10] perf workqueue: threadpool creation and
 destruction
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Date:   Wed, 11 Aug 2021 19:55:27 +0200
In-Reply-To: <YRLgYDKRUfwLSyHF@kernel.org>
References: <cover.1627657061.git.rickyman7@gmail.com>
         <4f0cd6c8e77c0b4f4d4b8d553a7032757b976e61.1627657061.git.rickyman7@gmail.com>
         <CAM9d7ci0LcdTZyDu5sxGkaS07Z-m4hvr2xU4TDK_aTRAJm7b7A@mail.gmail.com>
         <25278c08762593a5b0bd1873f6c0745c7ad97016.camel@gmail.com>
         <CAM9d7chuFG+cYPx34abvmciN0afUDqJ3uWo9Bsh-9jjLtQmWqQ@mail.gmail.com>
         <YRLgYDKRUfwLSyHF@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, 2021-08-10 at 17:24 -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Aug 10, 2021 at 11:54:19AM -0700, Namhyung Kim escreveu:
> > On Mon, Aug 9, 2021 at 3:30 AM Riccardo Mancini <rickyman7@gmail.com> wrote:
> > > On Fri, 2021-08-06 at 19:24 -0700, Namhyung Kim wrote:
> > > > > +/**
> > > > > + * threadpool__strerror - print message regarding given @err in @pool
> > > > > + *
> > > > > + * Buffer size should be at least THREADPOOL_STRERR_BUFSIZE bytes.
> > > > > + */
> > > > > +int threadpool__strerror(struct threadpool *pool __maybe_unused, int
> > > > > err,
> > > > > char *buf, size_t size)
> > > > > +{
> > > > > +       char sbuf[STRERR_BUFSIZE], *emsg;
> > > > > +
> > > > > +       emsg = str_error_r(err, sbuf, sizeof(sbuf));
> > > > > +       return scnprintf(buf, size, "Error: %s.\n", emsg);
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * threadpool__new_strerror - print message regarding @err_ptr
> > > > > + *
> > > > > + * Buffer size should be at least THREADPOOL_STRERR_BUFSIZE bytes.
> > > > > + */
> > > > > +int threadpool__new_strerror(struct threadpool *err_ptr, char *buf,
> > > > > size_t
> > > > > size)
> > > > > +{
> > > > > +       return threadpool__strerror(err_ptr, PTR_ERR(err_ptr), buf,
> > > > > size);
> > > > > +}
> 
> > > > Why two different functions?
> 
> > > Since when new fails you don't have a err number, just an err_ptr so it's
> > > not
> > > very clear how to call threadpool__strerror. Therefore I made a wrapper to
> > > remove any ambiguity.
> > 
> > What do you mean by "when new fails"?
> 
> I think 'new' is 'constructor', i.e. something__new() returns a newly
> created object and this not an error number, so he uses ERR_PTR() and
> then he needs to pass it to the 'strerror' specific to the
> threadpool__new, which will use PTR_ERR() to get an integer, and then
> map that to a proper error string, right?

Correct. 
threadpool__new_strerror is not really needed since one could use
threadpool__strerror directly, but then I would need to handle all possible ways
it could be called (e.g. (NULL, PTR_ERR(err_ptr)), (err_ptr, 0), (err_ptr,
PTR_ERR(err_ptr)), so I thought it was better to just provide a strerror that
only took the err_ptr.
Maybe I can provide it as an inline in the header, or as a macro.

Riccardo

> 
> - Arnaldo


