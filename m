Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89363344DAB
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 01:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775612807; cv=pass; b=LYCGKBs6sbnKL6NXjo8st2ZcEokvJWcy9W9nGTKe4TSJF4F09ysqsBU75i6xeeGEgR4lN1htigRKYtkwIKc+wc7MWXb3TVKMHNnRiLOzMM4sbz22FzUma8fEOs4QxlTVSn43p9OopIJ83cp2DBpgJtBQJn1HuzcuCFq9Xx5+vkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775612807; c=relaxed/simple;
	bh=QL8IUN7qeXYgh5GSXcwUvniUIl1xDMVEjGQWw4EKe7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OcBlmvHyxRB1BpJSAXXLbzhFvZZm7KlSHL331PF8UHanvDUseT+ZyAEAyLnlkUafyYYQawb2qgG6sqC+XNowlJJUoea8lexe2lc7yrOjVos0OIZTp282jRbk9eVjArSac2w93mngqqgNlMJTH1qR5glGsAM4Huh1Lcaysj2lIHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HZlp8/TG; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HZlp8/TG"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b0b260d309so22985ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Apr 2026 18:46:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775612806; cv=none;
        d=google.com; s=arc-20240605;
        b=dQvGSZ7qY3FSrZRYKgDXCaCfyFtNivmFvEkmyFjP2AKogM4ouDlTczy8gCqKaDM++3
         kTRgo96ORgppLL3P/izVXRbo0BMj6B214iteM2TlQmi22N03QKzP+/wtdnRWwBhew59A
         pfl+zsX0yDeOgRJWXlrqLrcqQUcSvytqjyjSqXSHqtHAgD7DxtAbiV0Hi8BG7mrIkbqQ
         NRiOUHpUlDKqKR/N+oX/65ZHIUzAgFsnn1PTz8Gb9t2TKqhBPLxvCC99mfyvg6a2C1qT
         lktXKkxUjo0qdjjChkaBkP240/VzWInmNf3S8LWtkkHK2aATn48aPTWP0CZBW0/kVlJH
         cgIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jjOFYF51uBM1+TeixF7rbmpu4qyqW6ZVfp/Ch5IaIPw=;
        fh=7h0izHys8KHgVwAHFbDqh8DXgNjj235aXcN4iZY+6bA=;
        b=Npg3HgQlQDRu6WSGx+njO4vcralNW8zgD/iOYufQJhTRpQGcNkoHtx/9M5Sp1C77Uy
         P/SUatnDmr91NJVwz/Kl1rHH61lKojFl+LCUI/IWfFyz8ZgBRbwWMOqtMRiSDyF4wdhp
         WHJAGEWFPHRdRJHAJB1bBOPaAz0MwCDITNCUEtrPzOyDer/NH7iFJVbbknaz46mr2j44
         f7HXzNfYBN1xkbeRsE7niUomyjudzLSFOOvgi5iOippXyzLoaSd9e7TkTGxFPP6MiBuu
         sxIDHVhorEW62NRHpbgyu5RIAVKqfOWMxRUXYmxQI4XQ6rUZ+gNdHhoXET5fuNHw49+J
         056g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775612806; x=1776217606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjOFYF51uBM1+TeixF7rbmpu4qyqW6ZVfp/Ch5IaIPw=;
        b=HZlp8/TG90KePO1H/j635PIKXwebHbbRH3Ph/8aSpo0VljceNNhTtjcW6wwz8F9Jn1
         Tw30w/MYucXefGN9YdI4EZniV4xXkLe/SEa5vFSDWScBr5pkDNSH9U6I/GxueGOryok4
         8kt1JZu3ZT9+Y3w8OxXDGzMGsTsXdFWyzeqiC+coJkp9M5smz/q7zmTrcCJmQz+9v4hz
         XtkH5jkYcUf2blxJBfFhpCgUyAtT7cwFYFNw+UV6nX6G0tcdFiAm2XmPIpum5PMmByyC
         nV9D1xUGAiUVQMYph5i7sH2/VcEFVmE1H0quus62eE/t8R98AfBfuZkM7kQI2ZUCUaK0
         mJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775612806; x=1776217606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jjOFYF51uBM1+TeixF7rbmpu4qyqW6ZVfp/Ch5IaIPw=;
        b=Wab6pGQPlRRjhafCEYjDdYBwetPWFscD0DFtVLW+nbLKue1Ca0eKmgFzvsgc6P+tXj
         iKYD5Zwcw/2ocPbvGxGKqTY5w9J3azLfKc8MrM8s5Vkr22TUbWNK0D1Y+ixrI4PB3XM6
         P1KEqpD+IWpA65lF5D9sVBdiQFyLFmTMSZnMYJlKwBnKR0cPFBdNtD46CszEhXD41PE8
         xhO5hiqkRK088TV2kFn3TDmwc/UqYKaNeacr07tzwgXEzaEfLMj/TkZ3RF5vmrmNWQlJ
         YotcVMnPIp4kg6e2jgSLalOb1oo1kO/tYPJewJc+BioeD/lW/M0LxHAA/xNtFnrOubYU
         weyw==
X-Gm-Message-State: AOJu0YxU5NryX6DmqvxWqP0KdjIs5fM35ywStxKE/MvLFfIJ9mkwpyY+
	LrR+r72F7zF3f6hnfXwpOgDpeQRDS+pIEKT7hhhLrnY6L08YMj47l3ueKOy5kN09kpB+zFyJ/ZO
	WCQvaudk9ZIACbF3aesLhxWT2FoB/TPGNGNw1LY+n
X-Gm-Gg: AeBDies0QoneOVAcI9RP/c2p3HLE9D4Fvkvp+I1G0Dabf8Kx9IfXCCnPSrnBhktdz0Y
	Li2y4/IlO8vTINOVZIQAdfOblNB0TS0tAnsdUENMlKm6nto5pHkogh3NX8S1VBIBr1A8hKxBhBG
	/BR7yeAmJnGZ7s6v0d6eugJ5Pq6D2UeZ8wX4xlDV2s73qbdyr4u+ZNGN0AdXAthaY1K/ADfTEY+
	OZwQXFSvEIfoONbH9GvP/qy1vERfPCkbd/tIIW8YN62ZfNiYNpfwNbJQXRmVknvsJIixHCaoEPY
	u927VgQO
X-Received: by 2002:a17:903:94d:b0:2b0:5193:1212 with SMTP id
 d9443c01a7336-2b2b96da1d6mr872985ad.4.1775612805134; Tue, 07 Apr 2026
 18:46:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408001521.102140-2-irogers@google.com> <20260408005152.C599FC116C6@smtp.kernel.org>
In-Reply-To: <20260408005152.C599FC116C6@smtp.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 7 Apr 2026 18:46:31 -0700
X-Gm-Features: AQROBzB3a6iMxFzVZyOw186cpShdVhA7om-DXRfo3ON5lKkC2wLIhQD5lNshF1U
Message-ID: <CAP-5=fVqaqNo1VyGPWhZ+DvEv+oRUU=sMtBtpFbm4D-sJb-JNA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf maps: Fix fixup_overlap_and_insert that can
 break sorted by name order
To: sashiko@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 5:51=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 1 potential issue(s):
> - [High] The maps__copy_from function corrupts the maps_by_name array by =
populating it in address order but flagging it as sorted by name.
>
> --
>
> commit bd0adc21836e1932db4199fc14353b8a08f98a0a
> Author: Ian Rogers <irogers@google.com>
>
> perf maps: Fix fixup_overlap_and_insert that can break sorted by name ord=
er
>
> When an entry in the address array is replaced, the corresponding name
> entry is replaced. The entries names may sort differently and so it is
> important that the sorted by name property be cleared on the maps.
>
> > diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> > index 7dd6da9d1e4f0..b44bc41f51f3b 100644
> > --- a/tools/perf/util/maps.c
> > +++ b/tools/perf/util/maps.c
> [ ... ]
> > @@ -955,6 +955,7 @@ static int __maps__fixup_overlap_and_insert(struct =
maps *maps, struct map *new)
> >                       if (maps_by_name) {
> >                               map__put(maps_by_name[ni]);
> >                               maps_by_name[ni] =3D map__get(new);
> > +                             maps__set_maps_by_name_sorted(maps, false=
);
> >                       }
> [ ... ]
>
> This isn't a bug in the newly added lines, but while reviewing the maps
> sorting logic, I noticed a regression in maps__copy_from().
>
> In maps__copy_from(), when copying maps from a parent to a destination
> (e.g., during thread fork), the dest_maps_by_name array is populated
> sequentially inside a loop iterating over parent_maps_by_address:
>
> tools/perf/util/maps.c:maps__copy_from() {
> [ ... ]
>                 for (unsigned int i =3D 0; !err && i < n; i++) {
>                         struct map *pos =3D parent_maps_by_address[i];
>                         struct map *new =3D map__clone(pos);
> [ ... ]
>                                 if (!err) {
>                                         dest_maps_by_address[i] =3D new;
>                                         map__set_kmap_maps(new, dest);
>                                         if (dest_maps_by_name)
>                                                 dest_maps_by_name[i] =3D =
map__get(new);
> [ ... ]
> }
>
> Because it clones and copies the elements in address order,
> dest_maps_by_name is strictly populated in address order.
>
> However, at the end of the fast-path copy block, the code executes:
>
> tools/perf/util/maps.c:maps__copy_from() {
> [ ... ]
>                 if (!err) {
>                         RC_CHK_ACCESS(dest)->last_search_by_name_idx =3D
>                                 RC_CHK_ACCESS(parent)->last_search_by_nam=
e_idx;
>                         maps__set_maps_by_name_sorted(dest,
>                                                 dest_maps_by_name &&
>                                                 maps__maps_by_name_sorted=
(parent));
>                 }
> [ ... ]
> }
>
> If the parent's name array was sorted, does this explicitly flag the new
> destination map's name array as sorted by name, even though it is physica=
lly
> sorted by address?
>
> Could this cause any subsequent lookup by name in the copied map
> (such as maps__find_by_name during child thread symbol resolution)
> to execute a binary search on an address-sorted array?
>
> Would this cause the binary search to take incorrect paths and fail to fi=
nd
> legitimate mappings, leading to missing symbols or missing maps for
> child threads?

This is legitimate, I'll do a v3 with a fix for this issue as well.

Thanks,
Ian

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260408001521.10=
2140-1-irogers@google.com?part=3D2
