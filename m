Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E57256C8B
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Mar 2026 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772823871; cv=pass; b=oAj0dGBtoCLKvsBUEbAUvngo0LidqRr16H1p/epRuCqZlMEWbTY/exhV8s1sQKmoxodXNHctlqpmR3013hVbz6jSK/0oVFM6Hv4ZRetFN9bZm6yp87Pk5hYHbjP8Yfm72mg5XBab7M5YFUC0/LtsZiZvqVjRRQAg8+k45mwGOVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772823871; c=relaxed/simple;
	bh=Bmtc3paof5PSRC3Li9CVKhdvh/PAOZs8GwMne56j9XU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2k+CsGJ503p02BUFCEhg16Pz3IHe10ESEGjsWCs5hQn0yyDj1RqzpGCtJsFq9AmkCWwKXLQcmRK1A1xDCvxOKHIuj1yBvHFt7914KCS9owzBA8TohTfLiT76HU29ax44ki4naw77VFbt0modIidg1P9jS5g1IgDnsBuBg3EPP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=giQ1XJCU; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="giQ1XJCU"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ae523d54d2so6865ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Mar 2026 11:04:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772823870; cv=none;
        d=google.com; s=arc-20240605;
        b=UdjyCfqaKnC6SnWPiKA/LxMFbTo+KxZ7wPorynKMeTDiN+vetN+hd+U+DvgYGJKff8
         rX0RIQVJyiqU6eYZYUzNzlNZ7Z7DAUaCUcupNgK0hxPD2jLgq8lz586bV7J6IyBz8LLs
         3F+GCK7XqbmlRaO36L7/5Wid1aq4WoGVEBIGwwWaq0OaoN3/fdeS4kIVjAATLyo39uqV
         t9r9QAjTlOyL2myljijEXvcvC5GxG+cr14/fyD2A441YKek2M6i/hMvMPmEjbPPn6Oai
         d50qNLh4bdcr1Pb7+/apTNe04W5XujJIBn00GbVsda+IP+Bq/NpA5BvaveGAIkAGg+5O
         Llgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wXhQjQ8hmzmRr9XNzl7m/m3PIVchZIKzZRejOQjYklo=;
        fh=Ej4+obUIHFLwFf4rXqrnC+wPh0pBQquLqPgvg0r49Dw=;
        b=NuTrlTSkFDg4SWIRq5C1p2df/siPMUxdJ5y3AjvG5cijYdHBgF89BEbRYHr1QMT6pD
         FQqK2KpwNBWZYMdDxRRtnufT6Q0lhnTLPMNtn5miHg79WZDOf/ZFWlKYtSe2adbc+GlM
         Yszmd+w5lTwXfxw4xsklqEuYRv6mGDgQuNdrcLR/r/NekK3Yg48dFOfB85IMMEdSmHsx
         lXtX6SX8HExbeVc4TrkzxJEBH5YpgvPGJoNgLGr2IxX5j+v/YPOYO3UTYS8wiWq986od
         YlIXwS/nN1A0Jb0Re6jPMm+udN4TwUYgCPvL2u9c0hPFY9XUIH1b/QFFhn+Gso75WAGd
         5J7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772823870; x=1773428670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXhQjQ8hmzmRr9XNzl7m/m3PIVchZIKzZRejOQjYklo=;
        b=giQ1XJCUF27oqiPEnFMXizD9TJHp8h1SfT44sfnzZIUsbYl+o5GjVqmmNcpsZeOpGp
         N3UBo7SbNNDyoeWD8Jh+JWnCBw13D4f1igs1KARPBA7GvoxjmQjbWe67OR9bQz6mRaj/
         700fNFzHPEpvC+VzoVuejAbR8LFSiWXMmappx6wFGAJErA4p4qu2MT8Ow3zJ/1BwML2g
         ic/OcCUo/8QSDIIrGCLTjPAxe9iRK0AhMS9jDHahnRWMC0lxO5t9DQu0ItieV+wjWxvL
         AzOHtgZs1mqHDjEu4Qxg0Qd4vhgvFeDkKgEyC3TV4pBHRC/pmmIZnve0ED6/xpQ3Acrv
         RwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772823870; x=1773428670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wXhQjQ8hmzmRr9XNzl7m/m3PIVchZIKzZRejOQjYklo=;
        b=Q96cxwt9MgzZIJmBWn/QXH2T+m/FEVmg8SXlwwZCSntqAMZlGwjXDNmKTILr/QBeYR
         Vd5uXFWugpYFK2JNHlyuvRD6EuxSI7lV8MDiHiKdSzSIE0mpAvwnbK89PwrhXjYEFgYu
         4K+iQvugRljn1C6I6EPHa/AoJZ0G2o4Zq2iToXC1OcpM9ywQ8Ej3WNBJpjuZ313ZQbU0
         SBbWbvt7iQ1xtPEfiUcDJbcdfMBr8eu+SAWIN3y/+EglV/wyKBpOYDLQ2CVXqSGn7nrf
         8yieF273DATnger+NERQtoStdJnAA7q/yOcZe+qtpFRCwqilrnX1W1kUyp41TkatIETX
         Xm4A==
X-Forwarded-Encrypted: i=1; AJvYcCVxiO6ADkY2MKuLb5K005/kTdKdvGCPWIBeFSikLGRKFRnEV3FE7SZYMJBZYoQA/ccB3WOfBhWdefxXE63vdAgA@vger.kernel.org
X-Gm-Message-State: AOJu0YwbXtSHSwyL8SE42Aq6Ec7IrZEm1QwaoWGa86afFqkdq1G1OkDg
	K/PxCqMQ1HbGfI/5f6/Nm7hb5DCtt6IZDxWHuXR0sDt+utfplo6D6v+Ym7mY+zsKHO/kq0gnE9e
	g7DSwHhOCmp0sYwmcmyxImA+0+IzPy6ch/jJDPIq5
X-Gm-Gg: ATEYQzym0Xgu0J6bM7ebZRSCNo+1om9bka6lcng0PaWA4ZID866KbKZNqZlVHPe2VOh
	DABW8bsoELLCC1BrGWRCL4vt33NdLCAYsbcb3YUsZpze6TnX+5diiXBbbjuJkPftrXvBZ11D78z
	/vNG4zgm4OxZsxWUVSTJ5ELvNRgh+NnKoGDXSUNG7YGRBY1595M3VXpogYc1PXGQt+SH5DLTBKq
	Jgw6V8QdeUWK7DQ2sKDRjoVWKuWkTsxKm96jqpPTlvKL3+I60v6b9B0K8akn1/2uHX5xLXlKpIq
	XSXUlo+X
X-Received: by 2002:a17:902:ccc2:b0:2ae:6432:8f77 with SMTP id
 d9443c01a7336-2ae8ae3fbebmr155385ad.17.1772823869369; Fri, 06 Mar 2026
 11:04:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAoXzSqHuQd7k9rp878YBG5gbChgOaProPQ6XBzKpy81JF5sKg@mail.gmail.com>
 <20260202162057.7237-1-yuhaocheng035@gmail.com> <CAP-5=fVJyVMZw=DqP53Kxg58nUmJ_0bxoaeOKAbC03BVc11HaA@mail.gmail.com>
 <CAAoXzSqLGqBG+n-rLCssz7MZSRLvLvRv6Rivtfg_OCyLPWoxCQ@mail.gmail.com>
In-Reply-To: <CAAoXzSqLGqBG+n-rLCssz7MZSRLvLvRv6Rivtfg_OCyLPWoxCQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 6 Mar 2026 11:04:17 -0800
X-Gm-Features: AaiRm53tmne7NeWqlBPKsue1R8_VsvtYvcli5Sd9KtIpAb8FntXfKKiXrhYqGM0
Message-ID: <CAP-5=fW-wHEv=TCULwk_HVOhWHdqRd8AZoESZsU_vnhLjghUBQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf/core: Fix refcount bug and potential UAF in perf_mmap
To: Haocheng Yu <yuhaocheng035@gmail.com>
Cc: peterz@infradead.org, acme@kernel.org, security@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 1:37=E2=80=AFAM Haocheng Yu <yuhaocheng035@gmail.com=
> wrote:
>
> That makes a lot of sense. It's indeed possible for a self deadlock to oc=
cur.
>
> I tried updating my patch by modifying `perf_mmap_close` to get a
> `perf_mmap_close_locked`
> function that handles the case where event->mutex is held from start.
> But this approach
> isn't very concise, and I'm not so sure if I changed the original
> logic for some unexpected reasons.
> Nevertheless, releasing the mutex before perf_mmap_close finishes
> executing might cause the
> original race condition issue again, which puts me in a dilemma.
>
> Do you have any suggestions?

With the:
```
+               if (ret)
+                       perf_mmap_close_locked(vma);
```
Wouldn't moving it outside the "scoped_guard(mutex,
&event->mmap_mutex)" be a fix?

Thanks,
Ian

> Thanks,
> Haocheng
>
>
>
> > On Mon, Feb 2, 2026 at 8:30=E2=80=AFAM <yuhaocheng035@gmail.com> wrote:
> > >
> > > From: Haocheng Yu <yuhaocheng035@gmail.com>
> > >
> > > Syzkaller reported a refcount_t: addition on 0; use-after-free warnin=
g
> > > in perf_mmap.
> > >
> > > The issue is caused by a race condition between a failing mmap() setu=
p
> > > and a concurrent mmap() on a dependent event (e.g., using output
> > > redirection).
> > >
> > > In perf_mmap(), the ring_buffer (rb) is allocated and assigned to
> > > event->rb with the mmap_mutex held. The mutex is then released to
> > > perform map_range().
> > >
> > > If map_range() fails, perf_mmap_close() is called to clean up.
> > > However, since the mutex was dropped, another thread attaching to
> > > this event (via inherited events or output redirection) can acquire
> > > the mutex, observe the valid event->rb pointer, and attempt to
> > > increment its reference count. If the cleanup path has already
> > > dropped the reference count to zero, this results in a
> > > use-after-free or refcount saturation warning.
> > >
> > > Fix this by extending the scope of mmap_mutex to cover the
> > > map_range() call. This ensures that the ring buffer initialization
> > > and mapping (or cleanup on failure) happens atomically effectively,
> > > preventing other threads from accessing a half-initialized or
> > > dying ring buffer.
> >
> > As perf_mmap_close is now called inside the guarded region, is there
> > potential for self deadlock?
> >
> > In perf_mmap it is now calling perf_mmap_close holding the event->mmap_=
mutex:
> > ```
> > scoped_guard (mutex, &event->mmap_mutex) {
> > [...]
> > ret =3D map_range(event->rb, vma);
> > if (ret)
> >   perf_mmap_close(vma);
> > }
> > ```
> > and in perf_mmap_close the mutex will be taken again:
> > ```
> > static void perf_mmap_close(struct vm_area_struct *vma)
> > {
> > struct perf_event *event =3D vma->vm_file->private_data;
> > [...]
> > if (!refcount_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex=
))
> >   goto out_put;
> > ```
> >
> > Thanks,
> > Ian
> >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202602020208.m7KIjdzW-l=
kp@intel.com/
> > > Signed-off-by: Haocheng Yu <yuhaocheng035@gmail.com>
> > > ---
> > >  kernel/events/core.c | 38 +++++++++++++++++++-------------------
> > >  1 file changed, 19 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index 2c35acc2722b..abefd1213582 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -7167,28 +7167,28 @@ static int perf_mmap(struct file *file, struc=
t vm_area_struct *vma)
> > >                         ret =3D perf_mmap_aux(vma, event, nr_pages);
> > >                 if (ret)
> > >                         return ret;
> > > -       }
> > >
> > > -       /*
> > > -        * Since pinned accounting is per vm we cannot allow fork() t=
o copy our
> > > -        * vma.
> > > -        */
> > > -       vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
> > > -       vma->vm_ops =3D &perf_mmap_vmops;
> > > +               /*
> > > +                * Since pinned accounting is per vm we cannot allow =
fork() to copy our
> > > +                * vma.
> > > +                */
> > > +               vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DO=
NTDUMP);
> > > +               vma->vm_ops =3D &perf_mmap_vmops;
> > >
> > > -       mapped =3D get_mapped(event, event_mapped);
> > > -       if (mapped)
> > > -               mapped(event, vma->vm_mm);
> > > +               mapped =3D get_mapped(event, event_mapped);
> > > +               if (mapped)
> > > +                       mapped(event, vma->vm_mm);
> > >
> > > -       /*
> > > -        * Try to map it into the page table. On fail, invoke
> > > -        * perf_mmap_close() to undo the above, as the callsite expec=
ts
> > > -        * full cleanup in this case and therefore does not invoke
> > > -        * vmops::close().
> > > -        */
> > > -       ret =3D map_range(event->rb, vma);
> > > -       if (ret)
> > > -               perf_mmap_close(vma);
> > > +               /*
> > > +                * Try to map it into the page table. On fail, invoke
> > > +                * perf_mmap_close() to undo the above, as the callsi=
te expects
> > > +                * full cleanup in this case and therefore does not i=
nvoke
> > > +                * vmops::close().
> > > +                */
> > > +               ret =3D map_range(event->rb, vma);
> > > +               if (ret)
> > > +                       perf_mmap_close(vma);
> > > +       }
> > >
> > >         return ret;
> > >  }
> > >
> > > base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
> > > --
> > > 2.51.0
> > >
> > >
