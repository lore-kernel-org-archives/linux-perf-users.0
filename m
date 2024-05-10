Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C531D68F
	for <linux-perf-users@vger.kernel.org>; Fri, 10 May 2024 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715364831; cv=none; b=jTLrHFtPT+7a76l07s5H99DMgBv7Wmf4SNabBsBlOvXvYI3kuTNgJhcKTDoDdcaqKoDDNPiJ0rsmSv1F+FI+DfWkfaBNX2IVJvbwNecSftEdHcRhvupR5PYK1SCeyn5yn4SJ9eDoDd6dAE+E3p9di9E0d0rl7OTbE4zsqiBsFHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715364831; c=relaxed/simple;
	bh=t4K3aj+Qg+DY7iHNJVbgeEYoin9ImKEn5FRMCsBcwks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=G9eQC0AZPA5GpqV0YCCatU8nttADdAHsHzAhRTOFcsUlZ1j3BC+mNbMG7I1mOCO/6ch9YbG2G3qM8FWRCMwDz9Md2VwJRbPs6XKx+52g/1nWUUdpTX3dWWDrgRE5AdRC6NdAjcmd5g8BV+SFQMYeDZBwSM93qeq2di/zsGE1okc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b2Biy/VG; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b2Biy/VG"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-439b1c72676so31611cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 10 May 2024 11:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715364829; x=1715969629; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awbg1hXHMBJgOYCrGAE0ipMK3UY/AVrGWhRCU4GMaY8=;
        b=b2Biy/VGw50x3T3UuqP1/VVLjtSMd5YQ1qLUo1O0Q623UnL0BhjELKNs1f8K7+1oic
         EY4FAxFlDjxEINmjbJLDQQUvx1O26yFKVkmdoj9BrMVluB2cdrOsZGxS3CGZjyZxtg/V
         /kWumo9s0/jSEvTbTOwH4Z9Wl0sPYXg7xDaQQ7oYUuZ6H/q35la5V6wg9Sn2wm0QczUs
         IArMVkkk1kGQ6qOaLeyCM89i0WStj/N0nHvLTY6kJclfSqKKZeyhufMSQTf2j4ejZZiA
         WaY6rBCR87nZtzlWlpWpl0jfcG0uSyEBWLaQu1uBc/cKqrjmBmdegB9Hf2b/EaTmuqrB
         59ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715364829; x=1715969629;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awbg1hXHMBJgOYCrGAE0ipMK3UY/AVrGWhRCU4GMaY8=;
        b=TMbFqfaYDRI3DPvd+yXSwiGz/xqd/T2QrPTyYIclADTO19TfbUxMOBlv2enWmZM/c5
         D8Ptn8YVLExnNpKVMrYh83V97ZEAf9d0MWN2K+JO6T7nYQViOY7+MHRS/mnNgHo4tjTO
         E8dDatUN3EHcTlhxNAwpdyWq+QclHmpyR1ePOkgtewaJxgUVAEZf/Eu5IfLy8O6CaEfs
         36b8JaiTcLboWN64aETUdGHxWKNv8pOsaNrYS92AuZGp88MgNzGsQiRSQW8LXBYTlX73
         wNH0cThUAdh2iEHWkUnY7Lfx5K/9mX/1K6K7BtfzcIbcFSlt8fxaku30Om0M9cOFpIrm
         s5BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVS19v3OVBzGnGrh0SEdwlA6yrt4xEfLjw72k5l8PM8VTK9dW6NwMXO2e6m4bvQEU9o6vRCEpVpxQX9a6hNbC1S94eWQuZ9jNG/TNvV8saxA==
X-Gm-Message-State: AOJu0Yx1xdCw+j6vKaIB0ANQU952MWEzvKDOKKzKewu3mTnc1AatQJcC
	8ENLLivwONTXYJE9dBF0fdK2gK8zaVYbmWW1DrH7b67pIhY44s3BZplxPsR+bIgYqTc0MKPAIrH
	QFouX1akNpYSSp2D7asHsBMBud2WrE9YgLOnS
X-Google-Smtp-Source: AGHT+IHed/SSXFd7UB/8BtmerloL3E1Jl/Hl2Ocgkk5LRBYR3cjzr2/OJ3RNL8woXCagYxNtcvof15fYxmywrF5Wk6c=
X-Received: by 2002:a05:622a:5407:b0:43d:e9ce:63ad with SMTP id
 d75a77b69052e-43e09222ee6mr278621cf.0.1715364829085; Fri, 10 May 2024
 11:13:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240505031624.299361-1-irogers@google.com>
In-Reply-To: <20240505031624.299361-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 10 May 2024 11:13:36 -0700
Message-ID: <CAP-5=fVSAQOXbSfpSLTVkWcZKGx+LqiuC_ZkCxnc0iPtyfrzvQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
To: Thomas Richter <tmricht@linux.ibm.com>, Bhaskara Budiredla <bbudiredla@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 8:16=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> The mrvl_ddr_pmu is uncore and has a hexadecimal address
> suffix. Current PMU sorting/merging code assumes uncore PMU names
> start with uncore_ and have a decimal suffix. Add support for
> hexadecimal suffixes and add tests.
>
> v3. Rebase and move tests from pmus.c to the existing pmu.c.
>
> Ian Rogers (2):
>   perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
>   perf tests: Add some pmu core functionality tests

Hi, these patches have been hanging around since March [1], it would
be nice to either be landing them or getting feedback on what to fix.

Thanks,
Ian

[1] https://lore.kernel.org/lkml/20240329064803.3058900-1-irogers@google.co=
m/

>  tools/perf/tests/pmu.c | 95 ++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/pmu.c  |  4 +-
>  tools/perf/util/pmus.c | 53 ++++++++++++-----------
>  tools/perf/util/pmus.h |  7 +++-
>  4 files changed, 131 insertions(+), 28 deletions(-)
>
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>
