Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF662D049
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jan 2024 23:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c8ITE3M+"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50eaf2f00d1so472e87.1
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Jan 2024 15:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704410990; x=1705015790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1ItoplfV1JX6AcITsa7L9kuWOogDN6iRQE45K/jnlw=;
        b=c8ITE3M+9ZeXFgsu1KsbQt/JyOHH8VYSi2rb8ZzB8A4HrIvSJ482sPP13mZ2GeK9Ga
         2aEZoue25pihJU+mmaCHHjjv0HUsIfgMqyKyS68DZzgYDQflgeymBVlVan/LH5AXZRS2
         BEE7B1MhJnuf3iqwfvNtYEyaXtWec16hCt/mprql9YbeLMWJ8Bsr7OvFL2TPaz1r2In6
         1gVVj4ylnmtRpPYCw7LXTqHvm5l/d/99yBHpT/ixgktoUF/xWDCOLtVwpeTvJDZNK6ud
         L16YpKu27Kg0pUfsjrxz8TWZ2HleIphqjrIuV8qDiAirA8TLPSiNZ53u7Fe/vX/AR0Mf
         wtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704410990; x=1705015790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1ItoplfV1JX6AcITsa7L9kuWOogDN6iRQE45K/jnlw=;
        b=HNsfLCkKEEutwzeLpr1kl4YM8IX/mCk5RLAF/voNPV/6WzT1YVpGBxh94S/ad+xqby
         mZP5p1lqDaGGHu5uJOA6IawhDWLMq8xMnAEJI5czlFsXCXIp8K0cxldlx3JAqtvHCNFK
         igdxXXZ5rQ5VY33nuSw+M252JA+i/8IvbG+y8IBmpRCGFSyKBBtD8PVjr85B81brQn0n
         1bQXu6H7+B8TytxqWicsIBoYDd1CiXcyzcyrKL0PPNzFOFDNmIq9MozSMh5eNwvkMYOD
         0dP3muuVqxPlzj0zJfgutFGamhbJwBhgSQu/IFSYo2zKGMeZ7maIX9DbgX9BlUowKG87
         HJ8g==
X-Gm-Message-State: AOJu0YyxeAbgb9BCDbvNyTczIzTOq0r9+h9fKGyRC7QpDgyqh0cjFqLk
	MPSzqU5pX5wy0N0zmRvOFFhnpQzGJXsi8BfhMauf6zenH5JP
X-Google-Smtp-Source: AGHT+IGAK/DXuXapY19eMLxBHwxotH1bZgf2uNLq4g8r0W0sLlOYMHO8R1dkrD+fCgpOge4ZJZiNUQ5NxowH3RxLuV8=
X-Received: by 2002:ac2:4430:0:b0:50e:7f67:dd0f with SMTP id
 w16-20020ac24430000000b0050e7f67dd0fmr14921lfl.1.1704410989471; Thu, 04 Jan
 2024 15:29:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208000515.1693746-1-irogers@google.com> <CAP-5=fVQfqS6gu9Ua3Exijc_ZaBzrt2=1PMopgdoyC_6R_cnaQ@mail.gmail.com>
 <ZZcdDyyADG8dP8LM@kernel.org>
In-Reply-To: <ZZcdDyyADG8dP8LM@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 4 Jan 2024 15:29:34 -0800
Message-ID: <CAP-5=fVfCnPG0O51rRXVqkGRU4eW7n0B1YGr9pL8CbwxG+V8jQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] lib subcmd: Fix memory leak in uniq
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Chenyuan Mi <cymi20@fudan.edu.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 1:03=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Tue, Jan 02, 2024 at 11:30:39AM -0800, Ian Rogers escreveu:
> > On Thu, Dec 7, 2023 at 4:05=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> > >
> > > uniq will write one command name over another causing the overwritten
> > > string to be leaked. Fix by doing a pass that removes duplicates and =
a
> > > second that removes the holes.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > Ping for this series, no comments since sent.
>
> I applied the first one, the fix for uniq(), but somehow the second
> didn't work for me as in your examples, nor the third, the output is the
> same as before.

I tried to repro the failure with a rebase but couldn't. I suspected
libsubcmd wasn't being rebuilt or something like that. I suspect now
that you have ~/.perfconfig with help.autocorrect set, which means the
output will vary as it will automatically try to run the autocorrected
command. Could you check for me?

Thanks,
Ian
