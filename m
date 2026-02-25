Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5205A299AB1
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Feb 2026 06:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002123; cv=pass; b=S+LfdsRSXpU5OqZ8np4sRoDnVe3GhirXgrrvFsragZn+RbwO7lgoyvIeIdGU+FORqaFlz4ExnTM5m0cSShvAl/6nP4/oIJMCLHasPYZQVlr6CQY72sT0LB4BYuXEmZGq+Ytijv9kYvbzXOgQEMCVxR1SiR58MOsMcpCxLqtrEww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002123; c=relaxed/simple;
	bh=bazJDGBGIMAUx3oqaC9l1I5+Jf0tEIuN88T64t3EkHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxFfqmddQABH6Dx93R9tJtaqG2AGulpwBW+A0HVQXjmNSyw22F0oqN0fQA0NYfoZz0kQbF4afwMH9RoIRjwJvCHEr4DHFVOK+J7Bn1iD4sfZl62wE6hPV/uIHmtzeGxHEpjLyd8/gcBJ+XRs3cXKmkrfSuRoflHWu+lxDWJ9kqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhZt+Rtx; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhZt+Rtx"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-899b08be919so10553816d6.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Feb 2026 22:48:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772002121; cv=none;
        d=google.com; s=arc-20240605;
        b=CnA+edvM/WWl3dL3sjIA61XzZkahdpUE+nc+sUFveANyFjyBJG8WoTIoHf8ugL4v1U
         c0gWEm/l7vp7qVH2bm0J7OWbSXlH+TWiCn4pdYdZunnLYkQ/wpOXijH0+RMe3awg6XNn
         /ifvoUy/RTIHO5Hjauky5XeQOevUwj3Z2M3dXu27il0xO2K/r6whPMDyCD5I9+WbgFlw
         Ehclf9U6j2qLBrqOUpTFQLHaYCmCDzy99iR+eALPLWRDJW4K+toNDuPWpUvDBwGfnDD5
         H+yyiqIwwlM8E7olZhH8Gyo5agoWxNnfw89luWnIQTX9r7k95ucHHjc7yNMLe5eNH/8G
         +tzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/snVLuY2V+3oJALazjxJR4aATI9prwsZ1+qFFk8MT3U=;
        fh=9tBNKLmDrxwxh+SizvwrYj9Fc8PWyxGkb/dP0PPPEOg=;
        b=TDx0GR2B4CzjK6mF7PsM3fdPSzP4pnTkvXaQaOItqLwlSmdC5rabgD6olhSMkS3zi4
         3nY86FUyzj6KFPT7eOzIf3n/rMeWZflnM1hRYYaIc4ruztuuZGEFefByUcf+eAF9py14
         23uWwpG71xVlEB9Kvqpi3eydtBgd3IWZsa0ZqJc5h/E1QQBzQH5RRCBwYyvd4WZQp0WO
         +MTnR+etf3uIZmFnrvsHWSdzVqCvia7kNwe9wQh/+oD3fxcC3bVXD9h5iTYrIAhCRDqL
         I994PSmUwKSNlxY5CBYlINqvdyffItmRXIrh5T24rtZcZsR6yRW67MoOVk5L8uN4pYjG
         yLjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772002121; x=1772606921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/snVLuY2V+3oJALazjxJR4aATI9prwsZ1+qFFk8MT3U=;
        b=JhZt+Rtx1JtznsLCcV2hHTG5LoEUfoYdYYuwiBDM4FDhD2bWJZNtWe71bVXO5VqYuU
         QXZna9Ryvg7Yihcywy9T89KDfPHcHCTtCjJ8GQmiUjaiVQqfn313xc4DcLnV0M7rFyPo
         IoAMBhg7EdV8ReVnabWfBoAmnL3c7CtSNADlaxYEA4Qf+P3MuQmXZG25PyABcCTWtRRJ
         RtMlt2urxdgVlRqNiHsEyTdJ+oz8efq5NedKIYXyrRhhzKdWimo4pyj622n5Cny2I4JC
         6vw9Y+XEQg6G2iDYCYhy2hfRamR8UsPgLEeyyXrHH8DUfTBjCG4I2oLAjdcNgDNLOoTQ
         cJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772002121; x=1772606921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/snVLuY2V+3oJALazjxJR4aATI9prwsZ1+qFFk8MT3U=;
        b=SWC0fTRrqr3j+VjG+xmC0MNB0xKyp2vHVKAyauHFd4K0O5FoWB5+sKO3KUDI8Utu5p
         2xvsj6N6QWEHztR6N8V+2+jc056RcOO6chYJAq0xxaP+XyagXFGHpFmnw9+03IYGAhhr
         9/SwzysGZGjZmsQ8WtLWnOOjbaQTstUw2Zv29xILSbcaA2ghu7rEUdBXIOJyakxu6mgG
         KVmRnvEh6a2U/bXCEkfNSVthIf1nyqND/soI1X3v+Uh4BGiH9yyopWz6cecbjzHJRG6v
         54ICZOQKfGWE+mfaxx/V00NVN32sn/i2dKlcV6rjXShHhw+v6hNEAv7j5dLirInH97Yr
         5g3A==
X-Forwarded-Encrypted: i=1; AJvYcCX+eBAHu6rNAie/A2yfWmiW2vxxwm6KoXrw5/E28CgdnZgSdx9OjCNkdcvSwZH/6EVl7F4VdHbZwSHJqM2eQK/X@vger.kernel.org
X-Gm-Message-State: AOJu0YytTUMPKl8Oaihvh+1Ogm/K/8JTB4KDDTt55OwCgOJfzf4vOouC
	9UbcDqtWQDQdXCy/8CIuCcPJ6nKxjn8JxN9/3wc4J78RWH9iZObEiYIiqU0Fe5cT7YCK0CsaaZV
	1s6tIr0/iUzoAGS0etcUGPUQ5zEpSQZ0=
X-Gm-Gg: ATEYQzxmZhp5TCAZqGbK+2vmrRrIc8nJ9Rsb8QX+KmUeLat2gLlPA9QJTHJCOZMetej
	xEkP/QJbvqTOBiFaSyHlHk2+/HQXColXIyGQpPrgpeVbpDiV7xvfoHjvCXSHYUxlrMfVLLnJ/5l
	mjsuyWuiNxRWFSkvM1m3e86C9S5cKGMhem5ZTbZoDhuvxqBrITeAirjb319VvKjL1wvktWkmbPe
	usQEAg5YJxAuf3q0N+puSl9u4GqOR3UPzqMj5JEFDM6YclFEAfdbir4ZhiWHmyQDRDzFeI0IdBZ
	80wx+vrQDid/37Ka39EMLv3jI4kfOj3cqLo=
X-Received: by 2002:a05:6214:2aa4:b0:896:af26:e74c with SMTP id
 6a1803df08f44-899b8c39dd7mr17449006d6.56.1772002121092; Tue, 24 Feb 2026
 22:48:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260124023917.78649-1-sj@kernel.org> <20260124024804.78869-1-sj@kernel.org>
 <aZwLDAxf9eP0lPdD@z2>
In-Reply-To: <aZwLDAxf9eP0lPdD@z2>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Wed, 25 Feb 2026 15:48:29 +0900
X-Gm-Features: AaiRm53GGaPVVDHoIKhwqeCV3u1Grhep-JVfBKu17G30DWV7VsMshswA2-jNLxo
Message-ID: <CAC5umygJNCxbDwbTPc3FFRAO+sfHyxx=QSXXF9g2TSiQ4Bvw=Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] mm/damon: introduce perf event based access check
To: Namhyung Kim <namhyung@kernel.org>
Cc: SeongJae Park <sj@kernel.org>, damon@lists.linux.dev, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B42=E6=9C=8823=E6=97=A5(=E6=9C=88) 17:08 Namhyung Kim <namhyung@=
kernel.org>:
>
> Hello,
>
> On Fri, Jan 23, 2026 at 06:48:03PM -0800, SeongJae Park wrote:
> > Cc-ing linux-perf-users@ for any comment from perf people, about the us=
e of
> > perf event from DAMON.
>
> Sorry for the long delay.
>
> >
> > On Fri, 23 Jan 2026 18:39:20 SeongJae Park <sj@kernel.org> wrote:
> >
> > > On Fri, 23 Jan 2026 11:10:10 +0900 Akinobu Mita <akinobu.mita@gmail.c=
om> wrote:
> > >
> > > > DAMON currently only provides PTE accessed-bit based access check, =
this
> > > > patch series adds a new perf event based access check.
> > >
> > > Very interesting patch series.  Thank you for sharing this Akinobu!
> > >
> > > I only took a glance on the patches, but my understanding is that thi=
s series
> > > modifies DAMON to be able to enable perf events of PERF_SAMPLE_ADDR t=
ype, and
> > > utilize the sampled perf events in the perf events buffer as the sour=
ce of
> > > DAMON's access checks.  In more detail, I understand enabling PERF_SA=
MPLE_ADDR
> > > type perf events makes the perf events buffer filled with memory acce=
ss event
> > > information with the access destination address.  The event will be s=
ampled
> > > based on time (e.g., one access event per X milliseconds).  And proba=
bly that
> > > sample data could include more information includign the CPU and the =
process
> > > that executing the sampled access?  Please correct me if I'm wrong an=
d add more
> > > details I'm missing, as my understanding of perf event is very poor.
>
> I'm afraid you need to deal with PMU hardware details.  For example
> PERF_SAMPLE_ADDR may not be available depends on events or sometimes it
> may not have valid values in some samples like on AMD IBS.  Also hybrid
> CPUs may not have same events on both CPUs.
>
> Maybe it's better to fix which event you want to use on each CPU
> architecture.

Thank you for your advice.

Is it possible to get a list of PMUs that have the ability to get addresses
(PERF_SAMPLE_ADDR or PERF_SAMPLE_PHYS_ADDR) from the kernel at runtime?

Or is it possible to detect that a perf_event initialized with a certain
perf_event_attr does not have the ability to obtain the address?

> > > And one quick question.  Can this work on virtual machines?  I'm aski=
ng this
> > > question the for following reason.  I'm actuaally working on a simila=
r project
> > > that extends DAMON for page fault based access events sampling [1].  =
The
> > > project aims to use page fault event rather than other h/w features s=
uch as AMD
> > > IBS or Intel PEBS, because my understanding is that such h/w features=
 are not
> > > available on virtual machines.
>
> KVM supports PMU virtualization.  But the existing vPMU support has a
> lot of overhead.  Recently mediated vPMU patchset was added so you can
> try that instead.  You'll need to pass appropriate options to qemu.
>
> https://lore.kernel.org/lkml/20251206001720.468579-1-seanjc@google.com/

Thank you for the important information.
