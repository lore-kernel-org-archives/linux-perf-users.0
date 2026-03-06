Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36506345CD9
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Mar 2026 09:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.196
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772789822; cv=pass; b=Q6ShkhSVSbMqE/WcnKq872CTsnNVEJPdP+h2yKWqntYbXjNZfgZ7H8R6oF9nub8j37KH7p/4HPDGhxYtaTVzq9Gkh84+SxST4JerJWy3vJpYb3re5VwhahDlcQlXCTQBhT9PXbLcCWBuiR9ffEHkprwOIvT+1Wru6w/sZJZpiN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772789822; c=relaxed/simple;
	bh=MhMD2r4jbzZnqIw5b3r73Pq8rwmLoyBYJfEHCXzHmSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIbARQBBR1IPxBbiovv0zMeL/2pzJ2zjLpdCvXuCaiXyxJ/GZJWcc8tm0UfLiaJ29O4pRLFYWiTiOsPCxF7VDS8QUy0/AX9o1SeQYiB65JTrOrJCODt0zPTFx45mnJhVNuMcCKTu8hgdHPpY3+gqVjY1UunFIfE5k3Jpg0mY14U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drSlYOvx; arc=pass smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drSlYOvx"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8cb38e6d164so1169666385a.3
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Mar 2026 01:37:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772789820; cv=none;
        d=google.com; s=arc-20240605;
        b=N1f2076CEmFROvkRVGSmrLWfBdCiZSuXTWCfJs/KhilHWTT5kMyMBFg8Znb7QV6CsC
         2QD15y21608x/d3trR5PGQHFMDSGgUsrMxBcxB8DkqwjE1/iwrpQWtI12KbEZs9XDNY2
         M3y2hrc+NMWe6u433BdLjjDrhudZICCO02NLLx9ami0QGwoBQurdv2jBp3+ltVHbsKsr
         D8E3WMkB+0/umFKLFY4lZpOMFMfOvzjYTOTXt7jtLkMoLCH/9qCM111OOcVPryy72F/V
         AreV45D42vCn4ShBUHLMbZNYjnsyyyByNRXqV/DJkZq3AlnRj5ThieSffOXYEFd5yB0f
         sNmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TRyrVPJGmUUvHLs4PwvSElFvEk7VSlAjdzyWvqfTSr8=;
        fh=LtVs+kIQeKjdc6gRnRfjexjXog2N1w+XSH2/xtdfCwE=;
        b=a/ZdsluG5zlmpbXVM/+uNRbXHmeEoS4QFIXSdzsiWEFfaclIis1QBVDMddZLYxVrZF
         rXner73eljGpiUxu9hGTmQln3DL4URCdwYgrEqCUGSXcAs4Do4qNUnAaBWE7LCNtxhpC
         sHnRFoOhuNYKug298r/O1BfLMadhkZWtYQrWfGcb/HOfj4BaNyI9J4Y+5Gao5y8syWEO
         xNz4qwaVP5oG4w2zFqO8Kg+AjS3ZR+lmUiUTjt5XuCjOlR/N6rMK8aaGnMHg/6SBo1Kv
         vhrhtgSX4/aQI0HYVzKgjphFibaaqG8y6vumwhvzpa6dACdiYeuRS1d5cpkUsxmcRvb4
         P/jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772789820; x=1773394620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRyrVPJGmUUvHLs4PwvSElFvEk7VSlAjdzyWvqfTSr8=;
        b=drSlYOvxifM1C5sVFB65zM85VqWHL4VnSgGwR+lkLItWjw7rv2LN7MaauREU/ahhWr
         XasBiBmNmIQXNVPQG/0SDDMhWzdmeS+1yNAZupflWFpGoGexRAx7kIF57T8ffwKRP3wI
         OFTqlDio+0JmYrd4hzQIcaMtDxATbkofKau6ChAVscv/tRDh4AihUcnd0eOtj0vePDyJ
         aIILL7DOyyiyM9xqdYOim1xgVToGdAqJ2S/K5vFEOzLWDoob/gm60Kz3O9rquUYxmqhq
         c/kAH8hCULjs9THdOZOPpvYb96N68ip7nbCUEt+1BjdQRYnP4MvYhM17BCB7/2TprPnT
         Io3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772789820; x=1773394620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TRyrVPJGmUUvHLs4PwvSElFvEk7VSlAjdzyWvqfTSr8=;
        b=c4DeZrzxxuoP6zP6nrXRVEtsMvp7oHhNgoT7DCttCUyuw6OAuSLxsSLMcMGGuPHVP6
         8sv+4fXz0L2Dn+EgUC+dTpdUNE9ZqPvn15I7iBOb52mwo0PBjwEnFf820uOmT5e+JLTk
         Xs4InNA6g3qtWaQjannIxiTPS5+fpNioezmdEobSb6u70envF9ZkWpqJOxRzYyioyVJA
         wXiePhViq3tnPkzapdqvPgzDZYe9NmfS2Rdmrta00hDh9TCiSfm7C1k+CZAjeKZtKfVF
         tohkaob8/YXr/hMCu/igazWGqRsdgvtclvxkykWLff/9gGwNIYHfsGFTIaCe3dIxeeM9
         iPag==
X-Forwarded-Encrypted: i=1; AJvYcCX8eXEEpDaJMLG36c8g41v7YHs135MPMiGmOzivTLr5OY9Dj0UWNDv6LvMkvzhpSLTcTE0dLqimE4tRq3IGR4tQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwDMNwbn2F9gHzBu/JCbT02rVBaVQdj+lbhdtU59dILH0lLno0i
	zff+FQKoGmeiiB/Lp0DDX+itWnySPLFST2r+gqiFWmgd/LpBG0QzBSL4Hk6AtjjcSORkL18Wev/
	dCsmEcmicf2kr0ZrllCmwBda0lWNyaFI=
X-Gm-Gg: ATEYQzwY8VX6gWxIdeJT6s+fZmpNZQRlB77ajVYjzAnWO4S5gmB0WiCkOn5Oj70ZUzA
	feVAEQbUcM1edX2PJsE7K+bBwXtAu2kzX3l0/FNEGcz9/IAs13EN1+J2Lme7Zp3ZsGCcs4+vKst
	PCW46nKtpynLWGpxdk2QpWs0Rc4IE3GE7S49iU4cdCIRZojgd59bv3aFQ0ndUFdFYx1fKlys816
	+JttUfomgpURMDsW9JbEHkRd+g3SGX/mI3UL2V4ZuQ8Tse59QaqV13Pu8Q+gzhebopidxTRWNex
	C6ia
X-Received: by 2002:a05:620a:45a3:b0:8ca:ffe3:33a3 with SMTP id
 af79cd13be357-8cd6d2838camr185206385a.0.1772789819994; Fri, 06 Mar 2026
 01:36:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAoXzSqHuQd7k9rp878YBG5gbChgOaProPQ6XBzKpy81JF5sKg@mail.gmail.com>
 <20260202162057.7237-1-yuhaocheng035@gmail.com> <CAP-5=fVJyVMZw=DqP53Kxg58nUmJ_0bxoaeOKAbC03BVc11HaA@mail.gmail.com>
In-Reply-To: <CAP-5=fVJyVMZw=DqP53Kxg58nUmJ_0bxoaeOKAbC03BVc11HaA@mail.gmail.com>
From: Haocheng Yu <yuhaocheng035@gmail.com>
Date: Fri, 6 Mar 2026 17:36:49 +0800
X-Gm-Features: AaiRm53FM4KI7SbUkhLHGXVeh9Xvtm8rF8S1XObRyikOG9V8Cqd4WYPMRljgpOA
Message-ID: <CAAoXzSqLGqBG+n-rLCssz7MZSRLvLvRv6Rivtfg_OCyLPWoxCQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf/core: Fix refcount bug and potential UAF in perf_mmap
To: Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, acme@kernel.org, security@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That makes a lot of sense. It's indeed possible for a self deadlock to occu=
r.

I tried updating my patch by modifying `perf_mmap_close` to get a
`perf_mmap_close_locked`
function that handles the case where event->mutex is held from start.
But this approach
isn't very concise, and I'm not so sure if I changed the original
logic for some unexpected reasons.
Nevertheless, releasing the mutex before perf_mmap_close finishes
executing might cause the
original race condition issue again, which puts me in a dilemma.

Do you have any suggestions?

Thanks,
Haocheng



> On Mon, Feb 2, 2026 at 8:30=E2=80=AFAM <yuhaocheng035@gmail.com> wrote:
> >
> > From: Haocheng Yu <yuhaocheng035@gmail.com>
> >
> > Syzkaller reported a refcount_t: addition on 0; use-after-free warning
> > in perf_mmap.
> >
> > The issue is caused by a race condition between a failing mmap() setup
> > and a concurrent mmap() on a dependent event (e.g., using output
> > redirection).
> >
> > In perf_mmap(), the ring_buffer (rb) is allocated and assigned to
> > event->rb with the mmap_mutex held. The mutex is then released to
> > perform map_range().
> >
> > If map_range() fails, perf_mmap_close() is called to clean up.
> > However, since the mutex was dropped, another thread attaching to
> > this event (via inherited events or output redirection) can acquire
> > the mutex, observe the valid event->rb pointer, and attempt to
> > increment its reference count. If the cleanup path has already
> > dropped the reference count to zero, this results in a
> > use-after-free or refcount saturation warning.
> >
> > Fix this by extending the scope of mmap_mutex to cover the
> > map_range() call. This ensures that the ring buffer initialization
> > and mapping (or cleanup on failure) happens atomically effectively,
> > preventing other threads from accessing a half-initialized or
> > dying ring buffer.
>
> As perf_mmap_close is now called inside the guarded region, is there
> potential for self deadlock?
>
> In perf_mmap it is now calling perf_mmap_close holding the event->mmap_mu=
tex:
> ```
> scoped_guard (mutex, &event->mmap_mutex) {
> [...]
> ret =3D map_range(event->rb, vma);
> if (ret)
>   perf_mmap_close(vma);
> }
> ```
> and in perf_mmap_close the mutex will be taken again:
> ```
> static void perf_mmap_close(struct vm_area_struct *vma)
> {
> struct perf_event *event =3D vma->vm_file->private_data;
> [...]
> if (!refcount_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
>   goto out_put;
> ```
>
> Thanks,
> Ian
>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202602020208.m7KIjdzW-lkp=
@intel.com/
> > Signed-off-by: Haocheng Yu <yuhaocheng035@gmail.com>
> > ---
> >  kernel/events/core.c | 38 +++++++++++++++++++-------------------
> >  1 file changed, 19 insertions(+), 19 deletions(-)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 2c35acc2722b..abefd1213582 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -7167,28 +7167,28 @@ static int perf_mmap(struct file *file, struct =
vm_area_struct *vma)
> >                         ret =3D perf_mmap_aux(vma, event, nr_pages);
> >                 if (ret)
> >                         return ret;
> > -       }
> >
> > -       /*
> > -        * Since pinned accounting is per vm we cannot allow fork() to =
copy our
> > -        * vma.
> > -        */
> > -       vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
> > -       vma->vm_ops =3D &perf_mmap_vmops;
> > +               /*
> > +                * Since pinned accounting is per vm we cannot allow fo=
rk() to copy our
> > +                * vma.
> > +                */
> > +               vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONT=
DUMP);
> > +               vma->vm_ops =3D &perf_mmap_vmops;
> >
> > -       mapped =3D get_mapped(event, event_mapped);
> > -       if (mapped)
> > -               mapped(event, vma->vm_mm);
> > +               mapped =3D get_mapped(event, event_mapped);
> > +               if (mapped)
> > +                       mapped(event, vma->vm_mm);
> >
> > -       /*
> > -        * Try to map it into the page table. On fail, invoke
> > -        * perf_mmap_close() to undo the above, as the callsite expects
> > -        * full cleanup in this case and therefore does not invoke
> > -        * vmops::close().
> > -        */
> > -       ret =3D map_range(event->rb, vma);
> > -       if (ret)
> > -               perf_mmap_close(vma);
> > +               /*
> > +                * Try to map it into the page table. On fail, invoke
> > +                * perf_mmap_close() to undo the above, as the callsite=
 expects
> > +                * full cleanup in this case and therefore does not inv=
oke
> > +                * vmops::close().
> > +                */
> > +               ret =3D map_range(event->rb, vma);
> > +               if (ret)
> > +                       perf_mmap_close(vma);
> > +       }
> >
> >         return ret;
> >  }
> >
> > base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
> > --
> > 2.51.0
> >
> >
