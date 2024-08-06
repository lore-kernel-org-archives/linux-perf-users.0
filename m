Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED35BA59
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Aug 2024 04:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722917140; cv=none; b=FaSyPyYcU0VG3ZRc8Uk7RNqJ9nW5ebtb9vhIOqTMumldJLvt+T0P7NbCws2IW+dbY3VRg7AQXzmivu0gfTOSXRCmi4snCwo6jq5mzWm272TJhJ+3MPw0ss2pVpe8BU2oWusvospapZH+AgckI5lcEc+qP/yUsl1fE20qkMRYLMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722917140; c=relaxed/simple;
	bh=ksgVEwS2g27EUf8mDdFHEkzlF4wPGczulQ17tbgdkZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ap5jUwpOErUHYqB22sAedPn5HazHjNvaJUtNzVrP1N9fsaBB4UyVCB+C1ZjW6zkW1uQlTLzojD5F1fU7ReRrgre8fYFV30lBmROwQDkSgHJFBKPBlpGyWipCUUfpspN1hKpYRpCc7hJz8O9TkP2/6s2v7aAyo7z+zVMe2wmtodo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fk+BkAmI; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fk+BkAmI"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fd7509397bso144535ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Aug 2024 21:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722917138; x=1723521938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksgVEwS2g27EUf8mDdFHEkzlF4wPGczulQ17tbgdkZ0=;
        b=fk+BkAmIM81iMoqcenMeoSA1x9HFTxk0sXMd7lUaXkC64r7+B0ruzt5eNaYwljIzoO
         nes7Jwg2aYO3OT6yrQAgTuq2Zs+9aKVqLcYOCYoCyVbuejz2JX7bwVs1DRFKhUHj1iZV
         mSwD7YEKddUFugJRyzr8N/7GmeGFjNQC8SA79vi7ZVasY0Ux59KxSm4gVLheeyFyWcAy
         CMmlFqr87erWW0ydI6p1s6HUT8IxsqeULHP6CAV3SsZKQP3W6i9M3uHVLMdwy8BKu8RS
         J/K0CP4A4Aume2B3PKyT/NBLaKnMyic91NiQoSxZKjWDbYFxoo5bp3E4LxQKm54udy9n
         fvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722917138; x=1723521938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksgVEwS2g27EUf8mDdFHEkzlF4wPGczulQ17tbgdkZ0=;
        b=hIWbTpg9Od3JEgyYCv28PnwYwi3wxpAwtJjXm0JIuI2sNQXzJTEtjZ4EJB8xEaDHLn
         n9zUU1hT1+N/5GcYPZs1gbfRGHCqfLfaBY+lltAw0mIzGn8DpGGHjfkpYyqeaMyHdRri
         cBNGTyh8AhZrHlxFRTipi4AWyT0w/sB97sutEAkAy67ozEikTEkbGxsHYvSFSivxTjrS
         JworH0tl3/ABEWhzF7MYjHNUb4iQaFk9t3FlwEQAEzcQRl8LqW7MFsU17gxr2GmlGy0+
         qPjx85qtrBT7jF0EzQHJi9G0QRpDZjQ8CS/SExW5W2gWBHuwx6gODbscjfaY1YT/1BVl
         8WWw==
X-Forwarded-Encrypted: i=1; AJvYcCX6LQztC+4Q7iXcZfx7xceYKbM/vDHmCRUj7xqx58VP1OKX6+pMD2FgifkXcu3j9abtUOKqbfh/1D0JENXfCfAHu1hKQ6TKAV6tCasoP+v7qg==
X-Gm-Message-State: AOJu0YyMpIMMMKx1fBYV4deIVNEYSChRW5aR3PFoegFVzjMXRfbp3ILl
	Shnr4/HgJbtoyGntHA7UDgqrHwFMigWn7cSHFzSx9g9I91FO3NtaFnK/kE1SBrRAMZN0TtW8y2L
	WUK/6dvkA4T7V0mzALeDZxl0xsukXa+BsxG4B
X-Google-Smtp-Source: AGHT+IEDrxvK9R3CWrSgJD6d2CzZl94gIXQbXiLVxjCNAOq9smV8d5JjmmD4IsrOF+xZ+lcRwE0maLH4oISqj8kMB0o=
X-Received: by 2002:a17:902:fc47:b0:1fb:19fb:a1f0 with SMTP id
 d9443c01a7336-2007666c84cmr1815415ad.4.1722917138011; Mon, 05 Aug 2024
 21:05:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805194424.597244-1-irogers@google.com> <20240805194424.597244-4-irogers@google.com>
 <CAPqJEFpiy307B4OBHK4WJGjgbVm_woUrdZ+Vy_LSdQ=ECqZX-Q@mail.gmail.com>
In-Reply-To: <CAPqJEFpiy307B4OBHK4WJGjgbVm_woUrdZ+Vy_LSdQ=ECqZX-Q@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 5 Aug 2024 21:05:26 -0700
Message-ID: <CAP-5=fWDmdAkJSoncedZTaSgFwG+p3--jywDj9krnXSfkhh6dQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] perf pmu-events: Remove duplicated riscv firmware event
To: Eric Lin <eric.lin@sifive.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Samuel Holland <samuel.holland@sifive.com>, Charles Ci-Jyun Wu <dminus@andestech.com>, 
	Locus Wei-Han Chen <locus84@andestech.com>, Atish Patra <atishp@rivosinc.com>, 
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>, Inochi Amaoto <inochiama@outlook.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, Guilherme Amadio <amadio@gentoo.org>, 
	Changbin Du <changbin.du@huawei.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, vincent.chen@sifive.com, 
	greentime.hu@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 8:54=E2=80=AFPM Eric Lin <eric.lin@sifive.com> wrote=
:
>
> Hi Ian,
>
> I've sent a patch to fix it and the patch already merged. Thanks.
> https://lore.kernel.org/all/20240719115018.27356-1-eric.lin@sifive.com/

Hi Eric/Arnaldo,

Right, I already commented this should have gone through the
perf-tools-next tree:
https://lore.kernel.org/all/CAP-5=3DfV3NXkKsCP1WH0_qLRNpL+WuP8S3h1=3DcHaUMH=
5MFkVHQg@mail.gmail.com/
Arnaldo, please take Eric's patch in preference to this one.

Thanks,
Ian
