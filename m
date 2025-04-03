Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22D62566D2
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Apr 2025 19:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743708351; cv=none; b=sXqvc+r3FfuHvGcRnWNOumL5E8MGe1T7Qur79ycqYVMgHMGkpUvXjThovVSlf2J/5HOctbsuHKz8FJ7fAt1XgIEeaJFk1ucZ1d2HJwxwL0KzdxTowQa56stFHkJYLv6dvkvsRmA6db9qYpqQdhlGACFE8vIlrLkNjswk62Dopgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743708351; c=relaxed/simple;
	bh=YRYgeYQSKEHiXrpTyUfWdnZFevy6BffJsGN8Akt6M4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7Zde5Tetwqe/vxzfbpu2wJzbCLd/XREBw7g/wflxj3zlVYy37LcRdPS+WpAqIU2CIiMnxWJv9SfghDR2OMTmh6fwX+yQx28cw1A83DtZoNoIjJoJnXMr7161Gow3eXhJThrykz0buJUfbWPUrVXyHV8hFuWX57jDR8DPbns8uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uNNBPw7m; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uNNBPw7m"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2240aad70f2so45695ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Apr 2025 12:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743708349; x=1744313149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPvfod2EQkGJmMMdAOg2BjArURxHw4Y566D3WCYMQmQ=;
        b=uNNBPw7mv4Q6buf15nJ17+oXiEXKM/tGqsxbPx4ari1QvLwWMy5dvHQci30yiAa5jv
         JKFbE5THlw6K9nrkV3AJc5FI5XjFyxZlKWhyo6YR15EPaFSW6fr88kPvn+X+n1B9i0HL
         l6HqGwbulKx5OU/SMszCvWXuDE5ZX8TzgVm2fixrkSNoFyctG8YGk+bi9PY4WnWnQ4cR
         qAbm0sobItFeQwP063wOkljaFP5L4zGw1u15AIxtz3NCBICSNZzfKChEP9tq7aU7cc5r
         1GUph0Bc0gqtmxAFr/s9tBunCBtzX4SoSpbUOC/pXaPwA7FzzF8fS+TCk5mmyo+Eckfd
         wlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743708349; x=1744313149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPvfod2EQkGJmMMdAOg2BjArURxHw4Y566D3WCYMQmQ=;
        b=sCgLWG/Sw7R6UnuK2zSq/2iQp2vmHjMnTas7SvrGQN7s2+R4hQWRfr63TXhWIW3wmq
         /jxQ8SLCBpdT3BawM46MwNTWmMU5sespb/INY7/+BE3kbsjpA6Y2lLNVYFGiwelHwKP0
         qs+mthYxmib/xZ43abLMl0GQes4RRqZQY6ZQ1s+n3qotaeP5ngPkTuyy3CzJuNaI5XVi
         qme2CQWCvUKt0PFO769yIhxkOEyOjPtJQY1PhNztI57Hu+fNCWnjNxDjm4BeDbO0UzgM
         IBolzpR9FXny2lsD2SlqILz87Z5Pqv8HlDz5oe6a5cGhHxvPIYUSdgGJ2kJrRxNJwsNg
         +auw==
X-Forwarded-Encrypted: i=1; AJvYcCUqOXSMj7ckrkIgo0pdvMEJb5CoHxowASfFo/4+/OqkP0FA1N71OBf2ZOzSBpDfuGeVzMHfOIA7GwVCOg69au8C@vger.kernel.org
X-Gm-Message-State: AOJu0YwRbGMDeVG0uy0wNL+8+iW/X2wmOSsEE2Ch2cYV6zXM2Dird3Ye
	6Fr4MW4mdwwQjR0lAVmZ0mkSnjZznSutMjBThXb3MDKRSNOw1kgEfeF1MgVfXRkToDzVWsM8rQR
	HxUyyb/u+UMB1M8ceKT0gKtkzVITs9BD+NkZz
X-Gm-Gg: ASbGncu2g3+4zgG3RDd2/FaexB2yVahdvDF92bj2tRStpql1W0jluqK9hxxiANGnXDS
	4ftmEBq+wJD2rmva0zWbobvnLZhlIufVFS1k4j5L/CweFGaENP9ZC3eU0qYTrCa89ohd+7BH3MZ
	SmDIrV6QsVuqZ40/v+vSMPhu/kAJQWIDbPBT6AmxuWI80Pvc+qUzRe
X-Google-Smtp-Source: AGHT+IGeE5vqLWQN/fZPk9rHzFvK6lM4bgUROZNOY4HEeGZzv3ni4YTk2CUz6tJ/dpzj1TbrPnfdEN3AJ6kaS3kZ9/A=
X-Received: by 2002:a17:902:cecc:b0:215:86bf:7e46 with SMTP id
 d9443c01a7336-22a8a0b3330mr316915ad.7.1743708348732; Thu, 03 Apr 2025
 12:25:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327225651.642965-1-ctshao@google.com> <20250327225651.642965-4-ctshao@google.com>
In-Reply-To: <20250327225651.642965-4-ctshao@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 3 Apr 2025 12:25:37 -0700
X-Gm-Features: AQ5f1JoLAY-0cavb_6d6-MpwT45J3yizJBaVL5nve2gtkYrURArsW8pQgPtBvyI
Message-ID: <CAP-5=fU37XBFa-kft5JYPO+BCWP5zGnfZCkCqvzYW-yozF8o0g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] perf test: Add stat uniquifying test
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, ak@linux.intel.com, howardchu95@gmail.com, 
	linux@treblig.org, yeoreum.yun@arm.com, james.clark@linaro.org, 
	weilin.wang@intel.com, asmadeus@codewreck.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 4:01=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> w=
rote:
>
> The `stat+uniquify.sh` test retrieves all uniquified `clockticks` events
> from `perf list -v clockticks` and check if `perf stat -e clockticks -A`
> contains all of them.
>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
>  .../tests/shell/stat+event_uniquifying.sh     | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100755 tools/perf/tests/shell/stat+event_uniquifying.sh
>
> diff --git a/tools/perf/tests/shell/stat+event_uniquifying.sh b/tools/per=
f/tests/shell/stat+event_uniquifying.sh
> new file mode 100755
> index 000000000000..5ec35c52b7d9
> --- /dev/null
> +++ b/tools/perf/tests/shell/stat+event_uniquifying.sh
> @@ -0,0 +1,69 @@
> +#!/bin/bash
> +# perf stat events uniquifying
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +stat_output=3D$(mktemp /tmp/__perf_test.stat_output.XXXXX)
> +perf_tool=3Dperf
> +err=3D0
> +
> +test_event_uniquifying() {
> +  # We use `clockticks` to verify the uniquify behavior.
> +  event=3D"clockticks"

This event is generally only available on Intel, not AMD or ARM, so we
will need to skip if it isn't present.

> +  # If the `-A` option is added, the event should be uniquified.
> +  #
> +  # $perf list -v clockticks
> +  #
> +  # List of pre-defined events (to be used in -e or -M):
> +  #
> +  #   uncore_imc_0/clockticks/                           [Kernel PMU eve=
nt]
> +  #   uncore_imc_1/clockticks/                           [Kernel PMU eve=
nt]
> +  #   uncore_imc_2/clockticks/                           [Kernel PMU eve=
nt]
> +  #   uncore_imc_3/clockticks/                           [Kernel PMU eve=
nt]
> +  #   uncore_imc_4/clockticks/                           [Kernel PMU eve=
nt]
> +  #   uncore_imc_5/clockticks/                           [Kernel PMU eve=
nt]
> +  #
> +  #   ...
> +  #
> +  # $perf stat -e clockticks -A -- true
> +  #
> +  #  Performance counter stats for 'system wide':
> +  #
> +  # CPU0            3,773,018      uncore_imc_0/clockticks/
> +  # CPU0            3,609,025      uncore_imc_1/clockticks/
> +  # CPU0                    0      uncore_imc_2/clockticks/
> +  # CPU0            3,230,009      uncore_imc_3/clockticks/
> +  # CPU0            3,049,897      uncore_imc_4/clockticks/
> +  # CPU0                    0      uncore_imc_5/clockticks/
> +  #
> +  #        0.002029828 seconds time elapsed
> +
> +  echo "stat event uniquifying test"
> +  uniquified_event_array=3D()
> +
> +  # Check how many uniquified events.
> +  while IFS=3D read -r line; do
> +    uniquified_event=3D$(echo "$line" | awk '{print $1}')
> +    uniquified_event_array+=3D("${uniquified_event}")
> +  done < <(${perf_tool} list -v ${event} | grep "\[Kernel PMU event\]")

Shouldn't the array contain every sysfs event that doesn't have a json
component? They may or may not be uniquified so I think the array name
is misleading.

> +  perf_command=3D"${perf_tool} stat -e $event -A -o ${stat_output} -- tr=
ue"
> +  $perf_command
> +
> +  # Check the output contains all uniquified events.
> +  for uniquified_event in "${uniquified_event_array[@]}"; do
> +    if ! cat "${stat_output}" | grep -q "${uniquified_event}"; then

Why not pass the file directly to grep?
Should some of the events not show in the stat output as you only
asked for the clockticks event? I'm not sure how this test can pass
currently.

Thanks,
Ian

> +      echo "Event is not uniquified [Failed]"
> +      echo "${perf_command}"
> +      cat "${stat_output}"
> +      err=3D1
> +      break
> +    fi
> +  done
> +}
> +
> +test_event_uniquifying
> +rm -f "${stat_output}"
> +exit $err
> --
> 2.49.0.472.ge94155a9ec-goog
>
