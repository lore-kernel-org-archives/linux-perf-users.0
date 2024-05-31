Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A2D28FD
	for <linux-perf-users@vger.kernel.org>; Fri, 31 May 2024 05:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717134453; cv=none; b=J/T3nhQCWKmW825aRzSb0yEdqhYtaxa1sgSpyjxUZJEJGHZPb+8yHgielxlA572b0qTq3wxxgyEJko2OFcrNuhboVUjTbU8cA4jyHdEmIHumpRjqKn8grJIFq+xCsSXm54RzL0V5EVRbmUecLmIilFYBrDR88SmcSZQEZhBtTL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717134453; c=relaxed/simple;
	bh=lkXTM1LqOWAxF1rYzYUvntWi+U/KXLIgPzaKn1c30TY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=awPw5icof7EKBxknn9oOzUG0bJgVQit39CkCMXa32TcudYr/ne6qLVdf9AGiiJP6xHGQ5THPIqOmkFwjJ9bSiqf6lmrXLhK0PcH3MFd2VkIB1t0QrIWKWJ5X9NGb4r40Kg8aXuJiLNuHTp3UuQqsF3YEA0dYNHWKR0uTjoAkNZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c1a16805f9so1353450a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 30 May 2024 22:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717134450; x=1717739250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5Y8fS9OSiYQSpas0jXUggJoQtN3En7LGg+d/agSyRg=;
        b=YaQJS3D8Iccq0vmtb7yO3qGzgxt0lX4l3ZqUQ7uRWTOfstVsd9rlRrZfFdIbErAfz/
         RDCEqpozqS6A/b7zSDaL3hSV43G5WeTgqeU5WtdggluJTnMGdOhdowdTOnvd5U2LxLiD
         OFuJrCGJVjwKZJfA4sPIG6cpOJjgvd4FrszpTAkK61RLcLcxYTZ1JmPMwXJvtxrCWmkm
         hEhtLTQ/G3cjwT+TlW2HWTmbZThk/hcgL5aJL0BJmEh9DkcRoAdt9lMV1rmz+wm3ZiyC
         5Ly7ZminzZUg4hb561rqzHsXrWapMn6oKCUV5rxEHW8e9Up5JqryinQH1J+pWZ1bnomh
         TvHA==
X-Forwarded-Encrypted: i=1; AJvYcCXJWpK3+NZHi9Td17aY6SiuHTgcUmHbu/OpFpP02OBXfHx540F+KZ0ebJnIIgmtoz1aJtSd014pfjEk9IcGD6iQaIv1gaNFBopr8nRialfM8Q==
X-Gm-Message-State: AOJu0YxJo8CPqQZobofFa0GR9dDr44TKYMtpHs2TjxjMyOiZHU2/YyMQ
	lh/AP2lgdqL+DfNKl7NNdsh/rvwiIhUvGE4NsVusxcPFuIMDerZGd425WYB/mcSu74TtC919kRS
	iu6BONjXnhhhL0FDqoNo4Nm1L0n4=
X-Google-Smtp-Source: AGHT+IGHB8H5MH9J8G5yja5vygsg62ZiUq9EZzivQTFFWeiB4O0mSdef6Gx61UNEasUNI2WbffUG0dn6614yB8+QEq0=
X-Received: by 2002:a17:90a:f198:b0:2c1:a546:350d with SMTP id
 98e67ed59e1d1-2c1c43df043mr1681005a91.4.1717134449983; Thu, 30 May 2024
 22:47:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fd2b28b4-8fc5-45c1-824b-4de4422e8837@app.fastmail.com>
 <CAP-5=fVpgRgx839qaeEbnOPSeMD5xXUwNv7Jeqe1PQj8yqV9_g@mail.gmail.com> <a8ea965e-1a88-4297-8ef7-8a8e80ae6a4a@app.fastmail.com>
In-Reply-To: <a8ea965e-1a88-4297-8ef7-8a8e80ae6a4a@app.fastmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 30 May 2024 22:47:18 -0700
Message-ID: <CAM9d7cjCL2=h6jwQ_cM24JqT2Um=zfWtJYdQbiy6BAcktyudnQ@mail.gmail.com>
Subject: Re: Linux `perf report` regression
To: Mateusz Kowalczyk <fuuzetsu@fuuzetsu.co.uk>
Cc: Ian Rogers <irogers@google.com>, linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, May 26, 2024 at 5:39=E2=80=AFPM Mateusz Kowalczyk
<fuuzetsu@fuuzetsu.co.uk> wrote:
>
> On Sat, 25 May 2024, at 5:17 AM, Ian Rogers wrote:
> > On Fri, May 24, 2024 at 1:00=E2=80=AFAM Mateusz Kowalczyk
> > <fuuzetsu@fuuzetsu.co.uk> wrote:
> >>
> >> Hi Ian,
> >>
> >> I have recently upgraded my system and I have found that `perf report`=
 no longer gives nice traces.
> >>
> >> For the same `perf record` capture, I used to get traces like this, wi=
th `perf report --hierarchy -M intel --no-inline`.
> >>
> >> ```
> >> -   98.33%        sim
> >>    -   42.66%        sim
> >>       -    3.40%        [.] <serde_json::read::StrRead as serde_json::=
read::Read>::parse_str
> >>            ordercache::Reader::open
> >>            serde_json::de::from_str
> >>            <&mut serde_json::de::Deserializer<R> as serde::de::Deseria=
lizer>::deserialize_struct
> >>          + <&mut serde_json::de::Deserializer<R> as serde::de::Deseria=
lizer>::deserialize_map
> >> ```
> >>
> >> However after upgrading, I get the following report on the very same f=
ile:
> >>
> >> ```
> >> -   98.33%        sim
> >>    -   42.66%        sim
> >>       -    3.40%        [.] <serde_json::read::StrRead as serde_json::=
read::Read>::parse_str
> >>            0x55e840085c78
> >>            0x55e84008fb0d
> >>            0x55e8400986d6
> >>          + 0x55e840096122
> >> ```
> >>
> >>
> >> I have bisected the issue to this commit: https://lore.kernel.org/all/=
20230608232823.4027869-21-irogers@google.com/ a.k.a. `bffb5b0c0976aa46aaa96=
1dd19a47c9d6301cfe1`. The working `perf report` is from the commit right be=
fore that, `1981da1fe2499823f626c86c5ba3be6b89844384`.
> >>
> >> I'm not sure if there's some mailing list I should be trying to report=
 it at. I can not share the perf capture as-is but I can try to come up wit=
h something on Monday that should hopefully reproduce the problem, if neces=
sary.
> >
> > Thanks Mateusz,
> >
> > The mailing list to use is linux-perf-users, added. Thanks for the
> > bisect, looking at the patch in question it looks like prior to the
> > fix there was probably a use after a value had been put. We probably
> > need to increase the lifetime of the get/put to avoid the issue you
> > are seeing. The reference count checking has some documentation here:
> > https://perf.wiki.kernel.org/index.php/Reference_Count_Checking
> >
> > Looking at the patch, and adding some annotations:
> > ```
> > --- a/tools/perf/util/callchain.c
> > +++ b/tools/perf/util/callchain.c
> > @@ -590,6 +590,7 @@ fill_node(struct callchain_node *node, struct
> > callchain_cursor *cursor)
> >   call->ip =3D cursor_node->ip;
> >   call->ms =3D cursor_node->ms;
> >   call->ms.map =3D map__get(call->ms.map);
> > + call->ms.maps =3D maps__get(call->ms.maps); <---- adding a get should
> > be safe, it increases a reference count and shouldn't make the thing
> > go away
> >   call->srcline =3D cursor_node->srcline;
> >
> >   if (cursor_node->branch) {
> > @@ -649,6 +650,7 @@ add_child(struct callchain_node *parent,
> >   list_for_each_entry_safe(call, tmp, &new->val, list) {
> >   list_del_init(&call->list);
> >   map__zput(call->ms.map);
> > + maps__zput(call->ms.maps); <----- a put could be the source of the
> > problem, especially a zput that makes the value NULL. However, the
> > next line here frees "call" and so we're unlikely to have been using
> > it later in the code.
> >   free(call);
> >   }
> >   free(new);
> > @@ -1010,10 +1012,16 @@ merge_chain_branch(struct callchain_cursor *cur=
sor,
> >   int err =3D 0;
> >
> >   list_for_each_entry_safe(list, next_list, &src->val, list) {
> > - callchain_cursor_append(cursor, list->ip, &list->ms,
> > - false, NULL, 0, 0, 0, list->srcline);
> > + struct map_symbol ms =3D {
> > + .maps =3D maps__get(list->ms.maps),
> > + .map =3D map__get(list->ms.map), <--- gets should be safe
> > + };
> > + callchain_cursor_append(cursor, list->ip, &ms, false, NULL, 0, 0, 0,
> > list->srcline);
> >   list_del_init(&list->list);
> > + map__zput(ms.map);
> > + maps__zput(ms.maps); <--- these puts should match the gets above, so
> > should be sound
> >   map__zput(list->ms.map);
> > + maps__zput(list->ms.maps); <--- these puts are on a value in "list"
> > which is freed below, so we should be good.
> >   free(list);
> >   }
> > ```
> > Nothing was particularly jumping out from the changes but given the
> > reproduction you have you should be able to revert the change in each
> > file and narrow down which change is causing the issue.
> >
> > Thanks,
> > Ian
> >
> >
> >
> >
> >> I thought I'd fire an e-mail in case this is something obvious to you =
and the fix is simple. I tried to search on the web but I was unable to fin=
d anything useful. Maybe most people are using some old version or it's som=
ething to do with my setup.
> >>
> >> Please let me know if I should send this to some mailing list instead =
-- presumably with a reproduction example.
> >>
> >> Thank you!
> >>
> >> --
> >> Mateusz K.
>
> Hi again,
>
> I was first able to revert `util/callchain.c` and confirmed that fixed th=
e issue. To narrow it down, I tried commenting out every `maps__zput` that =
was added and later even every `map__zput` that already existed but nothing=
 fixed the problem.
>
> The only thing that did help was this change:
>
> ```diff
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 909f62b3b266..77215cedf35d 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -1016,7 +1016,7 @@ merge_chain_branch(struct callchain_cursor *cursor,
>                         .maps =3D maps__get(list->ms.maps),
>                         .map =3D map__get(list->ms.map),
>                 };
> -               callchain_cursor_append(cursor, list->ip, &ms, false, NUL=
L, 0, 0, 0, list->srcline);
> +               callchain_cursor_append(cursor, list->ip, &list->ms, fals=
e, NULL, 0, 0, 0, list->srcline);
>                 list_del_init(&list->list);
>                 map__zput(ms.map);
>                 maps__zput(ms.maps);
> ```
>
> I don't know _why_ this fixes it unless something weird is happening with=
 the maps__get or map__get above...?
>
> I was able to confirm on the most recent kernel tree checkout that the sa=
me patch still makes the problem go away. Of course, this is probably not t=
he right fix but I don't really know what I'm doing...
>
> Maybe this gives some hint about what may be wrong.

Yeah, it looks like the right fix.  The callchain_cursor_append()
assumes ms.sym is set and list->ms would have it.  But the new
ms didn't copy the symbol so the output just prints the ip.

Can you send a formal patch?  I think we can remove the 'ms'.

Thanks,
Namhyung
