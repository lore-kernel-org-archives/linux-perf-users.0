Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9AB4A2C
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Aug 2024 05:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724562385; cv=none; b=Xmv5wjCtHTlc7XZZBLwJYoRU4AMHU3dNkKpOvwefncc4UAkaUtUg5gmhtJ7d1nsoWHBJCNAG2uPYG7njU7us4hlHZiUxkq8tC4t6sHCj7Ejcdu8AvdHzZAxxvL9+5t1qIk2DbUPY11xzYztbEWRnwu1fTQcYNObXuUZAtT39bmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724562385; c=relaxed/simple;
	bh=iJm4Urs/UC4vYg8SmsCbP927+ihuObpWVJzCOpxYzbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/g5+qv1xOqxod0PTCnf/IGretsBzczM+Fs+Pakb01GYqIyonka9p7IlzGstf+AC+aksLIKisZSfcSzEEOJsgn9TmQBiai8s9rK1wruSUHGGTaVCo6LpONleZt5+/yzrNT1VRpZ7ei97Fcq8cj4wKGetEZsnLlnx9UOLFqdDc5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OMnZ336D; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OMnZ336D"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-202018541afso154965ad.1
        for <linux-perf-users@vger.kernel.org>; Sat, 24 Aug 2024 22:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724562383; x=1725167183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMTbkedgsrPPfo8IkPbVnRMKzmVgjOLjelsopWSO9RY=;
        b=OMnZ336D00sgTkoJdyfjQwn+TV7xsIzJgmRvkmngQ1fQmp+GwWTn+tbX8PZn5Ha8Nc
         5MFEM4mArrptO80HlMLDPtQhKgSxsNh3Y/lcY+ohcvK9Q7YwPnmqQKO2oh1G6SLGpJ+9
         bNW1UUQTKLWyRJns0YxpiOKdp+xXp4G2j5aIiL9dJusB9vLHbONrIALYOXdmqzzAUUY5
         toGv/eOCln1ixvduVVHiEjnLZGiuuRBea2lE6E4cfYoAUMv5wrV2+pqUEFz+82z0zKln
         H+GoPPXunIvITUNQnPgIcehtDbOBXk3v4AgQ4Sk4kboujROZ62YRkX/tqyRblCL8RMKj
         asuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724562383; x=1725167183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMTbkedgsrPPfo8IkPbVnRMKzmVgjOLjelsopWSO9RY=;
        b=kjEy0Gii2N35Rwc0GV8CtbTs3Eze66dT+b0wMp2KjUwoLDuXmnk6M7scRoTK+Zkoeg
         f6nTqhO71Wc/2iOG5pMVLw7NInsIC7jMFZgOqo9sU0m3UzbdvWoxrHsvc/uxSx0wPmdq
         widYAeiqHwS2oKiZ6jkwW2L0l7f8Po6RK4MqE27Q62VJDEUCHoISew+/bvz3IgvqOrJx
         NAjtDROFkKMJfTRvTXbEOputoHdkaxUa4VyYEdwXVpH78cybtAoLiBacAJKrdPKb/kEF
         a3n9DfqgRocCdA29F4HEqebDCZsWNR0W7r5hiT/Px61V3b2vjFf8aRZ475Nksrg+3pm+
         Tf1g==
X-Forwarded-Encrypted: i=1; AJvYcCU34SoR0zHJDaJbQ14sRvbon1rBb3YKGKopP0+FHFCDlm4Jru/ajnWK86FhkqAPF20de8yMlQyCXSkN0LxGtXoP@vger.kernel.org
X-Gm-Message-State: AOJu0YyioChJJL2LTwI8X3olRVQiYRL1bZYztCjORRlUlXE9ZrwiKbzN
	J9MYznLqjDzQRqnkcgyOB76f4gJhBFIcg1A4/pkWc3QAEsjUmsUJi2N3C7hS2rJEaUdEjx+3djo
	rF+VnSnW39UojjXtCaNn23mhiNopux9sBrhb1
X-Google-Smtp-Source: AGHT+IHjS9fSVNpvHgfBVIFhvORjREsASYBgn5bFbXRzTlOIZ/el99DRfU4HWSZ0kS7JnnK8YcSOTQ05nicymObSraM=
X-Received: by 2002:a17:902:cec2:b0:1fb:2924:5c7e with SMTP id
 d9443c01a7336-203b6d6392fmr1847355ad.11.1724562382581; Sat, 24 Aug 2024
 22:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7f2b1c74-4087-4da4-94eb-51d37f3d8fc2@gmail.com>
In-Reply-To: <7f2b1c74-4087-4da4-94eb-51d37f3d8fc2@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 24 Aug 2024 22:06:10 -0700
Message-ID: <CAP-5=fVmP0sNaE-T0PAHb0y+Eoo7eNgDFyu7kCT+Hp+G62KXHw@mail.gmail.com>
Subject: Re: publish: perfwiki.github.io/main
To: Yunseong Kim <yskelg@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, linux-doc@vger.kernel.org, 
	Austin Kim <austindh.kim@gmail.com>, MichelleJin <shjy180909@gmail.com>, 
	Yeoreum Yun <ppbuk5246@gmail.com>, Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 10:11=E2=80=AFPM Yunseong Kim <yskelg@gmail.com> wro=
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

I think this is great Yunseong, thank you for doing it! Sorry for not
seeing your email earlier!

Can you explain a little on how to create updates to the pages? For
example, I see the topdown markdown here:
https://github.com/perfwiki/main/blob/main/docs/top-down-analysis.md
It looks like if I update the markdown, in a fork, I then need to
generate the HTML:
https://github.com/perfwiki/main/blob/main/site/top-down-analysis/index.htm=
l
Presumably I send a pull request containing the HTML and the mark down?

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

Log in problems to the wiki have definitely been an issue. I think
using github is a sensible way to resolve this.

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

Agreed, the wiki has been a work in progress for a long time. It is
quite sad the corners haven't been filled out and the documentation
that is there slowly bitrots.

> With a review process through the
> mailing list, I believe the documentation could have been more
> systematically organized.
>
> One thing we need to check is the licensing of the original wiki
> content. The existing documents do not clearly specify their licenses.

Agreed. Are there examples we can learn from? For example, libbpf is
active on github:
https://github.com/libbpf/libbpf

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

Agreed. The perf documentation itself, largely the man pages, is a
fork from the git source code 15 years ago. I did a round of deleting
documentation that related to git and not to perf. I'm not sure how
you'd propose packaging the documentation if it were part of the perf
tool. I believe the thought in the wiki was to remove the burden that
exists sending things to LKML. It is also for the best that the build
not have external dependencies (such as downloading files) and is
reproducible. An issue with the man pages was that they defaulted to
placing the current date in them, I modified this so that we use the
git last modified date and it thereby made builds reproducible.

Thanks,
Ian

> Warm regards,
> Yunseong Kim
