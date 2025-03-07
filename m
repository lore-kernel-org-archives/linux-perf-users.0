Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34C123F267
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Mar 2025 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741368824; cv=none; b=cdI0WGMLmuZlvBmKbMzo7M6lD3epavAkZ2CzPIFOLDo6WpYAjWRh5NXAf38nYmDd7/JaqZc4gk5pU/COme+BwYB/GO2rqtIOU69X+zKuRAsaHeQZMrzCgRSJbltdMpEaWK3oxvT99ISgFdv+kXiXKRMBfctVUHeX9Ew6WW8sWSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741368824; c=relaxed/simple;
	bh=ahxE4JYsaxa51CeJ3ENjN1uXinapCT6nJzDtEC7DNRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPpbK+IU+iiP0Bbw/L9VAhhT9T0GJ+dglTBrHy2R9hOv+3EG3/sR79fOKsT8PHAg9uPg/yaMsHsPRe2LWKuEtLT64WxuRhRzO1eC1EOgwyNjVlDNNfaxU7dupSMmDKOngCx88sAS2QPuSVTyrp8qqS2oSUp0p/M+B7yuCIed72s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BTl893pk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BTl893pk"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-223a0da61easo1095ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Mar 2025 09:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741368822; x=1741973622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPRXab6DmNAusf1g00ev3mIbVuq+IYAJLTGg3hKFOiE=;
        b=BTl893pkv0k5JeiSgEYH8lYGs+go8Edtnp9A5ikjBW/udXgbbWNScSxynZfdzvJ7kG
         xu5aAip6oEl+dYw86iT97fXVhuGx9AI2HASziGCh2eQ+oLTYcedjv6Hq1xtDGXwkDdmc
         IKIuBlQp4BhhhTtIqdQCAZKYgZvbKqp1pkjq06ZjZD0KM9OipzTiZ02aSvF1Ob1WvkHV
         VnwJI0C/4eZZWaxwTNzHT0wAZCTPaldqm+N+Jp7F9cURtR95gS1gyhwARW7N9m51Pz2t
         iOB1Z5wfcVyw3omz4UUQutwER5IblyYI3e3DtZyntCAQIZOP49LlGHl9d3Nj2a09cjlw
         C4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741368822; x=1741973622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPRXab6DmNAusf1g00ev3mIbVuq+IYAJLTGg3hKFOiE=;
        b=eM+23J8Ac3gwDhhFTwoaHdmxjrTVyl6kBLPr4uitJJkkPp4Ih6Upfdz2dD38EfRxAt
         e2OusodzYaSPulW5yVW83ajjMyLZC3aiio+Wxje22WzxmCIcci6tidYB1mrnKtdD2Do2
         ZnJCPSQpVLeGYWJNsCbq3u+d3o7dfU6h6dRVQEqfYlXVsU21nnSkamGI3IMxqaAFwKLd
         KnwgDfokUR0xER54ba0/OlqYGGGmILzBrfxxrvv54lqW7pYFb13tjmroChl6ePku4Y+I
         2yfe1O8Uddufm8Hu8XdODkCOzx0ltj9A4seMMFtl9kVRlcT6wg59Q7SqeEY0UBiNlS4C
         YGYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkTTyNNm4zsExF1xtaS9eZnOv1Ls6N7iPGhXYTCZXXtWH881MIcjKl1T1BgpB3yZ9mnyCHL9ksbCUnUhsXYNM1@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw+oYlPwGmJ6ShFUPvckwISmSJMwrmkkbj4HaGd+6gueW0g/ZW
	5l51IkPGTrtlGEGQoHNe86JRYSQpwThgWFBCimN+MgV9EJQgOjTBGBXCzRNyxFKFJzFvPan2LMp
	FqphRMDP/yG61FXwzKASIbwkEZ0GQ5AK6LaTB
X-Gm-Gg: ASbGncvQNjjs5GIuCxwtaZ6jYvRkPR6Ei6iIR5SIkEWfQrIfQxo/EaxpFqAa7r3357T
	ap3xikjJ5h/B1cSkw+qpy6glSWwAwPXZRFNfKWeJE+kQIrsN7+oy2nT2SLN1bedB+owZBd2mycY
	QTQaEb0FKSg+4PB9vOPjcBXXDauCU=
X-Google-Smtp-Source: AGHT+IEzQZheu5TJtSATahjhZ3enat9zM63QIvoyqZ/LEtGcyx3ArOSyUNJsAyUroa9B+ujfe7MnSYf2f6Gm/bwNmMg=
X-Received: by 2002:a17:902:ce86:b0:224:1fb:7b65 with SMTP id
 d9443c01a7336-22434c9abd5mr926215ad.22.1741368821959; Fri, 07 Mar 2025
 09:33:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307061250.320849-1-namhyung@kernel.org> <20250307061250.320849-2-namhyung@kernel.org>
 <403e3848770cef1d70357452082ddda0e92275fc.camel@intel.com>
In-Reply-To: <403e3848770cef1d70357452082ddda0e92275fc.camel@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 7 Mar 2025 09:33:30 -0800
X-Gm-Features: AQ5f1JrOnFoWT_aqgXFAIybmtf8NoAx1Ulyzs8IDlqpY5nPOnusDPd5k8O54K-M
Message-ID: <CAP-5=fXm_T_REHgCG2ctesmCAu=An6-t-EJAupfd7-et4gGspQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf report: Fix memory leaks in the hierarchy mode
To: "Falcon, Thomas" <thomas.falcon@intel.com>
Cc: "namhyung@kernel.org" <namhyung@kernel.org>, "acme@kernel.org" <acme@kernel.org>, 
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "Hunter, Adrian" <adrian.hunter@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "mingo@kernel.org" <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 8:28=E2=80=AFAM Falcon, Thomas <thomas.falcon@intel.=
com> wrote:
>
> On Thu, 2025-03-06 at 22:12 -0800, Namhyung Kim wrote:
> > Ian told me that there are many memory leaks in the hierarchy mode.
> > I
> > can easily reproduce it with the follwing command.
> >
> >   $ make DEBUG=3D1 EXTRA_CFLAGS=3D-fsanitize=3Dleak
> >
> >   $ perf record --latency -g -- ./perf test -w thloop
> >
> >   $ perf report -H --stdio
> >   ...
> >   Indirect leak of 168 byte(s) in 21 object(s) allocated from:
> >       #0 0x7f3414c16c65 in malloc
> > ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:75
> >       #1 0x55ed3602346e in map__get util/map.h:189
> >       #2 0x55ed36024cc4 in hist_entry__init util/hist.c:476
> >       #3 0x55ed36025208 in hist_entry__new util/hist.c:588
> >       #4 0x55ed36027c05 in hierarchy_insert_entry util/hist.c:1587
> >       #5 0x55ed36027e2e in hists__hierarchy_insert_entry
> > util/hist.c:1638
> >       #6 0x55ed36027fa4 in hists__collapse_insert_entry
> > util/hist.c:1685
> >       #7 0x55ed360283e8 in hists__collapse_resort util/hist.c:1776
> >       #8 0x55ed35de0323 in report__collapse_hists
> > /home/namhyung/project/linux/tools/perf/builtin-report.c:735
> >       #9 0x55ed35de15b4 in __cmd_report
> > /home/namhyung/project/linux/tools/perf/builtin-report.c:1119
> >       #10 0x55ed35de43dc in cmd_report
> > /home/namhyung/project/linux/tools/perf/builtin-report.c:1867
> >       #11 0x55ed35e66767 in run_builtin
> > /home/namhyung/project/linux/tools/perf/perf.c:351
> >       #12 0x55ed35e66a0e in handle_internal_command
> > /home/namhyung/project/linux/tools/perf/perf.c:404
> >       #13 0x55ed35e66b67 in run_argv
> > /home/namhyung/project/linux/tools/perf/perf.c:448
> >       #14 0x55ed35e66eb0 in main
> > /home/namhyung/project/linux/tools/perf/perf.c:556
> >       #15 0x7f340ac33d67 in __libc_start_call_main
> > ../sysdeps/nptl/libc_start_call_main.h:58
> >   ...
> >
> >   $ perf report -H --stdio 2>&1 | grep -c '^Indirect leak'
> >   93
> >
> > I found that hist_entry__delete() missed to release child entries in
> > the
> > hierarchy tree (hroot_{in,out}).  It needs to iterate the child
> > entries
> > and call hist_entry__delete() recursively.
> >
> > After this change:
> >
> >   $ perf report -H --stdio 2>&1 | grep -c '^Indirect leak'
> >   0
> >
> > Reported-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> Tested on an Arrow Lake system.
>
> Tested-by Thomas Falcon <thomas.falcon@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian
