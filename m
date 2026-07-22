Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A155B175A79
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 23:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784763011; cv=none; b=X285GXMuwFsSj6rmp0jl4J9XX3yw8BpOjK6EnhL3g2741Sp65lk2fDoDMVvY/3evsFsqDx8mLPBFl4OvZF3wXvS2fzIKi2jkEtcgDtw5IX/ABoOxjwp5ll6R115eu+ytA+fO6ruBh1Pad18AgwZ4Y7Ig9OrjE5zjapQ5Y5sbAGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784763011; c=relaxed/simple;
	bh=GDy18Suyu/XOvZ/DGW5GlcqYZDHFbKKK6g/UZV+3fL4=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=M+iqCQTOa5Gy8OFlvoQAs+NojCG/Bz5CVrA9apMW1xZ/h/xvSLpYikmTAyoWUdkaAxJ1jq9hI3q8b648+TT4/O3r72Ik/aC1jhgfs0HfUrC1qcghzYuRL598u/yJec0XT6OLlJt768jT1GQiXoH/ac28T+ygF6IaIIvLF6LCZtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q2dcbOtq; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2dcbOtq"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-971a7a7061bso12848241.1
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 16:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784763009; x=1785367809; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K4tfl6txiUD85Nea9WxjY1Jry32vVpQwp8K3x8BssLU=;
        b=q2dcbOtqo5HBkGSzda5gV38E7cWfZvbKuSBCdjDepYyBvjrnpEjAr8T07GYkRDLopw
         RLpkTcqJHFDjxfP6yHReEtQma5yMqfNxQLpsHZEzsF9XL/MtZCK/wNXKOVIMpRcCrATt
         NnO0pGoWjUfpWu9nVnaVUGT5cMg8Qo92cHwOKZ5pMXLpGP4CjulIW0mEkVckoak0NX7a
         fJvneSruX3OMJ1bkgINsP3MGxo9zoVKiM/Nmoc3VQqwRcPqeH7a35Fv6rTJSy6uE8ghP
         DPJRG+M8mLyOu6gKDjvSvmennV0U8t6Kyrdk3wXzR/an36p1fiEGT5rjBKGMEdZbJNx0
         Q+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784763009; x=1785367809;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K4tfl6txiUD85Nea9WxjY1Jry32vVpQwp8K3x8BssLU=;
        b=lfv+Y21oHD7DiHbHTzMDwhWbSyLJIi0aN5z2aDbOV/LQ58aB6HK/LDTaMi5LsnF8N6
         STWjNSgRR/feYTlXInQCHZ+ECvx59jHCMUzQSso/VMxFc7xD7fdkAeLJj6TD88x6FMmN
         5G14qO4SN6hyNdDYBKfJb196pm/uaxSbuk+tAlV7O6bpYFCcE6gZfFxZGmfKDFTm6yrT
         Tsk1ELOO9IGHdIHIVKBEI7e73t4c3JAWKy12Lug1g5zUqWUqavwPgy3a0Irrko70F4IZ
         lVt4uXBbAMOeHwUmG44+ir3CiKMWX35MQuw1rlqpCsxrGBEI6IzpqcpC42O3EQy/pFrq
         6uuw==
X-Forwarded-Encrypted: i=1; AHgh+RqJbC5LOGRfLipduJlnq2G+S7K+sEhqahVpy+9g9a5I9fQy/x7oBmaFMgPx03/+2M9USHR4laMcJwnexhH9bJnu@vger.kernel.org
X-Gm-Message-State: AOJu0YyiOUI9ZX2E22jdXIsjLSsawiKqiiyjSwB/oCWayCtrhV5yFBta
	on6Dw4PpWmOhOQ6q29cKIxQ7MtNRdW85MdEakOJnj0W5dAVzrAnPC37j9+93Hw==
X-Gm-Gg: AR+sD12m1aGyssW4XpZej1exE8c0xjg/ZNqHnaVmoATcNVIgzHl490Svxfbg5amzccv
	TbaJQtTAksFlKvDnyj9IVlMWmEAxZ2aNx1vt7E5AYA13vOCsR5EyVqiWSedXyNiilnE5R8EFVFC
	a7nwc96O3NM8M/MhhqmRVO8rsWjRNdPT2GyVJ3uyyFsbXAjaDFKzzhkZHiKCZRpph2W5G2jV6oa
	xRXqfcIu/FI+XOb7ygh4zGUxSjpKSGxhLxlguQh9hUML+ZZhnb+Y0cpIpC2Fs6mRIbja/Xa9nk4
	6tF4lCttj3ld0MjnI4Jx0HmtC1ZiPLWdwF+TMEtM38Y7t6wfapl/8v12qFXJqm/sq5NyPvk2D9+
	pnlOG6LxqsBOiJPHlbItBtGHVqp4iuHVDIHZKQAxQNhFUcuDMe+l+gLAGielOBxsrLHvZ2VpV78
	kA5ni7EV1DbBu5ghQKdj4=
X-Received: by 2002:a05:6102:3f87:b0:74a:9ac9:792c with SMTP id ada2fe7eead31-74d5e3cb58dmr267883137.12.1784763009482;
        Wed, 22 Jul 2026 16:30:09 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2804:2bf0:60e7:ae00:62ab:67e4:f6f3:271f])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9774407726dsm3367442241.5.2026.07.22.16.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 16:30:08 -0700 (PDT)
Date: Wed, 22 Jul 2026 20:30:04 -0300
From: Arnaldo Melo <arnaldo.melo@gmail.com>
To: Ian Rogers <irogers@google.com>,
 linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: Getting positive, and not just negative, Sashiko reviews
User-Agent: Thunderbird for Android
In-Reply-To: <CAP-5=fVpPktV2Y8XYxOMpZuY1oYQMwxmwqtaphRG4i6qkSVZyw@mail.gmail.com>
References: <CAP-5=fVpPktV2Y8XYxOMpZuY1oYQMwxmwqtaphRG4i6qkSVZyw@mail.gmail.com>
Message-ID: <E034E1D9-D2EA-428C-AD7C-A8F40B2E0E52@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On July 22, 2026 7:19:33 PM GMT-03:00, Ian Rogers <irogers@google=2Ecom> w=
rote:
>Hi,
>
>I wanted to give a heads up=2E I sent out a 1 line email policy change
>for linux-perf-users to get positive Sashiko reviews, not just
>negative ones:
>https://github=2Ecom/sashiko-dev/sashiko/pull/363
>Please comment/complain if this upsets you and I can abandon the PR=2E

And it's merged upstream already, let's see how it goes, I think it may be=
 a good move=2E=20

The maintainers summit list discussion (public) touches lots of aspects ab=
out Sashiko collaboration, we need to take its reviews with a grain of salt=
, but my experience so far is very positive, I've been using it locally for=
 perf and pahole development, in a loop with Claude code, with very good re=
sults=2E

- Arnaldo 
