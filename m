Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801504756DC
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 19:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791143793; cv=pass; b=PqlcPFc8Tn43DeGU+wCAOS8Oe9fTZnsyRpv8NhK+x97pMmW6MKKiiUOqgEyI91Re6jJD3y+tVFFR/NK0HM+f2r1v9lSdRnzdD9R9OSbcLoyKs1HQ7EDbQ+wI8apFghn2suz4rmhW8/q6iEOxE2GCYkLBDm7BC02ozwtTdx0yeiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791143793; c=relaxed/simple;
	bh=OnsVEjVr9nZISo1f+HA1XAFuoQXPTMkVBewjQpZFVEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=szQeNOxbD0DlxdZD9ZO/DIwLgAs6xOqBytyRb7ykEfSpcCMKRAJxzJaE6MZkFGHN/kZmtliL7NM19xrXsAAXrNX3cUZbTfH7dD9zkhNvIRcYGza/HSPjcUSKX04BgZZbG+PaOmRm9Mrp2bm6h2O8/woebcs/LFLFqL0c7OF+FiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=FiSo08sA; arc=pass smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="FiSo08sA"
Received: by mail-pj2-f39.google.com with SMTP id 98e67ed59e1d1-3a49b6bb21eso498196a91.3
        for <linux-perf-users@vger.kernel.org>; Sun, 04 Oct 2026 12:56:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791143791; cv=none;
        d=google.com; s=arc-20260327;
        b=qalGMuRn8RV9Qp1vtbhqiVJ3WJN7oC5/dziKQjZF6MFDmi6WlWes4KJKY/T7EUbrpb
         1Hf6iD2wislPs3CDc6WHwk4mPzEwxP3cptLFeaad46dGtCYTaaDQ3rlAK5qLLOvvRMuP
         E8M3mI69UsbFhxSAGFLpVI9AGPHZXn/+OioAJxakDzSXZNiprJ7zXNWp8SomR755JpW8
         iJ6a4UN+q14axcL3zp/ZmQ2Ig8JMvZ5Qy3Tisrrjll3AUqXVFUkB82tpGe4qYnbcUz2K
         xPuuyi5v+uXXfQv+BoJjZzrR+dEhBtgztIrKOD4gljA4ZviCCByHuXfcECJUpUX66JHo
         KZSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rfGcP5S/SMntYoP2Pr+7iM7tILrMvCrH9eSgNIL7aCo=;
        fh=9SlmeBn821EcLAvY51W6guDFFVB2Rbg40c1xysg1mLc=;
        b=kq/j2upOfcnuBJ7iJU5pdWdQYihFY3lp7ZxIiUOP9FqEiVfOfCxJMQ2bWiANVoLsOr
         +aWeSkoXDYlRJeZz/DgHEsN2szwvq4Y8NcARdGbAYNVzIVNqCq49DScnnm0BDN9ECAMt
         SnIk2eSCRyQTfwTQ6DKdNIGdebs2BL3t3XjrFKfsOb6WmP5/WWFgcn5sQm3CghC2w7LQ
         ctempR5VLbP1YTVru1MRAgI5ui1r42fh51WLUbdbgGo7f6CxcpkLwN6+y6AewEPaGbnS
         S/4DVI/7lfqorq6ElSp1IQn2/PSqFmoE0Xp5MdP5OSZxPjaxD+2lS1XNGrIJkhLSu9Yi
         shIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1791143791; x=1791748591; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rfGcP5S/SMntYoP2Pr+7iM7tILrMvCrH9eSgNIL7aCo=;
        b=FiSo08sAA/SMEpt90/djtG3p122zAoW45IAec0wxGDWZE0bT4OmcE/ndbTqD1Ja5sv
         BRvcbG29RuJAvqRHBL7+cEN9P0ur3Iz/ftcNcB45ChLN6NXsg8zv84dVbgRyLp3gOGqf
         3EVStJ1okiPwdpU7PnvotXb0DCCvvafKXZKbHLSgNKZatno/EarbFRDNSPK442pr49M+
         nXfKYKntU87c8nOO4b4EDmnl1G4JeeCmWxMhWXZ1WJJRNLztLcmBKF1kNnwTlMw3/w3U
         GSMSg/3OKndPX1VQ9cY7bDUPlBKfg85Hpl4OhL6pB8KLhWR267O39uUfyjNc6gjK8a/l
         7utw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791143791; x=1791748591;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rfGcP5S/SMntYoP2Pr+7iM7tILrMvCrH9eSgNIL7aCo=;
        b=pFb9CxjrWZi3/Fx5kG9FvhlyJWXzwkfeg80weF9xapjsd/XI+/ydeQZof8uo0lE9ig
         TntrWI6c21DhVkexJhstFRUu6J3tZA99ZBrZ9ll2+oi7B9mRVBrlfgforBEBJIbaDWnt
         9lweoekdqCU7qkl6hLO+PsU2COP+Pqef55oF7jPj0HzKzBybailGpTdhCT+QkkhGspWL
         VKqdL+1pkGeY8thR2sFbQiYExgT1YbYpyNAMKuUadfFtXrUhru3f5Wx9bLYOulPqnu89
         c2bEVMWxeXSmkXJ9qI6CWG6JaYonqn6baBgmCg1z8OZfXXclL9F2LeSeHYM3XTKJUSb1
         /9xA==
X-Forwarded-Encrypted: i=1; AKwUvBwqfAGqa9oJ2F70NEXuBFy0a//6+saxCimG0558AnOoM1qW18qUL0GtrksypePFF+8MFNH3qTAMkrsTsvYLDDQS@vger.kernel.org
X-Gm-Message-State: AFq9FYLuMnB4CIawX1yxNLfra4NK8pD14/SOeXvb+v57VRcAuSZVsO16
	cAsusjtQtuocEsMA2qUModmvbi+iQ3cJUz1he5sNsMILJp6Nm5H5UR7DgOlbzl9VfKFLZ7KFv7k
	Vt8C3dwAzERBqVlJxrubgwOLSF/5KR12FwFJUkcxn
X-Gm-Gg: AYBFou2Ynn/1rDrK2B0GQu0+F3CETtITDyhqEprAF12g9YcQrCyTSSP1s6/sP+TsN5M
	k/42tR6xkjeOsdtsarJCOGwXNwv3XTUJ0gptEnaO7Y898SKAV/pyyjnUPVL6VCtnFNDCjy8jVNL
	zUhMFiuccFXzgLR5WToEpCYWdM4Qiu5ifyBO9gL8/8PtolsYyfsn/mNsBzcpbO69KpT3qnzg1kj
	wbmNpf3Fqb7t+Ip395yDWbQtORB+UPHOHq8GmilU1IL0C7wz6v5v0PUT8SYQHM0zpJyOqj8f+iN
	b7M/ByowNSNda+WVoSymehxq4eeD72eYpHJ+O8sQxLzlFC8YwUsD4SYMOwFeb9vozKDR5vFRdr0
	/24hwHZ4v9m0=
X-Received: by 2002:a17:902:e88f:b0:2dd:c100:7cc1 with SMTP id
 d9443c01a7336-2e49b6e3399mr77155665ad.61.1791143790665; Sun, 04 Oct 2026
 12:56:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930210038.196928-1-yzhao62@ncsu.edu> <20260930210038.196928-3-yzhao62@ncsu.edu>
 <20260930211057.2E1641F000FF@smtp.kernel.org> <asA1u7LBRp2gqbWI@google.com>
In-Reply-To: <asA1u7LBRp2gqbWI@google.com>
From: Yanbo Zhao <yzhao62@ncsu.edu>
Date: Sun, 4 Oct 2026 15:56:18 -0400
X-Gm-Features: AclHuK8azCsvMF2wtXn3kb6m8zEbWMVz8t3HFQY0Wks_POrbAr3mS2ZkyYlGXgQ
Message-ID: <CA+J8via_aVdUYdfJRut-9Yar5iEJExBnW9s8fyOHxW1705TrDg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] perf dwarf-aux: Add C++ vtable helpers
To: Namhyung Kim <namhyung@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

On Fri, Oct 02, 2026 at 03:52:43PM -0700, Namhyung Kim wrote:
> On Wed, Sep 30, 2026 at 09:10:56PM +0000, sashiko-bot@kernel.org wrote:
> > [Severity: Medium]
> > Does this code incorrectly skip valid primary base classes when parsing=
 DWARF 5?
> >
> > DWARF 5 allows DW_AT_virtuality to be present with the default value
> > DW_VIRTUALITY_none (0x00).
>
> Right, it'd be better to check the value of the attribute as well.

Will do.  I'll skip the base class only if the value is not
DW_VIRTUALITY_none.

> > [Severity: Medium]
> > Can this loop hang indefinitely when processing malformed DWARF?
>
> It seems sashiko is picky about possible recursions on invalid dwarf.
> As we recently added recursion depth limits, can you follow the
> convention and bail out if it detects one?

Sure.  I'll use MAX_TYPE_CHASE to bound the loops in
die_find_virtual_func() and die_get_vptr_class(), and bail out with a
debug message like the other places in v3.

Thanks,
Yanbo

On Fri, Oct 2, 2026 at 6:52=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Wed, Sep 30, 2026 at 09:10:56PM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential is=
sue(s) to consider:
> > - [Medium] perf dwarf-aux: DW_AT_virtuality presence check incorrectly =
skips non-virtual bases
> > - [Medium] perf dwarf-aux: infinite loop in C++ inheritance traversal o=
n malformed DWARF
> > --
> >
> > commit e1f1b87424c8d58d923a8c3fbc1408fa0ae0c3b9
> > Author: Yanbo Zhao <yzhao62@ncsu.edu>
> >
> > perf dwarf-aux: Add C++ vtable helpers
> >
> > Add DWARF helper functions needed to resolve C++ virtual function calls
> > statically in the data type profiling.
> >
> > > diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.=
c
> > > index eb4b8f3475df1..b1f3dca057abb 100644
> > > --- a/tools/perf/util/dwarf-aux.c
> > > +++ b/tools/perf/util/dwarf-aux.c
> > > @@ -2293,6 +2293,222 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *typ=
e_die, int offset,
> > > [ ... ]
> > > +static int __die_find_primary_base_cb(Dwarf_Die *die_mem, void *arg =
__maybe_unused)
> > > +{
> > > +   Dwarf_Attribute attr;
> > > +   Dwarf_Die base_die, vptr_die;
> > > +   Dwarf_Word loc;
> > > +
> > > +   if (dwarf_tag(die_mem) !=3D DW_TAG_inheritance)
> > > +           return DIE_FIND_CB_SIBLING;
> > > +
> > > +   if (dwarf_attr_integrate(die_mem, DW_AT_virtuality, &attr))
> > > +           return DIE_FIND_CB_SIBLING;
> >
> > [Severity: Medium]
> > Does this code incorrectly skip valid primary base classes when parsing=
 DWARF 5?
> >
> > DWARF 5 allows DW_AT_virtuality to be present with the default value
> > DW_VIRTUALITY_none (0x00).
> >
> > If a compiler explicitly emits this default value, will the presence ch=
eck
> > evaluate to true and falsely identify the non-virtual base as virtual,
> > skipping it?
>
> Right, it'd be better to check the value of the attribute as well.
>
> >
> > > +
> > > +   if (die_get_data_member_location(die_mem, &loc) < 0 || loc !=3D 0=
)
> > > [ ... ]
> > > +Dwarf_Die *die_find_virtual_func(Dwarf_Die *class_die, int index,
> > > +                            Dwarf_Die *die_mem)
> > > +{
> > > +   Dwarf_Die cur_die =3D *class_die;
> > > +   Dwarf_Die base_die;
> > > +
> > > +   while (die_is_compound_type(&cur_die)) {
> >
> > [Severity: Medium]
> > Can this loop hang indefinitely when processing malformed DWARF?
> >
> > If a maliciously crafted or malformed DWARF file contains cyclic inheri=
tance,
> > die_get_real_type() resolves the type back to the current class.
> >
> > Since the loop does not maintain a depth counter or cycle detection, do=
es it
> > spin infinitely as it re-evaluates the same class type?
>
> It seems sashiko is picky about possible recursions on invalid dwarf.
> As we recently added recursion depth limits, can you follow the
> convention and bail out if it detects one?
>
> >
> > > +           if (die_find_child(&cur_die, __die_find_virtual_func_cb,
> > > +                              (void *)(long)index, die_mem))
> > > +                   return die_mem;
> > > [ ... ]
> > > +Dwarf_Die *die_get_vptr_class(Dwarf_Die *type_die, int offset,
> > > +                         Dwarf_Die *die_mem)
> > > +{
> > > +   Dwarf_Die class_die =3D *type_die;
> > > +   Dwarf_Die vptr_class =3D *type_die;
> > > +   Dwarf_Die member_die, mb_type;
> > > +   Dwarf_Word loc;
> > > +
> > > +   while (die_is_compound_type(&class_die)) {
> >
> > [Severity: Medium]
> > Similarly, does this loop also lack a depth limit or cycle detection wh=
en
> > traversing base class subobjects dynamically, risking infinite cycles o=
n
> > malformed DWARF?
>
> Ditto.
>
> Thanks,
> Namhyung
>
> >
> > > +           if (die_find_child(&class_die, __die_find_member_offset_c=
b,
> > > +                              (void *)(long)offset, &member_die) =3D=
=3D NULL)
> > > +                   return NULL;
> >
> > --
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930210038.=
196928-1-yzhao62@ncsu.edu?part=3D2
