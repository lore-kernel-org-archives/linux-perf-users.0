Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A17D3FCB29
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807959; cv=pass; b=d4BDx4Bpfmt6bS+CIPGmKAZg0KzHT76PmWKPiO88Q5dedUY6avwMPaMvYDm87Nv+p/ldi8WFom+uKStH8vk0+wBGJS0ry+t6lxZ7FT88HkNnBPAJi4w9nYr9VJxAevrgpsQJLayBzEy3xJoe0eR6l4fMHBwuKHPU+4uTEu83Tkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807959; c=relaxed/simple;
	bh=TkJXkeX+uNd4WnzK6MvrQswj9uAEMcpg3jrGJxDSYNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nr94ZdS4cNQXWIUWQN0Cnnncp3O58un4wfJpwfZ/bDp+tx0pSlELsjB0t+weyJxLGqGa9VnjM7KDZzs9ij3hnMFJ6jf/9Hlgkb2E8rClHcpzENsmKFnqPh+H3cWLA3v8GJS1WY38Q0T9psZbpLdS1tS/40RQw8brAdr93aSVmLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wRjky0F0; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wRjky0F0"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ba180a022dso7285ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 08:05:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779807957; cv=none;
        d=google.com; s=arc-20240605;
        b=C6zKHVR5LTZ62VGs8IW0omhZyBpfse0Ln0/AETQKjKbl+yjzLAoULcAr51oPrLVAUn
         H2SjMfkEQeVSw+D9lZsdgtK8HD26ZcF4nFs+MtR/Jeno15oRp+/F1akasXSqQa/vchaC
         INqFGbDig/eYdt4ScwyHv0J4BFLiGyxE5/wub3bwLdteqzzYDpzPyleGzpwXywQ3Sv+P
         L6XVm5gsU4IrfvYRjGJV0KjamDR5hQJ2F5zO+/V1HgnsfPjzy4JtM4TbLEgaDxdy4Qm4
         H129/9/XKD7+fCNA0xa2dImPBLXnBG/vzsHkFPhD5FABhr798wQIBAxuisr6y+Uqgk54
         zhsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7hjBIV3YncQoAOrcH0md7YOINow/MYQW1Lzzp+25BWU=;
        fh=KyJSeVOTPIInJ4F03EGaxKipDjSQVMls7G3d9nOJboU=;
        b=JbiHuUPO4Z517H0WQF2XJazdXO3s6cOPCbfkmdOJo4ub1uyVzLfh0rUWNxtpiv8Aca
         yZIVncaEAtggeReClQ4qhbsCGY2A+83vluikS3Ae6O6+gq5LBfH+ef2EVRnFsxPovjOE
         lJ6cSi6lRaBXpo5euxHH8FaPKxvKgUcixtnZPpCkguIZrBN/bScMNrAtI7AhIRncjkX7
         8xvc+EJl0w0/hz/l+bosOqjuVgT3ter9n6mpNGvLZZFLdsNDi2ZNPkq6QEdfmi+UG37z
         khBPYp3zL9Gs1lmOFD3GU8249I7Fu8jGOBTh69x3oOuIvRDB6CPdqEe3Wv0e1Go7b5de
         bH4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779807957; x=1780412757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hjBIV3YncQoAOrcH0md7YOINow/MYQW1Lzzp+25BWU=;
        b=wRjky0F0NY+48TXiY0eYlTY2vhtO8AWn85PCM+GZ59RRBX+UVogRfhSb+EEMqFP0Fw
         0XI4zAHWYWOUYaJj3aHURFbrXkije5fhX7Vmj+pWZHouK9IFzuvo895+uoZLvoWCkfNJ
         7KfntapJXwNIz4BNvBrjWpswbQVDzc0jRgv7xT9zfEG5+6q015Skhqhte1q8mO8oYakg
         Pu3CzDC/3HEMyL1spxLdYjh523Lm7rmuNEaUK3VHZI1DGvg5qW7h4rfZBxuxtbonRsZA
         NClQ76Wi08FCWby8FGN7Ay9Clr/MX76wMSThLse2TZTkC2iT47o/nDthbN00NcysG9bQ
         BJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779807957; x=1780412757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7hjBIV3YncQoAOrcH0md7YOINow/MYQW1Lzzp+25BWU=;
        b=lhub/xSLVYa4LMiSD+QMEF4Vep4wAPNnyUJEWO4SsON9YVNtQtWcSUbSYw/LJTfFYa
         0y3+XiGIXDUGOwGXAyq7Lmo1zQ8+pY/1xnAqjTbmPL8mWGwxhy9axFnGQmfKxZu++6cl
         WcGfthBRL/f+mji84yDwB7WrmYbwo96zUQrMn8TW8F7Jcwxj2PVUblSGLAv53paGEpJC
         zzrVp4VE1LbROSEZajoxIhda+YG6TKryDppe+te/S0sbdxHIrKtc+pMsJayhl3VX9zBr
         tm9xZSKBWT8FWTEfgsU4mQdbUlzocvQn6NJUwTjx2gKZkKf5L4rtRIXrijMRhVN2ToXO
         RumQ==
X-Gm-Message-State: AOJu0Yw1mKpWgOAw6KKs1eyyBRU5vYUMzLCrs6fPeKYE30nKiljpqPzn
	slmCZhlcmbHdXdA4Wfgz64wKRi0tkmbaYhg+qMNGY3flAoYH0+b0sX3/NIephmI3UqH9OV4tuI5
	ckINkHJkQP9UzJ6n5sCTdwt0AlSe3jH+HXxGGP0do
X-Gm-Gg: Acq92OGjWCll3qEILlInfJK43nuGDawJW4eLady+1v48QlnOr+SEZK+1mqLEFwpPgkW
	NEl33ZFeHuNLw5YmmxX8LqinK8+pSqP1jUnC7CfP7WpIDFKa7d3VKJZfngdYrmlM/mYHcMzpbvo
	tPjQ3APJD9iyUKUI8JrgMN2Mxj96DNPNnKTc1+P8UlUqbehnpC/mtwdnbML38ti0+7XSm5TOEJf
	cveFymKzJ3sJsbXg68LaPkDBQdRv9GrBVigRHQSRm1V22iJ8zPt+1y+cPWWNjT0ClyDzZIqXBCV
	eL06lO/ntsLmdJoqLiYtuoSmqzHmT+rQ2Aop7yG6H3Q722O0
X-Received: by 2002:a17:903:2283:b0:2bd:6dad:7ccd with SMTP id
 d9443c01a7336-2bec11e3e7emr5045745ad.25.1779807956208; Tue, 26 May 2026
 08:05:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526110852.7259-1-miguel.martin.gil.uni@gmail.com> <20260526110852.7259-2-miguel.martin.gil.uni@gmail.com>
In-Reply-To: <20260526110852.7259-2-miguel.martin.gil.uni@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 26 May 2026 08:05:44 -0700
X-Gm-Features: AVHnY4KYIM5xGc-Eqp61VQfVhdyenu0EBGARcIF_hrLVznyN5sI2l571esD_iTY
Message-ID: <CAP-5=fW6uR+VBp7F=98iSKuS6j+wAHbbpSjxRZ-9mxaudupY4Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf util: fix perf_exe() buffer write past end
To: =?UTF-8?Q?Miguel_Mart=C3=ADn_Gil?= <miguel.martin.gil.uni@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 4:10=E2=80=AFAM Miguel Mart=C3=ADn Gil
<miguel.martin.gil.uni@gmail.com> wrote:
>
> perf_exe() passes len to readlink() and then unconditionally writes a tra=
iling NUL at buf[n]. If readlink() returns len, the write lands one byte pa=
st the buffer.
>
> Read at most len - 1 bytes and keep the existing NUL termination. Also gu=
ard the fallback path for tiny buffers so copying "perf" cannot overflow.
>
> Signed-off-by: Miguel Mart=C3=ADn Gil <miguel.martin.gil.uni@gmail.com>

Reviewed-by: Ian Rogers <irogers@google.com>

and Sashiko is green:
https://sashiko.dev/#/patchset/20260526110852.7259-2-miguel.martin.gil.uni%=
40gmail.com

Thanks,
Ian

> ---
>  tools/perf/util/util.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> index 25849434f0a4..2c2a5c449ffd 100644
> --- a/tools/perf/util/util.c
> +++ b/tools/perf/util/util.c
> @@ -419,11 +419,21 @@ int perf_tip(char **strp, const char *dirpath)
>
>  char *perf_exe(char *buf, int len)
>  {
> -       int n =3D readlink("/proc/self/exe", buf, len);
> +       int n;
> +
> +       if (len <=3D 0)
> +               return buf;
> +
> +       n =3D readlink("/proc/self/exe", buf, len - 1);
>         if (n > 0) {
>                 buf[n] =3D 0;
>                 return buf;
>         }
> +       if (len < (int)sizeof("perf")) {
> +               buf[0] =3D '\0';
> +               return buf;
> +       }
> +
>         return strcpy(buf, "perf");
>  }
>
> --
> 2.43.0
>
>
