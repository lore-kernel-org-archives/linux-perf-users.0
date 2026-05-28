Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EA91AA1D2
	for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 21:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780003917; cv=pass; b=actPtoS3AHi2NmV30mNkzg4qPMsi8GRNtI9RYXQoL4X9OyxPjQhNqDKuwtn+ryXrneprOr7amQ/4I4jYxuY41xjoFHb72SMzYiN7YHkXtLBsuxwr+dyhUFc61Be5i/YIHvUedM5OHmbq9mSZtjUanuJjoKi6jLi0XRXQyQQoCq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780003917; c=relaxed/simple;
	bh=6B3DiZENPJKZU35Mh1YH01Eo/iEF+k7/1+GyXwN5yRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aUVjnORYvLhK6+b0jv95XJcEjiA0t3mpwR8tgzAbC06HfhXGls1NZhq3JSnyL1wgO2BOmJjgPMmAVZxfR+ZisLyDnQ1kCuHbjIUbu3k1GZYpXfdwPWPsJpGiiW6G8PluMaCpdift1lf3eNiOsrEdSPXxlngBCxZbrLf1OHGd5Uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j29KIu4S; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j29KIu4S"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1370417c01cso5851100c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 14:31:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780003916; cv=none;
        d=google.com; s=arc-20240605;
        b=esFLKe6hFGTxoqkW5upmEvvAbklwc5/XGDSZdfjkM911fPNQwf7mCrN6sDjYJgZkwc
         CeycTXfw3OzEQppC5Fg6pyDhoBk5W/vdbN5pMhYzf+PiSbZuNA+FackEmYCOCNYHEfwu
         DvMD3qgiqefT4oFeY/zINwQALbRJJjUgMyQk1OQWn44360bNi8h5hAO0lI4HnyySlynH
         MlsnjJluwOuGbanJlYalgFDfvy1svZX92L4O22YR5taauV8iw+HlSze2lZWSNvmYMJgO
         rSGwmZgdtXlNCxRlWsNI6NjTvsurfJFzK8L4yBzzsjVGP5iAuwyHZUWmxWrzxxNBrwoo
         UoWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/RhTlmb6yp6u74xKfUUPWy3UF0l67fTPbFlglmRNEoM=;
        fh=0zVHGC//SC94CWFKHtFt4lnskmkXkJNNy7lE0FDd3Ck=;
        b=Dv79Y1swUL5o0SqBmTwdGr6qxGOZEOepJaOcCCgnby6rbamG4G3gMt00hn/KXFaPt7
         AkCMl/A72VdfmCcmhwPVSldkRerOko6Fr7v9EVRBQIaIoe5ibQ0wEv0SVIIYxRPe0q4o
         UYGTqu6urTuQjjhI66052ZxYoridRnRB5PQeWzl3W7dfYw38GUozStDh09v5Jfsu4N3+
         qwVsX/zk/WYIHoECxGC14QRM2aV7E0NC1XC09KAmWtPowvuNAzo+8FjuzqxLsrgJNenP
         7QAzgDiT7nDSzzT35dgaj9cwsPoR3ZqvvAXCz43SeU8AakRsb6dajXdoC2ZPvze5N3gJ
         T4rQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780003916; x=1780608716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RhTlmb6yp6u74xKfUUPWy3UF0l67fTPbFlglmRNEoM=;
        b=j29KIu4S+SA4cirUK01Mlzdcgb9OO6boLdWc8MCODYg0ncFCGzcCFUQpN/E83VXXln
         1Brs9z74Ft9mI7RsCMQkWtJrzwmAwch76eKvhjLDQRmlzFV1nGT/0e9rHRSxqbFr701Y
         RkgLlc/aTlCAnYsXpKwntop4G2WMwb/drbEGpfD+oNY5YYdUyMnxfY0HjTqaxXDvMBaf
         YbBfQmAjDiRy0NF6Vd0B379sRfQd6d+v1jFOs9hztWyJT2BaE3PpA1qqtbNwGfjRzuVP
         E1vOSZoUGF6nkOPeaJN4MUm8jy+Y1siUX5x73RcwPlU65cpmlTVqJg7+K+0NDuESgemt
         cRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780003916; x=1780608716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/RhTlmb6yp6u74xKfUUPWy3UF0l67fTPbFlglmRNEoM=;
        b=pcbPfqQiylSjw095L3oztdgG2q4iAk85CXh7W1e4BNzYDWNT/67rbBV2SbiW6jJNIa
         E1hOoRUZ/AOYxM9dSM7EXmJB6GUruQxZGoBzgc6log0Fxi3tDxEq3hDW6pyJg4WazMz8
         ozPF4IzpKJR6fq7v/5iUJ4+43N5ExFtDX0Lkv2t6eI/JHLHDOyvb50rFaY089EB7Kmpl
         SaaIrI5o0Ek6e7jRI0aSvk9U+3PrqQHh99G/oGQrQ8oitNYzvin+JbPJREPFxq8rEJuI
         FfMMI0NAiFce+H1e9FRTU5oUMDRubf/hZm72DsAqJCNuIOK2q99QHmT9PdpJL927otwc
         43oQ==
X-Gm-Message-State: AOJu0YytAMYZpkXA9CF/eaECD17WH2BR/PlCGXle/3UFrjg8pAlkyV9h
	n2jeqgDw/13j/T9oiEYfOfQiJ9u4KJkq5AVlZoCYWSDcEuPeXUq+2AoBnvlJYTmUSAU0q6RuuMD
	2DpX+HQAV9Q3oPx8wC0Efcogy4L8w+QLCaAly30yEzZ77RMtiStgzw3V7
X-Gm-Gg: Acq92OG8jxDwBkhzRXXgDmVAOrvc4+stBRvhkO8v0hFqgaytkRjXka4xHoLt4du2ZBq
	g+am3UvTasmmG2Nq7VYTw6bI9S3qq5k3xBh9AaTaVkPZBkTgWI5/h5wsi9F7PuFYpp3x1IeA9rP
	o2peE64bVQmAshq0goMKIDAP1WA3V32QpGiDPd1+Dz77YtHzWYQgGjxE/HMd6PqV0OI+J7o4SSL
	ouYad621GXB+8s0TIaiKWWcHTzDa0cBhraMbgtrmW3AQfcgEM4stCqOirf7aIB21rYfLYZCCLJ0
	GvzIC3fk0jzFuJkC
X-Received: by 2002:a05:7022:226:b0:133:3bb1:8d40 with SMTP id
 a92af1059eb24-137aecb4d6dmr73964c88.15.1780003914784; Thu, 28 May 2026
 14:31:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527221934.3830896-1-ctshao@google.com> <20260528001117.3BBF11F00A3A@smtp.kernel.org>
In-Reply-To: <20260528001117.3BBF11F00A3A@smtp.kernel.org>
From: Chun-Tse Shao <ctshao@google.com>
Date: Thu, 28 May 2026 14:31:42 -0700
X-Gm-Features: AVHnY4IwiF5Pg_HQ1EZNPYq3-_irgF0d3bl9E1urKgBMTUCG97CRDlKg4dpcn-8
Message-ID: <CAJpZYjUiNdN3a6y+8rs=YP2Mgtj6EQJnkiB9TN_suWd8fGkoEg@mail.gmail.com>
Subject: Re: [PATCH RESEND v7 1/2] perf pmu intel: Generalize SNC cpumask
 adjustment for multiple platforms
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 5:11=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [Critical] An integer overflow in `uncore_cha_snc()` can result in a ne=
gative Sub-NUMA Clustering (SNC) node index. This bypasses the upper-bound =
check against `MAX_SNCS` and causes subsequent out-of-bounds array accesses=
.
> --
>
> commit be394e8b7ddbe730c3fc40fb608337fe19c7b33b
> Author: Chun-Tse Shao <ctshao@google.com>
>
> perf pmu intel: Generalize SNC cpumask adjustment for multiple platforms
>
> This commit generalizes the Sub-NUMA Clustering (SNC) logic previously
> specific to Granite Rapids to support multiple Intel platforms. It uses
> CPUID to determine SNC support and caches various PMU configurations
> to improve thread safety.
>
> > diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/=
pmu.c
> > index 7c9d238922a6c..9b00d5720fb7a 100644
> > --- a/tools/perf/arch/x86/util/pmu.c
> > +++ b/tools/perf/arch/x86/util/pmu.c
>
> [ ... ]
>
> > @@ -121,46 +142,73 @@ static int uncore_cha_snc(struct perf_pmu *pmu)
> >               return 0;
> >       }
> >       chas_per_node =3D num_cha / snc_nodes;
> > +     if (chas_per_node =3D=3D 0) {
> > +             pr_warning("Unexpected: chas_per_node is 0 (num_cha=3D%d,=
 snc_nodes=3D%d)\n",
> > +                        num_cha, snc_nodes);
> > +             return 0;
> > +     }
> >       cha_snc =3D cha_num / chas_per_node;
> >
> >       /* Range check cha_snc. for unexpected out of bounds. */
> >       return cha_snc >=3D MAX_SNCS ? 0 : cha_snc;
>
> [Severity: Critical]
> This is a pre-existing issue, but does this range check safely handle ver=
y
> large values for cha_num?
>
> Since cha_num is parsed as an unsigned int via sscanf() from the PMU name=
,
> and cha_snc is a signed int, a sufficiently large cha_num could cause the
> division result to overflow into a negative value.

I think it is very unlikely we would see cha_num > INT_MAX.
Since that is a pre-existing issue, I prefer to fix it separately.

Thanks,
CT

>
> If cha_snc becomes negative, the cha_snc >=3D MAX_SNCS check evaluates to
> false, allowing the function to return a negative index.
>
> Could this negative index then cause out-of-bounds array accesses when us=
ed
> later in uncore_cha_imc_compute_cpu_adjust()?
>
> uncore_cha_imc_compute_cpu_adjust() {
>     static bool checked_cpu_adjust[MAX_SNCS];
>     ...
>     if (checked_cpu_adjust[pmu_snc])
>     ...
> }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527221934.38=
30896-1-ctshao@google.com?part=3D1
