Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4700131E2D
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Oct 2024 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261158; cv=none; b=KgO7+L/dov690p+v5N2mgHeHrTU/VF8KnvBSWo6lVD10HCrkXOusLWc94PXpanyK3FOHuYWcZJMsK29neqyjLmVFA6JzHcJ5k8n/yCZPv1jRBqbqD6kssFMuqHKjrtcd6Y9jRmup2zdfep7Mh5g328eHbzCniuAKnvO5sadsqbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261158; c=relaxed/simple;
	bh=2xlxeZ9OoKGPHMhrdGjlko0XLLulDpMda3GTAVQBm3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qoGvN1zOcY2lxU2c2ZWw28NJrthEnPAROOmfNKcP40RIyrejNR90rql/4AvUHhKCRqpdAVj5YLzvG/OjAER78Lk98vjgCJgBhcqL4v9b57YWgDNIVBUp+Bdwr31lu36jrTY4up7pOmy7EMVJN8oX456tGcEVi6ew/SZnM7nKeig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHfrV/68; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHfrV/68"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e29327636f3so2061477276.2
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Oct 2024 07:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729261155; x=1729865955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHMct0TaXLgyEvMrEKu1ezv0UmCqJZhRsNgpBE1Ac2I=;
        b=PHfrV/68BN8AKDMxGfDx7XYxCNfz3PUFw/m34VYvcP/rtYugRsNom+ZMpny8KXidmZ
         vdiPJkH0pNAjylFeHPg5mPNXsxkaEzd5n/Y7WSWMiYeq7UrE+AWkYhwbRz0aucJHBzyN
         0ldiAQochM03pcd4KnEJLw0jxqRwqyEy9QJwjraIvwMisFEFJSRfzA1s36M/Bu6DSxMU
         otbq9yNiiMvgLuK7qfZD8erUhQZJ7lArVo4nkUWJIxxUdSvRyLuS5c2VMzbtqO71O/sC
         kAZ2CBwLlXrKGVR4oV/CEIEjcpWjbhfYclBTRF2dhaORyN1wnoQSukDJTW42eFCSWs+M
         aWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729261155; x=1729865955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHMct0TaXLgyEvMrEKu1ezv0UmCqJZhRsNgpBE1Ac2I=;
        b=j9NSRj7txSX7UQc7tDbdZZ0S1zVLKXr0n6Ghxhwpv/uy03pxYsFPCbVdlAxtbwEK8m
         5YD7nCIzEmzpAy9+wW58mv9Tv9geOBjUs9vSKb1xgkqYpbspPIgur5LJwzsli9sgTqpm
         XA8oqNO3xiS1940CLBZDC7rKzZjE5ibim+Ci6kJI5ZjFHI3dA9N1e5eXiKH7543UMVA1
         u5c6HLlXuvZTNycd76l6xeTMg/zuSK/xirRD8Jhf+kvD66oFtszPKvRneCfk3r9g8vqP
         hhEhQal2v/2S0wwdyo4A2QcXtVnJUQzDmk+raEfW91fbnE4oqxAc1OTuvjvydwExJbdk
         DXLQ==
X-Gm-Message-State: AOJu0Yzm3U+nZxb1XwPVJFEFhESkln43zFN3hJuQIFn+FQ0QfcnNI4hC
	3t3FYqm8WSiQ/+U71yiaUQH36PUNmG4x7f4SSUfyPFfAXUT3G+dnDZ6eQeI/tomL9nRGkDRaZ71
	3PyQocnqtOJF8CrsUluCmpqDs8gEOMw==
X-Google-Smtp-Source: AGHT+IEL/O8jHcGp3BPjhMr5KbMkN6JxXEopUVaLwEn9wujMxlp2/xQ3vsK3sOMbXhjbDkGq3xyqcqa6O8+WyZxjXnY=
X-Received: by 2002:a05:690c:9685:b0:685:3ca1:b9d8 with SMTP id
 00721157ae682-6e5bfe95992mr26947817b3.30.1729261155574; Fri, 18 Oct 2024
 07:19:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF6YOcNRt1=Dgw85QtVgwOY1QYTOd9E=V4Vr9xY2cjZp5n+bgw@mail.gmail.com>
 <ZxGPJpbElYMQhQDX@google.com>
In-Reply-To: <ZxGPJpbElYMQhQDX@google.com>
From: Fengkai Sun <qcloud1014@gmail.com>
Date: Fri, 18 Oct 2024 22:19:04 +0800
Message-ID: <CAF6YOcOOQ9gWg_LLzZXfyYrvhvZkgBhDL1rxMv4sHagZqiZRSA@mail.gmail.com>
Subject: Re: Toggle perf stat on/off periodically and keep each sample
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung, thank you very much for your reply!

On Fri, Oct 18, 2024 at 6:26=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> I think you are looking for something like interval mode like -I 1000.
>
>   $ sudo perf stat -a -I 1000 -e cycles,instructions sleep 5
>   #           time             counts unit events
>        1.001064439        644,313,943      cycles
>        1.001064439        548,175,426      instructions                  =
   #    0.85  insn per cycle
>        2.002682133        570,454,723      cycles
>        2.002682133        426,891,566      instructions                  =
   #    0.75  insn per cycle
>        3.004412672        565,162,161      cycles
>        3.004412672        351,875,655      instructions                  =
   #    0.62  insn per cycle
>        4.006131920        463,748,461      cycles
>        4.006131920        239,702,866      instructions                  =
   #    0.52  insn per cycle
>        5.001878221        466,409,911      cycles
>        5.001878221        235,684,130      instructions                  =
   #    0.51  insn per cycle
>
> Of course it doesn't turn the events on and off.  But is it something
> similar to what you want?
>
> Thanks,
> Namhyung
>

Yes, this is similar to what I want. Of course, I want the interval to
be variable and can be set from the user program. I guess this cannot
be achieved by current perf, right?

---
Thanks,
Fengkai
