Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C72778F2F
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Mar 2026 00:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772755274; cv=pass; b=I3IvYB63c4gmqNMMbTWsSJrPJIhycOv+WCQzbb4VLzyBzqBLZ9lE0TaY3PzAuciyAkHd8l8mMTuQcx8mR3kRI8xCcCRDjoELjovvZS0zCCXemL3lXyBs7xRffhTnwfEFndnRxKEvJbdzn9/cHbvC9kcV0gqsFdfjLkqDfLyhwtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772755274; c=relaxed/simple;
	bh=3qEbBm1jbPyvcyzPvbQ27b0RLrReUvTwWMgymBGu5P4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L1GpJp7Jj4nglFezeVN1VK4X2YDe+YjLcO9rfAOzvW9FDf+MhKSwuc/BylWdz+JU2+fpu+DeibyMESktwzlu0M1UTRnb6vp0yxg48FwLaXiyR5zlan+g06W9Zg9reo4U8tIQJOXJxPDH7kqx0Q0DmV/uatBQSLaEsi1XoZvfI10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mv53he1W; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mv53he1W"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2bd801b40dbso643840eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Mar 2026 16:01:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772755272; cv=none;
        d=google.com; s=arc-20240605;
        b=hzzWWX3RctlSd1q5iCP31peyULHcDw06PE3GVdvxU9D46D5uzoIZBuer9d96jwCaNj
         d1n91ST7FZETZBNEhrYHCB/67+B3zwXURPCMCcW+CmzqnZJu7OqxYY+FpKc/TddTfl5x
         J6NOXMuf0qD5YT3bnYcJz9eCsrPVQAFLk0EDEU2mIhrHOjUnfGBjIzM2Ep+4v6UoeDMo
         NZWNPBB3rLw7yhVYAhSQl33t1f4l2Vs9HiLXd2PMoPU1zxsKE9qo0ujbKDRhGSVFR//j
         mwGwnZygMR0PSiDMJteDKVSbJgnvHMb6ROmkms8yjcOT2T0jvWgd/86f5Xg+wc6bJv9Q
         mBAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3qEbBm1jbPyvcyzPvbQ27b0RLrReUvTwWMgymBGu5P4=;
        fh=pComdKKhFioadU1Jyq2gRok+oe2Eqo6WFngVqKt5hZk=;
        b=CQLGoSv7G39XyE3i3kJE+jRgs7XGoNg2e7GUz0G9bv9dmMqKXyNE/GLScn9Zhj++2b
         bXVHqskkKzssOHaLoxKkz29leNyiP48SbpcUraBYhzxqR/PDInBN7ubocch55A/QC7MT
         G/ajtIao3Svx/oUnlecjpYgFljb+ne+tNRYAgyjUMixVrNigbJ7o+gJxF/YEVgQzVXk0
         0YsgDRU8iaGZj+InEaPKimQ4W7hSxB6iHHyGjNDpsY19oLkTOMkKFMdub3kAvhoeJFap
         kRucOrePRS7F5xWjFyetAa0oxLTPYP50SA6s9kpVkklE82kIquEkTRAv7abS6smHlcbw
         pu2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772755272; x=1773360072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qEbBm1jbPyvcyzPvbQ27b0RLrReUvTwWMgymBGu5P4=;
        b=mv53he1WEnDGV0lX+GuahMPhSpG6WxgyBCZnb/0g60YXYN6Ws0r/dNfHVwtDW1C5UP
         U2uTEh/PHvUvvisVjWf8ezIMqFJo4TTwr5dlheSoDaB4BmVVhIGBAbRFJIM7QORlAXMI
         ecAf0D96ULVsbSWvqja/T37jbRDldhcw8yiRsQ3TiH69TTJOqCMqwK6hl7XPC2NNXx6v
         iePE38nnC3Mf5ws0N8uowtH4qk1wpZdJZuTug1mRkoEqOtvSjuvjWKnjWdN5spEIvfkH
         O0Xg/2yN3NZ0QHTXD0+7kJl8chTpTfoCcpsHKsNEyuwQtgpb0YNxafHDSo0ezcAEDpQX
         A0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772755272; x=1773360072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3qEbBm1jbPyvcyzPvbQ27b0RLrReUvTwWMgymBGu5P4=;
        b=Ofk55ujnyuEYWgyrtI+/HW7gMhIoGLMCcdjkh7sA/RxgFuQNKHm0DSJZVph9AcNW4U
         GXlw2BOBAAnUTTN/2qN8RUfkgucVdORjJmMn+5ELBSgBX5Mzg1yNc8yzl8DmgTSU3eOZ
         JPAXD784em5WzkpyMoB2yKcf0AScWGUIqxiPVuOFyHssk54+ljyeOHANbqfEsC7kmnF+
         X51gRBc95SBy7wdd51DoVYCWWPGdpoSXH+eQfMVSm5XbXNPwFIVkfXj4Z3o9l3TUKr/R
         JzHoJXOD+PSrIpfzUkPq9B6EZH3Y+jtzuu2rOAP2wynPIbP7oF/TUTkY22zyehFFGTFQ
         swFg==
X-Forwarded-Encrypted: i=1; AJvYcCWdZ3E7HK6Fz3mmIWldaZN0KJDjMyohGmPcgwBN0mykPeJ6VW3LhrW6+UWcPay2IMKitjyeGU+WOUeLIARM8/JO@vger.kernel.org
X-Gm-Message-State: AOJu0YyukwLs/FlSxeoWLUklQx6yOEpCbHzVQlh5p9qkjxLTBKRa3RlO
	GA/XGQwo2PxkOgNfrh/G58UCkf/oVmiL2LWYwEGPwaDTCgxLNBdPOlQf24k5/WSol88sp0SCX7R
	DgzzTldH4hAh4Mb4QPky88VlKDi+zMbI=
X-Gm-Gg: ATEYQzx9ZjQML8BIZreZGFAT53aQA61YMpGjTKSCT2GWBoHkW8u5xP1LCo/zgA4S7T9
	DfNXWu9WnigRiILqPdTprd+70FD3+34WwFRQ0KNhR0A8dffOTybSmjgjdzdIRHJLdMuqYhPQML4
	3D+rRaZOyfNwyLRd8zqZOOvMwFLupkPoETCkc59dYzn3Kyece4cYR0q44uvoZLYinXsSVxUAzmr
	+NBCXGniD9W5gEbK8qEcC6rLc7VzpnjPf87zf1cbmhJRlT+8uWJj3Rp1mzyxF5JZNnNnrddI9/J
	PppRqEl9R6K4KhvkcVK/E3eMSz+JKNbNZLNEha7Gp0+0z3bMUb2Hp6NhJe3nmol2LT1DANkkKg+
	bYopur36i8DPUgeWb+p4YZSMpDXU28Oj94ds=
X-Received: by 2002:a05:7300:724b:b0:2be:140c:bc2b with SMTP id
 5a478bee46e88-2be4de7afc2mr72164eec.2.1772755272189; Thu, 05 Mar 2026
 16:01:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218154800.367720-1-9erthalion6@gmail.com>
 <CAP-5=fXLNybYv08dDfAqAsDBzbOPzQY4EZQvdY0WZsfrMu9Yyg@mail.gmail.com> <aahEEkHP5g-T_tFg@x1>
In-Reply-To: <aahEEkHP5g-T_tFg@x1>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 6 Mar 2026 01:01:00 +0100
X-Gm-Features: AaiRm51qiqId7CqvK_sID90lFjp0_dfbyZ9p1mZ9wtbLjp2EwVVDFdfBNYEombc
Message-ID: <CANiq72mdo3TFS=t=t05Qc4RZ7a6DNayaDkXMUHBhBFixRjCVYQ@mail.gmail.com>
Subject: Re: [PATCH v4] tools build: Fix rust cross compilation
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	linux-perf-users@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Levi Zim <i@kxxt.dev>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 3:39=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Thanks, applied to perf-tools, for v7.0.

I think v5 (the latest one) was applied (to tmp.perf-tools -- not sure
if that is the right place), but this reply was to v4 -- I mentioned
it just in case.

I hope that helps!

Cheers,
Miguel
