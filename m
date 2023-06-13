Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B463C7EE2F
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jun 2023 00:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjFMAEh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 12 Jun 2023 20:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjFMAEg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 12 Jun 2023 20:04:36 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E192A1718
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jun 2023 17:04:34 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f9a81da5d7so119381cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jun 2023 17:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686614674; x=1689206674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFJb2DYUH4SPc/Q+szSqLA/RcQwAqBDcfYRno+8pMbs=;
        b=qVHT92ewJyouaKu6MMLoTf39mDMIZMOAjBtx0r7Jpbqsr3ldbcktmvTft9a5QCGjde
         vWS5CAJ4iUqojEq/8qIYpx+m1sF0a1hPNA75rzxp9buSPrUX4ARPJ2Og6xS3GTloDqsj
         AFQBbSTeojJHas0T0aGzDBfqctU3jxn+U1JhxWREccfGwEIl+LqNrZXQxoC5mzPsw2DE
         egLEnHH5iFUzlQHUpU4df6W+KK/lLzfKk2bj+KII22cyiA+1R1v+AJ5+J83mRrnrU58a
         MDVpW7Y9qwOBiWFVG7eovI5AjG1p3ZnEX9zrvRMo6mkSimwQDd5tnNogQg+qbRz8eiqX
         ybSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686614674; x=1689206674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFJb2DYUH4SPc/Q+szSqLA/RcQwAqBDcfYRno+8pMbs=;
        b=JhQ/mzIQ/08+S+xl51PxvTAvu7b8ZaDmkenajHktDCB4h89KmtwNaj/sy8Gt5zN0BA
         1OjFunys4mk7bz60h6nIFkI+r4IDNVCr8yJzJBLbNfCz3ELnDRIh5anU5fMn48nvgUgC
         Sf1dmRNGf5207/RDyNlqw9NBinzWWxr6dg7vhTLhu9fJid8Q3woMOmhWKGO29Zq67LUf
         /LfPCXL5MM1jGo3f/qBubGRDQotIM4XLrm5rbKUjFOuGFItlwheMgwN9A5bjQY/U2lfc
         9fno3WBS5scUyFXRFm4KZb/KjeZlTpl9CSGg/twZKEPGDS16C/AytX7O0UHQG7cb4v6L
         0xJA==
X-Gm-Message-State: AC+VfDxX7XwoB13UK/7JM8rkMUp9SAX9G1obw5Xn8G8L91xDoP6ECa/X
        hLfZZLRRsi8AljN7ZwgehevYITXfAD+l5k0JB61kFA==
X-Google-Smtp-Source: ACHHUZ6fIxnK/WgFoSTz0SP44PqYLAX1txVLnPtVREFcGCbCCxdcCF0KcpSDb4x58o/UgMZja+eg3H706VCHFM601Wg=
X-Received: by 2002:a05:622a:100c:b0:3ef:3361:75d5 with SMTP id
 d12-20020a05622a100c00b003ef336175d5mr1249qte.11.1686614673886; Mon, 12 Jun
 2023 17:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230609162625.100897-1-weilin.wang@intel.com>
In-Reply-To: <20230609162625.100897-1-weilin.wang@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 12 Jun 2023 17:04:22 -0700
Message-ID: <CAP-5=fVixzBLLiWnim8x6qcDOKH7uVfEWojTCP_H531Fhy7j-g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add metric value validation test
To:     Weilin Wang <weilin.wang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 9, 2023 at 9:26=E2=80=AFAM Weilin Wang <weilin.wang@intel.com> =
wrote:
>
> This is the second version of metric value validation tests.
>
> We made the following changes from v1 to v2:
>  - Add python setting check [Ian]
>  - Skip non-Intel architectures [Ian]
>  - Rename allowlist to skiplist [Ian]
>
> v1: https://lore.kernel.org/lkml/20230606202421.2628401-1-weilin.wang@int=
el.com/

Thanks Weilin,

when I try the test on my Tigerlake laptop I encounter an error:

```
$ sudo perf test 105 -vv
05: perf metrics value validation                                   :
--- start ---
test child forked, pid 1258192
Launch python validation script
./tools/perf/tests/shell/lib/perf_metric_validation.py
Output will be stored in: /tmp/__perf_test.program.J2u5c
Starting perf collection
Long workload: perf bench futex hash -r 2 -s
perf stat -j -M tma_mixing_vectors -a true
...
perf stat -j -M tma_retiring,tma_light_operations,tma_heavy_operations
-a perf bench futex hash -r 2
-s
# Running 'futex/hash' benchmark:
Run summary [PID 1258651]: 8 threads, each operating on 1024 [private]
futexes for 2 secs.

Averaged 953280 operations/sec (+- 1.07%), total secs =3D 2
Traceback (most recent call last):
 File "/home/irogers/kernel.org/./tools/perf/tests/shell/lib/perf_metric_va=
lidation.py",
line 571,
in <module>
   sys.exit(main())
            ^^^^^^
 File "/home/irogers/kernel.org/./tools/perf/tests/shell/lib/perf_metric_va=
lidation.py",
line 564,
in main
   ret =3D validator.test()
         ^^^^^^^^^^^^^^^^
 File "/home/irogers/kernel.org/./tools/perf/tests/shell/lib/perf_metric_va=
lidation.py",
line 522,
in test
   self.pos_val_test()
 File "/home/irogers/kernel.org/./tools/perf/tests/shell/lib/perf_metric_va=
lidation.py",
line 152,
in pos_val_test
   if val < 0:
      ^^^^^^^
TypeError: '<' not supported between instances of 'str' and 'int'
test child finished with -1
---- end ----
perf metrics value validation: FAILED!
```

Could you take a look?

Thanks,
Ian

> Weilin Wang (3):
>   perf test: Add metric value validation test
>   perf test: Add skip list for metrics known would fail
>   perf test: Rerun failed metrics with longer workload
>
>  .../tests/shell/lib/perf_metric_validation.py | 574 ++++++++++++++++++
>  .../lib/perf_metric_validation_rules.json     | 398 ++++++++++++
>  tools/perf/tests/shell/stat_metrics_values.sh |  30 +
>  3 files changed, 1002 insertions(+)
>  create mode 100644 tools/perf/tests/shell/lib/perf_metric_validation.py
>  create mode 100644 tools/perf/tests/shell/lib/perf_metric_validation_rul=
es.json
>  create mode 100755 tools/perf/tests/shell/stat_metrics_values.sh
>
>
> base-commit: 7cdda6998ee55140e64894e25048df7157344fc9
> --
> 2.39.1
>
