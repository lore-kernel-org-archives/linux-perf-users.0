Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1994C678D4
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Mar 2023 19:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCBTay (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Mar 2023 14:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBTax (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Mar 2023 14:30:53 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF39729430
        for <linux-perf-users@vger.kernel.org>; Thu,  2 Mar 2023 11:30:51 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id e13so168355wro.10
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Mar 2023 11:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677785450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdfkaCxTTajRPSsbsJ97SHWhUVr+A+uzvn+OY5HHtX8=;
        b=nCcHELpdSKKenDMqLjWJfap/VwM2vZ4RxJym41kpnMRXLSUldD2SYidfIQyQ1EEhK6
         qFzrOpwT7VcixwxYMReCpVH7iMWXzUqq4hR1Mrt1CRI95JU5inf7NGToeNmvj6ynp1eT
         HnnXSvyAwvg42yGLoy4wjMRbZcxvhuLE4JWVMVguwbZqTrOU+MA12VQUZNrpkZjkWZW6
         JQlHwtMsiN+Cd/e54W4/sUppHXv1kHWg800rz6XmyZjhocQvUiyYvlhuU9B9/lrDvRa4
         UZjx6iqcSLTOjUWKUg8YgR0DOEPdrKLAlStXw1ocJXtjqfV950ppG1EWRlsozix5mVV0
         c4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677785450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdfkaCxTTajRPSsbsJ97SHWhUVr+A+uzvn+OY5HHtX8=;
        b=UwP9vpTJUuSMdIMk/GdeVGuyaK6w27jfO95OhKYQ2h73JvFt3mlKR8p+wkjM9hqkRv
         iOV384HI3BKnpj5A+X3egHH4ruER4EHeycL6CL/oT0maalavIunJXT0F5aDnkhtOV8Wx
         wpCBYzrC/CsdkHbvrqyhYPm586GH6qIbEF0DCMovvFg+0aOaRmq94XmfulHdr8n3tbed
         llU7tqBCCUOm7xE/rbbvG3n9aHcy1Ajts+rmlQNvviW0W1Jrqv8Op/101FJpp/zBs+wN
         4jcqtees/IDhhcctgNaBL8Y2bovXMRd/C7h3uYVdQCqay7KzLd0KZS+0HNXRYevF7kxD
         GwRg==
X-Gm-Message-State: AO0yUKWcWp76U3VPKwTLTszE1gRJIwAFyhQwtQ8WKN3ZUcS+qsoP/15J
        kJKbTHH+k/q8VnVgiyveAHMNxrgoU630dCEQX8tgZA==
X-Google-Smtp-Source: AK7set8v8kkp4qS9ZFKIM2fncYdYWOiv+Tuu978JsleCGV6ETTqLN8XqF54d5C0eUR01uokzyOKFNY6BIVI1Iab5zVI=
X-Received: by 2002:a5d:4dc3:0:b0:2c9:868e:91a with SMTP id
 f3-20020a5d4dc3000000b002c9868e091amr1890975wru.9.1677785449870; Thu, 02 Mar
 2023 11:30:49 -0800 (PST)
MIME-Version: 1.0
References: <20230223071818.329671-1-irogers@google.com> <Y/dq4yO+zXYLCQ8d@kernel.org>
In-Reply-To: <Y/dq4yO+zXYLCQ8d@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 2 Mar 2023 11:30:36 -0800
Message-ID: <CAP-5=fXuZ=sWJcKFUSPVSpjmHFHzSWQEMfoisvjqzJz2dDOXWQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf tests stat+csv_output: Switch CSV separator
 to @
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Claire Jensen <cjense@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Feb 23, 2023 at 5:32=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Feb 22, 2023 at 11:18:17PM -0800, Ian Rogers escreveu:
> > Commas may appear in events like:
> > cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/
> > which causes the commachecker to see more fields than expected. Use @
> > as the CSV separator to avoid this.
>
> Thanks, applied both patches.

Thanks Arnaldo, I don't see the patches in the git branches so perhaps
something went wrong?

Ian

> - Arnaldo
>
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/shell/stat+csv_output.sh | 23 ++++++++++++-----------
> >  1 file changed, 12 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tes=
ts/shell/stat+csv_output.sh
> > index b7f050aa6210..324fc9e6edd7 100755
> > --- a/tools/perf/tests/shell/stat+csv_output.sh
> > +++ b/tools/perf/tests/shell/stat+csv_output.sh
> > @@ -7,6 +7,7 @@
> >  set -e
> >
> >  skip_test=3D0
> > +csv_sep=3D@
> >
> >  function commachecker()
> >  {
> > @@ -34,7 +35,7 @@ function commachecker()
> >               [ "$x" =3D "Failed" ] && continue
> >
> >               # Count the number of commas
> > -             x=3D$(echo $line | tr -d -c ',')
> > +             x=3D$(echo $line | tr -d -c $csv_sep)
> >               cnt=3D"${#x}"
> >               # echo $line $cnt
> >               [[ ! "$cnt" =3D~ $exp ]] && {
> > @@ -54,7 +55,7 @@ function ParanoidAndNotRoot()
> >  check_no_args()
> >  {
> >       echo -n "Checking CSV output: no args "
> > -     perf stat -x, true 2>&1 | commachecker --no-args
> > +     perf stat -x$csv_sep true 2>&1 | commachecker --no-args
> >       echo "[Success]"
> >  }
> >
> > @@ -66,7 +67,7 @@ check_system_wide()
> >               echo "[Skip] paranoid and not root"
> >               return
> >       fi
> > -     perf stat -x, -a true 2>&1 | commachecker --system-wide
> > +     perf stat -x$csv_sep -a true 2>&1 | commachecker --system-wide
> >       echo "[Success]"
> >  }
> >
> > @@ -79,14 +80,14 @@ check_system_wide_no_aggr()
> >               return
> >       fi
> >       echo -n "Checking CSV output: system wide no aggregation "
> > -     perf stat -x, -A -a --no-merge true 2>&1 | commachecker --system-=
wide-no-aggr
> > +     perf stat -x$csv_sep -A -a --no-merge true 2>&1 | commachecker --=
system-wide-no-aggr
> >       echo "[Success]"
> >  }
> >
> >  check_interval()
> >  {
> >       echo -n "Checking CSV output: interval "
> > -     perf stat -x, -I 1000 true 2>&1 | commachecker --interval
> > +     perf stat -x$csv_sep -I 1000 true 2>&1 | commachecker --interval
> >       echo "[Success]"
> >  }
> >
> > @@ -94,7 +95,7 @@ check_interval()
> >  check_event()
> >  {
> >       echo -n "Checking CSV output: event "
> > -     perf stat -x, -e cpu-clock true 2>&1 | commachecker --event
> > +     perf stat -x$csv_sep -e cpu-clock true 2>&1 | commachecker --even=
t
> >       echo "[Success]"
> >  }
> >
> > @@ -106,7 +107,7 @@ check_per_core()
> >               echo "[Skip] paranoid and not root"
> >               return
> >       fi
> > -     perf stat -x, --per-core -a true 2>&1 | commachecker --per-core
> > +     perf stat -x$csv_sep --per-core -a true 2>&1 | commachecker --per=
-core
> >       echo "[Success]"
> >  }
> >
> > @@ -118,7 +119,7 @@ check_per_thread()
> >               echo "[Skip] paranoid and not root"
> >               return
> >       fi
> > -     perf stat -x, --per-thread -a true 2>&1 | commachecker --per-thre=
ad
> > +     perf stat -x$csv_sep --per-thread -a true 2>&1 | commachecker --p=
er-thread
> >       echo "[Success]"
> >  }
> >
> > @@ -130,7 +131,7 @@ check_per_die()
> >               echo "[Skip] paranoid and not root"
> >               return
> >       fi
> > -     perf stat -x, --per-die -a true 2>&1 | commachecker --per-die
> > +     perf stat -x$csv_sep --per-die -a true 2>&1 | commachecker --per-=
die
> >       echo "[Success]"
> >  }
> >
> > @@ -142,7 +143,7 @@ check_per_node()
> >               echo "[Skip] paranoid and not root"
> >               return
> >       fi
> > -     perf stat -x, --per-node -a true 2>&1 | commachecker --per-node
> > +     perf stat -x$csv_sep --per-node -a true 2>&1 | commachecker --per=
-node
> >       echo "[Success]"
> >  }
> >
> > @@ -154,7 +155,7 @@ check_per_socket()
> >               echo "[Skip] paranoid and not root"
> >               return
> >       fi
> > -     perf stat -x, --per-socket -a true 2>&1 | commachecker --per-sock=
et
> > +     perf stat -x$csv_sep --per-socket -a true 2>&1 | commachecker --p=
er-socket
> >       echo "[Success]"
> >  }
> >
> > --
> > 2.39.2.637.g21b0678d19-goog
> >
>
> --
>
> - Arnaldo
