Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0E01624F3;
	Fri,  7 Mar 2025 02:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741313240; cv=none; b=Cpr+adedxjGg6aJ5XwcBXo4CbZ9HGBbv9DeKcH0tX8IKRkvjIj+hNuB8OGsQ+j/8SwFXtcWPdw3lnMrrbBCyOnAPbncjwXkSrhi/asAZ9h0CY/up+jsoWZPjuv5V7JK4leLNF0w0gVp8RTOii13OPtNbMs6eQv6fdGNxaeHHSNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741313240; c=relaxed/simple;
	bh=vUX2IWxwHVQnBwo2A0/9tWwdID1Albz7LWvfLeUVXRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=awUf6eD3p1n7Afb8Lx2k9c7yw7fFlfyPJ1VhtKf2Ezel/NWBS/mL8g2g2Pp6PFduIfOX6R/Hp+modF+4sVlL5YYQ3U7Jz3DbIjCgiy8XQbYYf5ODzrhDZ/Svwp0o7e3KoquqcG2432Dcjq7B4XhI4YauyFJ83mEXK4PYck2tNxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaVu4IJq; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaVu4IJq"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6f6c90b51c3so13068457b3.2;
        Thu, 06 Mar 2025 18:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741313238; x=1741918038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBS/9/JZqxGN5EhAdsD49AocUZOuPBBYW675wVUnCvk=;
        b=VaVu4IJq9jpAu74JgBCvQOOByyouK+IL69QhVyQ3dVBpcPeUZlpvNqN9GMNYEOoVSa
         jy4XNB+7EAMq5ydnH2xq3JzFrbB5VXpfwtHaGgyPkx3OBVKjXoy0EDDKywMGfvS8SmiE
         N6L8PIRT3wfNTHHom9ctI94XvlA4ZkDn54k5ytHxZvGlYfy0/uWMEV9mzaoiIG4zuu8q
         gc4Rog89Lgrh9tP1C/zQKTmZYuY+EOa6FWHD7/n9Y9AkGV0wqDaUtfLOrqRSBopMy6Lg
         runBkqIiw5YoByFVQYVwqaXdKcMKLCIqhuyBb9CH18N0tLqryPVG/xQlwUZpahqQitcg
         +Tbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741313238; x=1741918038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBS/9/JZqxGN5EhAdsD49AocUZOuPBBYW675wVUnCvk=;
        b=YVjfESqqh3qmcsk/oeplCH/iEGC+vyIEZ9UItpkDYUsYJhm0UxCAFW7W9Xs9Wc6Imw
         B5HydztuHvSy+0hx33UAJDnin1oi+byhsTpqRA/E1SCqzQdMABz8gOHKfcFHjAEm6ZUM
         viQg4Fl9QmF+Ofdx7lcXeecJZCUZC0JlgAkwTz46RuKKLMgwM/HZV6/Gv12Ofk6Py+Wh
         AxMF1E9+ExoiFVj+Ghoqpe3be8UW/LpksmilrJNgwNcNtRVbz/+dIuHo0uaGzeh0gm4M
         Rz+b33TiqcxkCHS0Ob8HSxhk9Mt0oocNT2R/kOGO38QtSYbzZr9r/wk2P5kxkOJqigkq
         GIXA==
X-Forwarded-Encrypted: i=1; AJvYcCVcYbEo0xZyuxzimUbuOt65zhQSbczyATVwCn8BDp46IjIOalxxGRbnqk+nv78XDJ0OZuDokEWUHqepQDM=@vger.kernel.org, AJvYcCWb2XEtvG0hxBOTQh4j006UQHp2KVroWLSZ6B1daL2S7ck+LRd/XXo1oOYWFmLChP48cWyIIKnFuE9X7jyQhV5PLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyukpvj1sy6OpUtAPhc37JLX8gncVerL2bi3/FA7OcgHsWx/ylt
	sjLhjIxHPWeWUvoVvurW+jqUFwIILhkwIu0MEqNrcAPVbTnquyna5RafTf4O0Xfcaz/2ljtD7My
	rRjoFOlilCet9B84mRXjqXxiEavI=
X-Gm-Gg: ASbGncvxgLU3AP7g44Iv0aiCS8sZhshmfHszidBSEkKfZckH+9BvzE66QSbNiApjj0k
	xoGmObKb8mliSBkq7StzjtUApS2Zk9NHfyum0KntOJoYAJZ9ZXODfLRNjH5XrSiyu8RJrTQgmgZ
	0/U29hE7ZdR5oj+nwUVae0mG4I
X-Google-Smtp-Source: AGHT+IHdiemz4ory7i/BDd2+Td5NPYBurE8U2C5eyTlufQa8fwOyusAfNvQudC8tRYbt2J8tG8bv0qXfnjNuZbI/+pQ=
X-Received: by 2002:a05:690c:7207:b0:6ef:4a1f:36d6 with SMTP id
 00721157ae682-6febf3ada0dmr27042057b3.23.1741313237976; Thu, 06 Mar 2025
 18:07:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228222308.626803-1-irogers@google.com>
In-Reply-To: <20250228222308.626803-1-irogers@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 6 Mar 2025 18:07:07 -0800
X-Gm-Features: AQ5f1JqR8MZAP-74zjHdeXFBCoVuG8ywW4I5h-pbH-0OIsgngYT8rb_cU3XyExM
Message-ID: <CAH0uvojZZR1C-NhL-ZG8WBEE+08wDaerfHQJBfe9AoPF7yNwtg@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] Python improvements for a real use of parse_events
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, James Clark <james.clark@linaro.org>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Ian,

On Fri, Feb 28, 2025 at 2:23=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> While parse_events access in python was added, it wasn't used by any
> python script. In enabling this for the tracepoint.py script a number
> of latent bugs and necessary improvements were discovered.
>
> v2: Fix a whitespace issue on the evlist.config patch spotted by
>     Howard and add his reviewed-by tags.
>
> Ian Rogers (11):
>   perf debug: Avoid stack overflow in recursive error message
>   perf evlist: Add success path to evlist__create_syswide_maps
>   perf evsel: tp_format accessing improvements
>   perf python: Add evlist enable and disable methods
>   perf python: Add member access to a number of evsel variables
>   perf python: Add optional cpus and threads arguments to parse_events
>   perf python: Update ungrouped evsel leader in clone
>   perf python: Avoid duplicated code in get_tracepoint_field
>   perf python: Add evlist all_cpus accessor
>   perf python: Add evlist.config to set up record options
>   perf python tracepoint: Switch to using parse_events

Reviewed-by: Howard Chu <howardchu95@gmail.com>

>
>  tools/perf/python/tracepoint.py |  23 +++---
>  tools/perf/util/debug.c         |   2 +-
>  tools/perf/util/evlist.c        |  13 ++--
>  tools/perf/util/evsel.c         |  16 +++-
>  tools/perf/util/python.c        | 127 ++++++++++++++++++++++++++++----
>  5 files changed, 145 insertions(+), 36 deletions(-)
>
> --
> 2.48.1.711.g2feabab25a-goog
>
