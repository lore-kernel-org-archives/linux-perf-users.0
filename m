Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1542C1717;
	Thu,  7 Dec 2023 15:26:56 -0800 (PST)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ce72faf1e8so1077981b3a.0;
        Thu, 07 Dec 2023 15:26:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701991615; x=1702596415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4J2E2tG2dP97E7tt5Zs/xut2bSJe2Lv30FSjIan7Ew=;
        b=tAcd5VZP5c9PcRamRHTcNCtrOOpKLUGgt6dAs9ZMFVWrrgNmV+CReqeXB7T+2EPqTu
         ijZUQP5jaPRXimIX8J/pZWN7qGTaWLqnuphScRnrgdh2AHzBb3CBd/AAGlYLdTSim8IP
         RRxujbwwPSep0zc+xWjN6Kgdgc6xE2ZsbQB8+/1/e5C8Z1u8RIsxmsNdV1x6jB587i9t
         0UZPckivi7B8fUP5KB+mnrfpw8Fwctm+B8kGCAYsLXaVleXdMkHyRymg2RsCj9q3SEqa
         tme7UXfPglfQ+wh0o5WGMuW94Y/Wgu4Crcz6f0XpzujMxJwFaiMu1m6GH0ntMrqM9JNm
         niLg==
X-Gm-Message-State: AOJu0YwrpYBNsxAlKyVmaUdwIPa+69qRfH/B3NqmyPMeGDEov9mRk0ug
	7dJ7yR69CrB/WFWwRYJVjtI9S9qU+/a7uKVnxNSOgPQ2BYk=
X-Google-Smtp-Source: AGHT+IEuuqBsJIJyxMPILRxJ8yuzzSZroPT9okr9/mpKlIjY2VyBtU2GI9b7309naza3f77qfi6ET2yEcRqhpJ166P0=
X-Received: by 2002:aa7:9e0b:0:b0:6ce:3260:c469 with SMTP id
 y11-20020aa79e0b000000b006ce3260c469mr2692375pfq.35.1701991615418; Thu, 07
 Dec 2023 15:26:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207125716.1947860-1-tmricht@linux.ibm.com>
In-Reply-To: <20231207125716.1947860-1-tmricht@linux.ibm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 7 Dec 2023 15:26:43 -0800
Message-ID: <CAM9d7cgJUgVGpQJ=KgH+3RzAJ8Ce50Acr=gSZh_ZLuiTa3-sEg@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix fails of perf stat --bpf-counters
 --for-each-cgroup on s390
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	acme@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Dec 7, 2023 at 4:57=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.co=
m> wrote:
>
> On s390 this test fails very often, as can be observed in the output
> below. This is caused by the second test function
> check_cpu_list_counted(). The perf stat is triggered for 2 CPUs
> 0 and 1.  On s390, which usually has a lot more CPUs, most often
> this ends up in no counter increments on these 2 CPUs 0 and 1.
>
> Fix this and trigger explicit workload on CPU 0 and 1 for
> systemd. This is a better approach than calculating a long
> list of CPUs (which is basicly the same as option -a), or
> wait a longer period of time.
>
> Output before:
>  # for i in $(seq 10)
>  > do ./perf test 100
>  > done
>  100: perf stat --bpf-counters --for-each-cgroup test : FAILED!
>  100: perf stat --bpf-counters --for-each-cgroup test : Ok
>  100: perf stat --bpf-counters --for-each-cgroup test : FAILED!
>  100: perf stat --bpf-counters --for-each-cgroup test : Ok
>  100: perf stat --bpf-counters --for-each-cgroup test : Ok
>  100: perf stat --bpf-counters --for-each-cgroup test : Ok
>  100: perf stat --bpf-counters --for-each-cgroup test : FAILED!
>  100: perf stat --bpf-counters --for-each-cgroup test : Ok
>  100: perf stat --bpf-counters --for-each-cgroup test : FAILED!
>  100: perf stat --bpf-counters --for-each-cgroup test : Ok
>  #
>
> Output after:
>  # for i in $(seq 10);
>  do ./perf test 100;
>  done
>  100: perf stat --bpf-counters --for-each-cgroup test  : Ok
>  100: perf stat --bpf-counters --for-each-cgroup test  : Ok
>  100: perf stat --bpf-counters --for-each-cgroup test  : Ok
>  100: perf stat --bpf-counters --for-each-cgroup test  : Ok
>  100: perf stat --bpf-counters --for-each-cgroup test  : Ok
>  100: perf stat --bpf-counters --for-each-cgroup test  : Ok
>  100: perf stat --bpf-counters --for-each-cgroup test  : Ok
>  100: perf stat --bpf-counters --for-each-cgroup test  : Ok
>  100: perf stat --bpf-counters --for-each-cgroup test  : Ok
>  100: perf stat --bpf-counters --for-each-cgroup test  : Ok
>  #
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/tests/shell/stat_bpf_counters_cgrp.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh b/tools/per=
f/tests/shell/stat_bpf_counters_cgrp.sh
> index e75d0780dc78..f67602321403 100755
> --- a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
> +++ b/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
> @@ -60,6 +60,7 @@ check_system_wide_counted()
>
>  check_cpu_list_counted()
>  {
> +       taskset -c 0,1 systemctl daemon-reexec &

Thanks for the patch.  But I think it should support
machines without systemd (or maybe with old versions).

Also probably you want to reset the behavior after
the test.  I think we can just run some built-in test
workload like `perf test -w thloop`.

Thanks,
Namhyung


>         check_cpu_list_counted_output=3D$(perf stat -C 0,1 --bpf-counters=
 --for-each-cgroup ${test_cgroups} -e cpu-clock -x, taskset -c 1 sleep 1  2=
>&1)
>         if echo ${check_cpu_list_counted_output} | grep -q -F "<not "; th=
en
>                 echo "Some CPU events are not counted"
> --
> 2.43.0
>
