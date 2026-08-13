Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8C4271456
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786628704; cv=pass; b=q4e+7yhUpbk9qE2BWfu2P3FWTCHke0upj9R82B/UmFkj5sZdLaMfAJmc1Cr5sAEkreUzoKOvZM3IyJTA9xa94O964J1vsl8XYhbG4gkvbW+MVwEPkAECizwYWYbJmlah4q5lbtT23bCqrXPbtgXwzkjfl5nngvIxgu6w2ToQODc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786628704; c=relaxed/simple;
	bh=y51AsQCt+cQd6BVFmDglntlmJpaPmEROcJgfxhrowTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRoVIIwzaZocXNvS/Mb/ExDuUmMPOwN1YYBZ376kO49Y2I8xUk6AqgAsbxk3qs7LHh1EWLCDLrICrWINPE5OBOxrO7w1eFz3mBoJ8LdN/oozzVkIlC67PH+PErRbs3w5Wj2mTvh45aTctv2Y8Uj/JEheIip7BXl+HMA0yiOs/3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fMt0aVuT; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fMt0aVuT"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c15a5b265so237651cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 06:45:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786628702; cv=none;
        d=google.com; s=arc-20260327;
        b=ntcbQaMTJDfI84J7EPaT3oabiIyB5ZwpchuNeubvZoImtP69J5olktsGX43Tj/WZeh
         rp5QVX6hyuoumBQuhQLRo/djF+f13oeBdhKvFfHfzpeoxrnIwuonFq/FpcATqj0GnRPe
         G6hohGTXElFDBcPPK4YaYFRaTaP1OGmlGoPUiB7ainqvwS1YqalWKa+KMxYAadt17PPN
         /72L/skmoHu1M/GDy1/s1g+qlxLAge/aFvljLkQfkR+6/5L7fJSqT3TsSXOKZBZUjt8c
         CRgUpY6b6AcD1dqmsrpc9vyltF5j30l2NuvaAzhIY861esag4iaWSjPl9we5erG/o0Aw
         8LgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9+HPC3+AUFbQ7Y0T+7bHOfa1aSDywdsqW2vFh63jDrA=;
        fh=wXi+XmK/w2n/Sg+31EmPpXSp/Y8afBzk8dK2vSBSjro=;
        b=eCwzSSCxUBEjczb8P0BIyj2n2xVo8XwH/S4M1xBk7rviMRLJqXNnoHhBLkbheNWJvO
         VWannj+hGSjrTDfRAO0piBQL4aevsTlq10VkLI0iswS9CGlGZbIolThihvHjSusEOijs
         uJezHNqOWmvRpyNrUyE3r/2nz6yM3PA0wUDp1mCR7xjERpLBG+betYUkldszYa8X+isS
         ig+ewgd/QBOG325Q1C7Y6E1E9T8jwbe4ikylP0UBpRUISv4B45WsMU9p0y0lHUOljM0A
         /YZ/vjJ1yn2NNlgBjSGvmdnDLf5wFlAkvqvNUVMyl7hT6H6fe7zoxxo0+G44+RXGJbW/
         yDDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786628702; x=1787233502; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9+HPC3+AUFbQ7Y0T+7bHOfa1aSDywdsqW2vFh63jDrA=;
        b=fMt0aVuTcq0PAiuLP1JZrdtP3OAMNTckfkoGGdQcKIeqM0Gw4UiJltdcM2xo/55KKr
         IL6gCp6PjGNoKwsDlTIGiZJj5vyUqsRpyUuXcVy3Y6vqV9fkzgBWKyz+2gOSGGkDbwnq
         MjgRIt3M8Ezo1Hp3RCuG3CM5fTZJ+CBUJmCZVDHsNhVLKbilXQqbbWhRqCD47BEcMhdE
         /3XvwOv1raZZiWRRmW7ghjqwsfZxC7DeBxoxFJoOIJBRzdDpG65TNVtAyPx4Uv9MMDER
         0BGcfVMRmABkymZjBRMzSwIZO2dTBn3k31Dl5Ze4cl6P0uu8mOVcTljbh+FBtve0Qs9H
         mn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786628702; x=1787233502;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9+HPC3+AUFbQ7Y0T+7bHOfa1aSDywdsqW2vFh63jDrA=;
        b=OB84VOGDCPNLQRVZgho7miFMAL/H6uxLr8/nW9McSQpmzG85/YGmOnVEpswkG0bJa3
         rs/NgkmlEWLxdBRL2jJcuB3R21DCJYj/v5aLKxQiludgi7irnOv3aT2HETmvE2H03dt7
         IPRv4blGwVgDvklzybpoWCRSapacMTlkEl1hjUA7bCCtxnW/gpqd2L8D5bWvMaNKih9v
         pauRelMaGnlkNZTbwRqTh9A896wDEaVIH0Hcfu6kHkAppakMr6Av899oimDVgsytGHpB
         M1PCSCulovjhE3QVDZNK3qfkcM5H4KTvMxu3Oqfu1kPkQMVTL6ny5E7gXa8dY/++wWDo
         A0KQ==
X-Gm-Message-State: AOJu0Yz9lWbobN/Lo4yRf5zjhLRQgMOtuvphmOA79huNbsiTra3TwlQY
	31RMK9UjL3HPb5OyHCfh3RuITeKY/Uw6PANeZgb4Bm/Kqdewjs2vWqaohZ16/ya4TiFdqatoZ9k
	6p/egEJA9SJSLq316ZykbhukR+Q1S67Fw5HGRZZd7
X-Gm-Gg: AR+sD12knmPKq3kSOILx90Wy6clfSPx6i7Tc1+p7XPWJOZbiTvoEH3Or67tt2mKSVNn
	CmpEy2lCgGeleD26kXovCrk6NlQmWthYefae4GtFB//Fwjam8UiKII1hR81egqu1K9WImN1yhnA
	I0FnO4DUVpISdNW8jOzOZznEmaIz0T1NDCZ1+K79aBY8BFZnk8V9/DAJNuCKRkJCfIIGIAqI8k7
	ciHv0Mo3JJHdYUCiX8lTl+Relf1TugZhHvsy9bClxRibNmphJtYYHCtr0mt4iccST9XGFrFJn6+
	M1Z3kO8qoh6oWyvt7Q4HJx8ZBqPHkyyxFNZbI1fiT8j1JQ==
X-Received: by 2002:a05:622a:1341:b0:516:ccc0:ee38 with SMTP id
 d75a77b69052e-52d76df7793mr2133191cf.9.1786628701050; Thu, 13 Aug 2026
 06:45:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812002728.2283079-1-irogers@google.com> <20260812052417.2361040-1-irogers@google.com>
 <anwuYYxLFbtDmmHx@willie-the-truck> <CAP-5=fW9bH_yd2VF+X1jnem91+dOHPjP53uNQ8x69xFmjLbt4g@mail.gmail.com>
 <an2DHgfQsQ6TOF44@willie-the-truck>
In-Reply-To: <an2DHgfQsQ6TOF44@willie-the-truck>
From: Ian Rogers <irogers@google.com>
Date: Thu, 13 Aug 2026 06:44:48 -0700
X-Gm-Features: AUfX_my-v7duLndJmy2k7kBJAwkUqkIybxSl67HmWKvBg4-_7qLXe33jwdYgudA
Message-ID: <CAP-5=fVOzmzxO2X4+r9goRxtwtWqdR15kPBP9ApSjuP2u6p7Cw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] perf: Add Raspberry Pi AXI PMU driver
To: Will Deacon <will@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mark.rutland@arm.com, u.kleine-koenig@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 1:41=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Wed, Aug 12, 2026 at 06:38:24AM -0700, Ian Rogers wrote:
> > On Wed, Aug 12, 2026 at 1:27=E2=80=AFAM Will Deacon <will@kernel.org> w=
rote:
> > >
> > > On Tue, Aug 11, 2026 at 10:24:15PM -0700, Ian Rogers wrote:
> > > > This patch series adds an uncore Performance Monitoring Unit (PMU) =
driver
> > > > for Broadcom AXI system and VideoCore VPU performance monitors foun=
d on
> > > > Raspberry Pi SoCs (BCM2835 through BCM2712 / Raspberry Pi 1 through=
 5).
> > >
> > > Why are you sending four versions of this patch series, at -rc7, each=
 in
> > > reply to the previous one? Nobody is going to review that.
> >
> > See the cover letter for changes. They address the sashiko reviews,
> > you may not see these reviews as they are only sent to me and
> > linux-perf-users, which is somewhat customary in the sashiko setup.
>
> Have you considered running Sashiko locally given that you work at Google=
?

Yes I do. If you look at the changes you will notice that more issues
are being resolved per version than the issues raised by Sashiko.
Unfortunately, factors like the model, context window and just the
inherent non-determinism of AI mean that AI reviews generate a
firehose of suggestions that you can't reproduce either remotely or
locally.

> > I don't see any relevance in rc7, I'm just mailing out a new driver
> > now that I have the opportunity to look at it. Whether and when it
> > gets pulled upstream is up to a maintainer.
>
> Right, as the maintainer for drivers/perf/ and I'm just asking you to
> slow down a bit. I don't need 10 versions of a patch series in two days
> when I'm focussed almost entirely on the upcoming merge window, which
> this is too late for. You should read
> Documentation/process/submitting-patches.rst which states:
>
>   | Wait for a minimum of one week before resubmitting

That's not what it says:
https://www.kernel.org/doc/Documentation/process/submitting-patches.rst
"""
Once upon a time, patches used to disappear into the void without comment,
but the development process works more smoothly than that now.  You should
receive comments within a few weeks (typically 2-3); if that does not
happen, make sure that you have sent your patches to the right place.
Wait for a minimum of one week before resubmitting or pinging reviewers
- possibly longer during busy times like merge windows.
"""

That discusses pinging or resending the same patch version. It also
lacks language around AI reviews where a response in less than an hour
is now the norm, but anyway. Spending 3 months on this series would be
ridiculous.

> > The changes are sent in reply to each other because the entire series
> > is visible in one mailbox (b4 mbox), which I find easier to work with
> > and provides me better context. Others use semcode to do something
> > similar, but I've not explored that.
>
> Unfortunately, this tends to confuse b4 when applying the patches and
> makes it really hard to manage on the maintainers' side. I think this
> is also documented in Documentation/process/submitting-patches.rst so
> please do what everybody else does.

I work with b4 without issue using this approach.

> > Let me know if I should drop you from the cc, I placed you there as
> > Mark and you were the only suggested reviewers from
> > scripts/get_maintainer.pl but I don't want to spam uninterested
> > people.
>
> It depends if you want the patches merged...
>
> For now, I'm ctrl+d'ing the thread.

Tbh, this seems to be a theme so I'm not surprised. I guess thank you
for noticing I sent a patch.

Ian

> Will
