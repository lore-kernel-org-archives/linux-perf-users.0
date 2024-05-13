Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A91C1A716;
	Mon, 13 May 2024 01:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715564510; cv=none; b=MfjPgxVPh4oPCkEbDT6H//Uq9jv7wqIt3z42C97PC8YhmV/RX9P40H9p1P3bCC+HGOa5ntuVjO2tYqcBlq9/GPq3bPavlCkND6h4aJOh+Xj13dOEFhe05YiKMNoroeKydR7gXCDjX13R//fBoOb2GTD5HXb9jFY13fMOvwnSbmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715564510; c=relaxed/simple;
	bh=gPVICJwVKIiVjiqOsTste8M8OnhOlRqzyunclYLQ0U0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZgQ4LSC+400X/0UumNcMHzz26LnYk+B83VuBOBCwrGWkXfjaxCI+HWUTd4LRCRJ0nQUIRCCVwT47dFIyxDFjx0eSguwyD+nT8yUgGiLZEp0U9UehfuJ7Ik+4M9/n9FkPo/Eku1VeopBLOOPnQCfzrBdh4FPU6l/EY9qJCv9Gock=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso2167497a12.2;
        Sun, 12 May 2024 18:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715564508; x=1716169308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ye2EjiN/XTTt0S8bCyyBd7UgmTMg5tt11OB/Ky8cM7A=;
        b=fXFkRZkc5+1RBqj0Ozr7P6dT8v0zohzOcqlZV0yN4kg2xGMMjxzKhn5hrYadK4lRDT
         1RbF5PuKX580aMf3cXllHL2W0230NwMu/mo00GoMcpo1/oKetOIwO3QzdWKofWC8WhDD
         rdtTmEhiiRm4HX7JvhVoRvmLZfz9XXBwEojXMppFM9WP+bF5xFEfcEgBjTQT2U5QQDEG
         o5NandEOrLESp5qlElXzPFPSLgvKIrr6sK4kXQXDwheBJvkIcjw3wvKrosa4eP0prvhp
         un5T52SYo6iFbFI9PYQXnMdJmQqhzs1Jg5eeP8sRldDb0hznQZmeRyzAh01LPMO8a29R
         vVbA==
X-Forwarded-Encrypted: i=1; AJvYcCUlAA0AKjth4B9OiDvHbOIqtwBNXPcS1ibJTfo1+jEp4xfkSDk7EDdzV+GxpAHybqIRlrr7IV2QAvmnSWNV3j/IHcFUChNKZI90GfPNFD0jYQ==
X-Gm-Message-State: AOJu0Yw+QaumPc+/ALWIqaQ1sAb7Hh3Qx9mhutHMnwQmBu1BqcavaCO3
	uMC4jh1A0C+RUznI0nq0p6oZ93NIz4LXC4zAxCUTknPlkK3O0iLvWGfPPCG+4oLXbazxJUdLQrT
	IsBPSMJHsHEpLXm3KPb+gQtypGm+SQg==
X-Google-Smtp-Source: AGHT+IF46DOfGgZNaN5Gc2hE5Y2JtI9jHJ7luun7r6rZfXbrZDuJ9+RI4WDNsmUPMBZv/WTVegUqeFrUMCACQw21N/k=
X-Received: by 2002:a17:902:6bc4:b0:1ea:f9af:ee99 with SMTP id
 d9443c01a7336-1ef43d28276mr81565675ad.25.1715564508359; Sun, 12 May 2024
 18:41:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508134259.24413-1-nick.forrington@arm.com>
 <20240508134259.24413-2-nick.forrington@arm.com> <CAM9d7ciQ5idMLWO51JrpNEbFtdtrgz3o0qashX5dL2y1d1MRyw@mail.gmail.com>
 <45d28735-043f-43fd-bd2f-9dd8cb5259e8@arm.com>
In-Reply-To: <45d28735-043f-43fd-bd2f-9dd8cb5259e8@arm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Sun, 12 May 2024 18:41:36 -0700
Message-ID: <CAM9d7cgPRK1uayZd3fRB0gWzdugGKLycCWSsNRCPNx4fhEt6Sw@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf lock info: Display both map and thread by default
To: Nick Forrington <nick.forrington@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 3:01=E2=80=AFAM Nick Forrington <nick.forrington@arm=
.com> wrote:
>
> Hello,
>
> On 08/05/2024 22:18, Namhyung Kim wrote:
> > Hello,
> >
> > On Wed, May 8, 2024 at 6:46=E2=80=AFAM Nick Forrington <nick.forrington=
@arm.com> wrote:
> >> Change "perf lock info" argument handling to:
> >>
> >> Display both map and thread info (rather than an error) when neither a=
re
> >> specified.
> >>
> >> Display both map and thread info (rather than just thread info) when
> >> both are requested.
> >>
> >> Signed-off-by: Nick Forrington <nick.forrington@arm.com>
> >> ---
> >>   tools/perf/Documentation/perf-lock.txt |  4 ++--
> >>   tools/perf/builtin-lock.c              | 22 +++++++++++++++++-----
> >>   2 files changed, 19 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Docum=
entation/perf-lock.txt
> >> index f5938d616d75..57a940399de0 100644
> >> --- a/tools/perf/Documentation/perf-lock.txt
> >> +++ b/tools/perf/Documentation/perf-lock.txt
> >> @@ -111,11 +111,11 @@ INFO OPTIONS
> >>
> >>   -t::
> >>   --threads::
> >> -       dump thread list in perf.data
> >> +       dump only the thread list in perf.data
> >>
> >>   -m::
> >>   --map::
> >> -       dump map of lock instances (address:name table)
> >> +       dump only the map of lock instances (address:name table)
> >>
> >>
> >>   CONTENTION OPTIONS
> >> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> >> index 230461280e45..d0b8645487ad 100644
> >> --- a/tools/perf/builtin-lock.c
> >> +++ b/tools/perf/builtin-lock.c
> >> @@ -1483,11 +1483,16 @@ static int dump_info(void)
> >>
> >>          if (info_threads)
> >>                  dump_threads();
> >> -       else if (info_map)
> >> +
> >> +       if (info_map) {
> >> +               if (info_threads)
> >> +                       fputc('\n', lock_output);
> > it seems you need pr_info("\n").  Where does lock_output come from?
>
>
> It's a static FILE* that defaults to stderr.

Oh, right.  I somehow confused this with perf sched. ;-p

>
>
> It's used by dump_threads and dump_map (via fprintf), so I think it
> makes sense to use it for the output spacing between them?
>
> >
> >
> >>                  dump_map();
> >> -       else {
> >> +       }
> >> +
> >> +       if (!info_threads && !info_map) {
> >>                  rc =3D -1;
> >> -               pr_err("Unknown type of information\n");
> >> +               pr_err("No lock info specified\n");
> >>          }
> > I think we can remove this block now.
>
>
> The original error looked like a function input sanity check (rather
> than for handling user input), so I kept it (even if it should no longer
> be possible for a user to trigger it).
>
>
> Although I can remove it (or move it to the start of the function) if
> you prefer.

Yep, I think we can just remove it.

Thanks,
Namhyung
