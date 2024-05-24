Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FD98493
	for <linux-perf-users@vger.kernel.org>; Fri, 24 May 2024 20:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716581884; cv=none; b=U3OhxTOfTOb9xovL3/5kPbwFJipBEAytoXrOCRCwDLTtm6BEbB4fQytNb5sBVtaDdB83pJ5lTW6eS+bF+qhapz6V6y3XrbQnAbESx++jwJXq2ItwKTCpR2ey/6zN3Q7uimP4p8tcX7pvr83tMxXA2o+x1zx14KK5Q0+6i3uuvZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716581884; c=relaxed/simple;
	bh=9ozPTCD7Fx/QFsL36aA4SuJ+RBTui3T5YbIkwRVu6Fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=U2SOZg9yW9semo6FN/CABReJLbmiDNbz+8sNNoxQza17vGJ/BuFhDRLukc9PKLY2kAtKPGxJuG+LFfkQ3gYS59D1IVnJa0OmqbZd0o1X4yOgDaOxrjOk/SP4biF1iw420KCLB4/t5wmDBtH2ZuAKS1dTN5iVEcbycwx7WDtggl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OnHDgcWC; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OnHDgcWC"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-373807d3bebso4785ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 24 May 2024 13:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716581882; x=1717186682; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wk4omrL/A903/S1NOkCW0dlLhWfbRdf0QhoFLip8gHU=;
        b=OnHDgcWC0Z7HEv/NbreihwGb9TQfLDABgOYFYISBU9jaJCHxTmmJswWK6nXP3JlBpl
         6RMBDA5WG0aifD75DR8Zas8ATpwmxv2EjBNRMlJVqSGJbZ88tN4/KC8CGWc9QFaN2uBs
         SaUoSomuc87r/w/S/CzF/HCH3Y2Ht0gRHVDyV3bq4yhgcwNc3ldPb1QX/SdCl4oCV0RN
         cnyPs2+cMi/LyJIgC3gyLQn+t4sQNPrQ1Yz9IJux+0R5XEla110dtB68aqrwoxy+EzGt
         CLT4TUk2ebG6J2aS11FzxUuQMUIS3VP/vFn0I1zleCNyHp3VN12CcW814f1d3DZWa0Up
         PDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716581882; x=1717186682;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wk4omrL/A903/S1NOkCW0dlLhWfbRdf0QhoFLip8gHU=;
        b=wvx/MTaE6ptk6pzy51AdiyJW+LL8EZfN+xstfIVESznG3uLmJ2U/JP+f9WMTyCdQwB
         wRqZsYOGOw6fNlepjbTd7a83SAqAoW0StffURWVUS23Q5Igdu0O9J0l+mLwJ+/lgbnUU
         7VL96htfD1i01hM0/i7K+3FpkLh2qWL3drI/c60aT87G+4DKpObAdcZls5Kop5yOWPyf
         yJPQ1ohv2f/LyH549FTbc2Gt1hs8mHg2LKT4CdQ1NOzef8DNKFsTl/nBIT/rpRvbSrVO
         6Gh5te6pCyFiUxIXZdU9hj7OXPZ7JBXwb/yGmmsGFNJKSYn5+DpZ7HFV/W6zfF6JRsZ6
         gR9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8vVEikwdONWKrGbqDqCC5Yg00hCJA2X4GvjSw9rsKfQ0kOBGeLl1y2wmocT5hw1o/O+oDBUVY/XMi1hXSMjcbOXvMjK8JSpHJr2oiQ1/ASg==
X-Gm-Message-State: AOJu0YxG27HP/wFvczYdYdtgVMHCZ0mH+1URzV85oY5lkHxFTCL7b5Br
	ZbloNHr16GR0lX/MalbW5+cYp1JhcyLLa77cPXg/XWv3N5rVwxxYjEx4bfOLPZFhBkQz7pE53T8
	N8AL9zsxthwuej7SYc7x2CdbTSoLVFt+xY5eVRtGD1aI9tiV6xXtU
X-Google-Smtp-Source: AGHT+IExTTqRGn3uWZSz9uBKuHDpAgIS6hbldf+nHdZLbU9qsGeci0RAFfnbAtHK3rhfG/gc8mIG2Cbr23oBFz68Pss=
X-Received: by 2002:a92:d945:0:b0:373:8961:70ac with SMTP id
 e9e14a558f8ab-3738a72b59bmr528635ab.14.1716581882226; Fri, 24 May 2024
 13:18:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fd2b28b4-8fc5-45c1-824b-4de4422e8837@app.fastmail.com>
In-Reply-To: <fd2b28b4-8fc5-45c1-824b-4de4422e8837@app.fastmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 24 May 2024 13:17:50 -0700
Message-ID: <CAP-5=fVpgRgx839qaeEbnOPSeMD5xXUwNv7Jeqe1PQj8yqV9_g@mail.gmail.com>
Subject: Re: Linux `perf report` regression
To: Mateusz Kowalczyk <fuuzetsu@fuuzetsu.co.uk>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 1:00=E2=80=AFAM Mateusz Kowalczyk
<fuuzetsu@fuuzetsu.co.uk> wrote:
>
> Hi Ian,
>
> I have recently upgraded my system and I have found that `perf report` no=
 longer gives nice traces.
>
> For the same `perf record` capture, I used to get traces like this, with =
`perf report --hierarchy -M intel --no-inline`.
>
> ```
> -   98.33%        sim
>    -   42.66%        sim
>       -    3.40%        [.] <serde_json::read::StrRead as serde_json::rea=
d::Read>::parse_str
>            ordercache::Reader::open
>            serde_json::de::from_str
>            <&mut serde_json::de::Deserializer<R> as serde::de::Deserializ=
er>::deserialize_struct
>          + <&mut serde_json::de::Deserializer<R> as serde::de::Deserializ=
er>::deserialize_map
> ```
>
> However after upgrading, I get the following report on the very same file=
:
>
> ```
> -   98.33%        sim
>    -   42.66%        sim
>       -    3.40%        [.] <serde_json::read::StrRead as serde_json::rea=
d::Read>::parse_str
>            0x55e840085c78
>            0x55e84008fb0d
>            0x55e8400986d6
>          + 0x55e840096122
> ```
>
>
> I have bisected the issue to this commit: https://lore.kernel.org/all/202=
30608232823.4027869-21-irogers@google.com/ a.k.a. `bffb5b0c0976aa46aaa961dd=
19a47c9d6301cfe1`. The working `perf report` is from the commit right befor=
e that, `1981da1fe2499823f626c86c5ba3be6b89844384`.
>
> I'm not sure if there's some mailing list I should be trying to report it=
 at. I can not share the perf capture as-is but I can try to come up with s=
omething on Monday that should hopefully reproduce the problem, if necessar=
y.

Thanks Mateusz,

The mailing list to use is linux-perf-users, added. Thanks for the
bisect, looking at the patch in question it looks like prior to the
fix there was probably a use after a value had been put. We probably
need to increase the lifetime of the get/put to avoid the issue you
are seeing. The reference count checking has some documentation here:
https://perf.wiki.kernel.org/index.php/Reference_Count_Checking

Looking at the patch, and adding some annotations:
```
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -590,6 +590,7 @@ fill_node(struct callchain_node *node, struct
callchain_cursor *cursor)
  call->ip =3D cursor_node->ip;
  call->ms =3D cursor_node->ms;
  call->ms.map =3D map__get(call->ms.map);
+ call->ms.maps =3D maps__get(call->ms.maps); <---- adding a get should
be safe, it increases a reference count and shouldn't make the thing
go away
  call->srcline =3D cursor_node->srcline;

  if (cursor_node->branch) {
@@ -649,6 +650,7 @@ add_child(struct callchain_node *parent,
  list_for_each_entry_safe(call, tmp, &new->val, list) {
  list_del_init(&call->list);
  map__zput(call->ms.map);
+ maps__zput(call->ms.maps); <----- a put could be the source of the
problem, especially a zput that makes the value NULL. However, the
next line here frees "call" and so we're unlikely to have been using
it later in the code.
  free(call);
  }
  free(new);
@@ -1010,10 +1012,16 @@ merge_chain_branch(struct callchain_cursor *cursor,
  int err =3D 0;

  list_for_each_entry_safe(list, next_list, &src->val, list) {
- callchain_cursor_append(cursor, list->ip, &list->ms,
- false, NULL, 0, 0, 0, list->srcline);
+ struct map_symbol ms =3D {
+ .maps =3D maps__get(list->ms.maps),
+ .map =3D map__get(list->ms.map), <--- gets should be safe
+ };
+ callchain_cursor_append(cursor, list->ip, &ms, false, NULL, 0, 0, 0,
list->srcline);
  list_del_init(&list->list);
+ map__zput(ms.map);
+ maps__zput(ms.maps); <--- these puts should match the gets above, so
should be sound
  map__zput(list->ms.map);
+ maps__zput(list->ms.maps); <--- these puts are on a value in "list"
which is freed below, so we should be good.
  free(list);
  }
```
Nothing was particularly jumping out from the changes but given the
reproduction you have you should be able to revert the change in each
file and narrow down which change is causing the issue.

Thanks,
Ian




> I thought I'd fire an e-mail in case this is something obvious to you and=
 the fix is simple. I tried to search on the web but I was unable to find a=
nything useful. Maybe most people are using some old version or it's someth=
ing to do with my setup.
>
> Please let me know if I should send this to some mailing list instead -- =
presumably with a reproduction example.
>
> Thank you!
>
> --
> Mateusz K.
