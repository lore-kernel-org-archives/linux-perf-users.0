Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9360780B;
	Wed,  2 Apr 2025 01:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743556049; cv=none; b=lzoVLpp7zdGke0otlX+c+51sHCxNPS6MkwRn2KgIOlO9UoTa/xCR4+6dcaA4JZ+5kLQCCUmcJ/YH8GYDePe7Ydjm7lRF3rBkhPmeTHnyjVwzlPqEhysAkDw91t36K2Y5KVmsCdjjbi7XTr2CfGlzib7ZZkS2gq27ZY5rfTFThvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743556049; c=relaxed/simple;
	bh=5PZesHeW3FmH0zI46qagmvpB3+cAWyaw3+Q+BiOdv20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c6o3++RXWYL4HL2oUOdHVrXFmKqXkfcNx2vexRtK0idc2ZEWYTkdycsB2T4iYz077/s4Bvk7nji94iielOie1nF/4zVJTLzZOaRMA1fL2DvT7WBlVeCBssfGIAWH3xg/F3nFk59PUhUby7hmwjiPRBmDRguuEw60JsKpHJlwLhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQPOsnGS; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQPOsnGS"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6f74b78df93so70874457b3.0;
        Tue, 01 Apr 2025 18:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743556046; x=1744160846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oxF+p5em2VYpqRHWZtHX7g5OjoPMVbjbFeP48P7SxY=;
        b=gQPOsnGS2sCUEE4wTvFZvGDH04QfBzyHJONXs4poQQpzLgpOzDaAHQb7k/mdsTe2d4
         gWfjin16k2wZmKpoSbRHTMXkjOx1K3f0VlBPVQXl7AZXBDR9b2fB7/Xytxs7R1VYcgps
         beVpxZqA/am+nUCQ1ioRcBwqK/pJcq66looj/TmT4PA/ieaq+ZZvky+ipnq5ynh0eZHF
         kK59zVJRQ0+VqA6/NuyyiFfyt8yo7o5VlfbomZB9e3lJyO3roYVLEuWnj9M79P30i+DP
         q1yuswtBHE/bbxRl+Vn20Wyp1Nl5CUWHcafP5oqIkqeUwA+S1Utrcns0paOcL+qOycrS
         WrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743556046; x=1744160846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/oxF+p5em2VYpqRHWZtHX7g5OjoPMVbjbFeP48P7SxY=;
        b=L+1f1juCbFizwtAcHhmcHipjJK1UgIjiFCsEVtB6/cx4Gtk80GCehVKWJN7ZCDBiXB
         +YRuaB3Wb8ytBCQ8wAp1Frb4qGbrcwsG40DvQs16d1DZkqMvbrPu86jbP2rFaLZZaOvC
         cs2ZQBKynUr4UDUw78ge9j1EGbqxzWCMY5fXTws6g1IfcU+viExFX3OB6BXmtfb20wDI
         526vs2blJWx0jYE5dPg8EGGJ+O8I28dUK2lKj5eiOFiXzKfQ8+2upBH8HxypKnqVmfH5
         anR+cQyXpBto/LEjP5coGmNFHYFl15fLPaDqnMr6am+94JEeQof25ZeibdPP/a+0scSv
         Rhlw==
X-Forwarded-Encrypted: i=1; AJvYcCUDnG/zLAprHJAINz7FLZcWfjyPhGdicvbwt3HTkVpenUbmbSjYxFVEd2m7lhZOmEPz0vinriqZXxlU2a4=@vger.kernel.org, AJvYcCXL+5rtGzsYfkrTg6cIlshjzIGUcH+l1/LJ14EU3unefszyj1k1VUrajYKAj5CoS2YhLJYs+UO2zN2zI9f0GFcNcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZuiCPj6VfryMhnvi6+s+D6JFXTWai6sk0fRGFxa7hcgYYOS2f
	e3jhvyxgy5KkmfMBdOtCq19Mh33GstCTVp/ASFSCIBoI6PewngBn6G9qufUZ2x9xHGJvuJ5l8Br
	v8z6CbI6wKMJJ+sKDsD282sPB+Es=
X-Gm-Gg: ASbGnctgolvKA3ThPk84eRexJVvDWnGXy5kVg63VsWpyk+o8DG4HyfNwL5TLzwSU6Rv
	+K+Y8DAdu1E24M7SdVRVRU2cTrl0o2nQAeCGKVfKAqL/YCOULX1BnxppBqlwbjs8UX+kX/rxxOP
	e1GxdaQMz1pTsKtPiUm8457p4E
X-Google-Smtp-Source: AGHT+IGHdyt7ATG8saEPHInkDsfS2SbzdYlFSB9ZTEx7N29oPWAzPreH+Xdjio/K7RgguyLPJxjDyW69EylaCYAoStY=
X-Received: by 2002:a05:690c:6e08:b0:6fd:34c7:280b with SMTP id
 00721157ae682-702570df85cmr198241777b3.5.1743556046330; Tue, 01 Apr 2025
 18:07:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331184638.3856982-1-namhyung@kernel.org>
In-Reply-To: <20250331184638.3856982-1-namhyung@kernel.org>
From: Howard Chu <howardchu95@gmail.com>
Date: Tue, 1 Apr 2025 18:07:15 -0700
X-Gm-Features: AQ5f1JoORAAUrvTsmhzebYXpG_ZOK_mFZj1KngdWpqGDjQqPlObv2dxbUQOZF6A
Message-ID: <CAH0uvohL4cFXukxhY6G4WfAWXqPOi3HbEHv=_KWixBQmgon2KQ@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Fix some leaks of struct thread
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

On Mon, Mar 31, 2025 at 11:46=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> I've found some leaks from 'perf trace -a'.  It seems there are more
> leaks but this is what I can find for now.
>
> Cc: Howard Chu <howardchu95@gmail.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-trace.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 3d0c0076884d34cb..10cd99888a9a11b5 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2835,7 +2835,7 @@ static int trace__fprintf_sys_enter(struct trace *t=
race, struct evsel *evsel,
>         e_machine =3D thread__e_machine(thread, trace->host);
>         sc =3D trace__syscall_info(trace, evsel, e_machine, id);
>         if (sc =3D=3D NULL)
> -               return -1;
> +               goto out_put;
>         ttrace =3D thread__trace(thread, trace);
>         /*
>          * We need to get ttrace just to make sure it is there when sysca=
ll__scnprintf_args()
> @@ -4123,8 +4123,10 @@ static int trace__set_filter_loop_pids(struct trac=
e *trace)
>                         pids[nr++] =3D thread__tid(parent);

I suggest adding a:
thread_put(parent);
here, just before the break.

>                         break;
>                 }
> +               thread__put(thread);
>                 thread =3D parent;
>         }
> +       thread__put(thread);
>
>         err =3D evlist__append_tp_filter_pids(trace->evlist, nr, pids);
>         if (!err && trace->filter_pids.map)
> --
> 2.49.0.472.ge94155a9ec-goog
>

Thanks,
Howard
