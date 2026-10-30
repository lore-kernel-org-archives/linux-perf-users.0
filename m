Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793366843;
	b=R+Z4Mrkpli7F0mq9dhaMT1LiiJe4NMWvrQjD+q1DkqHFBIfsJhV9XC0HEHA1X8QCtSP1
	 CKWTmdPf01bjPEkYxlTLdQfL7i8UY7qXB+SQzQ/kpqyAnlcEGYQa9DkEbtsABwZT9XbDB
	 A9IR9B37z9q5OhRFDOFPNvLIykcnjy15gtVXsVbnqNpxs5+jTByEWoYPku5ASXOtqfxJR
	 Esgsb/gsvfDV2R2Qr+fG+qfjSdaez85rxZgUutvRvjrZzB4llsVGXEBLztAkFCOeIGjWF
	 Rb8Pt/9tnFqjGL6nJMxKqOPNR/dsk3K/kP1JGFplAxz6yltVHJpqpNwPVjkJHiyqHjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793366843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=GrU8j6+xqAC4pU3BEEl6Hoz9aLelwf3and71b4BEia8=;
	b=iYGvlmUuWT24DFJ+SQIEmaBUjLyvJ2jrLlUevEGoZ2pYKZ0Je1/DtuX1J2wedUjSo0Pw
	 mLUxBk1N5PeyolOab8hDLsufYE2eQ3OAmGHBXuV1QunQGxkHIogxk1Z+2poyKCff+B8nK
	 srblp4YzWQ9hDkApdoZkK1Tw0RbzH8EBd/cQ6CCYf6VnP0fOF/t6Tg3lZXXweIsF75k4V
	 g8NjUvbHHB/nAYA9SquWr5MJBt5kkP1i0DbOn1v8PW6nDjplxsGtiCIk4a3eM69JWDNWg
	 YbxV3P+zTiFRRVdYLR4LbI+D/l+wnnmwCin9GbwDfK2ffRN6X4ilZSk2wjwIIDpJ5JA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uber.com;
	spf=fail smtp.mailfrom=uber.com;
	dkim=pass header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=mfLwJIw1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AAB606A31E
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 13:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2AAB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=mfLwJIw1
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-67999045530so612437d50.1
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 06:27:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793366842; cv=none;
        d=google.com; s=arc-20260327;
        b=VPqqVLfwY95pK2kDIySV5NrAabTY/0IKspb7ufjJiyynW15UJTwGlKb1XNTRFCkaWw
         5JrGlGKrLxym1yN6sDZ758nARj36pqe0seoBll3SMut+J9uYEv7nrFyeXra4Ls/ySRIi
         9ZMf0vsFMGqhS+u4wMT7RrPrdnAdK1c4P74HMullaHotjljFg6wuHWEyCDx6aWh9q+i/
         liPyvu9RRsAQQJ/4cnWOPWUAXopgTKBLDUetuLahL4mjv/Mu4oZ/UF0iODOJ8ZsKkHPJ
         bQvpq4n7uNjyM84ZU9Qeu6Ynh8+rV3TD9TaThniywfReOdWjXPhBv4Ln+TKV5rdNy8eb
         G/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GrU8j6+xqAC4pU3BEEl6Hoz9aLelwf3and71b4BEia8=;
        fh=xkiKLMVIiZhx7XzZyIQ8sgbE2HkpWz5Gnp6Z0cZnHcc=;
        b=pWMHedVrY7tg6RN6bYC5apEiLFXjYwel0T5vd2Vx769wnV5VzkewbOCNfkTAbDEY21
         uk/xIICWt8HEFx1CltfRpdJtcajIHFOYSMobNALE0udLsGrcAxjmPTy0P7S87qomsrVG
         kW3V/8yA1IXPLhocHKg0rcyy2upHgOyjApPhU1uOgZ2+YtXBBCYjTDqMtY7PT45boaeF
         675hQ19GuJmQIgiVvONkKp0kPiL6bD7VaxEXnkOTKhsJUFZvI1dU6EYQeelCtqA6V+7p
         GYw6RUyTq0haTX1/HlVABLd5uhhJsapVtX3vA5rhdXe3BOlAdDM2RMczd6Ru+vEybsjL
         IKzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1793366842; x=1793971642; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GrU8j6+xqAC4pU3BEEl6Hoz9aLelwf3and71b4BEia8=;
        b=mfLwJIw1WpoVDb7Qm/CEWyb7MKOANOTDSwnFWF4HyHAM6OB/TrZbwsHLsEwln9qScx
         /cqdI0uqOP1QP8Ce91i/MoOMZZOYPmGWBnckYr/STHq1plF6JKbUn/EyPZIDN3LTC8Mn
         Hj2a7Q1UxcuoGCyMRMXx2H1LHbhKB1rC/RmzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793366842; x=1793971642;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GrU8j6+xqAC4pU3BEEl6Hoz9aLelwf3and71b4BEia8=;
        b=tlkQFAC4MVTweA+iJcszuLLg5ukb+1Om/zMDxbOlFuGxKCUT/er4WlmRfwon9LhNMX
         WmBO+zLu97/l2o8upPll/5KHmyHCpvwZPrUsOI/LL4Rn3MGGc9339nEYWwha7csjNqjp
         le0CNnIcKOSNDtFKRCCjrn3JM8tDHxytzBT5HsL0XGdJ1C3D9JrCSShVOOY16/awjo68
         wIPcANpwbigE7/Pths6iXV/OONAAEuQY4Rr/eMv2tkpBsVRizDF3XT+lqMik7jPSylBl
         i1jscZNKPIuFGaH0RNGs38vy3JVsLg6S/BsET/B6Sy+Zl2Itn11Qq2ofDkaao5arLXXh
         vWjw==
X-Forwarded-Encrypted: i=1; AKwUvBxN63NL2juxsMFPRgbS/QPF/lKCNSpLlAThlc+Sp4KSL/COBndifVnbpwDN8zB+S6DgYUjmZRHPS3bQdUA8s+QP@vger.kernel.org
X-Gm-Message-State: AFq9FYLxP7miDUM9uzjK/I/p+iEVj2zvAoGGhdQS7NhneRnq7WpsOB0X
	FPHGFamh7YN97dNkF0AGl+ahkAlyQreRRLBZmb1qdjsPN7Xnda6Ywu2E2hRiFhvUMQshQxgFPrj
	RyZ8KiSLXnPy6ThdgyuhOv5JLF/m1sWKvBDgXie7CBA==
X-Gm-Gg: AYBFou2oBNwNLCQRChZp1NvqI1neU8QlO/NVUmbN2uhrdDrS6VA4iKqQZEzm85Z/eWp
	/VMu4Hjo4HJHaGxvgY5ah6WTnX3mxsHEzk7SrkBf1KiysVB6j2UnCnTDrmet7sYBwQUhhA4uRKs
	B8IxWoN5PfWgJjQQ781Wz/Sr1BTZB6wW1k0SOhA627G5Im20qcqHs29xxJf5Ig8PxQ8HNTtYfCZ
	nNuH95O5q1Id/VJeHrXaWibJcQfy05IB6W5IGPNxC7q8sHt7mz1MS3I2oKnrLrDCa7KURmoiDtm
	XYoD035Q7Tr/Y3WBnH0ZIEsfOx7MsKFauUpJe+uTc63iUSB9Tf6FNs8/8zWzudhnhZe+CfqOCoB
	FdGKQRFxNsiCNcfOTkgZY6dWvzY1npJAAzg0zP2E+KV1EllZSoaU6fsrIDc39uEMjBvc9IA==
X-Received: by 2002:a05:690e:190c:b0:679:b274:89a8 with SMTP id
 956f58d0204a3-67ba4e96537mr1905585d50.27.1793366841600; Fri, 30 Oct 2026
 06:27:21 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260928075237.3055101-1-irogers@google.com> <20261027231513.816148-1-irogers@google.com>
 <20261027231513.816148-10-irogers@google.com>
In-Reply-To: <20261027231513.816148-10-irogers@google.com>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Fri, 30 Oct 2026 06:27:04 -0700
X-Gm-Features: AclHuK9AYFKStnkTEp2YfN7bivnd5v_IjGJ3saQ2MjsqZIP8Gnf-VOrvu0UpqnM
Message-ID: <CA+w=M=Ruwq+GceFWMb6ig7mtqtxyRogS_UYbC0Kn3jS_oM6oqg@mail.gmail.com>
Subject: Re: [PATCH v2 09/18] perf symbol: Optimize symbol sorting with
 natural-run merge sort and binary insertion
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 27, 2026 at 4:15 PM Ian Rogers <irogers@google.com> wrote:
> + for (unsigned int k = i - 1; k > 0; k--) {
> + struct symbol *same = symbols->symbols[k - 1];
>
> + if (symbol__start(same) != symbol__start(prev) ||
> + symbol__end(same) != symbol__start(same))
> + break;
> + symbol__set_end(same, symbol__end(prev));
> + }

This changes which kallsyms alias survives. Every kallsyms symbol
starts with zero size. Before, only the last alias at an address got
an end, so symbols__fixup_duplicate() always kept that one. With this
loop every alias gets the same end, and choose_best_symbol() falls
through to its underscore and name-length rules. On x86_64, perf
record -e cpu-clock -g of a getuid/getpid loop, before and after:

0.20% [k] __x64_sys_getuid
0.20% [k] __ia32_sys_getuid

2.87% [k] __memset
2.87% [k] memset

This host has 79 kernel text addresses with more than one name. The
losing alias is deleted, so looking up __x64_sys_getuid by name fails
too. If the change is intended, it needs its own patch and a test with
alias groups. Otherwise, keeping the old "last alias wins" result would
avoid it.

Separately, __symbols__insert_sorted() shifts the tail with memmove(),
so n out-of-order inserts cost O(n^2). In a benchmark of this code,
300k random inserts took 3.4 s, where the rb-tree was O(log n) per
insert. db-export with many unique unresolved addresses would hit
that.

Thanks,
Alireza
