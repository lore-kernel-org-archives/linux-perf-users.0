Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBDF35203B
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293608; cv=pass; b=UekJ5NKIi3fkjHXq5z9a5PI/5xgMNj2SqJtwShlbPWXP7i0HRV/MQh39IOrLMGG9845dwUN+Ch+zybIO9dn5amkIbt6Dlx8qpsFRbZj097PT4lh5GW0a3+zYkDf4YZ69j+yFeXbEFyQMfgJEsYjRtVsBpwX4j/lNq25WUWDmunQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293608; c=relaxed/simple;
	bh=1SwpQjH3OHtcdgpNQEZOu4Hsoc6Reu7uGXIXrLgWrKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kr+eiu83Ae/uMZzV1dLhZ5zG3Db4n+8MxsGJzhk85DWh/j+rccpau9MfyqfHYw8MXMNi5w/A2+2m1DY7eXlTTJKfw13XpkQ4xZT1KwNKHd/fq8/6mfTA60mxOlbkKNQvpwngpxVwlU2DE78LxsexwtAn+eVmHrRYW8xDbqaYXp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EHKmJNQ9; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EHKmJNQ9"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so385ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 09:13:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779293607; cv=none;
        d=google.com; s=arc-20240605;
        b=Jm3jVt4sQsaH7Ms0DZHsjhyDRZZWQkbbQdzxk3tdWm9Wuz4MCKtdTTeOHsuyXt3dPn
         NX4R96hO2h69BxRU7aBNq6CqwZeZpZvi3xubHpcos8ovBBqWh1L/JOm0n3PVFQHB2dtT
         Aups+aKfUA1XyzeIPxAJBPPf2tLUM2phzhx1N/xM6xl3++CoGe55yQRnFrBAUmvzvfH8
         RYFv8gaRe2IKUcKeIKdODbwdlaVjwPkUlW9suBevrM0YB9z9pd05E8FUFxWd98F+z2IY
         GpccR0pgS3O8HDNG300nJhR2MfrWiG4DK9uBYuLNtpYeNhYp08VCAzW0RiKVeWH3cVEW
         USxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1SwpQjH3OHtcdgpNQEZOu4Hsoc6Reu7uGXIXrLgWrKc=;
        fh=mL+goVUPynMTAj0c2N3jYEfa3+4LCwAoZsnoMlLPkZY=;
        b=Ut7FqChFxyUnHX0seKU+PRUay3vdt9CcAVddlvDIdj6egxFx9bQ49KBvXxOaeU640r
         lv5pvZWyM0GlOamVVaOrJbgA/Ch3WIrNidJXsso13RLKYxrpMvoj04bswOl1Y69SYGiD
         j68LxKmdSG/nJ+wq2Fjgm79/EeyjxZSoyEZ+tmoSp8HqvrnW2hoRYRMPdpWpdkXuVNnN
         Q/NpbDFaUxMHRtV0kUadZWfR8MHS7st1uG0j9u2+lR0IrVGJ2b3uHcCJzWcytaL83khD
         tvM38Hzf6G5TaMSft7SuIWp4mWjYuHJd1NjA6jbJ84fc+3j8QJC6J89jNoQtTYtsi1wU
         yGmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779293607; x=1779898407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SwpQjH3OHtcdgpNQEZOu4Hsoc6Reu7uGXIXrLgWrKc=;
        b=EHKmJNQ90NNJTLJAjVQS1lErZCT/2mMufXz/0vvnOuA8XbAlmyD1p3MpFk2XpgoCCx
         7dSKJpOaEBKenwTYprMmVI4Mlf3xKC+K4uWroOX6KkVdPejm3LL712+5UafgSnn0Ykp5
         458ZfxF5wz+fcAwkMItJEz3VJmJcKO1+Zr6de6n2omVoydc3VDC0kpvfi9GcCL7HXmr6
         d7WF/SzHpLMaczI0eP77/y7cQ8ev51WtVIqjOf52j4IoI9aeJyDFeiOmCy9EmeNG4yz9
         gW+27kU6dy/HCI+PbAFHH7ab2YazIHEYn9uHqSZKY3dWeAKc9/uugo4kdriLFilJTfCy
         Emfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779293607; x=1779898407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1SwpQjH3OHtcdgpNQEZOu4Hsoc6Reu7uGXIXrLgWrKc=;
        b=ZUNW5AVaOOxmq8CWDlKZfiNTr/jBFR8afeQ/yVzRf+Rf5xvfL5qkPZlup32msmSzvs
         fB8m2Iau5V4Yma+fdN3hLLw9n8jk7BrBup6fO2+oK5diAkhYPwzuJM1eDdteZTvdm+6l
         NkFM140CwxNUoPki7wBP5uFo8SmWiqp3qE5hgogGY/4YPCxFTnbr8ZsdDoyGux6w8Byh
         JUSbYK+o1F6JAic8oYya8Y4eiVkj/omc/ZSpRLn8JaXjl6xeZ79Uymi6t1fsytWKOePc
         zMhtrJs6JZCO6Hi6uPK54VlqvgE07Ol4JlR1d/QupadFCM/uQrD4nxI6nrrUV80Gp+Ch
         Blww==
X-Forwarded-Encrypted: i=1; AFNElJ/FYJmLGWWKc6pBCNspqSO83XMR3PWj6yZJ/+H2l1/s17wvR8DWIMwqrBMJTHTgRCq0WfKOGweYh173j0IFb2pe@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1YnXLlpmdaf7ljj6T/fu0CMmiiYzjfe0uCl64fXEzUhDs/NJ6
	Fm8huzkQ2g3dMciRbpzGdiiVAvWNit51W6ZYoaHR52KXitHeFLk7JPHGpX2bkw2fdvzpzF7wHMZ
	Nuc9f4YCN6BzK2aZWJpOZ+2sSg+vgn3q3B4uPTSyTuxeUN08ux5Mwna7A
X-Gm-Gg: Acq92OGH8smgS+O5fZoNmM1hLYtLFWtu1os1QFNik7PmGMWS58yLqju+f5Sdn0EHffC
	opaqoVWk2vZ9M/3iMvi1XYCP8/OVvAotjwLMFKkUk86xRRrdh53EVT9Hwll0IfCAl4l90bnPL9X
	oapt3xHxM5A34YIzGyGuiCEoU2kvshOcFnJix6onfJDCtL3XioIViTwJZW+jSSvGfD1N+HKnBXW
	d66KbUnphyQC0bLIlzv5MeCCEOixiYtkxplQ+FQRc0UamsHpaJSRZdjpUEfhQYIg1gTRLWM5H5/
	hbJKr7HutnNZFghGZ0YpQUWC+byXP4HYQRwDhYC6EVD1DlhB
X-Received: by 2002:a17:903:11c8:b0:2bd:907:2ce5 with SMTP id
 d9443c01a7336-2bdb32c2845mr10525875ad.7.1779293606168; Wed, 20 May 2026
 09:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512194710.162215-1-mjeanson@efficios.com>
 <CAP-5=fXMtbO=7JMg2YvhQNbqOEFH_ze=8EifYM7bDfR945=KHA@mail.gmail.com>
 <e6d88ec4-c6fa-473c-ae70-071bb6f040c1@efficios.com> <CAP-5=fVnNyScv=fWy++iucCWWe8G7jcEn=AiDbLEV6PaeBooHQ@mail.gmail.com>
In-Reply-To: <CAP-5=fVnNyScv=fWy++iucCWWe8G7jcEn=AiDbLEV6PaeBooHQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 May 2026 09:13:14 -0700
X-Gm-Features: AVHnY4LCGygKnGFbvw6_Aa3ZatIoAm8JmsacUiIxY5fDM-Ix8RQMoGfaljZmz-U
Message-ID: <CAP-5=fX5QpRcVhnZCd230FQWsJ8KHbCrv6y_47vcrBK0fhWWxA@mail.gmail.com>
Subject: Re: [PATCH] perf data ctf: replace libbabeltrace with babeltrace2-ctf-writer
To: Michael Jeanson <mjeanson@efficios.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Derek Foreman <derek.foreman@collabora.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 9:06=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
> On Wed, May 13, 2026 at 7:14=E2=80=AFAM Michael Jeanson <mjeanson@efficio=
s.com> wrote:
> > On 2026-05-12 17:54, Ian Rogers wrote:
> > > This is cool, I'm surprised at how non-invasive the change is. I'd
> > > done a similar thing but keeping both babeltrace 1 and 2. I'll post m=
y
> > > WIP in reply just as a heads up, but I have to do much more heavy
> > > engineering.
> >
> > I think I can rework this to try babeltrace2-ctf-writer first and fall
> > back on libbabeltrace1. The change is non-invasive because
> > bt2-ctf-writer is basically just a compat API for the ctf-writer of bt1
> > but it doesn't expose any of the new features of bt2.
> >
> > Your WIP patch that uses the proper libbabeltrace2 API is definitely th=
e
> > way to go for the long term. In the meantime would you like a v2 of thi=
s
> > patch?
>
> We have a problem with the perf tool in that it carries too much
> baggage due to its library dependencies, so I'd prefer we stick with
> v2 support and your cleaner/simpler patch. I'm also hugely
> appreciative of the work you've put in! I'm too busy to review my own
> work right now, and cleaning this up ASAP offers an advantage.
...
>
> * We support libbfd although libbfd is GPLv3 and license incompatible
> with perf, which is mainly GPLv2. We carry around libunwind support
> but that project appears unmaintained. We have LLVM support but the
> LLVM dependency is huge in terms of size and dependencies it brings
> in, so people avoid building with it, etc.

What's the plan here? I'd prefer to carry the v1 patch, ie let's lose
libbabeltrace (version 1) as a dependency.

Thanks,
Ian
