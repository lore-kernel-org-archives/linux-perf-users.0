Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BE9148826
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Oct 2024 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729736432; cv=none; b=YQDZi93Q+OCXa3nWG/JzrdOdffvyl4NJJrdxYccZ2S+KpEr2L4/Gj6pNQ/tM9N+yCeqy7iO+QV0OWghrDaArvJS0mm+rb7ow1pxhfL62JlhWli216p62vgreLUd+XWRitoqpHe+cvwFGzPz5FNOUL2a7dcKNzlLfkWodVuCXLBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729736432; c=relaxed/simple;
	bh=WJnKJxHvB8UnVy6vhcLiN5HJIWT5kMa+bvWIc0uJbl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URV6LehCQ7cARVP+ocR9gG+8lF2HtyXU/nK/rrOKGUwd+iviev0rFMrzOchn6OsO3DoiRSaPsXDxyylgA4Nll+kH62mxPq23ceqTvTAnGG5Me0DNOqz3tu5FB754LeLYzXltwIDDGpDGwNAU1PgdLUlCVqj9/Vkk0nW4+Phy8gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zHBGjJr1; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zHBGjJr1"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a3b3f4b599so70455ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Oct 2024 19:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729736430; x=1730341230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pIngecXtsdxG6meylK9oaVYnKTv5n7OxGRDRvncAmg=;
        b=zHBGjJr1O3H9IDglk8TeY1UWc0DMjqbYF3pL3FWfQukTWlDpUfMJw4Li2l/o/7mLT4
         RUYVn+tNsyZ+latmwQbjEyrxi+nP7PP3cmwvhwARFJn0yQuu+IzYexkaXJT8Nudtbhf5
         Vx3o2hto63PkGLa1GUdEIAjMNU25W+A5zW/yLyRByajJ4Gh8FW1vFkBv8zxPWBN9ayio
         FMFibERGpgiA0Q7inqzeFznQvSKBqQ7qSRqYEjCXwKMK1tMWkNpbNdtD1kPIu1uHXHTm
         GgT1WopuQn/4ehJFC9Q39KtrZ9UvPSjBHkMVa75CaeY8JID5FL8YyWO3gAv/uTGJYyEO
         XXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729736430; x=1730341230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pIngecXtsdxG6meylK9oaVYnKTv5n7OxGRDRvncAmg=;
        b=A17IgDp7BwxvsA63419l+XYQYfWhCf+ZhnyaHIM9fF2PPEi67Js4/399oUuwmxmm0O
         mLswCttPJIMVHD/qo7X55kzNzILZMD+gq6GIxEz+RDcpqyIf4xmxzu8spJyGaCsWMk4q
         4u0nwN1AFUVam2KJW87o4GTiNZgQfXMT7LUS751zUQPf59iZpquIe0aGkFz4S7qRf376
         YzKlmm3OEmVlZR9RKrU2CStVJ/oUi1Qi71ew3lf0R+LJRopyJ6yirdF+W5lXIdIuViC4
         bWkEFMWhcEqMQN6X7F+JEEZiH6p4UFscQ5qLK5i25CSj8F/u/Y5EXniRgLM/lxE4QtNW
         tr4A==
X-Forwarded-Encrypted: i=1; AJvYcCVwcXjqCjoE+EVxHIGPjpkB6bgeNr2zh60eQc4R16AvsuiWAypJ+W1S5lL/giVQAu8dSrrL0kNEtCag9N7sBoEN@vger.kernel.org
X-Gm-Message-State: AOJu0YxFyH5u2XhmLao96eTpzmZ5MNE+JrVGglzRVl95JaBM9kuIaJEo
	R0bMnJ8X3idqFPrMPEwn624FoeD/hf//U5FqQ73WTGJ94nup7eFbyup9kwJAc4da09sAALCSMsd
	hR8jb1d5lvukwXGhXfbwOavY/ZHRWu5XI4SDZ
X-Google-Smtp-Source: AGHT+IGG/Dw2k/witcZ02E7496UMWI+dKZv2aHv4zHjcU9haI1uZHPhi9mkLxkPFhlTYMDiG5YLcVAijc6sdwZ1JLq0=
X-Received: by 2002:a92:ca4b:0:b0:3a4:d2ba:2011 with SMTP id
 e9e14a558f8ab-3a4dcdf6107mr1872945ab.0.1729736429527; Wed, 23 Oct 2024
 19:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011-quiet-chowchow-of-temperance-d0e205@meerkat>
 <CAP-5=fUz5CFEL8D1L+UATsNqs4MBb6rNeYtZ26+pFC4NgRYt6w@mail.gmail.com>
 <20241011-uncovered-original-vole-cda87d@meerkat> <20241015-warping-condor-of-storm-afa06f@meerkat>
 <Zw8cN9daNBvCJd3u@google.com> <CAP-5=fXsVXYkncR0rwxXvKp_f5dR40L9_x-qoLxwHXWMiyXh3g@mail.gmail.com>
 <a0626ecb-cc64-4c6a-abf3-76868178234f@gmail.com> <b1c1a76b-5094-4384-9304-360a6012e3ad@intel.com>
 <b11407cf-8cfe-40ec-abe7-165122807e1d@gmail.com> <ZxlwoN57PF_5YX0F@google.com>
 <Zxl5sduEDnoxEmd2@x1>
In-Reply-To: <Zxl5sduEDnoxEmd2@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Oct 2024 19:20:14 -0700
Message-ID: <CAP-5=fVj_M4heMdYSiOrpQCm1_t+r7zsWkZWzsG-4f6jsVYbWA@mail.gmail.com>
Subject: Re: Migrating from perf.wiki.kernel.org to RTD
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Yunseong Kim <yskelg@gmail.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 3:33=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Oct 23, 2024 at 02:54:40PM -0700, Namhyung Kim wrote:
> > On Thu, Oct 24, 2024 at 03:17:38AM +0900, Yunseong Kim wrote:
> > > On 10/24/24 2:34 =EC=98=A4=EC=A0=84, Adrian Hunter wrote:
> > > > On 20/10/24 07:49, Yunseong Kim wrote:
> > > >> I would like to express my sincere gratitude to everyone for their=
 help in the
> > > >> official renewal of the perf wiki.
>
> > > >> Additionally, the reason I chose to use Markdown is that I wanted =
to actively
> > > >> utilize its media features. For example, I wanted to embed videos,
> > > >> presentation slide or display Mermaid diagrams directly on the pag=
e.
> > > >> I thought these features would be welcomed by users who are new to=
 perf tools.
>
> > > >> On 10/19/24 8:47 =EC=98=A4=EC=A0=84, Ian Rogers wrote:
> > > >>> On Tue, Oct 15, 2024 at 6:51=E2=80=AFPM Namhyung Kim <namhyung@ke=
rnel.org> wrote:
> > > >>>> On Tue, Oct 15, 2024 at 02:25:02PM -0400, Konstantin Ryabitsev w=
rote:
> > > >>>>> On Fri, Oct 11, 2024 at 06:39:09PM -0400, Konstantin Ryabitsev =
wrote:
> > > >>>>>>> Yunseong created:
> > > >>>>>>> https://perfwiki.github.io/main/
> > > >>>>>>> Perhaps the solution here is to make perf.wiki.kernel.org a r=
edirect
> > > >>>>>>> to https://perfwiki.github.io/main/
>
> > > >>>>> To speed things along, and since the old perf wiki was near-unu=
sable anyway,
> > > >>>>> I went ahead and set the redirects from perf.wiki.kernel.org to
> > > >>>>> perfwiki.github.io.
>
> > > > Links to old pages end up at the main page.  For example:
>
> > > > https://perf.wiki.kernel.org/index.php/Perf_tools_support_for_Intel=
%C2%AE_Processor_Trace
> > > > https://perf.wiki.kernel.org/index.php/Top-Down_Analysis
>
> > > > Any way to get them to redirect to the correct page?
>
> > > We can use web.archive.org as of September 30th of last month.
>
> > > Intel PT Link:
> > > https://web.archive.org/web/20240930185823/https://perf.wiki.kernel.o=
rg/index.php/Perf_tools_support_for_Intel%C2%AE_Processor_Trace
>
> > > Top-Down_Analysis Link:
> > > https://web.archive.org/web/20240930164757/https://perf.wiki.kernel.o=
rg/index.php/Top-Down_Analysis
>
> > The corresponding pages in the new site are:
>
> >  https://perfwiki.github.io/main/perf-tools-support-for-intel-processor=
-trace/
>
> >  https://perfwiki.github.io/main/top-down-analysis/
>
> It is unfortunate that we can't have some sort of mapping from the old
> URLs to the new ones, I can imagine other sites having links that now
> will get broken :-\

Are there particular pages you think will get broken? When I follow
old links I get the "main" page and it has links to the intel PT and
other pages on the left. Perhaps 1 more mouse click is necessary, and
we need to make sure it is easy to get to the popular old pages from
the main page. I agree it isn't ideal but I'm not sure we can do
better. It isn't totally broken, which the old wiki login system had
become - so this is an improvement for me as I can at least edit
pages.

Thanks,
Ian
