Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559E3FC14
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jan 2024 22:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705963186; cv=none; b=PKAhyrUttwLn32jjJwIw7U5llTsZENd4C3tJOP3cWdYpSqBWXaVI2SByg99Gme3yuKvpnIRADkVGG4uEbPk3Ouq3+8UFnfyveZEUbeshqCN8JUekKoRG8dcANLM3cSJFxUiIYBgk8CIxLvra5+hSK2Us+Wgx76kT+x367x4Safs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705963186; c=relaxed/simple;
	bh=ZVmFSLgkoNjgxIco6IOLEXV0bYz1rKGdgxcfeqQjXwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjYcr9WuuAN8k77miJQKZVM+AkLJAOe4WpliKzT8vWsuxIOC+SuAZu1ODppOIc0lOGBHOMQNwCD/4VnrtZx3JmZqthvLmotAno7Yk+jgfsB8tdXqZFSdF8+vtHOVU+0v9bF7kim6CbETacB8oPnjzipsfqW0RhYVAw68A082iSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UHJpY+yb; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UHJpY+yb"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-361b24d1a9eso40355ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jan 2024 14:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705963184; x=1706567984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVmFSLgkoNjgxIco6IOLEXV0bYz1rKGdgxcfeqQjXwU=;
        b=UHJpY+ybagSEcBi+2w7v1lWuxQsIGWHlT3UgQiXPfN0rnTYgnM/ZTkLz9cSCp2wekl
         j16loNyQOKjJg6cGyHB+HalfHpU0O98ew3QnpvydmEbK2iF/c11sxgxeVGxRAAaNIi3Q
         y2z/UWTz01dxMRHIBmtkn98CiBo5fodO20pl27OcUYWidkh3tXJfxBtDLiiFqIlDyd8E
         yUWYsE4p9SteND4jfYb23rQ8yNCfOFfXtJ7ugCDGvmoVTtCXVDyXhZAOHzQYm1KxhD7l
         wQgpk4Ae5zUxpZ70I8hOqKeZ0MsN99wNRH/yvY+2ICgieN1hS/wft5DjybQC3JSnipuX
         XEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705963184; x=1706567984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVmFSLgkoNjgxIco6IOLEXV0bYz1rKGdgxcfeqQjXwU=;
        b=f0+JKjtKTNW6ZWn7kKgUdybMl49n1GE3jib2cMRQBnn7lPLTUvk51bM7gvqSk4M78W
         /VD0avewoa4As476L080slWsflHp/ilxQYdhXNVd8aApW1vADr2y+EpNbR9mnIDbrtKI
         X1bLN8WBUirW1caFZZv96OxspBa1kAdnxnNIqzattAW5phUBtQXxCmsF8Q6SDvQQf+Jp
         GHc+/XhNZ1DnDDAVammE4mzpZhto7Wf82WjPlNYPz6b/NKdA3cN+GaFWDGlBrmV7c/pc
         8rTHdR9LVMpgMR03iRjMOOroXfGaulnvtLDf0aJ1CCm/qrNesqJA+tdaTemHAGZJMZFi
         hxcg==
X-Gm-Message-State: AOJu0YylUx13TPhRDTCzgCYKCi89/PK6ndkvS8i8aVN1VhZSR1n4JaZd
	odoPX1mPgK7TsKn0fliuPqz4CazndxhN3eXeER/OTnSJ++8wAVxdI1qUzwBDpVCNcsBno8fOLuH
	JyGzjxHD6U9a8h0/AnKxYRaxa+hm2sgmWHU/AltN/LVJKp35nI4fZ
X-Google-Smtp-Source: AGHT+IHodE7Gn1dcsOiaZggAz0YjQ31miwedpRLtaNGpEgrNTjvanznuyPQ0kHjh+QdSTRnteaW9k7MDuYn4YSjRtvY=
X-Received: by 2002:a92:c043:0:b0:360:6233:1377 with SMTP id
 o3-20020a92c043000000b0036062331377mr35649ilf.27.1705963184374; Mon, 22 Jan
 2024 14:39:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fUMrS+fiewxm3y4j=z4GucBVbOyDGcXNg8uDF3K+yPZ2Q@mail.gmail.com>
 <fdeec5b3-693c-61ce-e8b0-94ff72188317@arm.com>
In-Reply-To: <fdeec5b3-693c-61ce-e8b0-94ff72188317@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 22 Jan 2024 14:39:33 -0800
Message-ID: <CAP-5=fXuduT--u5WThgi5RO1d8G5DuAUfn_AVjWTr6=VtZAUWQ@mail.gmail.com>
Subject: Re: Issues with Linux perf tool on Raspberry Pi 5
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>, ChaitanyaS.Prakash@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 1:59=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> On 19/01/2024 23:39, Ian Rogers wrote:
> > Hi,
> >
> > I thought I'd report the state of Linux perf tests on Raspberry Pi 5
> > and so I opened a bug because of the number of failures. I'm happy for
> > help resolving the issues. The bug is:
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D218401
> >
> > Thanks,
> > Ian
> >
>
> Hi Ian,
>
> For "test perf probe of function from different CU", Chaitanya has a fix
> that she should be sending soon. I already planned to look at "Check
> Arm64 callgraphs are complete in fp mode" as I see that failing here so
> it's not related to Rpi5.
>
> The others as you mentioned do look to be config related. IMO that's
> usually the issue, or it's a build issue where Perf is missing a dependen=
cy.
>
> Although those should be a skip so technically there are still bugs.

Thanks James,

agreed on the fails not being skips still being errors. I'm going to
look to see if we can't at least make the BTF not found errors warn
that the kernel probably wasn't compiled with BTF enabled. I look
forward to testing the Rpi5 fixes :-)

Ian

> Thanks
> James
