Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C76119A282
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Jun 2024 17:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719510547; cv=none; b=X6BQt2vz+8myQ0+bJ31IRrb547uwPNRLJmojct1Y1fqjnnrdkAoStlEOYuxTuk5gtOU63VLBqGnPCCAuAEGoJp+qZswCNUb15BdJPr3s0oWRe9fFArmcCdFc3SZ27a7tlNIZk/kFODOT4kLoTI8riJbJKRnpEsuk7NM0Cf3E6ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719510547; c=relaxed/simple;
	bh=VFa0V/qbZRLCCTiIFBj46TzZOwmCP1qFPmOixWO+/Z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=boNk9ycFNpIqO+XAL79W3SReNeLfdiMq2ebfp3VgVJ9nDQi1DGsoqVJXb81zxHSj4K4QCvQu7SuxoUM7/BY9Zcu3hLAMXP0jPo1F7gCBLCfk+hiLPxC0k4JwUvdGem0F9qqtE/lLha1ygIIGa1QoY8zA4y6dq+jsK/yW9vRJeWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=av3kNnM0; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="av3kNnM0"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fa3086cf25so8045ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Jun 2024 10:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719510546; x=1720115346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFa0V/qbZRLCCTiIFBj46TzZOwmCP1qFPmOixWO+/Z8=;
        b=av3kNnM0DD305txJC8K09rRBvKu628KQVyXb9hqOTpxWpENP93sKGdYdSp67gycdgk
         jOXod71RmFcyVWaAhEGVX7ArXkuxcz09D8X9OPRRhYYt4F2BQGl7Noraesbeu6kb8LUQ
         dm91fW5fVQ+4bUHEwDBrlju/dx7d23fTNXw0RW2MJnKcUiEmY2EmhBwk6SLGOO+NagEB
         Rre59nORrv7JVjMgXKy/cyc1/nWsjFx0BJ4GUjZmAQkra+5gi+XBV/8qQHsGJgGuPnp3
         oalt+LL2PbxaUHxMtWNpR/uvQs6t1Q06/HfWr3pMNnSs8iYVERnPbsMzmx1jJ14QMTwE
         MY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719510546; x=1720115346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFa0V/qbZRLCCTiIFBj46TzZOwmCP1qFPmOixWO+/Z8=;
        b=DW3L6Av1iFKbi2N0cVfPgTCxHnfeqEZFXgvtpSk+wnULZizylbtOJTFS/iaRYm08zc
         KYf0ukIMwTJgb2cKvyMyZdJsPHDGWIjSF/0CSR4WadE4o0udsz1fKjl4J5RFhxQXItmU
         /mKdGLLoia91F5BgpF74AuycnbFD8LjiLBsANgRamX7ejIsislz8kn8VZWv9ETVGqkII
         NLOf9uF+GeOb0q/z9gARmPhEPzbdSgt9PqPUoub38jz49yJUIcIUWEGO7lzKW4DAzlUK
         ccK+Y4xXgcFBn0O6J+us/ZzAvC3X0WPA5rG2NPxXragxSr2lim3INdZsaY+h67q75yc0
         qkxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVozL11SB5k3qhqPqDYnxnIF4N8PA8N4hYipfYWzbPjQ8J/ra+zil0CWniTh7c63dTqPss5AaX2A6LjGGm/kSDBik2EZHKTtFuYgaFQgI13Mg==
X-Gm-Message-State: AOJu0YznlBtm9FXN2GYaXwsje9zEslEQIVF2Z0geq0DLtXnbHvuJAEG7
	y0GbJLnvfcoWIHPJNwwc92bkc998vcmnSmGZTjyjxFqcDjqjgIWiK8xrwkTvEc6GmjFMiMY98LI
	6aVRHBYl0juJUpd8Prd9Pbpc+6KQazbuDP5JB
X-Google-Smtp-Source: AGHT+IGX4Q0hi8TE7EjVRSRtykeihoxSERMGYmaOt0hiXq66eSYNTOIYRg0tQFzQTw8EyGZ5dVyRmEybysF0W95QzvU=
X-Received: by 2002:a17:902:bf48:b0:1f6:f96c:4a44 with SMTP id
 d9443c01a7336-1fac1817467mr91075ad.22.1719510545450; Thu, 27 Jun 2024
 10:49:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fXOQxiKJBfzKs3Gz4DuMoxxoTWf-Hw4dKDbhRguSup9Qw@mail.gmail.com>
 <CAP-5=fU3D9YZ+O-Mm0CqrpY4Ubhe6qW_nn8NkjuQ_jfVu2-scw@mail.gmail.com>
 <CAP-5=fVF9LVxO5kpyutmbOTC31ywQCO-qgNk3qnqv5rVOf-JDA@mail.gmail.com>
 <CAH0uvoiCX=asogf6e4D8mZ2Yw+8pj3HMTyvYTtQjFTtgKKP6GQ@mail.gmail.com> <ZnRP4hJLcRpZzs4x@x1>
In-Reply-To: <ZnRP4hJLcRpZzs4x@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 27 Jun 2024 10:48:54 -0700
Message-ID: <CAP-5=fVtutBamCT9VJNJv+nXB1VMBZ3V9ed-mAMtWNaVbygvHA@mail.gmail.com>
Subject: Re: Linux Perf Tool Office Hours
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

5th week of Google Summer-of-Code. Office hours tomorrow at the normal time=
:

Linux perf tool office hours
Friday, June 28 =C2=B7 8:00 =E2=80=93 9:00am
Time zone: America/Los_Angeles
Google Meet joining info
Video call link: https://meet.google.com/tif-efem-uiq
Or dial: =E2=80=AA(US) +1 425-217-5482=E2=80=AC PIN: =E2=80=AA791 261 968=
=E2=80=AC#
More phone numbers: https://tel.meet/tif-efem-uiq?pin=3D2651187837256

Thanks,
Ian
