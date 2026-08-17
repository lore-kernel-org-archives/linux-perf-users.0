Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8C22475F7
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 07:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952816; cv=pass; b=AZTulq2etySgpeA3FzalnJ33HKMNfznUaL5kltYOmJJcCFa+lHFzh18K3jqBjbXRa+EQvWSNaS2YHAu/Cgw7aUoneSV2sXVkpMHLRQm30tKaEWIQ5B42m2BSRUDycAqfpNGlhnuHU4fhOyKyXHCEryvuak2KUfTPmVwu1mpfuw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952816; c=relaxed/simple;
	bh=lz7UJVJWoWy2wE7hc0CFyPVX5/AZ2HsTSf2ypZMOWxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7uf8AuIMeqPzpH8Hf1GOI5uojiENevHE4z5hw50rBIhNe1pXE3oUO+CeFTgLmroj9dQfVwYI6qvnUm2lCDG1f1b/JrjLwKFdyquWgGtpRD5Y70IepTsceGXErtsngXsUcfBtaxbUi0SOHNcF9jrsI4ZqL1rnOwqLswzz31BUxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D19DWPMo; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D19DWPMo"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c01c79467so676761cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 00:46:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786952813; cv=none;
        d=google.com; s=arc-20260327;
        b=Rbu3NrnB0uc65PJk422CLa8Y1VXnsbXOsex3hCwBKpwwcu0cbJaz2rd7Df6BQK4cD2
         6mwZlzcqT6/6+XRw9TKKYqIeHqp+Vins58QhNUwGBkglBC7o0kDpZGYEAUMhN21nQZrf
         acjhYcqhAoNxjji4Qd6M5WeftomRqKjyChvojJdRFxUEsNNza7ZIk5G+bxmnWWgSF8b5
         U+Wq7JZZtg+kDWt6e2QOxsBsPb34nmMJz0h3r6tECvk/gNy1A7XpWeXTIJKGNMgsbILK
         ML3yoXjuhJ7TITTP+DMuR30Ysq57YDPs0QBYLZa0fXm1cI6BwJSxbyGEXJjGZq4Lqrs/
         BAHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lz7UJVJWoWy2wE7hc0CFyPVX5/AZ2HsTSf2ypZMOWxI=;
        fh=cbibG8E3RlcYHGW8uSOjVy7wpdiVWf24EjF/RUAWZGw=;
        b=OWDjN0fLZdVK4p1B1xrFA0cHj6pQQrI6vkLc6hIKmtbZuqxwd0XsZRanrOLAD1rBT/
         QzR/shsuBeEUcaKv2NaqDn9evWiSP6OiTKDYZCU76KpGdrXEQlkCRVAylND+YXAeIsUZ
         183OjO9nrU/CEdHQmaelbQQQ95lml+orCiuUn0uzgWgNPbBkjvbtTTkgNpCvrZjk/8pl
         mmN8nY83xXg4xWtS+P4DJSZ0Ke22YqCPR6wyPBEDWDU7c9Py4C+OQImkw1s7DsX+qNCI
         yHxxCX557FWit7lowFLJH+TUZBw1aQK2NF77SxVh1KQaFENyRN3mnWrp4KeRCmvAEc4X
         BrNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786952813; x=1787557613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lz7UJVJWoWy2wE7hc0CFyPVX5/AZ2HsTSf2ypZMOWxI=;
        b=D19DWPMoCckGghKqGHV2Q89of5EXXCH8STEJZL0qLZ37DlFTbQlZ4eh4H6NqXAADTb
         sAO+i/i1VBCaME9xrW0cOeAMUxCQzLPcIH1m92Vk2hKwkK5Cr8kG15e83fEDgvPYYWzo
         eqIr18Z06BOnF1L/qg3uDR50IKaUNLFlJMO6kkSU9U7c1DH+KCnGgWDwFUyqxQi1XIfy
         kY9yRTAJum5MnFQ4vRuMX+udsvml2tmnrq/Ls6NZx67I159756Lh8QU2WIwtXF/dUsJR
         5anC71chA2FmCfvPBBo+C8UsZDaazXcBiK1neYNinjfTJRXK2+HCZwKipGDa+rpM0TXj
         t0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786952813; x=1787557613;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lz7UJVJWoWy2wE7hc0CFyPVX5/AZ2HsTSf2ypZMOWxI=;
        b=bBss1gNXb8geO2HjZlYBaFvo7pIVuiQgH/pWz+wIixaJw5AMDAcRI4Aak5gtxcfKgW
         v+JVl751bso38fBUc5BeEIjHEXf/IUaLO7KRrVjY3nUYDkh8KHe+bWBZjnJ9fpxKjV/J
         neq4sn373sC94YxZ9BoUmvZhm0sBtF9Vwt3yZLElZvq86EzxY7i1AJ6rZBMwv93as06g
         Um3ii6C5vPEgEwpOd5rtwUpZaaZHme+XW9E28TdLjtA6axPZQ+dav37DT6zjakvombFz
         lyB+IjXX6TqqUxCOnHV5xhdmJ/PNWntOHHmo+Kqtj36de9s+rXYpy7UQGcyNWZZqkVuA
         gxbA==
X-Forwarded-Encrypted: i=1; AHgh+Rp2J+Ofm3UiqKiC8faxwlEzWCQ3EJNOUhVprnSwVnBeJJqLc+AqKxH5NjxWZzMNaUbAAP0s5Y1r9ZKXZTnbLcPm@vger.kernel.org
X-Gm-Message-State: AOJu0YxLvHZkAUxxa6MDXgwDNUMLeE0ycxwNf2Pqgpl+nBiOfG+Ev3O+
	QS6eYq1cuqRq+oi/x0nqfVNB96WbCI3yjIg0nvogRu8ckcnWPawRGaAc2FYs57wnc7momuJLN6o
	wDB2wMwnqI/HkNxGFAdNmS3n7+M+04XCinIeNt0XL
X-Gm-Gg: AR+sD13QHBpVJ6W9UtbnUy0jXdxR8rwLvP7g2rJpajz8x1NdlqPDqAZnewToNQ65UQN
	kDe1G4oevFPtCCAAbHdUctNTzakRzyeRag26dr7LryAm75q/mgKAdA3+3AcoOPAM9Y89aFHstnC
	6a7PgTOYQ0H9mBm10E6mwa9dXHGAYRCczHu7xFPsw1eX3Ytl4JLQNFxtFghZ1FGzWWYnodbDvoQ
	GnDBi29MGmhyhuZ7IWqnh8HT97Ub+ifswHqDNUaWJby6jFsrxy0+AXQkPLRm5j/53rTB9ddCa9X
	CSZtEyEM6G65fhnmch5sZy0B+ea/pYFAj/HjTtjDNnN/+g==
X-Received: by 2002:a05:622a:120d:b0:51c:ca9:3d15 with SMTP id
 d75a77b69052e-52db093ef72mr8236741cf.12.1786952812842; Mon, 17 Aug 2026
 00:46:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815082048.4043217-1-irogers@google.com> <20260815172712.50119-1-irogers@google.com>
 <4998d0ca-eeb0-4b04-b3ac-a1f97c1829f2@kernel.org> <CAP-5=fVffrRgO4OM6u=JTEUwBY0np+fUExqOpbiYU1JgyMr7Rw@mail.gmail.com>
 <7cc71fbf-425e-4047-94c5-3f06d3ed8905@kernel.org>
In-Reply-To: <7cc71fbf-425e-4047-94c5-3f06d3ed8905@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Aug 2026 00:46:41 -0700
X-Gm-Features: AcwNN1WuYOhNid9ghYjSUIFLSR0oHbLNq9UQxrihJM05AZi4ux_k8Z5V-9XdhW8
Message-ID: <CAP-5=fW7yQmH+4+x5QCqr2vO_MNSYuPW4T8X8qTns=GitOUN8w@mail.gmail.com>
Subject: Re: [PATCH v13 0/3] perf: Add Raspberry Pi AXI PMU driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: florian.fainelli@broadcom.com, linux-perf-users@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, pbrobinson@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 12:26=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 17/08/2026 08:57, Ian Rogers wrote:
> > On Sun, Aug 16, 2026 at 11:20=E2=80=AFPM Krzysztof Kozlowski <krzk@kern=
el.org> wrote:
> >>
> >> On 15/08/2026 19:27, Ian Rogers wrote:
> >>> Motivation & Background
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >>> Currently, Linux lacks a standard perf-API compatible driver for the
> >>> Broadcom AXI performance counter blocks on Raspberry Pi platforms. Pr=
ior
> >>> out-of-tree vendor solutions relied on custom debugfs nodes and ad-ho=
c
> >>> kthreads, preventing integration with standard Linux perf tooling (`p=
erf stat`,
> >>> `perf list`, etc.).
> >>>
> >>
> >> Slow down!
> >>
> >> One version per 24h in normal cycle, not 13 patchsets in two days! (an=
d
> >> even rarer during the merge window)
> >
> > I'm familiar with perf-tools which was set up to follow BPF's example,
> > both have -next repos. The -next repos merge into linux-next for
> > testing. I agree that cherry-picking shouldn't be done straight into a
> > pull request to Linus. Is there a principle against using -next and
> > linux-next?
>
> How is this relevant? I don't think you read my comment.

I think I addressed all the points in your email. The -next
development is relevant because it directly addresses your point about
not sending emails during a merge window. Except when the -next branch
is becoming the main branch, merging patches at will is acceptable and
you also benefit from the linux-next testing. Not sending patches 5
times a year during the two-week merge window, it is nice to think
that this timetable fits everybody.

Thanks,
Ian

> Best regards,
> Krzysztof
