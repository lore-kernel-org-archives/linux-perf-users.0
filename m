Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7811369AE;
	Fri, 30 Aug 2024 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035385; cv=none; b=Mc8SPEDcTGlMqLoJDmuYzofCNbLUS7T1cilpsLFStg+TRM6bLijDGUUnIAz+DVSIzINIXNZOQxWdlEhi7Cba31eJSRq5Rm3xBwQoBC5ZQsdbd+2RdTfG85iI96oCydrqCUOPIq7E74t0QlgCAon8bfhCLN1PVmhPjBLm6hASOnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035385; c=relaxed/simple;
	bh=TSKbhhuaRzarcj0riC2ELT2cBIOKduDCtuPat/2Rrjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fCrVbc7Eh7x9C2Ylx0rNUDslilaPv1ZWGHAd4K7cwmFUejdP2CIewiAOXg84ECVw2Pwj4IjxBXlNvmNfiZeSTQUUZMfChvLScSq0iReghKnll+wPgMGfN1fMcN1kh7MQvr+5f96DqiI4YxxuWbW/GEen5jYVCkYqtWpEULxcOBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9eZNOfv; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9eZNOfv"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6c91f9fb0d7so19974817b3.3;
        Fri, 30 Aug 2024 09:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725035383; x=1725640183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKW2ySfTJtxg9hCELCYfcp6iXm8lrti76j0UGTwkt7Q=;
        b=F9eZNOfvmWA4JifXAmPnh6jXsP20qyB974XSTANPv4TlbibhNd/mXveRh0KKVCFvVQ
         CxYFXwPk/8ovhiq+64re/4ttlzmqSa7pR8dhY1w1EzWo5vpj7pKjfyanYfs+SpCDdeUd
         uyDyyIiLEFIXaPO+4gckgo+cS5ZyVQSF//7rVSlYbhWe4SBqu93ULms1GL/utDHRD60I
         XplFJJb8U7BzCfSiDum2q6GlvWBq80efCbrIDfu1ViDK2nWls5BrJKjxYMRXS4NZg+KO
         8Ko3Q9kvEn6hQliyeU8XwuXqjBYNsLgBPQUxLkP7xMqECJg2pM9giqQ9uozgwlNUN6Hx
         +mVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725035383; x=1725640183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKW2ySfTJtxg9hCELCYfcp6iXm8lrti76j0UGTwkt7Q=;
        b=NcQCXE8OcwHXW4xw32J9EUvuTtBdaJTiIUtW2NtdOV9AYAt8+fUmgWEPKZQgO46eSL
         6YwSz2OuPRryGljwF+CRJjm3uCgCwA/LqPjKeAhuII0uhZuM0MfmlCBfJIHX1fUgNxDv
         /n2K+gFxfzD7w3B2jsLMQS6e3fv/SdYsonk4wtrwVxSUr2zm6W05R0jZWjjQGUBP/ojd
         RzzeOt4aifhXYJn0u0ucYel1MRzoV1N6w0M8xlyI14UUR+bbDP+1ds6BLIQN3RVky7uZ
         4iYiGN4z2ec9jbuUz+NiBhlACYY77r3uGMNP0hBqwasbl9rVA1XdLg9UcKNNHoe8MfBM
         4WAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk9ufxhvOtcaLGLWnFQFC4QUPZoro6q3CWVgAcZVkzRNdc6l+y6esDFHn/k+OcDwAWhVNz2snZ4CM=@vger.kernel.org, AJvYcCVLyKDd/aChKVtddbfHw9vT9K4ISHwY6kMNYzM3lTh1GMJTAoHBFZT+LXiWmHad49EXrIGH2eo/ZNP2lqGsVdN+Yw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwITim6ievoVbuPR8q60RqWY4Xk3sW2p874RTDPKBBasV8XQbQ0
	J08zwqMval/oiPwZqLYlcLRnIu9D/5Y9WZLWER2ydMwME8p0i5EdRzr79wqDnjp5fsy+lgK/xrJ
	C0UFhU4wvuZSZrTDn2RWd84hDl+kibf1zwU8=
X-Google-Smtp-Source: AGHT+IHa7NEYai7hFc8Z0XKs4e6W+Vbtz8YA74OjOaSsq++EDmZV6aHRQLv+jKh99H84PAoJ1MmJiU0yhVqZN42yqqI=
X-Received: by 2002:a05:690c:d85:b0:64a:f237:e0b0 with SMTP id
 00721157ae682-6d40d78db7amr24524467b3.5.1725035382590; Fri, 30 Aug 2024
 09:29:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7f2b1c74-4087-4da4-94eb-51d37f3d8fc2@gmail.com> <CAP-5=fVmP0sNaE-T0PAHb0y+Eoo7eNgDFyu7kCT+Hp+G62KXHw@mail.gmail.com>
In-Reply-To: <CAP-5=fVmP0sNaE-T0PAHb0y+Eoo7eNgDFyu7kCT+Hp+G62KXHw@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Sat, 31 Aug 2024 00:29:31 +0800
Message-ID: <CAH0uvohyjLojJYtwCQeD2zmDYavjYWmom3C4O3Xmou-ez_hCkg@mail.gmail.com>
Subject: Re: publish: perfwiki.github.io/main
To: Ian Rogers <irogers@google.com>
Cc: Yunseong Kim <yskelg@gmail.com>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, 
	linux-doc@vger.kernel.org, Austin Kim <austindh.kim@gmail.com>, 
	MichelleJin <shjy180909@gmail.com>, Yeoreum Yun <ppbuk5246@gmail.com>, 
	Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Resend because didn=E2=80=99t cc the mailing list]
Hello Yunseong,

On Sat, Aug 10, 2024 at 1:11=E2=80=AFPM Yunseong Kim <yskelg@gmail.com> wro=
te:
>
> Hello everyone,
>
> I=E2=80=99ve migrated the content from
>
> Link: https://perf.wiki.kernel.org/
>
> to markdown format.
>
> You can now access it here:
>
> Link: https://perfwiki.github.io/main/
>
> All the pages listed under have been migrated.

Thank you so much, absolutely amazing work.

Just sent a pull request to the perfwiki github page for some minor
improvements, can you please take a look?

> Link: https://perf.wiki.kernel.org/index.php?title=3DSpecial%3AAllPages&f=
rom=3D&to=3D&namespace=3D0
>
> We haven=E2=80=99t been able to log in or sign up on
>
>   perf.wiki.kernel.org
>
> for several months now, despite it being a valuable resource for many
> Linux users. I don=E2=80=99t know much about how the perf wiki is managed=
,
> including any automated backups or the updates of man pages to the wiki.
>
> Using the mkdocs framework, my knowledge of markdown, my keyboard,
> and my efforts of finger, I=E2=80=99ve converted the MediaWiki format doc=
umentation
> from perf.wiki.kernel.org into markdown.
>
> I believe this was a worthwhile effort for me, especially
> considering that it serves as a backup of the valuable content on
> the perf wiki at this point in time.
>
> Linus once said, "Talk is cheap. Show me the code." While I haven=E2=80=
=99t
> been around for long, I understand that telling others what to do without
> taking action oneself is not the best way to give feedback. When I looked
> into it, the last edits, aside from the bot-built manual documents,
> were made in May. Someone can check the recently changed pages, although
> I found that it=E2=80=99s not easy to review the past change of history i=
n MediaWiki.
>
> I noticed from the perf mailing list that there were issues with
> logging in, and it seems the door lock is still broken with no sign
> of it being fixed. This motivated me to start this migration.
>
> I wasn=E2=80=99t sure how long we=E2=80=99d have to wait to regain login =
access.
> I hope you see this in a positive work and not as an act of rebellion
> against using the original wiki. I genuinely believe this was the
> best action I could take.
>
> This situation also made me wonder: Is it really a good idea for a
> wiki, which is linked to the kernel and serves as an official
> reference, to be updated without review from others through the
> mailing list?
>
> While it might be convenient, during the migration,
> I found quite a few documents that were linked for future additions
> but never actually created.
>
> With a review process through the
> mailing list, I believe the documentation could have been more
> systematically organized.
>
> One thing we need to check is the licensing of the original wiki
> content. The existing documents do not clearly specify their licenses.
>
> If you find any discrepancies or issues with the migrated documents
> compared to the originals, please let me know. While migrating, I
> also fixed some errors in the original documents. If the original is
> correct and the migrated document seems off, it=E2=80=99s likely due to a
> mistake on my part=E2=80=94no AI was involved, just my fingers. Or perhap=
s I
> was just tired. :)
>
> I wasn=E2=80=99t sure if GitHub or GitLab was better, so for now, it=E2=
=80=99s
> hosted on GitHub. I plan to mirror it on GitLab as well:
>
>   perfwiki.gitlab.io/main/
>
> The CI pipeline for building man pages still needs to be
> implemented. I=E2=80=99ll work on that when I have time.
>
> I=E2=80=99d appreciate any feedback and would love to hear any ideas for
> improvement.
>
> P.S. I also think it would be great if the markdown documents from
> the perf wiki could be viewed offline in a TUI.

Cool.

Thanks,
Howard
>
>
> Warm regards,
> Yunseong Kim
>

On Sun, Aug 25, 2024 at 1:06=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, Aug 9, 2024 at 10:11=E2=80=AFPM Yunseong Kim <yskelg@gmail.com> w=
rote:
> >
> > Hello everyone,
> >
> > I=E2=80=99ve migrated the content from
> >
> > Link: https://perf.wiki.kernel.org/
> >
> > to markdown format.
> >
> > You can now access it here:
> >
> > Link: https://perfwiki.github.io/main/
> >
> > All the pages listed under have been migrated.
> > Link: https://perf.wiki.kernel.org/index.php?title=3DSpecial%3AAllPages=
&from=3D&to=3D&namespace=3D0
> >
> > We haven=E2=80=99t been able to log in or sign up on
> >
> >   perf.wiki.kernel.org
> >
> > for several months now, despite it being a valuable resource for many
> > Linux users. I don=E2=80=99t know much about how the perf wiki is manag=
ed,
> > including any automated backups or the updates of man pages to the wiki=
.
> >
> > Using the mkdocs framework, my knowledge of markdown, my keyboard,
> > and my efforts of finger, I=E2=80=99ve converted the MediaWiki format d=
ocumentation
> > from perf.wiki.kernel.org into markdown.
>
> I think this is great Yunseong, thank you for doing it! Sorry for not
> seeing your email earlier!
>
> Can you explain a little on how to create updates to the pages? For
> example, I see the topdown markdown here:
> https://github.com/perfwiki/main/blob/main/docs/top-down-analysis.md
> It looks like if I update the markdown, in a fork, I then need to
> generate the HTML:
> https://github.com/perfwiki/main/blob/main/site/top-down-analysis/index.h=
tml
> Presumably I send a pull request containing the HTML and the mark down?
>
> > I believe this was a worthwhile effort for me, especially
> > considering that it serves as a backup of the valuable content on
> > the perf wiki at this point in time.
> >
> > Linus once said, "Talk is cheap. Show me the code." While I haven=E2=80=
=99t
> > been around for long, I understand that telling others what to do witho=
ut
> > taking action oneself is not the best way to give feedback. When I look=
ed
> > into it, the last edits, aside from the bot-built manual documents,
> > were made in May. Someone can check the recently changed pages, althoug=
h
> > I found that it=E2=80=99s not easy to review the past change of history=
 in MediaWiki.
> >
> > I noticed from the perf mailing list that there were issues with
> > logging in, and it seems the door lock is still broken with no sign
> > of it being fixed. This motivated me to start this migration.
>
> Log in problems to the wiki have definitely been an issue. I think
> using github is a sensible way to resolve this.
>
> > I wasn=E2=80=99t sure how long we=E2=80=99d have to wait to regain logi=
n access.
> > I hope you see this in a positive work and not as an act of rebellion
> > against using the original wiki. I genuinely believe this was the
> > best action I could take.
> >
> > This situation also made me wonder: Is it really a good idea for a
> > wiki, which is linked to the kernel and serves as an official
> > reference, to be updated without review from others through the
> > mailing list?
> >
> > While it might be convenient, during the migration,
> > I found quite a few documents that were linked for future additions
> > but never actually created.
>
> Agreed, the wiki has been a work in progress for a long time. It is
> quite sad the corners haven't been filled out and the documentation
> that is there slowly bitrots.
>
> > With a review process through the
> > mailing list, I believe the documentation could have been more
> > systematically organized.
> >
> > One thing we need to check is the licensing of the original wiki
> > content. The existing documents do not clearly specify their licenses.
>
> Agreed. Are there examples we can learn from? For example, libbpf is
> active on github:
> https://github.com/libbpf/libbpf
>
> > If you find any discrepancies or issues with the migrated documents
> > compared to the originals, please let me know. While migrating, I
> > also fixed some errors in the original documents. If the original is
> > correct and the migrated document seems off, it=E2=80=99s likely due to=
 a
> > mistake on my part=E2=80=94no AI was involved, just my fingers. Or perh=
aps I
> > was just tired. :)
> >
> > I wasn=E2=80=99t sure if GitHub or GitLab was better, so for now, it=E2=
=80=99s
> > hosted on GitHub. I plan to mirror it on GitLab as well:
> >
> >   perfwiki.gitlab.io/main/
> >
> > The CI pipeline for building man pages still needs to be
> > implemented. I=E2=80=99ll work on that when I have time.
> >
> > I=E2=80=99d appreciate any feedback and would love to hear any ideas fo=
r
> > improvement.
> >
> > P.S. I also think it would be great if the markdown documents from
> > the perf wiki could be viewed offline in a TUI.
>
> Agreed. The perf documentation itself, largely the man pages, is a
> fork from the git source code 15 years ago. I did a round of deleting
> documentation that related to git and not to perf. I'm not sure how
> you'd propose packaging the documentation if it were part of the perf
> tool. I believe the thought in the wiki was to remove the burden that
> exists sending things to LKML. It is also for the best that the build
> not have external dependencies (such as downloading files) and is
> reproducible. An issue with the man pages was that they defaulted to
> placing the current date in them, I modified this so that we use the
> git last modified date and it thereby made builds reproducible.
>
> Thanks,
> Ian
>
> > Warm regards,
> > Yunseong Kim
>
