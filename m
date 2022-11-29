Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B92C4167B
	for <linux-perf-users@archiver.kernel.org>; Tue, 29 Nov 2022 19:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbiK2TdW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 29 Nov 2022 14:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235889AbiK2TdV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 29 Nov 2022 14:33:21 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF1012ADA
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Nov 2022 11:33:20 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id x17so23724254wrn.6
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Nov 2022 11:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DziUPV3FYLxKZaiIMhDeCeZbJbV2j/J3+CJximfrnik=;
        b=ljIY7f+3ukdZIghKE1EdXX2KIJyvM8xGwKKFJE8BFwfNq2TGrrg8W5xeXZ6/DvkI1U
         a6Z3wBAVGZxhlYrj6OXjXqeIuhFAXfGmztDuKsJ//zNJZHF1JixxQSQHkxWZ9g8YFhhf
         fNLSZpSIrAtqMZ9KxfbX6FWW/pW4os3jcrOh7wG2wMPeVviMVWGl4lfjZ2OHnH7Dtmso
         eXnaQlL4CjvYIy8nrA/1xOvwt7LKMIl7orKKYqX5SLFiGca2NPNsElPdD37aHIXfibZu
         q+T6RxwLBwCnWzj9rqRXOHxkIQtaSipt52Wd25M9tjs6MwwdAInF+ajziZa99g1P5UgG
         wU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DziUPV3FYLxKZaiIMhDeCeZbJbV2j/J3+CJximfrnik=;
        b=x+AzcbqHtPwm0cE7bRj6B4aquZNTWZI8aS5acF9gYW81KSX+Ba8FAsF8GLT38I7vVx
         71dW+WCM18B9h3par0gnLL0oXHaIxsFDh+AbGld4WjUGoioEIrrE/4Iu2XXtpqKgJvdY
         PK+KvEcMhCQsA8bcaZpqRmZeMABHyMk6vDsTITd9zKGEB7LEHBebQV4lkd3p7BFNo+X4
         oGIKp3xqAye3HaaRdyg6ETljmRxNzRJCBBR2B2f4+0hWEWP32gAjS6U531Ayeayjjlk8
         Q2Wn4PNSDKeDfbtOfn024F0ViZGcvnBXuU8hzSphy5n5W3l0fUdUkchHKLHB0vHKCGov
         rhag==
X-Gm-Message-State: ANoB5pkZDrfgXRvCDYrfFw7bVYTQ0F2zZtD6OQI+ENjPZ35C8BcBan7n
        1hJ0qfaWaUGq6BG7tev4misa+nQk+jhOt2XxVBt+uA==
X-Google-Smtp-Source: AA0mqf6g0fmXm+IiK5ByKrmlfR+f9Iloi5aZFvc5rSu+3q8sOstHPCmZ64lRbwgI9u4Y5Y5RvADTTZf2lNJyEPbuePw=
X-Received: by 2002:a5d:680c:0:b0:242:a38:d0c6 with SMTP id
 w12-20020a5d680c000000b002420a38d0c6mr12307489wru.375.1669750398699; Tue, 29
 Nov 2022 11:33:18 -0800 (PST)
MIME-Version: 1.0
References: <20221116224631.207631-1-irogers@google.com> <Y4Cb4feK/9q+Wzmt@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <Y4DDsmXU/tkmDfK7@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
In-Reply-To: <Y4DDsmXU/tkmDfK7@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 29 Nov 2022 11:33:06 -0800
Message-ID: <CAP-5=fWv4DXAY1AhMvc47ULVcCUGDdoSZhK5r=+QXeiCWMpd+g@mail.gmail.com>
Subject: Re: [PATCH] perf build: Fix LIBTRACEEVENT_DYNAMIC
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Nov 25, 2022 at 5:31 AM Alexander Gordeev
<agordeev@linux.ibm.com> wrote:
>
> On Fri, Nov 25, 2022 at 11:41:40AM +0100, Alexander Gordeev wrote:
> > > The tools/lib includes fixes break LIBTRACEVENT_DYNAMIC as the
> > > makefile erroneously had depdendencies on building libtraceevent even
> > > when not linking with it. This change fixes the issues with
> > > LIBTRACEEVENT_DYNAMIC by making the built files optional.
> >
> > It kernel-next on s390 somehow libtraceevent seems to be bypassed, which leads
> > to make -C tools/perf install-bin failure. While it does not hit in every
> > envoronment, could you please hint what could be a reason for that?
>
> And unless I am missing something install-traceevent-plugins target
> is only awailable when LIBTRACEEVENT_DYNAMIC is undefined..

Thanks Alexander, I'm guessing you've hit this in your builds as
LIBTRACEEVENT_DYNAMIC is defined. I've set out a fix in:
https://lore.kernel.org/lkml/20221129192924.1580537-1-irogers@google.com/T/#u

Thanks,
Ian
