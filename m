Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4508D21148F;
	Mon, 31 Mar 2025 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743430029; cv=none; b=IDTJ49y0Y+gJgiUDZl1VS+vM2hKrsRqsi5wK+FuRXTIZz+W7wWHQdAZdyfG2t18nANfRn1s6Ta0gcHvV5JI8UAxgjw9ZUilLIgJv514KzgRHaKxkZ55PRWt7PboLBNaqkq1NEdQj0RLfZQKT/2295lp2Sg8YT7s+IpxYPSqmxwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743430029; c=relaxed/simple;
	bh=OD7JebTfU5MT1X8WCmBSw8FWuc6qyRDXMpQO0/Gvy4c=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=AnZNkJNHuFUPxX7/6NmZU/77VaspoSNZ5Ijqd+T8bIwTg9Khz22TzbzPrrmGREBKEiCcyCF7zfqHlbSZIrvTkHnraW3V7O0Bprib2HF6LB1XW8/6M66z8A0U9PqXgjY+ZwzIX4X7Lrbn9ImcAt/za/YxRbUSsYPYLBeScKX/H/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=tnzgH5Xt; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="tnzgH5Xt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743430025; x=1744034825; i=markus.elfring@web.de;
	bh=gdvTQJalkKgGpg46yW+cy2ny+k+pwLnIsMQDuMyPfkk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tnzgH5Xt6wbTBSwDmUaMD/lstqW32+Rp0vHYm87h79/jovkdQxYxqyASF6nUlIX2
	 JYQvprP2fZWfBPQSEgwVnGU3MsGbpAWtr0+3Kbnk2tiA05H37EFkgEuMUirncuG1P
	 hifJhHhENYmvNW6Y+2UNWhRzWNe7XQihDSbZcgb42NzH0IukSoG6PAO+824iSZD3i
	 rVhGQNag0kCEDj7bnQZZMvn3BhtDfydaCNbFJ+pFjQjmwmqoaIgliATq6vaDhz+3B
	 8Goc7FZ7gY3alQyarryvGKHAtX179nNiPRgWoho3QqZ3q+LSkVwIDugmDyndwT9Sn
	 ieM8wRRIAqww+c5cnQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.37]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N1d7i-1sxMZd0wnY-012Izn; Mon, 31
 Mar 2025 16:07:05 +0200
Message-ID: <96d7676a-ade7-4250-be3f-fd11728c23ee@web.de>
Date: Mon, 31 Mar 2025 16:07:04 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Henry Martin <bsdhenrymartin@gmail.com>,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Will Deacon <will@kernel.org>
References: <20250331135128.11881-1-bsdhenrymartin@gmail.com>
Subject: Re: [PATCH v2] driver: tx2: Add NULL check in tx2_uncore_pmu_register
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250331135128.11881-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rvQsaVjLIcFHk0ZTJft0nYrW4clO8feC57kVZ0fPagvI4VIK5OJ
 gJXQU8mFfXoHOVZUv2JL+JNymW9cYMIGUSEWsa3qJJDFBO7WQc0fgj/dKraZB5avpwPm4i0
 Dl9H65dz80TjYJ3kNfFsS8b+vlESi7gOSnwZoZuFcO7mAHqU2r+g8tPOBqly1U+fBxs86g5
 0Ac7xuAxOhCtFS3FmtDjQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WvlePFoJq3k=;ekmxjxif54ej6eMwJALcA96UWfL
 6bd5F1fr/u2fBaXlLdwk0ay9iQ7IUqXJFubcZZ5xoa91ODYe9CtwEW/eAPcpZRlWTzMPFgKpH
 16exN+QxUyPiEEfnDYMOLyly8KiWkzaphRjfxdsJLrOVanvAvc3UBMbJYLasdG4KbrAko0PiG
 5Lx6HIPbAHsTRM+WSzJlj0oR+SA5+tsrLwpzD/D71Jpo4/0WQI6OlbiKJHQ4jvBUqr808V/CH
 fyG4rTO3OZsD+Z0wGx9B8d5FhAMd1/5lzXu/LhS7dimjIuXfmd74QjYNWeVxpZBLaYzhsI1M2
 Y00FfZeS7ND9NQVvpkzJbN3VOZw3SOXOtJIRG87Kj/hq55JiEvszca++dAxjxjFzlFYpVurH5
 FZk3RExIEYs2z3cGmZDhiFLJTbY5p20ybD8tI3yGPf4TAOFB6DLvxmwKBNgEdOUFnKdye2s9n
 9pU1bNnBz1ynaE7hYzAsDga28tXzbZ3dmXxTyGROdZtyCYhHyaTkukvpaAjLPTK2DcdiP6U/M
 m62vNSUXA43AVTrfEmZ+3QjKRe768wdH7tzpQxr8m5hg9yL6XKHalSnsKU9lnHS/hMPHfSeXi
 ctGr81Wt5A8Q7oxYBCGcEtc1+X+MfVNZpDx4dI5XbmIwkpKBVuWfrpOEMXMoW/tYn2brQtPDL
 kPBuQ3uLNBuNMx8rD8SKIHBrNoEMQV/Gc3SPmlQ+NibYD6zpgMPyMnBvOp2fHd2IYFBngH/L+
 KNNYHx+n9/e+j0GRie83Rttk10z2e8VST+I0lSWqKI1qlliTUZpac/aKDQ/pEuYBr4MY/lj63
 WqB7sMp11p7uyCHVaI86Qxn7hR5JQhiclRExhXx0RJhKGPnNrthGn4ifKSIlgMv6gYq+cV6/A
 fIqd3dlUIAIMJYEzKxeJGtz8D6pLvUhjnLn7SY/NF60DR2e31+N/pIvQSb30dftB4lXfWm87Z
 cy9AJo0t0BLtHidfTuEktogXGBoiy592Qg1yECrTN9oZlA1DWdXNPNqPgOuH/zpU/RH9sZR7N
 NimNuTp5hOwtFYBQ+lK85C5fHOqbq+GM+T46FldEfDeBzT6siJThPz2DI0OmUzGT9/fxJTYxM
 apoaiy6rkfpIA90/EW5djsYN/gZ3WwVsu3l3Maq3hCri0gLjSNxybMSMqe4Fm6DxM4HnOCGkW
 SGMekUZi1ncUchtXd7bXyWgDqz8ckVbMsEj0qMgc3YNTCUFoVW4v0MPOQGpb9Ih4X2ICCptfP
 bYbgvjufEy/EndarkVfr6GlHqdWLmal/nenJA4w1Ui6ywthfkdNJh1C7WKGacq+psEKd5ceGX
 Fmx5pDS/3XKaHaW404xbIaSPkWkxtkqt8fUuUYw+CLPj7uq0VrNghEwCfuAEhd/j02qAeRRSD
 tjpE3eFRil+nNBQEDqHrVWE0SKFYJPNraPbF8p5Hg7ZD7XYniuDkXFGgsjWMopIfZR/ouF/d1
 ISwHuX4r0UM28LTdTFonSTrhnQNb+wXFLTvfguuiiaInYq3cM

> devm_kasprintf() return NULL if memory allocation fails. Currently,

                   call returns?                    failed?


> tx2_uncore_pmu_register() does not check for this case, leading to a
> possible NULL pointer dereference.
=E2=80=A6

You may omit the word =E2=80=9Cpossible=E2=80=9D in such a change descript=
ion.


Is any automated source code analysis involved here?
https://cwe.mitre.org/data/definitions/252.html

Regards,
Markus
