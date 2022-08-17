Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939A9C25B08
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Aug 2022 13:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238823AbiHQNCj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 17 Aug 2022 09:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236051AbiHQNCj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 Aug 2022 09:02:39 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236D85007E
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Aug 2022 06:02:38 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id z185so3516666vsb.4
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Aug 2022 06:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=JEpY0RlSeNKZEJVlprf831gSjjfs90GuJUkUulGJpXE=;
        b=HhwjHoELRn0n2dtUiR/VcsdJqCy/a2xBD+R5nenQKQWxOlIESLF9n0qlR5EOjKBR3v
         b+TbLF79FlfjMmtuS09ym0DOoszsDhtR5AJQcy0rT0UdaSru5MqiSn2wcvCBzWrh4wTr
         dTDdABjI278o6rNHK4MvpfgEAKNJW8qfUzlPn5PY7MkJKImp9xbxpRs6ziWQYKK0j6/M
         JDW+ebvCOExqVRUDf7d3riYGFI2ulJOk+J/LN/ooYQdHGgFWZWLSLb2UyBRiMTjOVKsX
         MipcEUK8kn7R/tyKniGxuOk2MGg83iFMqXy+7mP/t30zVUu6pcJmhib6FWk+qAqYW/Gz
         ompw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=JEpY0RlSeNKZEJVlprf831gSjjfs90GuJUkUulGJpXE=;
        b=r7+9qTFiBgSYYwiaVKWEVjgUxlr/X7FZ4YZba2355rLWgRPYBquFyDu4tt1ggv7O7/
         AMJYGWAzOXp+eBaJeqguevGZWf7Ku9hyjRILYlsbz/KeqSNfLTVp8xHN3gHzlFTYg1q8
         ls2kc9Oa19VZ8BheqCifYoMQjKKQfgyAF9ue6Y9B31Phi+aro2soO3L/AK32fhWEJPuF
         Wdyh3vIb5dNLS4JRTc1/kYF44ODseUih2zQznlKQ9zsPrBlaF6QbLImPD2Ebz0FIjfsO
         pepAj45WT1iArstHgtUIQyZjl6QncJnjvhYI/Ro+WZ0Zp41K3Fbyua61HAncl8A36qdd
         fumg==
X-Gm-Message-State: ACgBeo1nFPC0XaxQb+na2nLtVVpXYC1u84oUhChEQT2z6pIOmTYqeSwZ
        tYImbwjEa2bUlQnIu/MbCfCkza+KmLb8GF/yTKXDEA==
X-Google-Smtp-Source: AA6agR5xZEq+JYJ8NeDjjkQ6b/O3OdnvHus5amnMCRh5iTGg+w3myZ+kESjCxE+ExhG3WsA3fIVF4kR6TVhJZ1Mn138=
X-Received: by 2002:a05:6102:ec7:b0:388:d2a2:41c5 with SMTP id
 m7-20020a0561020ec700b00388d2a241c5mr10069927vst.41.1660741357054; Wed, 17
 Aug 2022 06:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <cecae74c-6bb2-d7da-bce3-35772b6e3f8c@intel.com>
 <CAP-5=fXJtRVKuPA_xpa=jBzq66y5JMv+jmr1GFNzh-zQ-7j5QA@mail.gmail.com> <b42344bc-86f6-9047-b015-88ef3b58a619@intel.com>
In-Reply-To: <b42344bc-86f6-9047-b015-88ef3b58a619@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 17 Aug 2022 06:02:25 -0700
Message-ID: <CAP-5=fUq4N+X+3VMsT=he3Q9_4qHKkqxdPDcMdDE=_3qdV9aCg@mail.gmail.com>
Subject: Re: perf tools man pages on the web
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Aug 17, 2022 at 1:55 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 15/08/22 17:56, Ian Rogers wrote:
> > On Mon, Aug 15, 2022 at 5:05 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> Hi
> >>
> >> I notice man pages on man7.org e.g.
> >>
> >>         https://www.man7.org/linux/man-pages/man1/perf.1.html
> >>
> >> do not get updated every release, and I wondered if the perf tools
> >> man pages should also be under:
> >>
> >>         https://docs.kernel.org/tools/index.html
> >>
> >> Thoughts?
> >
> > Sounds good to me. I'm assuming it would be some kind of build step
> > that would take the man pages and add them to what linux-doc needs?
> >
> > Fwiw, there has been some effort to try to improve the wiki:
> > https://perf.wiki.kernel.org/index.php/Main_Page
> > For example, the useful links are now broken apart and have more
> > links, there is a work-in-progress glossary. Perhaps there can be some
> > guidance on what to capture and where.
>
> Speaking of the wiki, anyone know how to change the
> "Set $wgLogo to the URL path to your own logo image." image?

+1000

Someone at RedHat knows :-)

Ian
