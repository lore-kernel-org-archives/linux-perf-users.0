Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8297B12C47A
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Apr 2024 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713279842; cv=none; b=Ob0b/ApWUrB1k3ui7xa4nZcgnkGdt3NH/rc34+09sqc/UrwysaMzH5A57C24hoTr7tgA9BjppFqgya1YGEfVMArfr3gtlhz5oHAsbTl08rJeRi1hVK0yLgnyDqZOomxZknUy20A/tR7eMfjO+J2/B6rk8XBcESwOsqKsk/vBnQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713279842; c=relaxed/simple;
	bh=2cgS3r5b01mMZQf2s06t0d7+O/XGgS0PkwBg/laRHm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jOdNTusEIF1PONOoOb6DhZKPW55zZMdBtkUAoPgBZnr8ah3ZIObEk4IfQivGwASt5mKd5XhOANYeAJSPIjplI+nV51UDbReVnuf4AuofJGihhJ+beh84tymqczgjKh3xWs6cq/t3TonR+XkicKuX23uFBLbUmAygWr9Eh9ZkRhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R4dzV8tc; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R4dzV8tc"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e44f82ff9cso145815ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Apr 2024 08:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713279837; x=1713884637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTbHn7KXi7MSOhS4QcXocuIOO4406QhuIHoSwR8an08=;
        b=R4dzV8tcXMiKRJ77DzSODXdJpynCnLqgwt2mfhm8eOWuzAjjisrjmgn/Udggo1NVGU
         jk+JhXyEwRTy4YGjQ1rDt8lSwrXEwknUNY2kS+iMVwDilF+mDp9UArz9zYTt5nlNJy3e
         HUzQ3Ct7HBa4U/KjCxhjwxSwRaglj3kNcNt7nsTTHyJhoz25yC79dwpYf+EufZ0dlFFD
         yLfPSIigwx5yhK3pI25nZxqWKdWOEx5HvM8otqN777HqV6qDWyU50Peyv1A8rjIyyEgR
         2XpUKfMy4l2r5EuU71FsvuMseQwJLpspWGfHMknuyTj9eyOpyLvBd1J5h7gyLLpCKT3j
         3IbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713279837; x=1713884637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTbHn7KXi7MSOhS4QcXocuIOO4406QhuIHoSwR8an08=;
        b=wa3xrwHEft+XXAxM5lLT4KPGZt5L1ZlZJEYj1lLUrb8SYC/BHwptb40DLriCLF/5pI
         JUfHCCHhxeIlWfjU9G1jitrBgmn57KVnob8M5Yefv09QOX9r47Pja6UsVMF2h6Vb3ipY
         3iMXlFagNgunl6SKyfRQKVGOM9DkBqQdzMmwSMtcYL/0uoEIdJ7h7FKu50YOMGb+Fw7j
         VNATqHIuWkAxcEzXD8GDliyfBJwZSvivcAildcmXEjT9bGD451L2+5mNa0Lo7zcW2bgh
         99uN27wfSAL9Wh+g52sCbZuHDZHp37tGLnVO19wn2CB0oowN5cnbJmTu29OrYJQge8au
         EGmw==
X-Gm-Message-State: AOJu0YweuMTqhPhnM/oxl3VIrwHnSvy9JGUbr2OwxCfh5O22oJq68HPU
	Y3XoELHVUFEP2fZyAQW763FUe6ksP1GXkt4nR2807wVD6EgSCjdZHywKZhKcl9JwEvWptwIrF5W
	xO65lb32FkfsRWpK2AR2DMAgAh7yA26zioJ39
X-Google-Smtp-Source: AGHT+IGQBEApKZ4ZqsdJJ8wEwkUrcTQHNJK6+nGqThM6qiMmEWzJfRClSFS+rZNoEarSTMArYmM77p2Ox+6QVPOjh44=
X-Received: by 2002:a17:902:d2c1:b0:1e2:c902:57b9 with SMTP id
 n1-20020a170902d2c100b001e2c90257b9mr269189plc.28.1713279836180; Tue, 16 Apr
 2024 08:03:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409130240.13973-1-vmolnaro@redhat.com>
In-Reply-To: <20240409130240.13973-1-vmolnaro@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Apr 2024 08:03:41 -0700
Message-ID: <CAP-5=fVzs9832tK9nrxL++DZXwNV0eLmMwtd4ZNqkp4b512UHQ@mail.gmail.com>
Subject: Re: [PATCH] perf test stat_all_pmu.sh: Parse return value of perf stat
To: vmolnaro@redhat.com
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com, 
	mpetlan@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 6:03=E2=80=AFAM <vmolnaro@redhat.com> wrote:
>
> From: Veronika Molnarova <vmolnaro@redhat.com>
>
> With the MR a381bd3615de6 ('powerpc/hv-gpci: Fix the
> H_GET_PERF_COUNTER_INFO hcall return value checks') the perf stat for
> hv_gpci events without required permission set returns an error value
> of -1 to differentiate the output from the unsupported events. The
> stat_all_pmu test, however, exits immediately if any command exits with
> a non-zero value due to 'set -e' option.
>
> Remove the 'set -e' option from the test and rework the test case to log
> the status of the event for better maintainability. Instead of exiting
> immediately after 'perf stat' ends with a non-zero value, check the
> return value and output of the 'perf stat' command with appriopriate acti=
on.

nit: s/appriopriate/appropriate/

There was a similar issue with metric groups that should be on its way
to landing:
https://lore.kernel.org/lkml/20240403164818.3431325-1-irogers@google.com/

> ---
>  tools/perf/tests/shell/stat_all_pmu.sh | 36 ++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 11 deletions(-)
>
> diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/sh=
ell/stat_all_pmu.sh
> index c77955419173..d9f0d2100baa 100755
> --- a/tools/perf/tests/shell/stat_all_pmu.sh
> +++ b/tools/perf/tests/shell/stat_all_pmu.sh
> @@ -2,21 +2,35 @@
>  # perf all PMU test
>  # SPDX-License-Identifier: GPL-2.0
>
> -set -e
>
>  # Test all PMU events; however exclude parametrized ones (name contains =
'?')
>  for p in $(perf list --raw-dump pmu | sed 's/[[:graph:]]\+?[[:graph:]]\+=
[[:space:]]//g'); do
> -  echo "Testing $p"
> -  result=3D$(perf stat -e "$p" true 2>&1)
> -  if ! echo "$result" | grep -q "$p" && ! echo "$result" | grep -q "<not=
 supported>" ; then
> -    # We failed to see the event and it is supported. Possibly the workl=
oad was
> -    # too small so retry with something longer.
> -    result=3D$(perf stat -e "$p" perf bench internals synthesize 2>&1)
> -    if ! echo "$result" | grep -q "$p" ; then
> -      echo "Event '$p' not printed in:"
> -      echo "$result"
> -      exit 1
> +  echo -n "Testing event '$p' -- "
> +  stat_output=3D$(perf stat -e "$p" true 2>&1)
> +  stat_result=3D$?
> +  if echo "$stat_output" | grep -q "$p"; then
> +    # return value 0 if counters gets printed either if the event is sup=
ported or not
> +    if [ $stat_result -eq 0 ] && ! echo "$stat_output" | grep -q "<not s=
upported>"; then
> +        echo "supported"
> +    elif [ $stat_result -eq 0 ]; then
> +        echo "not supported"
> +    # return value 255 when the required pemission for the event is not =
set

nit: s/pemission/permission/

> +    elif [ $stat_result -eq 255 ] && echo "$stat_output" | grep -q "No p=
ermission"; then
> +        echo "no permission to enable"
> +    # return value 129 when trying to run 'perf stat' with a non-existen=
t event
> +    elif [ $stat_result -eq 129 ] && echo "$stat_output" | grep -q "Bad =
event name"; then
> +        echo "Fail: Bad event name"
> +        echo "$stat_output"
> +        exit 1

Something we've been seeing with parallel testing is getting busy
PMUs. The error looks like:
```
$ sudo bash -c "perf stat -e intel_bts// -a sleep 1; echo $?" & sudo
bash -c "perf stat -e intel_bts// -a sleep 1; echo $?"
[2] 953102
Error:
The sys_perf_event_open() syscall returned with 16 (Device or resource
busy) for event (intel_bts//).
/bin/dmesg | grep -i perf may provide additional information.

255

Performance counter stats for 'system wide':

    <not counted>      intel_bts//
                        (0.00%)

      1.002334792 seconds time elapsed

0
[2]+  Done                    sudo bash -c "perf stat -e intel_bts//
-a sleep 1; echo $?"
```

To avoid failing for this we probably need something like:
```
   elif [ $stat_result -eq 255 ] && echo "$stat_output" | grep -q
"Device or resource busy"; then
       echo "device busy"
```
It'd be great if you could add this.

Thanks,
Ian

> +    else
> +        echo "Fail: Unknown return value $stat_result"
> +        echo "$stat_output"
> +        exit 1
>      fi
> +  else
> +      echo "Fail: Event '$p' not printed in:"
> +      echo "$stat_output"
> +      exit 1
>    fi
>  done
>
> --
> 2.43.0
>
>
