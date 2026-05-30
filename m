Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890EA2BDC0E
	for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780168879; cv=pass; b=B3yAsICB/bj90fV2IyT1gU9Cir4vmmnp2hxJC4NJ8o6JNPBahYWWlKdd6DFbYZ7TnmXzZwadkH+6XZyzy5yg25QVPxgjTwg07L9bozNw4Zz9juisYETlsFNl9Xska6B9WBYInOU3xwGmZtAgV084JEMTWo397KEjmb+RkfJK3tM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780168879; c=relaxed/simple;
	bh=JBbY23VLzr7UTA/IuwMS3GsOoIkG4M0mGFC5/+VyNkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DTfzqRWcoTbaxkcJvegBQdZxyAN7uxubqgDMh2iNvl2hZ43QSE5AClAQB9i3OZ8OukFX7TE9AsdBzvsHXDE99RopnRP/wyXnZar5Zrv4upjXgDpG7C4G7ypOV4f0RCTJJfnbzUXg4AZhmiFAthJA230EbyD0coVF71IGBDh8Os0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cak1ofO2; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cak1ofO2"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e636d1bedbso5246889a34.0
        for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 12:21:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780168875; cv=none;
        d=google.com; s=arc-20240605;
        b=jaYsMY3tvPkLP5Ttn28R6jXkVxszksP9W0iXgk4c5X06vc+P658QhJ5pAYlsKZlXVZ
         L1kv23BI33JW3ci8MNDZcxtNRsa6hBchgbk1SGaKtETBMq7aVUvgyFJdzBj3hUSsmnhq
         zzvYJv9ijA4iN4rFRGyZBy53honJzWHoOKE5CgukZ9JIp5gjtsQK3xVmC43M9qPL47U5
         mr7+cwvsOynxlqgtuRlqhPr3/mYBDOMA5huwjaSSUEj4eGKi2kgO40k3kdgVUjxC5ml1
         a14QNKevc6u/5/ojnTkSh9kszMCWn9mQOwKYQBHUXevbcpxtpyBqEEuaCA8BXqlyGx9s
         9tUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OV2fwopur6+ZLoKlvbHioBItO6Jx7w6IvPcKRJq8eAA=;
        fh=0iaor0J0ogBQLqyCPgweM0GtmgCYg8CzwrkNFvFFICI=;
        b=hZ2UZYVxXd37uVYtzGA3ihxpoJ6naX/0FXYR+vZRMUU4fbqVCUOuVsBsYYSQBBsn99
         A5tlbu1au9XetSC+R8LTLb9NyJBmYrHRe8CAxkTa/dDzBIURTwL841aOGmPrAcviYJL8
         Ba1Oc7MHR36waDpvU9PcdeOVkW9lDTRKb8zolgc2umIdMsDjQugdh01dEqeoTLjlQYNQ
         SV7B2BR8IoKoz41qRNW5Zp52+a2DpEqjZk1/NZS3eZkl4lt23aUsArmqdOTwpfGd6V2R
         qo2DQOdffAJyegl2qoslDnuIx9+bWHajrnMyE6sB8yh3IPqxsT798bdQYuGlodNeHoCX
         7clQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780168875; x=1780773675; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OV2fwopur6+ZLoKlvbHioBItO6Jx7w6IvPcKRJq8eAA=;
        b=cak1ofO2RfAwkYotkZFdjCgYHfaFxHIJhyN/ipD6+Npw9l0Zsal7lECWl9F4onPUeT
         HtHnIpzyWEbcl8Sjze5INikV0yl9FZZXLPcDsi1qi8o2xgrlM3sIjoSjA24wVqSSzjo5
         mIrr1y0iOrxICp5BksHKW7R707/m4Vyo55Js1C2MZ/DOxaKVEMI76HRNzgnh4ic0flOD
         z58SWRCLbbG3NNGUKrRwgSeQn0vyofb4inI+kmzHqRkZpI67v1d48pk9UgZNZ/Up+C5K
         1Jelck+mrdFCXB8yL49wlHHUYMmNX74SKn5bzqrNXOYAYJ3p8jE18IFfi5N1MWIlQwcY
         GvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780168875; x=1780773675;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OV2fwopur6+ZLoKlvbHioBItO6Jx7w6IvPcKRJq8eAA=;
        b=W4dizLA2f/wnzbNzp7qbtt5U6WdFnxVZV8BrOV8+rYxmEOKUN6UWFatVfvmkqdyhXi
         dB4ozyvFSlYt5OAEt/7Sj2IWJyH9aQLe/FlpyRMq/8YQezAkAGhrQs/awsGmaMiIpa6N
         0W1tt/ppQKIizdgwcsS+wfRLMnI8beA/OTjST8C8Hmy13Dj61+1Guam23DfSWaa5cTtx
         NaVBadwGwFv3mEjZCH9z/CZ+gdPApOhB8n65gq7MfJcpF1rVizOFL/nFeewaVP2WE3HZ
         EFdb0bLJjRbaNEbv8CEWAPjLv8NrxgLaBmf6Rr+rgnlji8yyfozmB80DV+uYA4qRUVbh
         fuTw==
X-Forwarded-Encrypted: i=1; AFNElJ8U0PaYc7q0ebEePJJjlzO4TNkRbC6WgdOpC3WejZaYzPH3/j2vkbzzPYkkLhxzxIYcByNoKSBqcWKe4z9NzWbc@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu54GaxMGVp749i7bsYN5xRVPmsFOJ5z2R+S7Sdj/AWAxJ5IrF
	FiEM2pZBoNz7HGQ8Z7XW+2WWLQB2LI4CK4nHvqjn91hXXtafNhw5owWI648GYRkw6vLFCttTZ6S
	SR1/cpXllV86yOiJHntqLWW/JSj/8edE=
X-Gm-Gg: Acq92OGqmVuKzZUEXgVowS6/ezj/9bz9O/I7kGXHnNAo3sy0eYr9XawzIr3jKE1faUK
	dhpnBh59eyLp1sCpWbH7s/tCgeABlOVVqOUDLTpiuTbSUjnzba3yYH0dTLppYz5M2f0KrLu7AFk
	wtkZETQhrdxI4kD7hEx85+nuUzJjOHiZr83koI/l181zX8mwwHIc0Acekftb2cNR3pQVtO+AdPx
	k2p55HDElD5yUgjUxhp6bmTaAuBtHh45niW6sSa0TcbmrqpJvEZOhJfAC7lKWF1VG71Z3Xs9abf
	f3DhAykopfM9pSpVpD04
X-Received: by 2002:a05:6830:6681:b0:7de:477c:9799 with SMTP id
 46e09a7af769-7e6a1dc4ad5mr3162146a34.15.1780168875317; Sat, 30 May 2026
 12:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507184238.65280-2-suchitkarunakaran@gmail.com>
 <20260507234959.EEC5BC2BCB8@smtp.kernel.org> <agAqESWvLdIJBErN@google.com>
 <agZgPBrlKZ655KdO@x1> <agq3PCt_FhxIYgQ8@google.com> <ahoqS-hZDkAluO5a@x1>
In-Reply-To: <ahoqS-hZDkAluO5a@x1>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Sun, 31 May 2026 00:51:03 +0530
X-Gm-Features: AVHnY4JLijZIElElgE9i3KRQV2LweikX4CquHZOzoihGyT7FEgWhWkVlbLJrM0k
Message-ID: <CAO9wTFiNVphYwr2sBHXh4-pPLG4jkqUyCRsk6UqrQJG55Fc1qA@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf build: compile BPF skeletons with -mcpu=v3
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 May 2026 at 05:37, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> On Sun, May 17, 2026 at 11:52:44PM -0700, Namhyung Kim wrote:
> > On Thu, May 14, 2026 at 08:52:28PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Sat, May 09, 2026 at 11:47:45PM -0700, Namhyung Kim wrote:
> > > > Hi Arnaldo,
> > > >
> > > > On Thu, May 07, 2026 at 11:49:59PM +0000, sashiko-bot@kernel.org wrote:
> > > > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > > > - [High] Adding `-mcpu=v3` to `CLANG_OPTIONS` forces all BPF skeletons to use the BPF v3 ISA, breaking backward compatibility for perf tools designed to run on older kernels.
> > > > > --
> > > > >
> > > > > commit 2e8791aeccf694e1ae9ed9fda46e3a6f73332838
> > > > > Author: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> > > > >
> > > > > perf build: compile BPF skeletons with -mcpu=v3
> > > > >
> > > > > This commit adds -mcpu=v3 to CLANG_OPTIONS to support the atomic
> > > > > cmpxchg instruction required by the lock_contention BPF program.
> > > > > This forces Clang to emit BPF ISA v3 instructions during skeleton
> > > > > compilation.
> > > > >
> > > > > > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > > > > > index cee19c923c060..a9a8c84b6b006 100644
> > > > > > --- a/tools/perf/Makefile.perf
> > > > > > +++ b/tools/perf/Makefile.perf
> > > > >
> > > > > [ ... ]
> > > > >
> > > > > > @@ -1195,7 +1195,7 @@ ifneq ($(CROSS_COMPILE),)
> > > > > >  CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
> > > > > >  endif
> > > > > >
> > > > > > -CLANG_OPTIONS = -Wall
> > > > > > +CLANG_OPTIONS = -Wall -mcpu=v3
> > > > >
> > > > > Does this change break backward compatibility for other perf tools running
> > > > > on older kernels?
> > > > >
> > > > > Since CLANG_OPTIONS is used in the pattern rule for compiling all BPF
> > > > > skeletons, this forces every BPF program in perf (such as
> > > > > augmented_raw_syscalls.bpf.c and off_cpu.bpf.c) to target the BPF ISA v3.
> > > > >
> > > > > Kernels older than 5.1 do not support v3 instructions and will reject
> > > > > these programs during the verifier load phase.
> > > >
> > > > I think it's old enough and we can move on to ensure v3 instructions.
> > >
> > > Can I take this as an Reviewed-by or Acked-by?
> >
> > Yep,
> >
> > Reviewed-by: Namhyung Kim <namhyung@kernel.org>
>
> So this got refactored, Suchit, can you take a look at perf-tools-next
> to see what is needed to have this in place after Ian's changes?
>
> Thanks in advance,
>
> - Arnaldo

Hi Arnaldo. Sure, I'll take a look at perf-tools-next and send a
revised version.
