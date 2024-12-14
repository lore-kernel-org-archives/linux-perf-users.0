Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBC7199924
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Dec 2024 19:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734204761; cv=none; b=MifEP5m3gRDcT//J6/9hlMBgwhEJJ66vRSYcq+8K7fDChiiGjf0qPE5tPXU8Jbvcbd6ZziNuldVoYkcr2atUaTlRpy2CX8iPAQOvpt4XPgHztvj68CNwsbpGhZyZlNmv0bDUS9gbB4FKCA9nNmgYz+2tOpsqSJ8g1pILRetdrYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734204761; c=relaxed/simple;
	bh=5Jn6S+PCzo7AtwY/ECptG9xjtJQeXvtl2DfkeEJVwQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=kwh/onA49ojkSdJCP8li7SFAcgg7HFdDBUtTTZ/cmcISNceiGafWdPqq6qOTkrH39XGUU6JdhpzBkG51Z3GCVKthbFTGx+8t54XCjyCNa4oz9J+rkmF157uBvsz3u6E26lgzTczzvlT0WG5GpcMw2YtJQXciNdXs3ZX18TL/OsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FABAKGPB; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FABAKGPB"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a814c54742so135615ab.1
        for <linux-perf-users@vger.kernel.org>; Sat, 14 Dec 2024 11:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734204759; x=1734809559; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ifcfCthQDxy8ySBkB1RvsW8y2Gn8eCLwcVlMpuAFhk=;
        b=FABAKGPB2fqG++cv2YvXkOIXKv+wO0QQ90KfG8FAD9C7Hz8I6O3g0i2XB1CRAE1u0p
         /vnyUHwZRsHis6RNN4AysTmHnNzhLe/ZE4R6Sz89Qkswp/01zuqLuB7Hxm44kH/u03bC
         EY79L6tPlemP0U6KYnQx1iMthAL4XG/3DPdcFlqIBlf8JYCAC6EQN4a+Z6R5kMMYcKWe
         bdmDr9D1LMN0QvzvK1I5raWebqMLPjgVUhUjkPn+9YwSoF8o/MbnlM1teTd52bgp7tFx
         Wn+NXxatirwLqmPX/rs1oHzs1bXvkc3D3NeWL+mdMnlMWbBo2fE+B1JpQbYnhvdci2fl
         ehng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734204759; x=1734809559;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ifcfCthQDxy8ySBkB1RvsW8y2Gn8eCLwcVlMpuAFhk=;
        b=kN7sGW5GnBTM6Nyq/5mRJNcWT+RLi4vuclwAeljqY+uhducxlBILLySfndcya7+S9u
         SJ9RBwXQ/jlwt5rk7oolSI/QhQCSXWAJDxVjRWeCX4apEPq5zdqd8fvowDr7vvHnztdh
         k9hINsnKiJcln9mH1VAWH52DWYWhEeQRA7a8quOxOAkyblG41nZyRTZrmsNNHUv5HfgR
         OPHCXKJTChvO+qrq/IO+z2jYyJh2FPMR/pdKLqU4r7zBc0TXS2zpUYOoVZMCwCcmVIIf
         dxDq9dKzWKxkoNYrHYDiOwUYNiRo/b07yfa5oreWY86m6vPlt7KLPTGJPYzJSXpLoHHM
         bRcw==
X-Forwarded-Encrypted: i=1; AJvYcCVb0nsXzf5X5jn/SX4fpOlU6c9UuvCoOrPQbxjLfds/w04cRY5MESJOvHT3s+DXO+04wOadyCGhH0V+/Nmp8MX2@vger.kernel.org
X-Gm-Message-State: AOJu0YwE2dwYxNMNGqyzLqHbUYFNQjNy1a9S8bHTVcYUcRuDOUf5kqQB
	JCNlWO35uBHkRdUtmS+iQiiDtl1p9aGMWSzSWyewcXoho0zdoS5VtusNXXX5bj35F6Uk/FWrvB8
	dEp8SWKyuRfeoS6QDaWwKUP9RpfVL4obcHQEw
X-Gm-Gg: ASbGnctcaQCorJ8KYsU3KZ0bsp2l23enz9g2zIaHWdihFECNp9pgRHglt39jS/rbnuC
	Rw5AqZ9+9yfNO9hObV57yt76QSNlXDzRB9VeRvCw=
X-Google-Smtp-Source: AGHT+IFGhEb9ifi4P5jJR6XUfQpzX49Z5lgclmZFwa3AsU2s1eMDMawXBOKA5N9NN49ZI2HTuN1WkAnYhYmJiUN64C4=
X-Received: by 2002:a92:cdaa:0:b0:3a7:e616:8d36 with SMTP id
 e9e14a558f8ab-3b2c59470f0mr1754295ab.9.1734204758801; Sat, 14 Dec 2024
 11:32:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212080530.1329601-1-irogers@google.com>
In-Reply-To: <20241212080530.1329601-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 14 Dec 2024 11:32:27 -0800
Message-ID: <CAP-5=fWtxkt_kFCF8G=Dp4Fj+=m1M7Fv6Ep4RvJmH_k-k53rNw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] perf synthetic-events: Ensure features are aligned
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 12:05=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> Features like hostname have arbitrary size and break the assumed
> 8-byte alignment of perf events. Pad all feature events until 8-byte
> alignment is restored.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

This change breaks pipe mode tests for me on ARM. I've not investigated why=
 yet.

Thanks,
Ian

> ---
>  tools/perf/util/synthetic-events.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index f8ac2ac2da45..5b14244253b5 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -2401,6 +2401,11 @@ int perf_event__synthesize_features(const struct p=
erf_tool *tool, struct perf_se
>                         pr_debug("Error writing feature\n");
>                         continue;
>                 }
> +               while (PERF_ALIGN(ff.offset, sizeof(u64)) !=3D ff.offset)=
 {
> +                       char c =3D 0;
> +
> +                       do_write(&ff, &c, 1);
> +               }
>                 /* ff.buf may have changed due to realloc in do_write() *=
/
>                 fe =3D ff.buf;
>                 memset(fe, 0, sizeof(*fe));
> --
> 2.47.1.613.gc27f4b7a9f-goog
>
