Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C77E3C1977
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 02:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896855; cv=pass; b=tvY2OUu7RtcyplqsYY0GBiDALFmmijXy8ss4W09IWUbH/9SotN76mjd1Z0ZTl9GRvQhg1NM+RY/waX8shCZ2LPLy/guntyTrfnVumXw73Lg5UvUff7Pg2cInpT+C3wg7tHNAunKuIs/3ryUbILE0cikjruRkwzQeS/OiSm05dxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896855; c=relaxed/simple;
	bh=e2CaDp2rjS/geQ4fdg6p1s3ePeoEZLt0A86LHj/pTVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oPYYQIH13xdN9Yc4rdhA3evfjOVLZDVnlnxFzCsVEjF5Z/bFprF0HZEYRR7oTiogcj88xbl37XfidhzumPYrGTXQECucHyrzBKyX6y+LCJJ0qM0EBYAupUm2SruO8tG1t8C7a4GXTZHeCkwMTT6J6nWbnqReTA7datmFK9Txnnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n05ErwQR; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n05ErwQR"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c01c79467so165361cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Aug 2026 19:27:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785896853; cv=none;
        d=google.com; s=arc-20260327;
        b=g1VsrqT+YqNnueOu5IgTSfRvQzCi6zX0RbpPNBuDQoNr3Dge5ktol+ZGbbYA/VzGLc
         Xmfu/o9iw0wwlOhycv5roBJnUYqLE3dWiTdxgB8tVjkA/Z0ssG+p2eZ+kibintUXaltQ
         eU6ymdQpovr1yThFycNRcqtQUHV0dWY25cdEE0Tqoa8Gvor2GK7NYvM6QmZFS0tPk1y/
         kdbDFgubcCz1tetgF3A2qnci7oCjrU7D4iLe2AWMoHwvt1h3sZRNvgYHBr7UY3FFCg+0
         l/MpJoh9aMEIGPOZ9iBrZbT1gQR2GJY35euX9jgPk1ihLua72l9O7WAiCijsFY+WYZZj
         RidA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e2CaDp2rjS/geQ4fdg6p1s3ePeoEZLt0A86LHj/pTVM=;
        fh=vcqaKlQNY3mz67GcFerS6XKM6m5vchy2vSVvnLiCtZU=;
        b=O4TSSrpVGyMyshBdvslR5ubOSkeruMW8GwUe8eJaseYUpdA8LoqACx0hiWPZKotHae
         PcbTX/knG9Wjtvh+8TaSOHgaee5DL5pf0jtk8ONAwMsl61M57Qbf0f0z4U2VAwXOj7BR
         XDEyxM2RgC+xjD2U4nXsCpKx0m8o7/c9hNDwhNuCKeo1g8fjlpNkwOVkMIhqx/eLlJpm
         SCPvbz3g2sskKo0paItwv6EzFwhG1c6ytIKU1UN5TMKBqX14jcBha904qyKd33GzZxBx
         BLK3i84PJ393dV/tevK7ry7NUKLe8VvizkcCozgJYAyG5jEOYT8nVlu2CW39DR3XOGec
         WTjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785896853; x=1786501653; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e2CaDp2rjS/geQ4fdg6p1s3ePeoEZLt0A86LHj/pTVM=;
        b=n05ErwQRJB4EY16LupsuZSLHk2sJ2ASGdI1y0RTEqkyrVIb2dbzKsBg8zVxrYO1RUB
         jlDdtZxwqVyYTokHnt1zkKN8/LQwmO5LU8VmlewfPq5LgXU1mfcgJyVqeTOVhjojfuke
         sNUsEIyPIhEgOUKm7OUtXGDChOBMU/KgdbPjCM7nGqHcQTO7klsoSRvY5sNsHxcMXnGF
         H79N3H2LHjOgYpGnADHfvRsjW4jDxf967q/8mgAXm2v1qsJC2P2szA753mhgffyEsvDr
         YLaKdE3SYTQGKg04mihn0JrJc8jkVdqlvfJTMKoE5FYKUfJ+s8PJWFYPQFrgnMf/AOH8
         JUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785896853; x=1786501653;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e2CaDp2rjS/geQ4fdg6p1s3ePeoEZLt0A86LHj/pTVM=;
        b=U4OpUi65Zg9PyVmgOyaU3wCOGbbv99fKn8X6t3Nq3RmHDuvO6qX6JeoS6HsBpN9X/I
         9/MKBKvYtdhbhaByusnnPfz+DqxkSOSM0rodxwhASG0HdbK5HiTslM5cPcjnUGDY9Fqs
         5JxSFDooj/VAgsOIjED/k0lFtXtM7KtNvotiCtXxw0pyMV2ltxnhYz7OMJVKPkeKT7xU
         en8C7n61F8AmmEoxZjlJBN5HOGNtrdK9HpiwOQLCfbdYKsQ1I9vd00Tg9a8RUgCmlNBJ
         pgs+1NK7w1kERDM/yNwO5MX4YOVSIh2mqfyHPrz0puwwQSQOE+42LqWBW+0KBMF+tOqg
         ed4g==
X-Forwarded-Encrypted: i=1; AHgh+Rorj32N6qqny5n6wbu3RezIbo71FUi8xteh9UoAwriMAv26BmIaHk78F2GYnY7IiEG9biH4AsZ6RD+mtAFJp3WI@vger.kernel.org
X-Gm-Message-State: AOJu0YxD2zF1LGN8wg2WFgp/RzIVRQX5WQcbtRLAO6/wWmAQ0EMJxYAk
	30Sd95244XByD0Py8ehZa8tBqDnanJ5OpqjEeetj/SOdaY2cJIO1pop489ZxwYa+HJ42rOxOtum
	a1JeJW0quuZS3KQttvFp/bUaPj6hYKUAEW2k+WJ0/WtiflF3LF1tB9Rdj
X-Gm-Gg: AR+sD125TVqN8av3V1Y9IZE9lCmiRfVU53y0xWuytszL12I7bAO3Ip9NZ8ox8kb+f26
	RWYsmcuA6vGo2x/DEfYZgL3SEmLQJ00tw4A7bkELdkPNpXmbcpjIJITXwkjXvJNcHvvieSvK+Gu
	s6gn5qAGv3hl2iVZdJJjtJRziucoYGzjfV3egTQLoH/cNQ30I7rWdJjrEOxGfu8ujckFwOI34Ev
	FSb0lXMLfr/CCvgmCeZ8ximyyENpWvn3zgAv4/jr/3oXIUnvMdsYBdALiwDx7VZMRN9XHTNbfU/
	M+wGHf1bl9AW17G1xqKAFzcur3aOJmQj4dD7yVux9E7yuQ==
X-Received: by 2002:a05:622a:8309:b0:51c:935d:8d74 with SMTP id
 d75a77b69052e-52ce97216aemr6211561cf.9.1785896852545; Tue, 04 Aug 2026
 19:27:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802180801.65183-1-tshah@linux.ibm.com> <CAP-5=fXGaMPzt8BUZKQB4QeuxrfiERAF8Kdut+uBPnXWvL82-g@mail.gmail.com>
In-Reply-To: <CAP-5=fXGaMPzt8BUZKQB4QeuxrfiERAF8Kdut+uBPnXWvL82-g@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 4 Aug 2026 19:27:19 -0700
X-Gm-Features: AUfX_myTD5ZxPyYhY7fyqtz7oDkG2IG_NGA1QsGB0ouLOxTOOKws0HluA10mb_o
Message-ID: <CAP-5=fV0Y=__y11kmcLBo+1yAMraUKf6pUpdNUfav4NJEocwGA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] Add perf.data tracepoint events to trace.dat conversion
To: Tanushree Shah <tshah@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com, 
	maddy@linux.ibm.com, namhyung@kernel.org, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, atrajeev@linux.ibm.com, hbathini@linux.ibm.com, 
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 7:07=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
> On Sun, Aug 2, 2026 at 11:08=E2=80=AFAM Tanushree Shah <tshah@linux.ibm.c=
om> wrote:
...
> > v1: https://lore.kernel.org/linux-perf-users/20260608125951.90425-2-tsh=
ah@linux.ibm.com/
>
> Thanks again Tanushree for pursuing this. I see on sashiko.dev that
> sashiko couldn't review the v2 patches because they failed to apply:
> https://sashiko.dev/#/log/baseline/53604/2
> The SHA of perf-tools-next that sashiko.dev was trying was
> d04ef71492fad7230d474efe33d05f4c0563d409, which corresponds to "perf
> machine: Check snprintf truncation for guest kallsyms path," added 4
> days ago:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/commit/?h=3Dperf-tools-next&id=3Dd04ef71492fad7230d474efe33d05f4c0563d4=
09
> Could you rebase the patches so that we can benefit from the Sashiko revi=
ew?

Fwiw, I went through the individual patches in case I could give some
useful early feedback. Everything looks great, and thanks for adding
the test!

Thanks,
Ian
