Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035DC37E31D
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770650809; cv=pass; b=f7/xVojDaict9tn2O80VwJK7akMf+mUEjMiRaH4K/aNBYVcwvEoXzgnDJ0DIKb9jhMJCvL8uWUpmXANJf468SzeFSVz+l9eA+D3bmWyX72VPdXtijd1G7z0wAmoSiMarC+GqI/t1hkdKVuKi/gFP2pRx1TXMXPKvy3m/aoskMdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770650809; c=relaxed/simple;
	bh=1M8Yj0ggbc/zEdWFgbC5pAXxIcdHkWoiJXYmdae/H2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wm54wFuYAf5e7t72ClU+wOad6sckjT0oXQyf04iBEBb7PnGdmBqik5bxlC2maAt33rKjeMKT8DZvLl1YF1FNpWRp3r2NBcp+ci6Vc8G6Hfm2k9Gu9pYxB6O3xlS+akP19TpUeeNxp47B5eAtJoEPJ6MtvcKgesbm8MzRXtNrQXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RI0UnuoQ; arc=pass smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RI0UnuoQ"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-895071c5527so41507186d6.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 07:26:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770650808; cv=none;
        d=google.com; s=arc-20240605;
        b=hNCS9sEjnsqJ5UDOFF4dDHXYsz0dRcGKlF7tEk3gKkl1FMrjTF/vRVjrLRwn04DrA0
         KUwd1ofTfWq7mTubfX2TYOd19KWJ6oqqgH9L/yH6LkkALqbuSxQ7tkBGsbxJMSO/cSTF
         1GfPkPHnCogFCT19OPw+ppyovUK6gwdBaN/7X3yWqVhghTX3hB2SL8PTDdFwAYuEXiUC
         0WiXnRlwrVz/2loB6iFAk5DK1+YO0fl5lT7AamG1ATfarIWb2tz17WXFD7A1mHenFjLk
         SpvL1hsjCygjFcRbenQoV0BGBCgJXTZluG9aLVy1H3GhSQ06EQRSCnnOfpAVgjARlyk1
         +tGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3HRXbBS0V93wU8l68FG/VNkXyhD52d0ryxA2MFe4s4I=;
        fh=1dthiytqHwu1DqsmifW1nMNGdyXihDxLaq6ragHz76w=;
        b=ZDanmgAbhYhGQHl9OJzgdqoY5/mwYsxIREkaZV7pdTNxcKzmyR+UmOL66QX7PgmMws
         JftFP29Amsi0sk/yKDwQN3nWnkO9GDFHUk97frKlTRM0OUUND8kDROnhzi3goYI/s6a1
         T1mtc+ABmD084khAddgv8mqWiuhiXIl4gjumyF88JvjfRkq6+i1c2X7IHSGm1xlrNxIB
         EZgR6U05/3CYL9KUgnNlqysRyxn2BE2Lg2wN/nPmVVlXhdU4tFkUNEhfU7cRam+pGwAH
         bushwMUivK2iN/lr+ck5MChDjrLEc2+3hMu2LI/ButECuceyfpt44uDq3TpmrMcyiMzT
         1wbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770650808; x=1771255608; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3HRXbBS0V93wU8l68FG/VNkXyhD52d0ryxA2MFe4s4I=;
        b=RI0UnuoQKnbGOpA+gTlBunXI4E9ymsOQt/cYduqvk3Un4ch11ozQFjybhQ8NjzsMpX
         XXM4Z4rzdDE66coK+r1/lt3W7Ier+jn9EQIupZj2caFFbpULKH1a+t0p3lRPJFjUFSKo
         g+0qzb06vImKAJpOuXG6Q8xWOHV8alMBArrUkV7pVaVvMYRtxJA9gTGCx19LzBwXIny1
         ThWNJ4Bm19muYyMEitOObc3V5pgyGrJ9lgHMOa3PVFEkG8572Vs5QrNTWSc/ownboXjD
         6pvC8CBdM8mDbuHeRluNa2GecUg6zqKjTIjgcoYuQOnqUhjd4pkdUPf/VyQVc1eKrK4v
         TL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770650808; x=1771255608;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HRXbBS0V93wU8l68FG/VNkXyhD52d0ryxA2MFe4s4I=;
        b=IIrg89pBYiug1l6Z70HcEg7W9zn4Bi+tevUw6PQYi+Smat8VqjiGAPYmYncB5B7V+h
         cW1QxPA0Np42NSOU309lpcEC3HoHOR0m5fKJlRawJIqyJshkTtd8qkQ/Jss93iXef+HF
         vGtmH8ldDFny3aiQUrie//J2D/oa1HaHSrixzYKZeK332ugDhQ/d9vs0/APka0iXNk5a
         qFm2Ckuyh7PKEk2n4lH9rno/eJ3OOKlElh/uz1LDzZL9+PmXxWwbMHRXabp8YNwslo9T
         H8p3sKUDK81PszNlgn9XcNO2guo0JaajCXAL/X9PRxWZbfeNFFT+7FQzwCLXahg/n2rU
         h3BA==
X-Forwarded-Encrypted: i=1; AJvYcCW4hoGQYP8Pk1AAIkzae+JHVOg1T8jU5FxEDu1Lyw3k/y+BhB9L0XoSN6ioXaxnLHxQwIrHAa8UEJZEWtc7T0Ka@vger.kernel.org
X-Gm-Message-State: AOJu0YysHN2VyOHSc7upwgFpLXBcodxlpncDOT0hNe598qqelJXBC2yg
	u7fTNdGu2f5G4MHyeLScWYHgYjvwRh2PN0O3RoiBDaKKU9LZVNG1cGFd41GcRo0AuiKXzpNXTqZ
	YQd/xLXBHDQ9e0gmAc/3G7b63FYTFMoY1rFRiUpE0Nw==
X-Gm-Gg: AZuq6aK4ivpBJZXpp26ZGpMgd+UjWpKLKiEiMSoefAMJ7ld2TFu2XE5zMzojTj/Dp1m
	bwdVj1ysN44lGATUVXvug35HnyiSqzyFyIenZew54UjMEwUARP+NxAAmNAVtX1tSNpeicaMgO/9
	leMat6AROyV3okpJmf7sMAa0OHxkz6nMsNSzelUuHlFqB74jeVmihQScS6sXiT+FepJ9342dbYA
	PIGx7qLoz/MDFiumhxgjiWSJBbGxep0DgluBP0FXa+26+zTnqPs6bVTKjjhxWFHjoXJfGpm
X-Received: by 2002:a05:6214:2524:b0:87c:2900:1f97 with SMTP id
 6a1803df08f44-8953ca703e2mr183041026d6.44.1770650807820; Mon, 09 Feb 2026
 07:26:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAoXzSqHuQd7k9rp878YBG5gbChgOaProPQ6XBzKpy81JF5sKg@mail.gmail.com>
 <20260202162057.7237-1-yuhaocheng035@gmail.com> <20260206090624.GQ1282955@noisy.programming.kicks-ass.net>
In-Reply-To: <20260206090624.GQ1282955@noisy.programming.kicks-ass.net>
From: =?UTF-8?B?5L2Z5piK6ZOW?= <yuhaocheng035@gmail.com>
Date: Mon, 9 Feb 2026 23:26:36 +0800
X-Gm-Features: AZwV_Qig9_5_PggJbPdwCYcsFuzzcHJnF_Bhohzoe2pABFVx49jdiD_ds-3wT3o
Message-ID: <CAAoXzSpxpOswM7TAZu5QZ+JdyL2V4SOehF_Kg3N9p29C5JZD4A@mail.gmail.com>
Subject: Re: [PATCH v2] perf/core: Fix refcount bug and potential UAF in perf_mmap
To: Peter Zijlstra <peterz@infradead.org>
Cc: acme@kernel.org, security@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

These explanations and patches were indeed generated by LLM, but
I considered and reviewed them before sending the email, along with
the kernel code and the C reproducer, and modified anything I deemed
unreasonable. I believe this patch is meaningful, and there are indeed
some issues with the kernel code, and that's why I send it out.

Below is my own thinking:

In the C reproducer, these four system calls are the core to this problem.
Specifically, the third syscall takes r0 as an argument(group), establishing
a shared ring buffer. The fourth syscall uses an unusual flag combination,
which is likely the reason this bug can be triggered.


  res = syscall(__NR_perf_event_open, /*attr=*/0x200000000000ul, /*pid=*/0,
                /*cpu=*/1ul, /*group=*/(intptr_t)-1,
                /*flags=PERF_FLAG_FD_CLOEXEC*/ 8ul);
  syscall(__NR_mmap, /*addr=*/0x200000002000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=MAP_FIXED|MAP_SHARED*/ 0x11ul, /*fd=*/r[0], /*offset=*/0ul);

  res = syscall(__NR_perf_event_open, /*attr=*/0x200000000000ul, /*pid=*/0,
                /*cpu=*/1ul, /*group=*/r[0], /*flags=PERF_FLAG_FD_OUTPUT*/ 2ul);
  syscall(__NR_mmap, /*addr=*/0x200000186000ul, /*len=*/0x1000ul,
          /*prot=PROT_GROWSDOWN|PROT_SEM|PROT_WRITE|PROT_READ*/ 0x100000bul,
          /*flags=MAP_SHARED_VALIDATE|MAP_FIXED*/ 0x13ul, /*fd=*/r[1],
          /*offset=*/0ul);


The sequence is as follows: r0 enters perf_mmap first. It acquires the mutex,
executes perf_mmap_rb, releases the mutex, and then calls map_range. If
map_range fails, the function enters perf_mmap_close, which calls
ring_buffer_put and drops the refcount to 0.

At this moment, r1 also enters perf_mmap and attempts to attach to r0's ring
buffer. Because the mutex is released during the r0's execution of map_range,
the second mmap can acquire the mutex and access the rb pointer which is
shared with r0 before it is cleared, attempting to increment the refcount on a
buffer that is already being destroyed.

So I think simply extend the scope of mutex to let it cover perf_mmap_close
could solve this problem.

> On Tue, Feb 03, 2026 at 12:20:56AM +0800, yuhaocheng035@gmail.com wrote:
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
> And you're sure this time? To me it feels bit like talking to an LLM.
>
> I suppose there is nothing wrong with having an LLM process syzkaller
> output and even have it propose patches, but before you send it out an
> actual human should get involved and apply critical thinking skills.
>
> Just throwing stuff at a maintainer and hoping he does the thinking for
> you is not appreciated.
>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202602020208.m7KIjdzW-lkp@intel.com/
> > Signed-off-by: Haocheng Yu <yuhaocheng035@gmail.com>
> > ---
> >  kernel/events/core.c | 38 +++++++++++++++++++-------------------
> >  1 file changed, 19 insertions(+), 19 deletions(-)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 2c35acc2722b..abefd1213582 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -7167,28 +7167,28 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
> >                       ret = perf_mmap_aux(vma, event, nr_pages);
> >               if (ret)
> >                       return ret;
> > -     }
> >
> > -     /*
> > -      * Since pinned accounting is per vm we cannot allow fork() to copy our
> > -      * vma.
> > -      */
> > -     vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
> > -     vma->vm_ops = &perf_mmap_vmops;
> > +             /*
> > +              * Since pinned accounting is per vm we cannot allow fork() to copy our
> > +              * vma.
> > +              */
> > +             vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
> > +             vma->vm_ops = &perf_mmap_vmops;
> >
> > -     mapped = get_mapped(event, event_mapped);
> > -     if (mapped)
> > -             mapped(event, vma->vm_mm);
> > +             mapped = get_mapped(event, event_mapped);
> > +             if (mapped)
> > +                     mapped(event, vma->vm_mm);
> >
> > -     /*
> > -      * Try to map it into the page table. On fail, invoke
> > -      * perf_mmap_close() to undo the above, as the callsite expects
> > -      * full cleanup in this case and therefore does not invoke
> > -      * vmops::close().
> > -      */
> > -     ret = map_range(event->rb, vma);
> > -     if (ret)
> > -             perf_mmap_close(vma);
> > +             /*
> > +              * Try to map it into the page table. On fail, invoke
> > +              * perf_mmap_close() to undo the above, as the callsite expects
> > +              * full cleanup in this case and therefore does not invoke
> > +              * vmops::close().
> > +              */
> > +             ret = map_range(event->rb, vma);
> > +             if (ret)
> > +                     perf_mmap_close(vma);
> > +     }
> >
> >       return ret;
> >  }
> >
> > base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
> > --
> > 2.51.0
> >
