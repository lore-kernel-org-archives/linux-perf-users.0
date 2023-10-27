Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5CF374DA
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Oct 2023 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FB9AC;
	Fri, 27 Oct 2023 08:23:24 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9be3b66f254so324972166b.3;
        Fri, 27 Oct 2023 08:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698420200; x=1699025000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SprNk3n3L2ny4VGwxVzkM2OBl4XIFMaj7eafsT3fj4Y=;
        b=dFO4gX9N+af9lpxu7QUd934uUSFXzl0hUORE8Cj37946I5Xz6B8ELsesi+zEqKCJ9N
         GF93WOULk5hipAd/ehhH6+YiUaTvvWjmx5bj7OND46mK58TTpgza+Il00w+l2T5OVCKb
         d4sl97ukhQjYrXKAgb8w9xKd24mnN7A/fV8Htqsy/jnu3ZCMgCCsy881WP8i9HvbAQPx
         DeDFkMcI57yf1DQE/gyrEg5h6Y6STesyKh5xUu6zbXlUQPcv4id9tdKFiIemgN4bLut3
         xSMxvb04aCCNs0E14VXHe+Z8nwS5UWUmNhv4iUeSZ7j29zXMU3VkMSpx7tf25yJHuyBR
         1H5w==
X-Gm-Message-State: AOJu0YwqNGrOIvJ713EES3uUmLPcnJbytDbaj/FmbXTL60HfXJ5pXSwY
	uNyrVsfj+gYBw+1BOhzWIJGNhtDbV56UB4Yb
X-Google-Smtp-Source: AGHT+IFrrmSvUG4X7Nc5QOfMt4YewQuHq5GuwRCMFYtHZD4bGjEIprgK+p99vG9mu0ECDopPrbsN3g==
X-Received: by 2002:a17:907:c26:b0:9ad:a4bd:dc67 with SMTP id ga38-20020a1709070c2600b009ada4bddc67mr2802789ejc.50.1698420199898;
        Fri, 27 Oct 2023 08:23:19 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id rp28-20020a170906d97c00b0099ce188be7fsm1361382ejb.3.2023.10.27.08.23.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 08:23:19 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-53e08e439c7so3767062a12.0;
        Fri, 27 Oct 2023 08:23:19 -0700 (PDT)
X-Received: by 2002:a50:9b5d:0:b0:53d:f4a2:5140 with SMTP id
 a29-20020a509b5d000000b0053df4a25140mr2645120edj.33.1698420199489; Fri, 27
 Oct 2023 08:23:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO8sHcn3+_qrnvp0580aK7jN0Wion5F7KYeBAa4MnCY4mqABPA@mail.gmail.com>
 <20231026145659.7063-A-hca@linux.ibm.com> <CAO8sHckF_D+SjvGySsGHOpOcdy6y7pwQEF9SfV3sw4Ye4_sCKA@mail.gmail.com>
 <20231027100925.9071-B-hca@linux.ibm.com>
In-Reply-To: <20231027100925.9071-B-hca@linux.ibm.com>
From: Neal Gompa <ngompa@fedoraproject.org>
Date: Fri, 27 Oct 2023 11:22:42 -0400
X-Gmail-Original-Message-ID: <CAEg-Je9+UnVsC9e_yDQmXTLNfZy+b42Smj3xobhTE5DiQjk_hA@mail.gmail.com>
Message-ID: <CAEg-Je9+UnVsC9e_yDQmXTLNfZy+b42Smj3xobhTE5DiQjk_hA@mail.gmail.com>
Subject: Re: s390x stack unwinding with perf?
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andreas Krebbel <krebbel@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Davide Cavalca <dcavalca@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 6:10=E2=80=AFAM Heiko Carstens <hca@linux.ibm.com> =
wrote:
>
> On Fri, Oct 27, 2023 at 10:00:53AM +0200, Daan De Meyer wrote:
> >
> > If the kernel gets support for s390x user space unwinding using the bac=
kchain,
> > we'll propose to enable -mbackchain in the default compilation flags fo=
r Fedora
> > so that s390x on Fedora will have the same profiling experience as x86-=
64, arm64
> > and ppc64. For now we'll keep the status quo since compiling with the b=
ackchain
> > doesn't provide any benefit until the kernel unwinder can unwind user
> > space stacks
> > using it.
> >
> > Thanks for clarifying the current state of user space stack unwinding o=
n s390x!
>
> We will implement the missing pieces and let you know when things are
> supposed to work.

Do you think we could have an initial patch set for implementing the
missing pieces in time for the Linux 6.8 merge window? Then we can
look at enabling this for s390x as a Fedora Linux 40 Change.




--
Neal Gompa (FAS: ngompa)
