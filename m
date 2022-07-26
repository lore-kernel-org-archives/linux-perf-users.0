Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F590C00140
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Jul 2022 16:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiGZQ5J (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 26 Jul 2022 12:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiGZQ5J (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 26 Jul 2022 12:57:09 -0400
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E37A2A71A;
        Tue, 26 Jul 2022 09:57:06 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id c3so14221739vsc.6;
        Tue, 26 Jul 2022 09:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NI6yWHtpqaqV6N9zf15hGVC4lywK5v9X+zT0pxAIPRk=;
        b=ztzxZoKp3dtcKGRWsV9nZ812625EgjJuQ1kKLB8WG457YHmne19Ogt7/sdTE0/olcz
         6X0a9OhkKsjuFLuvGOGxsV3I9+6xUrHLGzEPl9TTYT7fgIIjgzmuG8flrpfUzGv4022b
         CSAGT0GHG+mt7KAs5PVLujYcOpapD7d5N+FLkmkW0blxdC5qzSli0R7OXjT+sxJnKtBm
         O3Irn9nSLZDQZsw7G610gKm7CgpL21bGXHR5Ct4pHYnmTDBdNoBdMbFzCImsGnnnVjWc
         Lxj3PfI8PgjGxp3W60hoCDW6//wa9jcK1kvJGpVxuETik+KmYec9GaYQ2Lj/iN3wEc9T
         xPdA==
X-Gm-Message-State: AJIora8P7MeO/NNnqe5c42uB5+7YNOLlh1wf7xL16NBJsiP0gVFzWqLh
        Ij9y0g5T8u1PmxSDPGmfoijFbOVOQeJgqjYGuIE=
X-Google-Smtp-Source: AGRyM1sMUwZtonS+KStbsSP3Gc+vXL7V2hRpgkxCk6qdCNZ3Lm0qEZRgnEBhiblWlxEKK8kdt8+AeFOtzRhPbUEn3Mw=
X-Received: by 2002:a67:c886:0:b0:358:539d:e1a4 with SMTP id
 v6-20020a67c886000000b00358539de1a4mr3984652vsk.78.1658854625094; Tue, 26 Jul
 2022 09:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220725104220.1106663-1-leo.yan@linaro.org> <Yt68AZA2VV9d02xZ@kernel.org>
In-Reply-To: <Yt68AZA2VV9d02xZ@kernel.org>
From:   Alan Bartlett <ajb@elrepo.org>
Date:   Tue, 26 Jul 2022 17:56:49 +0100
Message-ID: <CA+_WhHyZZC=3gtzetEAQQrjtGujHmY5azwtQNZEc90gyOAwUDg@mail.gmail.com>
Subject: Re: [PATCH] perf scripts python: Let script to be python2 compliant
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Akemi Yagi <toracat@elrepo.org>, ElRepo <contact@elrepo.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, 25 Jul 2022 at 16:51, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Mon, Jul 25, 2022 at 06:42:20PM +0800, Leo Yan escreveu:
> > The mainline kernel can be used for relative old distros, e.g. RHEL 7.
> > The distro doesn't upgrade from python2 to python3, this causes the
> > building error that the python script is not python2 compliant.
> >
> > To fix the building failure, this patch changes from the python f-string
> > format to traditional string format.
>
> Thanks, applied.
>
> - Arnaldo

Leo / Arnaldo,

Applying the patch on top of -5.19-rc8 fixes the problem that we (the
ELRepo Project) experienced when attempting to build on RHEL7.

So --

Tested-by: Alan Bartlett <ajb@elrepo.org>

Hopefully you will get it to Linus in time for -5.19 GA.

Thanks,
Alan.
