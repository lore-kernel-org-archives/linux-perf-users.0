Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD12EEE49A0
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Aug 2023 05:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjHYF0O (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Aug 2023 01:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjHYFZy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Aug 2023 01:25:54 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CFA1BE2
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Aug 2023 22:25:52 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-34bae839382so90305ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Aug 2023 22:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692941152; x=1693545952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbdGy0NmHQroxMMpjOSAleHrdCZ6MJ+r3ixMQrh1nmk=;
        b=tnZE8XBXKivLRJkdILuCf1Eetego414ME4erJjEJipSKdJAiQWnKKl9iNI7qjM5EcO
         PlHG9Q+gGd+mLt/UtIXePpcYrzDzWHIWsKBDEIlcM+ZAVoK0PqR2xdjJfHx0n+t8yqWp
         Wl/m4HZ7lKy4oDXBrQhhuAt77fXwbdMFNlYpOprtN9ceLx3htENxWc+vfdrhUdHDozjO
         D1urDRk5LSqZhgoi5eiOko9hYUGZuYkjC3J+ruq8qA9MSr0DCJNQeTy5+p8WD8RJAmWn
         W2d8bQ+DkGAue+aBCFXW7g8VOOi4CfWulbX4Rwbzxmk5Bm9ETAxDnDMgyJ+P2BVEYACJ
         mr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692941152; x=1693545952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AbdGy0NmHQroxMMpjOSAleHrdCZ6MJ+r3ixMQrh1nmk=;
        b=TT1C7VjZ7xbsCPR7wAimroqOgqDqDWgrvVcdWLz2tbMIw/RLSLnBBNSKoIqkYBldKC
         aiOrkkCtAqefI5aZ80vvuAMJtvNCH8fYeGOR5TOYvOmZkNRnSJzqTcyrAL//Soy7weA1
         fhVB+AxRVldDp3eKS3QTWpvRftlX21WpF80pFMqzYAQtoI/rE3WNGaFqe1AmTulzihFW
         CHRUJMmshEHRpt2QrW0SIUqN24hix6UMVSH7FehVoa4jIevpVau+KObozFLkVgWEWIZa
         Emd7R/W9sz8/rQKvK0Tq4Lgg44gGBVa4PKf/rw6YgqAIxc3ACCE4uYpzIiajQTMHnIfH
         eUig==
X-Gm-Message-State: AOJu0YzhQO64etOBJbfQhHDb71G6DGUbmyyzHBkXMUqHBcrT9aD2g0qQ
        rAnXYW5g28SKu1+kR4BNyov78kb+KkoqrHFv8v+uQA==
X-Google-Smtp-Source: AGHT+IFwPeXziNWN3JhhxvfmXcT4+Bs8t2ebj8nQzybID13kwUqfImpxSn69Clr1+0HvL3kZ0R6ZBvtLvfXtrmSPNgs=
X-Received: by 2002:a05:6e02:b2d:b0:349:432c:329a with SMTP id
 e13-20020a056e020b2d00b00349432c329amr98119ilu.23.1692941152104; Thu, 24 Aug
 2023 22:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230821012734.18241-1-yangjihong1@huawei.com> <20230821012734.18241-8-yangjihong1@huawei.com>
In-Reply-To: <20230821012734.18241-8-yangjihong1@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 24 Aug 2023 22:25:40 -0700
Message-ID: <CAP-5=fUwkL7c0kSR5YRTDDEJmNweMx3U1Xfxovvs5-MFc2WJwg@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] perf test: Add perf_event_attr test for record
 selected CPUs exclude_user
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
> If all (non-dummy) evsel have exclude_user, system_wide sideband is not
> needed. Add this test scenario.
>
> Test result:
>
>   # ./perf test list 2>&1 | grep 'Setup struct perf_event_attr'
>    17: Setup struct perf_event_attr
>   # ./perf test 17 -v
>    17: Setup struct perf_event_attr                                    :
>   --- start ---
>   test child forked, pid 720198
>   <SNIP>
>   running './tests/attr/test-record-C0-all-kernel'
>   <SNIP>
>   test child finished with 0
>   ---- end ----
>   Setup struct perf_event_attr: Ok
>
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> Tested-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  .../perf/tests/attr/test-record-C0-all-kernel | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 tools/perf/tests/attr/test-record-C0-all-kernel
>
> diff --git a/tools/perf/tests/attr/test-record-C0-all-kernel b/tools/perf=
/tests/attr/test-record-C0-all-kernel
> new file mode 100644
> index 000000000000..2d7549277c1e
> --- /dev/null
> +++ b/tools/perf/tests/attr/test-record-C0-all-kernel
> @@ -0,0 +1,32 @@
> +[config]
> +command =3D record
> +args    =3D --no-bpf-event --all-kernel -C 0 kill >/dev/null 2>&1
> +ret     =3D 1
> +
> +[event:base-record]
> +cpu=3D0
> +
> +# no enable on exec for CPU attached
> +enable_on_exec=3D0
> +
> +# PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
> +# PERF_SAMPLE_PERIOD | PERF_SAMPLE_IDENTIFIER
> +# + PERF_SAMPLE_CPU added by -C 0
> +sample_type=3D65927
> +
> +# Dummy event handles mmaps, comm and task.
> +mmap=3D0
> +comm=3D0
> +task=3D0
> +
> +# exclude_user for all-kernel option
> +exclude_user=3D1
> +
> +[event:system-wide-dummy]
> +
> +# system_wide is not need for all (non-dummy) events have exclude_user
> +cpu=3D0
> +
> +# exclude_user for all-kernel option
> +exclude_user=3D1
> +exclude_kernel=3D0
> --
> 2.30.GIT
>
