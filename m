Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FC61F957;
	Thu, 22 Aug 2024 20:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724357496; cv=none; b=ST2FyOkfIXKqUVG3bXgciX6XyLvmKOBczpkM0fLOUvleeoPHLCyWDXOLqj7f8ItrqepoEYPY7VFhyvIgAK49goe7bHJA7X0+eyTj9pXlPAmx6O/08nF1fJGeiOPREmVEVjgEvt1H9XsZ0UgIY4Vovptpj0zalrRlaeuFSArKYnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724357496; c=relaxed/simple;
	bh=x3wXMcSjHjfNELF3zxCuDFp8wKWLyYb+BkEuhtZTcio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lhb5Pm9ls0kOjKM+Tc+OJe24NvX8cC8JemM7kX2Vm3ZpWRAqIARFhiqCw0Ln30XdaTIoNCQi4tUYkX5SwZ3ofkGf15tFOE83/CLONs3+dumqjFKp3BUEaF58/pEIHGEokHqPBuca7o7EIIAHOzzDF9AbeBAIsNKuJI/GUyeNAmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d60f48a2ccso994692a91.3;
        Thu, 22 Aug 2024 13:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724357494; x=1724962294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06JTAuxEC5nLVViX4Co1aPJmJYMF6kbZxHJmX2rPoME=;
        b=gun3WOi9PuihQQXZQm6FjWSDkFd3mZNRd7OxGlmlouG3GoTcQF+YEpRTk9QjwhT/su
         prdDbHaanh/tIwrDIpK/TpNIUuS6hWqr3aqKjVf/aLMB48bxRw7BupFJ88HL3N/Vhmas
         8SyL1Bo5SILKABV1iPFHq/yCmO/X9rIiOgOjwgTTwfuR5O8Drd9NNk8d4TMRJctBeUyp
         h5pOfHS0dwGIalvdPlkwilrhDUuHHi17G++2Lrg9Uj0X6LoYWN55qH/rQYR00XiaYcN5
         drJEfEKsrhOlY5u+Il8mRsHLV1pgRlg24Hkxwcdo/qFSbTEQzJFIO3XNR3wGrgJPLQGK
         JHoA==
X-Forwarded-Encrypted: i=1; AJvYcCW4lLGCL4BGWCfGDtr+pvCO1NqLrQlIkDQKCLhIUrIlbZUWzOwqBcHcSghBiX/SIMMLDBuHq8UZQFO8eIOKGvD1CA==@vger.kernel.org, AJvYcCX07t3ZsfBeuQx1vbeMFDGpTjXRaR1AqeAH/ldDwQUM43szFjVFGZQH5gVzqG7ghrVkxZechY0xOhhggZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/6i69V/JBxSfibtozNL4EGVwj/o1B66R8MCq64Mn63ccaIXOK
	H+5DPFPKxbGaDRDdwVtZI+4qRK/t51MFcM7/MfPI/pwgeTv43CUS704UDMYzjTQmg51w6eaLI7g
	mn/6bJFbiqT9lGfZ6selslbEInts6yF7Y
X-Google-Smtp-Source: AGHT+IESOtRJRywMB8gvUEXgV1uQRnr37iUBGb+9p0zPpFr3/swh71gpwTplE5rab/YoDhAW5sopNAj/rydJCab/mSE=
X-Received: by 2002:a17:90b:e8c:b0:2c9:9f2a:2b20 with SMTP id
 98e67ed59e1d1-2d616b28cb3mr3801138a91.22.1724357494188; Thu, 22 Aug 2024
 13:11:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5pUMUUhG-UVKQ@mail.gmail.com>
 <ZsdKhLaPy-uzKsuH@x1> <ZsdUxxBrpbuYxtXN@x1> <CA+icZUVtHn8X1Tb_Y__c-WswsO0K8U9uy3r2MzKXwTA5THtL7w@mail.gmail.com>
 <ZsdxinrZP1kHINWT@x1> <ZsdzLmIFWRqsXeXD@x1> <CA+icZUURwYd8nJSdMU7KW6nFjubi-VD2f-a5+zQNQGUxK7+2aw@mail.gmail.com>
 <Zsd39zG9BuGpZ8aA@x1> <CA+icZUXGV9dMGcRwJiP7WLcYUaY5CRCcDw1HLFr+9Sn7CrRGDw@mail.gmail.com>
 <CAM9d7cgSR4OroaX0FuBvC_bPPMeEr7ThXJwqgMfAnj-Lfk8wNw@mail.gmail.com> <ZseBZ1DIi4Y5zC2W@x1>
In-Reply-To: <ZseBZ1DIi4Y5zC2W@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 22 Aug 2024 13:11:22 -0700
Message-ID: <CAM9d7cib0JFJPM4KdFDPkw_2K0Nu79QGHBsVZ7XyR-Yz1ZBHdg@mail.gmail.com>
Subject: Re: [Linux-6.11-rc4] perf BROKEN with LLVM/Clang 19.1.0-rc3
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: sedat.dilek@gmail.com, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 11:20=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Aug 22, 2024 at 11:17:21AM -0700, Namhyung Kim wrote:
> > > On Thu, Aug 22, 2024 at 7:40=E2=80=AFPM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > > From 155212c965b5b23a90b8558449dbfd1c60dad934 Mon Sep 17 00:00:00 2=
001
> > > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > Date: Thu, 22 Aug 2024 14:13:49 -0300
> > > > Subject: [PATCH 1/1] perf python: Disable -Wno-cast-function-type-m=
ismatch if
> > > >  present on clang
> > > >
> > > > The -Wcast-function-type-mismatch option was introduced in clang 19=
 and
> > > > its enabled by default, since we use -Werror, and python bindings d=
o
> > > > casts that are valid but trips this warning, disable it if present.
> > > >
> > > > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > > Cc: Ian Rogers <irogers@google.com>
> > > > Cc: Ingo Molnar <mingo@redhat.com>
> > > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > > Cc: Nathan Chancellor <nathan@kernel.org>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Link: https://lore.kernel.org/lkml/CA+icZUVtHn8X1Tb_Y__c-WswsO0K8U9=
uy3r2MzKXwTA5THtL7w@mail.gmail.com
> > > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > Can we also add 'Fixes' tag to make this picked by stable kernels?
>
> Fixes what? This isn't a regression, clang 19 isn't available for Fedora
> 40, the most recent.

No, I'm not saying it's a bug.  But we may want to build the old
source code using new clang.

Thanks,
Namhyung
