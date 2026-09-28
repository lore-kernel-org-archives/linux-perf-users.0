Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A445548C41A
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 21:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790631131; cv=pass; b=jZKwY9hSLYm2CDydRm/rpLdN63rMySuLKUqjK9UEobDk7b16FYEkSMI0Digz5OW/XeCOOsUi9xjtuVpsgG3uAu78zYv533/+Rkem39foruW00YyskKzDXsuRI7uHhdL2gMffn8rcn+vxprdTld3V3AVV4AvsZWC1DndSTAeSwzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790631131; c=relaxed/simple;
	bh=p1RBWTYNXB1ayt1mjn73C403W2YSUfo7GSBkq13gnuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7c35oOgG3+SAacDsI3q1WB/htASIhB6car9w9dJRIRWzIhAwdw6vHeIv4naX0BbIW8AOehwbP4d1ok6+iad8kwTgOhOMYbTIHD3QMhj35qQUlGdle39oYXXQEKq6hwUTldW7zCLZrTZC8PXTcyUFnEj7aIg48sKx43IU4Gl6tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M+dg0mRb; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M+dg0mRb"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d3b445a84fso10635ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 14:32:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790631124; cv=none;
        d=google.com; s=arc-20260327;
        b=gd2Y3Q1ReHWD5DNHSfnN/eqkbSSx3ne1u8FpG35BrE6H3BHfdCBaZHRk5xN9N0phGX
         Q+RjJSrfvjbS+WHkG07CsquEV3sZDtNtgC64HE70vI7YtPd/QdHM24gDADTa/H8XDsl3
         7zxL6wts+CeL1672ZdJPsH7eIqBdFExxcu1rwAMoa9WlpDNcxAxtaM+9Nh0bRkq38Uao
         EttwP+6fzrKmwCup/+gvSHpB7pHKTsS5btExD9V5c5rXop0RWx4S2rjN6vFM6DB9HK/p
         k9+FQ9i531+ZPaPPqM6b1z43IJHnV24er3SkDg+0LacvTK7Ip2YokPXLbDHSG7YX9soo
         IFjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+lE1VGJm7uxmdcjGqZxkzLy2YHUwYwaDzNyp54coWZ0=;
        fh=Yu9UJrzJzrHOzbPD0mYbSynsXGg0XA6S6+z72DoqE2g=;
        b=rjJMRH8mRu0htm4Y7PDGI2meHOXMoaYuLrgcLhqi6TJcwtfbgOHfuWOrc/1gGBk74J
         sHIBTP68jWX1mx1dqzOxXg9TKD5ydlWFsZiX71mZf1xsrUG/hQl4Y62sA1ZiKU4Dd5qn
         Yr2VBZ/tQQSABTNeaF4pE4WFd3Rlsn3HTddL8ib6xs8wXL4+bjJFSjcKse8kP9aR3w6n
         J7RN3nks0rMKrPHJErogm6QEf75JoL4+wZ6vvAO9/exOenpdRFpEgfFTN6ytaH6CPzy7
         HjWP19x6yOiqEZ5XF2qnKeuqRPJdp08rSuG/+KMBr37IjFcwZvXmB/B7tMddyxi7hs98
         SVQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790631124; x=1791235924; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+lE1VGJm7uxmdcjGqZxkzLy2YHUwYwaDzNyp54coWZ0=;
        b=M+dg0mRbsyQ/tPSCr+GFl01fo1ArXZ//eEh0Nsa+XUexwNiHZZiFRJjWJKFkqajCqN
         08DqXy7WyKldSY60pd4HEjPJjeqsZvvXN3d4Lr13baXawHnSSnQdOM46iXCCK9uoJRyF
         bDftiJqY6j/eLqMH17O1VcAoIQ9w9lSZI1d4VkPFFm60+DC8gXtaM8LrWqJMCJ2MWubN
         m7WkYMjiQyfDZjZcM0B9IMVuCc+EO77nwHeiEq/wHx3jH+t8fkPfD/V80jBnRpGdJjv2
         qwSbfnEXBwKhW/4DiNPrOH8AYIF7HPZKGSgGmo/lcwEIBuyA8IxHtgO7cN67o7m1NSQ/
         BzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790631124; x=1791235924;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+lE1VGJm7uxmdcjGqZxkzLy2YHUwYwaDzNyp54coWZ0=;
        b=Qgs8xW6z23y/nlXwyIbOsbnp1dRhXFzHl9MQzGUE0ueokVvmFviI53evFoHSA7ZBXG
         O8+Lp0wO4cL/j9VPTdUcXIuf+LF9kL80JMUXCoDvWpzQDvSz8B3CAUtP3so4zMMo4Y2l
         qNpN5/z21hIVlGoEJeNdQQgniMNK33SNGb1dvg8q7aBoDObsXKMPwwj0aOr7UdASjMS7
         xetXfC4ohTtQHDVRtgN5bR9frg62FKhhTVtIFKdt/NF6POxRJ7Xn1nNDi6gvud63no8O
         nM5voPhKm9E690ZHaATTQYuiO6j+XfIlcBMB76BcdJRiyiOUMl0QJxGPizsZH/RJVwjW
         rjdw==
X-Forwarded-Encrypted: i=1; AKwUvBz4tC3NjM1oZJHRf87UEWwaWv1n3XWrlHhcB/vzffCURtk5Y/Ue9WIdzSuEVF6BSVI6XDAypFEWryHBxgSqicMO@vger.kernel.org
X-Gm-Message-State: AFq9FYLY8PO5Io4rCb3JSa3NtO1EagalyYCFkjjJJxvR3P3EAXo/vDCw
	uOrLoIg41+QJdgfcUHn6QgYfGLwHkz1kgbs6+opwS/nH/1KG0n61FnfLk5b+44dRtTA1p2yP32T
	J0DCnKUUPwHVQ/H6tHw9pQK7fAdh8Bxz6+AUdXKiB
X-Gm-Gg: AYBFou2B+KE9ch4tlXE+SS3hCkbjJ4sfVJeuxSNOj55JjjXnD6JuzMxjjWk6dXHMmGx
	uCDP1Mt3K8BWosSTLGbIC2ecMdsPB/WIIBihj7MnukNHejorodMly5zGl3wfKhfwysa5cgUIFR0
	SVGHJLt4EbiXMyzli9uUjp4vkn4b0wvsc7jCCGkiwrK55PgYKD6isD80Lwee+Ilmtx5/sH6tGPX
	p3FFl5wOZvShorYh6mCIFrxmVSO8po9MysEfn1s7Annma0XyRpNMe/U4slhUR21iicgF/etyvXB
	sKdzIbxRuotccJkES5lOOypVXNKwNnWnlZhbmiwQd0lv9a8Co56yued+KlhCvJv2Mp5CQdsnORQ
	vFLy/D/i9xg==
X-Received: by 2002:a17:902:e551:b0:2df:9957:d1bd with SMTP id
 d9443c01a7336-2e2c7a2d7ccmr288835ad.18.1790631123861; Mon, 28 Sep 2026
 14:32:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928010227.1903673-1-michalpl2003@gmail.com> <20260928010227.1903673-2-michalpl2003@gmail.com>
In-Reply-To: <20260928010227.1903673-2-michalpl2003@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 28 Sep 2026 14:31:49 -0700
X-Gm-Features: AclHuK961jia0Cign6WJrnpm7yNwXw1WkLXNkziDawCLyR5WWyWV5QS-KMIVEBs
Message-ID: <CAP-5=fWs6xu53uBqCpWvTtqSAx+kySoMM06pbJyaNa=L_7evQg@mail.gmail.com>
Subject: Re: [PATCH 1/5] perf test demangle: Fail when demangling fails
To: Michal Pluta <michalpl2003@gmail.com>
Cc: acme@kernel.org, namhyung@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2026 at 6:02=E2=80=AFPM Michal Pluta <michalpl2003@gmail.co=
m> wrote:
>
> The Rust and Java demangle tests only log a NULL result from
> dso__demangle_sym() and carry on, so a symbol that fails to demangle
> doesn't fail the test.  Set TEST_FAIL.
>
> Assisted-by: LLM
> Signed-off-by: Michal Pluta <michalpl2003@gmail.com>

Fixes: 07f2b1287c97 ("perf test demangle-java: Don't segv if demangling fai=
ls")
Fixes: bdf05ccd1841 ("perf test demangle-rust: Add Rust demangling test")

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/tests/demangle-java-test.c    | 1 +
>  tools/perf/tests/demangle-rust-v0-test.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/tools/perf/tests/demangle-java-test.c b/tools/perf/tests/dem=
angle-java-test.c
> index 0fb3e5a4a0ed..a8eb0f4effad 100644
> --- a/tools/perf/tests/demangle-java-test.c
> +++ b/tools/perf/tests/demangle-java-test.c
> @@ -33,6 +33,7 @@ static int test__demangle_java(struct test_suite *test =
__maybe_unused, int subte
>                 if (!buf) {
>                         pr_debug("FAILED to demangle: \"%s\"\n \"%s\"\n",=
 test_cases[i].mangled,
>                                  test_cases[i].demangled);
> +                       ret =3D TEST_FAIL;
>                         continue;
>                 }
>                 if (strcmp(buf, test_cases[i].demangled)) {
> diff --git a/tools/perf/tests/demangle-rust-v0-test.c b/tools/perf/tests/=
demangle-rust-v0-test.c
> index 904f966c65d7..ee4ddb61174b 100644
> --- a/tools/perf/tests/demangle-rust-v0-test.c
> +++ b/tools/perf/tests/demangle-rust-v0-test.c
> @@ -58,6 +58,7 @@ static int test__demangle_rust(struct test_suite *test =
__maybe_unused, int subte
>                 if (!buf) {
>                         pr_debug("FAILED to demangle: \"%s\"\n \"%s\"\n",=
 test_cases[i].mangled,
>                                  test_cases[i].demangled);
> +                       ret =3D TEST_FAIL;
>                         continue;
>                 }
>                 if (strcmp(buf, test_cases[i].demangled)) {
> --
> 2.43.0
>
