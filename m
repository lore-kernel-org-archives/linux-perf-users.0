Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E1C3C1F
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Jan 2026 00:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767312441; cv=pass; b=cUJwDCfA5f4uECx5bDORlFh52P2RdK0nXeeZTURBbgyEuXJmRRHE3mzGu7dTcM224lgjLKlCR8kukLWEWqlZxhyHOogsDdgHebGexGWSF+/b+c8qUpQA0HHCe1jlX10dAxJQA+s0q4N6U2lUgya1kbbiAbo+qtj7KuGHpcyJpNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767312441; c=relaxed/simple;
	bh=bzvdradnrH4y3ABu7mXqKAwg7D4A3vXrein3UIVagms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=COR89SHNagmTZCdRQNgiK3H7DFNlc/e+K9meFMw1m16nAYMYGz4yQLxeWfh5Hg/4cSmttTbMkfeAwkTf22eCQQHT3WWDvFwS1ToAK6WixAGAc3O261GTRU/WcqzAkEXYJ0DFYHhlPQzaleV6FueXWLmDAycXuU8hgZqFFgiqCAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FlzLHsHP; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FlzLHsHP"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a35ae38bdfso214425ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jan 2026 16:07:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767312439; cv=none;
        d=google.com; s=arc-20240605;
        b=Ckj+iiPJLrDLuBYTUr849xty/EDovVNGfqF3xn6MfjXie+srympgyUOaBx6lEm3Xq7
         JTsBJq3sG61L4g7CFeefbhGJLePDddRW2pOw5pE8WqXx8SwI3j2tV8A3ySRSyUfqWH4Q
         eXhpagGoChiH7IdqEuOLSt2X9wduRjUoYhNTkxPmzPN3LzdpsM9jx9+7lRF4H64nyfKs
         i56awzZ8bLouALPZBDFNgHY0FtshPToHWizBRy/aCOyH9mGknqltU1s+6wyvCkhCbE6M
         HJ+ynnLqVkiJmtHeKTBm+U/eWKpRzKacgtiDyeo561leJ/lmP99AlvfNVWaEk9SEbAlr
         3mUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IO19geaIGAMZyVUuJ8wlIAHyHp5IvsNTtBo5NCy+5VE=;
        fh=rD3ijd0Pi2jYIEzAdRTvdZL5u97G8K2ioJLU5o0IBYM=;
        b=a5ldGha5G7K2kTqrvf011e4FEDI910J7tJuet+IzdHE++x5JpveBx7nccrEWS1OYo+
         08Sj3qNEh2kmpbBe+DAKxl8madtRSb2zZbqeVVbk2jv2SSsWCLY+HoRjmvNkBB4Oe2iJ
         n+yDHlAMRZWTDOP/3+0b7nd0g9atg9PbiOpz+U1uYymfvuKnF9YuqOzwzZCIVzb6S+yr
         CXKu28SOJa/+k9TwapJYsofCxAqHTxEcoH8mkXlBBbbePVmSnbQllOS9hDhS2o3v9BcW
         TfQ/hOS1NP5uZBoumplk9Am+8HhYUsrPcLOXxBHvI9J72Zjf5EtMYZI+jmj53EuIxfAT
         nlWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767312439; x=1767917239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IO19geaIGAMZyVUuJ8wlIAHyHp5IvsNTtBo5NCy+5VE=;
        b=FlzLHsHP9lfPSxO2Ug0VNh/No6qmuMws62JY2GqTKeMagrB7gcCIzGTdWjgJGm3mPA
         YLxTj6kAs+N3O3G0uWMLg6mOU+sddwXzEbyOU2/TCaLV0x9AXe+4SQ9z/W2TJOxVIX8N
         uvs5t1QJI63/2HGHMqWSh9WlrFUvXDBnPQCwZCu9v1bYSBpofylFRExM8i+F22u0IqG+
         ui5TjjrJrsv3nnd/HsGfKMEYptUag9ki4f//duodQAlkEManASsix5Ss1QckzNDbZxEE
         dCoYoupEEO3r3tah4idUTSXHRZfY2OQ9wBPvla66YEdbsTtDgrjU6XfA9zgDuhjhB5ch
         KNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767312439; x=1767917239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IO19geaIGAMZyVUuJ8wlIAHyHp5IvsNTtBo5NCy+5VE=;
        b=aNwd0blL68U/XAb1XmjJDau8GMq6ns5XH2xTILfIfhcR+RTorpdX44fpTyjQyh5heL
         1TXj55JhkTlVvJZMvZfY+3Hd3VQGMeLiPxQ7LKL6OTDQOrf+dIySPguYx29lRuzwEzFj
         RrVBAWB4nCp83GI7RA3B0IxBZs8ULfkBXCgC9u9zekgeFA5UxY7m+VJ77eAYhuxpOt1C
         +5CWZ/rSDu3zZQnS3bdUilfWM0FdsoHL49TwL+Y3hHuN3GQ421ILj1YEycjLpWQ8Woax
         p+rxHHB3ZSkIiL43SdEIIMzWcQa7eXYOYGe6pO+OvxzLvxNZP+8kmdEOb60CwkBP7sUW
         GZ0g==
X-Forwarded-Encrypted: i=1; AJvYcCU/bYohjZ1mWXuY3rwzSq2ldy+vuVfrnjYU07lE778ZnrqsPUNJb8yHviPAe+/q1pJcAxubjjs4R+0irHDUOU0v@vger.kernel.org
X-Gm-Message-State: AOJu0YxHMhpBdIEXGso2p2MG6O0Pj7vvnFcLPkuMOgikZ9/WqRP78Pe0
	bHy7o28ScMB5PjtD+kOPpspVr1tq+F64KKqp8MMPNCHeXHz1cr3rDrYJVDj0PjcG0ZauUaJSdmx
	nuhg7zhg/iAfg4zLoT9P44HSmZc4MGnJKO0Sfwm6f
X-Gm-Gg: AY/fxX7Hw16NX+tuCIyrxIpGANJCzOB9zHnPZaGLxLj/HVGZsC++DTYXHOMYR9Z4dpC
	2W/5cxUD+Tal/mtWB/oBh75tTCggqbCatrNHLswzBZg65kEbFXbasvYSAAN7raQmIetGc29MLe+
	ZYsbdk2fQgB4zPM/8lXQOOP9kMUJh2GrVRl0giCb7WbWXMsijllRyJs1JLT6j8t/bHcrWLEj3G0
	hHbjIEICYY/YeV3IV6t19caDcSmCwzFHlf6QpKTqnPaKtEMREBcTduwUi34aj4199j8mag/
X-Google-Smtp-Source: AGHT+IHHiBBwrRubAUkhw4SjZDhn4k3EGqCubHAQugR24hG7pQWm02dE2ePMJTK9L/LerGyYfDcV6Qen77coT8tH3zs=
X-Received: by 2002:a17:902:e787:b0:295:3f35:a315 with SMTP id
 d9443c01a7336-2a3a48a826amr2334805ad.5.1767312439117; Thu, 01 Jan 2026
 16:07:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230165213.102961-1-Julia.Lawall@inria.fr>
In-Reply-To: <20251230165213.102961-1-Julia.Lawall@inria.fr>
From: Ian Rogers <irogers@google.com>
Date: Thu, 1 Jan 2026 16:07:07 -0800
X-Gm-Features: AQt7F2oY56GOwdQTZFk04JFPF5lQ-25qJ1pCUdkyzYBd0E7D11WdFiqqKHg7gBI
Message-ID: <CAP-5=fWMQ8H8_Y3pNzau8F4pMOZxAXgY=8Rk+YiN2LiYQY+Riw@mail.gmail.com>
Subject: Re: [PATCH] tools/perf/util/addr_location.c: update outdated comment
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Peter Zijlstra <peterz@infradead.org>, yunbolyu@smu.edu.sg, kexinsun@smail.nju.edu.cn, 
	ratnadiraw@smu.edu.sg, xutong.ma@inria.fr, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 8:52=E2=80=AFAM Julia Lawall <Julia.Lawall@inria.fr=
> wrote:
>
> The function addr_location__put() was renamed addr_location__exit()
> in commit 0dd5041c9a0e ("perf addr_location: Add init/exit/copy
> functions").  Make the comment preceding the function consistent with
> the function itself.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/addr_location.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/addr_location.c b/tools/perf/util/addr_locat=
ion.c
> index 007a2f5df9a6..81a0b79c5e10 100644
> --- a/tools/perf/util/addr_location.c
> +++ b/tools/perf/util/addr_location.c
> @@ -24,7 +24,7 @@ void addr_location__init(struct addr_location *al)
>   * The preprocess_sample method will return with reference counts for th=
e
>   * in it, when done using (and perhaps getting ref counts if needing to
>   * keep a pointer to one of those entries) it must be paired with
> - * addr_location__put(), so that the refcounts can be decremented.
> + * addr_location__exit(), so that the refcounts can be decremented.
>   */
>  void addr_location__exit(struct addr_location *al)
>  {
>
