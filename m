Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE963FD128
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777481856; cv=pass; b=pHo9r+LkmaMvSEpbtBURWevLRmV6E9ip6sDaIOYGbfLgU03XLNe8uyinXLQp+iRAW9Scuz27MBdR2ErAea2C48MtRlicKHXfLXKlnZEk++wJyLYV/7O5kVArPiFRW8oIjt1ZYeQWWbhEnGj+boZNcchWyQRPPcMLgLAyH1pKnYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777481856; c=relaxed/simple;
	bh=/Zlc6pfGXUhy+XEkm5Zdn2AzN7erVv46yEFA9G9HQMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+T9/zFH6k7sQs81XtSgAQoDmrweYLCg0+geku/03dH57n9z+YrsHsYHyfh0z4eSDPwMcK67faP+iND4teqkqOkTIS7Mv74Q4Ua36ynGm7GpRE2KfR3k3VkWh4uQ0WPpzRUe49NLAX5tOAd9UIFQgB8vumLpdZhRGSSwy6Twmws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mqgiSzmL; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mqgiSzmL"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso5355ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 09:57:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777481854; cv=none;
        d=google.com; s=arc-20240605;
        b=hfG5p9Jy/IRuMWf3J1k72rpng8Q5xWrggMiQxw7+i+AhMEAsn/Pl2xmASui4BXC16x
         8cw1KYwwMvU8MbFnmsdGd0Y9GoMVscIJVqtLvHdET7BXjjbymeEemmvNc9jUqpu449J3
         s3wtLHta7VqkHEfQwsax4jWB4gsjO5tqba2XisVIAG5Llj1Ozj8kJO0STKpr+XPfkWBs
         a3PwV3zVprlDNLgmUvzKlhWqfC7jgUKzlvWyQKlEFNdbIr7m/W3jR4ODOBksVynhL5Wy
         ydPlkFN4KXSaHrBw6wZOrGzk5FNjmFb0xJIPsGBw1KY42aB+cD68gp3/vpPgbjaT3KFJ
         oUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1UTzX5aJxV+kT83g29W47nQdURWPqc1+63uto6/0h34=;
        fh=bKdVyiWMIqD2KNPbVpwprCzcpaVWa+8qHciavb491to=;
        b=YUIfgpwY7SK5kU5nStWWKqQlx2tRpGaGR13Nbef9p8j4fI9CVEyBDESrPJtgrr5mxM
         ppkVRI/OjvHvHFwrzIdsPEieUQRHJgFz3hv5b5yyEECVKRTcytxcIK3Opbc77vfNX01s
         cfnaCCZ1QZK/RuxMVBIywL+vN1YwOrWu2hWeDeoIcjXzRBbucbQIg6VfJVVMOHKWg7YR
         SLb3EZ+j4NHz2FPKPnstiHjKhWDwoYKirNGbBOPwLZpyNFXvbx//Z4ouJfCAOhnYAr6v
         p4PqQa6UyAryUrBIb66Cs/qwK9wjosJh6t/r2CbWGcl8ptwBi+rS9ee3+0bGvGXQroYm
         fjhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777481854; x=1778086654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UTzX5aJxV+kT83g29W47nQdURWPqc1+63uto6/0h34=;
        b=mqgiSzmLG5+obJlh+PRQq3dRIVElprH7GcWevHaNrlBn3Ze6bcAx6BO/2CtrVjcsVm
         Tzn7rNDcTdyKsvGeexoao21CNfyNW+kebQ6phwjqdjXFVIBtxjz1dWrS/jBkLtyutKm0
         zroAzGNLDJjyusPpt+os8LQfjwAKcihHxavvphb6UFEtjAJvvqGVztLfl5vFqIY7k0HG
         Syjq8eQhlLjUCtJF7dVbGvdSsOcCkhtBjdj0YTvHe+t4UbPu1VkqmVjqw4BgLZkXAEcF
         vxkf4Qa+YLhqP07uxxPNU7wuVbXU+UiFihP7cwzYgk5GUrde8VnUmhhP4ekIYiqkX6CF
         CpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777481854; x=1778086654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1UTzX5aJxV+kT83g29W47nQdURWPqc1+63uto6/0h34=;
        b=eum9jOlL9uu/R7AWungspjH3sFIcXfnVUyf6Nr0GeoW7sYdsYyjiMQSpU+vaFnb8fP
         UgZkJ++JvPS3X+2GFDqlC9HlMunaeD3W6TbE69r9WhuELyyAhZ6nOhBc7QYY30ncDho1
         iqexuv4uTxuzbokfEvLy2BPyHBrrPhzPhO6q5ri1UhiKpeYtPlbHzwlVFhwnb3lPPSgk
         4Ean7xyOFdQvkLz8gQQnyHDU2MGcmkwbdMa02o/khoby72JCi1J1o1L71z9gXgn7a1Rg
         My/yGmjKYhYjVL2KWX4im7AW+0xcnJd9J+0qHwIwNyBAyoCd9vxN0MlKAJ6p821Hjawz
         +bLQ==
X-Forwarded-Encrypted: i=1; AFNElJ/agveWn7tvsH2uhWWzeP/mBWZQLtoy6fOpLgZgEoB3HCgWXI7OcaGd95k3bpn7upfR3xZtb7v6Rs0GhUF50f1w@vger.kernel.org
X-Gm-Message-State: AOJu0YwPE0f072MO3sHU6mivEA0HDhnctYdE8WU36ACVbZJ9WURNX/en
	v3TbmwY3B+01fodxPNjsDn/KlqOL3msGESeFQ8aoJmjdTFokUzHsyPRuBD+/1Z+LBVAWtH140K3
	5SoiBqNyVjjrEm9ZCyYXoiTBdMnpaamebZhf2nG2m
X-Gm-Gg: AeBDiesQK1Ku39Q8MkbkdsRAOZu7OEKk2QWEmkOQ03v1klrXEq3O2dML0KMQb4nqzm/
	6pXZoYzWZR8cj9NqN+qccoZyfV1R4+dF0FTSM6f84l/s7MvDrEcZAhkkizdtGk2RcuYDFcI5E9j
	0uD9M2PrIqZVhy2Xwl+9GIPW0M8jg551TqLtinaGcChnv57cRfaR4ZSSEEQLsz9aTLY8lvgiA1Z
	igSZ/ED1PEE3Zvs+VfgZlAfmKmiDF6ziAZ478zpQH33ivsSEJlzEXsssKTPNvGC1XduKumnXi/p
	Krc9w4hL9t9OG3VlBWqxZyHRAgJdINNfmrQWB6aT73FFhoiniKXXly+vY1c=
X-Received: by 2002:a17:903:38d0:b0:2b0:7a9b:82f3 with SMTP id
 d9443c01a7336-2b99e4b6f88mr30645ad.8.1777481853098; Wed, 29 Apr 2026 09:57:33
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428143920.2466185-1-martin@kaiser.cx> <20260428143920.2466185-4-martin@kaiser.cx>
In-Reply-To: <20260428143920.2466185-4-martin@kaiser.cx>
From: Ian Rogers <irogers@google.com>
Date: Wed, 29 Apr 2026 09:57:20 -0700
X-Gm-Features: AVHnY4LFDlA6ePnv_5OKY4drJd_zGjH03oNDamIaQ0nMBay6b-mNF7K9Nr3hF_A
Message-ID: <CAP-5=fVFFEij0c9t9Vr07q43q86SnCsmrrLdt2aqtE+ijCs7=g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] perf test: fix "trace summary" test for musl-based systems
To: Martin Kaiser <martin@kaiser.cx>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 7:39=E2=80=AFAM Martin Kaiser <martin@kaiser.cx> wr=
ote:
>
> The trace summary test calls /bin/true and filters for open, read and
> close events. These events are coming from shared library loads.
>
> On a musl system, the loader and libc may point to the same file. true
> needs only libc, no further shared libraries are loaded at startup. The
> test fails since no open, read and close events are captured.
>
> root@host:~# ldd /bin/true
>         /lib/ld-musl-riscv64.so.1 (0x3fb8882000)
>         libc.so =3D> /lib/ld-musl-riscv64.so.1 (0x3fb8882000)
>
> root@host:~# file /lib/ld-musl-riscv64.so.1
> /lib/ld-musl-riscv64.so.1: symbolic link to /usr/lib/libc.so
>
> root@host:~# strace -f /bin/true
> execve("/bin/true", ["/bin/true", ...], ... /* 18 vars */) =3D 1
> set_tid_address(0x3fa1f7bf70)           =3D 330
> mprotect(0x2ad6b8e000, 12288, PROT_READ) =3D 0
> exit_group(0)                           =3D ?
> +++ exited with 0 +++
>
> Run "cat /dev/null" instead of "true". This creates the required events
> regardless of the C library and it works for cat from busybox or from
> coreutils.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> v2:
> - use cat /dev/null, this works for busybox and coreutils
>
>  tools/perf/tests/shell/trace_summary.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/trace_summary.sh b/tools/perf/tests/s=
hell/trace_summary.sh
> index 22e2651d5919..b80dea77cec6 100755
> --- a/tools/perf/tests/shell/trace_summary.sh
> +++ b/tools/perf/tests/shell/trace_summary.sh
> @@ -14,7 +14,7 @@ OUTPUT=3D$(mktemp /tmp/perf_trace_test.XXXXX)
>
>  test_perf_trace() {
>      args=3D$1
> -    workload=3D"true"
> +    workload=3D"cat /dev/null"

Could we capture why the unusual workload in a comment, I know it is
in the commit message.

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>      search=3D"^\s*(open|read|close).*[0-9]+%$"
>
>      echo "testing: perf trace ${args} -- ${workload}"
> --
> 2.43.7
>
