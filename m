Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C52633C52F
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Mar 2026 05:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772863062; cv=pass; b=Y+8iR7GvlwbUTJFbY52abkTioNJAqREkZmOQg5Nb3Af4XKLike454pahy+QtS41IObHJDVWE4OBTIP0zfjgPmzwXmtBHdCdpNzNMFP6S9Pfgv/4Yj8zXgX5XTEtmBHTonwoMxam1lHVz3XTPft9d1epNppILXkifK7m2qNxJMSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772863062; c=relaxed/simple;
	bh=Hntitv5x4Dxa3kq7hMu1l9K9g/ZxY/p9Kki3n6V6n7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CvBer8vbM3N6ODr385o2/zEhAZORyYFfEwT7/HuRbxXciyi8mPMn4bxaVGLvwBrW7Tcp6d7ZgcGlK4jeoNhROQIJeP7H0V8gZ/rOdL1Nk+J5a3mCfMf36WY+fG3t3pHRacTxHN5kh4B8aabru1/DGHCsqE3KFYr56pS8zPmxkVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3q1+KmE; arc=pass smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3q1+KmE"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-89a0ece9f14so67526966d6.3
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Mar 2026 21:57:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772863060; cv=none;
        d=google.com; s=arc-20240605;
        b=ZZfJclnxOFPtFyFR9oYeHo5c80w1zOvm7fs50yAh7UQAhUFGtX62kQpx8DBAzrWpnr
         BlwSptuvJToy47CLTm8xi0gBdT/Jao0QxgeZgHsh9X/ZpxgXgoCuHK5hkvo16z4Aprag
         eMJI897Nyj2LkroRrzNPJEb9PtKJQz1/P1YdNpk9ybq+OiHewClku0uUuAVKaTd0q65I
         W/foCO1AGsFY/jBiNdYOGUUMDnjRIbSHOV4cJR0vSyuMcMTKRzrEKcExmYNWMyR/FlMR
         vTe0mn0F9BEIO5k3lsBeI4niXkEqKx6cMglx4FKx4vvrzf9zAnx4a2Jozm8r1ILcQIkC
         xNiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hB8MNHdf2pFSjQWfdLIaP5HsqYrb0xCWOL6ZGVTm/mM=;
        fh=3L7i13nZq4jHS0TQ1KczsplLEAQobcEVdzLVG+mSjS8=;
        b=HaSh+sfWhByiorWdpkVEr174AGiS4ItxCXlsjMkjBJUTy8J8/tXNHebA0qDlh0vvI3
         8btEHyWQKf14YCs5CTogfsvV1lLyOPH/qdABllvn3e1LKFzGUR6j8FyeMFH7tfBTMtff
         inaHKzYrH4Spbrgw5kUn0P6AwUWzF1ARYUvcHv+QigxKNMngvMHlUroKURlETgKDafAk
         7G6VXNoYklvMRk5cL1WjHU66ZuuKPEeyfVU7QyOt84G1fp5Ep+jTLhPmMZS/aj5VfL4U
         SgqFPgHAi1w6vJKGmFVTvNRky+WvrLsv+n8YXLZi8DAUJR4+BpavAW/qUoTk131EcLwk
         jDLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772863060; x=1773467860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hB8MNHdf2pFSjQWfdLIaP5HsqYrb0xCWOL6ZGVTm/mM=;
        b=L3q1+KmE4cBtnwAXc0ly5HPtSkkwJSRFxQKxwiQo22eeobKxxNVUJt0I1XhRbx1ON8
         Ai8wKZK1Zkg2l9+FGlTe/HXBtQ3Fit0PRnUGuQI0AevOA5IsPTjdTeZ9fXT7mzzHH3M2
         tpV50ZfxY0Yxm9XRDW5hrm8VJoH3sskxtRs7liTE1eretaKgj/QWCLTlx8pyNgfbCI0P
         7esyV5yA0SAOLyQTKWdxDnSClgaocWHNsFXpozZI7GVDR9kefNmnWjVos6VUpMFrEWYw
         Q7k2QMho+Mn6bm47m1/0ZpcOsT78l2F7y+n7nLJFC2TTIOpTAx9SfG3t0bJgG6Cmbw56
         8nPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772863060; x=1773467860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hB8MNHdf2pFSjQWfdLIaP5HsqYrb0xCWOL6ZGVTm/mM=;
        b=GgFxjylaDr2IIlAuvK08HMn/uSL74JvTjDhk3SPhfuez6NLq6Fx/lTAs23uNJ3So8F
         VgZ31HVPOFm9kVeGZtFLaxdPw/sdc3GrwObdVln21jc6+UVNfaaXcSYYCi8oeSu38mLj
         O5c1ePnPcqFELp74qK2R/V3EBKRsX/WtVtMaYu8lviVnOWoL/ry3PtINiuLSIYsqTmRg
         XGfWz1BpNBLB62NEJpsvPJnhwiLLBAT5kYEQtI7unn2J+nheqjisvHBQLbZ9SM0MXBLT
         /OFao8us+TBz9egoAIhbKUoYBiegArNYnroYNHmYvawnR15IQscXL7sTmTWUXGg020jm
         DYPA==
X-Forwarded-Encrypted: i=1; AJvYcCUtpcGPo6NfLuBvUkEX9UUg7lZH2Y4ywcevF7YeHxXWD8uYI9p0NB48FCxbDosgF7Ho2lzxBJwDaxiJrRkeCDTl@vger.kernel.org
X-Gm-Message-State: AOJu0YzJS/TPkiGzrzHiysTQfWvMtfNl9f+nHcLCqeEoISue44pX3fcH
	DXQeqytVy44NU+4zuCnKTivdV+rwpwRaPFicwPaMDy9UM2dRgxmpuXjimAyKhlBEcGdxHuVzHQh
	ads8rrl/ViopUIceVf8SH6Wt0qd+ve+423nXDKJaRuF1m
X-Gm-Gg: ATEYQzz8H3d11zPUCTzFOIbhfsgTnUM7yi7UloYl4nFng5nNkCwFXBoN+1lOC6FnCDT
	Ewdu2FeQHbLAKqQBOZDW/cjYSnM4DG/9je9Q4xg88SG44xZQ99rw2ghFeZgKrnDXu6/V3VdtmON
	sEiqfGMvGhttlm1CndrPdZDFaWiEnbGo3VcT93eswaWxgI7R2hPZ6CdJamYOCokRFHmzfGyHMAm
	04V8dpeX903mZGA9rTSZ8LXa0WKz5e7Id3fjxJ+OvnIybXgf4z+XX6mH7SNuU3aYyrX+gEnlKs2
	2CBa
X-Received: by 2002:a05:6214:622:b0:89a:181e:446d with SMTP id
 6a1803df08f44-89a30b20217mr63334586d6.65.1772863060016; Fri, 06 Mar 2026
 21:57:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAoXzSqHuQd7k9rp878YBG5gbChgOaProPQ6XBzKpy81JF5sKg@mail.gmail.com>
 <20260202162057.7237-1-yuhaocheng035@gmail.com> <CAP-5=fVJyVMZw=DqP53Kxg58nUmJ_0bxoaeOKAbC03BVc11HaA@mail.gmail.com>
 <CAAoXzSqLGqBG+n-rLCssz7MZSRLvLvRv6Rivtfg_OCyLPWoxCQ@mail.gmail.com> <CAP-5=fW-wHEv=TCULwk_HVOhWHdqRd8AZoESZsU_vnhLjghUBQ@mail.gmail.com>
In-Reply-To: <CAP-5=fW-wHEv=TCULwk_HVOhWHdqRd8AZoESZsU_vnhLjghUBQ@mail.gmail.com>
From: Haocheng Yu <yuhaocheng035@gmail.com>
Date: Sat, 7 Mar 2026 13:57:28 +0800
X-Gm-Features: AaiRm53n1N5dksFf-amQ5HSchkqt1wYsw83FHQsz-ADQBhOOVfL_gbO7KYTlBNU
Message-ID: <CAAoXzSoYPvE-AdhT28Rhik2BtFhFuntaM6uhrMqKLUaDgkyiNg@mail.gmail.com>
Subject: Re: [PATCH v2] perf/core: Fix refcount bug and potential UAF in perf_mmap
To: Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, acme@kernel.org, security@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

But if it is moved out, other events might be able to hold the mutex after =
the
current event finishes executing refcount_dec but before releasing rb, thus
causing the race condition I mentioned in the patch.

The following is a more detailed analysis:

In the C reproducer, these four system calls are central to this problem.
Specifically, the third syscall takes r0 as an argument(group), establishin=
g
a shared ring buffer. The fourth syscall uses an unusual flag combination,
which is likely the reason this bug can be triggered.


  res =3D syscall(__NR_perf_event_open, /*attr=3D*/0x200000000000ul, /*pid=
=3D*/0,
                /*cpu=3D*/1ul, /*group=3D*/(intptr_t)-1,
                /*flags=3DPERF_FLAG_FD_CLOEXEC*/ 8ul);
  syscall(__NR_mmap, /*addr=3D*/0x200000002000ul, /*len=3D*/0x1000ul, /*pro=
t=3D*/0ul,
          /*flags=3DMAP_FIXED|MAP_SHARED*/ 0x11ul, /*fd=3D*/r[0], /*offset=
=3D*/0ul);

  res =3D syscall(__NR_perf_event_open, /*attr=3D*/0x200000000000ul, /*pid=
=3D*/0,
                /*cpu=3D*/1ul, /*group=3D*/r[0], /*flags=3DPERF_FLAG_FD_OUT=
PUT*/ 2ul);
  syscall(__NR_mmap, /*addr=3D*/0x200000186000ul, /*len=3D*/0x1000ul,
          /*prot=3DPROT_GROWSDOWN|PROT_SEM|PROT_WRITE|PROT_READ*/ 0x100000b=
ul,
          /*flags=3DMAP_SHARED_VALIDATE|MAP_FIXED*/ 0x13ul, /*fd=3D*/r[1],
          /*offset=3D*/0ul);


And that's what happened: r0 enters perf_mmap first. It acquires the mutex,
executes perf_mmap_rb, releases the mutex, and then calls map_range. If
map_range fails, the function enters perf_mmap_close, which drops the
refcount to 0 and finally releases the rb.

At an exact moment(after decreasing refcount but before releasing rb), r1 a=
lso
enters perf_mmap and attempts to attach to r0's ring buffer. Because the mu=
tex
is released, the second mmap can acquire the mutex and access the rb pointe=
r
which is shared with r0 before it is cleared, attempting to increment
the refcount
on a buffer that is already being destroyed.


> On Fri, Mar 6, 2026 at 1:37=E2=80=AFAM Haocheng Yu <yuhaocheng035@gmail.c=
om> wrote:
> >
> > That makes a lot of sense. It's indeed possible for a self deadlock to =
occur.
> >
> > I tried updating my patch by modifying `perf_mmap_close` to get a
> > `perf_mmap_close_locked`
> > function that handles the case where event->mutex is held from start.
> > But this approach
> > isn't very concise, and I'm not so sure if I changed the original
> > logic for some unexpected reasons.
> > Nevertheless, releasing the mutex before perf_mmap_close finishes
> > executing might cause the
> > original race condition issue again, which puts me in a dilemma.
> >
> > Do you have any suggestions?
>
> With the:
> ```
> +               if (ret)
> +                       perf_mmap_close_locked(vma);
> ```
> Wouldn't moving it outside the "scoped_guard(mutex,
> &event->mmap_mutex)" be a fix?
>
> Thanks,
> Ian
>
> > Thanks,
> > Haocheng
> >
> >
> >
> > > On Mon, Feb 2, 2026 at 8:30=E2=80=AFAM <yuhaocheng035@gmail.com> wrot=
e:
> > > >
> > > > From: Haocheng Yu <yuhaocheng035@gmail.com>
> > > >
> > > > Syzkaller reported a refcount_t: addition on 0; use-after-free warn=
ing
> > > > in perf_mmap.
> > > >
> > > > The issue is caused by a race condition between a failing mmap() se=
tup
> > > > and a concurrent mmap() on a dependent event (e.g., using output
> > > > redirection).
> > > >
> > > > In perf_mmap(), the ring_buffer (rb) is allocated and assigned to
> > > > event->rb with the mmap_mutex held. The mutex is then released to
> > > > perform map_range().
> > > >
> > > > If map_range() fails, perf_mmap_close() is called to clean up.
> > > > However, since the mutex was dropped, another thread attaching to
> > > > this event (via inherited events or output redirection) can acquire
> > > > the mutex, observe the valid event->rb pointer, and attempt to
> > > > increment its reference count. If the cleanup path has already
> > > > dropped the reference count to zero, this results in a
> > > > use-after-free or refcount saturation warning.
> > > >
> > > > Fix this by extending the scope of mmap_mutex to cover the
> > > > map_range() call. This ensures that the ring buffer initialization
> > > > and mapping (or cleanup on failure) happens atomically effectively,
> > > > preventing other threads from accessing a half-initialized or
> > > > dying ring buffer.
> > >
> > > As perf_mmap_close is now called inside the guarded region, is there
> > > potential for self deadlock?
> > >
> > > In perf_mmap it is now calling perf_mmap_close holding the event->mma=
p_mutex:
> > > ```
> > > scoped_guard (mutex, &event->mmap_mutex) {
> > > [...]
> > > ret =3D map_range(event->rb, vma);
> > > if (ret)
> > >   perf_mmap_close(vma);
> > > }
> > > ```
> > > and in perf_mmap_close the mutex will be taken again:
> > > ```
> > > static void perf_mmap_close(struct vm_area_struct *vma)
> > > {
> > > struct perf_event *event =3D vma->vm_file->private_data;
> > > [...]
> > > if (!refcount_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mut=
ex))
> > >   goto out_put;
> > > ```
> > >
> > > Thanks,
> > > Ian
> > >
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Closes: https://lore.kernel.org/oe-kbuild-all/202602020208.m7KIjdzW=
-lkp@intel.com/
> > > > Signed-off-by: Haocheng Yu <yuhaocheng035@gmail.com>
> > > > ---
> > > >  kernel/events/core.c | 38 +++++++++++++++++++-------------------
> > > >  1 file changed, 19 insertions(+), 19 deletions(-)
> > > >
> > > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > > index 2c35acc2722b..abefd1213582 100644
> > > > --- a/kernel/events/core.c
> > > > +++ b/kernel/events/core.c
> > > > @@ -7167,28 +7167,28 @@ static int perf_mmap(struct file *file, str=
uct vm_area_struct *vma)
> > > >                         ret =3D perf_mmap_aux(vma, event, nr_pages)=
;
> > > >                 if (ret)
> > > >                         return ret;
> > > > -       }
> > > >
> > > > -       /*
> > > > -        * Since pinned accounting is per vm we cannot allow fork()=
 to copy our
> > > > -        * vma.
> > > > -        */
> > > > -       vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP=
);
> > > > -       vma->vm_ops =3D &perf_mmap_vmops;
> > > > +               /*
> > > > +                * Since pinned accounting is per vm we cannot allo=
w fork() to copy our
> > > > +                * vma.
> > > > +                */
> > > > +               vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_=
DONTDUMP);
> > > > +               vma->vm_ops =3D &perf_mmap_vmops;
> > > >
> > > > -       mapped =3D get_mapped(event, event_mapped);
> > > > -       if (mapped)
> > > > -               mapped(event, vma->vm_mm);
> > > > +               mapped =3D get_mapped(event, event_mapped);
> > > > +               if (mapped)
> > > > +                       mapped(event, vma->vm_mm);
> > > >
> > > > -       /*
> > > > -        * Try to map it into the page table. On fail, invoke
> > > > -        * perf_mmap_close() to undo the above, as the callsite exp=
ects
> > > > -        * full cleanup in this case and therefore does not invoke
> > > > -        * vmops::close().
> > > > -        */
> > > > -       ret =3D map_range(event->rb, vma);
> > > > -       if (ret)
> > > > -               perf_mmap_close(vma);
> > > > +               /*
> > > > +                * Try to map it into the page table. On fail, invo=
ke
> > > > +                * perf_mmap_close() to undo the above, as the call=
site expects
> > > > +                * full cleanup in this case and therefore does not=
 invoke
> > > > +                * vmops::close().
> > > > +                */
> > > > +               ret =3D map_range(event->rb, vma);
> > > > +               if (ret)
> > > > +                       perf_mmap_close(vma);
> > > > +       }
> > > >
> > > >         return ret;
> > > >  }
> > > >
> > > > base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
> > > > --
> > > > 2.51.0
> > > >
> > > >
