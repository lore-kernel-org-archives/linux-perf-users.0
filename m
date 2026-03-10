Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8BF309DB1
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Mar 2026 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773156287; cv=pass; b=P/AzIUVbiLdvf7pi+Hb3WV8uS3XddCVdffBux02MKhB1ST1wig115hAs5ArQsZjMDK4g1s0zYCWSEWYx/ohNcHng+6kySmcfoDjdubuJHORnuA4eypT6fwPFiotPs1dUH8Nk4/F7aSTvqDzwStypIQtgYFV8C7KULRiHnLu475o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773156287; c=relaxed/simple;
	bh=JZrDM///Q/kT9YypmPxIzuH5l/jPTkmghWuvdPPmizo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5JxJFuZO7nEBm9kUWFSX1EDuJ0ZQQ8uVZSQO4dDDATrc/icLdZPUk+2KnAwoz1v5jKy1MS9aGzD2hfGafvG94ymz6rQPzZtuCbv7Q5VvYN8PEAGv5UmHweF/XbpqjepEhLRrmvCUsE5hEUcJRagvtb0bbAA0/pqV2fd1zt0evw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AS0YZQu4; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AS0YZQu4"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-126ea4e9697so9741c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Mar 2026 08:24:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773156284; cv=none;
        d=google.com; s=arc-20240605;
        b=eXSCqGo+M5RllgI06xjyc3q9nI+4Lwnu+T1XxU0+FG0ytyU0FcGLI9GN5vuX2LPDcG
         vPrUextXIBZscBACH4w/e0M+le+AxX7g+OOqsad1k8eR0lAtroqqsuZ4M7VdV5xgjgTB
         E36QsG2VAK1V8+GXVANu1DqrYJjOVT8C8NrcV2r12RWEfAk/tnKWtwncr/YZK60+Ls3H
         i53ADizgq9ubV9jRVX4EfNGtbcW66ayO9lD3dYY/RFAXkhuyEX/p7JaVAVrQOo/Htxks
         +U784bEMzdqJOAzroXaIlOKrcbfNCgyuWPPLAtkmE1nzVbPyLhOfVutGU4rGq1QBZhkI
         qMgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LJ217KTzkBEYdpWoN1Yqy2wHTlV1OI6Ge8V1e7aSXA8=;
        fh=wLnGRaQG5Br0br9SqtX0cKT64AmH57Gd9Um/cWVxH4o=;
        b=WhoDe+kxktEepp9LpnK1nHv3j1dMsThuxWbLgqiSeBDc0cF22A4nXBfrr1ANLH/1x3
         v8mIxpXIX4Cfd6s8CR1/J9hhIhgGdDwUuSvr3lTxCfSgIYthLyBhOTzHCJRrRy8kKrt+
         HFn+JsJwwWMicrcty9JFcM0SagcCysVatXaadw71LlpxI1Ign5lRbweZuMli3x8G4+/H
         jjkLevgaDJMUfwkp4DXI5s7i4uyE5YRlG7rfEAlDuLDeZdS+6had7ggbqU2dP6iM7llo
         dU62R2oun//XODupPbNgLyEE1Csfrt6hwEU55p/OYnrCohALdetXATRE2x14ulAWmBg2
         rwxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773156284; x=1773761084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJ217KTzkBEYdpWoN1Yqy2wHTlV1OI6Ge8V1e7aSXA8=;
        b=AS0YZQu4zmJ98x39TEKi2eioraZV+UJyKa6/E6jDWf8o8Ia6P6vUdCYJdy6pCtYOeb
         kby8Xbp9eSTLrEUs6LsZ77yqzL1HqcwiVl9xWc/+wEDwO211mXgnz8+cakh+cYU8uIRp
         9eB/jh3uvp3T/db95MOCwahg7P9jQqA8AE9hcUERQptm1Arf18evwg7cVydEv2fgLoqE
         MKXQfaTqKHVTnPEqN2WFdYW+FilCQp/6PaD2mu1koAGpyr4bp7988uLv6m99bfD+YaVl
         ZDWOgNpyWd32+Wn3x3708j1uKhFr6p9zWceZGggMrJJz0Vit5kNfiKw1JnhUYHRVNvHG
         RG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773156284; x=1773761084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LJ217KTzkBEYdpWoN1Yqy2wHTlV1OI6Ge8V1e7aSXA8=;
        b=Il7AF5urCQEy408knzpAGQJHIJYp2V+bh0jDgUfUTtLa6uy4E2zAxM//bQtp075j4X
         WTymH/Op82ToqXuoaXqFa6eu3aR6M5aGZrUL0feb0e0jDME8egLhJvoo5CtLwvzZirq4
         2SAElklrYtu20r668JSquoZj95ctR3uYWxZLABKrGlKxje/zbol+dECW0ynA8HB5L0o2
         +f8lChoEmaoGw4MTzAF0KdvwdZNbvqE1VmFv+s6/WpTw1LYqO7qQV2Oxa8MX1dmL6Ncw
         fmlJP7z90++I7IcGE6oxPmeSp5ZAjpyr/Sxh4QWQBHjeIt60O2A7fkyZ0SIRufpvm1bz
         AEYg==
X-Forwarded-Encrypted: i=1; AJvYcCXEXv83LlHk5u75zVQFT4HbXusqmX/XSOLTdOdMmCtROgwSpCjmkncvBhtFdf9YN3BX+Nelz60TOKXXLAe3GN7j@vger.kernel.org
X-Gm-Message-State: AOJu0YxjcBV8ZGDbcOCMhPb/e8Lvq28Cx+TtbU6SIrSmWB5Ih5vNuMp9
	AM2Du7z8UtfH184vgVLMgwL3thWqvfjYB0awfv1rNAvQzuui+RkLuUkSsdZeIVM8DPflPBLE5n/
	901uPERwgt7q0NZDLGR/kRGogmqiGWvw1e71+Dtla
X-Gm-Gg: ATEYQzwWlQSaZm1Xq3fDqEBuYKBYrbJtsiOwJtUGxGQDypJ8yq7ErGgiKi6lWHZTynr
	SI061HtJU0L4W6MzbDJ2eb1x6MA4hqelKsxSTBny6nTg3ZaUmRZmQoRXfjMp7ME8akd/0wwRQSi
	ZT3dccD81DWjSgdkitaskeYJtQEgXeWHIgJO9gY60zIp++FHAYq1XNlmXH8Rpme6OqcdBB3DxjW
	SOHMA2AeAE3oMbxzNshrohl1rX9iTHMz/tl++F4rycEq4yEi927e33s50HV6dCZVhrzEnRv2tX5
	LM+s62852ZYq7GPg2qTG+Q3gKLJOYlwCI+E=
X-Received: by 2002:a05:7022:b056:10b0:127:9745:c69f with SMTP id
 a92af1059eb24-128ded26ae5mr128995c88.9.1773156283463; Tue, 10 Mar 2026
 08:24:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309155728.98026-1-jbrnak@redhat.com> <20260309155728.98026-6-jbrnak@redhat.com>
In-Reply-To: <20260309155728.98026-6-jbrnak@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 10 Mar 2026 08:24:30 -0700
X-Gm-Features: AaiRm52uXnelWRxcv3Ted65gu8oq4my3JSJJDaHjN88gakWwqxqalLqwSHGhjnU
Message-ID: <CAP-5=fVvbq3=sh-0xr7t4BBHDPsuTsr9Nx0-DhBb7G1ZdZRz9Q@mail.gmail.com>
Subject: Re: [PATCH v6 5/7] perf test: Format log directories for shell tests
To: Jakub Brnak <jbrnak@redhat.com>
Cc: acme@kernel.org, acme@redhat.com, linux-perf-users@vger.kernel.org, 
	namhyung@kernel.org, mpetlan@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 8:57=E2=80=AFAM Jakub Brnak <jbrnak@redhat.com> wrot=
e:
>
> The name of the log directory can be taken from the test suite
> description, which possibly could contain whitespace characters. This
> can cause further issues if the name is not quoted correctly.
>
> Replace the whitespace characters with an underscore to prevent the
> possible issues caused by the name splitting.
>
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> Co-developed-by: Veronika Molnarova <vmolnaro@redhat.com>
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
> ---
>  tools/perf/tests/builtin-test.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 70f4a61357ec..cbfae7dcf2b6 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -292,6 +292,7 @@ static bool test_exclusive(const struct test_suite *t=
, int test_case)
>         return t->test_cases[test_case].exclusive;
>  }
>
> +
>  static int delete_file(const char *fpath, const struct stat *sb __maybe_=
unused,
>                                                  int typeflag, struct FTW=
 *ftwbuf)
>  {
> @@ -340,12 +341,19 @@ static char *setup_shell_logs(const char *name)
>  {
>         char template[PATH_MAX];
>         char *temp_dir;
> +       size_t i;
>
>         if (snprintf(template, PATH_MAX, "/tmp/perf_test_%s.XXXXXX", name=
) < 0) {
>                 pr_err("Failed to create log dir template");
>                 return NULL; /* Skip the testsuite */
>         }
>
> +       /* Replace non-alphanumeric characters with _ in the name part */
> +       for (i =3D 15; template[i] !=3D '.' && template[i] !=3D '\0'; i++=
) {

The AI review mentions:
  Will this loop terminate prematurely if the test description itself
contains a dot? If the test name is something like "test v1.0
execution", the loop would abort at the dot, leaving the subsequent
spaces unmodified. Should it instead bound the loop by the length of
the string minus the ".XXXXXX" suffix?

Thanks,
Ian

> +               if (!isalnum((unsigned char)template[i]))
> +                       template[i] =3D '_';
> +       }
> +
>         temp_dir =3D mkdtemp(template);
>         if (temp_dir) {
>                 setenv("PERFSUITE_RUN_DIR", temp_dir, 1);
> --
> 2.52.0
>
