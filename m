Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4CBEB64DA
	for <linux-perf-users@archiver.kernel.org>; Wed, 12 Jul 2023 17:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjGLRfa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 12 Jul 2023 13:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjGLRf3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 12 Jul 2023 13:35:29 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1FC196
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jul 2023 10:35:28 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-403b622101bso19251cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jul 2023 10:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689183327; x=1691775327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUHKr25mKMwzaetspTzJuKob1qSWy270LwGgiT27nos=;
        b=TT7riyt5+IvDbDOfbsoXanuG80TLe5nPyZqepV674ZPQiHmhP0lWm8Ni1ivIJJzy3r
         xKaSEKI9jmuh16/1F45sZqXSOMinTrYaOQbOZsfrxPpmRa61rw5po7nLWJ3tWdm/JFLN
         2Ez6Q9HTMfC59bGFaO02aGX4a09WjWpxLoy4uqw/nZgkE5zAF4g53nHxEdgeqlhRFHsU
         pPCsRPhco0nePVTlwf7cXjBfp2vokXqTmh2Sp4mYvSpnJoVzoHQazn7h4RDpXXq4W0yk
         /DLhStMd3GuUZMYnHbOaETGU9PIgDzirhSQyjeQsE+WDGB6ZKrJxxdxjUC+qqdh/wgIr
         4tcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689183327; x=1691775327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bUHKr25mKMwzaetspTzJuKob1qSWy270LwGgiT27nos=;
        b=BHPJ650/AMBc9o7l79BP5UQ3N3kyjPTqmuu9x4rkAFeX59aivxXqpJ65TlHokNSfYK
         ugnLOmhi7yQVJ7k7nWTn3Cu20LTnpLAK5rq1A+zBznlv4f0ayio2awImMT4n8Duh9176
         JyTvTDKUj2gbTBrBpdpdQAbT3w25S94s5a0mRhQ2Z885bEyD5JV/1xHCfDTjzJvV126z
         7IgPiLBPPfGcrOabz15stqmdfcO8s7xXF5Xn50W200F5kdpjmXJqpdQ/PgOkJyuTU5c0
         4hWauVxnsTJzZAjVmrxnnmLxnjCg/Sz8CHj6vZtr8mmobLa8UuA5ujYA0qjY0qUVV6+X
         qVpA==
X-Gm-Message-State: ABy/qLYdiJWADuhcOKrsBzrxY58ejFxPINEcxP33rcixDw6C4TUfAb5s
        9srsAFlK7izFZ4cAFK0/0fnnJh/zF3rL2zqo9XQcyA==
X-Google-Smtp-Source: APBJJlE8YxTv63Dw3FssBBmef8iBVEWuD9nCrCA+1iylTfq5Zt3O2SmJepmIDCk+9XDAzaTKpEVg/a2GkqjHm4/bxOc=
X-Received: by 2002:a05:622a:1994:b0:3ef:5f97:258f with SMTP id
 u20-20020a05622a199400b003ef5f97258fmr328491qtc.16.1689183327385; Wed, 12 Jul
 2023 10:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689024635.git.anupnewsmail@gmail.com> <8b80f803ffbed4c84c0c63b3e1dae155a66ac1f2.1689024635.git.anupnewsmail@gmail.com>
In-Reply-To: <8b80f803ffbed4c84c0c63b3e1dae155a66ac1f2.1689024635.git.anupnewsmail@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 12 Jul 2023 10:35:16 -0700
Message-ID: <CAP-5=fVtfHM0NJ-7ogR1wvu3bUMR+2a1o-ndRPT_-BD1o5xdgg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] scripts: python: Implement add sample function and
 return finish
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jul 10, 2023 at 4:14=E2=80=AFPM Anup Sharma <anupnewsmail@gmail.com=
> wrote:
>
> The addSample function appends a new entry to the 'samples' data structur=
e.
>
> The finish function generates a dictionary containing various profile
> information such as 'tid', 'pid', 'name', 'markers', 'samples',
> 'frameTable', 'stackTable', 'stringTable', 'registerTime',
> 'unregisterTime', and 'processType'.
>
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> ---
>  .../scripts/python/firefox-gecko-converter.py | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools=
/perf/scripts/python/firefox-gecko-converter.py
> index 39818a603265..6c934de1f608 100644
> --- a/tools/perf/scripts/python/firefox-gecko-converter.py
> +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> @@ -106,11 +106,36 @@ def process_event(param_dict):
>                 }
>                 stringTable =3D []
>
> +               def addSample(threadName, stackArray, time):

I think these aren't following general naming conventions:
https://peps.python.org/pep-0008/#function-and-variable-names
So use thread_name, stack_array.

> +                       responsiveness =3D 0
> +                       samples['data'].append([stack, time, responsivene=
ss])
> +
> +               def finish():
> +                       return {
> +                               "tid": tid,
> +                               "pid": pid,
> +                               "name": name,
> +                               "markers": markers,
> +                               "samples": samples,
> +                               "frameTable": frameTable,
> +                               "stackTable": stackTable,
> +                               "stringTable": stringTable,
> +                               "registerTime": 0,
> +                               "unregisterTime": None,
> +                               "processType": 'default'
> +                       }
> +
> +               return {
> +                       "addSample": addSample,
> +                       "finish": finish
> +               }

I think the use of a dictionary here isn't idiomatic. Rather than use
a dictionary I think you can make a class Thread, then have functions
passed self called addSample and finish. So:

class Thread:
  def addSample(self, thread_name: str, stack_array: list[...], time: int):
     responsiveness =3D 0
     self.samples['data'] ...
...
thread.addSample(threadName, stack, time_stamp)

Should samples be its own class here?

Thanks,
Ian

> +
>         def _addThreadSample(pid, tid, threadName, time_stamp, stack):
>                 thread =3D thread_map.get(tid)
>                 if not thread:
>                         thread =3D _createThread(threadName, pid, tid)
>                         thread_map[tid] =3D thread
> +               thread['addSample'](threadName, stack, time_stamp)
>
>         # Extract relevant information from the event parameters. The eve=
nt parameters
>         # are in a dictionary:
> --
> 2.34.1
>
