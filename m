Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795688402;
	b=LiAFX+PjsM1VhBj2urZVsVyoEl1gTbRFd7XOB9JRbGVf6GJxmCPWBRqS+V/PUcGG6jjX
	 eQn6JqCxc9a0z1vm2UrjgQgGuGILunP/EYEU8aiqlw/ch5wGkZpU8CNulgRbrzOBI1kDO
	 cGtoIOtFtTYRhLEvMIdw1v/Qr0PbVmwy8M8fhqKP2DDirPcDQXxsPGZ0ovgC4Qi+TUY3D
	 EaFRL7BwekgPAuZxzSLv1lgTw8jL+03nyfF+zEClG/3b3q3FyzbwXXo3TudUL9cGKoWTM
	 jJ+k9wA0DPgWl1DusPQmyzJEgHqmb6ijOgAkSO+ICyeBH7OQCgNU/yWMxA6E6CjsMNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795688402;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=7Su0Jnoa9T1bK2wCUvargtTv86FSfHcn2VXjpGqEuo8=;
	b=MHShexkgEJvtmmRQHAUcjugxaHKOZxTZlBB8L6ypw8dSVa3mf+R2RJkULEamK0Y/+kqc
	 nflgVepoaWJ0smu6hkgHZWj07mh9zF5tT5eGPiHE9jdhs1xH2fVTYujkMJJhnXemT25ea
	 9rPmZ4hH0wYtxL9H70rcc2/YydkIlTGpmj20PoZ7MuEP0grtlYYM9P2t9BuhOaINRNH5I
	 OQMtNH9czRsh7Ok0b/sbCDz0F9D5wB7KsBliGRj0Gz80h1w9CHDZyyCR/nL3FgIGOPMID
	 Mjd5ibBmXQXy8Or41gsoqI4/XSDbIDiTAPqp8QqRG9YZIk0KScH7A3ANxYj7Jhviw0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TU2dwGTv;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EFE606A321
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Nov 2026 10:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70EFE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TU2dwGTv
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso14540616eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Nov 2026 02:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795688402; x=1796293202; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7Su0Jnoa9T1bK2wCUvargtTv86FSfHcn2VXjpGqEuo8=;
        b=TU2dwGTvb9gg/JCh25yPCLvQO1qeLXogC7wjNN5y4huBKzdxQd97gfphkvEK6fFYKD
         +x8ygecqSDAbeU4X5f0oheVwA63i2iE2VrMPlHSDd9ClMmeag9SL0UfHEmWwnq5xE68o
         nWwspUnrj5H1Y6yLYJN3NcnJDhWYLMhWQJXTX8cI5DPwvHashmbZLozsJYzvLF+rPWAQ
         jaJNDJocAj15D1heRo2Ys+JLed345KtOB/p2rTv3SwMsds2P6vRzXVDXmiNA5CUBPKjk
         Mjf/347xieHWI6pqX9JyIoDywbNkz6evSKwPeNL4WYqKy2eCJp2QsIHC4E85WN4eqCBL
         WMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795688402; x=1796293202;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Su0Jnoa9T1bK2wCUvargtTv86FSfHcn2VXjpGqEuo8=;
        b=QuVUOAFgGRyu/UNT3rPZGibb6d/m7ip7HSlBB76ztWzyuRXQBv0n8MWlOUS63QxSPO
         HesVh9fLhly9WjasYIbZ9pQEFlHhlBzWrGxhZL4WKgIFtLIIIbpRnHC+acuBNyQ/iEzd
         0/Zm23uwRVCkkwo52ywPLHDFkAg2qHOit63EWff8JWe+EZ9nLc5fdS3Tl2xaG/x7Rj6T
         yrUlXY6NXlx5DGHIqRdzkbykKtevtxbqltu8iblMwktM9n38+4SIyOD5qS5zIswxXhSV
         nwAI5gsziZW2JoK0Z51Bx474JrsrSDJEVgTwyZU5Cf49CVw7oyPZnMzfLIFrtIHSnNQv
         iL4w==
X-Forwarded-Encrypted: i=1; AL+hErFabax+DR/TTkTVKKgXwVh9KFdEUkFnfKH8I2bkBaFb912Wk7ecZ0RY3T7QY3Z/GnFeAFPoAHVqWwUh9xVtXtyj@vger.kernel.org
X-Gm-Message-State: APuU4Z9OxFR8WRPVHSdWxrvxH1TFhxRlhsiig6PdHAmd/Y5SlLEzC6Ou
	nQJE82IAGGJNh9WmVRGF4Yycnlc4vSYwbJzQote5KvWT9hajO078rcJx
X-Gm-Gg: AZFdTZd9nl217yCW4E3Y2PrdFO8IbyV04NwZsOg186xRMhHLKGGMWoRXeh0OhsCrllp
	DgjoFjBfap1qHd38JWztDtiX7HfhufPQbg/6IEJW+j5ix3gOKjuhRK63VhWOWNRkQlr2Ywfk4l0
	8NaXW4idC+kuUlywpLs0ZK4p/h4d68yenp5mtipxenUOcZokTAJ/CDMEiXGvS5PqjWdZu2Zd0g+
	4rELHy53G/nMTnU7JMVRO9cDKr7QbFhA7ZvZmo1QNGABLnHGo8zU6/6rb+ielzj86SkwlfqUbAT
	7ihv1WeBagzR18IhyZG3A1Roc1QCUS20g2oM7T8EUYv6TXR6ypPcRxhf9ZR4UD8zKZ4d7LDNulT
	6qO1ZtYQ7VJhbH8w1XF1CwVWp7nl9+RdINCbbGrTflFuZ76Y/KAXxwo1iDzYDMQYylkwMf7/juE
	IBkJprjEqurNPl0vWhKaxciazYOwIDNKxxLY5Yngiy+qcBKV9tUpNSP3wab7cSL44iZEnJSV6MA
	8p2CUgfCs4Mx7y81YxkS81fjIr1PvfLSLN99g1X9qlWkZm3YJVoX87B7SPp7bEcvgWg3kZYDYkS
	yVvAwxTULhEI8M2fXA6lKeVCDQ==
X-Received: by 2002:a05:7300:cc83:b0:381:2f5d:a696 with SMTP id 5a478bee46e88-386a0ab6732mr17133269eec.34.1795688401418;
        Thu, 26 Nov 2026 02:20:01 -0800 (PST)
Received: from [127.0.1.1] ([2603:c021:8021:f000:0:1865:8c38:18fc])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567ea2cc5sm57114050eec.29.2026.11.26.02.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 02:20:00 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org, TAKANO Mitsuhiro <takano32@gmail.com>
Subject: Re: [PATCH] perf build: Replace the deprecated FileType with a helper
Date: Thu, 26 Nov 2026 10:19:59 +0000
Message-ID: <179568839930.2893535.16443681851424564423@gmail.com>
In-Reply-To: <awc1wOQYO14k1R6j@google.com>
References: <20261125173315.2359128-1-takano32@gmail.com> <awc1wOQYO14k1R6j@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: kpatch-send.py

Hi Namhyung,

thanks, I see it now: Lalit Maganti's patch of 2026-11-15

https://lore.kernel.org/r/20261115003507.1872482-1-lalitmaganti@gmail.com

replaces FileType at the same three call sites (jevents.py:1494 and :1496,
perf_json_output_lint.py:23).  It predates mine, so please drop mine and take
his.  I am not sending a v2.

My duplicate check searched for my subject and for the lines I changed; his
patch touches the same call sites but the lines read differently, so nothing
matched.  The check now also searches for the identifiers the patch removes
(FileType here), which does find his post.

Takano

