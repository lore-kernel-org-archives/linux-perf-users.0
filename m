Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9B81ACEDA
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Jun 2025 21:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750712876; cv=none; b=rkP46PD3ho/NncR+NvJ3dqKY0/jjNuceTb1UYsTioHDu/YyO0SQOWRR9ar249+1RcEYf0oPEfGDbi+84mtR+LPJ51R136m9usfWAmolzLx6HkgKOmiiTXHrAo97PCBIzGb750BzQ57vJICNIH2FVE2Fpzddtf42DeHwCwgcGiDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750712876; c=relaxed/simple;
	bh=QYSgA2r9Hoq/PyEKP+W5aS5hG/seCLS+yMuWGfPqxDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cdjk+LCwQRTTWR3+NWa7OWYpFXutcfEKwz9T1S/fAW6kxxLhP7bqhOUQh8Ef9RQHnPsV9C+TI5VpKTuAHjd+AgeERQqlNmdjnKPeHkGyHcOmuMLeUdR1kGUzSxgojDtWLztyyiQu/pIvwr1sQZOeR1TpftGG6VLoGjVnrc4vpZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=st8Buq1X; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="st8Buq1X"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3de210e6076so9225ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Jun 2025 14:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750712873; x=1751317673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4cX0phktxLtIZp90+OwfwSNf6uSHnahTRACJDaKBFA=;
        b=st8Buq1Xh6wu5Z1sLuJ4RrIdSnsppsQ3TgldF/7GlHufJ+8TbJM/NQRWdu3qFIq3mV
         IiSHJLJa8ya5q1+Wp84qZ/Vhc1Mtfg9fcnrjmdwQUEM6s5H5lPlMETVxS/AHs2OY1WCv
         MBwX3Bl5pqK5jPl3CJeBLB2HlXJ3BNbQ5JVQBfBT+8yf7RZBpOxX9lXzl0W+8LsUmN6c
         bKhAkkDSyEUILr0W4rnc/R5Y9rHwaWm9V0mMVKBcT6xEechSJ37Gio7cTtk4P1MWGXQn
         kDJWjKqyG2aaruN6Dp4Wv0e3V5WHikousykFg+z8jPbXi9SeJwO5p7X1uknTU6RWKLSk
         B2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750712873; x=1751317673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4cX0phktxLtIZp90+OwfwSNf6uSHnahTRACJDaKBFA=;
        b=q7dK8aNDMlbS8XKY/BPA9r4/jx9Du3KxvAPRsSrm1aDsCTykeqClqW/cIHFW3qwuPq
         kwTtHLmu1GT1E7LE1ElJrg88aroVqhEGSXg8F0hjRVhoJqDke/+1hoqZwD4klIj9egCS
         6yRB0/qnWXkU1/DHBprm61I5TBNtZEKrgI1xFGh55VZjbEL/7yFCDglx0bu0OR5Gkw73
         pVCi7jjtlrAqFnrn3sfsWtXXYazweqQDxF4bdGGN+/YdjRHS3eSvt2h8tMRopZsc5Vbn
         J+24WZWpoDiyep4Q0BM65PMGJgv33mQo99Qx6e6pVG0SQAwPUbyoqGR1C0jMmvZYZYqg
         4C7w==
X-Forwarded-Encrypted: i=1; AJvYcCXH18JTf7sHGha3dUonftsvp1eylw25/R9U7xI76rV9jp1SDuRNlzn10jdmbfPJBi+wg8Y7vXcA5V6aC7+LKxNB@vger.kernel.org
X-Gm-Message-State: AOJu0YwzdzWpR1HncVnzqGlXirMyEPhdLkH/RQ+sZUUi9P7KtHCiXyr0
	NR4w0AQ6amO/ycNRrvt2G6+w5xEVTW4YlplI1+iO+feuyjZkZsZOnqc3QQpzvlIO980ejyXuzox
	qIfuDyz2AYsySzXDoqxL3FiyXXY7XZOY800vcbAx5
X-Gm-Gg: ASbGncvZH+hXnS4IMcwEeeijwHq9Sy+/sIBlDxXFeiTU3knEhQcpd3IVQeYnrucYGuy
	B+U8qHYveX1rAATuPS5i9N3cQgLx4dfkx5zzqgxmdAa8l0b1QOFQO6LjFOGf8YkC6DPsds5CiAF
	1GDp5/EcW9suEwLwHfqnK0nPnfgKyMjxJRqxgxKXqfZ24jI7HoSmCPtmE2ifHqRDY13Rn+nWnn
X-Google-Smtp-Source: AGHT+IFQo7whZ43umpkON7cWHCeG6OEupE+1dDqM8Rn4tGg8MZoRe7tVwq2DQ7onfuTeRsVjhMgAyWWGJyuOZG8BsFA=
X-Received: by 2002:a05:6e02:3787:b0:3dc:a380:3ab3 with SMTP id
 e9e14a558f8ab-3df29806c65mr614355ab.29.1750712872755; Mon, 23 Jun 2025
 14:07:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620212435.93846-1-acme@kernel.org> <20250620212435.93846-2-acme@kernel.org>
In-Reply-To: <20250620212435.93846-2-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Jun 2025 14:07:41 -0700
X-Gm-Features: AX0GCFuW5EtyEiOg10N9QdQ_vnwsKRM3tQ-FpqSv0D_UnLEn_f4f-NRtdNqss98
Message-ID: <CAP-5=fWzHDsa18SjSJgdJsZ8myyA-JH6K7CjZQo8f8GfX7+rAw@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf build: Suggest java-latest-openjdk-devel instead
 of old 1.8.0 one
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 2:24=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Just tidying up the suggestion to pick the latest and not some specific
> version.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/r/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

For patches 1 to 3:

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Makefile.config | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index d1ea7bf449647eb2..afebd3b1e6cb9f58 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -1144,7 +1144,7 @@ ifndef NO_JVMTI
>        endif
>      endif # NO_JVMTI_CMLR
>    else
> -    $(warning No openjdk development package found, please install JDK p=
ackage, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel)
> +    $(warning No openjdk development package found, please install JDK p=
ackage, e.g. openjdk-8-jdk, java-latest-openjdk-devel)
>      NO_JVMTI :=3D 1
>    endif
>  endif
> --
> 2.49.0
>
