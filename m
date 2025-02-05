Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B811FCD02
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Feb 2025 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738787013; cv=none; b=NFamQ+uaHYFxkU4WWv47svM+LqAZZHg+eMVouFFr26SuzKPYzXTnCK07hRJZat2Q9y0fzfdnazcV4ijXKtg19WefEqWZZPjWTrzEBbdRwfHzW26h2s1S3HWIPz/ANBR+/Z4h32MI3/xliyf4RqcNnh8MtsXRGRI+BhIylVnaKDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738787013; c=relaxed/simple;
	bh=wsMltDkEpWi/9vvUFEQa+lJpZdcNTGLeCWmIQennZfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPlCoVfsNxevYWpSLlMzQjSjNxptUtK13HrvFF37fZqVIaenBIA69h6tsahn1UXlN+7Mlj8rZE+a2NTKtynH6M0YDpzhs3zuWJCwvSa7zvp6Gnl8Bp2C8TekRT+fuDIxjYPhKS1faRX1ECzpDglFLZfrYXBLhVYUWWSXAYkTprM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bE+4bqt9; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bE+4bqt9"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d04e5bd797so22625ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Feb 2025 12:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738787011; x=1739391811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3VMBo6M4NxHrdjSNYPeuLU0Yl/mGJ8CLI8lkKTLPMc=;
        b=bE+4bqt9y7lmQiOLZZdk/P74RSi9qB1ICZpUJeQ0X5UtPM0xy1JdN8BY867hfWA9WT
         87CzMpY9rgNucBU4VXyfSUbxKn2YMgIjl1zWpJd1DSRpgQ2GTa46HnA0mUjBEOGU/Psh
         SmwExF9LHFz+UdtwpHBGRibUuq5zrjuNI2YG3xr9kknNlLF+nVMUfjGJgQKm9B4GwqUz
         ZtKJ8tYGN49ckXsknAP2MPONRYMGsTLGl5nkl7MtAGG/CxO5xMtBfTej4ZfzxP8HEbD7
         FEsTJbXlNrtPvS9lBJvXRjhT0OR79C0XkUKzhFGY660buthNBEOaaErnznzvZWZDpPFV
         c1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738787011; x=1739391811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3VMBo6M4NxHrdjSNYPeuLU0Yl/mGJ8CLI8lkKTLPMc=;
        b=D+f7GnpH1y8aKqaWZJhg05+bLxw11Rw/I4M7n2867HksAT4nqAGfn2LIWygjE3m2fJ
         tBlOeEv9lIEPfj5uYxhSPxLj3bRnRumCe/U3gDaYzeNNp7pJarag7jTTW4eqJlN4A12J
         sWuLwuocBPZgu30WCwisGBjKFfigIDNP4a8vJ0ozrLDHF5baUalufoIn8WDqwBjXKh9C
         iWkfSOi3bxl9lXPx8KmM2exY5j5RV/zDZnCWhqszCjqiJgDE8kUuwXk8YJG158Z/kI0Q
         HLAowvqh7Sa1KON/OZgNpDKiRA0Lum8Qa8pKJwZg90koPMj30OLEJ+QCtnWuJlBfgnAz
         XhPA==
X-Forwarded-Encrypted: i=1; AJvYcCWueldcLGKOpqSXgrUDWW2kHGM1Z4vYVlyblnWMiHDy3uwOfcY2zBuAmdT0Qi0ZJzQ/bjUYhoE6/aLSbVGjgFT2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx97zXfAYxhvOFkVEVf89+/MvuMdfFLbA0kjw5gdC6OPZSexxhA
	quTipjXdnAm9QMQ1wDU6FIEwpEkujWAUzEfF1yxxfL0OZe7Q7VLnNjhqTl+bYvoXkSUGdnsQGLy
	A9hZXt0LvewcvQIN0BJ9vb4hTxFUyUQrVyY5c
X-Gm-Gg: ASbGncsnMSm2dp6XHBOgScUGIqg7U0hVBf/zreEjrJr4649ksqG2EaTi4RO9n1OOMg8
	bBropnuFrVm+RGngRjy56DpVlo6Tau4Dx7uvyDbkEmfFEk+fVdd9GYJq1FY6dQpyL/nksdN3pyu
	bttfFvtG8E/xZYBlUH6FVm6lBD
X-Google-Smtp-Source: AGHT+IEXh3rPoZZSrrnSCQYmSnDnY9aLV6e5b8Kl/me6PZRg7kJ/ZNlyO+jUONDQT6QilBwlvjlzZwl9GHBFCHcccak=
X-Received: by 2002:a92:ce8f:0:b0:3ce:6758:24fe with SMTP id
 e9e14a558f8ab-3d05b358adbmr405155ab.1.1738787011033; Wed, 05 Feb 2025
 12:23:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205173140.238294-1-irogers@google.com> <20250205173140.238294-12-irogers@google.com>
 <7692d2d6-16d5-4f50-8c3a-37f1db356426@linux.intel.com>
In-Reply-To: <7692d2d6-16d5-4f50-8c3a-37f1db356426@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Feb 2025 12:23:19 -0800
X-Gm-Features: AWEUYZmBvBkMAnK16XwVqYBVic-6udqKjGw7mv6P7jYSBWVAh8hWAF-BgmXV45E
Message-ID: <CAP-5=fU+9MgMbQKpFix+Jw8k+-_yfAs-F+FYE4CmTWxevPmd-A@mail.gmail.com>
Subject: Re: [PATCH v5 11/24] perf vendor events: Update/add Graniterapids events/metrics
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Michael Petlan <mpetlan@redhat.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 11:11=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2025-02-05 12:31 p.m., Ian Rogers wrote:
> > +    {
> > +        "BriefDescription": "This category represents fraction of slot=
s utilized by useful work i.e. issued uops that eventually get retired",
> > +        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + to=
pdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots=
",
> > +        "MetricGroup": "BvUW;TmaL1;TopdownL1;tma_L1_group",
> > +        "MetricName": "tma_retiring",
> > +        "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations =
> 0.1",
> > +        "MetricgroupNoGroup": "TopdownL1",
> > +        "PublicDescription": "This category represents fraction of slo=
ts utilized by useful work i.e. issued uops that eventually get retired. Id=
eally; all pipeline slots would be attributed to the Retiring category.  Re=
tiring of 100% would indicate the maximum Pipeline_Width throughput was ach=
ieved.  Maximizing Retiring typically increases the Instructions-per-cycle =
(see IPC metric). Note that a high Retiring value does not necessary mean t=
here is no room for more performance.  For example; Heavy-operations or Mic=
rocode Assists are categorized under Retiring. They often indicate suboptim=
al performance and can often be optimized or avoided. Sample with: UOPS_RET=
IRED.SLOTS",
> > +        "ScaleUnit": "100%"
> > +    },
>
> The "Default" tag is missed for GNR as well.
> It seems the new CPUIDs are not added in the script?

Spotted it, we need to manually say which architectures with TopdownL1
should be in Default because it was insisted upon that pre-Icelake
CPUs with TopdownL1 not have TopdownL1 in Default. As you know, my
preference would be to always put TopdownL1 metrics into Default.

Thanks,
Ian
