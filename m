Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E8113D61B
	for <linux-perf-users@vger.kernel.org>; Thu, 28 Nov 2024 05:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732773204; cv=none; b=SnBgnIBQ30iHrqyovASsWPzSNXK1Bih3Joc5ZvtVWKbOs1eCVlCve09piYO1TJBzms5KBGFZ4PhsbN2vXdDTt+48GbWp3/dbo98tF37tYceTNNjt6D92w+eiK+LCdvCRAz9w5/a36guS4epUigB9GvIxpKxGLBbelXJhE4WLx90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732773204; c=relaxed/simple;
	bh=CigLghzeFNvhCkft/ugL35ygrYZxds6r/kbd3dqmIUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HI2TlGqxkvSQ84UVlyaMkZSdwudEPbm/m/ag6zUt9duiluTuERHs0wDDruPyOs5zJ4ESHhP9cWOxcYCI7MeU5iHtMGM3JgmiiMsxiq/ZGGUvAEsjagV+scIm6h3oxan4jTTe5OtnJwq4m7hcONy2lWpXFtUGmLH96GoLC3PGLIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uak4QW4o; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uak4QW4o"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a762686909so59605ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Nov 2024 21:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732773202; x=1733378002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9jJe4aAwUIUkAd7lzdX2fV+tre1lnRm9MMRnXeyM0w=;
        b=uak4QW4oZJYJrfLDb9KGAUps8MDgtImAoSvi9JQC/A4L3tgo648fxEWywKrN8RnzbJ
         lzg9RCcx7ztiMWuuGyRtrlPzl+lbZdQrVSyH8A+3BVwqeYKZBausYLfq/JrJN5f80AL8
         B5S9EHHWRuWsHDbGfx4XkHh+S0X6ekFiup3F4OXaTlbJKwIqa6PkxyoYrlmdhauEEwZD
         xtr5zz2AIXU0m/btI9Bf2P9VcTsmoKqGxAEepHJe9C70LQgDmbc5OUdG1rUtuWclB1Wz
         K4aLBBvD5hUZiRR1g+jROaDD21pNxzsherNLJPtrXgORxmYyrERjnHW1rHHQUThd3pOM
         Dikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732773202; x=1733378002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9jJe4aAwUIUkAd7lzdX2fV+tre1lnRm9MMRnXeyM0w=;
        b=X1DYupsPngt6/u9/H6IBxp7YJw+0hlSU0AUGfnLltjMgG5f1iWA7s3BA2ZOmn60jJ6
         +N+ED+ZRdqOGTS4CGfyYcuLTTVtD7jMxGlkia/y4C0+sw3wN4+Q/XXKNQ2yf90x4JIIL
         LIOdZSkFYZwnq3t9DZULyuVhaVxcX8wddAxG7lT/i7hcQ9inWTkCvyNKDvQvCltTBGMN
         XeIhUIf3/yenAjEOpHszoYh1GbFk0fiT9Eaj50LZVr8rXNdLHHfD2Sw2m5FqqiHlPBIB
         piuvAikKzesNOrVwKv4TN84vLOpnlZu/FGm7cqPCdzFPXs9QU058VZOxRlS8rLqDdh9+
         pH8g==
X-Forwarded-Encrypted: i=1; AJvYcCWrgV7y+oUy4V3+2vBLme47MKUzZAxgKdIZCMZ7qSX53A0s7uFnWyfas9eP/WiBB31cIRsk8xmWJNkNRZHtzNEb@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0hvQ8Bc3AK3P5WGlwbyC6jrQplKEGvK8IIH4YuAY41doCPQGC
	jNj9Xd9My0bGaigysPa1zhMeHFivWArPDJAdAE7BrCWfBG6V+4wjJ5yl4mihY2vH6231kqwue/Q
	NAJ+6KBE1h6+sD014IcKOMq8lMqDOqcca2BLx
X-Gm-Gg: ASbGncviyhDbJt+1vu3aQNiPIio+Zo95PLIyyLJM905J6LyI6aYhbWu/Bvegwolw/eN
	LzvlRCxALXvENhoJvgECAqTXtHit4N4eP
X-Google-Smtp-Source: AGHT+IFvYUjJNyjZWFekd14GLP/s+DIjnjuLrclm8XY0JQ6x14JWKwl04yKcgVwfz/w4sbDoidYcVaCp33ULyhKOcSk=
X-Received: by 2002:a05:6e02:441a:20b0:3a7:cd62:7a7c with SMTP id
 e9e14a558f8ab-3a7cd627adamr540585ab.26.1732773202115; Wed, 27 Nov 2024
 21:53:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125071653.1350621-1-namhyung@kernel.org> <CAHk-=whQ_yeRDh_zZjhz-4q8G=vu5Ypb-Y3f=efHQSwd5Kas3w@mail.gmail.com>
 <Z0ZhDHXxHKoE2Nrl@google.com> <Z0ZvAB0vcL-D-a6f@x1> <Z0aRFFW9xMh3mqKB@google.com>
 <CAHk-=widREwanfzcQ3YUvqQ42xLmQHjK_asCFN2jTBM2OHY-Ow@mail.gmail.com> <Z0dkpqogjSCnJQec@google.com>
In-Reply-To: <Z0dkpqogjSCnJQec@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 27 Nov 2024 21:53:10 -0800
Message-ID: <CAP-5=fV4A-FKxv7Ovq5d44C-ght3_y3YuaevR12ptL1YyAWLSw@mail.gmail.com>
Subject: Re: [GIT PULL] perf-tools changes for v6.13
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 10:27=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Wed, Nov 27, 2024 at 08:02:42AM -0800, Linus Torvalds wrote:
> > On Tue, 26 Nov 2024 at 19:25, Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > I think it's a bug in perf record since v6.12.  I found the build-id
> > > event in the header area is broken.  Can you verify if this works?
> >
> > Ahh. And the reason I thought it was new to this release was simply
> > because I was traveling during the 6.12 merge window and didn't do the
> > tools build that I usually do, so I hadn't realized it was actually
> > pre-existing.
> >
> > Your patch indeed seems to fix it for me. Not hugely urgent (I just
> > installed the fixed perf binaries and clearly nobody else has even hit
> > the issue), so I'll leave this alone until the next perf tools fixes
> > pull and we'll get it fixed then.
>
> Good to hear it worked.  I'll add it to the perf-tools tree.

Apologies, for the breakage. Have my:
Reviewed-by: Ian Rogers <irogers@google.com>
and it'd be useful for a Fixes tag for a 6.12 backport.

Thanks,
Ian
