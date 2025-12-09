Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBC0301489
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Dec 2025 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765298426; cv=none; b=PbAh5zOphSD2PQ2B5oUYEYfiRmxTwJ2DbD8LwAZNiURCrSQlktHgAXjPmNwdkHPtq1/tgpmPBH5x3W3sDyzPguDor6rRXF6DD1QOzgNwT6cr/2i2Xh6T3ZUNuj+ask9fct2popXTgE53xm0npdw2AnQaVEv5nhSN+72WDSRGnOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765298426; c=relaxed/simple;
	bh=JvFF6+FOKEAOJj9t/hxDHDO1jVTcnLAYiVmuSofMOCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KTfCX4U0xKlL767udOo6+uakrD0cUsG5lqq3ZsA7ZMs6oGcoHY4gmWVSSN5r1jN1B83M9LW/g+xrve50HPkM7Yl6hdfw5ClXBhSQT1FfwNnbawHE1bLAGjODXaUdIT1Ra81baDZGQEyLFdFqaBygoYkcSGfNLgfl2zmMGIv45ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cYV6hfle; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cYV6hfle"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29e7ec26e3dso252895ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Dec 2025 08:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765298424; x=1765903224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIKlOB/KgpJP9kT0dnjJxhFbF65TR4r34o2YIc6jtW4=;
        b=cYV6hfleOG4s2Xj8TORMH/MEzSoM1XY+wzrjv+3M0wqUlgy8BiC6HnQwf3JGxnjeSA
         ODYaJ0bAyPYv49ZXj7AApUYroUjAI6NoAt6oFe6dESqsQWTaqxE0GqJaqQhveDctsMQP
         SQwAf/jWd4BGvSHHPoOffVkBQlHQtlG3T7TR49re+5/hHcPeDxOaH5xV9q9mk8EY9k9H
         jWgRbehXbgbAJMaypGApx2F8+zbeAnJIBFckGskru1s/bsVRIR/1UO4rYZrFaONPhnKX
         kfyZLH8gb6TZzdLDcAQV5PztKSTxahnTvFpboEg7FNdnLSPxfnS/DdS1Nk2i6VYHwiWZ
         JJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765298424; x=1765903224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QIKlOB/KgpJP9kT0dnjJxhFbF65TR4r34o2YIc6jtW4=;
        b=vcsQOfTY7Q86bYFL67IdzSopd7yLJ3a/zoQ14KRsxXD0Wvp6SKb0bQEq/rhcr503CF
         2/NmLfe1Tvkyd5ypEdPEhjyZShWuahuG9TqC39nKIe7lEAjf4z6wtM3HEp/TKwye0OBm
         QkiUg2kBoDg4uwMBTQ9aAMTD4k9UmB/3q9WqdAvRWcYzNITF1LZdDOyrjBgyZEXl6zuG
         y4yw0Gc4flqdzpnpVKZswcZVBA3IXodo0nABBpDnNIipZ4Pp4UxwBFUGrsRKTd40RN5k
         DjBx1d5oHjs0eLny3G5gthiNaGknarL0R+/3UiCdEwHDZ2K6cZEfpOxNkW/VYwZRr4VH
         QH6A==
X-Forwarded-Encrypted: i=1; AJvYcCVoGv/rD+Ofyt6gq58Zps4sS7IwVgrmlg3avV3kstahD0vYsjUUyqtr4by3XalWCBjdufqXS83KNXZAQHUjOGdA@vger.kernel.org
X-Gm-Message-State: AOJu0YwLHt0+0hHwRrATQllxrAOQdDyAU6/zZZqUmdoISIuDrudphvkv
	5WvROWEHAKIrX2QbLBbNm5oPolJRSKn1RQOhXq7Gi6lCGunqtgkRN6sYGO+SLRfMVfZkHuzJUHr
	/4DVg4zHTa6ws3ISp6m83UtcqHox6rSUl8r0arhlw
X-Gm-Gg: AY/fxX5GOVPEXgTu6C/L8BNyA/NIUwjUFLoh2Iesb8U/xciyqtQYmR8xG5OBo3DgkhC
	b9Yfv6dpwBjtCPlBr8po73b5uKIiUDzqkqyYqma82IDc1LCNseCTz1prFT3JayVkAB4y8AvKKgO
	JUnftL9WgjZD4YOxzxfLBmtdRAW4BIl1Q9k0gMiO/x0GOCF96YSAcSm1CGCnkSb94vp3FvYf6ZM
	P7E5tzPqI4AsSG5oL8qSHIQ2m2YKsL+2UGWa8vNynAOabJsx+qUW5+CG1m08yg/p9BBMAwX2OBH
	XF4laDNWeUQ2eDAPrNMQsmkf
X-Google-Smtp-Source: AGHT+IG+tXtxqxAs5MZsdZ8QQBhYZxwYfw3KSnJRGGNeVnKDA+uhxtLhn7sIFa6Z7B6HlmBTov8Y3nqdUn5WPLykovg=
X-Received: by 2002:a17:903:22c9:b0:298:3544:aa72 with SMTP id
 d9443c01a7336-29e99730116mr3216545ad.9.1765298423750; Tue, 09 Dec 2025
 08:40:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209105029.142517-1-tmricht@linux.ibm.com>
In-Reply-To: <20251209105029.142517-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 9 Dec 2025 08:40:12 -0800
X-Gm-Features: AQt7F2o2b-TqXVYAJS0WsHVzROtpYWKCgPgSD2vNxwquDaWtEtxWSQOanCjh5Kk
Message-ID: <CAP-5=fVxFEzOwQN610gE9F5XiHYP2wHKD6K5zfBHhFOrxD1fDw@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix test case perf evlist tests for s390x
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 2:50=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.co=
m> wrote:
>
> Perf test case 78: perf evlist tests fails on s390. The failure
> is causes by grouping events cycles and instructions because
> sampling does only support event cycles.
> Change the group to -e '{cycles,cycles}' to fix this.
>
> Output before:
>   # ./perf test 78
>   78: perf evlist tests              : FAILED!
>   #
>
> Output after:
>   # ./perf test 78
>   78: perf evlist tests              : Ok
>   #
>
> Fixes: db452961de939 ("perf tests evlist: Add basic evlist test")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Thanks Thomas, I always appreciate your help and fixes! Do you think
we should switch to software events to remedy this issue? Perhaps
cpu-clock and task-clock? I worry about event deduplication possibly
causing issues were it to happen.

Thanks,
Ian

> ---
>  tools/perf/tests/shell/evlist.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/shell/evlist.sh b/tools/perf/tests/shell/ev=
list.sh
> index 140f099e75c1..80f808b3059d 100755
> --- a/tools/perf/tests/shell/evlist.sh
> +++ b/tools/perf/tests/shell/evlist.sh
> @@ -38,13 +38,13 @@ test_evlist_simple() {
>
>  test_evlist_group() {
>         echo "Group evlist test"
> -       if ! perf record -e "{cycles,instructions}" -o "${perfdata}" true=
 2> /dev/null
> +       if ! perf record -e "{cycles,cycles}" -o "${perfdata}" true 2> /d=
ev/null
>         then
>                 echo "Group evlist [Skipped event group recording failed]=
"
>                 return
>         fi
>
> -       if ! perf evlist -i "${perfdata}" -g | grep -q "{.*cycles.*,.*ins=
tructions.*}"
> +       if ! perf evlist -i "${perfdata}" -g | grep -q "{.*cycles.*,.*cyc=
les.*}"
>         then
>                 echo "Group evlist [Failed to list event group]"
>                 err=3D1
> --
> 2.52.0
>
