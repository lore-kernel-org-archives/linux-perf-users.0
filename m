Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE672EB64DB
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jun 2023 06:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241164AbjFOGA3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jun 2023 02:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243107AbjFOGAW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jun 2023 02:00:22 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574472715
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jun 2023 23:00:18 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3f9d619103dso105401cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jun 2023 23:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686808817; x=1689400817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TSH9xGP+io54giLsogMK2zsosKwPnZ24iN0fmv6nts=;
        b=uFbyA8iHEWqzgZiJfD6a7GJil6wKdK8i75hv2LSTEDTBaVyHgtNeQk1HnBkBCkTlTp
         /kmm4Iq81UdYLq6XOJhxhxHcsSGtPLOVVpZ2gK1gxwGEdVgOMXzjOX8WuuQt//ZX2Pg0
         ctOyuzDmwRaQYdTjpZ6e3HEdkz0/0vwzgnZE3B2qksobUT0Fylc30fCT4YvnNTh9NytR
         fr0WQFIQetkIpKp/PIX7+65V1rxyo0TutZt24IKUsCU99F1+rXJZEJY5NJG0DP8qW96R
         Pt6S6a8zZ4NLeAHXnEr8yoOLODCQx6672/Pceokz7gYP877aESlnWfjDDkOFfol5wEbL
         3huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686808817; x=1689400817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2TSH9xGP+io54giLsogMK2zsosKwPnZ24iN0fmv6nts=;
        b=eum3FAjgV7xLDX8vY1yN16Ll/k6JTzouePmsrG8/iENLvUItZXPMSTB2QlU+U60BEC
         IIHN5YUyRk0rdBU3EHNZmKHFCzX60Sd/xVr1/NYdSHtXPBErk6JILr4l8DslklandrCr
         QQeRgVlvHVhtp+E7zfeMiRCgkbnmIII0GE/zDfL/8yTksS8J5LwV72ra//5+Nl2YNkhx
         rmfjP+bLpX7n9KZ+tHFzYV++J28nj5boOiJ1YPo1DKWVE0V9A3bKM7/Slmqq/KVLSQmG
         CQZh0dJc718ZIddDF4+hTL6MT1Pq5s30aglAeQq/YF7quTnAR/wpkkbppy/fkvBJUZLp
         vJoQ==
X-Gm-Message-State: AC+VfDzLbxWy1ldWLDYws3yfNh2P+Yh8ZbDVoAHyOj4ecYYNCsEY+BzV
        Q2an3i7SyUSEFukaN3cORVWKJJh5uxDt0v+3F+a2mA==
X-Google-Smtp-Source: ACHHUZ7STKzYkVq+UK0FDMKH8vACkwBx9XboHMjyagaDSANCGQbuRRSHhD/B1bqBUrG8V9N2LRawu7LNos/42qRKy8Y=
X-Received: by 2002:a05:622a:107:b0:3f8:1f30:a1f2 with SMTP id
 u7-20020a05622a010700b003f81f30a1f2mr168763qtw.26.1686808817005; Wed, 14 Jun
 2023 23:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230615001735.3643996-1-kan.liang@linux.intel.com> <20230615001735.3643996-9-kan.liang@linux.intel.com>
In-Reply-To: <20230615001735.3643996-9-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 14 Jun 2023 23:00:04 -0700
Message-ID: <CAP-5=fVt+_taayKpj8_aQ6wnxMBCU8GrKmbfY-M01gOE=X=EUg@mail.gmail.com>
Subject: Re: [PATCH V2 8/8] perf test: Add test case for the standard perf
 stat output
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

On Wed, Jun 14, 2023 at 5:18=E2=80=AFPM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Add a new test case to verify the standard perf stat output with
> different options.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/stat+std_output.sh | 108 ++++++++++++++++++++++
>  1 file changed, 108 insertions(+)
>  create mode 100755 tools/perf/tests/shell/stat+std_output.sh
>
> diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests=
/shell/stat+std_output.sh
> new file mode 100755
> index 000000000000..98cc3356a04a
> --- /dev/null
> +++ b/tools/perf/tests/shell/stat+std_output.sh
> @@ -0,0 +1,108 @@
> +#!/bin/bash
> +# perf stat STD output linter
> +# SPDX-License-Identifier: GPL-2.0
> +# Tests various perf stat STD output commands for
> +# default event and metricgroup
> +
> +set -e
> +
> +. $(dirname $0)/lib/stat_output.sh
> +
> +stat_output=3D$(mktemp /tmp/__perf_test.stat_output.std.XXXXX)
> +
> +event_name=3D(cpu-clock task-clock context-switches cpu-migrations page-=
faults cycles instructions branches branch-misses stalled-cycles-frontend s=
talled-cycles-backend)
> +event_metric=3D("CPUs utilized" "CPUs utilized" "/sec" "/sec" "/sec" "GH=
z" "insn per cycle" "/sec" "of all branches" "frontend cycles idle" "backen=
d cycles idle")
> +
> +metricgroup_name=3D(TopdownL1 TopdownL2)
> +
> +cleanup() {
> +  rm -f "${stat_output}"
> +
> +  trap - EXIT TERM INT
> +}
> +
> +trap_cleanup() {
> +  cleanup
> +  exit 1
> +}
> +trap trap_cleanup EXIT TERM INT
> +
> +function commachecker()
> +{
> +       local -i cnt=3D0
> +       local prefix=3D1
> +
> +       case "$1"
> +       in "--interval")        prefix=3D2
> +       ;; "--per-thread")      prefix=3D2
> +       ;; "--system-wide-no-aggr")     prefix=3D2
> +       ;; "--per-core")        prefix=3D3
> +       ;; "--per-socket")      prefix=3D3
> +       ;; "--per-node")        prefix=3D3
> +       ;; "--per-die")         prefix=3D3
> +       ;; "--per-cache")       prefix=3D3
> +       esac
> +
> +       while read line
> +       do
> +               # Ignore initial "started on" comment.
> +               x=3D${line:0:1}
> +               [ "$x" =3D "#" ] && continue
> +               # Ignore initial blank line.
> +               [ "$line" =3D "" ] && continue
> +               # Ignore "Performance counter stats"
> +               x=3D${line:0:25}
> +               [ "$x" =3D "Performance counter stats" ] && continue
> +               # Ignore "seconds time elapsed" and break
> +               [[ "$line" =3D=3D *"time elapsed"* ]] && break
> +
> +               main_body=3D$(echo $line | cut -d' ' -f$prefix-)
> +               x=3D${main_body%#*}
> +               # Check default metricgroup
> +               y=3D$(echo $x | tr -d ' ')
> +               [ "$y" =3D "" ] && continue
> +               for i in "${!metricgroup_name[@]}"; do
> +                       [[ "$y" =3D=3D *"${metricgroup_name[$i]}"* ]] && =
break
> +               done
> +               [[ "$y" =3D=3D *"${metricgroup_name[$i]}"* ]] && continue
> +
> +               # Check default event
> +               for i in "${!event_name[@]}"; do
> +                       [[ "$x" =3D=3D *"${event_name[$i]}"* ]] && break
> +               done
> +
> +               [[ ! "$x" =3D=3D *"${event_name[$i]}"* ]] && {
> +                       echo "Unknown event name in $line" 1>&2
> +                       exit 1;
> +               }
> +
> +               # Check event metric if it exists
> +               [[ ! "$main_body" =3D=3D *"#"* ]] && continue
> +               [[ ! "$main_body" =3D=3D *"${event_metric[$i]}"* ]] && {
> +                       echo "wrong event metric. expected ${event_metric=
[$i]} in $line" 1>&2
> +                       exit 1;
> +               }
> +       done < "${stat_output}"
> +       return 0
> +}
> +
> +perf_cmd=3D"-o ${stat_output}"
> +
> +skip_test=3D$(check_for_topology)
> +check_no_args "STD" "$perf_cmd"
> +check_system_wide "STD" "$perf_cmd"
> +check_interval "STD" "$perf_cmd"
> +check_per_thread "STD" "$perf_cmd"
> +check_per_node "STD" "$perf_cmd"
> +if [ $skip_test -ne 1 ]
> +then
> +       check_system_wide_no_aggr "STD" "$perf_cmd"
> +       check_per_core "STD" "$perf_cmd"
> +       check_per_cache_instance "STD" "$perf_cmd"
> +       check_per_die "STD" "$perf_cmd"
> +       check_per_socket "STD" "$perf_cmd"
> +else
> +       echo "[Skip] Skipping tests for system_wide_no_aggr, per_core, pe=
r_die and per_socket since socket id exposed via topology is invalid"
> +fi
> +cleanup
> +exit 0
> --
> 2.35.1
>
