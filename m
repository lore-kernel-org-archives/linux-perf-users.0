Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2B047142E
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 19:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791143711; cv=pass; b=XrwFUUJ+2V6E+WitYCoGe/rBcJaIq7rVB7CCmgH6sy+S8qbzyNxqRD0JaAySWgY3XWmg8P0ue56KHQg30SqZO6rYAjIrb6PygAsJ3HTrI81AylDGtfZYeMJtZhvBDumDL+3P5M7+8mam6UYANREJj/dkp+PV5n/kxL6G81XnHyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791143711; c=relaxed/simple;
	bh=Jh7QrlOttp/hJOGnDhr5dP/akcAxUwVLAJfz5fQRGrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tliwtDYKbOZgKfDEax6/Of8Twjv0gdJOR38wruOKiHPMHJLApNNJcnWIv5OSpuESyi0aO83C2f7/uYuDPRThlgLPvTquhLhHOaVvYvfCQvtVmXQ1hSht/cPTBQ6h26A0CYuCZNJtUjX8uKVjgnOMQOo9Z4fO3+RKSTnmS4duews=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=GxcfUGHa; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="GxcfUGHa"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e4a341d177so6345685ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 04 Oct 2026 12:55:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791143708; cv=none;
        d=google.com; s=arc-20260327;
        b=iNc2/hkVZ1uXRWkMDVO7Ccrq09ucPsUJtyrp4A7IpcfTe3Nv7fIbqAYD6tNbljFcqV
         wBzj3wO6AFkM98tCZqXmyZVBQ/UHg5ON2NDntWOU0VpufT9PbLZEub6nYbHPy7EvXANT
         dy+usi4Uz4YYFxA1k68gQmDZDw8oOLc9MulavUqqbeZUxJp+go1uy+4C0pCfmHwju1dW
         CuK5HPekvPzp7Mi0IGCCJjaE3FXdK5CnSEswKQIJl+DQOLHrtFrLtcGkZZOkt6RqE/33
         oBFPPu0UIkWoPbN0o5pRENTXwLgTN6/N2sRZpZDtDEv9uaOiantxCM2ORNsaiprEaKqU
         bPvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P6RFZCyUChiX/tp/C+y/RH4dV99Sf5c60j1c6Xm2mKQ=;
        fh=B/YNpWXB6prln9A3FcBgFX1njmDV/akXvaplpPEELro=;
        b=BHE3py9G91p0onleZLynCDPIS5ZdFoVIpOSWk+SxVGFcri+DC11BwUQO9J3KZR2g5b
         LVlEd4Cu8HfMi5J1jhmfTCNYktoYIxlr0rAuqgSB+NxTwUerP2+bFP2gBsmrvovFO0GL
         7dO9oWbAsqwGVY4tTcsubm78Yr5lkPiex0gIeGA7U0eiSCura0OAnmIcvl1cqRsq6dKG
         VGGRM5rAodx8tCBZV0WgQ/Z37pzViBgsBIdjs1KFgqFf/ITr08djeYlJW4LItRNXskkG
         GjZfVNHGKJLkR19h962GOyPXHNiExy2AedTYWuoT9nBxMB3o1ey9lI1kE4cR7tDx/fOi
         rdOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1791143708; x=1791748508; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P6RFZCyUChiX/tp/C+y/RH4dV99Sf5c60j1c6Xm2mKQ=;
        b=GxcfUGHacyEcXVmAQ++ZXlnjvuqYZpE9LjzLXPkyzhmY1uor33veceaX8jw58zcOb3
         6THoGGaF+89oOPkIfDzRlBUKLEB+Fd/gkxJSZ7CQpv1KSqvtnqoKk+SA7fYQLLqfPp2D
         TXp9g+rAKDNd6XOX7moAcssiIdwc7iB/ZFlY4435/tM4PLwUKdqx1f1b+JBkI0PnU+B4
         lxR6Yq/dI/4SW3S2OWyQbqV5nAqdXwE879o3N5mZn3QVtmEGaFP2oxh4DrNoc5kk6xFq
         YyoItMLRb0jcvVJ6ay9GzpLEwhAUNcT9gV3M3mIb2ulsq998sQ4X4qFlyqzjv+OK8QIN
         DUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791143708; x=1791748508;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P6RFZCyUChiX/tp/C+y/RH4dV99Sf5c60j1c6Xm2mKQ=;
        b=SEWk4YIkg2COL3THyk98xHPIIJkbyEUK5YiwBHsKgX2jsQMAzpwL9fJwMIzmXhKste
         2LHLV66SlvzshG8I5SzR5vThLpsj2KgDobxT/yHt33KdOzjQVZO5oJ1lfXkGhI7GV86a
         PX7mIgvgu4rBbRwl/qIr/piH1pHDOaF3c6BqeEB8gKOsvETUnUOQ9Ju0vt6BYyfXIcER
         BxdzV9hB3EHUgwvTx7hKaopBAF2skVq2fv8Djlawi1EeT9YX7ZPyOxJfYOeyLgPFtS7h
         VNUbwwZgsa6VdVL+TRcX8eML22aqL7AAC7APBLMjb4yw1U2+0Kx3kcuK95YBFklbEOyy
         F4ig==
X-Forwarded-Encrypted: i=1; AKwUvByaLWYwbB35tsL/hTCOjoZGTVDFyhji1MkVQN4e6qsuo9KI7U0XA0ugOYWT6iwf3XBDK7lZRcx933hHFtnXR3fC@vger.kernel.org
X-Gm-Message-State: AFq9FYJKji6TR+ZKCrL1Kwc6vhPrs9D05oxU5U1VtjSmzLm6pOdAd2bR
	+Hz4KIAePW1/lSw3IyOvUeSimS7MiWkvggglV0QoIOTdIUSrrGsQOd125KijRkIEdPGUCNMHZWF
	OHC1jXHJPU0ft7+gKcNvEHPuA75vAysO/ciaENKBW
X-Gm-Gg: AYBFou3kBPhij6WurylARKEHBZrjNGizlv7ifj9AkfQga3zyubIuaU3zjTmtczcgWS2
	xIWGYnZC4h8bzrx3vLDz2dsq25YDWcHHJSt7SBV02Da+hEW9swyiLvh0F/P/0qcUqv8r4DphkJE
	CWFOebOoF8IR7wVGmufzTiOkf4jawLd46PRtIDvi9CbzKKvEdDpQgbCOo/jH92UMGer2rS6rJ3/
	WuXjA2VoCQZpJKaWmoq3ByHPPnJGfo9l++RYw5yuL5u1vWEBOw3+7BjUGZrYsCc4saReDYv1wIs
	VnMPYjzRjsm4Eh9fY3C2SGBaroT9hpGnwzxEfw5M3wCEe+a2I9CcN2ql6+ZHRSbhh/NKWk5mrel
	xUdzcntt/kB4=
X-Received: by 2002:a17:903:3df4:b0:2df:a4d8:579e with SMTP id
 d9443c01a7336-2e5106355d6mr37437385ad.45.1791143707699; Sun, 04 Oct 2026
 12:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930210038.196928-1-yzhao62@ncsu.edu> <20260930210038.196928-2-yzhao62@ncsu.edu>
 <20260930211051.8EFDA1F000FF@smtp.kernel.org> <ar6i_ZKXNVZmze2r@google.com> <ar_dGYiNoo04-OEK@x2>
In-Reply-To: <ar_dGYiNoo04-OEK@x2>
From: Yanbo Zhao <yzhao62@ncsu.edu>
Date: Sun, 4 Oct 2026 15:54:55 -0400
X-Gm-Features: AclHuK_fTdiCh8dZTLaIHxhK9TmQN-VSQrMo_UjkUH2Z6NvvPB4Ss4Mw7_KN0uo
Message-ID: <CA+J8vibQxdKXpqstnv0+BGpwn7dd_E_kQS5GE9dCyR47--da5w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] perf dwarf-aux: Add die_is_compound_type() to
 handle C++ class types
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, sashiko-reviews@lists.linux.dev, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Arnaldo and Namhyung,

On Fri, Oct 02, 2026 at 06:34:33PM +0200, Arnaldo Carvalho de Melo wrote:
> On Thu, Oct 01, 2026 at 11:14:21AM -0700, Namhyung Kim wrote:
> > IIUC C++ officially doesn't support flexible arrays and there are
> > better alternatives so I guess it's rare to see them in C++ classes.
> > Maybe it's ok to ignore them until we find it's really needed.
>
> ok on both counts, there is another patch with a Sashiko report, can you
> guys reply to that one as well?

Thanks for the review.  I agree with both, so I'll leave this patch as
is.

For the recursion in __die_find_member_offset_cb(), the callback needs
to carry the depth in its argument.  I'll send it as a separate patch
on top of this series.

I will reply to the reports for the patch 2 and 3 as well and send v3
with the changes in those two patches, and there will be no change in
this one.

Thanks,
Yanbo

On Fri, Oct 2, 2026 at 12:34=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Oct 01, 2026 at 11:14:21AM -0700, Namhyung Kim wrote:
> > On Wed, Sep 30, 2026 at 09:10:51PM +0000, sashiko-bot@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 2 potential =
issue(s) to consider:
> > > - [High] perf/dwarf-aux: stack overflow in __die_find_member_offset_c=
b via cyclic inheritance
> > > - [Medium] perf/dwarf-aux: flex array detection fails for C++ classes
> > > --
> > >
> > > commit 3f3b9b56b2e28f1713af3b40ab8946d5bbc8d245
> > > Author: Yanbo Zhao <yzhao62@ncsu.edu>
> > >
> > > perf dwarf-aux: Add die_is_compound_type() to handle C++ class types
> > >
> > > This commit introduces die_is_compound_type() to support C++ classes =
alongside
> > > structs and unions. It also updates offset lookups to descend into ba=
se class
> > > subobjects using DW_TAG_inheritance entries.
> > >
> > > > diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-au=
x.c
> > > > index 54f8b5ec74a2f..eb4b8f3475df1 100644
> > > > --- a/tools/perf/util/dwarf-aux.c
> > > > +++ b/tools/perf/util/dwarf-aux.c
> > > > @@ -61,6 +61,14 @@ const char *cu_get_comp_dir(Dwarf_Die *cu_die)
> > > >   return dwarf_formstring(&attr);
> > > >  }
> > > >
> > > > +bool die_is_compound_type(Dwarf_Die *type_die)
> > > > +{
> > > > + int tag =3D dwarf_tag(type_die);
> > > > +
> > > > + return tag =3D=3D DW_TAG_structure_type || tag =3D=3D DW_TAG_unio=
n_type ||
> > > > +        tag =3D=3D DW_TAG_class_type;
> > > > +}
> > >
> > > [Severity: Medium]
> > > Does die_has_flex_array_recurse() also need to be updated to use this=
 new
> > > helper?
> > >
> > > If we look at die_has_flex_array_recurse() in tools/perf/util/dwarf-a=
ux.c,
> > > it currently forces flex array detection to return false for C++ clas=
ses
> > > because it explicitly ignores DW_TAG_class_type:
> > >
> > >     if (tag !=3D DW_TAG_structure_type && tag !=3D DW_TAG_union_type)
> > >         return false;
> > >     ...
> > >     if (tag =3D=3D DW_TAG_structure_type && found) {
> > >         if (is_flex_array_member(&last_mb))
> > >             return true;
> > >
> > > Could this cause accesses to flex array members inside C++ classes to=
 be
> > > wrongly rejected as out-of-bounds?
>
> > IIUC C++ officially doesn't support flexible arrays and there are
> > better alternatives so I guess it's rare to see them in C++ classes.
> > Maybe it's ok to ignore them until we find it's really needed.
>
> ok on both counts, there is another patch with a Sashiko report, can you
> guys reply to that one as well?
>
> Thanks,
>
> - Arnaldo
