Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA21EB64D7
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jun 2023 20:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjFMURz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jun 2023 16:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjFMURy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jun 2023 16:17:54 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60540E5
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 13:17:53 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3f98276f89cso4001cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 13:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686687472; x=1689279472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXZYbcN4lT4MwovmyfDQYwlkMbjb1em4SMZ8xBlxtCs=;
        b=7P+JWTqo/e3oHiBcBjVlnIK4cD2+AO1Irn4+L5r6prMwkbhG4VHXGoRVMUd8rfypWE
         xqSMBWVx+c6OMPd4pisCGsJSOVVuK5AUAFx4uK/dnhE1pymPHMNlHW+POxTYaxPVdYSb
         3+82UqxGWVruw7f+dcplHLVmXLuKV1sNEKHxEVypwHPKiwv/tlhf+RjddK8CUcjwvN06
         lrC8J359WkUxC/ocI1ya1q6mroKPB/Y/xDmmFU/rhoGgFeax8hZkoY7iyd+8ECYq9iX3
         wvQr2xbykQTUq+8xUWFuVtfphyzv8pxdGQ6Ol7ttxU4J0JNbtjU6X525A+NeGR3ENWTT
         q6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686687472; x=1689279472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXZYbcN4lT4MwovmyfDQYwlkMbjb1em4SMZ8xBlxtCs=;
        b=PupK/yrYl2mrnTBZfbC05rzL8e9kiH0AjRriLTHfkYdNCZsoF4nVB5iPbaDU3prBL1
         /7PK1kGRJhwrbFn16tyoHSaVHTVumBSPZX1P1zEs5lN2R+r5r6FxXhDPHngFhY2DEnmi
         lGCpuVmPMPBH1YHpmB06nRgl82uiySKypLBrdTHMIFoSg9SqZNb9zxhnCxJ9Tbu8SA6O
         IMI0o6J5119+uIhL0TS2N9fRuQiQoHWOaEZv+JSn30KIg+qHnCzFNoHG0fvYeMD7RcmF
         p1yYZ9Cs07UPOS8N/KEUdhYcSpjaWD/hq3K6nBeQDddOU7NW5kjwfihfAhAJQtY8LtJb
         fTGA==
X-Gm-Message-State: AC+VfDxRZ2eBNXHQY/x06O6PXwa2sRwhGFsJmbRUKWAv1POvwRMFv3EI
        C+8VRtEnoodI9dnYMEErnwiBPEXCUFQnolYrOSgU/A==
X-Google-Smtp-Source: ACHHUZ7jXI3SsKtoyWPHN02Hr9RxZp6g80e3/Y77CE8muNDSa5vHp/cZjeHyLgrXhyoyw/ySM252aJDwifFsHNTU3xc=
X-Received: by 2002:ac8:7e8b:0:b0:3f9:a986:f3a4 with SMTP id
 w11-20020ac87e8b000000b003f9a986f3a4mr44756qtj.25.1686687472411; Tue, 13 Jun
 2023 13:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230607162700.3234712-1-kan.liang@linux.intel.com> <20230607162700.3234712-8-kan.liang@linux.intel.com>
In-Reply-To: <20230607162700.3234712-8-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 13 Jun 2023 13:17:41 -0700
Message-ID: <CAP-5=fX9E0g28spjC2k_YUKz6Vm2AKe_1VLJoapStHY6juDX1A@mail.gmail.com>
Subject: Re: [PATCH 7/8] pert tests: Support metricgroup perf stat JSON output
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 7, 2023 at 9:27=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> A new field metricgroup has been added in the perf stat JSON output.
> Support it in the test case.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/lib/perf_json_output_lint.py | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/=
perf/tests/shell/lib/perf_json_output_lint.py
> index b81582a89d36..5e9bd68c83fe 100644
> --- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
> +++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
> @@ -55,6 +55,7 @@ def check_json_output(expected_items):
>        'interval': lambda x: isfloat(x),
>        'metric-unit': lambda x: True,
>        'metric-value': lambda x: isfloat(x),
> +      'metricgroup': lambda x: True,
>        'node': lambda x: True,
>        'pcnt-running': lambda x: isfloat(x),
>        'socket': lambda x: True,
> @@ -70,6 +71,8 @@ def check_json_output(expected_items):
>          # values and possibly other prefixes like interval, core and
>          # aggregate-number.
>          pass
> +      elif count !=3D expected_items and count >=3D 1 and count <=3D 5 a=
nd 'metricgroup' in item:
> +        pass
>        elif count !=3D expected_items:
>          raise RuntimeError(f'wrong number of fields. counted {count} exp=
ected {expected_items}'
>                             f' in \'{item}\'')
> --
> 2.35.1
>
