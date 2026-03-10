Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F8E1E8342
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Mar 2026 04:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773117935; cv=pass; b=plefTcQ4T/1wCLXmuz41dJUbTUfZ7+f+4ETnLXh1ejHZcW8WzmaBMzOKCe0SEmn9P22OOJ9/3FHcks/WpsbiZT/C60u5+nKjmCGSWUHS4Xi7CYAn64xmnrZuQrCGeOtERm1DR1BS7C+C4LFYea4PL1t1JjNMtSP6UT3lK+vQbs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773117935; c=relaxed/simple;
	bh=/GsfuX1laZefcVFIGDEEd2Jxk9Gu7lVbbok9iu2yyH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9qjX1fUBtCRAsBJgggUqrTWKyY6f4EgWCojc0nKAJd1fodBppt2tcEBd5SpgkRo/XNELFAqGsJ1lwUfQZHoUoCdEySP/0M4GDN9whq6Fas89H/FQbfYGVVvXUsdhWHCgXyCiwG+dEWibSSUcwIsV2z2T9d4LnEFDEu+p2xBeL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KYao6Xxa; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KYao6Xxa"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2aea4ebb048so29615ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 21:45:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773117934; cv=none;
        d=google.com; s=arc-20240605;
        b=er94eZNrFyf93ULS8I3NoARU8nT28DSAMCT3G8BsqveuOd0k6ksJiqotDFHP3ct838
         6wBy/13N3DE6BOi0slrWSnhu7IQXHOl27yJpgEnT76NYolrlmIMFpIujXQrKhoIUj87t
         LKh7/yPGuPrXFYWB7ro9CsBJ1ChymRWPdJp+7WvQG5rd/AJ83SW6Zbp1BjzSyiXgdZjo
         m1i26P1lO4W1sOJxSVNWVXudNiabC9tCdO3E5aUnmZQZUMQG1pUVVhu+1FUdxZtwEIG8
         //L7gUCoBAyrxKkQY4TDjMIGQyvk3LQY2ogUTnB+iow1fp9zIujJ3pTy4061voMYKU4H
         HlJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hZavQgmoNN2kzn/Zz8JRSVxbJKQgGQB+0qA3Wca9Je8=;
        fh=ugiumfMHX+wYrUvTJrYOuHlqRZYSBreoloTARL3alMU=;
        b=LV5MeavTBHdunUprsQQRzGs1A6rcbeEcVJooiIQoIpVJ6FcLBN3t5QjdFYG2VJiKYO
         JZ375SR5GlZIsm43RaCrzmLDoAkbg3+ZUj+t7R222ZCHPJf/FwNf0avvCCNBI3h35IcD
         Fw/KubIK2IYkL6Ri7OvJfgoeKkxycN2W/eCqdS5tJxrc0siJU0f54Kerln7HlDKSdrpX
         4peNZYXmNnYk79cqhEBPHaBW41/UfgwQY+f5i1mpxczAvakStomWEZVdM7KwJt1/gQ8o
         QGwjODbHkxziMIx+B7p2mULeuNAPwntVz2LYterVljwmt/mW6k2vd31XqoEzdFLtGXQC
         f8xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773117934; x=1773722734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZavQgmoNN2kzn/Zz8JRSVxbJKQgGQB+0qA3Wca9Je8=;
        b=KYao6XxaG3WSTxiBOny2BHf/EHH8XFeL68dl8KOU7DzCqDndHRbdhCG/Mfj0QMlsnB
         xZzRh50zTNnJ+A5+jraK6euPku6bMRHtvuuW8Q8TEWlgGG0/PEKZGw5yY4le3OeKOtQY
         XOQn2w5buwp88LQ/ph07yMcRvSqg23hN+IuK80+5BiFcxDsy+s1VCilr7/xfZU2JiggL
         qheIMrU672EZXEe1oQ8NI8S/BRXZAnM4+OwTuV2PLSCXtLzzoF31B4Hr6FHH0NcToOBz
         C0Kre/Hf3fZP6RdF2YSzPafazcrHP+g3n19ghmKtp5S7O197ITcum5OnNvjjQryUc9pC
         47dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773117934; x=1773722734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hZavQgmoNN2kzn/Zz8JRSVxbJKQgGQB+0qA3Wca9Je8=;
        b=nrqDOf+Gr7eNDFpLjXrIw0nsIAIX8CfB/pGJEDyTN2Ka0OnZHs1IMgza0D9/lTusCl
         RY4dwBft46FnYzmg855yD05Y0y9mkkmZ1GbymnukTlMGcQnPLPYtEXtJO33JwhyAArHD
         ypFk4HKBpVM/Dj3jdr0SDzGro4ZR4X6qz2s0xPUL4lh56sG2BO5QiUYLZfF21LrrsvYF
         Njnv2SfN0v0sQlYNo/6II2QFnPQH8KF3Ij5p5oGv7Nl6t9Se6pq267VY/b59+c4PkoAN
         Vy6s+K2DBojSaL+CmO2LIP+9nh/QYAmt29HMmw4EyCTktZAXbhTy9IHpChjzGwnWR67T
         p4zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhALH9H28uJ3KgCbNmbFaUOUrO/VcbG2iXPprQnHuvZC+ZLAowZp3oP/GrSuhft5+vL0mGVzK9TQXGKaLylOgi@vger.kernel.org
X-Gm-Message-State: AOJu0YwJlsFh3aIs9rKcmB0dj+0d2YVnWo41g62MwHAsup2K/lPsnyH3
	v0c6g3jhmq24ccJcGWZG9G2QKV0tJAT/FU+chufBeYLCNultpSUn4Rhj4cSvUBT91CX7N6Is8BW
	dcSiudGoh18POb2pI6UYSXlX4pgIPe2UWNBDJbVT0
X-Gm-Gg: ATEYQzyMzPmckj5UEL53dXgfsmeqjOgQyQ5dGjnm4QZHQViNazwAT8MMbnxhD/l0yKv
	v7r6ozxKZdeekpJhVut14X5J90/qhxo9WbppGVipHOc8maeVGc3NtQaXiv68eZsY755iclTBo+3
	dQPEFQTXF9D6EsDNqdrpGddfzwPbxElRjWCEgB0Z7+FuAjwGfDP//lGjb4tZkVnGgB7YOM4KC4n
	BjggklLP+sLQgx95mMRVwa0jhUne20lD9j/JLXnBrOPnKKcM8Xk7TJIHh2XZsB51TUEOhNZLkTq
	9sO/BePVGbO/4zj/cC8=
X-Received: by 2002:a17:902:f650:b0:2ae:45cc:aeb6 with SMTP id
 d9443c01a7336-2aea3035ba1mr1912355ad.6.1773117933269; Mon, 09 Mar 2026
 21:45:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fW3jcUyOOF5ikEUHbp8r=yMZE=iUPVesUhcba38T8ayZA@mail.gmail.com>
 <20260310033742.3606390-1-wangqing7171@gmail.com>
In-Reply-To: <20260310033742.3606390-1-wangqing7171@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 21:45:21 -0700
X-Gm-Features: AaiRm53sli0RqcG4Zudl4EwMBJe-z3FT77b2GyJ-MTZu1cJrsOdonSSWauxtoMI
Message-ID: <CAP-5=fXMuLx0Wy3w246tybuFrntam_ZQ9AmWh8gv=+-fxrawVw@mail.gmail.com>
Subject: Re: [PATCH] perf: Fix deadlock in perf_mmap()
To: Qing Wang <wangqing7171@gmail.com>, yuhaocheng035@gmail.com
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org, 
	peterz@infradead.org, syzbot+196a82fd904572696b3c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 8:37=E2=80=AFPM Qing Wang <wangqing7171@gmail.com> w=
rote:
>
> On Tue, 10 Mar 2026 at 02:59, Ian Rogers <irogers@google.com> wrote:
> > Hi Qing, thank you for looking into this. I proposed a similar fix:
> > https://lore.kernel.org/lkml/CAP-5=3DfW-wHEv=3DTCULwk_HVOhWHdqRd8AZoESZ=
sU_vnhLjghUBQ@mail.gmail.com/
> > but Haocheng noted it reintroduced the race condition the original fix
> > was targeting. Haocheng has a larger fix in:
> > https://lore.kernel.org/lkml/20260306093616.84299-1-yuhaocheng035@gmail=
.com/
> > that should handle both the original race condition and the deadlock.
>
> Oh, this fix is too large.
>
> > I wonder that fix may be made smaller by passing a parameter like
> > "holds_event_mmap_mutex" to perf_mmap_close, something like:
> > ```
> > static void __perf_mmap_close(struct vm_area_struct *vma, struct
> > perf_event *event, bool holds_event_mmap_lock)
> > {
> >    ... // code from original perf_mmap_close
> >    if ((!holds_event_mmap_lock &&
> > !refcount_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
> > ||
> >        (holds_event_mmap_lock && !refcount_dec_and_test(&event->mmap_co=
unt)))
> >      ...
> >
> > static void perf_mmap_close(struct vm_area_struct *vma)
> > {
> >        struct perf_event *event =3D vma->vm_file->private_data;
> >        __perf_mmap_close(vma, event, /*holds_event_mmap_lock=3D*/false)=
;
> > }
> >
> > static void perf_mmap_close_locked(struct vm_area_struct *vma, struct
> > perf_event *event)
> > {
> >        __perf_mmap_close(vma, event, /*holds_event_mmap_lock=3D*/true);
> > }
> > ```
> >
> > Thanks,
> > Ian
>
> LGTM, your fix is better.
>
> But, can you explain why there is still race issue after applying my patc=
h?

Hi Qing,

Haocheng has a complex explanation here:
https://lore.kernel.org/lkml/CAAoXzSoYPvE-AdhT28Rhik2BtFhFuntaM6uhrMqKLUaDg=
kyiNg@mail.gmail.com/
with the original cause, which I think stemmed from syzkaller fuzzing.
I can follow the explanation there but I'm not familiar enough with
the ring buffer code to know whether the race with open is benign or
not. I'm guessing Peter Z thought not, hence the original patch
landed.

Thanks,
Ian

> Thanks,
> Qing
