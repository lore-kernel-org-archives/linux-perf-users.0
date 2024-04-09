Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F881E491
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Apr 2024 23:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712705074; cv=none; b=hs0n/d1MMuYTyAtwLrCaLYZeg32NsJ+DkcVpxVy2n1YI+053xJL32hbGeAxWenXb4zQNdTfco+9K34tmOF3zkm57Q04fQ6xjInUn2MZZbqYl7BEoymd5y6QccXt+9SydHNG+jz/Nup9Ako2RaGA/Ck/+Uop6uBR+P//qhqLlaW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712705074; c=relaxed/simple;
	bh=IFxtp5/b3NCxyIehAWBjqG/rLI/kFXb2xNTe9AJi6Ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKZBSFw2m2R4oh6MfAUF1cmnbF2uGGYepdl84MWdBNG2fzR/nORttHGAvWZbNmxBgE8q72WeBGKxBLWOdVbkg4R7PYU9620PvZpadBBvyaoKjBKaMqJWcsHM7fuYHRZudJ5XC7QufCebb8voLrzUifNXdrCbzWjZoJAp/KAr7BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBsPy056; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBsPy056"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7e3555015a8so2243418241.3
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Apr 2024 16:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712705071; x=1713309871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AukJ/1QwXoCft0xV39YvmnOfhwMCP+WOFf+PnF8g68=;
        b=TBsPy056f6MOKYD/zDyBfJW/yAKQNxK6egSZYtsVGu8SnGXSWkrOcZuQx0ER5vp7Wf
         //jos8E6BcVJ/5NIlGQqUkWMSgP1s8W51IuRrugdLFwj+JXjo7EknMZ8L43pHNwcAecg
         90Artnku6mIoqAD8Vo2X3fF2epLM2YH0AAAtBvE/xaBqAZzxbMuaN8RrqCfrtkWLRo9l
         X6Ss5jxsPp+Jq+kcFty1pMz1WykGPkyC0m+FaNLJ1NekbXzcPRgB7nh/M5cHV1Bq7GmK
         EklnU5+A0Z8oosiDcPdxt1Q18kIqnQaroB/LGIkmp92Nqog68KSFrt0wtct9p72pHnVW
         n+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712705071; x=1713309871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8AukJ/1QwXoCft0xV39YvmnOfhwMCP+WOFf+PnF8g68=;
        b=bnNWZQIdoorngpmQoCnsgafLtFPT4CwfFgzsW6LZKlmvoiPNSfOtPFIYxO6h4itpph
         dObKup1oWTqCl4VGBB9fLRwW9LnSOiI6Lm2ytMtRMV/XdOK9cKWKyNFJLXijtHy/j1yH
         55mX6CoEzcFPcyGsK47I24sif8T5OKuL5gr29zg/jxwkMpiNy79Vfav/GqHtpvMdde9T
         h94hvSqVQT9fskIZ2ycuzPxWCY8pvSGkpcno4MrM1bcqzJE8EwQVQR0fRvWSt6P2a3IJ
         ZrlsbrLcjDAoJ2Gp+aOFxo5kfNEHIg4hrfPjrbNyFakxqCsmPoNHCOxoE/Kk9z1WF03P
         QRKA==
X-Gm-Message-State: AOJu0YyCUC4HYbITH3gGZlQGbveexEMqe514ZtDPRYAQnb8Eu1P53B4U
	5nwVbluHEXyxllMMSQ7DWTaDcJUCeOZbTbn92aULfoKwziJSNIF9oAk+9DQVhYpN4OsG78ANZhO
	G95m855YByhMwWe+SaUMwTxaOZJ0UN2Q0
X-Google-Smtp-Source: AGHT+IFn/WOjHfCjq+PMmmRTl3WsAxtBlaK0Xhi5c3+A6FlffRHLruBkzzNxhrxX2Yp/ijKtA0eMG15X1DpKm7mJF+c=
X-Received: by 2002:a05:6102:3714:b0:47a:268c:9c1b with SMTP id
 s20-20020a056102371400b0047a268c9c1bmr6550vst.1.1712705071603; Tue, 09 Apr
 2024 16:24:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <83b3aa2678b7a82c4247669cd8edae4573d1f52b.camel@yandex.ru>
In-Reply-To: <83b3aa2678b7a82c4247669cd8edae4573d1f52b.camel@yandex.ru>
From: Namhyung Kim <namhyung@gmail.com>
Date: Tue, 9 Apr 2024 16:24:19 -0700
Message-ID: <CAM9d7cid-rmSVrQ2_eHH90NKxiXcX-u-udJv5WhRimkFtAyZVw@mail.gmail.com>
Subject: Re: `annotate --data-type` is empty
To: Konstantin Kharlamov <Hi-Angel@yandex.ru>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Apr 5, 2024 at 6:17=E2=80=AFAM Konstantin Kharlamov <Hi-Angel@yande=
x.ru> wrote:
>
> 6.8 release added a new feature: ability to see which struct fields are a=
ccessed the
> most, to figure out how to reorder them to maximize performance.

Thanks for testing this out!

>
> However, I am testing this with Emacs and I seem to get no results. Emacs=
 is built
> with debugging information.

Can you please share the output of `readelf -SW ./build/src/emacs` to verif=
y
if it has the debug information in the binary?

>
> # Steps to reproduce
>
> 1. Build emacs
> 2. Record a bit of Emacs work as:
>
>     perf mem record ./build/src/emacs --batch --eval '(benchmark-run 9999=
999 (cons 1 2))'
>
> 3. Get the results with
>
>    perf annotate --data-type
>
> ## Expected
>
> Information on a lot of different structs that are being used.
>
> ## Actual
>
> There is only one struct
>
>       Annotate type: 'struct _IO_FILE' in /usr/lib/libc.so.6 (1 samples):
>       [=E2=80=A6]
>
> and that's it.

And it seems it didn't get the debug info from the binary and
only got one from the libc.  I suspect it missed the debug info
somehow.

>
> # Additional information
>
> * perf version: 6.8 built manually from commit "e8f897f4afef: Linux 6.8"
> * `perf.data` for the testcase is 3.6M, so it definitely has more informa=
tion than
>   just this one struct. I can upload it somewhere if that helps.

If you can build from the perf source code, I'd recommend to use the
latest version which has a lot of improvements.  v6.8 only has the
basic support with pointer variables.  And the full features will be
available from v6.10.

Thanks,
Namhyung
