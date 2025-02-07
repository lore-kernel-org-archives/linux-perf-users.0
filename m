Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE85A188596
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Feb 2025 18:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738953841; cv=none; b=Mg3bBFDgZuMcUMc5bhZsxTPmbbeefaoz30/qhIuanIKQxD4Cn9RivNH08uw4lvnN5fCkRMmB2n53GH5m3Uj7aY/aK1WrT3dh0Mh7X9h8VE1Pg4mQHJpJypE2bBiEwac3MlhurTTGkal840xQG44tVHalBRv7D0AIIS9UqBzUa/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738953841; c=relaxed/simple;
	bh=xw9ohBuPP1PHhzXIhvS4ajE+J30QQt9YlU3w3geOk/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Gm1fWCbXFPB7bl+gy6fJ+kBAmGBeljZsWNmjlTZ4L9JImUx4uktFnH/lHoOPw8qLph5BmadwpehZvO8hpXkVDvCSCxV5zpzvBQan3xggFNDz2mLf0r8SfU/4H4m2mW0KbvA8hN9B9/nnsXb3RHPcnTnI1X+C7x6ZJ0vDB5GjVqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RIxfjyIQ; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RIxfjyIQ"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d146357fb2so15065ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 10:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738953839; x=1739558639; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mDqitGlbkpJDuH2VQz6cbRcchYfLHIJ0XpphkGi3Js=;
        b=RIxfjyIQEE6tmOlc76GtiQ9Fop2slikiU6BhLmis+E2Z8c0HKxcbX1SyuPUkqGh1pQ
         O9okYgULkl1TadIQUiUV24+vBcMNFjC9Xk0XvZglrpXdXvJ+g0d5j9mBYhDLmKruag1J
         bM9ayE1O+fjyKH8wzXXCiPWWfGoZDaIo5TM+ZQaSgFlSVS+IdoJa28PNG8jCV8NIexnC
         wRsfBavlZJQ0+OvRuvvbEi9AdDE+F7nh5iWvBa2cuhM6IJnzaIhOELrwxmRZ4/Apgq7N
         uk3RmEQENd0VNqrM7u7gF1jRqLu2CwDuyEWhjGiLoYCg0M6goOgOa6Uyh2wkuKDr3B9U
         M01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738953839; x=1739558639;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mDqitGlbkpJDuH2VQz6cbRcchYfLHIJ0XpphkGi3Js=;
        b=ZH7bcKX0pGAjKHSgmq2UjzbdgmAgw1zS5SAxsmfRubdYE8hFv9KUFR27wI8UPJP5Rq
         hnb1ZxIzbLkztsUejpzPJdnKeLUtafN5+G2OLE9IUkjkQ3VdT6GNmUzR8bRldEe47dr+
         60f6bedAcZidD5pcV6KsjvpaKopj++pXtQjioQwvZHdMGpMLbVIxA+KrHy0QfSolIod+
         gSc68u0CnpguYpoRuX0EfM7xC9LNnaCfGEp8djJXeaLHTJQOCKBRP/X3jX6b3f0os7FX
         ZHkwq4zqdwYuoAE5TvSty/xHT4qARfdy90cU5T2zWEt+dMVwHQQhoGabQjjZNw8wVk6P
         nSrA==
X-Forwarded-Encrypted: i=1; AJvYcCUC3NNUTlzoHOqF2tIIHB6EvcbRi4PW6XrmgoTMyg1R121S8Vu6UNczAkey7I18+l4XN9zg0rskI+aeAML67Pu7@vger.kernel.org
X-Gm-Message-State: AOJu0YwuP9wVEDZogOc18Lecd9HL5GrArwTr1pipwhizGN1kxNYs6lwo
	oHh2Q3SopN5URppLuJtB6xxno8ptCltphdQNueFHwvepRdJfzOqBWppjnaUYoH8gnilN0ZNNa1M
	uY4gbvovSm0IWyBM0QtlfIAC2Z5Ro5Gn9uYqE
X-Gm-Gg: ASbGncsTZmhnk9zrrJHpbMv6jpVc9Uv2ANcOsQuLPZzOtpHy/85bNsZ4/pKIaJGBHGC
	/j2co4194w/0nKGHG8z6aVquhFQ9er5Kb2+wQz/7U5sWyUJzIml9Ky4s4nRjH8gqsq8qKyJVHfg
	==
X-Google-Smtp-Source: AGHT+IGtx+KhQ0Wp6EnPXlhGbxviAiV0er36lH83UOAXDy+Sv0GePUrKiEEeXyEc3GpCohWzxjIF2aL+e7w3TombAck=
X-Received: by 2002:a05:6e02:b43:b0:3a7:a468:69df with SMTP id
 e9e14a558f8ab-3d13f1a450bmr3027925ab.3.1738953838625; Fri, 07 Feb 2025
 10:43:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207181959.799610-1-irogers@google.com>
In-Reply-To: <20250207181959.799610-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 7 Feb 2025 10:43:47 -0800
X-Gm-Features: AWEUYZnga4RiZjiKLQPC3fg6oFt8l1tDjda97Q4LcvzQqzhyY6N9r3ifhBfozA8
Message-ID: <CAP-5=fWEvr+r39Yw46W6uNbKWoxxPoJ=_xNqZkJSFUEpVc2Wug@mail.gmail.com>
Subject: Re: [PATCH v6 00/24] Intel vendor events and TMA 5.02 metrics
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Michael Petlan <mpetlan@redhat.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 10:20=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> Update the Intel vendor events to the latest.
> Update the metrics to TMA 5.02.
> Add Arrowlake and Clearwaterforest support.
> Add metrics for LNL and GNR.
> Address IIO uncore issue spotted on EMR, GRR, GNR, SPR and SRF.
>
> The perf json was generated using the script:
> https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
> with the generated json being in:
> https://github.com/intel/perfmon/tree/main/scripts/perf
>
> Thanks to Perry Taylor <perry.taylor@intel.com>, Caleb Biggers
> <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>,
> Weilin Wang <weilin.wang@intel.com>, Kan Liang
> <kan.liang@linux.intel.com> and Thomas Falcon
> <thomas.falcon@intel.com> for helping get this patch series together.
>
> v6: Add Default metric groups for new models (Kan). Fix TSC and
>     C-State metrics (Tom).
> v5: Remove Valkyrie metrics mistakenly added on atom. Ensure "perf all
>     metrics test" doesn't skip for missing events.
> v4: Fix TSC events on hybrid mistakenly specifying the core PMU
>     inhibiting the use of the msr PMU.
> v3: Fixes for hybrid metrics that were missing PMU. Update to the
>     latest events.
> v2: Fix hybrid and Co-authored-by tag issues reported by
>     Arnaldo. Updates to Lunarlake and Meteorlake events. Addition of
>     Clearwaterforest.

I've spotted that ARL, LNL and MTL are missing the Default metric
group for TopdownL1 on atom cores in this patch set. Sorry for the
noise, there will be a v7.

Thanks,
Ian
