Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A043C3DA66
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Aug 2023 05:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbjHYF2z (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Aug 2023 01:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbjHYF2x (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Aug 2023 01:28:53 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA8B1991
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Aug 2023 22:28:51 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40c72caec5cso185871cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Aug 2023 22:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692941330; x=1693546130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMl8Omhipd/N5y5b2upf5FElBLBrPgcWq16uQRlX0xw=;
        b=jI81O/l34UbvbzT/GP8XdMkgJXHw8v66psq1ji1sBf/wO19Gh7LU2G+qRp2X+J4Uxb
         xQYiInOP+SAGE5UQpg4AuDPxFDR7JA1W0XnnEok6KenvWMF/QsDPZcY57hxyhtNcPupb
         kAL2LjLsILSvIg5StEIC6WP49n1GVnnXiRq8OEkcUoTd93UhCc0X9Wd5jFYrQon13IOv
         Ur8a3/rmZlNqLA8QUJwtc0iTQSfczCeIf/SIHyMraEcAsH7VRMqseRIZ9kGm6oGNQNdp
         7LrPljTSMsufjIlZ1baTxB/VRfmuE3u5YIKGyDG9MxIrUdzu2EYrL1STRhWMTa8JJ3X5
         nlpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692941330; x=1693546130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMl8Omhipd/N5y5b2upf5FElBLBrPgcWq16uQRlX0xw=;
        b=e6Bg4Y9iCTKVMLSiEopkYHHNTOz3oYFsxaZYm+46Dw332l6bJRH3cj3aNg9Qgyzf2L
         TvSjTCVH/kqdHtComyZFzifCssBFZL8V7w4Hd/X5AgovNXbtnuJXHYTYVxEWr5sSELd8
         jhpC3RqLC2MctHq1nLPn8PYsr1wKc36Otfm3woXz2CXqIpRvy+obaw99zcKbPejNrohx
         DQLjwNEvYQsQZkVqL5Pb58PXTueMX1SPsktBlxewIURvJ5OiztFxnXVGb4yOq6y0MHZh
         G23DpyO4KqUePB+UheH8m5ubEERsEhLZNYe0DI/qT6lu5oi7F12GG0WqRW9d5d65qGNv
         a4Ug==
X-Gm-Message-State: AOJu0YzmBUQVsRqBj4QCRciAV0VOEPLXAUW2H1YalgLa9WTRxsNdk5FD
        iXrV40CpzWJEOWjgB2dpQnDomHZd0q25vwXmg3qyIg==
X-Google-Smtp-Source: AGHT+IFNB9i2iL8k74PNka05h9+oD74/eZNjxGgDIVoAlnvyDgG3jQSmf/MpCz+pyGjqlZLZM4ZhPysGs2uONhvNqDM=
X-Received: by 2002:a05:622a:89:b0:40f:c60d:1c79 with SMTP id
 o9-20020a05622a008900b0040fc60d1c79mr171969qtw.28.1692941330219; Thu, 24 Aug
 2023 22:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230821012734.18241-1-yangjihong1@huawei.com> <20230821012734.18241-7-yangjihong1@huawei.com>
In-Reply-To: <20230821012734.18241-7-yangjihong1@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 24 Aug 2023 22:28:39 -0700
Message-ID: <CAP-5=fW+ybe3GStU2ttUKH4BSwiyhS=zf6uHUORVEXhexFJxtQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] perf test: Add test case for record sideband events
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, james.clark@arm.com,
        tmricht@linux.ibm.com, ak@linux.intel.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Aug 20, 2023 at 6:30=E2=80=AFPM Yang Jihong <yangjihong1@huawei.com=
> wrote:
>
> Add a new test case to record sideband events for all CPUs when tracing
> selected CPUs
>
> Test result:
>
>   # ./perf test list 2>&1 | grep 'perf record sideband tests'
>    95: perf record sideband tests
>   # ./perf test 95
>    95: perf record sideband tests                                      : =
Ok
>
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> Tested-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/tests/shell/record_sideband.sh | 44 +++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100755 tools/perf/tests/shell/record_sideband.sh
>
> diff --git a/tools/perf/tests/shell/record_sideband.sh b/tools/perf/tests=
/shell/record_sideband.sh
> new file mode 100755
> index 000000000000..2ecf00011cb1
> --- /dev/null
> +++ b/tools/perf/tests/shell/record_sideband.sh
> @@ -0,0 +1,44 @@
> +#!/bin/sh
> +# perf record sideband tests
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +err=3D0
> +perfdata=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)

Could you add some kind of cleanup on trap function like:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/shell/record.sh?h=3Dperf-tools-next#n26
It'd be okay to do this as a follow up patch.

Thanks,
Ian

> +
> +can_cpu_wide()
> +{
> +    if ! perf record -o ${perfdata} -BN --no-bpf-event -C $1 true 2>&1 >=
/dev/null
> +    then
> +        echo "record sideband test [Skipped cannot record cpu$1]"
> +        err=3D2
> +    fi
> +
> +    rm -f ${perfdata}
> +    return $err
> +}
> +
> +test_system_wide_tracking()
> +{
> +    # Need CPU 0 and CPU 1
> +    can_cpu_wide 0 || return 0
> +    can_cpu_wide 1 || return 0
> +
> +    # Record on CPU 0 a task running on CPU 1
> +    perf record -BN --no-bpf-event -o ${perfdata} -C 0 -- taskset --cpu-=
list 1 true
> +
> +    # Should get MMAP events from CPU 1
> +    mmap_cnt=3D`perf script -i ${perfdata} --show-mmap-events -C 1 2>/de=
v/null | grep MMAP | wc -l`
> +
> +    rm -f ${perfdata}
> +
> +    if [ ${mmap_cnt} -gt 0 ] ; then
> +        return 0
> +    fi
> +
> +    echo "Failed to record MMAP events on CPU 1 when tracing CPU 0"
> +    return 1
> +}
> +
> +test_system_wide_tracking
> --
> 2.30.GIT
>
