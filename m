Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8380264A7C
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Jul 2025 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678177; cv=none; b=Jmk0TaiUamg2gdrRVAQG0MvCmqkr8uJTBnK9R1eTHfZ/wIDtZ++vF+AFSQ1VenJGmerLJ4c+DCJI4kabG2ASj4E0rLROjOt78nuEtJe2S3vpNnGJdbSKrBH8jEGkmaOXhzkKMmzPw15ayosWGcV8ferpYpi+XEbMPTzZzSy7NBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678177; c=relaxed/simple;
	bh=H/6LF+iyqlB6WdJMGv+zhODFsSfPB/DLQ2p+t7Osrp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRnre5a7bHcC/bY5FFTDoEkzpcLXWYvmCxpw57aXWZVj15U78gX7PpB7nn7aZzWWotCp4K6Wum86pACQsRdC4Tq8KcJlCoNn3XokRgBUYP5UAnVDVAmudeR5/X+g85zKgQAy6jFNiMm8wStiEP+0EUm5715xmz9/2c2JtRJhD0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RM4IULYd; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RM4IULYd"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3e283b2d065so227985ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Jul 2025 08:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752678175; x=1753282975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XeI4y6AwbVbBI9zJk5QvguTosq6+VRIDRyatWXbmUE=;
        b=RM4IULYdR2L/UlNxCnR7JC6Jy+fjppKVAMmsAFTkLpXIpNF4aav6RT28OfHJAeoIJh
         powK/Np5aOpAxlGmWVLrV2aOvdYsfzWknSI1sT70BGB9adrHXJC/BuOR5s8orydmFblG
         OF95U5H15JI9VoRTimEiXBD4TsmuuyvW3QMG7UuU8in+iQ83Xm0c7NLiVrKf1yx9nJAN
         XJTs8d7KQzm1WcaV2YGKPSqwM5N9tklD1eO11ByNY0kZ0ms5X16I4zqlSdev8NS2YppN
         /hmZqaKUeLFifFeeQLwOHUK016j/M0zPEZI4iHczob6XMNI3kBC9gdfRHIWVPt8JppOf
         g6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752678175; x=1753282975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XeI4y6AwbVbBI9zJk5QvguTosq6+VRIDRyatWXbmUE=;
        b=ZkxvZZZ3Dv9ROxYucFa1g62UemrCo3mNMeRwWTrKftWg9zjrZ0QqoQLDT17tKydv3/
         YVHxMZAgoIUvoHujVyE9NhUqSAoPv81jHrJl6ZcbbOVfouLTAQCrzMDi27dqIbxwCh+M
         IY/UggVZLzIuzr+k9MovBoA7p1NZKMUOhQMcIvP8o5XeZjY58PEYXeBw8X15ySXovk/g
         gez2Lb+cQJQHnm+kHkqqic7cZnPk35JBIpfb68m7nP1yEm4Y5ESQAYWsJvsRi5dYJPld
         QGG6LXYkNwfKFji/tO2EfbARMDHuc+DCf86DDZJYYR2t+1wqFjrACDVaIPbxSLJ6QeWO
         Ecfw==
X-Forwarded-Encrypted: i=1; AJvYcCVw01c+1LuBM3/i7rvebiPXSBMHAOpDury8x/uwf3aYlOnBC75/3IObIEr2dZ6d33CWQYYgMVvP8KtA5HyCpsBV@vger.kernel.org
X-Gm-Message-State: AOJu0YwGRFq5F2AvixQrwwN97wj5ap2xDWILdHN6SC6T5yy8kDyv5vn7
	zdyyPVB/WUfyDVYChQgnda3HNBrkPZdtA+s2k6TjgH/70mGBC9sw3Kt0rM/+9sJrtZ4LqXM6BbL
	XS58Nw7+HopnEPsd20Db7Yh70XCVXVwZ9V9kvXw6y
X-Gm-Gg: ASbGncvGgBhJY6b7ijzt9YrvsG357def4P3F2OUKMkqwx1mikBSBRUYOwSbAa/ownN1
	Di+7nKSbdalGq8tLLHRXIvWRG0zayWen8DR+9wIrZ52A74Hu4bxD6aMSnErpJbKf4OWQQgHTWq4
	RbOSRiNS9xUskQ1bop4lSMn8pVwAoxkfSY+WtgZWo5W2wZhueFW8ATPsXKGNY1fRAvSHvZBEO21
	2qAsBLOCbhHQ1qdEUyIOTY3Yt61OMMNSg==
X-Google-Smtp-Source: AGHT+IEabtwYOt8rm3YI3C0FkV4NnosV35yDgcOcSkRAsSS0TRnyL8foTBS2OU/EQDy76fqwehyL8IT8hljwpLQJMdI=
X-Received: by 2002:a05:6e02:4503:b0:3e2:865b:6b62 with SMTP id
 e9e14a558f8ab-3e2865b6e64mr1897195ab.1.1752678174505; Wed, 16 Jul 2025
 08:02:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716050054.14130-1-namhyung@kernel.org>
In-Reply-To: <20250716050054.14130-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 16 Jul 2025 08:02:41 -0700
X-Gm-Features: Ac12FXwIOgTloU0VMFTU3qvt-L3PqdHLEbOTbvhHknx6mvbSQWqnHz5ffR786pY
Message-ID: <CAP-5=fXV2pz9ba-2riHubGsDzh4X3m_vuD=0o+D0vDt56o8hhw@mail.gmail.com>
Subject: Re: [PATCHSET v3 0/8] perf annotate: Support --code-with-type on TUI
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 10:01=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hello,
>
> The --code-with-type option is to show normal annotate output with type
> information.  It was supported only on --stdio, but this change adds it
> to TUI as well.
>
> v3 changes)
>  * hide stack operation and stack canary by default
>
> v2 changes)
>  * use 'T' key to toggle data type display  (Arnaldo)
>  * display '[Type]' in the title line when it's enabled  (Arnaldo)
>  * show warning when debug info is not available  (Arnaldo)
>  * fix a typo  (Arnaldo)
>
> Actually the command line option sets the default behavior and users can
> change it by pressing 'T' key in the TUI annotate browser.
>
> The code is also available at 'perf/annotate-code-type-tui-v3' branch at
> https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>
> Thanks,
> Namhyung

For the series:

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Namhyung Kim (8):
>   perf annotate: Rename to __hist_entry__tui_annotate()
>   perf annotate: Remove __annotation_line__write()
>   perf annotate: Pass annotation_print_data to annotation_line__write()
>   perf annotate: Simplify width calculation in annotation_line__write()
>   perf annotate: Add --code-with-type support for TUI
>   perf annotate: Add 'T' hot key to toggle data type display
>   perf annotate: Show warning when debuginfo is not available
>   perf annotate: Hide data-type for stack operation and canary
>
>  tools/perf/Documentation/perf-annotate.txt |   1 -
>  tools/perf/builtin-annotate.c              |   5 -
>  tools/perf/ui/browsers/annotate.c          |  66 +++++++--
>  tools/perf/ui/browsers/hists.c             |   2 +-
>  tools/perf/util/annotate.c                 | 157 ++++++++++++++-------
>  tools/perf/util/annotate.h                 |  27 ++--
>  tools/perf/util/dso.h                      |  11 ++
>  tools/perf/util/hist.h                     |  12 +-
>  8 files changed, 191 insertions(+), 90 deletions(-)
>
> --
> 2.50.0
>
