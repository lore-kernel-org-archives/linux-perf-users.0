Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FAA1E3DE8;
	Sun, 18 May 2025 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747607563; cv=none; b=Tex3nETZKtvwO257bTh9hmrmw2QsgwvWt8Rm4IlBEqhsADRnq72Yz/moVOG7WvQamJvXDXx/ziJrW/Jprq/TdVtWV+RfB49GBQ5T6fM9cR9jCiyKKWIfGaTF0b9vD/xsheB9ykUQmePBBlP2UuzCPfgLJMH+zEqi3zK1szoe86s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747607563; c=relaxed/simple;
	bh=l9oO+/3NrbBbHunrq3cjDnNKvd58oHtVQzOEatObfVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRy3d0OeqYQFqNcSGvjvtbg8wEB2tUf/oUHFJ0rcCdBqO0xMSySpQvoHhcAQTNV8ILCBWbEbdXKIrYXOjQ9lymuWdvxa/CQb5OHwgTmq5XjkH5YB2NVyxexRq3Yn3qVURelUd6ZGTRpMO5dTsNVC/plAH3cBclLX61/3eSjxX4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKc3afgx; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKc3afgx"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e7b99f387e8so387751276.0;
        Sun, 18 May 2025 15:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747607560; x=1748212360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M66bK3dRTJqGwsSXfd10GV6EVRjCRceJqLJ9oPjIqRA=;
        b=PKc3afgxbE/Pr2kkehlgk403C8i2SOelWpVOM3SWg2uT0xlaIEfe2P9cNqVryQdw5u
         B9FONuxVfD2mAe+gEUoXrGnKVWRSclwbK4hYiD4rlrG/tINr35OdrBI9qMZ1BApEAQuX
         XMAS3efhNYDnANcUrg8awZuHiK1LbnH3Iapt9yzXgvpwYd3gJ2Lf1P1296rJGv9zCGZv
         xfOmXaBtedJS9Nr2gczLERJSNFme6JodGcDyOwrHW8X3s99kVKY4EiOFeD3IRqaYvEcw
         SqCI2C+CXpmVUaezm5kUCqlWxFIcbHmaplof/BVw9oTMwuEL4mggznSSI5KjnCr0FsYo
         uhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747607560; x=1748212360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M66bK3dRTJqGwsSXfd10GV6EVRjCRceJqLJ9oPjIqRA=;
        b=fg5BfJpFSPsHBM2xvD3jtWyiTfzNjxms48T9IiFOmWcBmrWrqqrmavV23ERpcEGSXv
         6yKCN7s7eMiYiQ755hmWtYZeNgNo2DYPB4R8I7lpuZkK2qm4kfCd4tXwP+K5UaECVAll
         8kr0i0pmLw53B6F/FYs6Evl1KOtAntV9ui4fqMvgvOZNO2g2Ihu6bWdqClqlw9aAqnHy
         s8As8YJ33gam6xyhJzRzHAhvz5kq2SmISnTgAfw3CPV6iZlq5/ymvRTTvw47/6Vjb3Ju
         w+U7S/YmZTQ7vP6PDSOEEe788j4bVQ34ddei0TM4lO77nLHoI79d2OqksiQkQnnzQTrd
         kpDA==
X-Forwarded-Encrypted: i=1; AJvYcCUSRJGDZdGby8t+CdRyf1IJ2i27rvWGbY1TWrFvs7zGQRGoLAsCy2raUnvjt/0WG4rKyQsKJEtCUTDIbY0=@vger.kernel.org, AJvYcCX0Q/xqxsX66DID1fAZAonLp0hhSkEnyd7WhCC8GFeX9Y8maIap6+O5xFTmqgRDHXRcLn0oqjF/fYpU6S99GEL2Yw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Jds7NI4EvmDU4h1R8NhBO1rgC+4P4Oq+/tJDY/QVHBjTvECQ
	OePnGxFXdxmtGz5uQAydRiWVOyPhdL4ODKRkhRV7Pcv5W0Xq3EB8BEpHIKOsq1O1J4kmnEVvs9w
	W8thEP+5mgW5aZG23JXpX2/T9OomEYUo=
X-Gm-Gg: ASbGncvd7wy8KAZJhn4vn6qm/b4ZUh/XU2TmJxD8MYd54rhCjcn40ye+UsG59wyXwAj
	2Dfa9T3bYth4X/cU+RbtKtMqxIFFq2vbP20xAxMbsXEljTmHcz4HNIv3tSXbnT7WzrYHF1pB84H
	b2FczyPbm/bas5DqrSpAbFv0Mv7dT8mgM=
X-Google-Smtp-Source: AGHT+IECkLuerWwWCZ8/5bUyWO8gJLyLQhn2frnslLKmzaGYonKaIWNoj58CUC2Eq1FOPS8OImRM6FB0R5qC/bqULA8=
X-Received: by 2002:a05:690c:f8c:b0:708:c91b:4ae0 with SMTP id
 00721157ae682-70ca79f1ee4mr182294077b3.16.1747607560182; Sun, 18 May 2025
 15:32:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250518190957.58932-1-howardchu95@gmail.com> <CAP-5=fUs9ZVa3z54w1GyKrR=D0YF5GmSZEQ4dh=cKehTPD_w1g@mail.gmail.com>
 <CAH0uvoju7bFsJPeqaDBzSFzM3GZkaTWgfcgEtcBr9dpn=T-e2g@mail.gmail.com>
In-Reply-To: <CAH0uvoju7bFsJPeqaDBzSFzM3GZkaTWgfcgEtcBr9dpn=T-e2g@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Sun, 18 May 2025 15:32:29 -0700
X-Gm-Features: AX0GCFuNw3NOH3oJcA7Ra31VoEffHrw1oo-rqqaYgrgNjeCng5qvzUHcoGIPL7g
Message-ID: <CAH0uvogAkSeERCHS_P9UYu3Km=7Eu1Ja-9-EyaYu2BMf=dQCkA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] perf test trace: Reduce test failures and make
 error messages verbose
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, mingo@redhat.com, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, peterz@infradead.org, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

BTW thanks for testing this series, I will add your tested-by

Thanks,
Howard

On Sun, May 18, 2025 at 3:26=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Hello Ian,
>
> On Sun, May 18, 2025 at 3:18=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Sun, May 18, 2025 at 12:10=E2=80=AFPM Howard Chu <howardchu95@gmail.=
com> wrote:
> > >
> > > Currently, BTF tests fail constantly, this series fixes two major rea=
sons
> > > why they fail, and makes the error messages acquired when using '-vv'
> > > more verbose, so when they fail, one can easily diagnose the problem.
> > >
> > > Before:
> > >     $ sudo /tmp/perf test enum -vv
> > >     107: perf trace enum augmentation tests:
> > >     107: perf trace enum augmentation tests                          =
    : Running
> > >     --- start ---
>
> <SNIP>
>
> > > Changes in v2:
> > > - Add an extra newline after error messages
> > > - Rename the title of patch 3 to 'Stop tracing hrtimer_setup...'
> > > - Take the debug diff for explanation out of patch 5 to make it apply
> > >   normally
> > > - Add base-commit in this cover letter
> >
> > Thanks Howard! I did some testing but see failures that may be
> > pre-existing issues:
>
> I don't know the command you used but if this is the result of 'perf
> test trace', it is the parallelism issue. I will fix it once I'm back
> from Costco :).
>
> Thanks,
> Howard
