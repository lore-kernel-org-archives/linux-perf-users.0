Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE66299A90
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767900485; cv=pass; b=KpQizykmbzgokHRwEylq0SP/TqCGFH3jIaGjUzQU7iqv5HRe2MuNL1uAOZ3oUICkhj6zOCWwTArOLNzkGi/e0NUvmF8QTowAwiKcKJX0YkqqS1fXRsGqeeiypUa5KePu7GCAbUZPb5A9IuXx3CBlSMouHF0eXcHSeUdWjc9jy2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767900485; c=relaxed/simple;
	bh=CgAFgo6hAqJXVtW/Br568HbmGUAn1XAdn5pwefHkTa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cplAo6O4TjXHmwqOzW4/l0+sFsrHRZXoMBBE23SZ9o4CwShvLJeFVCMIHkdFyp9GGrSjP7KT2DvTcmMCCBQywsf/rHGrFm0RUkg0nAhINyADOHhx7ckhzDI6yc2BREzf0jP8dGdINgAR4icG6d9f431jt6+6aYDvbz2rYV84rqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MT5IHJJd; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MT5IHJJd"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a1462573caso12405ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:28:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767900483; cv=none;
        d=google.com; s=arc-20240605;
        b=I58hKPhi/uAmsiqeIQGYR0lTI+1mx8yDkNYSf6S89//sCPQ7s81uoQOe4GhtCBQaxz
         Kp5kFpRn6sDNP3jg1IqC2Cd1URygLg+TB0vsNh2Tl8ocy9+KWmEOYz2c49BuHGvij4x7
         uTiGy5cI90vE4fLY1tJANu0W36isSMxpUanrsf5jAR3mDs5SvFRv0oTdKT5FmHQ2toTw
         iBj7kNj7hK9HqjmRny9WxRpGEG9U+malrVadTIFs1rcHlx7zTpeBNSZpD+YbHMGoA+Nu
         DMiLHZEWgcC3Az8gdsfNe+RAn0sIxJxfVX7naAnyylrAoNFw89swTgCQ/Gda9tp+wLxS
         8aLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vC2DxFXob/rzhDH5D4OhfksUyAXf881aE9Fm95CaDP8=;
        fh=QegG3Ec5Ua6srt4nlWgFUI2FnpvdSTDSCF7/4ZoLg98=;
        b=hMNIMHkYHeoMd8ryJjmezrz54KwfL6vR/8oNlAbrOeyyo4cnhyFs/26XZabbSr1nD3
         Oo9vwTRmjaQIcdcdKv66sgGr4ikRQXz+ST3vLoaretpa/i3pNt7S6tKBlMC1wEYXz7wO
         O6oV1vZrNR0b/LIJ2ElrA/hXjWO7/pIe43zn4LgLKSF1qaU3UInZF1QDyo7nICeTDsgN
         aDDeq9kIOOYa0A9xCb10cONGYjmO533l6zZiW0k7Qtc/FkIL5UxEkT7FG0iqs1ECT1bz
         eQNF0HRYt9BY7tjGkc4pzdBIjwwvAmB9C83yTIeKL948LtvEdUeninbrh7HIj6M8Jmfg
         qAgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767900483; x=1768505283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vC2DxFXob/rzhDH5D4OhfksUyAXf881aE9Fm95CaDP8=;
        b=MT5IHJJdQ5ekDcQyO85JMBGyBerlo6NWO4+EnOFhmmDno54ajg1i0Tx+SfCQFAVHtl
         ODKb0yQDCv4jkToGRRvVY96EyLYwPKul8kMeaMwwfecP2XkKBlVD39pr1lenGoB5gyCW
         cTwLumqHun2/roHjNvQNTw5wF49DA8ri9v+Mmv3pmLhA7lpyr1OuyH8/PD9W7fi9o7OR
         qC4u6pbfKCVZpPUIwSF8zL9BQTzvRCiu1GXTjWsX+SFzXDF2iYVx2dz856ndhg/E/BVp
         U6aubL+zQyAvehQe6/lhVhD7bqRPNLjWBVaCN+duHi9TNT9sa4DtV2aEBf/NoT7P9jiV
         vcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767900483; x=1768505283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vC2DxFXob/rzhDH5D4OhfksUyAXf881aE9Fm95CaDP8=;
        b=beINBLAX3khviEGGWBmpWeD5GpJ9A0EEJIr55BJyFQ9rMTbXxv9H0HfSwyKxYm4sZ4
         92nbPT0MQe1uleri9Tw7esLZuhE1GcViQs8zr5/p4F3JjKH06kfVu0AJV8NFeM0aF9oF
         SVVlovS3pr3v2NpUcQ1IFvdw8mE/+CPbD4iRvQRiD3jeOF+nf89MJpjDYoL8W3ZS8bjh
         4UW04skYEC+EKVWD24zx4jhgiZdjQIx9PL8EQhYm5on6h3dAdlAupWYm5BdA9RgCoQ4P
         nwxWQsH8zpHgr9pTjAd9BoiTBRe38K5UiyH1Y/5m42tEnEsnJqaXPtbMeM7hs0ApqSkN
         Sxmw==
X-Forwarded-Encrypted: i=1; AJvYcCVIaKawKCZ6vmwlAutb6S84whm6Dv917J4rx1SgRZxdnq8g8ZjnSimzYNJqNzEFlm6UOeG4jTRCDKGlnP5TOqIj@vger.kernel.org
X-Gm-Message-State: AOJu0YwfUytPxY4KiyxGULH3BWLUVtWbA1BifWr0BiYmMCHBNOzK3ZeB
	UfT/CGVU3452R/Psm3JIOAp0N+mu1b8S3XoMmDsRRixoVPPrgNjdAJjGLHf16i/gtfWzxj8a5Rj
	Ge2N+9DITySaQ/nBFEGaO8RrOg1V2Fc7beUNxmbC8
X-Gm-Gg: AY/fxX63qHHDLsAqUNWbhODPXf90NVZVyr2YvIYH03rpFwQCwO9DF/aqrFUnuw6yBd0
	nhgZqg/fhHPvafwQhJTie10dqVnMD27Xovm0M8Vm/ZoL1jzHMKD2Tkg3MiYgpl7Uthq1DPsBTYa
	aBE9ZZCqAj2jq2e1+CABuuLQwwI4ped4cPmey860lYw0GyqVgRiV2Hj9Y3zHWruTJDFd2VXKDdW
	Rk6Fke0z+86+xo19Kafd50NlKNt9YVbEv0nyiKtx1fItFy/zt6C55RZPtWWx9JLHOVbk9s/B8rl
	HSgw0lH0zyCbSMvACl2uTgWLsg==
X-Received: by 2002:a17:903:41c4:b0:2a0:7fac:c031 with SMTP id
 d9443c01a7336-2a409ab1764mr451485ad.14.1767900482739; Thu, 08 Jan 2026
 11:28:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208172339.1445817-1-irogers@google.com> <BY3PR17MB518624354091DB1B4FB7A7FCA5A1A@BY3PR17MB5186.namprd17.prod.outlook.com>
In-Reply-To: <BY3PR17MB518624354091DB1B4FB7A7FCA5A1A@BY3PR17MB5186.namprd17.prod.outlook.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 8 Jan 2026 11:27:51 -0800
X-Gm-Features: AQt7F2pAqib-T10TWwbXIeZyITfb2pdqYsTv-xYrwMAw7olwPzUE8iu9i7H0gDY
Message-ID: <CAP-5=fXT=s7jnZwOK=HxWHAznjStrHvgZuJ9p62EGMNG1NYnqw@mail.gmail.com>
Subject: Re: [PATCH v1] perf test subcmd help: Add exclude disjoint subcmd names
To: "Jayaramappa, Srilakshmi" <sjayaram@akamai.com>
Cc: Guilherme Amadio <amadio@gentoo.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 5:12=E2=80=AFPM Jayaramappa, Srilakshmi
<sjayaram@akamai.com> wrote:
>
>
> ________________________________________
> From: Ian Rogers <irogers@google.com>
> Sent: Monday, December 8, 2025 9:23 AM
> To: Jayaramappa, Srilakshmi; Guilherme Amadio; Peter Zijlstra; Ingo Molna=
r; Arnaldo Carvalho de Melo; Namhyung Kim; Alexander Shishkin; Jiri Olsa; I=
an Rogers; Adrian Hunter; linux-perf-users@vger.kernel.org; linux-kernel@vg=
er.kernel.org
> Subject: [PATCH v1] perf test subcmd help: Add exclude disjoint subcmd na=
mes
>
> !-------------------------------------------------------------------|
>   This Message Is From an External Sender
>   This message came from outside your organization.
> |-------------------------------------------------------------------!
>
> The test is based on an error/fix poseted to linux-perf-users.
>
> Reported-by: Sri Jayaramappa <sjayaram@akamai.com>
> Closes: https://urldefense.com/v3/__https://lore.kernel.org/linux-perf-us=
ers/20251202213632.2873731-1-sjayaram@akamai.com/__;!!GjvTz_vk!XehekKNUE4Ib=
_tvqIH6PMIIhly4X3BZ-Y40RC1HKMQ-6OdYEFvUPQhyWv_gk9vsRRN4_RcOLS2Bh0CQ$
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/subcmd-help.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/tools/perf/tests/subcmd-help.c b/tools/perf/tests/subcmd-hel=
p.c
> index 2280b4c0e5e7..9da96a16fd20 100644
> --- a/tools/perf/tests/subcmd-help.c
> +++ b/tools/perf/tests/subcmd-help.c
> @@ -95,10 +95,36 @@ static int test__exclude_cmdnames(struct test_suite *=
test __maybe_unused,
>         return TEST_OK;
>  }
>
> +static int test__exclude_cmdnames_no_overlap(struct test_suite *test __m=
aybe_unused,
> +                                            int subtest __maybe_unused)
> +{
> +       struct cmdnames cmds1 =3D {};
> +       struct cmdnames cmds2 =3D {};
> +
> +       add_cmdname(&cmds1, "read-vdso32", 11);
> +       add_cmdname(&cmds2, "archive", 7);
> +
> +       TEST_ASSERT_VAL("invalid original size", cmds1.cnt =3D=3D 1);
> +       TEST_ASSERT_VAL("invalid original size", cmds2.cnt =3D=3D 1);
> +
> +       exclude_cmds(&cmds1, &cmds2);
> +
> +       TEST_ASSERT_VAL("invalid excluded size", cmds1.cnt =3D=3D 1);
> +       TEST_ASSERT_VAL("invalid excluded size", cmds2.cnt =3D=3D 1);
> +
> +       TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds1, "read-vd=
so32") =3D=3D 1);
> +       TEST_ASSERT_VAL("wrong cmd", is_in_cmdlist(&cmds1, "archive") =3D=
=3D 0);
> +
> +       clean_cmdnames(&cmds1);
> +       clean_cmdnames(&cmds2);
> +       return TEST_OK;
> +}
> +
>  static struct test_case tests__subcmd_help[] =3D {
>         TEST_CASE("Load subcmd names", load_cmdnames),
>         TEST_CASE("Uniquify subcmd names", uniq_cmdnames),
>         TEST_CASE("Exclude duplicate subcmd names", exclude_cmdnames),
> +       TEST_CASE("Exclude disjoint subcmd names", exclude_cmdnames_no_ov=
erlap),
>         {       .name =3D NULL, }
>  };
>
> --
> 2.52.0.223.gf5cc29aaa4-goog
>
>
> Reviewed-by: Sri Jayaramappa <sjayaram@akamai.com>

Ping.

Thanks,
Ian

> Looks good, thank you !
