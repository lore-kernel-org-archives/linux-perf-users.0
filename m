Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BED192B89
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229180; cv=none; b=O2UgRbPHE8lR7wUGXqAwfrCiezRJ8TqXBr+2fJEWGnuwHN4q/gtxeaXXj5grIkiawn/JsP7a8P8SEpzoTKI1784CXpATzRuvb21vhzOy1kMk+N0VWulDk/S11SRcmQ2P36mJHTtm376TTegr50NhVdtd9erWgGMQBXDVOR9wMoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229180; c=relaxed/simple;
	bh=HTDwcdiYgqE7n07rfeJ5JycUs/vTXGKFpWCaf3FJVQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kouu5rXhNu0ryvnpkFQqRfOjanoZ09kf3caE0APAXiK6QeQBiCul3tOQ5wYQxeknwO+SxEn8Udpo7fw3yHdP3Yn/Ss64tJj0d4SdTOzugNas6e9sKrSVO4MrNkWkr04hld90nrq1z3DVIBdN0IdaNKdX1VMBjh+idf4Q6tOwP+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kKUJND5i; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kKUJND5i"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2242aca53efso565ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 09:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742229178; x=1742833978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bFeEUc1CMFlQ9JPLuTZMO7db/vAU/zdZbpR/R6e4e0=;
        b=kKUJND5izx33K6H7DTb8yxI7FueCTfq8R6BOw7DRSfPeRjrG0vzfBFVE3GnORTLqRa
         T02pcsK2qbrUPxRcPxMLw2884CA20wEBnHUEMYdPvtmJeXlf3KnzmQtIvv9WjwKkq5N2
         0g2wCAa7Xdau2P/z61mlUK4AKg/XQBgJpwIeckLvvU245wxwDtVoU6kj/nsC07M19HkV
         f4o6e+clzx8MahuMtXPOC8jxPuxGmf1c2CFeSX7Ikyu0nJuQBkevBR9xSS0blOiauDIR
         XRWB0GKNEHxalki0BwYgFE/pjun5uYp0lPwhWo+9hIcOko9UiCDXjVH0EvQlGW90i9ay
         XnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742229178; x=1742833978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bFeEUc1CMFlQ9JPLuTZMO7db/vAU/zdZbpR/R6e4e0=;
        b=whlQjWWDQIQDygdRDVvrX2qQePQo3AxLMmHhnYoB1vP7kc4QyWFIOGhdmfB3CWed9W
         a/YVng7xsN6Z9wQTO8cGrnXzzSyji4BnDMxz8sb7/HsnFGYXLHM0F04+BYuyI5y+hPGm
         766k8vfkXQHBGe/9C+AEXkOGsPxaBqil8GB1vaEHdIyUaut6GZkwyUi3jUK8v8CEpU51
         tOG5ZCE22JEflTv1RCqi3OryLIVAUVB2cb/fDWdXpAn8ZZPSitj2zykAbYijhTYBEJO2
         kj9eOGzNJY01JxTEO/pnH5UpWoiA+vaziGwyNLOfnhzNowHtJmK//gLY4dl4hOxbDj+9
         8Auw==
X-Forwarded-Encrypted: i=1; AJvYcCXzKJO3ZU6Mi+KxdLjnIurIbWLMg50hWn9OhquLbcBKIVyyR3sRWBriNX5OlbYNE9ksjfU9UyO93b0C7cI5EfHe@vger.kernel.org
X-Gm-Message-State: AOJu0YwL1qLB37/nw8RlELtNpNj5hw0Jm8fTMViKpPF/c+bZsWLbZxzF
	Di0QH81Ws0l0CHubhgHJMAAMY1zVVedsz9GxtIZI7NdJKMMWrraNBVGgLBOFzdm4F/4dFhAdlLE
	xja3zRcXRNc0LcLm3OKljb8zDEMbYTZinqXcm
X-Gm-Gg: ASbGncujH6xlOqvCeioAZezMGNyW2UxWpgXlx0f7KTVP4Q1ODKlSNwSxmPb/tKTugV0
	xOmZMm/po1H3uvJb+WHzquSAKZX8DHGgtd4o9pBcAqnQnV53syTqKAdPkSHAPXgdn+fJCm6yIWe
	NVm9agY3mevzC3TXiSbdicCor3oAG89VbygdIhLDOQbQgkZ/kK2V29jus=
X-Google-Smtp-Source: AGHT+IFiwNfIZhEEvJdCoa5sd9XgmoNGcvI3JM2dZ33BS1kjru58n0GAD6FGCdYHkBSJwySlctBvsNrPQzyUJog7T0E=
X-Received: by 2002:a17:903:11d2:b0:224:1fb:7b65 with SMTP id
 d9443c01a7336-225f3eb51c3mr4461585ad.22.1742229177861; Mon, 17 Mar 2025
 09:32:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303183646.327510-1-ctshao@google.com> <Z9TXabugl374M3bA@google.com>
 <Z9hFJtEKfsGGUDMg@x1> <Z9hLKsZOfouM3K7H@x1>
In-Reply-To: <Z9hLKsZOfouM3K7H@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Mar 2025 09:32:46 -0700
X-Gm-Features: AQ5f1JpruzNCywHc1Y1hhYmxqC8yRcfXO_HkTwABokxnyZaen-Bd5nEzsXCsEuk
Message-ID: <CAP-5=fXOBp1F0eXbgjyjZd0K-=trqugmROttwSWT_M393HxeEQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf record: Add 8-byte aligned event type PERF_RECORD_COMPRESSED2
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, terrelln@fb.com, leo.yan@arm.com, 
	james.clark@linaro.org, christophe.leroy@csgroup.eu, ben.gainey@arm.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 9:17=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Mar 17, 2025 at 12:52:09PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Fri, Mar 14, 2025 at 06:27:05PM -0700, Namhyung Kim wrote:
> > > On Mon, Mar 03, 2025 at 10:32:40AM -0800, Chun-Tse Shao wrote:
> > > > The original PERF_RECORD_COMPRESS is not 8-byte aligned, which can =
cause
> > > > asan runtime error:
>
> > > >   # Build with asan
> > > >   $ make -C tools/perf O=3D/tmp/perf DEBUG=3D1 EXTRA_CFLAGS=3D"-O0 =
-g -fno-omit-frame-pointer -fsanitize=3Dundefined"
> > > >   # Test success with many asan runtime errors:
> > > >   $ /tmp/perf/perf test "Zstd perf.data compression/decompression" =
-vv
> > > >    83: Zstd perf.data compression/decompression:
> > > >   ...
> > > >   util/session.c:1959:13: runtime error: member access within misal=
igned address 0x7f69e3f99653 for type 'union perf_event', which requires 13=
 byte alignment
> > > >   0x7f69e3f99653: note: pointer points here
> > > >    d0  3a 50 69 44 00 00 00 00  00 08 00 bb 07 00 00 00  00 00 00 4=
4 00 00 00 00  00 00 00 ff 07 00 00
> > > >                 ^
> > > >   util/session.c:2163:22: runtime error: member access within misal=
igned address 0x7f69e3f99653 for type 'union perf_event', which requires 8 =
byte alignment
> > > >   0x7f69e3f99653: note: pointer points here
> > > >    d0  3a 50 69 44 00 00 00 00  00 08 00 bb 07 00 00 00  00 00 00 4=
4 00 00 00 00  00 00 00 ff 07 00 00
> > > >                 ^
> > > >   ...
>
> > > > Since there is no way to align compressed data in zstd compression,=
 this
> > > > patch add a new event type `PERF_RECORD_COMPRESSED2`, which adds a =
field
> > > > `data_size` to specify the actual compressed data size. The
> > > > `header.size` contains the total record size, including the padding=
 at
> > > > the end to make it 8-byte aligned.
>
> > > > Tested with `Zstd perf.data compression/decompression`
>
> > > Looks good to me.
>
> > > Arnaldo, are you ok with adding a new record type for this?
>
> > Checking the discussion and the patch.
>
> My first impression yesterday when I saw this on the smartphone was: how
> will an old perf binary handle the new PERF_RECORD_COMPRESSED2? Will it
> ignore it while emitting a warning, since it can be skipped and then
> what we will get a partial view?
>
> Having some session output showing how an older perf binary handles
> PERF_RECORD_COMPRESS2 would be informative.
>
> I'll try to reproduce/test this all...

I'm not sure we've worried about old perfs being able to read new
perf.data files, but we've worried about new perfs being able to read
old perf.data files. So if a change is additive, which this change is,
then nothing should be impacted.

My thoughts are this way as this patch:
https://lore.kernel.org/all/20220614143353.1559597-7-irogers@google.com/
changed most perf.data cpumap encodings in a way that old perfs won't
be able to handle.

Perhaps testing/documentation should be present for this kind of thing.

Thanks,
Ian
