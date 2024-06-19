Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DF015748C;
	Wed, 19 Jun 2024 18:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718821544; cv=none; b=hOvcTFPHKug4NGtjpkOkhYx3T2zBMcuIBGlytjTX8GntPYrVA+QVUNJWZST/eQ6pc/dU39OO9HMcJJT35u3B+MAHuIl9PQ+TKYyTRRfJhk8OZQzE5iWuEp6nXUPC/01fY9zfZbMCMIKbbBcNThgFEibWjzq3lCDEO1MDKgbM4aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718821544; c=relaxed/simple;
	bh=cNU4k4Z9vt2ZVTeVLys4gCrez6b7RfRDUbs2t8p/kSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kwbE4CPfxO5fMPS29z8/viXnWIkAcEZqeHoxfegFX838aDTm1J8OSVgEszYAbIc71rn+h42044Ww72hTxG0QOe9BBpRw3OfNAQb7m17Z9+hyzKe7T8v+PX7Qh3+RtwtgkJgk9R83Jv+qOO54IVbVV0Bo44vFi2tJTG/TsbUVJrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBaxKp5q; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBaxKp5q"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dff06b3f413so42070276.3;
        Wed, 19 Jun 2024 11:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718821542; x=1719426342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRPhb4LcEfmXog7Vq9PBNDJLtn9KBxrQUGmQ/CKFcK8=;
        b=gBaxKp5qqj3hVL3m7DfFdg7Gonlmb/6pR+Ps4y8cSGgbA+VT5JZ3c1DRgfBzTXooEM
         SDm4G0Qhe9UhUcpNqLs2nov3bwzWysR1k/Cur1UWszDJOrOdnLnjf2eQCdnuaZ5Uq7X9
         7bHLrzCyQ0HBAULtrRCC4ypkvgFNpxLV5pq2EHWREgeySD1unXbVRS5+EAA61JHhfpks
         m6fIehZeKizByy/2e6qlJHoOnaOwS1Cx0iQUZGWA8G7i7gm73SylXfBm7Z2z+c64GxKC
         URgUcrNYAfcIODlIlaztH/4IToUEpG7oTVEXWKSLUR2Gl+R4+osyTdKQ12h+Yo1l6VQ7
         /Png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718821542; x=1719426342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRPhb4LcEfmXog7Vq9PBNDJLtn9KBxrQUGmQ/CKFcK8=;
        b=w4pCVREHMNOjx949qGP5K/ho1p4pvujxVPIjrus1kDXCJiYbe0xiqs/LzYyDV4gx5T
         Mmg7mILipK/dbk77AbYYUQYN4NzcKRiWoMx+t6x1MYK5+hQyc/q9xfmwr2zD4lStzwJu
         Clm7BuG1YbGwlN7SdsbxAMg6wUoggTPAiQ4feUqyxeQrc8HYDUggUggZT7pb+7l9reiN
         1sr0tmihbYdu7fC2XFJKr+l9QWPHIU6FDpxQ+7Syi+BFwkiTxWOxWsTUj2ZbBwzC1k3y
         NE4gxTBsSagX+b2GNOuiUcFKsXjoC4qvLZvsO5nuOmOK1MsGbzbGzLAkRWeXrg14eQJc
         f17g==
X-Forwarded-Encrypted: i=1; AJvYcCU3kT7zGLyl9RFSXa3azsq/bwcqjfbuGwnNGEM470lPAKj25VO0+JRspD1J+o+VaFfSgOndplgExVg87FYrlr3z9mLB/RRTLGezBesMrPGJqbaVyv+DORwUKjym/vywvvx+JiHyurrHoKpTSteH0Q==
X-Gm-Message-State: AOJu0YzeZaZQR0wRw9W0nId/U+m4FoG3vNp9Vb5A21pPp7W9Wt3q5BFO
	LSKVAwLf+yxy6QMILCTQy2Kn6a/g98r8C6vHVSx+inqu6z+gSHvmCWee7s96WBgGuaOrwNvR/Jb
	ygkGnizdC9ReR/lrldQk2KVN9ZWW6/RYgtbBQaQ==
X-Google-Smtp-Source: AGHT+IFBqPeCafDYX98OBfIHDMdNXxq0533UQn/rqrzPYZG3GXmQAYQdzhHwVxBSZpPaRgZPDWT48kPDLYdJLzfphj0=
X-Received: by 2002:a25:a2c1:0:b0:dfb:e1c:c799 with SMTP id
 3f1490d57ef6-e02bdf625f8mr3693344276.0.1718821541823; Wed, 19 Jun 2024
 11:25:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619082042.4173621-1-howardchu95@gmail.com>
 <ZnLjT_m90EDtRFE0@x1> <CAM9d7ci+TEXG49=-7oLfFpTakUMHikxGFc-=NhEPPG0sf-UC9g@mail.gmail.com>
In-Reply-To: <CAM9d7ci+TEXG49=-7oLfFpTakUMHikxGFc-=NhEPPG0sf-UC9g@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 20 Jun 2024 02:25:32 +0800
Message-ID: <CAH0uvoiFvHu-iKJFNHeO1TcQHLMgo60N+1zXFQx3QrLibgEU6w@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] perf trace: Augment enum arguments with BTF
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 2:19=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Wed, Jun 19, 2024 at 9:55=E2=80=AFAM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Wed, Jun 19, 2024 at 04:20:37PM +0800, Howard Chu wrote:
> > > changes in v2:
> > > - Move inline landlock_add_rule c code to tests/workloads
> > > - Rename 'enum_aug_prereq' to 'check_vmlinux'
> >
> > Usually the versions descriptions comes at the end, after your signatur=
e
> > line, just before the list of csets in the series.
> >
> > > Augment enum arguments in perf trace, including syscall arguments and
> > > non-syscall tracepoint arguments. The augmentation is implemented usi=
ng
> > > BTF.
> > >
> > > This patch series also includes a bug fix by Arnaldo Carvalho de Melo
> > > <acme@redhat.com>, which makes more syscalls to be traceable by perf =
trace.
> > >
> > > Test is included.
> >
> > Thanks, the patch submission is now very good, at some point you'll be
> > able to point to a git tree from where to do a pull, then have it with =
a
> > signed tag, etc, all this is not necessary at this point in our
> > collaboration, but as you evolve as a kernel developer, it eventually
> > will be asked from you.
> >
> > And it comes with a test that introduces a 'perf test -w' workload,
> > super great!
> >
> > - Arnaldo
> >
> > > Howard Chu (5):
> > >   perf trace: Fix iteration of syscall ids in syscalltbl->entries
> > >   perf trace: Augment enum syscall arguments with BTF
> > >   perf trace: Augment enum tracepoint arguments with BTF
> > >   perf trace: Filter enum arguments with enum names
> > >   perf trace: Add test for enum augmentation
>
> Please make sure that your change doesn't break the build
> in case libbpf is not available.  For example, a build without
> libelf seems to be broken.
>
>   $ make NO_LIBELF=3D1
>
> Thanks,
> Namhyung

Thank you, I'll fix this.

Thanks,
Howard
