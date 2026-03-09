Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDCB329391
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 19:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773082809; cv=pass; b=AtEmgXpteydFehggqX5O7TMHeapCVn8k2oAcn+fogpVGqHuaf6mc/kuSeoH3ufcRWPe/IyxisQJI1wm5XvxR6tzN9gVfF7v3UwWgnb7Sk7ZOEWmp2wwNWyQU1TowwCeHc6UR0a1lQWaPOKwr0Hh7doSDEFr8OdUFZlz+4YcgdAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773082809; c=relaxed/simple;
	bh=CA6S3On2vTP5a5E5aET5ntZ0ItXqO0wHfnxbUEuk+RE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DY34vuhZLmU4BPMYgb8p+6kqAhtUQyyFmmXGDA/jCeSr657kNuAq/r+a5Iv6QLrPAhTkVkK0vK3epHMqagDEd0HUYFtCoBgpinsyXIrc8dFs58bn+s073ypFvx6mn31m/QWEvyPx8OQVxktzK9y6XaKWVxzyAExsiT19wNAXMeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c75zsmgS; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c75zsmgS"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ae523d54d2so21365ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 12:00:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773082808; cv=none;
        d=google.com; s=arc-20240605;
        b=FoEU8F3plQb4QoNY5mgT1GnGKQYWKhYdqwioPoZuKmpKU8yECOdfnYu431h45mB01Z
         n2EFtuxuKvXWc3pvGBKqQirQ3o1uPgWCyCPgtGaBoYvCG+qUQ/D7OKo0dJN9iBBQOHPQ
         swMrI/hFwPeOiX3m5yYk0xD7U5zQRD07GeHIhJ0rtxKyyTQSrXnps+DnT9ARW7BfAzQK
         DfZ5lXW2e1P1A+rvhqej87wtiKFYnxLuKuh6TW6esckJcn/fs5R4ytH2hY9cgI/NkvcV
         IDhWpJZh6j5M5k0rxo44aWMRDQy8cz/nZs+GqGFclTTuy6RgCNEgCrVFxRyw+NEUjDKu
         exUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A69zc9BdB5IhC524YUAWFmjoBTZB9t4o4zitXpX63fc=;
        fh=JWIpOMLvwr34BqCSpZBDW07PZkBzBqRXwXYtmVDr0Kw=;
        b=RcFqPoDs8CnappmZEm3Dslk4ujYdGvbaOEGA3tP31VnH6xEZBPNjxbLR7K7IITJ+2s
         gtUCNlFh4qakRv6vrtmK5w+SRXgWE0jtE0bTtsuBiesvlGWywWl2VpA4/5IoQ+bbwkHJ
         dsZ2tTuin6ukYPL1IvpCK7G4uS5U4B6NjnqX+lGpsuKOjCa1CxguraaJU5lRKqE45KcB
         xGwDUAmKrPIHE+4CFRRpBVxpKFK719IsKiVnBq8A1as4qtK6MsXqBPHbqIVy1U7f5Qt9
         smpKc+2XoQ9yBKfIFfvnImB0Y8aZXx8AQrng6Sqo97XJRI1wJqWLgO5u88jGD+5h15iO
         AV1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773082808; x=1773687608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A69zc9BdB5IhC524YUAWFmjoBTZB9t4o4zitXpX63fc=;
        b=c75zsmgSuEs2nto+f0QGaIswwpJ25SkeIvHnOopAR8yjB76t68zrPHdvT9BS/a702+
         +nn0ExP8F2SOJMfXnhaIMpZPgVUHFtGEZc2Sgg4zrbHJxcRHseXfrmKzD8GpB6rN2og8
         YwOLrn+wyP8a4j4W0shbW9ktcGuo+4DkinwHfLNeochNjojx/GZGpOvfc62GBGG7xmtx
         sTZlt4el2UdESD7cXnJ5HDE+a5JJEhfjEBnlhK9fW6n8SGetK9DsNxsrcioY3fe2OpS0
         lAfpyi6UVyhrQVaS8v+wSz3j6HwyNq1CLzKCYgKaYQOzVoEHn//Ykezm9/pBdoTcQjkb
         831Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773082808; x=1773687608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A69zc9BdB5IhC524YUAWFmjoBTZB9t4o4zitXpX63fc=;
        b=e0/JfljWAooUqegeRs8FeqHhJNBwzbvi/RxoEwjo9mIlYz/N9JPxLLSKxsPMdhIkZn
         a2FcaHdNeorQ4lgXqe3HxSfMgrTTKMrJrlN6L/lNjz55iykkv8tAkstUrIURcvBixpfY
         c7Zyn4SNeev4VI5/ijm5G86aLXh7Y4Q4pum3SdsySh3xTJk43nUhjWB7gyJ9cQ+gB179
         eUeIXfa7NOU4lsrpzEVRqxouEId9LWtEvdHgImCp66KC8U+4/VsLruMYAPdSSHTgTL2Q
         uEbZRMDr8GIWN0Sm9be6ZyWXR54cETGhnS6ruYZxZGWucN/VqjlkcsjJuSXMad1+QTdM
         9r4g==
X-Forwarded-Encrypted: i=1; AJvYcCWpJ9w0QMQN0MspWgBk0yUA0kGKid2FYcQM8Em+hDqi5YLs705bcf52o92rEsqYxqgHXiJg2MMGgVtN46PnfiVH@vger.kernel.org
X-Gm-Message-State: AOJu0YyDyewVLkI8ssU3Ebaa/L1gbUYpIXw/ugosfnWO2cQZxRny9vsl
	zGcycoYFyQML2fwqYqTdJv4zbT1hRqAkv4VCXUxAGEmq6CI6V6850kMZPv/RmeR9JBj1smqC/n0
	v5db9/PGZPaO0DWeoft0KIjAqrDzTih2vWJbj5BmQ
X-Gm-Gg: ATEYQzzaLkuAdB6XDmIJ4lTFYRGVh4lRWtnAy1fJLHI7khtzmT8frQHNdgaOLTAOMdK
	pMltecQR60dxZVLpQoCjXWjGEqtisZXOlnLJgkd1huCU20YZArlR2grbHoHqlIWhS2HeWa/ZK3N
	6Oifu++OvuEdkSBepL5LLbeho1KOSleQczTJkf7QEZPw5JYFAI2Syi6nOi8y0zMoTtF/z9t4IFK
	WWHO7CJSrb4PiEL2vV1PwyjgkiQ80DdLMd4EnbHFFmI355zA9bSPKvd+pxudSXdyEAriK73vPb0
	qkP2KJ1DIFJ78nmW51FpaDE3Cm5RzfVKXzo=
X-Received: by 2002:a17:902:cccb:b0:2a7:4151:2c74 with SMTP id
 d9443c01a7336-2aea30cfb2dmr468065ad.16.1773082806886; Mon, 09 Mar 2026
 12:00:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309082548.3084264-1-wangqing7171@gmail.com>
In-Reply-To: <20260309082548.3084264-1-wangqing7171@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 11:59:55 -0700
X-Gm-Features: AaiRm519kDNzK9lKlbcsZ89g5eBroJB4EAWXUe13eNdTd-jVAPSHd81mv3FaRz4
Message-ID: <CAP-5=fW3jcUyOOF5ikEUHbp8r=yMZE=iUPVesUhcba38T8ayZA@mail.gmail.com>
Subject: Re: [PATCH] perf: Fix deadlock in perf_mmap()
To: Qing Wang <wangqing7171@gmail.com>, Haocheng Yu <yuhaocheng035@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+196a82fd904572696b3c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 1:26=E2=80=AFAM Qing Wang <wangqing7171@gmail.com> w=
rote:
>
> There is a possible deadlock in perf_mmap() if mmap_range() fails then
> perf_mmap_close() is called while holding event->mmap_mutex. Since
> perf_mmap_close() also acquire the same mutex, this result in self-deadlo=
ck.
>
> Fix this by moving the cleanup(perf_mmap_close()) outside the scope of
> scoped_guard(mutex, &event->mmap_mutex).
>
> Fixes: 77de62ad3de3 ("perf/core: Fix refcount bug and potential UAF in pe=
rf_mmap")
> Reported-by: syzbot+196a82fd904572696b3c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D196a82fd904572696b3c
> Signed-off-by: Qing Wang <wangqing7171@gmail.com>

Hi Qing, thank you for looking into this. I proposed a similar fix:
https://lore.kernel.org/lkml/CAP-5=3DfW-wHEv=3DTCULwk_HVOhWHdqRd8AZoESZsU_v=
nhLjghUBQ@mail.gmail.com/
but Haocheng noted it reintroduced the race condition the original fix
was targeting. Haocheng has a larger fix in:
https://lore.kernel.org/lkml/20260306093616.84299-1-yuhaocheng035@gmail.com=
/
that should handle both the original race condition and the deadlock.
I wonder that fix may be made smaller by passing a parameter like
"holds_event_mmap_mutex" to perf_mmap_close, something like:
```
static void __perf_mmap_close(struct vm_area_struct *vma, struct
perf_event *event, bool holds_event_mmap_lock)
{
   ... // code from original perf_mmap_close
   if ((!holds_event_mmap_lock &&
!refcount_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
||
       (holds_event_mmap_lock && !refcount_dec_and_test(&event->mmap_count)=
))
     ...

static void perf_mmap_close(struct vm_area_struct *vma)
{
       struct perf_event *event =3D vma->vm_file->private_data;
       __perf_mmap_close(vma, event, /*holds_event_mmap_lock=3D*/false);
}

static void perf_mmap_close_locked(struct vm_area_struct *vma, struct
perf_event *event)
{
       __perf_mmap_close(vma, event, /*holds_event_mmap_lock=3D*/true);
}
```

Thanks,
Ian

> ---
>  kernel/events/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 1f5699b339ec..e5ce03ce926d 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7485,9 +7485,12 @@ static int perf_mmap(struct file *file, struct vm_=
area_struct *vma)
>                  */
>                 ret =3D map_range(event->rb, vma);
>                 if (ret)
> -                       perf_mmap_close(vma);
> +                       goto out_close;
>         }
> +       return 0;
>
> +out_close:
> +       perf_mmap_close(vma);
>         return ret;
>  }
>
> --
> 2.34.1
>
