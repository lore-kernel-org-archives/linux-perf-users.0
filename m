Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B3B35F170
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Mar 2026 06:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.196
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774421932; cv=pass; b=DkWvEn+BVFwISprGhUEq3KArODYaBfet0Ikx0tTd7UcBxfSoU2SCCsR2wVdLxS5QIEY4YaJmEIA+A+ZfqtCq6pT4qsCHVr5ZNxdnSIS6lyO5xqB69GK+r0m2pVnA1V0sZ72I/yT9WIvmu2BNLUKEXj4gzOfE/f6ygUqeKEbGFqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774421932; c=relaxed/simple;
	bh=7B15doPJ8Rj4HKR23HYJSCQmVxOH9iwhf+pPSLy34FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZEEQ8wk38lB4spXVlTU9d1ID6+3M6JgbqzJQ30ALDYyaJpSeD6con36x+qd6LjoKLGEmHfgAG/ZM7CPsr0luCLFPLTwiS6SHU94x2QmoU0HZPVkkVSoa4NvLjA+/IpANubh4rHa18Ar7aUz2jGDE/Sgdlqvh4C2saZDDGiKHjtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OblsiEKk; arc=pass smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OblsiEKk"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8cfcb045909so597247485a.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Mar 2026 23:58:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774421930; cv=none;
        d=google.com; s=arc-20240605;
        b=gmUXDHgkls44rKrpQY3o+GQ06E4IOuMoZ3MESwYP5bURNtGHAyFPszNzNNIVMIgwng
         XdIEnsE/q2kpWEwK3ZUClSPVSnzRMqKlAVUMI6Nqo1CMVaJEwFSuIkxY3tlfDvxdn0Xl
         1a6txJwpnR20ILAKNtdlctqzOF/znl1yJ6MK/m0yndKB6godEiuWoQtnz9SUG35uo8Vy
         eT+wDaYe7hVed+jFGho476C1uR12Ljy7TXwx7bFYhxEwCpWt0VENjla2sD4cMFPzI6b5
         Meo6yhlelf103oLVMZWRoiKI/8n9ukBpehMag2jhsJRrh65bM9LFfS8oBmzT214JI/FP
         AeAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MD4iD3V/K52e27H+q7MbVF4NzgNqB/avv3+N1poeypQ=;
        fh=7h5OVXHQuCQlfX3cH7I/XRKrKWA+B08LC6MYdlwRhRk=;
        b=LkwiclmbomOYB6+Xs3lh3PDZOvnZZx7s3RqDfoVNIRJ9/Q+YMPfmFNhjCRAKQqIjPx
         2zxDmWeJAhN3HYWu74KLgqxmEDBQeTD5FjKz4q/xtF4j3JwmsoeWTdCbZ9nszuG91NDE
         GnbxPGtgwRSTHxv3BdS1cDkumtvNhQW7DluH4sE/Axlnkr5AfUY0XMjvC6NAM26S/ZEK
         1eQ4izZpk+IcD68gT6/GTRt6WwI2aUuRaHQDLdoEPV3UmnYq/495FJhmwTJTVtz/o8q7
         BWG2BV/mzY1XlEZEKJ51MJwSflEyy7GkzioROBVI3qK+vIlju13Fp1IgbETUTba27sNn
         5IRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774421930; x=1775026730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MD4iD3V/K52e27H+q7MbVF4NzgNqB/avv3+N1poeypQ=;
        b=OblsiEKkcT8VOifBXmgMLBcnbvt18yHLtoQctc27Lo+KCo1fDDRmd1Zqfc8KmOGyjk
         DPOS+u+aGOGuF2hMHYhg+whWrv9PgyIdwLWVeY+SzKx8O+vVMF9rF6OZ5xghNvTgdOHs
         v3xlTg8t/z+f8AqklPWvvYPUCz66Fn2bfnVcqJqnR46qx6oWlRzCYT5Y1TJJlsEi9mom
         vYM5dKQOdfZATBbWlX13DR58YhaXObUMkODtlfuDrq3RWBzMxXBaiOZNlwm5q7lhn5UT
         5uBa3v30Fp3hhdRdm1nwMQPQKuMSOcogZk3luBPmgQFl4f49JoY+RLjkB/gBWWqBUd03
         G0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774421930; x=1775026730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MD4iD3V/K52e27H+q7MbVF4NzgNqB/avv3+N1poeypQ=;
        b=sL+vCbEJ/ixP+UsYCFFQAyWL9nEt9DN/k934klZmTVNiclX/KHtTdG6y12KYTULOPQ
         oFMHFJBvvfpbyq3H7Ew5+V+vWq2AJYgmImSFDyuoiXpOqUVEhtjSKyfHLrC64fHFUBK1
         sUcVZ7QsT70N3kJ8FtCnx3UqYDKq+hEoyoVbui7rOXr75kcZA73nV+tSwL8Q+XuN3z3w
         AziO5OdGskV/6KW3Ot/JAufgh+LLY1++iSJFTiOWIcXopUxQD1OOd9KGElLcQa7YvOze
         0YA8LU72k2bO7wKrCPS9Q6s1lF5qFzGcyrL59M4KTiNB5058491rzkRBa9y9YtUbFJMI
         0lpA==
X-Forwarded-Encrypted: i=1; AJvYcCWUIwf+mkutnPC1rqX9mYhjQlOKXg/pJ0y507N4MzMZ4GQMPy4hFK6rBsvU6toal0HT9l+aWa7yKWxcao0Fbluo@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7UpFtYe557Jk9PDk8dzuDUxYe0H0tJM/SLZpQqIN9R/NXFhAP
	rxyf+U7Gf2N8WXPfAWczEEcjKlFR9cbO7puilxSCFoCOm0CEip9pln48U+2/ZW+3XgxbdxQx5ZZ
	0QINaC56mDkf7U+/ZFQfT2746ZHoWMsQ=
X-Gm-Gg: ATEYQzyVSj3X87PZv4ZXEhS9JmqnYpjoo0Pk5glyBKGaDpq0DPLwwxg8tAw52OwZIdb
	9kffzNSoJczrCDIRnbA9EOhGMjLue0nV2+qlpLVgQE8rx70cOUQNll87sMVZF9BS7w7FW/XEr+V
	y754x5GgZkinR7x6lXZmOf8z5ufA1izcitkEgMIWG1bWsshHdmVIuASZQX8eaK/vevewcUohgHC
	jbIM+kvVb3UdwEKYpprcrnv8tJELzNguTVPAw26DIy0tLb8fv1UUVG2kyzh4bqW6o/wzCwtxuUH
	FZDZXw==
X-Received: by 2002:a05:620a:4450:b0:8cf:d510:3b43 with SMTP id
 af79cd13be357-8d0010402f0mr330415385a.44.1774421929826; Tue, 24 Mar 2026
 23:58:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fW3jcUyOOF5ikEUHbp8r=yMZE=iUPVesUhcba38T8ayZA@mail.gmail.com>
 <20260310033742.3606390-1-wangqing7171@gmail.com> <CAP-5=fXMuLx0Wy3w246tybuFrntam_ZQ9AmWh8gv=+-fxrawVw@mail.gmail.com>
 <CAP-5=fUJxmOLMW_TkZcpqT+bzicCd2kKnftCYwP23RdCACWR5Q@mail.gmail.com>
In-Reply-To: <CAP-5=fUJxmOLMW_TkZcpqT+bzicCd2kKnftCYwP23RdCACWR5Q@mail.gmail.com>
From: Haocheng Yu <yuhaocheng035@gmail.com>
Date: Wed, 25 Mar 2026 14:58:33 +0800
X-Gm-Features: AaiRm52JZBmSLx0IpSLePwC0KuH1tIAYpoftWuyttFpn68vlXwbeK6MM3hMrhHw
Message-ID: <CAAoXzSrdEjHtLYqHJDT8bm_gDAY=C1VdeU=0NbjJ0hhpOo5V9w@mail.gmail.com>
Subject: Re: [PATCH] perf: Fix deadlock in perf_mmap()
To: Ian Rogers <irogers@google.com>
Cc: Qing Wang <wangqing7171@gmail.com>, peterz@infradead.org, acme@kernel.org, 
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, syzbot+196a82fd904572696b3c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I apologize for the previous misunderstanding=E2=80=94I assumed you
would submit a separate patch, since you came up with the whole
idea. Thus I didn't update my patch. Your solution is indeed better.
I'd be happy to incorporate your feedback into my fix if you wish.

Thanks,
Haocheng

Ian Rogers <irogers@google.com> =E4=BA=8E2026=E5=B9=B43=E6=9C=8825=E6=97=A5=
=E5=91=A8=E4=B8=89 02:38=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Mar 9, 2026 at 9:45=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > On Mon, Mar 9, 2026 at 8:37=E2=80=AFPM Qing Wang <wangqing7171@gmail.co=
m> wrote:
> > >
> > > On Tue, 10 Mar 2026 at 02:59, Ian Rogers <irogers@google.com> wrote:
> > > > Hi Qing, thank you for looking into this. I proposed a similar fix:
> > > > https://lore.kernel.org/lkml/CAP-5=3DfW-wHEv=3DTCULwk_HVOhWHdqRd8AZ=
oESZsU_vnhLjghUBQ@mail.gmail.com/
> > > > but Haocheng noted it reintroduced the race condition the original =
fix
> > > > was targeting. Haocheng has a larger fix in:
> > > > https://lore.kernel.org/lkml/20260306093616.84299-1-yuhaocheng035@g=
mail.com/
> > > > that should handle both the original race condition and the deadloc=
k.
> > >
> > > Oh, this fix is too large.
> > >
> > > > I wonder that fix may be made smaller by passing a parameter like
> > > > "holds_event_mmap_mutex" to perf_mmap_close, something like:
> > > > ```
> > > > static void __perf_mmap_close(struct vm_area_struct *vma, struct
> > > > perf_event *event, bool holds_event_mmap_lock)
> > > > {
> > > >    ... // code from original perf_mmap_close
> > > >    if ((!holds_event_mmap_lock &&
> > > > !refcount_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex=
))
> > > > ||
> > > >        (holds_event_mmap_lock && !refcount_dec_and_test(&event->mma=
p_count)))
> > > >      ...
> > > >
> > > > static void perf_mmap_close(struct vm_area_struct *vma)
> > > > {
> > > >        struct perf_event *event =3D vma->vm_file->private_data;
> > > >        __perf_mmap_close(vma, event, /*holds_event_mmap_lock=3D*/fa=
lse);
> > > > }
> > > >
> > > > static void perf_mmap_close_locked(struct vm_area_struct *vma, stru=
ct
> > > > perf_event *event)
> > > > {
> > > >        __perf_mmap_close(vma, event, /*holds_event_mmap_lock=3D*/tr=
ue);
> > > > }
> > > > ```
> > > >
> > > > Thanks,
> > > > Ian
> > >
> > > LGTM, your fix is better.
> > >
> > > But, can you explain why there is still race issue after applying my =
patch?
> >
> > Hi Qing,
> >
> > Haocheng has a complex explanation here:
> > https://lore.kernel.org/lkml/CAAoXzSoYPvE-AdhT28Rhik2BtFhFuntaM6uhrMqKL=
UaDgkyiNg@mail.gmail.com/
> > with the original cause, which I think stemmed from syzkaller fuzzing.
> > I can follow the explanation there but I'm not familiar enough with
> > the ring buffer code to know whether the race with open is benign or
> > not. I'm guessing Peter Z thought not, hence the original patch
> > landed.
>
> I think no fix has landed yet and the original patch with the issue
> has appeared in backports. Haocheng, did you want to see if you could
> incorporate my feedback into your fix?
>
> Thanks,
> Ian
>
> > Thanks,
> > Ian
> >
> > > Thanks,
> > > Qing
