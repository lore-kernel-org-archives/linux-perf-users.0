Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB314158D78
	for <linux-perf-users@vger.kernel.org>; Fri, 31 May 2024 16:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717174598; cv=none; b=UJiyQwiN4LJ4cMunwTrdmYFdRqaRt65ujQvqnM7uyyWFq1+u401eUA3CR6cXvQFQpkxngk40Mo3s+R+gcwQNXXD66JBgrAjQWLwomYhGL3KJHs0YNeOKuIcM0m/agTQeQEyZTwnWPwwEqGLmm0o7VYPSItQU7sMv+96A3/G0OLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717174598; c=relaxed/simple;
	bh=HAY7PZMaSk67hRF42ewRM4L+BqGH2YWq0pLTOi5iT1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fdchf2Yp07pj3nELzMsW7SZuN2G0h5BQBkVwfsFKkr7Ffqdhb2T+/yenv5dlAvzo4lG6Inb5FigWtmU9VZGVHAb0YQLSw9hmx66uE5hyEMxp/2ViLnvLMFcQUMwqHiyqVS7uCaludrtHvTkEUNrn7VN2k7Me4Wpk4lTwpDBJMts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a10PUx8n; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a10PUx8n"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f61bbb1dfcso6705ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 31 May 2024 09:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717174596; x=1717779396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOsa8RSvQlQFExoP/a06+U/w+QQdd8JWB0+onPI4VWA=;
        b=a10PUx8n0SgnxQh/Eo7ndakU9JbeeZ176hWtWBLwO7p0CY9dkUyT9gQkn7CMAtkTDM
         2OjaxCXEmh6ROklACVlL9b4+PXxDzsQD66B713zyjhL5EWkbLP9hSYhvbDaLvFGg1nUC
         8SwMNZQukFJbSGyUdQfJ5Q8R2xL/YNAVXNyx8ECBu1BHGQYBUKCIj5jExi3NdfBM+uRs
         Lnf7o+UCVY2E03PyDysuXOOoEKheF93d4RIRTglvpzB8MeZyyDOl9Dpg0chJacO5/Ju6
         CitMNDhVcWN366WjaFH/tlmH1oFF+edFYuK+vVG5YgY+CyuPqKcoQtHEbNXXyot7HIWs
         xNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717174596; x=1717779396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOsa8RSvQlQFExoP/a06+U/w+QQdd8JWB0+onPI4VWA=;
        b=Jvc4z/tM3dUgbF36pS0+dvtkTbZRCKMBx2d2vfuxv2IGO/mbnGucDQfNRJn1/A7Rl/
         SBat3CilW0yDaJlXi+XMmNsvk2Mex/QDR+a5bwPeSZgwJ+D1RiJeWe1t+HhdtOxMs9uT
         nG/RlkTgrVjJ141GMP5m/ILjfjYzy87qWGNy97KQjztyZj333ds5jbIYVaTDjAGC2vO6
         dePjuX4zVC9XYVMl4JnzzdSYHH0n/Jw7ecyGqmsCFC6Zi43BW9G4n+VZLkJ1MgEevBb3
         IbVgIsepqeYW3bmmPAsHhuSuIj6iYeHFggb67iekph9O9hfVNxZmttgYgMs5Qg24R+Mx
         JxQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSctXUSSTMeu+aXnSiMHU+Jajao1/bOtfslhkQuZPLuK5JqOeq9Gi44SYjh2lhMD2OsvxrypwAhCxbOAzI2+3B3qyT28hi7FD6xuKW/mmXWg==
X-Gm-Message-State: AOJu0YzszHvIOwe472W1T4rP9CqammucU67M9UeCwc6WGbWE3roTJ/r+
	F2+0u0/W8RJSu6rqZmm5kvZ6JU7rxwXOTGewLuSxxBw1kCQ1qzrTgAr2rkYS6JtbZY065GW11Hs
	B10eqsBhylx9KKYVX2V3XsEkvL9SURyDRBy67xsz8+mffm77YIVUJ
X-Google-Smtp-Source: AGHT+IFiBy1CeSjcDwkWntpZMxGp4ZCTCi8lwdsNZIgQfy+pJ3nVd4Yd25lRoh0riJQkwGitQMnZ0B5M+SFamln0udc=
X-Received: by 2002:a17:902:c144:b0:1f4:7db0:afca with SMTP id
 d9443c01a7336-1f6343721bemr2381945ad.6.1717174595474; Fri, 31 May 2024
 09:56:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fd2b28b4-8fc5-45c1-824b-4de4422e8837@app.fastmail.com>
 <CAP-5=fVpgRgx839qaeEbnOPSeMD5xXUwNv7Jeqe1PQj8yqV9_g@mail.gmail.com>
 <a8ea965e-1a88-4297-8ef7-8a8e80ae6a4a@app.fastmail.com> <CAM9d7cjCL2=h6jwQ_cM24JqT2Um=zfWtJYdQbiy6BAcktyudnQ@mail.gmail.com>
In-Reply-To: <CAM9d7cjCL2=h6jwQ_cM24JqT2Um=zfWtJYdQbiy6BAcktyudnQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 31 May 2024 09:56:23 -0700
Message-ID: <CAP-5=fVHMdfeAb4psYr3TtorQ5t7V9u8HUWH=LLJcBC4TOqnKg@mail.gmail.com>
Subject: Re: Linux `perf report` regression
To: Namhyung Kim <namhyung@kernel.org>
Cc: Mateusz Kowalczyk <fuuzetsu@fuuzetsu.co.uk>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 10:47=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hello,
>
> On Sun, May 26, 2024 at 5:39=E2=80=AFPM Mateusz Kowalczyk
> <fuuzetsu@fuuzetsu.co.uk> wrote:
> >
> > On Sat, 25 May 2024, at 5:17 AM, Ian Rogers wrote:
> > > On Fri, May 24, 2024 at 1:00=E2=80=AFAM Mateusz Kowalczyk
> > > <fuuzetsu@fuuzetsu.co.uk> wrote:
> > >>
> > >> Hi Ian,
> > >>
> > >> I have recently upgraded my system and I have found that `perf repor=
t` no longer gives nice traces.
> > >>
> > >> For the same `perf record` capture, I used to get traces like this, =
with `perf report --hierarchy -M intel --no-inline`.
> > >>
> > >> ```
> > >> -   98.33%        sim
> > >>    -   42.66%        sim
> > >>       -    3.40%        [.] <serde_json::read::StrRead as serde_json=
::read::Read>::parse_str
> > >>            ordercache::Reader::open
> > >>            serde_json::de::from_str
> > >>            <&mut serde_json::de::Deserializer<R> as serde::de::Deser=
ializer>::deserialize_struct
> > >>          + <&mut serde_json::de::Deserializer<R> as serde::de::Deser=
ializer>::deserialize_map
> > >> ```
> > >>
> > >> However after upgrading, I get the following report on the very same=
 file:
> > >>
> > >> ```
> > >> -   98.33%        sim
> > >>    -   42.66%        sim
> > >>       -    3.40%        [.] <serde_json::read::StrRead as serde_json=
::read::Read>::parse_str
> > >>            0x55e840085c78
> > >>            0x55e84008fb0d
> > >>            0x55e8400986d6
> > >>          + 0x55e840096122
> > >> ```
> > >>
> > >>
> > >> I have bisected the issue to this commit: https://lore.kernel.org/al=
l/20230608232823.4027869-21-irogers@google.com/ a.k.a. `bffb5b0c0976aa46aaa=
961dd19a47c9d6301cfe1`. The working `perf report` is from the commit right =
before that, `1981da1fe2499823f626c86c5ba3be6b89844384`.
> > >>
> > >> I'm not sure if there's some mailing list I should be trying to repo=
rt it at. I can not share the perf capture as-is but I can try to come up w=
ith something on Monday that should hopefully reproduce the problem, if nec=
essary.
> > >
> > > Thanks Mateusz,
> > >
> > > The mailing list to use is linux-perf-users, added. Thanks for the
> > > bisect, looking at the patch in question it looks like prior to the
> > > fix there was probably a use after a value had been put. We probably
> > > need to increase the lifetime of the get/put to avoid the issue you
> > > are seeing. The reference count checking has some documentation here:
> > > https://perf.wiki.kernel.org/index.php/Reference_Count_Checking
> > >
> > > Looking at the patch, and adding some annotations:
> > > ```
> > > --- a/tools/perf/util/callchain.c
> > > +++ b/tools/perf/util/callchain.c
> > > @@ -590,6 +590,7 @@ fill_node(struct callchain_node *node, struct
> > > callchain_cursor *cursor)
> > >   call->ip =3D cursor_node->ip;
> > >   call->ms =3D cursor_node->ms;
> > >   call->ms.map =3D map__get(call->ms.map);
> > > + call->ms.maps =3D maps__get(call->ms.maps); <---- adding a get shou=
ld
> > > be safe, it increases a reference count and shouldn't make the thing
> > > go away
> > >   call->srcline =3D cursor_node->srcline;
> > >
> > >   if (cursor_node->branch) {
> > > @@ -649,6 +650,7 @@ add_child(struct callchain_node *parent,
> > >   list_for_each_entry_safe(call, tmp, &new->val, list) {
> > >   list_del_init(&call->list);
> > >   map__zput(call->ms.map);
> > > + maps__zput(call->ms.maps); <----- a put could be the source of the
> > > problem, especially a zput that makes the value NULL. However, the
> > > next line here frees "call" and so we're unlikely to have been using
> > > it later in the code.
> > >   free(call);
> > >   }
> > >   free(new);
> > > @@ -1010,10 +1012,16 @@ merge_chain_branch(struct callchain_cursor *c=
ursor,
> > >   int err =3D 0;
> > >
> > >   list_for_each_entry_safe(list, next_list, &src->val, list) {
> > > - callchain_cursor_append(cursor, list->ip, &list->ms,
> > > - false, NULL, 0, 0, 0, list->srcline);
> > > + struct map_symbol ms =3D {
> > > + .maps =3D maps__get(list->ms.maps),
> > > + .map =3D map__get(list->ms.map), <--- gets should be safe
> > > + };
> > > + callchain_cursor_append(cursor, list->ip, &ms, false, NULL, 0, 0, 0=
,
> > > list->srcline);
> > >   list_del_init(&list->list);
> > > + map__zput(ms.map);
> > > + maps__zput(ms.maps); <--- these puts should match the gets above, s=
o
> > > should be sound
> > >   map__zput(list->ms.map);
> > > + maps__zput(list->ms.maps); <--- these puts are on a value in "list"
> > > which is freed below, so we should be good.
> > >   free(list);
> > >   }
> > > ```
> > > Nothing was particularly jumping out from the changes but given the
> > > reproduction you have you should be able to revert the change in each
> > > file and narrow down which change is causing the issue.
> > >
> > > Thanks,
> > > Ian
> > >
> > >
> > >
> > >
> > >> I thought I'd fire an e-mail in case this is something obvious to yo=
u and the fix is simple. I tried to search on the web but I was unable to f=
ind anything useful. Maybe most people are using some old version or it's s=
omething to do with my setup.
> > >>
> > >> Please let me know if I should send this to some mailing list instea=
d -- presumably with a reproduction example.
> > >>
> > >> Thank you!
> > >>
> > >> --
> > >> Mateusz K.
> >
> > Hi again,
> >
> > I was first able to revert `util/callchain.c` and confirmed that fixed =
the issue. To narrow it down, I tried commenting out every `maps__zput` tha=
t was added and later even every `map__zput` that already existed but nothi=
ng fixed the problem.
> >
> > The only thing that did help was this change:
> >
> > ```diff
> > diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> > index 909f62b3b266..77215cedf35d 100644
> > --- a/tools/perf/util/callchain.c
> > +++ b/tools/perf/util/callchain.c
> > @@ -1016,7 +1016,7 @@ merge_chain_branch(struct callchain_cursor *curso=
r,
> >                         .maps =3D maps__get(list->ms.maps),
> >                         .map =3D map__get(list->ms.map),
> >                 };
> > -               callchain_cursor_append(cursor, list->ip, &ms, false, N=
ULL, 0, 0, 0, list->srcline);
> > +               callchain_cursor_append(cursor, list->ip, &list->ms, fa=
lse, NULL, 0, 0, 0, list->srcline);
> >                 list_del_init(&list->list);
> >                 map__zput(ms.map);
> >                 maps__zput(ms.maps);
> > ```
> >
> > I don't know _why_ this fixes it unless something weird is happening wi=
th the maps__get or map__get above...?
> >
> > I was able to confirm on the most recent kernel tree checkout that the =
same patch still makes the problem go away. Of course, this is probably not=
 the right fix but I don't really know what I'm doing...
> >
> > Maybe this gives some hint about what may be wrong.
>
> Yeah, it looks like the right fix.  The callchain_cursor_append()
> assumes ms.sym is set and list->ms would have it.  But the new
> ms didn't copy the symbol so the output just prints the ip.
>
> Can you send a formal patch?  I think we can remove the 'ms'.

This is awesome! Sorry for the regression, thanks to Namhyung for
confirming Mateusz's fix. Thanks to Mateusz!

It'd be great if we can get a regression test on this.

Ian

> Thanks,
> Namhyung
