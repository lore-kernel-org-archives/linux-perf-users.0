Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BA0EC2;
	Tue, 24 Dec 2024 02:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735005804; cv=none; b=jwM981YFNpDXk+hBT9R0vm7DtTAAdWvjQwOwMzUxAUHfvwWyReoqDzihjSiQkAu5/7M7dehxFrhMvrCEnc+IuR7YOpXs0CUIiFwbtaHOlUIhWxk8GcYzkzgFHY/5k7aNeBv5OK+k1g9yBe/ylPQ8+JylrXXV5bV2JrgSi74xVP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735005804; c=relaxed/simple;
	bh=vltnjx80fJ62DR+0f0CD+LFdYg/1BgcxotsUBA87WV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/PjmHqER2/2uET+OhYqqLuE0ZXQw+Vr3SCCXUli0rIwpYjNxU7Kb7kJ4F+7fCLwoL8WPAc7S1OpONxhUX9qpJh0EMYrGtKbRScaCZQKE+Y2j8dY+/Og0rfraMyUuuKcZV3EbcVBmvu48fSlN3jP8hKC0AYbWe0ChlcGXVkyyQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bm/iFqBa; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bm/iFqBa"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e3a1cfeb711so3401140276.0;
        Mon, 23 Dec 2024 18:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735005802; x=1735610602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/EJ2Eb3Tn2rBoUBe+TFvM932Gu8zY+2YkqIL0dTFWo=;
        b=Bm/iFqBa9Zc8IKVODqcetZR0mwPPXWJAr+xYhEC7pyUf/P5IKU2ZwHPoV3kW3ofbLx
         xJTaByPy9FYrcyZkr41mpxxW7SGKAgkeGbArM55g9qKuIkyqOaQmS+cN5UtEwF7K9wAr
         6YxWffDkF+iUMS+6XuqZPVTVJR6fgIYSa4Qg7Ddx4vWbrlhAw7CP4mOAXZ+xI2vn1JAq
         +zml16Pjn6syxe1IflqE0no20DY7AWK38PIn6xgeBPdC+IuWRamvtQbNfSGeq5uv5QFA
         jFgckjdLQpRl/movHAPAC146bKROBHE4GHGb5+fDB1yC5dm+pobIM8z7RaG3lBp8Cmyt
         iGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735005802; x=1735610602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/EJ2Eb3Tn2rBoUBe+TFvM932Gu8zY+2YkqIL0dTFWo=;
        b=eNkM5ISmjjSutOt3mcKmjpwDONSPcel22Tg3WpSg9alauATy70j8rJdNNkkNBIQEb7
         28QSJBWzpVDkr4WoD/9wWEaFvsxpYYq7yLT9NKosohUcTQmF0rTv5rMXg0ul+XflnsNG
         II0XljFoaKGp8EgnOyK98fzkAVOkjekJI6xpePGAUEA8uSQovzacIH3u/yZMzYnS1gB6
         AEoJHYirlqBSe39Hdwx67uHupgbjm0jv0pMgta+BDfwwnkLRZ3uKQbpVFj4OPoaJfxvz
         wZTaNzF14aDlAbHnBs5WboRxr4yJn5YLuPNkR5Rzjr/90NMHw1TIi1eb7E9ZamrDj6zK
         4rLA==
X-Forwarded-Encrypted: i=1; AJvYcCWGj8ui3UDlZJmMszawPRnwCwtutCXFwjalJQgbcJCRRPf5XA1q1goSg/A38i4IZJW3prRDA7Mr96woNaM=@vger.kernel.org, AJvYcCXKWiIOIkrGWIoRHf+I+tQDY3+PQaauscEyEFWjRilkFFabHz0kpxY59VcHjLkP5S8uvVlxbnRUVdllokEkxycTaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDcK8F/gXNEZA1rS9guin/4f2h27Yd5ADx3j9AeemkC4sIDE4u
	QkPEKerb+1IcPwUfoxHSRQIfXRjOXhipRSqIyf6uMdeEf9PBQ57vf14Gq6aooruw2bsVr8YxagK
	liA4bgAwsUOQEjfqq/S3Vl3zchqs=
X-Gm-Gg: ASbGnct9apkrDq2cjVX4xiZ9cjutQdeXxX//0QvxaszM7+RQxldHHtFk6SIpryhE+yE
	q36ptLVd8VAeKmb7aeTVEHdGJJIUXkWxvd4g4
X-Google-Smtp-Source: AGHT+IHox6wU8e4aTIXP9/6bqaoq13emS7RQb8X4vfsslkoNzncSkh2lXJwvCNQy3OsYCpx8dbd+sZPPeb/d2/KHQrw=
X-Received: by 2002:a05:690c:d93:b0:6e2:1bba:ed4c with SMTP id
 00721157ae682-6f3f8115681mr111873147b3.17.1735005801971; Mon, 23 Dec 2024
 18:03:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241215190712.787847-1-howardchu95@gmail.com>
 <Z2CGdi5xpJy6C6sv@google.com> <Z2mzzytPOpjF0Hxe@x1> <Z2m8qzyLdm1BEYuF@x1>
In-Reply-To: <Z2m8qzyLdm1BEYuF@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Mon, 23 Dec 2024 18:03:11 -0800
Message-ID: <CAH0uvohvzQi_iE0q3A8jZF4P+cwu=4P1Az2guNKP3ckPon9HxA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] perf trace: Add more tests for BTF-augmented perf trace
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Arnaldo,

On Mon, Dec 23, 2024 at 11:40=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Dec 23, 2024 at 04:02:43PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, Dec 16, 2024 at 11:58:46AM -0800, Namhyung Kim wrote:
> > > On Sun, Dec 15, 2024 at 11:07:09AM -0800, Howard Chu wrote:
> > > > Changes in v4:
> > > >  - Use if -f to check the existence of vmlinux BTF, and exit if it
> > > >    doesn't, so trace_test_string will not overwrite $err, and keep
> > > >    running the test.
> > > >
> > > > Changes in v3:
> > > >  - Add vmlinux BTF check, and skip the tests if it doesn't exist
> > > >
> > > > v1, v2:
> > > >
> > > > The previous version of the perf trace BTF general augmentation tes=
ts
> > > > didn't pass Shellcheck (thanks to Arnaldo Carvalho de Melo
> > > > <acme@kernel.org> for pointing this out), this version uses bash in=
stead
> > > > of POSIX shell to pass Shellcheck.
> > > >
> > > > This patch series also adds documentation for the new option
> > > > --force-btf, which is used in the tests.
> > > >
> > > > Link: https://lore.kernel.org/linux-perf-users/Zt9yiQq-n-W6I274@x1/
> > > >
> > > > Howard Chu (2):
> > > >   perf trace: Add tests for BTF general augmentation
> > > >   perf docs: Add documentation for --force-btf option
> > >
> > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Thanks, applied to perf-tools-next,
>
> It fails when running in parallel mode, sometimes:
>
> 109: perf trace BTF general tests                                    : FA=
ILED!
>
> Then:
>
> root@number:~# perf stat --null -r 10 perf test "BTF general"
> 109: perf trace BTF general tests                                    : Ok
> 109: perf trace BTF general tests                                    : Ok
> 109: perf trace BTF general tests                                    : Ok
> 109: perf trace BTF general tests                                    : Ok
> 109: perf trace BTF general tests                                    : FA=
ILED!
> 109: perf trace BTF general tests                                    : Ok
> 109: perf trace BTF general tests                                    : Ok
> 109: perf trace BTF general tests                                    : FA=
ILED!
> 109: perf trace BTF general tests                                    : Ok
> 109: perf trace BTF general tests                                    : Ok
>
>  Performance counter stats for 'perf test BTF general' (10 runs):
>
>              2.148 +- 0.293 seconds time elapsed  ( +- 13.63% )
>
> root@number:~#
>
>
> So its not just when running in paralell, anyway, its merged, we can go
> on from what we got there.

Thanks, I will resolve this issue and send v5 along with the
documentation changes you suggested.

Thanks,
Howard
>
> - Arnaldo
