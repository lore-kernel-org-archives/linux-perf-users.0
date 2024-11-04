Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D3C1C32E2
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Nov 2024 22:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730758844; cv=none; b=Sbp9eXNG3Lm5J45fec0vTYwmVPSN3CsDsHILDTV8wT9k4SXPGJ8ZxwdNIEZKL4nwgiFWcdkKpdHcJ8y8WDQc8J7TDgZpHhqZzuI06/MK9DvzjkuBhKOtw6o/nffSCtP5L8gWr3Vq5fArjftaGDu/FPjxHftxl3W52QbVxx60OyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730758844; c=relaxed/simple;
	bh=YtC1zPgY1CSZDUiukBIdLDlWX++MZpeTPyZCPXa85rY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3gdpAxauNHXJBQKP5Iw6K8OimYzeOrn2MVgdExyvahxu4lWcByh5kBUodZJIhcHOKI7YeSiGN9Zx++L2CEWurkTT5aPzdRB3CCGqIlsImgsLI54VGCEZv67aRdNvk5d/FnAvRZfTokdMkiztXsRqEKOLV8qoeU/nCnBATkxU7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h9/+Lsls; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h9/+Lsls"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20ca4877690so15455ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Nov 2024 14:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730758842; x=1731363642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezu069EFwz2Tvc+ZJ6gG6EgI1srdu0M3gSI1AGlpaKg=;
        b=h9/+Lslsnuc1rsbuOrcvvPPQpfTClLifp8vvV9hRNszH+13w2mEkeUiNZJRC6RCklH
         dHgYRv/djL/sKsUH5+eePknLd+Rasd/VJ8JxK9f22utKlm01SK27p1BqB4L6LEVzHCva
         FlbezI10ikMbBEXSrqSaVUL/MawQ7QZXuk22go5qEx70of/dLDrV3ozRuHsFuTZIf1fp
         M9GePO/t2GXiaaPu5JG2rNt+tRP2wbNyxaXS/N3NeXNK9bjj+nNJH2xTpi0OBNfgFr0V
         N7SYcpSb4GYRi9KsqcOE45n5/9hOSbAFzH9OMDgHqhf4sVbgAYE7pY13aUeAAyPzK0gA
         6acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730758842; x=1731363642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezu069EFwz2Tvc+ZJ6gG6EgI1srdu0M3gSI1AGlpaKg=;
        b=NR5g1bCR0/vT0MWB2hOjLN2sxLxGBp8pNzSDWKsAOpc/MZZYmMNn2UBQrx6aqKrZDc
         1Hd3Wi40HkRJAgNiDJv4yMbGHA4LLVPqnINtH3nGjKg6EDxyDpRTcQvwcMf0aYeGNdsI
         4AALHwVjidDicN0RayeKJiJd/mkh6G8btET3ErucRFGkBxO3E2+JDedXxmyrcxqmRKDj
         aWPDeBD/zXNHtyIhfA+T0/T+2gP60e+5fCg3PlJJR6LyA5g7+ewsuYUmbWwCfeglPQy6
         xzI5S/uh/A1xuMQRxKQHP7hINSZuHrqev3I27e3cNNCoPyxlJrwUmYiYJXH4kq/SzhTI
         TMyw==
X-Forwarded-Encrypted: i=1; AJvYcCUFXfxKFxBq8nQkIKyySDZ+eno7pUaHH4sGwZREqFAMm3OPmdXC1Lhbl3QDkzZKbpyaf/KfgzSsLqJG51eilnBy@vger.kernel.org
X-Gm-Message-State: AOJu0YwI5rJVrHUX4L8GOhxlV7lpJ/MqD4tbfcOzPMdl3m/Nnv4FCWz+
	he4ybVbtL0EdomJfjV3RSmXcovpKhIPHoXvJ+U49KpdFDjHDFpTZz3R/FbFaLurS7ijI4o1OiPQ
	0p3GUBvWIA026ux049UsR43udhbnXgWxStjsJ
X-Gm-Gg: ASbGncsnL9d94Lcoa/kZRy8lgUqHy2pbnbfPGJXnBsQhVI7X/kfYQYPhByjgtn+2DzW
	aGptKth/CtgWwAcqFOSZV/Fni7DwAjTSCDPhpYusV45Yo2gVc9gbwJCpupcXpqWs=
X-Google-Smtp-Source: AGHT+IHx1BUa6dlZq5ClEuvGMRG28L4rSNnJktrt9z2YvZVUPM9PhUoKpEnE6UU2aAqiSFY7/NnFVOS4Ww51+uWcck8=
X-Received: by 2002:a17:902:c402:b0:20c:6c50:dc80 with SMTP id
 d9443c01a7336-2115f63dc88mr211675ad.9.1730758841928; Mon, 04 Nov 2024
 14:20:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031014252.753588-1-irogers@google.com> <20241031014252.753588-7-irogers@google.com>
 <ZyPX7ayIO4teziDX@x1> <CAP-5=fVgJu8BJWFVUkCy1Zsi3piTPdV-GXL1bTpWZeO=nm=jrg@mail.gmail.com>
 <Zykk2MJ4REGCaqVw@google.com> <CAP-5=fXQpej43wxEtMYFbxdofHtUi98X68W4AaR9UCfsbDir5A@mail.gmail.com>
 <ZykxD41c6gWQoIrQ@x1> <CAP-5=fWf8guTgqwfrrct3AGYDC=Lb1Oxo7kXU_x1yEr5urFSkQ@mail.gmail.com>
 <Zyk19KgzI7ybPkQ4@google.com> <CAP-5=fXj1-wqt+Bs-0ZypRsaZw2VP0qyKdeeRHpjUD5BwO9OBg@mail.gmail.com>
 <ZylGJF7Ux3JdJllo@google.com>
In-Reply-To: <ZylGJF7Ux3JdJllo@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 4 Nov 2024 14:20:30 -0800
Message-ID: <CAP-5=fUz_LSJ4v4aaAWoLMQRXAtsqeQSjcyRun2kBVXUHTzvUA@mail.gmail.com>
Subject: Re: [PATCH v5 06/21] perf script: Move find_scripts to browser/scripts.c
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 2:09=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Mon, Nov 04, 2024 at 01:06:35PM -0800, Ian Rogers wrote:
> > On Mon, Nov 4, 2024 at 1:00=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > On Mon, Nov 04, 2024 at 12:48:01PM -0800, Ian Rogers wrote:
> > > > Namhyung was asking that the c&p of code be 1 patch then "add new
> > > > changes like using openat() on top". That is:
> > > >
> > > > patch 1: add is_directory_at - introduce the 2 line helper function
> > > > patch 2: move the code
> > > > patch 3: update the code to use is_directory_at
> > > >
> > > > patch 2 is known broken as patch 3 is fixing it.
> > > >
> > > > Hopefully this is clear.
> > >
> > > Actually I don't care about the patch ordering.  My request is not
> > > to break build and just to separate different changes out. :)
> >
> > So, patch 2 can't be separated from patch 3 - are we agreed? So we
> > squash patch 2 with patch 3. Patch 1 is trivial and fails to meet the
> > bar of a meaningful change, so we squash that. We end up with this
> > patch. If there's a later revert and a dependence of the 2 liner, just
> > don't revert that part of the change. We've never had such a revert so
> > it is hard to see why we need to generate so much churn because of it.
>
> As I said the patch 1 should be the c&p and no need to introduce
> is_directory_at() before that.  Why not doing
>
>  patch1: move the code
>  patch2: add and use is_directory_at() + openat()
>
> ?

Because placing all the code in 1 file expands GCC's analysis and the
build fails. In the commit message I describe this:
"The arrays are warned about potential buffer overflows by GCC now
that all the code exists in a single C file."
A standard unsound workaround to this is to change "sizeof(...)" to
"sizeof(...) - 1", as it is ugly I added is_directory_at to not suffer
the problem as the arrays are gone.

Thanks,
Ian
