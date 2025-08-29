Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489021D8A10
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 05:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756447175; cv=none; b=GwgX5fUY0H1EptaLVMDoRGUcuAxc1QYPSoxv0fkjGMcgJQc8MGw99p4kiFv2qswnxPhpSr5tu/fe6eAAOtuuvAuzSTSg4NNKeUktkLiDPL0kVZhU1itttN+t4uGW7MvRBnMxHixs+WTaUZ+clQWp7s2hEFbYmGB1zb+MFk/HhzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756447175; c=relaxed/simple;
	bh=HQHfXVXKCqm565Dn42Z59+LNgV1U4UlkiCvPgaZSeQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aTbQaPHhm0F6QNOIQuqFkTfCQOfn9sgTuiCTdFzAl5Od+6KtUhp1NjwJSmo4CQlb/xIU3mPgl64EhyF7idqkKv4YVVuLZCqs4MRbyuO96c9q2UBUHE1A2lbytjeYjjbtPAIF3sG0QTc1BV8IJStqCQQbgmar/L34KTXv3+/37YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=flugKghJ; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="flugKghJ"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-336b82c03ecso2115971fa.0
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 22:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756447171; x=1757051971; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P9b89mWcH1WRoi8NB6LCKkiGizr7phQg5j8xmHQXvrc=;
        b=flugKghJYfGrHrmWu5n6xDWoYY4uL0G/5bmZOOtwiqKdHk+Kb6vfw428PSR60W91Z1
         xXFqqG3HScK+ibXsuKTmfjGCNPu/a7edeGERKa4Dz3QGIv5u5Nj1muqxW/uBO8zmA7JS
         vaxBY5uetsyvTpmIbeDIx5g/z/r2DkOlXf4m5kSLSYGiR+Uv3W6x6+tUy4+25SjwTVz3
         iQGNrVgnTTnoi2x2PJSG6HPasEKrYM6AVTQTTGiQU+Pv4xjTjPOfXLK+8LGGDDLp5+E4
         U+TICFsJ0fO7AsDtgRNRmpGrHbRMy7Rw0rzPyjT+/MMUjYLtW54pUO2bujM827yvqrAM
         qxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756447171; x=1757051971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9b89mWcH1WRoi8NB6LCKkiGizr7phQg5j8xmHQXvrc=;
        b=edsol1aRKUVJ0dgkFiOOYtfMlgEZaZ5QZVCiH2gzq2KkYi22F7XleBDPlJbCNoWl7B
         0FOqbzwk5NCfWROEnzF+y1KHRdesbzZZ74yUspRFJti/DMMRIk+nBpFDtMmEXjkCxeIy
         I+S6ys82mQf6UpApBbz/JwPdZ36iJiEmNfUbpKVLt/JHGZLziKVGdniToAsJM3ELICI4
         CtHYr5USqRj0ZSsf27XLR8fYwEFLgzp9ws130sZaMGCeGpJf6JDfiAogbMiABL7bzNct
         E68BO/5tCRPSpgH60t9OryUmm+VKIAEDyEEPB9Yq+zLv+wGu8sa/Ova3ibgB+NEh4K40
         +Upw==
X-Forwarded-Encrypted: i=1; AJvYcCVXlUKjVuRcJY1JyBxmKNF3L4uqFwAJ4x9s5GVmWehLVHuOz2xHF4QVAvqFgPrybLmNR5ViQVftgqei1Koug+4w@vger.kernel.org
X-Gm-Message-State: AOJu0YzI6VVpokXcFr9Ev2/DPxYUkLwGSq/KafIIFenJ5JHlcTa7pWmH
	znOdw69J36dF9z6RIRVl/XuuWdbIJ0EpzKc7lKsXFat28d0MuN6A1NTOy3gzNlEmU8ORQjjKMbf
	lmS+W4PQ7jtJ4mblsrjTqS4hyte7UHKwxtxZitp29
X-Gm-Gg: ASbGncsfj0YCR24n2/AQmAsaBWb28mpCg47J03vY+qRYvGaXL97UfhfjleqpExyFga2
	grxYY+qWE9m3SW9jk3SxiTsga6dP+wH1vUtteJFB0wcnlBVwdbhumHwTZB4JZDHxOAhaIUAlFmG
	TkSv+NaaZxFiFwE2Rdl3ej1IkHVmteXVYhHueEZSlUIWkQK7xnaDogD2iXs6RxEQ2/Cug0KbRcj
	X1zqRg5SoHO1qrgmHQryrmX7S6tenBSrXXNppqWyA8OP81zYAjdv7sxBw==
X-Google-Smtp-Source: AGHT+IGpsSHWaCkR84qNI3V45LpCTM6KTwnsCQMP483IEziQLGCDzdNJpFNTpDClHjL7Rp31C5D88TK18RjtyhkTPDc=
X-Received: by 2002:a05:651c:1118:10b0:333:7e5b:15c0 with SMTP id
 38308e7fff4ca-33650ea0b23mr53475191fa.13.1756447171269; Thu, 28 Aug 2025
 22:59:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aKYEpf7xp3NnkBWm@x1> <CACT4Y+YX-ROx0cW4pkDnqbdfbigVycwPLwO12RNbbtX9-Qp73A@mail.gmail.com>
 <aKv_FjtkPIR86inu@google.com>
In-Reply-To: <aKv_FjtkPIR86inu@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 29 Aug 2025 07:59:19 +0200
X-Gm-Features: Ac12FXzOVh7BPaHMQclLjPZcl1R6uL53TzQPya8c8MkZgMLcA8AbQsulHRMdbNg
Message-ID: <CACT4Y+ZxqgqAGoSgUaVKk6_=h1dO7iV8qrVHDOrmbBS3VW8-=g@mail.gmail.com>
Subject: Re: [PATCH 1/1] Revert "perf hist: Fix bogus profiles when filters
 are enabled"
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Aug 2025 at 08:13, Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> On Wed, Aug 20, 2025 at 06:14:08PM -0700, Dmitry Vyukov wrote:
> > On Wed, 20 Aug 2025 at 10:23, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > >
> > > This reverts commit 8b4799e4f0f40a4ec737bf870aa38d06288bf0fb.
> > >
> > > Not combining entries in 'perf top', so we're getting multiple lines for
> > > the same symbol, with the same address.
> > >
> > > To test it, simply run 'perf top', then do /acpi to see just symbols
> > > starting with acpi_ and notice that there are various lines with the
> > > same symbol, press V to see the address and its the same.
> >
> > With this revert, does it show 1 entry but with a wrong percent?
> > I am not sure why there are 2 entries for the same symbol, but if we
> > merge them, we can sum of percents. Is it the right thing to do?
>
> I don't think it'd have a wrong percent.  The hists maintain stats for
> filtered entries separately.

I still don't fully follow.

If we merge a filtered entry into non-filtered entry (with the
revert), now we attribute what was filtered out to the non-filtered
entry, and the non-filtered entry has wrong overhead, no?

If we merge the other way around: non-filtered entry into filtered
entry, then we won't show it at all.

> Based on the position of filtered entries in the RB tree, I think it
> might not merge correct samples together and create multiple entries
> with the same info.

The second thing I don't understand: without this revert we don't
merge filtered and non-filtered entries, top shows duplicate entries,
does it mean it shows filtered out entries? This also looks wrong...

> Filtering by unused sort keys would be undefined.  We probably want to
> warn users instead.

Do you mean that the filtered=1 is set incorrectly in this case?
Do you mean that with this revert 2 bugs just compensate each other by
luck: we wrongly set filtered=1, and then wrongly merge them together,
so it all works out in the end?
