Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F593133987
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Oct 2024 16:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267749; cv=none; b=kXlNnpWlNAOpGwiEC+hoJGUbhrkvHPuIXToqM7i0v6fNWNaaQKFBizQrPHx99vQYJZ6r0/mijPtyDZQPE9BALHsUbN+5/oPI+ojzQYC5XFC4WEngPt4OFCn2gpkgpXAw8TbstXMqvk2RmLmVrtrGN2RkbrZ0dm++WejKMllsVvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267749; c=relaxed/simple;
	bh=G/RJTYen395sCHf3o0PPTezlt/2syDXKmHkNmd8dMf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SGpR+r3SvtpaccIP/4ZfmsFLF+L0CNJEZaeSpBTRPjyVorTQzNO2jg5FyQLgaFaTPnFLcSOitQDB0N5Ftjtaps25W4z6rc2dzfoTw7vJ0+CQs+hcWXsC7Rv70Ie8d6T6gZ/sq+LJvAV/MsU8z28cjlZMsXX43ZMREGbdl+HDZb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KDljfgmN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KDljfgmN"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20ca03687fdso232255ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Oct 2024 09:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729267747; x=1729872547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d02tJ2688aWYnrpNpT8aw0PM607j/vuc3rJOiuZ5dXI=;
        b=KDljfgmNGP1OXPUSjhl6Dbss1+0u9/PZoI9S18PXIo1+dU9SwBIqrqAIYBiFBgn2GO
         qoWg/1aTTOqBqyef0MJ8pEzi1anVzJXSHWG2+OArKtNZKya2wPyo9q8lYkzCmQyQItGT
         Mt/yaTwl+aHj97mRlyE982ZCuHGNj9pEoeuk/94SeisjB6ei5Kptrd5YA8Bu+QiZnlwM
         2nnQkvz1NqmZwYA135mcJTAuxw/h0nHaCW4JovrzaIocQYfyA2SsK82eLqtYQvfmGW90
         shLDxKZOH6DcHD95MfZO+I3FdE/fhJwSlly0UqawvP1v3ECTtkRYtJbY/nVWz4RAzVSA
         2b9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729267747; x=1729872547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d02tJ2688aWYnrpNpT8aw0PM607j/vuc3rJOiuZ5dXI=;
        b=V/mpakmBPKAOXbZS6GVDq0iY3RK5tsoJHe9bVuJ5rp98PhI+NbdJQClrjI9OEL8tPo
         aIVSgp4YULplYDmUPAtRx7EiRXQG/siwFEqMRQZztSpWo21BS8QBAYdzSS6/zz26wYbO
         rbB6N8rfj4QkVXeIL1clGXKmfKd+v/JvtwdACZYvhzbLoM/9OS0ZP9LaA10tJ8Wlo5jL
         FVaFuz5WvH1TC6M1Xms2pgfqbV7UPbDdeD9mfTtAauxUM+X8erC9Fr18BAxdpkcsFzbv
         EpAko14ntZIPWfGQvm1dTAJaLl4EROHVu2OuV93gTZUcvQ8d2U9bjLdtf+J11vJkfuC1
         Hflw==
X-Forwarded-Encrypted: i=1; AJvYcCXJcj7kfGlTNjOIw8lPwNfi4rhOGf9HtsvYAVcuzzdOALp9k/gBOBniB9hIIlZJa/aN+zm6NbLWaP1EKpRTKpFa@vger.kernel.org
X-Gm-Message-State: AOJu0YwUU6qsuRxWyKlEAs36zFxPewWB1e+J+w6iL2ZcWXfgsgDMpKsi
	H/D5dC33nLuT25kzYS1/ZHlogGhBIY6UgLmpm4GnStvGLPdRfvMFMpf6x/zj0ZDoU1c+V4scq1G
	vw7CqAB3le0cT9cnrqG298IixIFgWYGOd6LfZ
X-Google-Smtp-Source: AGHT+IGw/e8f9nTq5QjQwKGkhABnd4urQMDSdJvbm22FwwefYnvjUyaXjTm6dZq8c28kvMEL9FEwOmMU+QzXcUtmSx8=
X-Received: by 2002:a17:902:f68f:b0:20c:568f:37c7 with SMTP id
 d9443c01a7336-20e5b833634mr2711975ad.17.1729267746796; Fri, 18 Oct 2024
 09:09:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF6YOcNRt1=Dgw85QtVgwOY1QYTOd9E=V4Vr9xY2cjZp5n+bgw@mail.gmail.com>
 <ZxGPJpbElYMQhQDX@google.com> <CAF6YOcOOQ9gWg_LLzZXfyYrvhvZkgBhDL1rxMv4sHagZqiZRSA@mail.gmail.com>
In-Reply-To: <CAF6YOcOOQ9gWg_LLzZXfyYrvhvZkgBhDL1rxMv4sHagZqiZRSA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 18 Oct 2024 09:08:52 -0700
Message-ID: <CAP-5=fW6OnBvyGwEZHJut0QA6c=KD3UBf7mNKZC1YS5AjCNZsA@mail.gmail.com>
Subject: Re: Toggle perf stat on/off periodically and keep each sample
To: Fengkai Sun <qcloud1014@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 7:19=E2=80=AFAM Fengkai Sun <qcloud1014@gmail.com> =
wrote:
>
> Hello Namhyung, thank you very much for your reply!
>
> On Fri, Oct 18, 2024 at 6:26=E2=80=AFAM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > I think you are looking for something like interval mode like -I 1000.
> >
> >   $ sudo perf stat -a -I 1000 -e cycles,instructions sleep 5
> >   #           time             counts unit events
> >        1.001064439        644,313,943      cycles
> >        1.001064439        548,175,426      instructions                =
     #    0.85  insn per cycle
> >        2.002682133        570,454,723      cycles
> >        2.002682133        426,891,566      instructions                =
     #    0.75  insn per cycle
> >        3.004412672        565,162,161      cycles
> >        3.004412672        351,875,655      instructions                =
     #    0.62  insn per cycle
> >        4.006131920        463,748,461      cycles
> >        4.006131920        239,702,866      instructions                =
     #    0.52  insn per cycle
> >        5.001878221        466,409,911      cycles
> >        5.001878221        235,684,130      instructions                =
     #    0.51  insn per cycle
> >
> > Of course it doesn't turn the events on and off.  But is it something
> > similar to what you want?
> >
> > Thanks,
> > Namhyung
> >
>
> Yes, this is similar to what I want. Of course, I want the interval to
> be variable and can be set from the user program. I guess this cannot
> be achieved by current perf, right?

You could gather more data than you need and discard the ones you
don't? There's a json output to perf stat that may be useful for
scripting on top of this.

Fwiw, in the future writing python code to do this kind of thing
should be more straightforward:
https://lore.kernel.org/lkml/20241016042415.7552-17-irogers@google.com/

Thanks,
Ian
