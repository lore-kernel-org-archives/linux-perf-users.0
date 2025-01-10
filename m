Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13818199B8
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 04:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736484377; cv=none; b=G0O8NWLqmSiP8+glRbT8WfLmiChtudVSt956XBBqHMiqNJGSRGSa+1UjBNzteodRBaaWxCcvSsWG8TJGpM5x8AoycVYVR0T8/IoypJ8+lK1S5XOCldQ9+PJTAc7MF82vGOxZwMYbus38NznC2S2qAWKc8QOL4ksofluTH40Y2es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736484377; c=relaxed/simple;
	bh=qB+pysJX8QfCD8ad47prQhT11z35v/s00Jlil6gPhDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HeiKEZUSfJCcPi5cv4DkrX3yYjL55BPUvO0/arGaZ1MKJLzRPc2LW2ti3huenI7Fi91Mv7Ac1TYsEOAQCzkd7wDvFY5oDraUTMpWVksRDsivQwe/jfr/Hi3+K4rtBEhle/BrjRzwmTNgAzHwl9bXK62QtygpGVQLnQrKfB5u4T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HM8sFP0x; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HM8sFP0x"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso52975ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jan 2025 20:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736484375; x=1737089175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zQ5fC1SpLlGlbuSIzE2TLhfuh43/3hqST6PYFsO0LQ=;
        b=HM8sFP0xVzoLCGpKROUe6ozlQP2A/YCEqb/T6QckxLqZYcn/RZZ5TK+hzj5NIH+Waz
         YPFnRAOIoronkOVPBGQFe7eO7e1f0Fh9HoL13L8e6U67u/A4awbVfiQPh7R3Ljz/kQCG
         ut7B9y+rWf+luw1dxwfFwS8RrEl0Gpcoqw+SISea900BQHRm48oBJFnCPNBBf2EmzMNr
         s1y6Sy9061OibtNmfCT9prWcj/rSD2ZvhxWg0hqp+WA8wS90aH3jWhNCSwt9f+WPa/JP
         GGWe1THbs5hdsxBl+dZdyT9ZY0U7gLZa/t5P7kktpQXqBXkE8XmWnH0XGNdbDbovsPmu
         e//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736484375; x=1737089175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zQ5fC1SpLlGlbuSIzE2TLhfuh43/3hqST6PYFsO0LQ=;
        b=lc0HSOCyS1pGA4fCJahvXSWagvL3ZeVl6R0nmQniNe0kAxE2rA//MTmTFpw5oV2hS5
         BUokTc5p96utvMPhk8CFfqUMSz1IuuY9VsYbj26t/mFgGGVycUEc8AIqZI5Hc94lbVGf
         TAjoy3ELMs0T+9mNA/hHizqqCKXorPUwyL7QrTwf2CR/W2hrcYEVZms/r9NscGuxsw23
         EFDGDkcdpbTRxMSBX/A8qVWVNJh9yUwRSsU/zwtj5sSpuEtEOApo3k13vPl4hcLZEil2
         Lv+qcltecofDbO+y00YufRg+ZyRRJMJjatfbYlwVl4bnGFUBk0QmFkcuqrdoehunpfWF
         DFBA==
X-Forwarded-Encrypted: i=1; AJvYcCUyuZn7dOJ643Zuw2vbFZDLELshwBisNEs59twYBmHDoHdVvZN1gvBqEfFv/CnivU5Y2YIpNapSAuvwpwzjsSp5@vger.kernel.org
X-Gm-Message-State: AOJu0YwPB2EVSaUB47KA+oGs4zxbG04U6hwGtEncHDoIk7Y4+YGEkUWW
	/AD8Ujy3+QnCtbnPDBoQHIP7yyGOPMO8az8x/4l0DsbaYkgTP97Qy1zOYtWDVwhEFoY0/6ABY7N
	BTVs4OUaGKPbLQ8BT5W96VzruXVrsgIsxwyjv
X-Gm-Gg: ASbGncv+BbJeXoa6yKlNrRwijJ8rTNVoDj+XFSRer4bZPMc2cjJtgAg1/CKfpPlbfHg
	b7sR9SYRl5HxaYlAXcb07RI+E8kYQcOR5I98O6fg=
X-Google-Smtp-Source: AGHT+IH8zZszyfZul2AgsNLzkeQcq63tHokDcvPz6wqGStRkA6bUo0Pog6t0BenIR27dsRYIr/+lEVFiR3M8yTRcrnA=
X-Received: by 2002:a05:6e02:388c:b0:3ce:46e2:42c7 with SMTP id
 e9e14a558f8ab-3ce58911453mr1153985ab.13.1736484374992; Thu, 09 Jan 2025
 20:46:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109215055.454888-1-irogers@google.com> <20250109215055.454888-4-irogers@google.com>
 <Z4BwzZ27OrG19EL7@google.com>
In-Reply-To: <Z4BwzZ27OrG19EL7@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 9 Jan 2025 20:46:03 -0800
X-Gm-Features: AbW1kvZCbkwbn51Qyf-x9IDMj6COpaKTP0T2F8ACoWFtwNUHjHhYLa3YXCdmewE
Message-ID: <CAP-5=fUNhO9oMeyTKU9fGkfvqumHfYbQp1xhiOMUnaZvOKbJug@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] perf test: Remove parallel option documentation
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 4:58=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Thu, Jan 09, 2025 at 01:50:53PM -0800, Ian Rogers wrote:
> > The parallel option was removed in commit 94d1a913bdc4 ("perf test:
> > Make parallel testing the default").
> >
> > Fixes: 94d1a913bdc4 ("perf test: Make parallel testing the default")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/Documentation/perf-test.txt | 6 ------
> >  1 file changed, 6 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Docume=
ntation/perf-test.txt
> > index efcdec528a8f..8f8a3c367570 100644
> > --- a/tools/perf/Documentation/perf-test.txt
> > +++ b/tools/perf/Documentation/perf-test.txt
> > @@ -35,12 +35,6 @@ OPTIONS
> >  --sequential::
> >       Run tests one after the other, this is the default mode.
>
> This needs to be changed too as it's not the default anymore. :)

Yeah, I fixed it but inadvertently the change is in patch 4. I'll move it h=
ere.

Thanks,
Ian
