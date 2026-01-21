Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8572B2DCF71
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 07:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768979943; cv=pass; b=YmONBhoZ9fPWCswgLxCTlORjbDuDePBP5OjxocSK3z40ldq9XEAVwy0haCUqJyL3umK6/DvvqHuTyHDwq8aHqPbJsDatrEMVYyoUNSKHy2kF3KCopxS2fAGBYOCfqJQU5JpJMR7vaCvUvFk4paGxA7QIx0imJB8P5lT0eLJUFpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768979943; c=relaxed/simple;
	bh=64VV5VbrmAaOkFB/5fdR0Q5NQIFsbjIERWI9nz07w8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EUnbFUZ8GyuUSU6NdfJxL+bs5ErcAOq4qHYKHtoBBe70zJYuFIdDVkyX98R7WBzFZTF02I0wcukMfE/51iyRxgvYI6iPKCiHBfvI6MHqY83Gj1g0kv1kJepFVtbSmbVQc9Q21WkWKOA7B7XWiqudATkbERhcp2tF0HR0eIyHWvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i5xEu51F; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i5xEu51F"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a35ae38bdfso45695ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2026 23:18:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768979934; cv=none;
        d=google.com; s=arc-20240605;
        b=cxa6UtxKaZ7/U6FIqHVYmokk7HCa2Dai+2ZCQ0X58Rl5xogEduoOjVBvDxWujOu6z6
         5otu0AYML18Bza0n/WohwnLDr1YOMJ/dwxWD0qC5K7pLikDQCLrkSBDPC72ot87li9sK
         uBGXhivkPSSjfJ9Xvn6v7DzqcdDPxYd9pqDkwDpRuZdIrAGZzejFMMXb5ABQ1m2OmWcW
         tuuZNDJ5gngaRizdFRs8cmvImMuBcVksBYhGwEL6WFTWiAe+Hp9NdhHCXVbsEz+QYz6d
         4TAzVllzYgS3P9XUZ+1w8cDWmxpyZKOa13Fgcmwh0Tk9XjRIW4ukFZqGrmI71GpiVk62
         WJhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0//XAUFi/BEZH5+bUVqHfm6heoaPE1vlqEuf95UAgT4=;
        fh=mGDP4DAQS9YiSxoTbzDLMgLwDZc7UVF9nnZ2l1iavew=;
        b=VcQQchMAQCInJQeGM1L5BKQ+RChiJXpR2x2pApJo801HE9HAX55DNGmsP3fac9hw4K
         AJUunu5JWFzRBn4WWKn3+CQ+J2y2gtA8EzIwrq9njvDHhB9MdoAD1XmNhWJdMtgRYivS
         AEHcwNv8Il8tdl4f50GCLXGfjFNUXL06mTUh0mqlwfuJwWwCRWirb7fALpRqcNmuZPGG
         4G6VOrmH5iuyuX1F6+C+eEVN52jlss1ilV0KHrBcNLdcA1viC/Fc+s8UEt1kAl98X04e
         6qMn82kRUw/w60+07YXjupnJFW62ZoH2PljBDEEVbDlWYR8UYLKVcBvHp9try3LGfPZN
         CTrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768979934; x=1769584734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0//XAUFi/BEZH5+bUVqHfm6heoaPE1vlqEuf95UAgT4=;
        b=i5xEu51Fu/vpizkuPhZCVDTcnT0c3fl/B4hpdGNAqMYvvHXUTf6ALGTqDvzh6mIzRs
         mKNMNxJwsFBkMFO2mfkztfAu/7TKUuVkoP4iygMOK5121MIl4Q57TnOK/bHT9HuGIZB0
         RwDM9YhqQBKOMfHmU0YKMd5Z4qbEe7BG06SJO9mD98B/aBiYhsklKCcOIJ3qqfdfw1Uv
         EscrqZKVjz8qe0auxDilMLuHdYpa0CTRwBGCloCt7ICT4s+2jXZvL5ySMzPgwVAeggki
         DAVVFTmWsdRvEV1lTB/GiDBZPi/okvQncb6fu+Qv2vclvJ8h8Vdwc+tOS97r3X9Cvhgx
         mCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768979934; x=1769584734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0//XAUFi/BEZH5+bUVqHfm6heoaPE1vlqEuf95UAgT4=;
        b=aCdzlysjTX+6VSkShRPp+vbTGAIjrYqHO9mQCm1UbSINYHGYur10p2uqLTZzif6H3V
         iWC8yz+dsaBMOa4jd2mZ27TiGUE+bGXUJaj3JHtPcARjJabY5JdAKXqUgCP5Q8gj7LVs
         VtgLl0D8wmadrPxuyxmL1dEpuF+RrPY/o/LbklJrah61UiCh8t67tMxexOScefC9T9Tk
         Erpk5CAH/cpAqHZv7GkxlMxLy7aS003m/YaPdCbw1VquhnRrKubnQRCLiL5gqmbT4VO0
         X1yxjMlV8o3z/D+hmROFygEgTNz9TszvCRor6M5IHqdpt7Or0VX0/BPk3AhObXYNV3IV
         iIIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUN14ofHKsxbU01tx9bnVGK6/aQJhk6Yof+4wouNdORUr+zpE4TH0+81+xt2RHxK44Dj98VKmA4BJJGnMKHB6Xi@vger.kernel.org
X-Gm-Message-State: AOJu0YzZC7FpQN4A+v+N4a4RkZ8XGWXFWmWHRPQXNfdb/WOv2HBqJ+wj
	fFAotBVNCFB1wDM8HnmSRP41G3xl8zkY5UgBujU8wKqfxiG7YOQgFQ0ytQZkGKluCowKYpxXS3W
	v8xg+yzGf4a8Th3BlolTmZxC1Wlg2ngvqH75Q+FxS
X-Gm-Gg: AZuq6aKY1V5TuhghvyHdiWBspbaf/fYJ5QGFaUVzXen5hrBD85ffjZcv/aB6TOfyOyf
	YAOL1KKNUxyzQjmVBQcJCIXY6t+G5IntusU6OxneJuNCCs4Jn0yUi7ZbOGf83biDTyJI8IA5HwT
	zldXnUh8Rh9hBDAZ2aVbcJ+d14dATgeSKw2durpenS8m6sKYoe4d96UA9RPrWHlXPdUU4K4TyhC
	qfpS8C+8CfY83XyRFAhf1bqO2EgimcpVjCAguabxJzZzEN6Vfp4UeAO7I8NACI954duZpTC
X-Received: by 2002:a17:902:e746:b0:290:8ecf:e9f9 with SMTP id
 d9443c01a7336-2a7a2443b58mr1521975ad.7.1768979933104; Tue, 20 Jan 2026
 23:18:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231224233.113839-1-zide.chen@intel.com> <20251231224233.113839-12-zide.chen@intel.com>
In-Reply-To: <20251231224233.113839-12-zide.chen@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 20 Jan 2026 23:18:42 -0800
X-Gm-Features: AZwV_QiQDnxV5_vG-c9WR6XWAjDYg1h75pFCh4Vs3ChSwOjmq-Cj4iExMNeSw6c
Message-ID: <CAP-5=fVO+dSstWmYiTvu7o66hahiUKig4r=FEfu+FvUN8+nvcg@mail.gmail.com>
Subject: Re: [PATCH V2 11/13] perf pmu: Relax uncore wildcard matching to
 allow numeric suffix
To: Zide Chen <zide.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>, Falcon Thomas <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 2:49=E2=80=AFPM Zide Chen <zide.chen@intel.com> wro=
te:
>
> Diamond Rapids introduces two types of PCIe related uncore PMUs:
> "uncore_pcie4_*" and "uncore_pcie6_*".
>
> To ensure that generic PCIe events (e.g., UNC_PCIE_CLOCKTICKS) can match
> and collect events from both PMU types, slightly relax the wildcard
> matching logic in perf_pmu__match_wildcard().
>
> This change allows a wildcard such as "pcie" to match PMU names that
> include a numeric suffix, such as "pcie4_*" and "pcie6_*".
>
> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>

Can we not merge this. I'd missed a perf tool patch as it was hiding
in a bunch of kernel uncore updates. At the very least if wildcard
conventions are updated then the corresponding documentation needs
updating:
Documentation/ABI/testing/sysfs-bus-event_source-devices

Thanks,
Ian

> ---
>  tools/perf/util/pmu.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 956ea273c2c7..01a21b6aa031 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -939,6 +939,7 @@ static bool perf_pmu__match_wildcard(const char *pmu_=
name, const char *tok)
>  {
>         const char *p, *suffix;
>         bool has_hex =3D false;
> +       bool has_underscore =3D false;
>         size_t tok_len =3D strlen(tok);
>
>         /* Check start of pmu_name for equality. */
> @@ -949,13 +950,14 @@ static bool perf_pmu__match_wildcard(const char *pm=
u_name, const char *tok)
>         if (*p =3D=3D 0)
>                 return true;
>
> -       if (*p =3D=3D '_') {
> -               ++p;
> -               ++suffix;
> -       }
> -
> -       /* Ensure we end in a number */
> +       /* Ensure we end in a number or a mix of number and "_". */
>         while (1) {
> +               if (!has_underscore && (*p =3D=3D '_')) {
> +                       has_underscore =3D true;
> +                       ++p;
> +                       ++suffix;
> +               }
> +
>                 if (!isxdigit(*p))
>                         return false;
>                 if (!has_hex)
> --
> 2.52.0
>
