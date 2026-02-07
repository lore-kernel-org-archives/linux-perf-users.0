Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204DB255F2C
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Feb 2026 02:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770430325; cv=pass; b=avAJnRdpFnXFalkKTj8kBZxswLpUZ7exHgx1P0C/qrhc3Zzwihywq3mBtWcXW7kOKMHVF9zhLS8jzg1fXdIVpM6QLc5bqx83HS8/pJHxheYzxWmMIwtkYuAnC4rf9bq1ERp73aaEw7iiQl34qB7WGrERar3kzref4G1/BybPsn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770430325; c=relaxed/simple;
	bh=H8ygkU9hCJhnugRPEnG3lPWgCrbq+0GO3cjHhz/6Ncs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZKBLsfV/9lzFz/59J4vIxqQhfeFzJ/RDCbKUXBASGhTFK5IQXJIrNqm53WinyYxyeuSkGtCDpUkF5/D4r2WiRRDfhy57v6FgGi53yYazE5X49eb8By4gFwqRJCWsyBsIP9R69Vy4QG1LrDw51uyIQgWzWd8vMFkC9d4dBRVZ28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=UK1Tfjts; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UK1Tfjts"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64c893f3a94so5741705a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Feb 2026 18:12:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770430323; cv=none;
        d=google.com; s=arc-20240605;
        b=FuMvU9QQsLuDuDmrQTHETv3wQOJ/2N95RH/mQIjX28OVEeQr9uwKLB/GFUevoHNEZC
         6ikihYtksO+HeRBJ5HR7N7JjXKHGdWYxCWVadX5njS6Ea37NAYwg4JgHbYlWzXUgm2xv
         oBKwwjVoyljj5b7QQNElTOz7e4kWF1joB6k95YIq0r0NqBKiX6mpxRyvzr1Z1rr7eng2
         UnvIiPmZbiiw8IiswzzSTE2y5tvXDlL0fwGZ51biJ2KQ9ed24XaSSKoeVSph7dF5PPe2
         h5QgtGdMrKxTrhrmK3uY3X80DEmjzbXl6mgP4l+sqoK0oaPuHmDAL7L0UtojpNMDjdYn
         RlMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xVXJfBkOf++utzjym33J9FgN5u0L0gqySOwPjSjRi3c=;
        fh=q7FgfY4Z6KxH3CXTglp1dHBnU1cykEpPSCXy20cH+X0=;
        b=DP+RLfUL9oM1zCtKlwlrb7pkooJx+VU0qzjuRXttgU0SPu8uSb9r5YHuRbKvWSgCfb
         F5Jbm8efFygK2aT6BRPAyDlJwTH63u1DTo4B1DbXE5BmVlVzeQRBSeclTf8jY2kPNfTS
         kPpk3Q0bCO53iWuejaX+YMzNfF2QsqFq4gPg8zqwzZ4mjHyRdTBtYJqf+ItAWypWGkbR
         4iIZqm1kOGgJ7qB+Ball7OW1vnhcx/Kf8VBZ9BWoipws8FCTQgB4D+/0NPzTk0jFPEKP
         5d1U3w+Cb76yyD5geluw7XV4mxn8MiBqNWTyT8TA7JnaCsGYkyUBKlVI61op5dNnFZNi
         lJIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1770430323; x=1771035123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVXJfBkOf++utzjym33J9FgN5u0L0gqySOwPjSjRi3c=;
        b=UK1TfjtskPBvBftD8YltalZRhW5+CL61JXQpe+siFZNRnOb8IJI9VeA4W7tCT8aILo
         xxmxWGLltOYSYDDzCgQsd6K5+i8tA/hs61GeY/gAcoq1s0p2obnTsmYfqOxil6YaCIep
         exhwyQgIXqrNs7ABqwVA7X2oY1vq9BUbTzK3JyRHpK8tjIJ7v0lTspBl5XODh9txlTZr
         83byfTHuAPjR0CukRdRoq5NWP4NS53oDfi58vAxKAn9zSQ+dg3P4iJ7ZUEY5egYJ77mZ
         /ib0GOQkvxB/Am+FgBL2vnWUTrnS0022ztCtKeIE/GlDceotZSuZu71J6LvSUBcGFw/s
         bBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770430323; x=1771035123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xVXJfBkOf++utzjym33J9FgN5u0L0gqySOwPjSjRi3c=;
        b=erTvgFfdcXI0F9hfTT8yUT9188NSDY/CVUULuRBstKCtFjUU1mwBDx6ct4uNGqoPfB
         /jojTigX3vBywprAn7xNmcZ12gO/JysjjsEsH3jiTqqdV9Nh56cIGVPLQEKk2awT0jl9
         6aiQ4xzEdWW6xbX/Ejhjk1oL7aGVN+qK6TKtjnzNMeO0pXk4UP0We6rq9ZnhPXT1p2GK
         xcAunNEkrOtVxRRCxLmnt9knDHNMpQ2MGOaj883UVu/EYevjAR5NgZBkloRcpSAyNgKg
         Ev6LZr1f+cH8lwFAD6MPtcC2NWP5jd3cPT5Hr23em96x8QqoNd0RU5EwDvg1Ijo7CznI
         Mw7g==
X-Forwarded-Encrypted: i=1; AJvYcCUzYrrJXCXqq8r0y46OgQfeqCIV9/rtbQjHgwmvgvSgiduHLcH9s+kuwJ0TIFV76VxKx+1vWMiLnQcOfl+J1eAr@vger.kernel.org
X-Gm-Message-State: AOJu0YwAy3M2Gd2Rd90dOeYRIJwLjP7M5FVJFQm+jJHIxrIVAWbCfXD9
	4J87VytP8AAlDD6R4wGcyA5FWTwOOqSe54YDJo2nb+k8GoqyvoUvibahC55/SJvn8wEvWJUHQGa
	ev0/gSkxcC3oim90ahSo9k/gauLxU2sqtIh+PLf+5ZUjqRYId5Kc4D8k=
X-Gm-Gg: AZuq6aKcUNpV2hn9AtDcH9mQBvy9aqkH5Fivau0uhZZF60WorA0kxrPPFsO1DgUJeB4
	k4siT1Q/fSCVuzpy98Ok2RXx6zGMEAUUqfNKb7Og2r/8itwCcSNbxoV3SgyAaIp3WKQcyiNe2nh
	FpJQorWXxNN36EJ/Q3m0Yf6p0nbA2uG/3i2DgQKaCHiDLkcx7M1Skbk4tPbtA0G3sI2yfAUdQ28
	QklYz8syc1AqECioUD/WZlUh2M5ea6bh+2XYo77KzlYm9qVuA7O17SFkBQFQgqtTpukoa2/xBkw
	mvYtxJVy
X-Received: by 2002:a17:906:d54e:b0:b87:2abc:4a2a with SMTP id
 a640c23a62f3a-b8edb7e7fefmr270858966b.1.1770430323440; Fri, 06 Feb 2026
 18:12:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769562575.git.lv.zheng@spacemit.com> <cover.1770195980.git.lv.zheng@linux.spacemit.com>
 <9C0A2AD4850D179B+524146e74e808db90d5f28fcb6ee791cf1d1bfaa.1770195980.git.lv.zheng@linux.spacemit.com>
 <p74snip7yykhogvzqld4gyjlygmd2z4kqnat7w3qj63fwebnmm@dlz6tloevgbs>
 <4D87481E9AABE2C6+72d18f72-9407-4d68-8195-edc6c171df14@linux.spacemit.com>
 <CANXhq0q8N5eHx9ytabZR97Y7AULKwgS2-uEGhcaOOGp9mvbtRQ@mail.gmail.com>
 <6C65A3873186B07C+29da5dbd-ed27-4ace-a5ca-355b3983d60c@linux.spacemit.com>
 <zzbwkazzgeovgmbvg4qnibipzsldqcjnw4axnxlamhgvcld4hs@4m4cc2ctuuvf>
 <752514AD54FA2A1B+513d6894-b3bf-44f3-bcc1-7d30f2642cc2@linux.spacemit.com> <xukccsqgwmagqq5egx7i4op6nfot3t3lusnaso4pfzcq5h6bfz@adsm5nusnocx>
In-Reply-To: <xukccsqgwmagqq5egx7i4op6nfot3t3lusnaso4pfzcq5h6bfz@adsm5nusnocx>
From: Zong Li <zong.li@sifive.com>
Date: Sat, 7 Feb 2026 10:11:53 +0800
X-Gm-Features: AZwV_Qjm6m6hA8715ry8OfD2Mr5pGoAnS-0dMwS1leYT9MosL-HIb3AQrdVJAok
Message-ID: <CANXhq0rFuvfcYRew3ZDWfNOrrAYo01OqPzJ5rbRZN6eS1t72jA@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] iommu/riscv: Add HPM support for performance monitoring
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: Lv Zheng <lv.zheng@linux.spacemit.com>, Tomasz Jeznach <tjeznach@rivosinc.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Jingyu Li <joey.li@spacemit.com>, iommu@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, devicetree@vger.kernel.org, 
	Yaxing Guo <guoyaxing@bosc.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 11:09=E2=80=AFPM Andrew Jones
<andrew.jones@oss.qualcomm.com> wrote:
>
> On Fri, Feb 06, 2026 at 11:42:39AM +0800, Lv Zheng wrote:
> > On 2/5/2026 11:23 PM, Andrew Jones wrote:
> ...
> > > Since Zong Li's patches were already on the list then your serieswoul=
d> at
> > least discuss them in the cover letter, explaining why you've opted
> > > not to adopt them. But, most likely some of the patches can be adopte=
d,
> > > so those should be extracted from Zong Li's work (with authorship
> > > preserved) and based upon in order to respect that prior work.
> > >
> >
> > You can see we have contacted each other in community, and decided to
> > cooperate in this way to honor his contribution. But final decision is
> > left for the community to decide:
> >
> > From Zong Li:
> > >> Of course, if the community would prefer to go your version, I=E2=80=
=99m
> > >> perfectly fine with that as well.
> >
> > We respect all contributions, We'll add the link in cover letter to the
> > follow-up revisions, let me know if anything else should be done to the
> > new revisions.
>
> Just do all the communication before posting, allowing that communication
> to be summarized in the cover letter and in any appropriate commit
> messages so reviewers know what's going on. Also don't forget to CC
> anybody previously involved to ensure they have a chance to chime in.
>
> >
> > --------------------------------------------------------------------
> >
> > And let me describe in details to compare the functionalities and
> > addressed comments between what is provided by Joey and by Zong:
> >
> > https://lore.kernel.org/all/20250115030306.29735-1-zong.li@sifive.com/
> >
> > There is no missing functionalities between the two approaches, I also
> > checked the original Robin's comments, let me describe them in details:
>
> My concern wasn't whether or not Robin's comments were addressed in this
> posting (that's important, but not what I'm talking about). My concern
> was that Zong Li's work wasn't addressed in any way, so appeared to be
> a chance for duplicated efforts. Indeed his reply [1] indicates exactly
> that and even that there is a third patch series being worked
> independently. Please work out who and what patches are going to be
> the focus going forward and describe that decision in the cover letter
> for the next revision. And please don't forget to CC Zong Li and Yaxing
> Guo.
>
> [1] https://lore.kernel.org/all/CANXhq0oi9nE7ffLGsz5j8GnC1UDTD-4bE4cantRj=
W2fXHYrjHA@mail.gmail.com/
>

First of all, I apologize for the delay of the PMU series and any
inconvenience it may have caused. I also really appreciate Andrew for
pointing out the upstream culture and consensus.

My next version (v3 series) is expected to be sent out in the next
couple of days. It will pick up all the suggestions and feedback from
the previous versions. Apart from that, the main structural change is
that the PMU driver has been moved under drivers/perf/, which is
something that has been mentioned repeatedly by several people.

To allow everyone to review the major changes in the next version as
soon as possible, the custom event support will be split into a
separate series. Its overall idea will be similar to a typical
platform driver, where vendor-specific PMU events are defined through
driver data. More details will be described in the v3 cover letter.

Additionally, since I did not follow up the patches from Lv Zheng,
Jingyu Li, or Yaxing, it is very possible that my v3 series may miss
some important features or fixes from their work. If that is the case,
I apologize,  I was not aware that those patches had been posted to
the mailing list, which is also why I did not respond to their v1
patch series in a timely manner. Therefore, I would really appreciate
it if everyone could help review the v3 series and point out any
additional fixes or feature support that I may have missed.

I also really appreciate everyone for always helping to bring us
together and keep the discussions aligned.
Thanks

> Thanks,
> drew
