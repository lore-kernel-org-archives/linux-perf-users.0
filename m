Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FEC3B42F4
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 21:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791841082; cv=pass; b=d/5cKVj0X9lfuk/WxFZ9RHpRCAZ7ycISIiiT/MfeKhGmK+fay5BsbG+iWNn5QycYGLhRhlLljaRGJeoeIgz3ZPSobfydEN0A+p/mx6NkEyM6hRtNsYTOE67Mx/MLAGQEoOKST7bjsQXjDsl1KgsCc9WyiOXQCE/rmz5J8b0PLSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791841082; c=relaxed/simple;
	bh=slDu1S3NEvxaLYJ/cgDIeepO5MtD/JMrBX12ULvCTZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QcKhkjWhjRg8tj9qo0w+D48+uCCBrI+I2jJlH+Ledr31Gxx+fLl6EFW0VEd90/MGSUIIKIwjk3kSV5/KoVX2yv7Sdq7wxuhBvw66g3R5lonRjZqEM5nHLY1Jkmi0AmKwP5Aq1Tnbr94pIivohFsx2oWnuDrBZZS6CPdvD5HsVt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LEKWTAMd; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LEKWTAMd"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5337c7b9937so539801cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 14:38:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791841080; cv=none;
        d=google.com; s=arc-20260327;
        b=eIVHp1X7lxsyqVuB89x0/dlxgbpBgP3ZpvX0qVMLY9vPSjUQRN+hEtttGYz3PZ6yE8
         LU8PDTS5yz1tc0J3GTmDpRrZ2lOui16XibrlOpZO5jyEuL73VNzekMDQV14vfSlp0gxk
         mazBRrIRbw9luBvV212pDwrJ6B4RGr0ixIAs9S6oSzIgZ3Gy1Z6SKLsd1svCqrrn2ky+
         GOVeC97/j7gRi7nWL0aHlM3wA+eiP09u5vC0woTV7nmFs3lu1oRkUb5sm+7DUE88WV91
         B6OJGxwSElTqp6gXWiLrFAti/RKChqsbJZ8QLOlOX9QDqV7jy6nZV63tv6J6v9g4lWqH
         1L8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dfZ1pdxaSN0EWKS1LnjMwHylnXhOgM1cGgWdcIKxOvI=;
        fh=kNi//NbUlsDbl6DVIygfLwPvxUkT8xxu9MgQMNYaPKQ=;
        b=nP6fiOANBo2Q1A63LRxh9n6ll50p/vpH05iBgn7AUamoydn+p3q4OFuqANwiBcuFvj
         0mkOdP9pZIBVMwSN+383l6ZxslFFGxlbgCbdPcKXy/X2gOhQAcGhq/lEPaZ/TdRxqx20
         TeiaK4Ey8AcZ0IPyGL6jfkTAHpkjwS3Hkm36UnYOnEs/hHfHi4gtHW0rc0JGm7txVOiy
         2aTq8awVACf7UtBI360368IUlZ0gB4rMobqptL6EcgE+dOIkGNq+anddtbrxMEwBe0rI
         QwtrXYTvJLLAA9k6tnpBwUwg+Fn5lU/NMJK5CgxAc9yd+voSTKSM483cAxBVSsCjkyFC
         1zBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791841080; x=1792445880; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dfZ1pdxaSN0EWKS1LnjMwHylnXhOgM1cGgWdcIKxOvI=;
        b=LEKWTAMdf1ts+qM8WNq26PNyj/JkdXYh+96hDZ8Uae3+iOgAd00nM3Yb5isa8G1M2z
         5HyERb/GEyUu0SJKs5/GHnf39KwXonzXUQIeGWW6mkzj7I0JLDo1t6hP5lSPukn/0gYz
         TKNfi7pR//vLCvX2oMQ3nSIwB9I5XaUdtacpx3KFV39fw4PxUYFuR+TPACOfmOp1suWT
         fylATmq0KLXUn6DkQ+SQ1ZYLPFtBU3t5edJhlZuOIdnLQUy32KIzPt4Q9yiy1Esgxd4E
         DqC50BxuRsi4LZCoCYaNEVZ3c5R9f7bcdImk47mbePAGCdnuKTFBTZXbGm7M2Qlfy0j8
         oHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791841080; x=1792445880;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dfZ1pdxaSN0EWKS1LnjMwHylnXhOgM1cGgWdcIKxOvI=;
        b=na4SKO68x9nCsIAogEkfINhRUpz5H0BZKwLDUjMEe6eG9+leVyVPSOUqZuZYvDd99c
         FzY9CxkBiBlcnHnFaIiCrOtm1NZrUuQzfRo2wMdB/rij28pmBaRzhWYrq3Lm4dBzEnT4
         YuQ9f7dW9s95rMX/jl0+wcdD80liDxPDekb1AWfN+dOgP/+vIKefLw475BPq/zOej49/
         plXLICNcTOvbxupMF8AzrRPXF5waXBm+deCTvXAYTabF3bN6pAqNZdhoE3ZVJZQ2QSoF
         SbBDAptgUI0teOtlQrD9O/mMbmfSlBQQt9CabYBtKg+kzoboKPIToURdQicpgS30lalP
         8wKw==
X-Forwarded-Encrypted: i=1; AKwUvBw4dLZcNuCh5jPkScoTtv30C9BxsxJaP0QASFAG395DB2SbGtFLsIJNeuv+7JrE/ZnukpFYI6AbuJbNRieb23+Z@vger.kernel.org
X-Gm-Message-State: AFq9FYJzkcsZJk2TFUfW8pZQBKQviDVbbzg9yLckYvRbhpAPttN/i/Os
	1h5tXNHPUADAQ0Itn3lLX8AOU8epnOYInk/pE4Wvuzfd+F05xcTTKLo8r37oq+PjQ3/5d6GfHbZ
	JsKhgz/PPVAeCphLvkKY7tALBkQkMqzvRa0YAObq7
X-Gm-Gg: AYBFou209S84X/haWMtcEEkA4nmzpZTHW5qgGkzRe1rAXq4KGSjVEVpShnZpmR/ALsg
	wdSFH0ua1S+L4wV1OZlv6qHpA2mRKGA7YuBjxCk56XopSEsRECl1g8CcRLxOrkX4d2nCFrX9jfF
	Dc1hJ54fi4Vbp8NLhhyApwO1FUhP3b09QURxekm7MtpWZMvLIPADMRMerJq/spoVhLuUd9K8J3/
	8rWbK6qofNwsv+bASsYokMsLY/lttz6P5EaWjcnbyLCl7oKId/gtbA/5t/KepgKEk/VBhXkGiXx
	uYgZbyiWiVu1zcNUE2tRGUFBaXz2OvdouJEzJqJSv4tbCW0K9M1JDvk5DcemdU2nuyqJmb4YVs2
	GN1Oy21OZ5Q==
X-Received: by 2002:a05:622a:1ba0:b0:534:313:9b4e with SMTP id
 d75a77b69052e-535b321298dmr37633311cf.5.1791841080036; Mon, 12 Oct 2026
 14:38:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012052601.13920-1-namhyung@kernel.org> <20261012052601.13920-7-namhyung@kernel.org>
In-Reply-To: <20261012052601.13920-7-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 Oct 2026 14:37:48 -0700
X-Gm-Features: AclHuK_ZrNgnTBwqtkh3IwDmLF8XdwWV2jnDsPu1pqTS-JvqwyRdhfAiTlgo_50
Message-ID: <CAP-5=fWbYmbMv_7rCyWGsSmDA2S0q-z8=2h1W3NqMWCiAJqniA@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] perf tools: Factor out dso__find_binary_type()
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 10:26=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Separate out the logic to detect binary type of a DSO.  It checks if the
> candidate file contains ".text" section.  It should be called under the
> dso lock.

Could we add an EXCLUSIVE_LOCKS_REQUIRED for this?

Thanks,
Ian
