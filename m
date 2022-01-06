Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FEAC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Jan 2022 20:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243680AbiAFUYc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 Jan 2022 15:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243661AbiAFUYc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Jan 2022 15:24:32 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAEBC061245
        for <linux-perf-users@vger.kernel.org>; Thu,  6 Jan 2022 12:24:32 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id d14so3026577ila.1
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Jan 2022 12:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1hwwvjlhtkCgnYzKELSHOhx4GC796dq3UFrZuDKUjZw=;
        b=pjeWTfqAAFn0D70nVe2H8jxZ56DPQQM86g1itSPNeUWz0Df2BWfBY2oSYu3YeKIbpf
         feXVe/PqKsxq+OmDKcwNK5HNjhEgvGGDSpQD8UKTVmvvBE9gFTvufl0oFWxHiN94cZ1E
         NHxtLrx3cyPsG4Re3rh5WX0osECP0cWJTpyC1DOdxUEbCueEoJG0zgPta22rWR8+bHwo
         nCthVCGSANxLMbHt6sTLddyqzYrkW8UrZWiPk+NNFFu+W1AmM50LOqk+SpAoZt8gn/2H
         xHaTQeju4IED99/3Jel58xaJn32WAeCrGthgnUc2Pd6BjhYWOenTFQ5L5Ce4dSgyiNRY
         rf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1hwwvjlhtkCgnYzKELSHOhx4GC796dq3UFrZuDKUjZw=;
        b=JhQNYDDv3anEP80I37qm8yDeFxeZBTTGuT9HuZ3oGnrDMGv1NNhlo6RfwpBqim7Cj2
         zqTDcVzh4zcKw54XA5mWejbgAxAqjLYNJ9n3KM5+DaX4Rk3tgbYnIbivm+KG8KFtDqls
         FNcBJKR3pCo9B1mdH4CjsyQEYPpPtWpNX5djdhFkOZh1BnWfjmvAf02Ib560EzKq0nPr
         ZRG1R6yograf3TfayAXzO5xmBjyhCyLHYYZCKm18bnQdgYEeC9umqP3dVrf28u5pO+To
         LNLVxxnUYTADHD1bs5mhLrbyKxGgJ6dUkMpBGFcNiPNcI7peZOth5gGHL7HGv3Ilfryl
         33kQ==
X-Gm-Message-State: AOAM533luEwWQwFrWeKBDTAq1CoLfOHr9rr0bmOoFyXs6JMjTvkU5AAf
        HZCvBXwjf8rkhL5b2Le4MSJUbzDW6pbCBRlzZWOCcg==
X-Google-Smtp-Source: ABdhPJyQRHDqkZiMGNUXLizaclzFo6BOctys0w1THIbnIioQgwHfzgOf6Sh8VTpnDMkncqh8Z3v4x/MxVtKxkvvwFxs=
X-Received: by 2002:a05:6e02:170c:: with SMTP id u12mr28684525ill.53.1641500671458;
 Thu, 06 Jan 2022 12:24:31 -0800 (PST)
MIME-Version: 1.0
References: <20220106072627.476524-1-irogers@google.com> <YddC+lzAO1Urj0TF@kernel.org>
 <YddDcqxtDrPDSAVi@kernel.org>
In-Reply-To: <YddDcqxtDrPDSAVi@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 6 Jan 2022 12:24:18 -0800
Message-ID: <CAP-5=fWNfB6g0Bk2zPH3yYuvcDQG7TGQ7DBsnkTc3pZF0jKoHA@mail.gmail.com>
Subject: Re: [PATCH] perf build: Lower the priority of tools/lib includes
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        torvalds@linux-foundation.org, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jan 6, 2022 at 11:31 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Jan 06, 2022 at 04:28:58PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Jan 05, 2022 at 11:26:27PM -0800, Ian Rogers escreveu:
> > > tools/lib has a 1.1.0 copy of libtraceevent. If a newer system
> > > version is installed then its headers will go in /usr/include. As -I has
> > > priority over system headers the 1.1.0 version gets used in preference
> > > to the system one, which isn't what is wanted. To make the behavior
> > > match expectations use -idirafter so that any system headers have priority
> > > over the tools/lib version.
> > >
> > > Fixes: 08efcb4a638d ("libtraceevent: Increase libtraceevent logging when verbose")
> >
> > Hi,
> >
> >       You forgot to add your Signed-off-by:, I'm adding it as you
> > usually provide it, ok?
>
> Also adding:
>
> Reported-by: Jiri Slaby <jirislaby@kernel.org>
>
> - Arnaldo

Thanks Arnaldo! Both good with me.

Ian
