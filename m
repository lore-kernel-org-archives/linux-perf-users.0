Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04728C43334
	for <linux-perf-users@archiver.kernel.org>; Fri,  3 Jun 2022 21:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348051AbiFCVAR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 3 Jun 2022 17:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347807AbiFCVAP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 3 Jun 2022 17:00:15 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5435676F
        for <linux-perf-users@vger.kernel.org>; Fri,  3 Jun 2022 14:00:13 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u3so11839626wrg.3
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Jun 2022 14:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Clz6tR5ivCzeh/CunE4A+ZyoKhX/KSXV/708BnmkcsE=;
        b=baPq+F0++gKTHHfzwWVxbM4iW4rS1/D9/ppKSb1K8TVoHhPPytP89sO9e7VpBqt25V
         Ii4cYd5DBNpw9OZG2TFrsfULIRXsjmL4Xx5URtcOi9gJsJFXI7UWs8Oqu9SbxOQDG7Bo
         JJwn0pE4iXjRfNUPTu61Z/OlcQMBz9W3UdIxIxFV0lZhlsushuh6sGoPBRrMu6eXEfLR
         c7KRW7XeUUTESYryd924xvcKW3SPD8rEmODKC3i14yVPno3DP4wxNzSDi+ODMOtMJT3m
         cn17fufFBhd/EqYj7SmG62auD2eDjVWF3b35qc25+eh8OYqIQuxYxy7BNJ06aE9nEXVv
         tkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Clz6tR5ivCzeh/CunE4A+ZyoKhX/KSXV/708BnmkcsE=;
        b=CISe89EHvWPQ6Pnm8G0qId5IZvoCJhktKhYtEOkrEe/AP3v1ugKDJLpqev982pvRLd
         MAVKxd+CF46PmRJltAb2R/VF/Pgy/6pLYx/dONWLou6FhpXbaPb+SXCb4h2MivF2oj8B
         Ii2CrEWVUfybHZsc0YwsMhFmtFVVZomzNy8NBeyJGjhhibTQcmgV8dFl+Z5jufb5laDV
         9YErZw1pip5Q/+YG4Jm3f6aFSnYmWOuL7jVe29dNm+U4HVWTOOdkgi3cQZ21OseYMnPU
         I6uawlOFyC+gIMu1ovgDnGcO1qlQkDn9tkBC1Z093v9RaktTtd3H8m8AB6084xkhIfJH
         q/yQ==
X-Gm-Message-State: AOAM530x9kG/2993Skrtb3wduH+yarGu6ffVhqMGka+BzzhQgjLGVKmE
        RlovUAvORcAcGSbif1nhfW/3bWeeiLatRyX5zPk7LA==
X-Google-Smtp-Source: ABdhPJz9HW0qw02xfUIixjpyD2f9xxNvG6rCCnn0CW1sPY+b5Ke1xFpn4ve1e86inTIdGfAxZteerZY5AAnCsUeM9+s=
X-Received: by 2002:adf:f5c4:0:b0:210:2ac2:6aa0 with SMTP id
 k4-20020adff5c4000000b002102ac26aa0mr9705156wrp.300.1654290011428; Fri, 03
 Jun 2022 14:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220603113034.2009728-1-tmricht@linux.ibm.com>
In-Reply-To: <20220603113034.2009728-1-tmricht@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 3 Jun 2022 13:59:59 -0700
Message-ID: <CAP-5=fXWngvcJ-M-OgZNuTCwXdvdYNmw-a0OcgQD7rFrc1eRFg@mail.gmail.com>
Subject: Re: [PATCH] perf/test: perf test 83 fails on s390
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, cjense@google.com, sumanthk@linux.ibm.com,
        svens@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 3, 2022 at 4:33 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>
> perf test -F 83 ("perf stat CSV output linter") fails on s390.
> Reason is the wrong number of fields for certain CPU core/die/socket
> related output.
>
> On x84_64 the output of command
>  # ./perf stat -x, -A -a --no-merge true
>  CPU0,1.50,msec,cpu-clock,1502781,100.00,1.052,CPUs utilized
>  CPU1,1.48,msec,cpu-clock,1476113,100.00,1.034,CPUs utilized
>  ...
> results in 8 fields with 7 comma separators.
>
> On s390 the output of command
>  #  ./perf stat -x, -A -a --no-merge -- true
>  0.95,msec,cpu-clock,949800,100.00,1.060,CPUs utilized
>  ...
> results in 7 fields with 6 comma separators. Therefore this tests
> fails on s390. Similar issues exist for per-die and per-socket output
> which is not supported on s390.
>
> I have rewritten the python program to count commas in each output line
> into a bash function to achieve the same result. I hope this makes
> it a bit easier.
>
> Output before:
>  # ./perf test -F 83
>  83: perf stat CSV output linter  :
>  Checking CSV output: no args [Success]
>  Checking CSV output: system wide [Success]
>  Checking CSV output: system wide Checking CSV output: \
>          system wide no aggregation 6.92,msec,cpu-clock,\
>          6918131,100.00,6.972,CPUs utilized
>  ...
>  RuntimeError: wrong number of fields. expected 7 in \
>          6.92,msec,cpu-clock,6918131,100.00,6.972,CPUs utilized
>
>  FAILED!
>  #
>
> Output after:
>  # ./perf test -F 83
>  83: perf stat CSV output linter             :
>  Checking CSV output: no args [Success]
>  Checking CSV output: system wide [Success]
>  Checking CSV output: system wide Checking CSV output:\
>          system wide no aggregation [Success]
>  Checking CSV output: interval [Success]
>  Checking CSV output: event [Success]
>  Checking CSV output: per core [Success]
>  Checking CSV output: per thread [Success]
>  Checking CSV output: per die [Success]
>  Checking CSV output: per node [Success]
>  Checking CSV output: per socket [Success]
>  Ok
>  #
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  .../tests/shell/lib/perf_csv_output_lint.py   | 48 -------------
>  tools/perf/tests/shell/stat+csv_output.sh     | 69 ++++++++++++-------
>  2 files changed, 45 insertions(+), 72 deletions(-)
>  delete mode 100644 tools/perf/tests/shell/lib/perf_csv_output_lint.py
>
> diff --git a/tools/perf/tests/shell/lib/perf_csv_output_lint.py b/tools/perf/tests/shell/lib/perf_csv_output_lint.py
> deleted file mode 100644
> index 714f283cfb1b..000000000000
> --- a/tools/perf/tests/shell/lib/perf_csv_output_lint.py
> +++ /dev/null
> @@ -1,48 +0,0 @@
> -#!/usr/bin/python
> -# SPDX-License-Identifier: GPL-2.0
> -
> -import argparse
> -import sys
> -
> -# Basic sanity check of perf CSV output as specified in the man page.
> -# Currently just checks the number of fields per line in output.
> -
> -ap = argparse.ArgumentParser()
> -ap.add_argument('--no-args', action='store_true')
> -ap.add_argument('--interval', action='store_true')
> -ap.add_argument('--system-wide-no-aggr', action='store_true')
> -ap.add_argument('--system-wide', action='store_true')
> -ap.add_argument('--event', action='store_true')
> -ap.add_argument('--per-core', action='store_true')
> -ap.add_argument('--per-thread', action='store_true')
> -ap.add_argument('--per-die', action='store_true')
> -ap.add_argument('--per-node', action='store_true')
> -ap.add_argument('--per-socket', action='store_true')
> -ap.add_argument('--separator', default=',', nargs='?')
> -args = ap.parse_args()
> -
> -Lines = sys.stdin.readlines()
> -
> -def check_csv_output(exp):
> -  for line in Lines:
> -    if 'failed' not in line:
> -      count = line.count(args.separator)
> -      if count != exp:
> -        sys.stdout.write(''.join(Lines))
> -        raise RuntimeError(f'wrong number of fields. expected {exp} in {line}')
> -
> -try:
> -  if args.no_args or args.system_wide or args.event:
> -    expected_items = 6
> -  elif args.interval or args.per_thread or args.system_wide_no_aggr:
> -    expected_items = 7
> -  elif args.per_core or args.per_socket or args.per_node or args.per_die:
> -    expected_items = 8
> -  else:
> -    ap.print_help()
> -    raise RuntimeError('No checking option specified')
> -  check_csv_output(expected_items)
> -
> -except:
> -  sys.stdout.write('Test failed for input: ' + ''.join(Lines))
> -  raise
> diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
> index 983220ef3cb4..38c26f3ef4c1 100755
> --- a/tools/perf/tests/shell/stat+csv_output.sh
> +++ b/tools/perf/tests/shell/stat+csv_output.sh
> @@ -6,20 +6,41 @@
>
>  set -e
>
> -pythonchecker=$(dirname $0)/lib/perf_csv_output_lint.py
> -if [ "x$PYTHON" == "x" ]
> -then
> -       if which python3 > /dev/null
> -       then
> -               PYTHON=python3
> -       elif which python > /dev/null
> -       then
> -               PYTHON=python
> -       else
> -               echo Skipping test, python not detected please set environment variable PYTHON.
> -               exit 2
> -       fi
> -fi
> +function commachecker()
> +{
> +       local -i cnt=0 exp=0
> +
> +       case "$1"
> +       in "--no-args")         exp=6
> +       ;; "--system-wide")     exp=6
> +       ;; "--event")           exp=6
> +       ;; "--interval")        exp=7
> +       ;; "--per-thread")      exp=7
> +       ;; "--system-wide-no-aggr")     exp=7
> +                               [ $(uname -m) = "s390x" ] && exp=6
> +       ;; "--per-core")        exp=8
> +       ;; "--per-socket")      exp=8
> +       ;; "--per-node")        exp=8
> +       ;; "--per-die")         exp=8
> +       esac
> +
> +       while read line
> +       do
> +               # Check for lines beginning with Failed
> +               x=${line:0:6}
> +               [ "$x" = "Failed" ] && continue
> +
> +               # Count the number of commas
> +               x=$(echo $line | tr -d -c ',')
> +               cnt="${#x}"
> +               # echo $line $cnt
> +               [ "$cnt" -ne "$exp" ] && {
> +                       echo "wrong number of fields. expected $exp in $line" 1>&2
> +                       exit 1;
> +               }
> +       done
> +       return 0
> +}
>
>  # Return true if perf_event_paranoid is > $1 and not running as root.
>  function ParanoidAndNotRoot()
> @@ -30,7 +51,7 @@ function ParanoidAndNotRoot()
>  check_no_args()
>  {
>         echo -n "Checking CSV output: no args "
> -       perf stat -x, true 2>&1 | $PYTHON $pythonchecker --no-args
> +       perf stat -x, true 2>&1 | commachecker --no-args
>         echo "[Success]"
>  }
>
> @@ -42,7 +63,7 @@ check_system_wide()
>                 echo "[Skip] paranoid and not root"
>                 return
>         fi
> -       perf stat -x, -a true 2>&1 | $PYTHON $pythonchecker --system-wide
> +       perf stat -x, -a true 2>&1 | commachecker --system-wide
>         echo "[Success]"
>  }
>
> @@ -55,14 +76,14 @@ check_system_wide_no_aggr()
>                 return
>         fi
>         echo -n "Checking CSV output: system wide no aggregation "
> -       perf stat -x, -A -a --no-merge true 2>&1 | $PYTHON $pythonchecker --system-wide-no-aggr
> +       perf stat -x, -A -a --no-merge true 2>&1 | commachecker --system-wide-no-aggr
>         echo "[Success]"
>  }
>
>  check_interval()
>  {
>         echo -n "Checking CSV output: interval "
> -       perf stat -x, -I 1000 true 2>&1 | $PYTHON $pythonchecker --interval
> +       perf stat -x, -I 1000 true 2>&1 | commachecker --interval
>         echo "[Success]"
>  }
>
> @@ -70,7 +91,7 @@ check_interval()
>  check_event()
>  {
>         echo -n "Checking CSV output: event "
> -       perf stat -x, -e cpu-clock true 2>&1 | $PYTHON $pythonchecker --event
> +       perf stat -x, -e cpu-clock true 2>&1 | commachecker --event
>         echo "[Success]"
>  }
>
> @@ -82,7 +103,7 @@ check_per_core()
>                 echo "[Skip] paranoid and not root"
>                 return
>         fi
> -       perf stat -x, --per-core -a true 2>&1 | $PYTHON $pythonchecker --per-core
> +       perf stat -x, --per-core -a true 2>&1 | commachecker --per-core
>         echo "[Success]"
>  }
>
> @@ -94,7 +115,7 @@ check_per_thread()
>                 echo "[Skip] paranoid and not root"
>                 return
>         fi
> -       perf stat -x, --per-thread -a true 2>&1 | $PYTHON $pythonchecker --per-thread
> +       perf stat -x, --per-thread -a true 2>&1 | commachecker --per-thread
>         echo "[Success]"
>  }
>
> @@ -106,7 +127,7 @@ check_per_die()
>                 echo "[Skip] paranoid and not root"
>                 return
>         fi
> -       perf stat -x, --per-die -a true 2>&1 | $PYTHON $pythonchecker --per-die
> +       perf stat -x, --per-die -a true 2>&1 | commachecker --per-die
>         echo "[Success]"
>  }
>
> @@ -118,7 +139,7 @@ check_per_node()
>                 echo "[Skip] paranoid and not root"
>                 return
>         fi
> -       perf stat -x, --per-node -a true 2>&1 | $PYTHON $pythonchecker --per-node
> +       perf stat -x, --per-node -a true 2>&1 | commachecker --per-node
>         echo "[Success]"
>  }
>
> @@ -130,7 +151,7 @@ check_per_socket()
>                 echo "[Skip] paranoid and not root"
>                 return
>         fi
> -       perf stat -x, --per-socket -a true 2>&1 | $PYTHON $pythonchecker --per-socket
> +       perf stat -x, --per-socket -a true 2>&1 | commachecker --per-socket
>         echo "[Success]"
>  }
>
> --
> 2.36.1
>
