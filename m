Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B3214A8C
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Apr 2024 23:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712792796; cv=none; b=MaXx5LS7ZlOam1tI5G2dsEX6aPgIpOFKhZcGJH11OueE9kGYAlQq+98JiCswU8OOZCW02MwJUp9KpunRJrPj8egKhZqfY4K6Q1VrTCVU7jOdrZmFFtFX4gc11iiFjGdWspZTaQ2RL+oMKFIi4xolZWZv6zEbwrNmqyZ+heGOrbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712792796; c=relaxed/simple;
	bh=htzDZNW2cBkCQhW2PnUjm99zk5aQQ6LfQxg4mPK2Ou4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ea5gnlXF//dWyeacPQt7gVmUjHz2qQzbajfMKS6yuAZZpgOH7nS78+T6SfCwvclfo4HC6d37C/zyd/vLo9nJbBDmaGXCXc6P5tIDq/aMLEy8MMQNA9unFrPPboxtuCPCRf5KYoIwSBTb9+nfhHLFSIiD4qIgDhC0RQmP49TFL7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2a2d82537efso4318273a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Apr 2024 16:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712792794; x=1713397594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qQFngh/XWmfh4eCEflWO4VUptRw76shXZWfVWq1X8I=;
        b=UKXKB4zCJ9LKND0amSBBnrsEqOE7u/V0RYeBC3Lt30eA9bQhNJwxk1GnQJ2ePTDYEE
         Uyc19lm5C7fNccmbf24pjqEsz7Hj4rqYEoFTF5mFYUw0x09sPH+wIJcOn9srdc0mN89f
         VIrLrA47LbU9g8yxXlQXpy6A+EgLnoT7+W3TiZzdhFDi1hL/ins+Ywa2+IKpyQxAKpoC
         g0rYHa3bXHWOO9tYTp8+svCwKQ/7cWRrpsB40CKL16t6OezxF9+A/iwv0VI1zrBA+sNo
         Bwn1vqCrH6vF4quoFKUTx21I6gng8UdQZJNU21mK23W9wdxl91KyBcyhQhJ1d7PrxFim
         r+vQ==
X-Gm-Message-State: AOJu0YzFMtcTuwRDSL3OMTTTcSR8WatKujT3tPmydhflUdFPK9uwWFbj
	hUnY9xEHf8vRav2KyXFodmLquEetbJ7L/VzdrVraueO4jOuNfYonqqD5p0koKeXdfXxIFcjTqFz
	amJQYGobRobEF3DTCkR+MPKyUAYmSAnc4
X-Google-Smtp-Source: AGHT+IElLs+Zi7W6PaJ+xuaboCiMtN5U1BX3PiVSDCmmZy01FW5u4SVeYgjxlNTsL/NKh2mGIFyLFcd439fnyVKrxKA=
X-Received: by 2002:a17:90a:4094:b0:2a2:e56a:ca8f with SMTP id
 l20-20020a17090a409400b002a2e56aca8fmr4320583pjg.42.1712792794544; Wed, 10
 Apr 2024 16:46:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <83b3aa2678b7a82c4247669cd8edae4573d1f52b.camel@yandex.ru>
 <CAM9d7cid-rmSVrQ2_eHH90NKxiXcX-u-udJv5WhRimkFtAyZVw@mail.gmail.com> <15e1a2847b8cebab4de57fc68e033086aa6980ce.camel@yandex.ru>
In-Reply-To: <15e1a2847b8cebab4de57fc68e033086aa6980ce.camel@yandex.ru>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 10 Apr 2024 16:46:22 -0700
Message-ID: <CAM9d7chRRkEKxpvgD-=Aj+dWfma12EAQHJX=gakeNYrj7L_Lag@mail.gmail.com>
Subject: Re: `annotate --data-type` is empty
To: Konstantin Kharlamov <Hi-Angel@yandex.ru>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 1:19=E2=80=AFAM Konstantin Kharlamov <Hi-Angel@yand=
ex.ru> wrote:
>
> Cool, thank you!
>
> To cut story short: it worked. I followed your advice and built latest
> `perf`, that is from 6.9-rc3. Additionally, I rebuilt Emacs because
> that was an old build. I did check debug information in the older build
> before I sent previous email, by running emacs in `gdb` and setting
> breakpoint in a C file. So Idk if newer perf fixed it or somehow re-
> built Emacs influenced it. For posterity, flags I build it with are:
>
>         CFLAGS=3D'-march=3Dnative -O0 -g3 -pipe -fmerge-all-constants'
>         CC=3D'ccache cc'

Good to hear it worked well.  And v6.10 would bring a lot more
exciting updates, stay tuned!

>
> -------------------------
>
> However, I am also getting the following errors, what are they about?
>
>         Error running objdump  --start-address=3D0x0000000000016d00 -- st=
op-address=3D0x0000000000016f40  -d --no-show-raw-insn       -C "$1"
>         No output from objdump  --start-address=3D0x0000000000016d00 -- s=
top-address=3D0x0000000000016f40  -d --no-show-raw-insn       -C "$1"
>         Error running objdump  --start-address=3D0x00000000000155d0 -- st=
op-address=3D0x0000000000015910  -d --no-show-raw-insn       -C "$1"
>         No output from objdump  --start-address=3D0x00000000000155d0 -- s=
top-address=3D0x0000000000015910  -d --no-show-raw-insn       -C "$1"

I think it could not find the target binary for some reason.
I've sent out a fix for that.

https://lore.kernel.org/r/20240410185117.1987239-1-namhyung@kernel.org/

Thanks,
Namhyung
