Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107F617984
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Apr 2024 03:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714015119; cv=none; b=aumCEEPiuDrzgGFeOaYJf48SG9AmA/7I5oqIudekuwJ8JKnR6LhSsm32N4kycJRtjPRUOqbW34HJwVOFFY3w5JYXEi5vZRlQRuI09aAa3RuADAc/Vd6Kk4JKNqzvnKwoz6Sqiv8nCv/6Wm2ea+Zq1seGOMFLv+go8IjMyeaTfjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714015119; c=relaxed/simple;
	bh=Ns7Fo30/xpBBMDoCH6XFa8kXXTSy9aXlglwSRJUr1S4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bk6EQYsEImPePWJAiG5RhKXyGqb+Nt4DwCLswYvx8L9MRlBj6eOeIEdF+TB1XhVBTVQQDSTAw2cnLxLBWAKcpvOH3ysnyhARqk2hvaNg/b80q/EmJvskIjW2vhoUcesUacou+lg5/Pr0w2pVOu3C6tzVPU6VTVZrYahDRnr3Gac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GjOHtVYT; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GjOHtVYT"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36b3738f01cso73915ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Apr 2024 20:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714015116; x=1714619916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPYiVyxMu3u5xOHBv4eVLhhrFMPrsWmts8AO796WRkI=;
        b=GjOHtVYT1xniLQ9wjvVzxdDXqV5eK08Gc4QHHABtW9UFer34tOnrfAZfhsahNWDsUk
         CZw4d9gMRi+4vXyOe/ZfqfrNxnhASnFCsGLygs1oycmJXQXzSBgNiGk0g8feKTArcSSZ
         +mAwY9w/7U53NbtIDd5DSgEdpRUT60bEHSe+eZOX4JxFQ2X3x4H6BX8ebPlRDm7J7tFS
         6FXUrYTD1EbwqHfTYoFyfyPKqH3Hgug15KatOauv4f9yWB2KXtMbEHqNhSGA4ihqkquG
         SoRSWPvvk4wG9TYMD5GSTdzXz7uCOS1jFWnin22KRlThVhGJC0wGf2WyvPNYhhoJoq99
         2/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714015116; x=1714619916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPYiVyxMu3u5xOHBv4eVLhhrFMPrsWmts8AO796WRkI=;
        b=ssTRT5H/p3/bCtn+tw9WrVIr3xZ2XkakT1VcWqgqsgAie4nFpzu5kwJ82zYzXHMM8t
         3/yZRDRTpxia9WjNmvJpdWyLNgvJzf1ndFcPF2QemhKd9PA4YnDyqSjjLsr0MIBRs7jL
         X8tLEXT6WZJy+KeWe46b8mgSjx2c1Xaw7W0UGmsKp2PlCXlybsRD6H6YBNpJXpkCqPJ6
         y3WpUZXKQci/Z+aHCNxIGEOjVc418xan9XmWO5WMiA5rPlT9t9AuESXHgOaUaWIOZZXT
         KssLzxB0eob59Ugx6p+4Yc19Eu+pvA1A2/J6DE4yefb1ayucP+USRlVEFbq9sRsdLMVI
         D4Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVCZb2qZIx7erPVRRY8rsimgvrJEbsRD8P7ZhOCk6/leivgIafJMAUIL7vx8ULRW6lBhlXiGLJ8nS1kcJhMOFHsmrmABsvKR46aAPq4kHv7kg==
X-Gm-Message-State: AOJu0Ywk4aDSGNbSrAU25DdNNhdE5MBQhLPjr5t6qj9ZoI9AUbygqdBx
	dRUJbID5WWRAqUIn129IMftkjtRRkXc7/nMAgPX0UNgs7OthG6LnLd0hZqeFa19VVoW2Wh8ucoL
	rKfhYYLCivKpBqBZi1BeJnYs7rk5KRL+Arl5IcAGc18YT332zDPc1
X-Google-Smtp-Source: AGHT+IHF+CVLmAdpjL8XDaGa9FnoI/B07c0ipnHIB8jLOOAXa3rQAeDSGJB4Zy4e7sRp9tCchiO6pzYblkTQeU1g9WY=
X-Received: by 2002:a05:6e02:68b:b0:36b:2eee:85c2 with SMTP id
 o11-20020a056e02068b00b0036b2eee85c2mr95258ils.15.1714015116024; Wed, 24 Apr
 2024 20:18:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424230015.1054013-1-namhyung@kernel.org>
In-Reply-To: <20240424230015.1054013-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 24 Apr 2024 20:18:24 -0700
Message-ID: <CAP-5=fV5mgVqi2rEgV1hY0BSCZ_6dLKjc0Mp=EDxDirzmB9qPg@mail.gmail.com>
Subject: Re: [PATCH] perf annotate-data: Check annotation on perf report TUI
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 4:00=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> As it removed the sample accounting for code when no symbol sort key is
> given for perf report TUI, it might not allocate the annotated_source
> yet.  Let's check if it's NULL first.
>
> Fixes: 6cdd977ec24e1 ("perf report: Do not collect sample histogram unnec=
essarily")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/annotate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index dca2c08ab8c5..f5b6b5e5e757 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -906,7 +906,7 @@ int symbol__annotate(struct map_symbol *ms, struct ev=
sel *evsel,
>         if (parch)
>                 *parch =3D arch;
>
> -       if (!list_empty(&notes->src->source))
> +       if (notes->src && !list_empty(&notes->src->source))
>                 return 0;
>
>         args.arch =3D arch;
> --
> 2.44.0.769.g3c40516874-goog
>
>
