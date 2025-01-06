Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3801FBF6
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jan 2025 20:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736195056; cv=none; b=dt+5RgtLN/Ywh4X2YsikR+4vfDjPm3KTL+/58+gxq8dVEe+TzaV+nxxVkzb20R8ceUf1rjFhFyHOj3EUTQf+QnhwGUduGFgAmFjWswF7X8P5YUriPcb8p+QIpMDSBkmN5y7E9GSIrMgP+9rU7DOEs/ayt2EZk97vd9CHiXC1mVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736195056; c=relaxed/simple;
	bh=J1k+mHRA5ip1YUZGgzIdS4x5nnMQ4ZxFCoposnIfKnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S01aQTcp38v4f9uHnM9vpt8fjGcKEbAWHq79Q0lkIzoNCydGz2pF4x0bRzCYPlbrpDHfwuMzv+hhFoa0nfYVv/aIc+3co0fN2iLeBzD6Q6nqx8yQ0caGRT0WNvVkrYdXRIkMsoyzaWGnr/pPwgCwQFgQqGA+N8Os0rTgSTBCLFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HHD74icR; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HHD74icR"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso22035ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Jan 2025 12:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736195054; x=1736799854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pK73faD2iUHU43HzvTFZI0Cc/e5Ytr8pBdbyU/Jw7w=;
        b=HHD74icRuj/fFG+nFrKBWKykNa/bAxxLzvbqrNhOfMG4dbaommCPgRFywG9ctwqSaE
         0fAAd/iIoqLfOsq/wai6WzQrn+Baze1G29WAcjjjaGKeS4WbFxZ0m7o5bLDJyKi0MvZj
         lA1uqeNgYWyuHnIc2FwL2j7UUcr0/YMEHyHdJsd+Ywqhp/MVyD+3W/K2eu6DRXy7NO+G
         0zRPvpmgZmLFm4/mMikXhIBM+IhfNegbzsu3S4CvVIvpqQyDu/jKGtmhN5DPdDX74GVd
         ab7+mzcFMOsesFone5c5WI5mDCYLQJcWj2Qb6fIoTEc06/zGDaaHfnvBdJa4tpfUY7xD
         XzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736195054; x=1736799854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pK73faD2iUHU43HzvTFZI0Cc/e5Ytr8pBdbyU/Jw7w=;
        b=apVd23uhf5FaiIfPylwOJ14etoBSEc3iyEJTwKKrnSdTTGzM3htpYJrSjg6F0uGVrX
         q9NT3yUkIXT3XosLWulMpHq7zHAKgH1XUWpWwRopYekOI+ph4vMheiQ6q/TyxzTYFdqL
         8uqC8kFC6YxqKLr4R6noi1zPpn05CMGKQ+erzlKXW/2ETDFVQOFpeHal5qCfUhKzwcQw
         cBCmGMsz/bRr2RukUhX+aqo0Wc5e9kL6Q698S/ED8lAWSf8XRdIk3sKhj/gySZoXf5wp
         uFb6Qb8XYP889G39qMcwvmTPQTbeLpUDPaXnBDRWI0L3IrpYf/M1m8U8YChxXJzpLDEV
         SFSA==
X-Forwarded-Encrypted: i=1; AJvYcCV6Qj/NjAqX5N8w/UpUZ3BC16frQK5u7Fimw12HSjH+BIGF85ztQTTPRIV0WczW026jDmbhkePYd3HgzAa6ey8t@vger.kernel.org
X-Gm-Message-State: AOJu0YxS3xFBJ0q3vlAFMCqO4zI78U9Pk0/TCe8fRVhc97BcypaQ7rum
	vQlivTrEnvkg9dHObWrT0QPE5w+64S89rYWoVRQcYRlfaTQ60a4aAbysZTcJEgoXTNA8scYutBY
	CQt3CgGe86WqFpZDdZo78oPuDmf9HZOQ385wS
X-Gm-Gg: ASbGncuRt3/Z+gMf/kHSWegufkuzw7TAccr+FZro0RDJdx3+4H9uHwU5t9PICuWlzPC
	ilkoH5rBSuZGyEOLzvPlDJf1Ag1U7rgh/esY9KD7c4pq8LtaNdYyrdRrAL3uPgKI3KKjt
X-Google-Smtp-Source: AGHT+IG/x5R/zua5r2i6YsQhWKKZ2ogrxjvF/cbOiTTSPADkG+pErtfI7/WJKmkrTs/Ppy0SdSu5BFv+/dRQEuollP4=
X-Received: by 2002:a92:d205:0:b0:3a7:6126:ca3 with SMTP id
 e9e14a558f8ab-3ce32459024mr444465ab.24.1736195053560; Mon, 06 Jan 2025
 12:24:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8c8553387ebf904a9e5a93eaf643cb01164d9fb3.1736188471.git.christophe.leroy@csgroup.eu>
 <3fda227e6ff229b5063d4181ecf75567ca016c18.1736188475.git.christophe.leroy@csgroup.eu>
In-Reply-To: <3fda227e6ff229b5063d4181ecf75567ca016c18.1736188475.git.christophe.leroy@csgroup.eu>
From: Ian Rogers <irogers@google.com>
Date: Mon, 6 Jan 2025 12:24:02 -0800
Message-ID: <CAP-5=fX2mr_N8fqScrb9Sr4b+Y726J9StGn7T3_Qfx36-Q=T5A@mail.gmail.com>
Subject: Re: [PATCH] perf: Fix display of kernel symbols
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 11:38=E2=80=AFAM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> Since commit 659ad3492b91 ("perf maps: Switch from rbtree to lazily
> sorted array for addresses"), perf doesn't display anymore kernel
> symbols on powerpc, allthough it still detects them as kernel addresses.
>
>         # Overhead  Command     Shared Object  Symbol
>         # ........  ..........  ............. ...........................=
...........
>         #
>             80.49%  Coeur main  [unknown]      [k] 0xc005f0f8
>              3.91%  Coeur main  gau            [.] engine_loop.constprop.=
0.isra.0
>              1.72%  Coeur main  [unknown]      [k] 0xc005f11c
>              1.09%  Coeur main  [unknown]      [k] 0xc01f82c8
>              0.44%  Coeur main  libc.so.6      [.] epoll_wait
>              0.38%  Coeur main  [unknown]      [k] 0xc0011718
>              0.36%  Coeur main  [unknown]      [k] 0xc01f45c0
>
> This is because function maps__find_next_entry() now returns current
> entry instead of next entry, leading to kernel map end address
> getting mis-configured with its own start address instead of the
> start address of the following map.
>
> Fix it by really taking the next entry.
>
> Fixes: 659ad3492b91 ("perf maps: Switch from rbtree to lazily sorted arra=
y for addresses")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/maps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index 432399cbe5dd..d39bf27a5fdd 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c
> @@ -1137,7 +1137,7 @@ struct map *maps__find_next_entry(struct maps *maps=
, struct map *map)
>
>         down_read(maps__lock(maps));
>         i =3D maps__by_address_index(maps, map);
> -       if (i < maps__nr_maps(maps))
> +       if (++i < maps__nr_maps(maps))
>                 result =3D map__get(maps__maps_by_address(maps)[i]);

Thanks for diagnosing this and sorry for the bug! Using the next entry
in this way won't work if the entries aren't sorted. I think the code
needs to be a little more complex, something like:
```
while (1) {
    down_read(maps__lock(maps));
    if (!maps__maps_by_address_sorted(maps)) {
        up_read(maps__lock(maps));
        maps__sort_by_address(maps);
        continue;
    }
    i =3D maps__by_address_index(maps, map) + 1;
    if (i < maps__nr_maps(maps))
        result =3D map__get(maps__maps_by_address(maps)[i]);
    up_read(maps__lock(maps));
    break;
}
```
We could also implement the code similar to maps__by_address_index but
with some kind of best next value in the unsorted case. Given the
function has a single caller then this is probably overkill, but we've
seen performance issues in this code before.

Thanks,
Ian
