Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC52169386
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Jun 2024 23:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717631695; cv=none; b=kfTbGldC4yIi7yAzYFPw2dpSHZIskFCsKS41nDIi/xoPpbCwhIeuPJxovWM9V3nc/uDPkDbV9neF4M2gKEzIwZw3M13/LPQPUNaApuLuIWtsded11LUsDBmSWXHLsrfdnQDY8+jNfzDmVhTdYdl591ySduOZ64cVFZZSC0nccso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717631695; c=relaxed/simple;
	bh=Tk/gg4Z7m8cPwkqUMSj9bxnEXvLbAVNGUl3GAZ8QhMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=VHm2mg49AtPIK7PbP+YXGsYzbwD50WgmPXMABiAU5P5BCUb388N9DuTy1gQQBwIEvSv+T/tYWFA5Of3vbIsNUSQG4Qz4RYcPTNaYgrx856F/3zTrw9mjvEmSr2lkVcjGNS0tt2A6jwdHrVtKKLA7NcnNGgNtCIImH/WonJmKDVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EP8zK+Dr; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EP8zK+Dr"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f61742a024so71655ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Jun 2024 16:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717631693; x=1718236493; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOoM7UFhwQ7QR/s5c6/iMqUtz+xzNojBCRoqDAeYHPk=;
        b=EP8zK+DriFdNMatQenNp34Ulk+MxOi01IKpL95Jqh9c2Q63NBrPkFcwR4D5oy0MDIZ
         AjWCSLzzMxUYB/qSRIJ6Yl07cogcN140pppAtq65uReCuEDsqr9rcAJmt822MI4eKI2F
         lNtwwbRXMQ2Dap3MVwuRuYwsUmIP6WwbYyW47p4Nghfkcp5l9jPwcYW5hwyBBDxgohXn
         TeMLvRR46CnMk7/WzjS/Qbm6+tUsJ4N005SUFnBE6WP8lF7JM0xYEt18I20eix/18CPm
         LBr7HStQFRI4L+ONGYP0XCKbwv7p7mzDweQItz/y1A6LzqPldN4pJi7ALFFR9WxnBKKb
         zj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717631693; x=1718236493;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOoM7UFhwQ7QR/s5c6/iMqUtz+xzNojBCRoqDAeYHPk=;
        b=VS+epk/Ci9aXtEXEz6MwNCi7Ogxzt8Lq75ccyl5SsLSGOG60llTG6Ne97pNDXUZyrn
         +SQUsRqJXbudb+JvdqpjciPP4vCu0NmsrwjchwHMLPzVv4PmYiDJRRj/st99SqME75Vx
         aNUqU9iyStY5Sne/0M7fL+hUiJApijVTa/AbX8cs+Gwdg+Znp32dlvJJUrNqLAbBY6wE
         +HTD1YVnZfvj3DADeN/JjIoL4IKLpU1fr3lS/NOsG6fqir/7zdcFHQVjLXSrk8wmJ7Cs
         gHpbxapNG2VcjtSEOJJV/YrN4H6QlyzF92FFIR+fBc0BAj2IDpTYlaOLU8jTkkgTzibM
         29VA==
X-Forwarded-Encrypted: i=1; AJvYcCU/qlD3h2zKAvRCOKKKvLqbRNTkDMtjd7vF7EbUEn9FBD3LYlysGTVfvWQrt90sEuf5AKkIChX3syRyhELbsu76gfYPSp4Oem/GYfp6aR6DMA==
X-Gm-Message-State: AOJu0Yz/06yfPeanvqqE0JD95NWhGB+cD2/++bNDnawyHCFVsnRVNqZT
	1cnMbPC6kfdAakOF+ktoOjZdEDXd0zeEh08snpFN5XCw6jsAJU9NxFK0tyE8Kr/Q8PzK4pLndgF
	d7oKPCYU+wHtWSeU7AON6Q5TBzfO2HDbSwy5S
X-Google-Smtp-Source: AGHT+IFKAkvdqg8Y4XtZJrq2ocqJwSXi5rXoy4qvsNne+rSk5pV5EMUpWTijA52FMFgSlCuU6iCOUgRoIxtqZfaFju0=
X-Received: by 2002:a17:902:8b87:b0:1f3:2b46:47ce with SMTP id
 d9443c01a7336-1f6bd3a4268mr711265ad.15.1717631692204; Wed, 05 Jun 2024
 16:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521165109.708593-1-irogers@google.com>
In-Reply-To: <20240521165109.708593-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Jun 2024 16:54:40 -0700
Message-ID: <CAP-5=fXJrGWpOo9B9V-T9K2fkQBhgL6edo-c039nCn=Y7FxSEg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Fix and improve __maps__fixup_overlap_and_insert
To: "Steinar H . Gunderson" <sesse@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 9:51=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> Fix latent unlikely bugs in __maps__fixup_overlap_and_insert.
>
> Improve __maps__fixup_overlap_and_insert's performance 21x in the case
> of overlapping mmaps. sesse@google.com reported slowness opening
> perf.data files from chromium where the files contained a large number
> of overlapping mappings. Improve this case primarily by avoiding
> unnecessary sorting.
>
> Unscientific timing data processing a perf.data file with overlapping
> mmap events from chromium:
>
> Before:
> real    0m9.856s
> user    0m9.637s
> sys     0m0.204s
>
> After:
> real    0m0.675s
> user    0m0.454s
> sys     0m0.196s
>
> Tested with address/leak sanitizer, invariant checks and validating
> the before and after output are identical.
>
> Ian Rogers (3):
>   perf maps: Fix use after free in __maps__fixup_overlap_and_insert
>   perf maps: Reduce sorting for overlapping mappings
>   perf maps: Add/use a sorted insert for fixup overlap and insert

Ping. Thanks,
Ian

>  tools/perf/util/maps.c | 113 +++++++++++++++++++++++++++++++++--------
>  1 file changed, 92 insertions(+), 21 deletions(-)
>
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>
