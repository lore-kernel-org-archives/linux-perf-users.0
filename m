Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KaMvLDy9"
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76301FD5
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Dec 2023 01:47:55 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d9caf5cc948so3726808276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Dec 2023 01:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701769675; x=1702374475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4OIORyF5AiO6J56QFameLO9C9jQkM/m+E8MEQMLkaE=;
        b=KaMvLDy9yiQ3ggUcQTiA9hDn0LaMCSKy+5u9hgjsavV+tn8z0KE6DukTTv8/qqI8Cw
         g5mN1Jd1B0gFRPRDCVRF7WQ3lDmDhDuThfrAo3Zza9fYRy2Vs4A368nmf1Xzqo0ehQS0
         jckXpQpFhDwA2yL1HiM6GuXlF88pZtzwFQw9tjXClFcZH8JaRFfwillJtVcl5gAsGI2Z
         Clg2S5Xf5CMzcPnEeA7v7EWd0XhvXHhaRrwEuL+LfGxCUdkQ/Jl5IHFYbhRzxPLzD3Ag
         +RqjdvrQ/GEqMysXKd46jGPqfN4Ecy+au0dOaX9dpl8cAucgOpFo/n4YmqLBUun5HzBb
         eOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701769675; x=1702374475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j4OIORyF5AiO6J56QFameLO9C9jQkM/m+E8MEQMLkaE=;
        b=HnNTrQL+AshqIlJ2j/lhFatHa/PRUqT1G8UB/ViHYNjjjpCerY56DLfsKEWJiBReF2
         DpZ94dGlV+2FpWXrHAUljnwFbOpxZ0TcEQepJCDbBtmH+qj3DJfMnBCexnWWcHDfI4+z
         jYwgRKvajuBSX2569o7+VP/ygTdkXWg4leRDd2cBlw6jU9mo0S/Ozcg0ruMYOXtES9Z5
         BXNGIJNsrNCsPDlMfT/TJF90ehtZc3EiC37zAMmO/xIsE/mYZzVQrZH9uh+QgUac9lt/
         gmRk2ACCefHj+20sSLXS2jv5A9Cu5ehEbLCoJ17DVfCUnKeobBpjCSwHZxN50ab8/Yim
         oaMQ==
X-Gm-Message-State: AOJu0YwoLpgD5FUgmxOqlwERfMuZLuuacGkr4p5yCSKpRaicWncHCewj
	mQ4hUC5F+KILPn6N0vgLCwdPsD8HBowKcouTaDaTvA==
X-Google-Smtp-Source: AGHT+IGLKV5WrEKu2Peckp8WnZLZ4p71MmEZ/yB7cIiIFKWxkfmDK61lxlmTj0F1X7OQOf1DIkrt+bUusOcTQ8qR7Ec=
X-Received: by 2002:a25:3290:0:b0:db5:9004:cf5b with SMTP id
 y138-20020a253290000000b00db59004cf5bmr3526873yby.64.1701769674682; Tue, 05
 Dec 2023 01:47:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204-drop-11mpcore-v1-1-f96cd3938cf1@linaro.org> <93cc5193-aa1b-4df8-8d00-c3149c33b7e7@app.fastmail.com>
In-Reply-To: <93cc5193-aa1b-4df8-8d00-c3149c33b7e7@app.fastmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 5 Dec 2023 10:47:43 +0100
Message-ID: <CACRpkdYcCh8TNBW-UJ1WhH-7sQMAw6xjx1FV6+bWGi2VmsTQHA@mail.gmail.com>
Subject: Re: [PATCH] ARM: Delete ARM11MPCore (ARM11 ARMv6K SMP) support
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Lubomir Rintel <lkundrak@v3.sk>, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 8:00=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote:

>  static const struct of_device_id realview_scu_match[] =3D {
> -       { .compatible =3D "arm,arm11mp-scu", },
>         { .compatible =3D "arm,cortex-a9-scu", },
>         { .compatible =3D "arm,cortex-a5-scu", },
>         { }
>
> I see that the arm,arm11mp-scu device is provided by
> arm-realview-eb-mp.dtsi, which in turn gets included
> by both arm-realview-eb-11mp.dts and arm-realview-eb-a9mp.dts,
> so the Cortex-A9 dtb ends up with the wrong compatible
> string at the moment.

Aha I need to make a separate DTS patch for that.

As stated in the commit message I don't know if RealView EB
is working very well on real hardware, I have only ever tested
it in QEMU.

> The driver doesn't care either way, and we can easily
> change the dtsi file use the Cortex-A9 compatibles
> later, but I think we probably want to leave the
> platsmp code to match the old string as well for
> compatibility with old dtb files.

The patch deletes the support for RealView EB ARM11MPCore
Kconfig as well so it should go I think? Or am I missing
something?

The Marvell MMP3 is also defining the "arm,arm11mp-scu"
but it's not using it for anything so I think it's just some bogus
copypaste error (Lubomir can maybe fill in) and should have its
own compatible.

BTW is the Marvell PJ4B a descendant of the XScale PXA? I
never manage to follow the lineage of these things.

Yours,
Linus Walleij
