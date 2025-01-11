Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD974689;
	Sat, 11 Jan 2025 00:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736556742; cv=none; b=NIg4OjxbAgEh51/nfExEHcGjHPnVfEGAETidP5dn8G1OXtRTX2NV6/8W0ZX/BOrxxpj7WFcFPTNzUUaUwoyglK3IwjuVyR7M+uuweZAMUWNs7mITV5HIZaqiZOe8ojY2bW4s4BFnUXsO5FRElyV2qHFMeuvP1DUMDRO0Z0vlZ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736556742; c=relaxed/simple;
	bh=nk4XtFqv0gEFAclRRN3uciL5r1v3Ef2OG2HF1AtKs7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NW0chQflyM7A3NzT6fSE6oC9FWgAEVZqOKwOTfH532tFk9aZLVCoYoPYimFgEuDsRwMa7cjzjU/MnEF/ZJkKiYeFCIzay4AtxGqGxnWTCe8j2LPMuoodNhWfTR5n2TaSc0Snyf2q+nAOSRMqKolmAVaDluPVvPXzh0qB3mKM7Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5iHSoVc; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5iHSoVc"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e3983f8ff40so3843145276.1;
        Fri, 10 Jan 2025 16:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736556739; x=1737161539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XjKGVFbfzFVl+Zs//Yt8Zan7PcoyN6xVrYHcv2BoW0=;
        b=K5iHSoVcsFn3nlgPG9Ob/m+taqN3P34GeUsufGKIUQWg06ps8Z4PO9PHoBnoVBEL+Q
         ofTm1ToclSC6m/VdIhu0+13QKWKQdEaxxlO4t1ddGcwi/nmYPkcWSzQ79TCKu0B2dy3a
         elPwZmbQg9j9wygszOFqdU+AcYAhV05jR7r6w+sld9uX7QUpNfN3cewGFX9A/b6o+Cuf
         C4D2BiTizDISm7Hz+YS70e8FUWUpt5K8OkZzaZkZWBZGHyv/gvUqY9HqksAGch7xv6nq
         qW3rOlsH/Dvh24hP0CYSVa3SsS6+3jCRWGGfy57SA1qdQNlmwbUhIERf2BpmkDwVIxNU
         FBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736556739; x=1737161539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XjKGVFbfzFVl+Zs//Yt8Zan7PcoyN6xVrYHcv2BoW0=;
        b=j8I6xiYaIlvRszq8ZL5bd4ohDWDB3g1hdffS2PB6YZ0M6PhTAuANC8qAS+cPSkf66P
         MEQrAuOCNIyGfnGelcVksjXWrFnk9Bs25q9/ipSG4HAuUsvpeG4JmRiUnOC+HcMZhsiq
         uALPvhdvmudwwmp16h32QSiKuxNNt7YgtonkB3DUiAfeP+IKiNKdWsXnfWoxaGnoXtQ9
         r/szTzHOvpVJKCjAQ9n8dYJuTIQDFdexxoMG+ePoR7FDTJNfdZrFHPslHo7DUZB79orY
         xRnREW9EBBRoILSeqaYjyPOA7aENbSXPtpeyo5NlARdE7PJC3ld/iXT9JSuwYEQ/T9zG
         gsCw==
X-Forwarded-Encrypted: i=1; AJvYcCV47kMFZYAoa5Jbp3I04KJtaRa8Q3i1CR06ibyiooo6tRRLPLiQvR9JS9tU36hEKJoRPsx1mEg7qGXzjms=@vger.kernel.org, AJvYcCXQ+l3UI8ZhtRfcJXiOFfJcaJKSme6luT7riJH4JSNOjLTEEm08S+1dXPvuJBk/i/pUf4+QjcUKkd5r1RHRgUKkBg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+LBIILPNSk0zH6e7vM0p1eupAbchTDw+lCX9DM8IYneVUzGlY
	5YQO57ACinFEylvCfKNp7MCK0AOFuaIO4Joe3D/09akKIv3Wv0vKPVyVkmYqZ5LDWkGhtKPxKc/
	uCR7hkEO2u+JTusu17rtKY1GUE3Q=
X-Gm-Gg: ASbGncvGQc9KGHA/UTfrTK5/JD1bURCGRglH1xSb8GKfv8waZ94JmdzTx272YFjZk1s
	M/dAvFKHWfA63Yj6+CoOJVuht3S/FjwcB9F06g5E=
X-Google-Smtp-Source: AGHT+IH/m3y/0xHPCdmZ/4LGTYgjLaAd5IK27MnzUYk6bz/E/W5r0WVsTS2kUKd+fJzI+U+sa2ZtTR7KmwI+cCZ02w0=
X-Received: by 2002:a25:ad55:0:b0:e4f:45d:2d with SMTP id 3f1490d57ef6-e54edf26de2mr7712148276.8.1736556739503;
 Fri, 10 Jan 2025 16:52:19 -0800 (PST)
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
Date: Fri, 10 Jan 2025 16:52:08 -0800
X-Gm-Features: AbW1kvaNnzIVa0-yYH_rlyM3ykNIyTrf6S_0BZpwS8xrd4oBniwou6K-bN0fiAk
Message-ID: <CAH0uvoga29=0iF69A5uHN+nbB458LeW+WDWHNnoQV4msVm9zDQ@mail.gmail.com>
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

It never fails on my machine, I think the reason is my machine is not
fully-loaded. Can you please run
```
perf stat --null -r 10 perf test -vv "BTF general"
```
And provide the output?

Thanks,
Howard
>
> - Arnaldo
