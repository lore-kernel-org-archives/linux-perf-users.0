Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BED613D521
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Dec 2024 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734801022; cv=none; b=Gi3skRy4/qDu2CZ5wlK0CCpbuRg1E9veAmgi8B7yxekm595YMMMKOp7kpFwUMRaUU6C+hPxo4/6ADheRXTmowBfpYxhOPAXFgdVb0WLKRV8tzofyZwvaIm0e7Jeu1FpTaAyj+kf4iRcJYM1c8zKKH90KSkGlcV/kqR0c/QjWls8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734801022; c=relaxed/simple;
	bh=tqgHSbvRKdxXnSPWyjYOYpuio6QQSn7kWDbj2OAVc5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pw6Vai2H8EgBJGKWFyV+iOOmW8FnW14KB6d4eeP/xILr01MsO2yKDamiIISVLWvDGcE5CqeXk4Y7mkPWBXLw4irKE4LbQkjamx5byaYZr8J9LDtoKBpj9jamrkomrgClnKWSG4sJXe350gFsv2HoqzUoRzKZiyNdnTln5mmSKDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YJ3izos3; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YJ3izos3"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a815a5fb60so329125ab.0
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Dec 2024 09:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734801020; x=1735405820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLmKsV/RWaRLBbqJb1Z1njuLAOUOlvnE81C/TcIrFFQ=;
        b=YJ3izos3PgVuYOpQLOu8BYaI5/tlBMMWlf/cqp+txa5o+ZKd2t1vQmOXf9MseRBccL
         7yQDrjZiDhOpxlODucwHh1euW/SBGhJJebfpu2zvDR8wEv57VClBCLhPVcksAdpq6iZC
         EESlde3SC03mK521OTitWyvcMWZeDIgnc5/774MZ7HK2B0uQA5+YyBxWLTnIX75Zqmkh
         XqIFyncAtG0bRs10t+IHYXegAiFapgs7jHJIFYj0CVz6e2BKZBaTS60+bUXDY3unGDwV
         ik5OxPgnBr5EhPb6BA0agE8hFwSxgTcvsyRIR+JssA04Pj6GHKZSS7wexa8ai+tcsqJD
         RDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734801020; x=1735405820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLmKsV/RWaRLBbqJb1Z1njuLAOUOlvnE81C/TcIrFFQ=;
        b=c74lZJcASZpxQHmcSAKGnGmthBHUDbuLMNAgluFwILiBc4GjidEtxQ3M7LFvy5at9g
         jCATJZl565zwa+rLgTuWrxK9pf/NW3g1TtssxcWK80gse+WrINKiT5Jhy1PxUHfzRlkJ
         oKqIoCsFc9BYr3RaPtdXZJ0Gxu7ABmBD/Cb9ITX2NOBZUPZ4FSDjpxNrKMSE6+Ei008k
         /oQVhJG2fXnLC2xBKta4yoVUmaBJhJ2ISeVHDjrnaQ90Fxo2JOmgfTyOB7ggajk29gJx
         v/tBvAnimqhEnU2kDHqZpy+jKUdb9pUk+zkfNyvAmA/3jbM6Ud9g2zKskumBNGqqPRMS
         kgBA==
X-Forwarded-Encrypted: i=1; AJvYcCXpLCKIqcpamKFfHFIqmaQqtErt4OtaouTLOQ/LaVVz2xZM3Om+fVuyw5kCaNDOhK6Eocej4kHPAIiJafzqNlny@vger.kernel.org
X-Gm-Message-State: AOJu0YyW8Wa3yQgx57t6UvYd6P5xo0REQnoMOtlWD+iVaQ2rxkmjFHsg
	k8xb9iI8zp9bYWC6TphLprsV7wxxFqif4zNHzcZoPEkDN8p/sZELQEKbsSEy9KjjNb9oIhSew0d
	hMo9BacXpzzQByd3lGBVg/CkHpWeE9chCxjqPbJhAxAY0LO2JaF7fN+E=
X-Gm-Gg: ASbGncsQYHr9SljOgj7EQHuTcC79f179h6s2qFLDqBNiZqhpWEWY9R/vB0fvgJs83aW
	isQIH+OeBe2jIQKm5FHiDrC/XmkP+CIfzxzsHo0Q=
X-Google-Smtp-Source: AGHT+IGrRHybQh/aur9GJ8vVi28AsUwCbp3ZCmsIhbcUOMxxOXLFLjFa5VFGKP7sPPJLH8+lCdFKWyLkV5iiR+1KNxc=
X-Received: by 2002:a92:c569:0:b0:3a0:9f85:d768 with SMTP id
 e9e14a558f8ab-3c33139a32cmr5379575ab.11.1734801020409; Sat, 21 Dec 2024
 09:10:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216070244.14450-1-adrian.hunter@intel.com> <20241216070244.14450-8-adrian.hunter@intel.com>
In-Reply-To: <20241216070244.14450-8-adrian.hunter@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 21 Dec 2024 09:10:09 -0800
Message-ID: <CAP-5=fUwjYH8uvmsgSN=1exN1FEEBEPQHFYwgq4cJEeOApFNQg@mail.gmail.com>
Subject: Re: [PATCH V16 7/7] perf intel-pt: Add a test for pause / resume
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 11:03=E2=80=AFPM Adrian Hunter <adrian.hunter@intel=
.com> wrote:
>
> Add a simple sub-test to the "Miscellaneous Intel PT testing" test to
> check pause / resume.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Acked-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/tests/shell/test_intel_pt.sh | 28 +++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/s=
hell/test_intel_pt.sh
> index e6f0070975f6..f3a9a040bacc 100755
> --- a/tools/perf/tests/shell/test_intel_pt.sh
> +++ b/tools/perf/tests/shell/test_intel_pt.sh
> @@ -644,6 +644,33 @@ test_pipe()
>         return 0
>  }
>
> +test_pause_resume()
> +{
> +       echo "--- Test with pause / resume ---"
> +       if ! perf_record_no_decode -o "${perfdatafile}" -e intel_pt/aux-a=
ction=3Dstart-paused/u uname ; then
> +               echo "SKIP: pause / resume is not supported"
> +               return 2
> +       fi
> +       if ! perf_record_no_bpf -o "${perfdatafile}" \
> +                       -e intel_pt/aux-action=3Dstart-paused/u \
> +                       -e instructions/period=3D50000,aux-action=3Dresum=
e,name=3DResume/u \
> +                       -e instructions/period=3D100000,aux-action=3Dpaus=
e,name=3DPause/u uname  ; then
> +               echo "perf record with pause / resume failed"
> +               return 1
> +       fi
> +       if ! perf script -i "${perfdatafile}" --itrace=3Db -Fperiod,event=
 | \
> +                       awk 'BEGIN {paused=3D1;branches=3D0}
> +                            /Resume/ {paused=3D0}
> +                            /branches/ {if (paused) exit 1;branches=3D1}
> +                            /Pause/ {paused=3D1}
> +                            END {if (!branches) exit 1}' ; then
> +               echo "perf record with pause / resume failed"
> +               return 1
> +       fi
> +       echo OK

Hi,

this new test is now constantly making "Miscellaneous Intel PT testing" fai=
l:

```
...
--- Test with pause / resume ---
Error:
Failure to open event 'intel_pt/aux-action=3Dstart-paused/u' on PMU
'intel_pt' which will be removed.
The 'aux_action' feature is not supported, update the kernel.
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.003 MB
/tmp/perf-test-intel-pt-sh.Hs8jcq0ADc/test-perf.data ]
Error:
Failure to open event 'intel_pt/aux-action=3Dstart-paused/u' on PMU
'intel_pt' which will be removed.
The 'aux_action' feature is not supported, update the kernel.
Error:
Failure to open event 'Resume' on PMU 'cpu' which will be removed.
The 'aux_action' feature is not supported, update the kernel.
Error:
Failure to open event 'Pause' on PMU 'cpu' which will be removed.
The 'aux_action' feature is not supported, update the kernel.
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.005 MB
/tmp/perf-test-intel-pt-sh.Hs8jcq0ADc/test-perf.data ]
perf record with pause / resume failed
--- Cleaning up ---
...
```

Should the fail be turned into a skip for missing kernel support?

Thanks,
Ian

> +       return 0
> +}
> +
>  count_result()
>  {
>         if [ "$1" -eq 2 ] ; then
> @@ -672,6 +699,7 @@ test_power_event                    || ret=3D$? ; cou=
nt_result $ret ; ret=3D0
>  test_no_tnt                            || ret=3D$? ; count_result $ret ;=
 ret=3D0
>  test_event_trace                       || ret=3D$? ; count_result $ret ;=
 ret=3D0
>  test_pipe                              || ret=3D$? ; count_result $ret ;=
 ret=3D0
> +test_pause_resume                      || ret=3D$? ; count_result $ret ;=
 ret=3D0
>
>  cleanup
>
> --
> 2.43.0
>
