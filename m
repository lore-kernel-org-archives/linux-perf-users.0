Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792684853;
	b=D6cAnT2A+1Ax9J6ytEIiKYOHY/08WGgR+LfsiMHhsClMwxwLvrIAMFE80QtsJMePd35m
	 kqCtLdmxeX0n2e0SePQXnExYSvaSjLuHzcbYxIi7vf16TUrS9XIcBlq48/LG3Lkt+cQkg
	 O3SsLVeBtz0sQFF26dcFikEghgQ31xYWs9OnbAdi/y4TfBwO5MF1mqnigb7JtXQEcfkdr
	 1BXqASzmocrtcYHk9vIJZcnpUJS+AnDko4xI687BkzKDX+LOXbdVPkg/KjGu5KQwSwY5l
	 RfkL99RJ67chB5emE3Qs0UhhsjSkCByO3DSI23aM2m5WH7rOxBTOeD5Va+ekteJLjBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684853;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Mk3GH3Ng2PrOezdHtaigQomG0NHLOTtcMUPVoA3YW2Q=;
	b=aMDbYXRj++m7H1uv0S9WjaXSgePAj0V3TvrmFYFqUwdQHUHCovRdbzJPefYl3efgTFxg
	 j3BhOheK+zJ016bbXaX7SY/+vEbS7omWUQQ9PcLzNuC87qf3zZpdQbrniQ+xzJvqOQ2jj
	 isyXrD+EPoXS4NG/KWEQJplRr+y1vNGsM0Oc/dM3wa2c2/U6wd4pKOOSt4cA5i27dSAFW
	 LgX9ox7TfwPL0+ABkVNvQ9JFd40EID0r8WS/xL8/O5HS6HL14L1fH5KCDcC5ErMcxmbon
	 ce4BEnN5qQRhPapOVHK051vxw5lwHjSgEA+SYCBcXzshDlLHPWkEsK/DAsFlsWXF5lg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=wcPHXCUC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866F3606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 16:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 866F3606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=wcPHXCUC
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5337fa12431so342251cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 09:00:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792684852; cv=none;
        d=google.com; s=arc-20260327;
        b=KvPXREB09ZAItWkc+Wt8Ysd+Z4Uou2l/5alUk57NGvW1Rs/VoUL7pM2GZC35mkrCpd
         QK8PQc/F/kPJyfxqdzhb0j2S6lhVnDkmI4Cz2Z47R9tXyyLos91qB0nc7PR1ZXje+M6X
         OMyl9pyah0J21UO3eDa5kL3XEIcvFh42E0KOWnJqq4f3z7LpNib54xJu38y0/twuKVKo
         teKJGvKJew9NCQlG+Aj8cJCUq5HVzQlJ4rff9ChkUynDZcCkW4Dmcp4R6rtlCbubAaBK
         MWHTmSs6N5oBsubU3r7Vq8IEsG/y6OjlDTigOnCIU6XyVdKSZMLnPo4G35ZDiiEtvjK2
         U+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mk3GH3Ng2PrOezdHtaigQomG0NHLOTtcMUPVoA3YW2Q=;
        fh=TOl/La0l8LkvQ+arM6Ti2gV73+LbeHHGxYwLG5Y1lwg=;
        b=RvyYeAY5lVgYo7E5L2eFVbvV79zT0bbc8dVjJgOpaYnkjMeHjkva5jvDL72q/cuN8j
         MvocGTEUQ2z0Sslu3Ll4bJSYiPzqWRv683pX03JGqAgjaUkD+1FWbrcQ9Ln7uVn8UqEa
         yUq1G2V0VIdYjDI/YWtFOiRB0qLV0EihbQxV79NOn7uvc6X+MP/ywzFpmGKuyT0Rcdu0
         knjgGXQvP0cOH9zUW2fhqznN9yzZgx1M9kVlkMS2iAqwS5Asbq8AfIG06e5fz3ckfGL0
         nqR+sgAtJ5TMJLUwcca3XjZk0VxdX8G1iLubvP6qU9ONrnjGnmpDDvtImUFgvswgYWU8
         JlTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792684852; x=1793289652; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mk3GH3Ng2PrOezdHtaigQomG0NHLOTtcMUPVoA3YW2Q=;
        b=wcPHXCUCvSkXxZZ7WS6Rpw7hKROhm1IgP90r2hOA8IKeEPB107jlnEdXttjG9t0Z+Z
         17Uk2+OLg4RxdvYtIfWj0cawSZaM/3NM16eOobG4ZFqeEvNu8gR32SC+sd+7liDxD6/R
         qQaAgKATAd3TiLggDKUxH53zuBp/mT1Ui+z+3Xjhw/iQtOViLjZaWSuxGT6NrHDpDD5Q
         mpzD9vVSM5FotapjaaoV9zjxRDVlnVUwRopzTV5zKFZSY/UjnqHFGVMUSebxT9v4Axkd
         hKtf85ZjpC9moHzzCZAnQAsZdSwz9RgovSzxkWbuIbcD0CdEzvW52oSufOUAKJyyrF/9
         cB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684852; x=1793289652;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mk3GH3Ng2PrOezdHtaigQomG0NHLOTtcMUPVoA3YW2Q=;
        b=RqeTd1KxDiRXzgpZNLdmNwKsLgzlIFM0OTpyP4JDHBWCEQqzdOiJV8eaYixnViGOih
         AJu6GMNsF4f+ydF4FDb6d4IRyYEDjd/QdpR3yGWUbLIPKduFBl8duAnx4b/zerpFaEvi
         uZ9ETh+GhdMTwVTE3xnCJhdoIUT7wCwwumsj+nCP/Fc/u7J3Gb9KSeyozoyltlYd35jo
         3F+RodCZrCAO+PfoQKpB0Elw7HwsbNBeQ4kYbSIrVVrX8S7M96Znsy7HjiWknHujfRU9
         uTVVG7lrugU+AkulmZ6sQZhLfNxEqoHAiyPUvHzhxl1Uj4m1JkYlL0oUcvMk/JDlidiv
         nZBQ==
X-Forwarded-Encrypted: i=1; AKwUvBytfin2+9SxDeBYD28anWeirHJO49oEpfuazRi3RbemnU9vN9L1Lp3CvEmZGEQQylJUGIhGGfquJir8Co/zcO43@vger.kernel.org
X-Gm-Message-State: AFq9FYKg9vp8B2YyK6+1kgMQ2ESd/RvPvfqcCtrExWK3xsOcjMPd7goW
	fVPzsGoTCoYS4Op49ljG6Dl6dEFZtWK+qzxlKOkIC3avwUrwhgVDXJS8Enc/L8XMBXnMmq9+UnY
	RZ+tH3hr29fkmS12AhW/y1cJKUmUX8Iy76DrXZLcW
X-Gm-Gg: AYBFou1aS4uiDehxW7MEe5i0kkioE/pAaN5dlGvgY5s8Js0IJ4X/rVVWaRtFq2mfsFc
	wq7OuvRF4BCvj8vUWauc7HOiPL2PKAWD+AekrmCIyMW3OuVk0S928C0LX/NU3BjpvHmRwkdQfxH
	6cPGbrlUcrfMRcFF4DzLRdDaAfPztYyfH4y5jIZfGG4/+S7HzYndxdqK+ieXxFY4XRQU6KqbNm2
	iihmAeYDVA/u+9Je+SCCZPnI3Q8imXTcLjcDcQgIxgrDpLLwZo5vJEef8IQhUaIOL/bPs37CZXT
	JawPMIvKiMZYOwIn5ERTh3zeeSVDife2RK8P3qF/YeQnee/j7GTyD3pSUSHvO3M1q7LMQDXw2Oj
	bYmeMcs1K7ROm65JYGom0CnxVPZfY5TKbfd96Ak/7tNNCz5+8Wj8xNlzafWDpOOC61o8=
X-Received: by 2002:a05:622a:1801:b0:536:35e0:4f97 with SMTP id
 d75a77b69052e-536b0631604mr19791391cf.11.1792684849952; Thu, 22 Oct 2026
 09:00:49 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260929025345.88829-1-irogers@google.com> <20261012234724.721224-1-irogers@google.com>
 <as_1Jr1h4qFF_2Jj@google.com> <atYLkAOAGkg1dyIX@x2>
In-Reply-To: <atYLkAOAGkg1dyIX@x2>
From: Ian Rogers <irogers@google.com>
Date: Thu, 22 Oct 2026 09:00:37 -0700
X-Gm-Features: AclHuK-uJH4YZWfjtxaoJ1MMQZSmKk9LsolQziPKPCYRQKJgJS7vz0QuFThVjWc
Message-ID: <CAP-5=fUMGe3x3OnJ4nf+KrXHdZRoxfRjVyUr1AgZuZQb11gZKw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] perf test: Per-test timeouts, JUnit XML
 compliance, and snippet improvements
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 5:22=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Oct 14, 2026 at 02:33:26PM -0700, Namhyung Kim wrote:
> > On Mon, Oct 12, 2026 at 04:47:21PM -0700, Ian Rogers wrote:
> > > Ian Rogers (3):
> > >   perf test: Add per-test timeout support
> > >   perf test: Improve JUnit XML schema compliance and completeness
>
> Both are failing to apply to perf-tools-next, I'm pushing what I have
> (with 3/3) to tmp.perf-tools-next now.
>
> > >   perf test: Avoid stack trace noise in verbose=3D1 failure snippets
>
> Applied.
>
> > Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks Namhyung and Arnaldo! I'll rebase and send a v5 series.

Ian
