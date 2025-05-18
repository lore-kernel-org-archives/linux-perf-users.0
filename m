Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3274EEDE;
	Sun, 18 May 2025 22:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747607223; cv=none; b=kBuFxEln1qBMJ7wniYRXwU/2gMcq5SS3nfn92j9XXlB6Ufjj7eeG9h33Btk9z069l/x/IAz86jAk/S+1yIDOSfVMkzIiKNUMyXOWmBQJzhSdmp5yyGiHR3OsQSqrglJDttQ/2+XFdMlkAeK4Fiol0rriJMBhUw+e9G5ngAeKFgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747607223; c=relaxed/simple;
	bh=xL6Z4PGkknXVho+JeZ5LzycfHmADIxu4S+kPxKl50PI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=op8CKAnp6Rpl2bLvcZH7LzZJk8JlI1oXNGGc1oEGqb5L9nhZSVpS9K2eSeWhrol7ICPPzJF1id0p714we+BoyGbjVj32hroLRO1JlYmxgnSbH1nRfzZ1MWuf5g8672bLRfvj6ggL9VXeinj8Rc0bWnHRgnYmEOrEQbtG6D+B4GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZmrViFH; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZmrViFH"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7080dd5fe92so30151847b3.3;
        Sun, 18 May 2025 15:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747607221; x=1748212021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ssv6bZwRhvX91G+SFVNUep76r7LL0MP2SbXYm9UXRk=;
        b=AZmrViFHfrX8JNzPsrDRz+jaNTu+wP9pgNC/IHY6ZaSiDvv8lQamL3G5VJI63etshY
         Mi9C74hogVolirY+VWk3BvJ7o1bu+Q61NP7Al4SJQAWCAoAa+9U4J93CG3YkXoRuz+18
         vWudUOKQzzKvOSv3bcISgDx8cYOdb7ccG44j2AN1dKuCRh3Xore/nbn4t3dEyYtZjhoJ
         Ww1YwJTPZJ86iR5cMqw6d7kvyi3QS2fXctP+ts4BPw+iNK8cu2PHkbCyFskIgii4DbMs
         +tViFRB9y/fU88vEx/1aRKWrW4/pZ0FRZhvq957hiNZ4gS27OU0QPqLiWNj2pk6lzYJP
         dozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747607221; x=1748212021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Ssv6bZwRhvX91G+SFVNUep76r7LL0MP2SbXYm9UXRk=;
        b=s3SgDyGDSWtXCenMSrAC/77CNPV5z2Dst+ifRLjAih2ftBVERlAt9y5YqFpE6iYa/8
         IIMK1basq1xZDa9hWfWDbKDpc/gWn1ve/kjl24QjrJrOZBWFPxak/zzojnzqQLQSmbK3
         tAxp+Z0reUZKorgj4Vbvuxpfc3k8fMqNTrHz4LiGRHKpcM9om+C1coLKAVyroVZb+HCk
         LVI+xeOBLaplziAE8EnQxCI8v5UpI4uYBI3vBDBi9spgWoi0YEX2Avw2pXKZLVJ5jR36
         oarQ7wREA85MFNTtWHgrFRU6cux8mvO5moA+6rU9hRTA/U+aKHV9gPux7zXXEVuapKTa
         +f1g==
X-Forwarded-Encrypted: i=1; AJvYcCUMr6wnWOlxrhPktN0WI4MNVlqApnoDmMQoMrkPUebisGnFoEum4UvHAKb3XO6N6UxnXA2Nrm1lkdDgoig=@vger.kernel.org, AJvYcCVu6K1n8vnQvueFrD7Pff/EaQcL3egFPr2lhfOxzD14Mwrc8psJ7R+rh/zZNELeWVIAvosRrc+f/BW/bKXk+pLrUw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyl9knuJbZUn8RFVMJ65pkWh7ZAc6FSsCf7UybrbRb4oqEfaKe
	JL8AKCrwvIXDpoJ8j0nY2QD4OfPqsfA+pGbplTdrCrbM+Yxcxinmeu9MpuvUuk/q4GhTswE6g2t
	NoEOCNMMmiRnF/7tNOA5PLFs0ZZFTZLk=
X-Gm-Gg: ASbGncs+E4BILpB9BpGSmLVF41zx4EXCoQXR8jbSOU4UBnmBokBnkFAuxLcZ46jAeZV
	6kEsviDbdg4vledKMBdMZXq8vcANLk+5f/FHA/BmNc/sTqnmHsBFpCeo1G+v/sR+/NDQzsdXRHz
	WOzqoMV9lOnPKMsqikbqA+14yZl41maIj3zV+44ARflQ==
X-Google-Smtp-Source: AGHT+IEN90OAVd+S+3xBAQbuQInzkBvmRTX/ff4EN8fUsnwfAgRbHFaUdl1fTbho8Q4Sn0mcAwLwW+Y5NheVt6u60ok=
X-Received: by 2002:a05:690c:6385:b0:709:164a:fec with SMTP id
 00721157ae682-70ca79fa08fmr146692907b3.17.1747607220735; Sun, 18 May 2025
 15:27:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250518190957.58932-1-howardchu95@gmail.com> <CAP-5=fUs9ZVa3z54w1GyKrR=D0YF5GmSZEQ4dh=cKehTPD_w1g@mail.gmail.com>
In-Reply-To: <CAP-5=fUs9ZVa3z54w1GyKrR=D0YF5GmSZEQ4dh=cKehTPD_w1g@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Sun, 18 May 2025 15:26:50 -0700
X-Gm-Features: AX0GCFvppkCaeGr5ugqVPhD_rjdxUuu89kKUjXUCRoupmZnxFj0eBjjrxlgsiiY
Message-ID: <CAH0uvoju7bFsJPeqaDBzSFzM3GZkaTWgfcgEtcBr9dpn=T-e2g@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] perf test trace: Reduce test failures and make
 error messages verbose
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, mingo@redhat.com, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, peterz@infradead.org, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Ian,

On Sun, May 18, 2025 at 3:18=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Sun, May 18, 2025 at 12:10=E2=80=AFPM Howard Chu <howardchu95@gmail.co=
m> wrote:
> >
> > Currently, BTF tests fail constantly, this series fixes two major reaso=
ns
> > why they fail, and makes the error messages acquired when using '-vv'
> > more verbose, so when they fail, one can easily diagnose the problem.
> >
> > Before:
> >     $ sudo /tmp/perf test enum -vv
> >     107: perf trace enum augmentation tests:
> >     107: perf trace enum augmentation tests                            =
  : Running
> >     --- start ---

<SNIP>

> > Changes in v2:
> > - Add an extra newline after error messages
> > - Rename the title of patch 3 to 'Stop tracing hrtimer_setup...'
> > - Take the debug diff for explanation out of patch 5 to make it apply
> >   normally
> > - Add base-commit in this cover letter
>
> Thanks Howard! I did some testing but see failures that may be
> pre-existing issues:

I don't know the command you used but if this is the result of 'perf
test trace', it is the parallelism issue. I will fix it once I'm back
from Costco :).

Thanks,
Howard
