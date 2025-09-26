Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7B9279DDD
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Sep 2025 09:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758877261; cv=none; b=uhGkWNmXcr+ASi6Ota3BMpaYS5OhYkR8rrVAAQrCLG7P79gT6Swhbb+AxHnmQyFVOBA2ObRPpydJQ+Dpe5WY+wtR+zi6q+EkFhLszhD2GpRU9pkPKyvKt1FJOZisRzUQMs82WJDS6M5+6cRV5UG6EymlIYLJRxqIV6al71lC4Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758877261; c=relaxed/simple;
	bh=2wA0d16u/6KCj+Abm5zr10wxjk/Nv6UemcjdDLNfRf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mf3JOS+Qv/Y4lbDzhkqeMYN85cKgWjUt6BUq50AHzKuxe7TxzX3nyPFP3tpZ7CRVz5uW9eiNMvx1mR3Jwvp5pCu7ZLOOm1+blPF8ONe2owKdz8Mqtwy5wzVnvwKXv5RBbjqGVbURQjAU3z1mWdrR8NLEvu55iLaefQKxuNGVr7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ULJO/MAL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULJO/MAL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758877258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ShGXGHPdvYlBe5RKUUi4Bd0ovd8HxH8J4+xlI4KkhA=;
	b=ULJO/MALAs1ZcXAxuOLpTY39cV3NlAw/evOxTJKxu8B7nrqUzvVHXLaZabgxDAeSfcIQVm
	ZaqqJCdPSF48fFykJIgkjOoprSE+jaBZUIlIvWYQRtn1XIqJ8H8GI6S0UJjSHZ1OsgGBVT
	awdksZY31Codo1zusfILMPwIWl8NVCI=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-j10fn44CM8iOq0stbZ7_Bg-1; Fri, 26 Sep 2025 05:00:56 -0400
X-MC-Unique: j10fn44CM8iOq0stbZ7_Bg-1
X-Mimecast-MFC-AGG-ID: j10fn44CM8iOq0stbZ7_Bg_1758877256
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-74a30209044so3579264a34.1
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Sep 2025 02:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758877256; x=1759482056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ShGXGHPdvYlBe5RKUUi4Bd0ovd8HxH8J4+xlI4KkhA=;
        b=PxA5Y+PZBCViPXzbJjiwMyL0IW6nfFJ+J2zaliP8IXztOqPbtmO8wKOnN/mIgc9efB
         VCf4Hcgo/GRvz2+LetRAwtnZGc5tzdHIBYvrWRNbfe5Idj5SRlSdfpGq0buB/GmyDy5D
         00NYQYbElj81ea8R4CesmYjoAZCCWT4gvBmUmAjFScu+b+RVFTZ2qRtYZMbGwtbfdKjA
         SYBVKF9dIsPznjNXykaqOYtaRpOx0IQ20r8eQNYQ0ISY/NotsGK/XuEQjbZpQdNmbQ58
         e0GWrw8wLadGqXgXHypxcm88Y6xJ/33H1qnS6CKWYVJ8jaLaR+4T/wV+EHUPPj4g5N1a
         lZiw==
X-Forwarded-Encrypted: i=1; AJvYcCVjCPFBSTl9X/KG0yYrIW6l/D6Y9NrbXFddtRRCOMhUkPe9UTVLen7y+AQhZpDjHkZ8SYXWtb61DH6rRPdeC0s8@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Pp+FfMo6k5SsTT+IsdKVX7F/5s7D96gSe3QvS4ZeYsb+jvms
	LPg0mbqBU0ykJrB+siq9esmmktDaDR/HwlBi7X+4PgwtOzbqYYNSO3ihGGnsgk1mO8koWpq3IWL
	CmbEliVHeRHK0NF+TK/a47xFO5PrvDaCNvcqoI5bAvGyZK2MznuFHYGwDDmZf/fY5y9dFIUgjUG
	FN/fuaeE5kpkqkRs7VvHWjdd0oYYUIJRmOm6yF1i8qz4AKyQ==
X-Gm-Gg: ASbGnctCvBolL5p6DV2TolSoOJi0iW+CEkJQmkPcImhIx+KKIemdBH1N758Dg54m6e0
	P/g8UxwUYd9zYgja7Mv57U4kdVb2FmmpT0CStavtvwhH3GXnyyoufuAJMXi2OowM4Q/h3Hkb+VD
	9r+0DgNfP1+vGpCX0OfjIFHw==
X-Received: by 2002:a05:6830:25d6:b0:790:78e6:8450 with SMTP id 46e09a7af769-7a03d122795mr3216497a34.6.1758877255709;
        Fri, 26 Sep 2025 02:00:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZxy8k2uUNsp1XRNbnNWcIuiqAPl8O62jVNCJNNdDph9uiBGilSEFZNffrSh/bpMVUsWAWwFTFyXQs20a4HOw=
X-Received: by 2002:a05:6830:25d6:b0:790:78e6:8450 with SMTP id
 46e09a7af769-7a03d122795mr3216478a34.6.1758877255212; Fri, 26 Sep 2025
 02:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918222202.1353854-1-irogers@google.com> <20250918222202.1353854-4-irogers@google.com>
In-Reply-To: <20250918222202.1353854-4-irogers@google.com>
From: Qiao Zhao <qzhao@redhat.com>
Date: Fri, 26 Sep 2025 17:00:43 +0800
X-Gm-Features: AS18NWAV1pmn_mwfn6L3-Ucum_4jK7MR8aU109NNkeDKqD7xSbvxIWq9Qew7oX4
Message-ID: <CAATMXfnqCjxSV2wOqDJ9copKMWyR5hNe9p78kwtrn+W7UCV2DQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] perf test: Avoid uncore_imc/clockticks in
 uniquification test
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Chun-Tse Shao <ctshao@google.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

I tested your patch (latest linux-next code + your patch) on hybrid
CPU machine {CPU Model name: 12th Gen Intel(R) Core(TM) i7-12800HE}
and failed,
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# perf test -vv "perf stat events uniquifying"
 95: perf stat events uniquifying:
--- start ---
test child forked, pid 21799
Uniquification of PMU sysfs events test
Testing event uncore_imc_free_running/data_read/ is uniquified to
uncore_imc_free_running_0/data_read/
Uniquification of PMU sysfs events test [Failed]
# started on Fri Sep 26 04:49:54 2025


 Performance counter stats for 'system wide':

CPU0                 1.47 MiB
uncore_imc_free_running_0/uncore_imc_free_running,data_read/
CPU0                 1.47 MiB
uncore_imc_free_running_1/uncore_imc_free_running,data_read/

       0.000925108 seconds time elapsed

Testing event uncore_imc_free_running/data_total/ is uniquified to
uncore_imc_free_running_0/data_total/
Uniquification of PMU sysfs events test [Failed]
# started on Fri Sep 26 04:49:54 2025


 Performance counter stats for 'system wide':

CPU0                 0.59 MiB
uncore_imc_free_running_0/uncore_imc_free_running,data_total/
CPU0                 0.58 MiB
uncore_imc_free_running_1/uncore_imc_free_running,data_total/

       0.000969877 seconds time elapsed

Testing event uncore_imc_free_running/data_write/ is uniquified to
uncore_imc_free_running_0/data_write/
Uniquification of PMU sysfs events test [Failed]
# started on Fri Sep 26 04:49:54 2025


 Performance counter stats for 'system wide':

CPU0                 0.00 MiB
uncore_imc_free_running_0/uncore_imc_free_running,data_write/
CPU0                 0.00 MiB
uncore_imc_free_running_1/uncore_imc_free_running,data_write/

       0.001183888 seconds time elapsed

Testing event uncore_imc_free_running/data_read/ is uniquified to
uncore_imc_free_running_1/data_read/
Uniquification of PMU sysfs events test [Failed]
# started on Fri Sep 26 04:49:54 2025


 Performance counter stats for 'system wide':

CPU0                 0.29 MiB
uncore_imc_free_running_0/uncore_imc_free_running,data_read/
CPU0                 0.29 MiB
uncore_imc_free_running_1/uncore_imc_free_running,data_read/

       0.000710088 seconds time elapsed

Testing event uncore_imc_free_running/data_total/ is uniquified to
uncore_imc_free_running_1/data_total/
Uniquification of PMU sysfs events test [Failed]
# started on Fri Sep 26 04:49:54 2025


 Performance counter stats for 'system wide':

CPU0                 0.62 MiB
uncore_imc_free_running_0/uncore_imc_free_running,data_total/
CPU0                 0.67 MiB
uncore_imc_free_running_1/uncore_imc_free_running,data_total/

       0.000959074 seconds time elapsed

Testing event uncore_imc_free_running/data_write/ is uniquified to
uncore_imc_free_running_1/data_write/
Uniquification of PMU sysfs events test [Failed]
# started on Fri Sep 26 04:49:54 2025


 Performance counter stats for 'system wide':

CPU0                 0.23 MiB
uncore_imc_free_running_0/uncore_imc_free_running,data_write/
CPU0                 0.23 MiB
uncore_imc_free_running_1/uncore_imc_free_running,data_write/

       0.000775028 seconds time elapsed

---- end(-1) ----
 95: perf stat events uniquifying                                    : FAIL=
ED!
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# ls -la /sys/bus/event_source/devices/uncore_imc_free_running_*/events/
/sys/bus/event_source/devices/uncore_imc_free_running_0/events/:
total 0
drwxr-xr-x. 2 root root    0 Sep 26 04:57 .
drwxr-xr-x. 5 root root    0 Sep 26 01:49 ..
-r--r--r--. 1 root root 4096 Sep 26 01:49 data_read
-r--r--r--. 1 root root 4096 Sep 26 01:49 data_read.scale
-r--r--r--. 1 root root 4096 Sep 26 01:49 data_read.unit
-r--r--r--. 1 root root 4096 Sep 26 01:49 data_total
-r--r--r--. 1 root root 4096 Sep 26 01:49 data_total.scale
-r--r--r--. 1 root root 4096 Sep 26 01:49 data_total.unit
-r--r--r--. 1 root root 4096 Sep 26 01:49 data_write
-r--r--r--. 1 root root 4096 Sep 26 01:49 data_write.scale
-r--r--r--. 1 root root 4096 Sep 26 01:49 data_write.unit

/sys/bus/event_source/devices/uncore_imc_free_running_1/events/:
total 0
drwxr-xr-x. 2 root root    0 Sep 26 04:57 .
drwxr-xr-x. 5 root root    0 Sep 26 01:49 ..
-r--r--r--. 1 root root 4096 Sep 26 01:49 data_read
-r--r--r--. 1 root root 4096 Sep 26 01:49 data_read.scale
-r--r--r--. 1 root root 4096 Sep 26 01:49 data_read.unit
-r--r--r--. 1 root root 4096 Sep 26 01:49 data_total
-r--r--r--. 1 root root 4096 Sep 26 01:49 data_total.scale
-r--r--r--. 1 root root 4096 Sep 26 01:49 data_total.unit
-r--r--r--. 1 root root 4096 Sep 26 01:49 data_write
-r--r--r--. 1 root root 4096 Sep 26 01:49 data_write.scale
-r--r--r--. 1 root root 4096 Sep 26 01:49 data_write.unit

- Qiao

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


On Fri, Sep 19, 2025 at 6:22=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> The detection of uncore_imc may happen for free running PMUs and the
> clockticks event may be present on uncore_clock. Rewrite the test to
> detect duplicated/deduplicated events from perf list, not hardcoded to
> uncore_imc.
>
> If perf stat fails then assume it is permissions and skip the test.
>
> Fixes: 070b315333ee ("perf test: Restrict uniquifying test to machines wi=
th 'uncore_imc'")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  .../tests/shell/stat+event_uniquifying.sh     | 109 ++++++++----------
>  1 file changed, 49 insertions(+), 60 deletions(-)
>
> diff --git a/tools/perf/tests/shell/stat+event_uniquifying.sh b/tools/per=
f/tests/shell/stat+event_uniquifying.sh
> index bf54bd6c3e2e..b5dec6b6da36 100755
> --- a/tools/perf/tests/shell/stat+event_uniquifying.sh
> +++ b/tools/perf/tests/shell/stat+event_uniquifying.sh
> @@ -4,74 +4,63 @@
>
>  set -e
>
> -stat_output=3D$(mktemp /tmp/__perf_test.stat_output.XXXXX)
> -perf_tool=3Dperf
>  err=3D0
> +stat_output=3D$(mktemp /tmp/__perf_test.stat_output.XXXXX)
>
> -test_event_uniquifying() {
> -  # We use `clockticks` in `uncore_imc` to verify the uniquify behavior.
> -  pmu=3D"uncore_imc"
> -  event=3D"clockticks"
> -
> -  # If the `-A` option is added, the event should be uniquified.
> -  #
> -  # $perf list -v clockticks
> -  #
> -  # List of pre-defined events (to be used in -e or -M):
> -  #
> -  #   uncore_imc_0/clockticks/                           [Kernel PMU eve=
nt]
> -  #   uncore_imc_1/clockticks/                           [Kernel PMU eve=
nt]
> -  #   uncore_imc_2/clockticks/                           [Kernel PMU eve=
nt]
> -  #   uncore_imc_3/clockticks/                           [Kernel PMU eve=
nt]
> -  #   uncore_imc_4/clockticks/                           [Kernel PMU eve=
nt]
> -  #   uncore_imc_5/clockticks/                           [Kernel PMU eve=
nt]
> -  #
> -  #   ...
> -  #
> -  # $perf stat -e clockticks -A -- true
> -  #
> -  #  Performance counter stats for 'system wide':
> -  #
> -  # CPU0            3,773,018      uncore_imc_0/clockticks/
> -  # CPU0            3,609,025      uncore_imc_1/clockticks/
> -  # CPU0                    0      uncore_imc_2/clockticks/
> -  # CPU0            3,230,009      uncore_imc_3/clockticks/
> -  # CPU0            3,049,897      uncore_imc_4/clockticks/
> -  # CPU0                    0      uncore_imc_5/clockticks/
> -  #
> -  #        0.002029828 seconds time elapsed
> -
> -  echo "stat event uniquifying test"
> -  uniquified_event_array=3D()
> +cleanup() {
> +  rm -f "${stat_output}"
>
> -  # Skip if the machine does not have `uncore_imc` device.
> -  if ! ${perf_tool} list pmu | grep -q ${pmu}; then
> -    echo "Target does not support PMU ${pmu} [Skipped]"
> -    err=3D2
> -    return
> -  fi
> +  trap - EXIT TERM INT
> +}
>
> -  # Check how many uniquified events.
> -  while IFS=3D read -r line; do
> -    uniquified_event=3D$(echo "$line" | awk '{print $1}')
> -    uniquified_event_array+=3D("${uniquified_event}")
> -  done < <(${perf_tool} list -v ${event} | grep ${pmu})
> +trap_cleanup() {
> +  echo "Unexpected signal in ${FUNCNAME[1]}"
> +  cleanup
> +  exit 1
> +}
> +trap trap_cleanup EXIT TERM INT
>
> -  perf_command=3D"${perf_tool} stat -e $event -A -o ${stat_output} -- tr=
ue"
> -  $perf_command
> +test_event_uniquifying() {
> +  echo "Uniquification of PMU sysfs events test"
>
> -  # Check the output contains all uniquified events.
> -  for uniquified_event in "${uniquified_event_array[@]}"; do
> -    if ! cat "${stat_output}" | grep -q "${uniquified_event}"; then
> -      echo "Event is not uniquified [Failed]"
> -      echo "${perf_command}"
> -      cat "${stat_output}"
> -      err=3D1
> -      break
> -    fi
> +  # Read events from perf list with and without -v. With -v the duplicat=
e PMUs
> +  # aren't deduplicated. Note, json events are listed by perf list witho=
ut a
> +  # PMU.
> +  read -ra pmu_events <<< "$(perf list --raw pmu)"
> +  read -ra pmu_v_events <<< "$(perf list -v --raw pmu)"
> +  # For all non-deduplicated events.
> +  for pmu_v_event in "${pmu_v_events[@]}"; do
> +    # If the event matches an event in the deduplicated events then it m=
usn't
> +    # be an event with duplicate PMUs, continue the outer loop.
> +    for pmu_event in "${pmu_events[@]}"; do
> +      if [[ "$pmu_v_event" =3D=3D "$pmu_event" ]]; then
> +        continue 2
> +      fi
> +    done
> +    # Strip the suffix from the non-deduplicated event's PMU.
> +    event=3D$(echo "$pmu_v_event" | sed -E 's/_[0-9]+//')
> +    for pmu_event in "${pmu_events[@]}"; do
> +      if [[ "$event" =3D=3D "$pmu_event" ]]; then
> +        echo "Testing event ${event} is uniquified to ${pmu_v_event}"
> +        if ! perf stat -e "$event" -A -o ${stat_output} -- true; then
> +          echo "Error running perf stat for event '$event'  [Skip]"
> +          if [ $err =3D 0 ]; then
> +            err=3D2
> +          fi
> +          continue
> +        fi
> +        # Ensure the non-deduplicated event appears in the output.
> +        if ! grep -q "${pmu_v_event}" "${stat_output}"; then
> +          echo "Uniquification of PMU sysfs events test [Failed]"
> +          cat "${stat_output}"
> +          err=3D1
> +        fi
> +        break
> +      fi
> +    done
>    done
>  }
>
>  test_event_uniquifying
> -rm -f "${stat_output}"
> +cleanup
>  exit $err
> --
> 2.51.0.470.ga7dc726c21-goog
>
>

