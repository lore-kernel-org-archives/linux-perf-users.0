Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF716C761A6
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 Apr 2023 13:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbjDDNlL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 4 Apr 2023 09:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjDDNlJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 Apr 2023 09:41:09 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA0F49F9
        for <linux-perf-users@vger.kernel.org>; Tue,  4 Apr 2023 06:40:42 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-3e390e23f83so106641cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Apr 2023 06:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680615640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZcpONyrq35k/KMGNdDERzaapkisIpNvWic8pI9VCIY=;
        b=M2vzh9W51JaG8iKSKF8epT+/9MuS5c0JUkok1vh6Q/vtNkZR9TSdEjK+TqBG0JRMLn
         H4+IwrSKmC2N8KHS5aZzgh5b+4MXgQfKF9Ln1stvVacxYNm+Y5v8dNhuaVeCNzuKHmV5
         rDZ4w/cLX6nGpxgmPb2ugH8fqBb+0t0ULHz5dQWIjejTeQtZ7mRnbGs38qF5gaEVnj9f
         j0/1o9Y7fQ00da59pAZwWuaUOu0g8blXl2FhUAuw80VTm2cNi8xBrLJDj0CPGNw5b+v7
         muBV1O2EBXDZY4Jd5G9y4ZJuSrQKQTSUC8TqD8Nzt+lECl4W3W1ULzmYxqP9rDt/A3iO
         m1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680615640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZcpONyrq35k/KMGNdDERzaapkisIpNvWic8pI9VCIY=;
        b=SpeCytHH/OauGLRM6qqV3LFuS2Jt29eDfqg9modKndybNRNq3ufpBEK4g011cKlI/H
         XeDYmsdjklPKkVOdIlZuaUGOFGDQ1WqlcqG4Zr5lLdXVORp1IxOhn5jTvd1FGaMnPP12
         IfCKmQRRBUXScr+K6BN7HdWsaMztnxmZt6r0fasdkgaceh+Ab0a4qVJtAjIanu5eVfT+
         V3W74zAAszwLfoS84qGNoYdg8EIIqKy1924GHRi2nxu6i5NPeh/Hmgk3Xwp71e+kPr7C
         DoJAsHaO1rP1qcEhj8e9ruloIKKNme3meu8KgyKgneT8hBdxMbclctocvHtyeAMvgGk+
         ZyHA==
X-Gm-Message-State: AAQBX9efCiq0NNLXDXW+M1rvYf5epoO2G9/e6qugPQ7WcYKRBbFsp0Xs
        Xv6KQprjsQP4pMhl6xtxcbu/FdkfigmWAh4QaCJbdQ==
X-Google-Smtp-Source: AKy350YAuwojFrWhhma/x+GD/OWGo8vlOCnjWZlVtwOH4/NoK6blbsC9wr688+5E4xG/a37J+g7dpI6m6JPF5D2cOZM=
X-Received: by 2002:ac8:574c:0:b0:3bf:c406:3a5f with SMTP id
 12-20020ac8574c000000b003bfc4063a5fmr247495qtx.7.1680615640024; Tue, 04 Apr
 2023 06:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230403172031.1759781-1-irogers@google.com> <ZCvT+OvZKQqsw8mh@krava>
 <ZCwabKeceQUqgtAd@kernel.org>
In-Reply-To: <ZCwabKeceQUqgtAd@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 4 Apr 2023 06:40:26 -0700
Message-ID: <CAP-5=fX1Cuoswr3dbDjt8A39OMj=hHnz0D5imHp1p6owNuUimQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf pmu: Make parser reentrant
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Apr 4, 2023 at 5:39=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Tue, Apr 04, 2023 at 09:38:32AM +0200, Jiri Olsa escreveu:
> > On Mon, Apr 03, 2023 at 10:20:31AM -0700, Ian Rogers wrote:
> > > By default bison uses global state for compatibility with yacc. Make
> > > the parser reentrant so that it may be used in asynchronous and
> > > multithreaded situations.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
>
> So this clashed with Namhyung's recent series, please update it using
> what is in tmp.perf-tools-next.
>
> - Arnaldo

I dealt with the merge conflict in v2 [1]. I didn't add Jiri's
acked-by just because there was a small change in
perf_pmu__format_parse.

Thanks,
Ian

[1] https://lore.kernel.org/lkml/20230404133630.1985739-1-irogers@google.co=
m/
