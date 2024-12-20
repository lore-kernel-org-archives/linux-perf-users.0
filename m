Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7C0219A69
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2024 18:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734721092; cv=none; b=k4V445K4lGxu6luv59iyO9Du+KmaC9oL+wGsFA88U8DUKyB83qgt87Qcz1CWzgOKru2MU9h8lAlrLtcHinTUOPF0nx+PXBeOOKwMWvA7ts/XlH8O7CbFyxMD531TXvdvKRtQGeGKV1JKndkio7jqfxg2UE/qOFaCCqhB7+9ddLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734721092; c=relaxed/simple;
	bh=eQNf0lehN9bu6pzS2nXqn+cmD4eNslzOIzOKkjAUAkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T1BGG+w6KremN82oDg4TkpX9L6fsvrPM6+AU2a546fPiBvKdHUA1MZ4CjZjl8QLJRVJosb8ZDW43jaAQdNTk0124bftiecoSBRcGBjArjWzrSBdh/KJcC9D5x8vuSOOtrdZZr79MHtu72gAksCWXkVJGKaciCVagxTpzWDFM8js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MH+SlS3n; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MH+SlS3n"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a814c54742so202345ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2024 10:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734721090; x=1735325890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3T6I6yTFYH8S6DxobwgqkBfUF81QdpsYlHmc2eOu2U=;
        b=MH+SlS3nz2D8g0+vEblrrbtIU7qlT6hMO6OMUgp5jAzbQRVh+Jz2em9sr3rJok8dwZ
         vxbRIsdUYV5YXfZLODEJ6kApMlGZhJSbuIB6JhYZaRj0exK2MELIowKKT9Ap4G5TWlBV
         pGdoWMsAoj1N2Hq2Rvt9wJBtAsp4JavIfpEsAtWCbNGTfOuTeOuWM+7iUUObVUTo3LAd
         q7z1jtU3lxCtri7U+xPYYrllB2zBYkJKZqn91zGiaPMT1bxXE6dqBTH/8aG293NcHytH
         mxT4FUQetbCJ2JX8hFkM+a7luZefHnHQRD79mOe92q5ARL33vNwnB6Xh0YvjuSGpdhi+
         ve/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734721090; x=1735325890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3T6I6yTFYH8S6DxobwgqkBfUF81QdpsYlHmc2eOu2U=;
        b=j76FwYxOzaZ/j0kbHboND80Y8eyh2I0mOdNBX9igegvJ5kmrDYixcl6b7lRF4g0cNl
         r+oTVlHUBbvsFwzPWG2tJE/jbMz0ShYG3r5axOYzmGv8NuiuEc80++qwdlsX1Eq7d3cc
         PgTBpVC04an89sELNCwTaC2QrntWiYr0MQOEYzfTARMDOjXeli0dvcxuozhIomg43YGG
         rJner0EzQaQss7CxiWLGfqC3gTOETDa8RKIWzzvEE9API7Cttgjx+mWwNm5fOsvYNG1c
         jiv63b3gvLiEzx5DYGGxActDkj6/a9OtoM0ythcI/VjYBb3E+myMv0+fNbMUyP4QOsVC
         BTGg==
X-Forwarded-Encrypted: i=1; AJvYcCW0FReuXc9xYkW7yvgfVizwxsEjxX70OZi09DhID7RLbohgsgs6CeNfkChv3BDjWO2PnnVswJO/Ei1tpJcjtiac@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5zNMwVDjfKaWi9Lw/1H9WJJyzo2YM/gUGOIW2xYf4uC6h6bVV
	m4JKD/3YfuCxbvcxuopz188IzWMPFRgVt2oyVH3z3SdGFhb+6k09oZ2X2LXMw7+W8ffxqy/ogpF
	sikz8P1TD69j5g4QQMEHKhjZUun9KiFUDlYGB
X-Gm-Gg: ASbGnctEwZrXEBvLI8CZC4bgY7WHJuLEHdXEGokUDyQkKWnWEF0EebP57yVFljaWZch
	Nywrlcej2P2Vy2RBWOKDGGkKopolv0UMMJJnN3vI=
X-Google-Smtp-Source: AGHT+IHikTcVQ+NPdRAIGv8ZQQ8Oj5vgYEoofX6mJwa8r7Hji1aTptVSp3qh5lD8sX0rYg3FXzVWMNY/jA5joJUApZw=
X-Received: by 2002:a92:d205:0:b0:3a7:cd21:493f with SMTP id
 e9e14a558f8ab-3c2e43f2c78mr3636515ab.26.1734721089684; Fri, 20 Dec 2024
 10:58:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114230713.330701-1-irogers@google.com> <Z1zNuQaqtDDoQhP6@google.com>
In-Reply-To: <Z1zNuQaqtDDoQhP6@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 20 Dec 2024 10:57:58 -0800
Message-ID: <CAP-5=fXOdoyuXwTC2coFUAg_ruaYqj3KVe27YjcBtHCAFt_NeA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Prefer evsel over evsel->core.idx
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Andi Kleen <ak@linux.intel.com>, 
	=?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>, 
	Chen Ni <nichen@iscas.ac.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 4:13=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Nov 14, 2024 at 03:07:10PM -0800, Ian Rogers wrote:
> > James Clark's patches fixing evsel->core.idx [1] reminded me that we
> > pass the int value around unnecessarily. Passing the evsel avoids
> > issues if the evlist is reordered but paired with sanitizers we can
> > also know when something is used when it shouldn't be. These patches
> > do some initial work reducing the use of evsel->core.idx or reducing
> > the API to pass evsels and not their interior index.
> >
> > [1] https://lore.kernel.org/lkml/20241114160450.295844-2-james.clark@li=
naro.org/
> >
> > Ian Rogers (3):
> >   perf stream: Use evsel rather than evsel->idx
> >   perf values: Use evsel rather than evsel->idx
> >   perf annotate: Prefer passing evsel to evsel->core.idx

Ping.

Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: James Clark <james.clark@linaro.org>

Thanks,
Ian
