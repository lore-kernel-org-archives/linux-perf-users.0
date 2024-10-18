Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2385202F73
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Oct 2024 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267896; cv=none; b=gsDMbtc0QEnKBTjgZ7jU3uffvKhYKQLIp8UC3QWOMCwp8xZXbYLp2igfzTqb68tQzCkQZUcZKcQ90Gysw3n41ta+llJIBx9J2LkworsXGoJzI6TE3gUC5wbLEtveaZ1VCz9NGQimc0h3Ve8CgH18QLdus7rj4/wP4BL6Le8wDhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267896; c=relaxed/simple;
	bh=U5gFiTyyZWD2QwJmIx6pQoswxw3NzvZukFdjf2JPSBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D287IwlR9xLG3K5X7qt1bzDRsLFZHZ5LE4K3nNRfly+YxXhJoQKZULvvKv8N/KEETJRMj8LPCo+iy/aWkbp58u92ddViHxGoQxe68rJOKWXme73W8aSzqISakEgM9ldbtM+beLXMjTonJ5Nu6JSOaWezpxyG1qKWdBOG2pvSPvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iAj2rof0; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iAj2rof0"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c87b0332cso184425ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Oct 2024 09:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729267894; x=1729872694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8B7ibEayFHCsbRQB9ZzYhdirygNU7e0zdMaz7UmJUtc=;
        b=iAj2rof0uK5ZNNB0Mg+Fn1qWln1LXsFRX+6xJQl5rleNwzjMMLO16YvS/BPHoOGAd5
         6b1wQYtNFgfmsLp12Tf6koBXADf/hmKp3lfAOR5lff8cHvBtjhsCx9vzfFMGKLsyzdB+
         UfC3/AkEPJjx5HN3w4EUZBbqFS8tkwxE2EjQVQbh8VpWNv3nFwOO23+ZyT1DLti0DRFx
         4T0r/0QheUoPdkLMPsOAl/q35oJyBjOVTNGY1fbD0DR3tSekVEonTqyL1iMj66Vw4+Vx
         9aTggnhqlXNmiw1VOpHs7U3tudpAQEUSbbkdQjJDvUrt2U8By0oeMCdSo3kNFxueV6wp
         EUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729267894; x=1729872694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8B7ibEayFHCsbRQB9ZzYhdirygNU7e0zdMaz7UmJUtc=;
        b=tdnosrN0S1qMZEco5ezZdTn64yUz7OTWosIDz0UFILOlPi32l07bcicTCao6EdKeKs
         yvFoU6SafGG2l/rlCzFBnpRr8e8Gl+fljgR69KJzm25Zu2iyJsqkVjiLKGJqfWVj48uh
         A/ma5sEdNjEWbYsMsFCpEURO9QRcLIDjmB8wTpR0FaQZUbOaQnGqS4Zidmy4JOHXv+qg
         +J9LyZ38eo2sIWrnbeXitzX8z74IQoi+gmTGthifxQaLkKFExtPW2QGjWDol84uB17+e
         xUKT/SM5EE08ju6x8JdccIKUoT2TYYZQT9qele11hcEe+H5BdpyqMJfQh7exWszfbdh8
         0ing==
X-Forwarded-Encrypted: i=1; AJvYcCWqrcJmypvMMHAkAL9RaeQd2wguF1n1vQwVFE6AqNcfTfEac+E2anWkewBk1bLB0SXwVCqnICbrB8yDH3quLi4F@vger.kernel.org
X-Gm-Message-State: AOJu0YzAsW3nre0m5hQ+xanq2UWUi5HD3C8LfhkskyWjpp9BeSK0wPd7
	WBjIBYrA8gMDmNUYexPzzfwmXv7GmhWtzy1UQTya/C1ZFlWxr5QjNbJNIcVj5isRkngN8x3Q2oZ
	4wfjJdXDlfd6vRBLKzdxofogKEy2DYpcqtYao
X-Google-Smtp-Source: AGHT+IFMJOmiPu6T5M2aLbt4TGY5oBAvuDIL8R/OOcvgRNxMVDp4/yEjqqq5/qHrwvuJqn2rHURwYpcSKeycrIhYbfc=
X-Received: by 2002:a17:902:cece:b0:20b:5e34:1850 with SMTP id
 d9443c01a7336-20e5bd22cd0mr2412525ad.23.1729267893500; Fri, 18 Oct 2024
 09:11:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018081640.1388661-1-tmricht@linux.ibm.com>
In-Reply-To: <20241018081640.1388661-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 18 Oct 2024 09:11:21 -0700
Message-ID: <CAP-5=fWx64SW2BnVm6zbLKpNWqOp1Qm4JT1B5b9shwq0h+yNrg@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix perf test case 84 on s390
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	acme@kernel.org, namhyung@kernel.org, agordeev@linux.ibm.com, 
	gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 1:17=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Perf test case 84 'perf pipe recording and injection test'
> sometime fails on s390, especially on z/VM virtual machines.
>
> This is caused by a very short run time of workload
>
>   # perf test -w noploop
>
> which runs for 1 second. Occasionally this is not long
> enough and the perf report has no samples for symbol noploop.
>
> Fix this and enlarge the runtime for the perf work load
> to 3 seconds. This ensures the symbol noploop is always
> present. Since only s390 is affected, make this loop
> architecture dependend.
>
> Output before:
>  Inject -b build-ids test
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.195 MB - ]
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.277 MB - ]
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.195 MB - ]
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.160 MB
>                          /tmp/perf.data.ELzRdq (4031 samples) ]
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.195 MB - ]
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.195 MB - ]
>  Inject -b build-ids test [Success]
>
>  Inject --buildid-all build-ids test
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.195 MB - ]
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.014 MB - ]
>  Inject --buildid-all build-ids test [Failed - cannot find
>                                 noploop function in pipe #2]
>
> Output after:
> Successful execution for over 10 times in a loop.
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>

Lgtm, fwiw if we can land the parallel testing [1] I'm not sure it
matters if a test takes 3 seconds to run as long as it is running
amongst the concurrently running tests.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
[1] https://lore.kernel.org/lkml/20241018054719.1004128-1-irogers@google.co=
m/

> ---
>  tools/perf/tests/shell/pipe_test.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/tests/shell/pipe_test.sh b/tools/perf/tests/shell=
/pipe_test.sh
> index d4c8005ce9b9..e459aa99a951 100755
> --- a/tools/perf/tests/shell/pipe_test.sh
> +++ b/tools/perf/tests/shell/pipe_test.sh
> @@ -13,6 +13,7 @@ skip_test_missing_symbol ${sym}
>  data=3D$(mktemp /tmp/perf.data.XXXXXX)
>  data2=3D$(mktemp /tmp/perf.data2.XXXXXX)
>  prog=3D"perf test -w noploop"
> +[ "$(uname -m)" =3D "s390x" ] && prog=3D"$prog 3"
>  err=3D0
>
>  set -e
> --
> 2.47.0
>
>
