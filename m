Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2312D9499
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Mar 2026 18:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772736977; cv=pass; b=X6OpT01Ne7vQ1Nl/OUa2zNbDMbxDemVSFPGuGt/N/RlpSIaRQi778rrom4Uc00ukE6IL3cfH4Aq/zi72PGLqXjpCJkGl84GKL4AjeJeB93LMi/jQfGn1reSHdvr1T2twVBErN3FQFkOkMSdcg+h0kKnSRIDtl2TCJ/W1mBTKwdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772736977; c=relaxed/simple;
	bh=6kMpd89SrVEzkjyWZWZY3bxwtPhoW0V2aoMMjGhPxOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dnhP8Sx0GLPMoer3ivcfYu/EBajvtpNmWeGLTZfKnfMSOLhjnx4dd//xUEK15cbKZils6tFq6j1HUpt2v9kA6YJaPzz+7kY5WMpfYTRGlNzl/BRagEpCuhnoi2uEhaTgDa+m3lUQkRNMlRI3+Gv6zvqYdcAJIaTgUXT8jyaDBQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rli+gPj/; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rli+gPj/"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ae49120e97so9175ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Mar 2026 10:56:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772736976; cv=none;
        d=google.com; s=arc-20240605;
        b=FLeiVUv+WYtevNUZfbO+gp8W0WpyiAEJx0yoj+Tn6ycp6iPM2j3KNuueJS3kmtYvyZ
         yqKOnydHr4i2lyEcpwpFQsqTV2pfWw39Eq5h13i+ms0pRKZe4y75ddQocgJgoVVyGUWw
         qVump7vXbexCo2BWofQSgZHOJ6iNXLBmbRaxPjFAtmPPc78DdoU0RILHnSswCRAwCe49
         +FoR25heLbMnSVcTmTZA30HGBYwRH5uS3jZXeCHp53ZkzDR1NyDQpjxtkByy8FRQgn9Y
         ajIgtNv4Qhs2OiAvXU0+lRMtQDXAiIsaLo4Sy712PUlfRdYLyA/fLWdJzVVRI4MuaSpG
         X46A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iWcKzDGDl1VfohdpvRNb1j6fkH1FFT60689mg8RwtCw=;
        fh=U4BlYhkLd8ug5e9G/W9E+XItyO9dTGOTjng1XJcNfr0=;
        b=MSkmWS4ey2ftnHSmRltGFyshxjtDc9NPkC4gCdK81gZdSJ7xEFzBuO4lNjrtfMySP3
         +UfVfrTDtNbjteV99TWX0lc9d886eExqxuoTTNi6OptmHVFNogYACHW6q9DkebgCCTvq
         zc+Qm+mJBWVxNu39lKR1ysZ34i7ZhnlROiKdhejE1zd/8uxhjmn0UL3gIa+Lci+9IiUo
         7v0mbIHpHbLgMjxbkJl8cqlABDP0K6sWg8HviiAT8pIKD8CvTN02iqWttOl/dVF/aSKJ
         mKIOFNXmF+Lt+CWmKX7BlF+mP+EExbpvBz/6l5aytibhYaxEzXMc85TK09+1fX9C9AH8
         9A0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772736976; x=1773341776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWcKzDGDl1VfohdpvRNb1j6fkH1FFT60689mg8RwtCw=;
        b=rli+gPj/ygpG9dHDjR+9H3+eJClOg6DWKh/+d1jxSHy7TaTzp78Kh+CaUfRhM/4NbU
         SLBw4sVzbbh1ZGGayuOuXTvYihIdw4BmhR3OiTHhYdSW5PJ7XjehB98LKiRpvHmduvg5
         BnCiLOQ8eVjB/wK3N2Y6oZNxkcIlzHO4Vk/VcUFKsmx9iLYffXYOH4OLfLAVio5Ob3yD
         7lDdUMi+LKG/EQdPEoZMAjyDlYv/ihKzoAGNcgg2BByy9o3xK3zKQuLmZDDC5PT+KMTI
         zTFVTggVXtWCUOh1B8pa8+3Ps2OCWg9FU/WzVnpmju96k1AGp62++t3KWzIBlEczgc19
         L3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772736976; x=1773341776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iWcKzDGDl1VfohdpvRNb1j6fkH1FFT60689mg8RwtCw=;
        b=OhmJaL7HE662kvv05RjGcDp/iZLwrnv2UKuoCNlTgytGRz4xxfgUkzWAqYKRLvKc79
         f0JT88evW/EGoOOlOuidpIl2G1G8cI3K2wwuiKDNhpRxXsi3+7nQrwtwo4YGtLAvu0kv
         /uOe2kun3vtb/glJHOBIzvcw8rbwtbLkyCVMuyMVXPNQDONA4wX3oOBZ00smDJ5QXdfA
         xWSuZ0+1AQ/U9mQPYMsrAWrbGheX8thhHEpDsLGv7cgc0TZ9WiMv/z5Djdd5Ck38OaVg
         aLbfC/EBM+3nf1IG6XqESwSmz9kNeH+FNdDA8HQek3on+wqPXwZzsUsTPtG65k+k3ghg
         /MXw==
X-Forwarded-Encrypted: i=1; AJvYcCX1T9YsRxca93xNvBiMIw285SSxnIXSg6N5hfl9rPiK7Mpcgyo6ZjMYiqRKKm2u69+tWimKKtJCO/DmhKuixmyK@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6fSssM9NZpidtHLAIpHCpNZEyM+48vQ7RsVgACYl7PQ94fsMT
	5QWnRk8xIsWM/z84RgbF2LPbermFRHSoXIKwcqGUkEOVY0iv8iVa5yCf79l4s8HcJ5iMmcRDX5H
	f1Y2B7FKTo+lZxNHTpM1IzMFOcOvhrFiSLwvFSvn+7sZUbZt519TfbFqIHAw=
X-Gm-Gg: ATEYQzzsY+jcoleEzur4Aozi1qfyQ5YxnLdB5N7xn72m0TVdWmCJtnhGQbz41QkewRE
	C5w8SBjHMWPXXyugslpOf4rrHq2VbhZOWCJWljoIBwFKvoVfxlgLYli32oO53/SZ2vAMiQschc+
	ZXcfdhWMy2Kp8IjihxeQFVrCivITlbCkEg5EzaqvdAAqhJ4l1jKmNC42g0TvsauR3zXrKOEzuaO
	iYcth50E9i1t9VIkxceO4d16Z2HKOiF7uKUsXkrJd7PAR0hQDqIsNgvkYFZ7UEsS0UgiUhYStF9
	TSfWW0BmvCyhbKWTdn7R3QdGfEd3jdnzO0m0a4eZ1t3DteM=
X-Received: by 2002:a17:903:b50:b0:2ae:7fa2:6bda with SMTP id
 d9443c01a7336-2ae8120df38mr197525ad.1.1772736975155; Thu, 05 Mar 2026
 10:56:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAoXzSqHuQd7k9rp878YBG5gbChgOaProPQ6XBzKpy81JF5sKg@mail.gmail.com>
 <20260202162057.7237-1-yuhaocheng035@gmail.com>
In-Reply-To: <20260202162057.7237-1-yuhaocheng035@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 5 Mar 2026 10:56:03 -0800
X-Gm-Features: AaiRm524WMpSRhyrow1SEg0u0icWNC-ZQBR4qsgb-fg0X3WbVcj7lKrROj_fawA
Message-ID: <CAP-5=fVJyVMZw=DqP53Kxg58nUmJ_0bxoaeOKAbC03BVc11HaA@mail.gmail.com>
Subject: Re: [PATCH v2] perf/core: Fix refcount bug and potential UAF in perf_mmap
To: yuhaocheng035@gmail.com
Cc: peterz@infradead.org, acme@kernel.org, security@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 8:30=E2=80=AFAM <yuhaocheng035@gmail.com> wrote:
>
> From: Haocheng Yu <yuhaocheng035@gmail.com>
>
> Syzkaller reported a refcount_t: addition on 0; use-after-free warning
> in perf_mmap.
>
> The issue is caused by a race condition between a failing mmap() setup
> and a concurrent mmap() on a dependent event (e.g., using output
> redirection).
>
> In perf_mmap(), the ring_buffer (rb) is allocated and assigned to
> event->rb with the mmap_mutex held. The mutex is then released to
> perform map_range().
>
> If map_range() fails, perf_mmap_close() is called to clean up.
> However, since the mutex was dropped, another thread attaching to
> this event (via inherited events or output redirection) can acquire
> the mutex, observe the valid event->rb pointer, and attempt to
> increment its reference count. If the cleanup path has already
> dropped the reference count to zero, this results in a
> use-after-free or refcount saturation warning.
>
> Fix this by extending the scope of mmap_mutex to cover the
> map_range() call. This ensures that the ring buffer initialization
> and mapping (or cleanup on failure) happens atomically effectively,
> preventing other threads from accessing a half-initialized or
> dying ring buffer.

As perf_mmap_close is now called inside the guarded region, is there
potential for self deadlock?

In perf_mmap it is now calling perf_mmap_close holding the event->mmap_mute=
x:
```
scoped_guard (mutex, &event->mmap_mutex) {
[...]
ret =3D map_range(event->rb, vma);
if (ret)
  perf_mmap_close(vma);
}
```
and in perf_mmap_close the mutex will be taken again:
```
static void perf_mmap_close(struct vm_area_struct *vma)
{
struct perf_event *event =3D vma->vm_file->private_data;
[...]
if (!refcount_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
  goto out_put;
```

Thanks,
Ian

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202602020208.m7KIjdzW-lkp@i=
ntel.com/
> Signed-off-by: Haocheng Yu <yuhaocheng035@gmail.com>
> ---
>  kernel/events/core.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 2c35acc2722b..abefd1213582 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7167,28 +7167,28 @@ static int perf_mmap(struct file *file, struct vm=
_area_struct *vma)
>                         ret =3D perf_mmap_aux(vma, event, nr_pages);
>                 if (ret)
>                         return ret;
> -       }
>
> -       /*
> -        * Since pinned accounting is per vm we cannot allow fork() to co=
py our
> -        * vma.
> -        */
> -       vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
> -       vma->vm_ops =3D &perf_mmap_vmops;
> +               /*
> +                * Since pinned accounting is per vm we cannot allow fork=
() to copy our
> +                * vma.
> +                */
> +               vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDU=
MP);
> +               vma->vm_ops =3D &perf_mmap_vmops;
>
> -       mapped =3D get_mapped(event, event_mapped);
> -       if (mapped)
> -               mapped(event, vma->vm_mm);
> +               mapped =3D get_mapped(event, event_mapped);
> +               if (mapped)
> +                       mapped(event, vma->vm_mm);
>
> -       /*
> -        * Try to map it into the page table. On fail, invoke
> -        * perf_mmap_close() to undo the above, as the callsite expects
> -        * full cleanup in this case and therefore does not invoke
> -        * vmops::close().
> -        */
> -       ret =3D map_range(event->rb, vma);
> -       if (ret)
> -               perf_mmap_close(vma);
> +               /*
> +                * Try to map it into the page table. On fail, invoke
> +                * perf_mmap_close() to undo the above, as the callsite e=
xpects
> +                * full cleanup in this case and therefore does not invok=
e
> +                * vmops::close().
> +                */
> +               ret =3D map_range(event->rb, vma);
> +               if (ret)
> +                       perf_mmap_close(vma);
> +       }
>
>         return ret;
>  }
>
> base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
> --
> 2.51.0
>
>
