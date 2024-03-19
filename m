Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC97124B33
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Mar 2024 15:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710862147; cv=none; b=NgMOtGf+2FeFtOFi9flipZiM7DtItYxP/Nsrw3seeG1PydgGeXGZaNpQoVVGLIeNa8hQzCHu9xvzElSLsZEvD89b3QIdOl2Cxdum7dNpyNP6PG9fovRxecTg924dp//HqtZ0IBzWvYBNjXRC6HtRy1HKzK5iCvZaakTYhHnUSqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710862147; c=relaxed/simple;
	bh=G98xpnV55uE4xGNXkH0WxYHPJ4Y1Hav+deNHJfCByBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=MbJ+Ge/+7fSxfKfeljX2BoMJPyvd+oY+iSttVxcmu/+WL2d27cjfnM7u89IPGB62Dd6NzYRJCvTXA2CSoN4DZKcS4V80Bhdv5bRWkw3+m7U+z99hdoSkBPm77M6rh6Pba7+D5hu/oEFxCnCEVnOF0gM/ce2MU3bRV8SJfinXR8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q1a92suD; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q1a92suD"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1deddb82b43so185135ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Mar 2024 08:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710862145; x=1711466945; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G98xpnV55uE4xGNXkH0WxYHPJ4Y1Hav+deNHJfCByBg=;
        b=Q1a92suD8yKUmT+urq9CgHSQXfYMiBCu2XpfGR3w7nYHS9mIjZDgs7uW/6mRrwODUt
         vX2gkQf3AtC+yAEOMd6Yyvu4P3/SRZI14DOEk0fjCcCd3RQ45yN2tH9jIm8TMHo2JQcM
         00KaiWg1L/NQHEF5c5sjRUTm3Zz6AokwpyBdHbL6iiHTmRZ4Zxom9ffs165epy5XKmb+
         45v2jJK9ObKDjslhk7zjEq7iwmA+lx+0vZzjYS0Muks8FtQQL/qNhg8+MxDwFHjtVJrU
         mOnrS+oPtIT7qxYaNBnvm2fFjwiwOi2X3qtPG4ZW6RbVoeTxJ+saDx4EvM98WLJbZcq8
         wc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710862145; x=1711466945;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G98xpnV55uE4xGNXkH0WxYHPJ4Y1Hav+deNHJfCByBg=;
        b=lsg/3deQZD3T7eoLnm2O9J085g77T64gmC0wlfzsotIk0Ps/8EDG99W8NE3tyb5zsM
         KRHLBxVoxBKsgAJkeNAu5m8rg2bYdUvbhIrTu44Xf9jZx7WoPcQxkbY5cBRdNbCeEMiG
         VO11qp0/nlmLGStKmf3aSyGNWtjGX57CgzcHFhHww+0QIKzLXZGviHd3DxdpK/nixQJD
         t23yIumIBe+kUjRCKCedzxhe6dn145GdL0c3P+Fl37oV5AWODHrdVYZYnA3rTXNh4brz
         35owczdf3h/QYTyuGeQQeJNkJ1jpuqgT1AkH3MEiaAh8HyQU+z5gFDpJ2MBfaT/zx3QD
         Esfg==
X-Gm-Message-State: AOJu0YwFnsjB8VCFL/MNxVlpJEAnUtQfqhZIpmDWo994SWoLZauM0Uo3
	rieAcOiqImtDA1JlMMDr7vyimI1OM/YgBkhRY2XD6fPgm5A7GS+tvrv/FN+UEHnbODbfXs4CXXL
	3CbtTUZlixVnX1aXU/aeFRoVB4/XcTVjevpe9O0wPRU6/jaEQC91h9+s=
X-Google-Smtp-Source: AGHT+IEXeOhSU+tb50pUuFChd5J7zWEV3YHvC6L2uID7g10tC8Zwf41MhJVdp/tEqNbxdWiYO79idLAxm6enPy0TysA=
X-Received: by 2002:a17:903:22ca:b0:1de:f765:cc71 with SMTP id
 y10-20020a17090322ca00b001def765cc71mr273768plg.28.1710862144219; Tue, 19 Mar
 2024 08:29:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fWALQGhqNqh+hsEDZ9p1O3uS=0T4_hqx-fz_VNQF96Zzg@mail.gmail.com>
In-Reply-To: <CAP-5=fWALQGhqNqh+hsEDZ9p1O3uS=0T4_hqx-fz_VNQF96Zzg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 19 Mar 2024 08:28:49 -0700
Message-ID: <CAP-5=fVK2UV0s3hfo=G+TpsW7cW4WXndo+-OHVuCOYe0WWduhQ@mail.gmail.com>
Subject: Re: Google Summer-of-Code 2024
To: linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

A reminder/heads-up that the application period has now started and
will end on April 2nd [1]. Thanks for all the interest we've had, it
has exceeded everything we've had in the past! I'm really hoping all
the interest becomes applications and all of those become projects.
I'm excited for all the improvements that can come from the work.

Thanks,
Ian

[1] https://developers.google.com/open-source/gsoc/timeline

On Wed, Feb 21, 2024 at 7:07=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Hi,
>
> I'm happy to say that the Linux Foundation has once again been
> successfully chosen as an organization for Google Summer-of-Code
> (GSoC) 2024. This means we're looking for contributors to do work and
> get paid as part of the Google Summer-of-Code program!
>
> A full timeline is here:
> https://developers.google.com/open-source/gsoc/timeline
> We're in the part, "Potential GSoC contributors discuss application
> ideas with mentoring organizations".
>
> Project ideas and more information here:
> https://wiki.linuxfoundation.org/gsoc/2024-gsoc-perf
>
> Please help spread the word, volunteer to help out. etc.
>
> Thanks,
> Ian
