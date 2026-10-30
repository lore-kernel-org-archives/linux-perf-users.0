Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793345635;
	b=O0t7su2I88B3OOmCnRJVfWXyd1G9qZwZggCvJR2pk9vDiqv7mw8TyirhB28cYtLwJyYI
	 0K9Q0OT+92rdEdPUCkqEeBmt6rrl4mrHeTRIEl/ad6hIhAb+N73lN4qREM4IOBxKUt8om
	 Q30P8ae37msCRDxZ9cfxT7rMUfKHOkL3/Yxsw/5MJnROVp2AWgeC+wSbg5sAB2xb0mX3M
	 bh4wZDnkFQJuwLseIbUtIA/pbWZjw1frF1/Z4w0lHl/G/BWBnDDN9bFHCFYhadIV8D7aB
	 waEDsEtvKN+il1F5hbK9VnWHdh+uLldYZldIVGd8B0xWAI1xEJexXUFQZwDPOnLc4rA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793345635;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BzMDdqDEf2PfGSyV10n+owoiqld++wyRkAWFeDnOkAA=;
	b=POkADA042jtcZKOR2I3TkdqG4AkxMbse94U7I9pk8AYsIaLnMOQHfP1BhqDqAnM4CIdE
	 cXDSGJXVJ750PCLWR8t+NcD2bE60/rpviFkytdFtNUP8srxwn/LIt9NNHyOd1d8ahEFA+
	 U5VcFR/19927dKsvdNbQya6W8iN7KtfBg/bn6VNfy3Y2J3LauRoNkMylWrx0yzHSCzUtE
	 /Fd8BdDegEusJ6ewtgZ+96K3CS+FqKBYDjhcd3mD1AOc4C7CCHkLfevSQffKiZdU33oNo
	 vjHf7p6SRdFXjy8lYTUdtf6DcDgma289IbAudfbAFV1kcU63/RledaezVfJSF9b/0Kw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=IZraQTfG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D09D606A327
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 07:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D09D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=IZraQTfG
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c445c95d553so44515866b.1
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 00:33:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793345633; cv=none;
        d=google.com; s=arc-20260327;
        b=duTVusi8Dq72PlWgQaRtWvURuv9uVghAA9Vf9jDuBWhF+4cg1cPlfzkuZiE4j4MZd1
         8T7N9ju8WLhYd+pPD0Pha2D1I1DZEoSYOnWm44waW7Opns9upirMp28+F/LBnWQ9Zmr+
         yV8TBjBIgRyFcVHhFxajC3nMPIu1Kyq1hXJoYAg7U5oEJlOHgqqbMZZ0rbivncBFmP8t
         wixk2RHvYKjXXZOWrxusb7D/XVCQpy0Smj0JivxJMVw09CEo20RluT/goarcoyo0v+u8
         vCb7jefPlZB7xdvIuy9kuNqpw2/ooMgJHZty9xMkQ2ycKXhDaVg7nzSLJskbM8XmLp6E
         43cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BzMDdqDEf2PfGSyV10n+owoiqld++wyRkAWFeDnOkAA=;
        fh=1xMfRi0bd2GtajGmWNuA+1XVDRO+eLz8NryC5+fg0iw=;
        b=YM5YQHpWEGsWvjW6vokTH934XiZB76yucN1vpqrOaFGGG4FUg/jbchzWTesVLxZwEW
         77d1+A47K7Cg5bFlfzHqcvbzoEEFgCDIPSf1iEBuasYB5SNQUwHILJdGvxg9J8M79bx7
         YBU6y6UwgIXtFpcBzTc1ReooOWSnYpUJCvB4IzMhesBIqvN29fNBHo5UWOAcHPxwQhVG
         NtFWp6uNaKGzDg+KYyFoSB1uoTekyorvDxWdNbx7HcLCA4rQ/EKP8NTmLiVvj68nwojv
         he/j4lOdFEQgbPNbnwXcp4DC9KG3VX1nBXn9LfUB6DilISgk3hZ3ExI02m9TeeJ7xqRH
         xW0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1793345633; x=1793950433; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BzMDdqDEf2PfGSyV10n+owoiqld++wyRkAWFeDnOkAA=;
        b=IZraQTfG+tDFd0+TYJNCsWuzg1Me+7gmHeIIcFBwZqtfpjJHI/NKwd/jkwpA6K7HfO
         7QFFf3AMazDYe88UeylCuRjtgIHgUe+Hv0gEoQd+qaqxwiWslcihgWMi8SX9bQiJgtfK
         oN0+0bJg+nSSS8xlNghZeod8htskZjRwDTHpH8IlI/AQC1pC1BNKDSqZ4Jwd0Vd/9GGk
         N4scwS9mMwNnr1evT+b8D2OLFw13iVj3ZUJXAh23zhr3JE5FM7ZHLHplgNVID8M8YmXe
         35HVKCWh5NMZQBa8jD0dsRwikYtERhhoywlq2SeEMhRZt7widTWqY3+fjrmYzeRdq4tY
         rw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793345633; x=1793950433;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BzMDdqDEf2PfGSyV10n+owoiqld++wyRkAWFeDnOkAA=;
        b=rD8g5ALqMfGYfEfK7bTfVWsbWLDQpe6Jhn94ATwMRuiuANy2va4nE19/wT+ty48KvS
         cabb7/9MufMp8V8m5cdJkVJkbZwaeh3blE2lLHHeuk2N2Uk3iwmIIfPYcGSu8jmMNt6Y
         2tUf50rbg1iDmyHY3Win3UhI9UGGadKm3oygg5TSlL+/HfFkMBvcymT3C3u1m2NosmyF
         29sJmz6ss61ziwj1kiaxM36I++bJLNHc6Gal8rT24Bmnit/sWApWflyVy3d7eXUT3MaG
         jSQbthoFO6rnHNJ0ccGxRFRTdrH6xEdogsjB1A+P7TEhQsKMygEFq1Fq0GT5BX1arvB6
         HASw==
X-Forwarded-Encrypted: i=1; AKwUvBx60d5v/f0cQoHyA77i8cYuJdhZ0/AEjDbMIw20HvmtFoQnmALSNJHhR+lMpGvrLc0L68knsk1Acx9rVvITCicA@vger.kernel.org
X-Gm-Message-State: AFq9FYIrPxSj/YcpSUw8VFbIKjMeKc7nJI8tepFfi2UOvNiFSY2HvfBJ
	p+TRKesAmXjFAh+OGldkrfAnIZObRbfCLLSAgJ/CA89XNt3NsugLmQlowqCILI570X5BnseKC72
	Nj5igUfSN0ANU11mJSzHNEDVqun5Bpz6tXaQzerxgJQ==
X-Gm-Gg: AYBFou3MsZUKDE65zB+1xxE3xwyYDjUYL3Z7C1dVjoeAIV3qJjOc5KVKJiOREWtwULR
	wWqnYhlvN1GOphkkhWdRjbYw06ZiNfB1sXdJ9wKGiqgOp9O9Y74HhRdjuVLHm3gznqOrFHDxBUZ
	RxEUm7sqrL4CjPS7V+d8579EnaL6yOs3y8rSa1dn/gvfQQK7WqWsmFRLTFOxBeb+Smp8B1+i3+j
	rWL6L4KUgjp9x9eVYWEB5TSbYpeUMWoYRw37hK/tLyvlFwUPJKW+Nlmg8Vzr7R+1wpr+LpDmg7f
	F0uXKNV1+06qNSgv9Ny81UspFBb3KiMh67CtxNqtleiomJk+iti3Vd2iLfgn6LYSb1RIxcRqoh2
	o3LCEum8nxRxrQmB8vGiT7iMMe8O8j1UlXpFa+4grnFAIYpyMiCSYsYorirShFHIo9g==
X-Received: by 2002:a17:907:9c06:b0:c42:24ea:3220 with SMTP id
 a640c23a62f3a-c4ca7ab31cdmr117578766b.31.1793345632990; Fri, 30 Oct 2026
 00:33:52 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261013130052.3012773-1-max.kellermann@ionos.com> <CAP-5=fVPtjkxcjEkR9r6QZGsoKe=_rZssjZp1FcJ7rCgntpPng@mail.gmail.com>
In-Reply-To: <CAP-5=fVPtjkxcjEkR9r6QZGsoKe=_rZssjZp1FcJ7rCgntpPng@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 30 Oct 2026 08:33:40 +0100
X-Gm-Features: AclHuK995b-JOK6lyN0BDphySp3adp3n0FavtFVMGG8FAoFOKg5oQqb1-bZD7YI
Message-ID: <CAKPOu+_C4H4w00762045owSGq2ExSec0da-NU3ZVW_aXC2fvOg@mail.gmail.com>
Subject: Re: [PATCH] perf: skip unnecessary userspace map synthesis
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 3:29=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
> Thanks for the contribution! I can see if there's a user event then
> evlist__needs_user_mmaps will return true, otherwise we'll return
> false if there's a kernel event but true if the list is empty or just
> contains dummy events. Why do the empty list and dummy case need the
> user mmap events?

I checked it again (and got confused a bit more than I should). Is the
empty list really possible? If no event is specified, "cycles" is the
implicit default in both tools.

With "perf -e dummy", the kernel emits user mmap records even with
"exclude_user", so this would be a possibly user-visible change.  Do
you want me to remove the "dummy" check, or do you want me to add a
comment explaining this?  Or is it possible to check whether a dummy
event is guaranteed to never require user mmaps?

--
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
