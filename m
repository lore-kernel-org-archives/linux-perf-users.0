Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BAA1E230E
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 06:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775023585; cv=pass; b=Ra1Q/zW+J872rSWjdWLl8C6RsDSRXxAOGazhGWQ+T81Ds5B1y7tgtkAp9SO2unnx3b8g/zfPBJiv32lqrwwdEhuwFYIYfSmXaGYNYWR9S3nyNmurr/5fXTnc4Rxd60HHUwfRNLCTQIzeb0DXRz0pFtJDTLQ6UobFhXswCwjQjYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775023585; c=relaxed/simple;
	bh=UmFwinRejztxzsMq8+NIVmWPiWHafxcMj3kLU1MGmI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMPWvSdJg9PnSMo7bHMmDzJCqM/pPx3Vpq3Lkf5Z73/C5n67x7Vi5sPCLem9nMvL655UAFevbezTXFSUUJgxpZrecUfHy5q2yprXpdAz7bvnZQj5ZJeZtY+u2ttKt7KrzIDqGVR5R7ltgZTKWY9rgUeFssRiOixdQAFS4rG+MT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E/4OgAyP; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E/4OgAyP"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b0b260d309so146575ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 23:06:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775023584; cv=none;
        d=google.com; s=arc-20240605;
        b=bOaMSCHCng+GNOpsKaXio+T+WcG/opTXPozwZ98rMX45UnVLObmKPI0zMueHYoa4/7
         TyQXK50R3DbbRo6OWNZE1aqAk2M+aB4lhR4ICHTbQlfJxiS19Iifa5DEjbY6BTZGW10W
         1mM/WL3EGWT60ARnv7WqVwDtT9H1wlVWViU6V69/h4vJt81lYuB7qD1MJyRg/xD9GdFv
         anxqm9NxHm4km3bWUDVpDq1wDDmkCmPvgLk4a1uX9THhIhUpIAApg8loS5Wh3Y9XWmq6
         fHA8R7NxnH7x8JqxlbdKLOYtCfX2H4LltGy9rV5KLbNyBtFZwKNriVK/MdepDgowKQiP
         n6lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yKDhWCtNqP0nDMWkjoldbuAKb5syO75dCIFO52MFL6Y=;
        fh=oBkk2kkmeh76AadTBnoqf+FnTk/B2r09qmlc2VA4i70=;
        b=DRxnfYUnYPMcQ7/zySCr+cId5ClEWFY2TZZ3idA67uMMFLr/49fsxwQadYB5IeB3U7
         Zgn9qS8DjZz9XXKrwZtXCe1cXK0F4M/NbzVS7W/5071/6EzTq4zsdz+1wYHS1T352vbf
         Kd/TSuRfOwO40H8iQbnpe9SluscUwgbgN5BHI+e4K9OM+q99REpDyhGbkYgBhANz8Xog
         Pf9Zt6zmYAo4SiFSPYI8+/RQsZV43xhwLeoCMg8Y3KVOJ+soQ5RVk3/v/LJfB1dCEs+B
         3ZpXj0yobml9P/4P0cPDrlj0bHbA0Puq6+tWJ0SYfQd7P5H7vz7Q2vca4HTbV1OmCrAW
         EDnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775023584; x=1775628384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKDhWCtNqP0nDMWkjoldbuAKb5syO75dCIFO52MFL6Y=;
        b=E/4OgAyP+TN5ef4wva8Vr1+B9X1YAGVpYGLgM1s4ABPHKTT9PDx/N8vsLcgMYyPOJh
         OT3gv5WqZlgVsVBnHCSLs4tbOliMwuUwD0YTiAIpkuAlrhVk3L+yB6gCkh8Su9ONbd7h
         vbFvVmVYOEuKH/AxeOFh1MX5Rf4JWXc14H1pFZcX3AnHTuUqgglh2Qs6T4b4HvpOrxE2
         /JI1XGZ8C5Rr9U5hC3fvBNHQbmPaBHj7E/wvz1oCkWGAV6/CnYjggvSH4H7VZ6w5NqBx
         f5QGYVVbdRYP43Yw7Yq9bdfAq5qY0D80yu0RCuCb+GLXLAK7zJjMeM8TBsDOlszPlSH7
         QDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775023584; x=1775628384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yKDhWCtNqP0nDMWkjoldbuAKb5syO75dCIFO52MFL6Y=;
        b=n78UWVJGbf/we9PIPD69o3DA53AGghvbwEO9+FRj04xfgboGHCLt2KeFhE3ZcNpzkn
         BEFqU2c8AbUwGMAMIW2U3OV3qmE/XaK2PI/+mX1S6Wf1dR4sUymS+pxqbtF1vYdcUD6p
         WOk24CAfO1+jveFFS/CKj6nVYFJzSk9IiUMw9Vsf/eWtlNwIcH8hIqUl60A+GkCt27Ng
         tULEo5D+Vyhuu1AfP2c7+SPrxsqBtTAGroMwsVOR9Jn3wNtldOrelaO6D7PpK5Fu4kZa
         IMGZcZAefiZ+v+q50Zix829O1rm2pmF2TR/spu0izYXrgnZFUIzau7UEqXNxBBjZvqkQ
         PBCg==
X-Forwarded-Encrypted: i=1; AJvYcCV6p7RWVf2K4DXrjdzpH0a2j4AP1QBEAKmGKrkwrRv4FTnUqppDzJpmdiuElbpxXgAz3q1up2Hs4nZscjROE1W2@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzh78xI0N9hca1qqvqfBGDzNdwzYebKcO4HuYKWuymyh46n1s0
	HWu0dcuRJr/HkHXwiYBKRjbXsokhNKJQptJUs/iX89Wpt5Bx0LL0Bm7e23dIzK3i4pde0ryMP1f
	LSyWXmA4QNZ/7vA1nh1/POCMJu2F/0RppiNf74QbM
X-Gm-Gg: ATEYQzzAQWNOzrRRjPRpjo2DvkAxb2GHdAlFksKFjeq3RnDdqG51at00Q1b48UA5rzr
	mNf1dDewOFnORpvtAT4uSJsiR6ORa4Yz9zCeb/qYrHs683d9HE/2sKhNycg3ujwk2MUsZ807r92
	iUwrsAejAXQsrWl8UbXlVW2gK6+15Yb4QladMf1LIVVrH/a0Fio0AuLdmx4fsWYevcYgbJkJlEs
	JSxR2Nxk391vwPPUoXcI+3eyfotBcS/DNXAjPYrjaET0KXHUBAL0e/vjVQZoF6H7J1puITW5rkV
	+nWj0LDI
X-Received: by 2002:a17:903:40d2:b0:2b2:4a2e:5dd5 with SMTP id
 d9443c01a7336-2b26b170a0fmr1475475ad.3.1775023583350; Tue, 31 Mar 2026
 23:06:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331112404.2167274-1-tmricht@linux.ibm.com>
In-Reply-To: <20260331112404.2167274-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 31 Mar 2026 23:06:11 -0700
X-Gm-Features: AQROBzDMbS_jC42C40Cy06Pyngmp1JBW9GA-OGPjMjqU4tWEZumtUo1s_dd9zjs
Message-ID: <CAP-5=fXywxYNNzQ1g=5=98KJxOWZggyqJCRx6xFR21_RBdgdpg@mail.gmail.com>
Subject: Re: [PATCH v2] perf test: Skip perf data type profiling tests for s390
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 4:29=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Test case 'perf data type profiling tests' fails on s390 with this
> error:
>
>   # ./perf mem record -- ./perf test -w code_with_type
>   failed: no PMU supports the memory events
>   # echo $?
>   255
>   #
>
> because s390 does not support memory events at all. According to the
> man page, perf annotate --code-with-type only works with memory
> instructions only.  As command 'perf mem record ...' is not supported
> on s390, skip this test for s390.
>
> Output before:
>  # ./perf test 'perf data type profiling tests'
>  77: perf data type profiling tests                        : FAILED!
>
> Output after:
>  # ./perf test 'perf data type profiling tests'
>  77: perf data type profiling tests                        : Skip
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Dmitrii Dolgov <9erthalion6@gmail.com>
> ---
>  tools/perf/tests/shell/data_type_profiling.sh | 24 +++++++++++++++----
>  1 file changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/tests/shell/data_type_profiling.sh b/tools/perf/t=
ests/shell/data_type_profiling.sh
> index fb47b7213b33..6eb7d96fb2b2 100755
> --- a/tools/perf/tests/shell/data_type_profiling.sh
> +++ b/tools/perf/tests/shell/data_type_profiling.sh
> @@ -14,18 +14,26 @@ testprogs=3D("perf test -w code_with_type" "perf test=
 -w datasym")
>  err=3D0
>  perfdata=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>  perfout=3D$(mktemp /tmp/__perf_test.perf.out.XXXXX)
> +perferr=3D$(mktemp /tmp/__perf_test.perf.err.XXXXX)
>
>  cleanup() {
> -  rm -rf "${perfdata}" "${perfout}"
> +  rm -rf "${perfdata}" "${perfout}" "${perferr}"
>    rm -rf "${perfdata}".old
>
>    trap - EXIT TERM INT
>  }
>
>  trap_cleanup() {
> -  echo "Unexpected signal in ${FUNCNAME[1]}"
> +  if cat "${perferr}" | grep -q 'failed: no PMU supports the memory even=
ts'
> +  then
> +    echo "${mode} annotate [Skip: perf mem record] not supported"
> +    rc=3D2

Instead of trapping and changing the error in the trap handler, can we
just explicitly test for mem events something like this:
```
perf mem record -o /dev/null true 2>&1 | grep "failed: no PMU supports
the memory events" || exit 2
```

Thanks,
Ian

> +  else
> +    echo "Unexpected signal in ${FUNCNAME[1]}"
> +    rc=3D1
> +  fi
>    cleanup
> -  exit 1
> +  exit $rc
>  }
>  trap trap_cleanup EXIT TERM INT
>
> @@ -50,12 +58,18 @@ test_basic_annotate() {
>
>    if [ "x${mode}" =3D=3D "xBasic" ]
>    then
> -    perf mem record -o "${perfdata}" ${testprogs[$index]} 2> /dev/null
> +    perf mem record -o "${perfdata}" ${testprogs[$index]} 2> "${perferr}=
"
>    else
> -    perf mem record -o - ${testprogs[$index]} 2> /dev/null > "${perfdata=
}"
> +    perf mem record -o - ${testprogs[$index]} 2> "${perferr}" > "${perfd=
ata}"
>    fi
>    if [ "x$?" !=3D "x0" ]
>    then
> +    if cat "${perferr}" | grep -q 'failed: no PMU supports the memory ev=
ents'
> +    then
> +      echo "${mode} annotate [Skip: perf mem record] not supported"
> +      err=3D2
> +      return
> +    fi
>      echo "${mode} annotate [Failed: perf record]"
>      err=3D1
>      return
> --
> 2.53.0
>
>
