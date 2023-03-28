Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0CFC76196
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Mar 2023 16:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjC1QPH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Mar 2023 12:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjC1QPG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Mar 2023 12:15:06 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BECE187
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Mar 2023 09:15:05 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3e390e23f83so132081cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Mar 2023 09:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680020104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+JetgBmJtGgZMghdtbRfsuzcfqlxlv1JoYdHsK6DCQ=;
        b=nORKWN0nz4mfudMSS7DGwfuQTEU1fpYW4Bf5VfcpPLP9V8Kf2armdHPubI9CqRVjXw
         Ah21i5Jp4dSet8Yhvj9V4JHM1PgG1NovH72EYjMolGLcRkEaFy/7uO6I1JvE2ouircur
         rkJjMbKCULDB/fyRJ4w8LApnGLnkpQv+Zv7TkJUVGdHYSPVVnzVqxhSqAHn7PAkE8Cv9
         2R9N47DDf7OBib3FNnp0nlOrrb8tQvdBqN/uuqIho09gYsYrRViep8kOLyZrjdyqvHfH
         tPoUGs6dLTTFGKM0YZFK3RLjE1CKUsnI4C/724+KB+osdgSuKRRpylvkEFZk1JQ255sT
         h6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680020104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+JetgBmJtGgZMghdtbRfsuzcfqlxlv1JoYdHsK6DCQ=;
        b=p3rUDSRbMI+sRIn/t50BEwRBzgFYIAzzjVcBL+3fAKNTUlvYgxSj4Z2MYBRXuoh1HN
         wwzTcDi6YC0zPFk3wDgGAyAvXbpqXpTI4Pfkbit91gqoA9mj70svs0gWnKwB8RdS5x3r
         yuZdO9MdxTsZlR0VBHniyc8UJ/BMzbSo7uda4qC8LO3g2AqbFN8pf/l452eZOakwjRru
         6DnhCNBroeI1od8WOZ336nxSs2KYuReluTZRSauHZ6Cl/SpJL5is46HqQD+1RT2nPsVr
         NWCj5kFGf0/fhcMct7KNuhurAy2h6rnLqp917K1bRTpIjmCPDQMmkVw1Wuy5PL/NKSzm
         O/Cg==
X-Gm-Message-State: AAQBX9efTL5J1zAeCNDdH3ctEbbw5khGdbTIA9AWWJ4vWyLDqjqZ237j
        KuTyRZLOKl49wnTkaP+ylFL3znUEdYqZXYEwY/atbA==
X-Google-Smtp-Source: AKy350a3htYo4uaYKOMVa123hgYVHpK//kvzmKXmedkuZdOYErtvNDfqsTRz2N7x0zz9qMcvWeSAn+BUwssIZo4ulDI=
X-Received: by 2002:ac8:58ca:0:b0:3db:1c01:9d95 with SMTP id
 u10-20020ac858ca000000b003db1c019d95mr532594qta.4.1680020103986; Tue, 28 Mar
 2023 09:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230328014058.870413-1-irogers@google.com> <fe36e38f-d42f-efe5-bb3c-cf802f8001a9@intel.com>
In-Reply-To: <fe36e38f-d42f-efe5-bb3c-cf802f8001a9@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 28 Mar 2023 09:14:51 -0700
Message-ID: <CAP-5=fV749yr+wMMYjm87ThnM7ESd+i4Ko=+6H+cuCNdKJM50A@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] Simplify linking against tools/perf code
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Raul Silvera <rsilvera@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Chengdong Li <chengdongli@tencent.com>,
        Denis Nikitin <denik@chromium.org>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Mar 28, 2023 at 6:24=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 28/03/23 04:40, Ian Rogers wrote:
> > When fuzzing something like parse-events, having the main function in
> > perf.c alongside global variables like input_name means that
> > input_name must be redeclared with the fuzzer function's
> > main. However, as the fuzzer is using the tools/perf code as a library
> > this causes backward linking reference that the linker may warn
> > about. Reorganize perf.c and perf.h to avoid potential backward
> > references, or so that the declaration/definition locations are more
> > consistent.
> >
>
> Seems like it could be a pain to maintain.
>
> Did you consider just adding:
>
> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> index 82bbe0ca858b..a75dd47d68ee 100644
> --- a/tools/perf/perf.c
> +++ b/tools/perf/perf.c
> @@ -456,6 +456,7 @@ static int libperf_print(enum libperf_print_level lev=
el,
>         return veprintf(level, verbose, fmt, ap);
>  }
>
> +#ifndef CUSTOM_MAIN
>  int main(int argc, const char **argv)
>  {
>         int err;
> @@ -576,3 +577,4 @@ int main(int argc, const char **argv)
>  out:
>         return 1;
>  }
> +#endif
>

It's possible. Would need to make the static functions not warn about
being declared and not used. I still think that just aligning
definitions and declarations yields the most expected code and will
lead to fewer problems in the long run.

Thanks,
Ian
