Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD1D1E2843
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Nov 2024 21:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730497321; cv=none; b=tsDuwES4H8QbwuGi66+nKkvwJwogF+dTHH3d3vRRg3F2rBUEK/N3S6h5vXvjFWBaUz+xEt/g2Rt2rjSJEsrDENx3D6KG4yQoK5T8h57NQPUAJ8FR+TMzuQvI0fcoIZWuKLnBZwOsMjyRDvB4il7dbIuWMN5qEHu6dweeyAzklPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730497321; c=relaxed/simple;
	bh=DbfqY7IFcAPB09OyKpR93DM2ZjDMYjW04ydu1Tn6UTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYrSMLXbRv/R/8onJddtuTpXdmTcnT5rmGIA4LNx1oY9Sc4zAUe0Dnu+yJPqJs1DEzKUAvniHSvFHz39y5+iiv9cBnajqMM3Xb4Hlz/tkM9BXxtGvzRqGppAhWxBk0XL5zTrZVrjKD6auI2SycGnvoEKnqod9Y9ZuLbHfI5yYco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com; spf=pass smtp.mailfrom=engflow.com; dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b=fgMaCcHT; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engflow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b="fgMaCcHT"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so3978989e87.2
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Nov 2024 14:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engflow.com; s=google; t=1730497318; x=1731102118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jo90b8Yd71LhW+/ErXRjU0g+lG1e6qGL15CJicn+PDI=;
        b=fgMaCcHTsMt7X51dL8HaT5rEY+mU0JMciTpvRAlgWAYq34eclsHs1mbj4uiRPDEKvJ
         pE1CDg242KhWOW77wVOw/dBA1dUGxEI7oEEkKUJOjA8Eoy9chQz2OylPq10Fk3tJiaSq
         OJq3OJrsTSsBaadj4snN0AtAj9eZkh5s+qyEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730497318; x=1731102118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jo90b8Yd71LhW+/ErXRjU0g+lG1e6qGL15CJicn+PDI=;
        b=J7Qer9pXv6wmJkrQAPtWNv11GmSneCenrgpalEyzj6pg77pY0yPwGOQiZ7Ooek6KYY
         P901cZplDt7s7AhdHgisQLkRfbdg4wtNPDqskB1XCv/w5SjHbf1PVWeYmFxxxcOGOpTb
         zGkfC9hx8fPDHZApV38rR3nPhoDIYUq33+nsr6umRUZ/qBj+P1lhHYvxGVDNFZvNarF1
         qFLyOZCNuXZdqmpXiKBw/put32VIEarvBTOqwrrO/0h5RD6y5ElsgSiU4ykHgVly4a3+
         hsBQvDSkk/EwJzTpTyjTPGZ6A3Pi/ugwC2aV+yKZmUtMeKcOgid75xODzvM8qoPKRLpm
         vePg==
X-Forwarded-Encrypted: i=1; AJvYcCVEPNu6ZYylkjUfeAx2YCT6/wrtKCtCFk93T1Qez4gYNk/Fpb/ftqY5aEVCQyjewg1UOONE8iNLeTVt6K1qOnn+@vger.kernel.org
X-Gm-Message-State: AOJu0YxibsFEd0s1cewFtthxqGsdcZVjvUFCyghyv3zr1ZoEy94zDteI
	oGNijLwqI57+1DXMJtYK4uPBpPtMObutTXhyUKUx1GGqYZij3PJPg+zOdwZzuibMjIWuIHJnG++
	FytF4YAsBUkcRnu/9yrABSph+uKcgYvI1UAcblw==
X-Google-Smtp-Source: AGHT+IGcJSS7owX3TBRF8ZsKYn+5S4Q3Hg1EpCxbdq1KPte+oQuDZLnbzKisdC+ggu1lDkdDgpVrbty8dyMekv9XJ2k=
X-Received: by 2002:a05:6512:3d10:b0:539:94f5:bf with SMTP id
 2adb3069b0e04-53d65e16d9dmr4558411e87.59.1730497317409; Fri, 01 Nov 2024
 14:41:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101005338.5846-1-benjamin@engflow.com> <20241101172714.84386-1-benjamin@engflow.com>
 <CAH0uvohNO517GAD7XH-VvUvU+dPdeZBKDw0Teij50sAPSe9sCQ@mail.gmail.com> <ZyVIgKcAuqZSYYB1@x1>
In-Reply-To: <ZyVIgKcAuqZSYYB1@x1>
From: Benjamin Peterson <benjamin@engflow.com>
Date: Fri, 1 Nov 2024 14:41:46 -0700
Message-ID: <CAEmfU+ufKWoJLvhksPzADMKkbinV37Tv1KODU6RdJfBM9Juy7w@mail.gmail.com>
Subject: Re: [PATCH v2] perf trace: avoid garbage when not printing a trace
 event's arguments
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 2:30=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Fri, Nov 01, 2024 at 02:00:46PM -0700, Howard Chu wrote:
> > Hello Benjamin,

Thanks for testing & reviewing.

> >
> > Before your patch:
> >
> > perf $ ./perf trace -e net:netif_rx_exit
> >      0.000 irq/79-brcmf_p/1694977 net:netif_rx_exit(6n<)
> >     28.153 irq/79-brcmf_p/1694977 net:netif_rx_exit(6n<)
> >     36.429 irq/79-brcmf_p/1694977 net:netif_rx_exit(6n<)
> >     36.461 irq/79-brcmf_p/1694977 net:netif_rx_exit(6n<)
> >
> > After:
> >
> > perf $ ./perf trace -e net:netif_rx_exit
> >      0.000 irq/79-brcmf_p/1694977 net:netif_rx_exit()
> >      7.352 irq/79-brcmf_p/1694977 net:netif_rx_exit()
> >     30.232 irq/79-brcmf_p/1694977 net:netif_rx_exit()
> >     37.529 irq/79-brcmf_p/1694977 net:netif_rx_exit()
> >
> > It works beautifully, but I'm thinking can we simplify it by just doing=
:
> >
> > +       char bf[2048] =3D { 0 };
> >         size_t size =3D sizeof(bf);
> >

I believe this is slightly suboptimal because it obliges the compiler
to zero out 2kib of the stack every time the function is called.

> >
> > Tested-by: Howard Chu <howardchu95@gmail.com>
>
> I haven't tested it yet, just in my mind :-)
>
> The patch looks ok and seems to fix a real problem, my only concern, a
> pet peeve, was that it, in addition to fixing a real problem, did an
> unrelated change, the "Remove the return value...", that part looks like
> a distraction, something that shouldn't be there.

In my mind, it was related because both the bug and the odd return
value arise from incorrect counting of the number of written bytes.
Obviously, the fix is what I care about, so feel free to strip out the
return value change on import, or I can resend.
