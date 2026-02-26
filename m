Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B9136F42C
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 01:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772069672; cv=pass; b=brywgieUOcS8c3ZMZVCFXDUftannH0Kwa2KMmYxm4lYVamVuL8KJTV6ClnR3RaU/vicR2rtXzC+XguYm+PQvrhCZqCpmHuVdzhnDaLeWTDwDF6JPM0foX/ujM3uXe7LzFAyXmW4DSaGGlvYq6CTUPW+ayXm1wIEyj4OpBMTTI8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772069672; c=relaxed/simple;
	bh=2lfNOdwp7Hs9olEfUgKwim/PUZCEuG6TXfOiJzzfu0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XEkjFYZEkQ5TjSmzblhZtPT8XVn/Oy0qL3jIiARZbjPYLw6PcObgS0+is6I793MSqdLBjs8vjGd5ESVvfIobdrUhgpBXYrC1VOZpEo2MtboJGm8qcUVHq55hXae0CPAww6OLbte1TZ88jdS8F9RgkBllCnGpXKVwo/fQdp5j9/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a6BjN5Wh; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a6BjN5Wh"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2adb1c1f9d4so45835ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Feb 2026 17:34:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772069670; cv=none;
        d=google.com; s=arc-20240605;
        b=UPMza8QUI0+aVniGZ4ZWRx+KNy377W5u7rBcz1WH4iJ02nINFNUzqP99pT38txF43Y
         CA8BwJ+j07ejjs9zLN5di8TPXm9fkoVIlACTRXpkVLEi0rxJrS6PRRODtWxuPV86l3kP
         y0KqwMXK1+wyEDaLvMnLl/E5Xp6IsaV4ySKNppMyZyc3uBX1XlhB0fytyflNz/pPCrkR
         KbcJIPu6iu+k6MT+j9ThUI2csQG4hyYgkLCXIWDgh0Tv64GccEXnd2lVpWT1eVd9MXV4
         P9JbTDOiEwRHc7dMifennGF2TC4wSny5BHt/X+RNJSUjrP72PuACtpIaDE5mbhfX3UP4
         XsDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wjQ53JZFB5yfDU+VhP3J0dlwnX2GHMinS2bwduWJ8k0=;
        fh=K4oqgZefKrxkzgAh2XLQ0onft6ZHyUsnn/SddsGkmH0=;
        b=BBnMsgtHzMJ2yCAY7u2es75gAaiZ7GNqDJvc/gaBmA2J6LWv0dPgyxfR6TWV80Hft3
         0HXT/eFKg7dGqRnz3oIcKMTGX2SAo6/MCAwQJ2i5SvhhOw3XYe3rAzu4h50cZJlek73V
         48V5ArUYYYPXBtREAVywHk2vmMLtRjEYd6hNLsKTzhIFUIYdvNpogHay0Aljf6uhSk13
         QwUZ/coWGkKywYiJz7hGH3kxSAQyFMTe1kdC00pP7DaInVuAieE3GBuMsr2ARr5x5HuT
         PbykT1Ql8G5N7gQDeG7+uwSELDVCl5fSFgf95t0h+42MyjV2U+yWMJmYKjG+To8p0Hp+
         aPtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772069670; x=1772674470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjQ53JZFB5yfDU+VhP3J0dlwnX2GHMinS2bwduWJ8k0=;
        b=a6BjN5WhxNPYlE/9Xzv/pnqVAaYDUH35ugq+li56Yi1OmcWO4Q3jopdxpCEh6RdCiV
         EuWrb+Vn73pcxwcS0vHWc0+6uhZqP31r77VyZ8KZfFSSNbgU7vwT7fpk8OivQqEq+BZB
         z8eo+wasWdytKE7VS036K4hGQFO5ML+3+HqO/a5lL6fVVmIN+pkMv34rPQ9Bilr1lysg
         xDPcCht31MqodCYJ2b6BezFregTeXrjsO/4qItobSbiofVQWb5WR/dYRELu4/fQArJOc
         yTnHiM+o0jy50ElzwkRJiN9sYMDp6L0ivOezr/BSQ64Qb9BpTbPL3etQcYy/vbPg0c/m
         Xb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772069670; x=1772674470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wjQ53JZFB5yfDU+VhP3J0dlwnX2GHMinS2bwduWJ8k0=;
        b=bQ+vNEluy4TsLLQXLwKEToJ4T6PU9iGnGXQlFBMu3wTtFz2j18mlmHj4th+4J672YB
         kOpt3MeBIUS1yFL4rUy5v0r6q5v/SjZ64hIrYZHIxOTf+vvCG/wBU0zW6uU3+M5Z8ZkI
         dCpVLZsdUyfeUOa+A0SaDc1AwkSmVG7jmP/gM0CW7y4qDv8BnmVY67Dp0JqOAqvIYAqp
         ZlHg31PVxIipnUBjXLHdcIHAtNVL1xKQZfDiaphOmSXJG+RmdSbgIzbM/WPpsFtcVxQ0
         haBpegbE3AeIR3209hIq8goeWUPK9inNklHHkjbvWpU7zZtnZl6htlXRNvG1fIe9MwCx
         DObQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbnTLVNzqpU/omwIXZRbTNUQZAaCFF5EWhEQUmMx1e9usk+KplDGXF036V0WBvIrh27LX+xAV0l2o75ZoWQTZ3@vger.kernel.org
X-Gm-Message-State: AOJu0YzD8PRLc2XmC5TuO/BEluAng5N3xTylRWAiwCPr7VCNmLl6jKNx
	WhU7sNOej4CiyPW2+d3s0dnKcp0ZJNC/y/X6kt5pDfgRoK072RvEOtwDG3KdWFVTZwhAXaL0Pm1
	Iz/ExlTrdY24QaRI9opMDC3dC7kaZTjX0TtEhklKC
X-Gm-Gg: ATEYQzzWyAhhZ17AQSCQFs2aQgWjiio0wO1zuL/xYjVL9SZrmTh+ntKr+ZJC/pjlA04
	ieS37ll1Ci/WSRkuZjwQBavHX6k8Qx1naJHCnJHkzg7yIdlv8Sqi8UpG/hxABIb+mIaqyXeTMVm
	pxJ3QGCSnGsLJQzgO/EB+nlORlPsXRzjv/ZqF4l62dRAG3pKYp2kJz3XdsHnG0mNRDmXrGFrMWq
	/l0kItQrGGiURTZcSf4OqvqpDVV0ZWTiLK6VfZgvuOUjvP4Lt2gT0JnFk6iTb3Xqbquzxo1EfUs
	obkrQ33B0WJR0xs8OSnzBw3Zu7duuc+wJ3L+dw==
X-Received: by 2002:a17:903:40cb:b0:2ad:6f9b:7819 with SMTP id
 d9443c01a7336-2adf77de594mr1447145ad.24.1772069669550; Wed, 25 Feb 2026
 17:34:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224142938.26088-1-irogers@google.com> <20260224142938.26088-8-irogers@google.com>
 <q3oys2ukvylrd7xfn7267bh3wpumyxbbxpk2udhps375cmk64p@l7sjnlxll6c7>
In-Reply-To: <q3oys2ukvylrd7xfn7267bh3wpumyxbbxpk2udhps375cmk64p@l7sjnlxll6c7>
From: Ian Rogers <irogers@google.com>
Date: Wed, 25 Feb 2026 17:34:18 -0800
X-Gm-Features: AaiRm53aNAb6Tlux87h_8UOmv876w-RjbJJ3ZYy7jl1sfvFunMT13zrT8xA0lxo
Message-ID: <CAP-5=fWVU3ktkGAnZQrjQJf+Z5AtQo73BVUhj-nr3H95GdcEJQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 7/7] perf unwind-libunwind: Add RISC-V libunwind support
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Blake Jones <blakejones@google.com>, Tomas Glozar <tglozar@redhat.com>, 
	Yuzhuo Jing <yuzhuo@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Shimin Guo <shimin.guo@skydio.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Chun-Tse Shao <ctshao@google.com>, Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, Thomas Richter <tmricht@linux.ibm.com>, 
	libunwind-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 1:08=E2=80=AFPM Andrew Jones
<andrew.jones@oss.qualcomm.com> wrote:
>
> On Tue, Feb 24, 2026 at 06:29:37AM -0800, Ian Rogers wrote:
> ...
> > +struct unwind_info *__libunwind_arch_unwind_info__new_riscv(struct thr=
ead *thread __maybe_unused,
> > +                                                          struct perf_=
sample *sample  __maybe_unused,
> > +                                                          int max_stac=
k __maybe_unused,
> > +                                                          bool best_ef=
fort  __maybe_unused,
> > +                                                          uint64_t fir=
st_ip  __maybe_unused)
> > +{
> > +#ifdef HAVE_LIBUNWIND_RISCV_SUPPORT
> > +     struct x86_64_unwind_info {
>                ^ copy+paste issue?

Seems very likely :-) Will fix in v2. I'm still after a way to
generate a compile of libunwind from its github with all the remote
headers built and not just the one for the host I'm on. It seems there
is an Android solution for this, but I was hoping for something more
upstream. At this point it is looking to me that libunwind is a dead
project and we may be better just deleting the associated code.

Thanks,
Ian

> Thanks,
> drew
