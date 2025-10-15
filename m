Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DF7322A34
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Oct 2025 11:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760528841; cv=none; b=j2EGg7yXeMTipqQrW2aH0FzxwNdsjeKzhBPz+zxpW4MIlpmDFqQxJIqq/vXvqpd41p50I9uJsKQ/nH32z2eqUq5JeC8lFqUADVYaHNcn/njsjWNluITiwOrlj9JVLv7/F+sZTAWjzyEEOQGOQwUY4NZ2b/hvD6CZ4xRtHWyebkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760528841; c=relaxed/simple;
	bh=K8Ef9394U0xGAO1FYDn+Orh4zfOf8Xw0fy6jgoX6rKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pIc8kBhseawq3oYl//oALZprM7zKKJwf3JEzW2uiWDtAJNR2E80/mzqosEcd0igYCH4QU8tN6dHZAAUz0vAzI4dDlIUzqVun51HNx/UmwZJaqZ1Sp5I5owZ7XyxN9FpxN3eu17GOANjSWmXMlnuI2IwuFuDrjlZWupkfP/4QaQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUWjeze+; arc=none smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUWjeze+"
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-36453927ffaso59250381fa.2
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Oct 2025 04:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760528838; x=1761133638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kjD7nlR2YEzkS0lnkW+YD90/WFAnc1y24O/rAXSwJ4=;
        b=cUWjeze+0jn+DyGKQDUKmZdDgaBIws4sKGEIUXggyi/qc3KSaJoLEBP99bUv8PrDRR
         7MyVQNPi+gJgBdaoj2KA2oPPW1ch+MZvnlx9y7brtgTdAWKhsW0FgNaB6KH37seNTae7
         AFh98HJJhw1ggckArc0L+Q1jJ45leg3eLCUAILo9kEYOCslYJoo0T0y1/abdUZFA6PpQ
         6hwe2snxGdmPfxwPpJD6zQCJDdQTtO7X201LIw5tHvSX5VI3HChhGRZZY3kHstgll7hp
         +K+viBLvmK6oEg7PJGBAdA/Gd2EVA/OzHJGLhCt4i5R5CDdaoR6nTDdz/z31Gc38R5wf
         P0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760528838; x=1761133638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kjD7nlR2YEzkS0lnkW+YD90/WFAnc1y24O/rAXSwJ4=;
        b=LkLZvEPmSLssPoD8Bxp98mBAA66J6d+Q2koxfilc2CY5PY9nLapH2kdVFeI9cVWp3V
         TkJhfHGj/UZHH1XO7qON2zZrjljj5y/dJ9yW0UGRsKRMTBYTT3afy1o6a3AbFJqQZ4v0
         FmIfMcMyzpZT2PZUURA2pNfGsR9ylAdAl73S+PP4yeTpHbHcvUNdubDJyzlz+liRQ3mj
         7KOngI7LI2GkqJdJcqH/0NmeI07OsZrTP96LXlFySbdCu1ScMV1HJBuEz8MVYtPwHj3f
         XcrCsfySQKXB2kU3vEsNInSMe4qXfmWX6fWtOcn2lx1IPsdb+LpZqOfKZ348yZeBdltK
         6f8w==
X-Forwarded-Encrypted: i=1; AJvYcCXjaJ75b0MK7exw5CVTHmyGizJHWwRj2nCVuliPzGTqjhvoiKEMpSKKVVElxG05G9s0H7FYKEub4RuTDcjzXtjJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxBJIYp9vevYJILQgFB61F0odEjdio5EEY8kJUhVNZMnaXM1kZA
	qOUdxUfYpua/U8PBC0Q6zMsEvhxspfQ9C4fInt4/EAaujMadroATUoyro+4GsjfZWboMQq+PkkD
	Hql9y99g2+wiuR5hZP2iiC5UCu2IuAKQ=
X-Gm-Gg: ASbGncthSzLDUz05QcxyB3llKABoLLd9sD4Gws25X2+T4qgN473WFtmxQTT6DPFJBdY
	VfGKs6THpbwvfpB/wkC2I6qkSKi8UaXCUdSULcL9TLO1Lu2fEO0yoMWpU5JYTDTlyeq60uesyyV
	ndUkJ3eDyb0Lwmt8ud3tPhoyOj7DwzYNFDANS9sA+RWIq3Kum2s39MFUVv+ZKFjFZY/jpRXghgN
	DQ6ib0ALFDSw263cvRBk8KA4areRHw6NUudTg==
X-Google-Smtp-Source: AGHT+IHB7Q6zZZMGHVTDzzBJ7VX3uS6ZTaxkupI5fWKfSKIZBSRc8BqdSXDaczSqzz1xMTR2k41s6xuNNoZwhsfFZGo=
X-Received: by 2002:a05:651c:1543:b0:36d:54b3:9f71 with SMTP id
 38308e7fff4ca-37609cea713mr76878821fa.1.1760528837594; Wed, 15 Oct 2025
 04:47:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013080609.2070555-1-hupu.gm@gmail.com> <CADHxFxRMUhn=VdG5uzrosTUpwAMHi+zO7NTYVikWzFdnKrUJ4w@mail.gmail.com>
 <CAP-5=fXykcQ7n3rw6RX3S+dLoLUC9BZKh=BP8yx8ak+f623aEg@mail.gmail.com>
 <20251013161429.GE77665@e132581.arm.com> <CADHxFxQg2ZKwLEOa6wic_KP49PRBp=hF=cY16aVmR0O0pa8ZkA@mail.gmail.com>
 <20251015093037.GA109737@e132581.arm.com>
In-Reply-To: <20251015093037.GA109737@e132581.arm.com>
From: hupu <hupu.gm@gmail.com>
Date: Wed, 15 Oct 2025 19:47:04 +0800
X-Gm-Features: AS18NWAkVWEMyCdv0-Y1CwBUX6NfnUpUNHXCsHsXsJw9gljovloSmphazhBJKPc
Message-ID: <CADHxFxQyOBurB0LB9qRdc3DEDNU+vatqOybNdcizPnWZngiPZg@mail.gmail.com>
Subject: Re: [RFC] perf build: Allow passing extra Clang flags via EXTRA_CLANG_FLAGS
To: Leo Yan <leo.yan@arm.com>
Cc: Ian Rogers <irogers@google.com>, namhyung@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leo,
Thank you for your reply.

On Wed, Oct 15, 2025 at 5:30=E2=80=AFPM Leo Yan <leo.yan@arm.com> wrote:
>
> Have you installed the GCC cross packages ?
>
>  $ sudo apt-get install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
>  $ sudo apt-get install libc6-dev-aarch64-cross linux-libc-dev-aarch64-cr=
oss
>  $ sudo apt-get install libc6-dev-arm64-cross linux-libc-dev-arm64-cross
>
> My understanding is arm64 cross compilation tries to find headers in the
> path /usr/aarch64-linux-gnu/include/ (I confirmed this on Ubuntu/Debian
> distros).  After install GCC cross packages, the headers should appear
> in the folder.
>

I hadn=E2=80=99t installed the packages you mentioned earlier, but after
running the installation commands you provided, I was indeed able to
successfully build perf.

In fact, I=E2=80=99m currently working on creating an SDK package, which
includes a cross-toolchain that I built myself using crosstool-NG. My
initial idea was to install certain third-party libraries (such as the
packages you mentioned) into the cross-toolchain=E2=80=99s sysroot director=
y.
With this approach, even when developing on different host machines,
we could simply specify the header search path (pointing to the
cross-toolchain=E2=80=99s sysroot directory) during compilation, and the bu=
ild
should succeed without requiring any additional package installation
on the system.

Based on this, I think allowing users to extend some options via
EXTRA_CLANG_FLAGS could be a flexible way to handle such cases.
However, this is just my personal thought and might not be entirely
correct, so I=E2=80=99d like to hear your advice.


Thanks=EF=BC=8C
hupu
