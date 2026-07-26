Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A7A37C0FF
	for <linux-perf-users@vger.kernel.org>; Sun, 26 Jul 2026 07:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785051068; cv=pass; b=IiQqkpL2I35VvqyKNv1iyaTWV0g5T1caQb0qHE4eFXUBMHRZRWLafrpIqmdnqgN8ucGrnTsNCzmMexqo+XmNHVBwQKp6e4wdVozQCOMwW7gfZOkTI8Qx2XemXM/rF77fHG0jrQH219RAUdglMbrIXG+GGpRxWdQmrf+sxnrZHBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785051068; c=relaxed/simple;
	bh=i0lh72d2nmu3uu3VDQoHujJQG0QNixt9o8QmQUrkaDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CHecj8tBUd0whn9Qmyz2+UosVT8wGqxXxLXvgpTw1daq2FiZOFYRWBSeGrNDxX/xBpC5bnTN3uv2+ptjg9KWWyxWnQUF2bT4LQ/E9yA5yHAfKCg9m+pKKlSrGPvGzlxvERekuBWhJy3bWGSwTrpDKfItLZJ+qeW7gVtkFb2WB4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrK5Lp6W; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrK5Lp6W"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso1761836b3a.2
        for <linux-perf-users@vger.kernel.org>; Sun, 26 Jul 2026 00:31:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785051065; cv=none;
        d=google.com; s=arc-20260327;
        b=qofyS9SGYPDHuo0kj3Pj5ZSbU2DKUrvzyUw+M2O+XA5hPdqbIURZxE6epiuhHpfTEH
         a5CZ55c5CrNwyP2SdvdHkd6wZty9ULORb4Ph9Fqwv7TTk6LEtfNSR4aj5XNMX2CgUmMX
         cWoGvAF4NNnYC4s+DhY7TlGb2teMR9oziJt6O7tMAV48HAHLoJ73cqHdFo2rR9Q4XTzL
         k+nsCfYmK3Zge5AB5WhVGMjmZXsfUsbnCrcrbMyNqYwWtEEX8xcokqxRsaAJ+8oSyPn2
         qRd96D645q7/RIkA1Cko4fXVCcLBpzjA1CY/hG5tFOwicMmeTqJxfEZ3a/IpDoMKCRJs
         U37w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LZTVSxKYFzxJZaYDAFPYkohl9eRKYUawYCXhr4l0HQQ=;
        fh=PRlB5NGjVNVk2CbtOc5Pvk9+5J8IHUiM+LPcqNK0PU8=;
        b=anMrcKeXA5L01sypNvXyTDfRwbr7sPVD45vi5rDaVggDqJuhaT42Bgvk8ehGf7JWNT
         NBHxyvDki3CBKFcmNU/W5Qu0W8weCg9d8Y74Z4lUxycbvHsOH3m50BuSSV+wACk2pDJ9
         HS/vOqR+JWCRxBZmklRHAk987ehh6wnqDkVJOzPe51GvnKvLPpJWc5y1SmvmQoFDtX9u
         c0YDnU/lG5yzEkycxlegnAs2bYIZZd0YflI6KgDq6ij41A6kgKI7cItPiEqcEXnjYfJy
         d4LK3hnGpA+TjuYVSKXWZcNClyJ0AxxuOJFAmYmvl5x43dKxc6TPg8Tewh9gebaunNZB
         gAWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785051065; x=1785655865; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LZTVSxKYFzxJZaYDAFPYkohl9eRKYUawYCXhr4l0HQQ=;
        b=ZrK5Lp6WqJQ4AYEUExlJ96qEozJu712C5w53xvpoTOGRL96QqYfaHp2RmF753iN5bo
         SpbMiuR/Rrr6NF/cirypL9oH5ccFJu5bTk5LzZmmXhUqeg7FVeM4fTLlYxpoITkSGNR3
         I2Um1YzhaO7tB+9iew+TAmbV46K8WlZPKgh13IKI/eze+xalGjRmg2DPm7Yb1PTuegy/
         MxmXX75YGz7gvyBYyFHTMjrtevUQ63b9cQ+XCIYw2mH1awAMLl2FHoDGAuf6Q59GTmyB
         e/a4KhMt4VrfzGIH4psfiIcGyicDjqv+g4+ML8pvR1lnV4M+UuNinfYSKlsY9SespX06
         E0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785051065; x=1785655865;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LZTVSxKYFzxJZaYDAFPYkohl9eRKYUawYCXhr4l0HQQ=;
        b=gqtJaIasR2i4X0Vabpol2gUJsRDJtJ7DKh1+U4ki7JXn9nBunLlZqruVKDMu7O/1Hh
         O1PPOyRj+1TavvCkNJX64yPRvUTUNM3Ofu3jzjPk/Hc44C/EKnAB77VJ1O8oHDgI3BnE
         CYWfr0Il9ZfIs1mvVheVqPRHdeB+rkpuGvxxTamTNcQ+YmccSVJGE9hhBMC8iSfb5rFW
         1tLIZ32aF+YZS4EQB6MXjdGn+kNAf7ojUUz/078BfpXXRyYqApbnP0uzU12yEXjVB5uC
         Hl1mE+SlrWIxKhlzohAbEzuuYayb2s2jbnTE8zB0Yb8zTRj0C3/47rQ8q6QyWDNKotDW
         uTyw==
X-Forwarded-Encrypted: i=1; AHgh+Rp3qSRU5V+zrac5v+ClZ5ka8umua7kxmXF++3s3jUXMd4qQ5z5+p35ciBuk9DtCk27M2ExW/WomcUBpuJMbEgMb@vger.kernel.org
X-Gm-Message-State: AOJu0YzVCILv5a3muTMgSy1ufh6jHB1/wYODKA1Kxrr991ZUU68uvZ5J
	cvRk++DiP551+X13OmTFVAef6f9v5QQCIWyXjn/R+J2oUhsY3cCFjqtMIZAjdqSh+qxv9/KLp7/
	qpuxzwbBq1q6gwSViLf5rOYPhHx136ok=
X-Gm-Gg: AR+sD10PwODo/dqr8w8EvKjqAeVoXSA5/ktybRa2p8aNqcDLSjuOMUzsgBnFh/P/YAT
	KQ6pvhV0NDlOGNapAqvE684eogWv1eits05GRXcI9X24W3yV+rOqKcIIMJ+AV5Y2sSkPbwp9Ymk
	a9ENw7qbHE3v/Lt/kqX349KKelkr0PcC/wm2oUh0h2aBiE63kxNXW+AyfA71TaVdYcgcXoX7vCR
	61N4lYHt3zbLjdjB4Wqi0Elub4tDtX2JbVQ2VTZiKv+tB+Cx/+H8XPwy1Iukg==
X-Received: by 2002:a05:6a00:4213:b0:84c:4d9a:ae42 with SMTP id
 d2e1a72fcca58-84e59498487mr3719808b3a.27.1785051064667; Sun, 26 Jul 2026
 00:31:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523-af-alg-harden-v1-2-c76755c3a5c5@gmail.com>
 <20260603133312.12848-1-freude@linux.ibm.com> <amOGWwdjnJqyxH5L@codewreck.org>
 <20260724160034.GB2032@sol> <amOTjPW__CNZui3_@codewreck.org>
 <CAFLxGvy+ec3nQLrQtwFZgGELhT2pKBDnHdD0pMvEGh-Mf3rjgQ@mail.gmail.com>
 <20260725220443.GA41199@quark> <20260725230922.GB41199@quark>
In-Reply-To: <20260725230922.GB41199@quark>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 26 Jul 2026 09:30:50 +0200
X-Gm-Features: AUfX_mwtxGS7a6c5QzhlmY01HvejyEPiuukikmfTBc_9wA_H1fyNyxlq8igMsLA
Message-ID: <CAFLxGvzT7jO+dxLSUgw0SOViuV7suY+Tz8m-RE6DBVfF-WbRUA@mail.gmail.com>
Subject: Re: [PATCH 2/3] AF_ALG: Drop support for off-CPU cryptography
To: Eric Biggers <ebiggers@kernel.org>
Cc: Dominique Martinet <asmadeus@codewreck.org>, demiobenour@gmail.com, 
	Harald Freudenberger <freude@linux.ibm.com>, acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ardb@kernel.org, axboe@kernel.dk, 
	corbet@lwn.net, davem@davemloft.net, edumazet@google.com, 
	herbert@gondor.apana.org.au, horms@kernel.org, io-uring@vger.kernel.org, 
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org, kuba@kernel.org, 
	kuniyu@google.com, linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, peterz@infradead.org, 
	skhan@linuxfoundation.org, willemb@google.com, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2026 at 1:09=E2=80=AFAM Eric Biggers <ebiggers@kernel.org> =
wrote:
> > You've only mentioned that it "can" be used in this way in upstream.
> > Can you confirm that it *is* used, and with an actual upstream algorith=
m
> > name, and if so which one(s)?  And if so, would you also be able to
> > share whether this is for dm-crypt or not?  We should remember that
> > dm-crypt accepts keys directly and AF_ALG is not needed to use it.
>
> We'd also need to know whether the user (if there is one) requires
> unprivileged use.
>
> Hopefully not: these sorts of hardware crypto drivers have lots of bugs.
> Indeed, the CAAM "cbc(paes)" doesn't validate the key length correctly,
> leaks DMA mappings, concurrent requests race with each other, etc...

Uff, you're right. There are some nasty bugs.
I guess nobody noticed so far because the algorithm is only used a few time=
s
at bootup (as root).

--=20
Thanks,
//richard
