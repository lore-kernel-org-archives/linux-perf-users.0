Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630430;
	b=sUbsobBlEJjoPCx7m3R8Y/CN+NeSXmfNHfnEc92HLK9Lkjj+vpvAIM9B3PQe/saBTZVg
	 vv8dfxTcO374VegSYh6pWk61W6Ic9m4OxNT3OYtFigNDDr1Q7N98PhAdTx+wGATMDZmoZ
	 1Qi0pIuuvuM1QlfuciQX2qU+K0AGnDsQ/cOKNhiQzSL+gxXfjzXVA8tbUrh0hL0aWjdQy
	 2gzzvnRXFd3eZbdbra5pqwT97spZ2XeVrO/mfSFy2b0CIPNTdX9tUlhwUQLnVWfydR77v
	 M7wIv7CvZPR7BwStmTIE5RJLB7tkPaIg9ai/juBmiUwxg1Spt3QRmiVc7cBkZtIGTkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630430;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:MIME-Version:X-Received:
	 In-Reply-To:References:Message-ID:Date:Subject:From:To:Cc:
	 Content-Type;
	bh=8KCb3jyGQ/bigmlFvziRGIAlAhwF9099ubuYHNXm/ls=;
	b=ECLoosswnhnGhaIps6QmdnxaMKcouBkvvgaPnAbheXQOUAKG/+gKMymTTpUMoYnvEygU
	 RDxEzhFkGcqXAZ67CU+2ZS7CF8QSxI4sp88NS/wpGT6sEg3/RovFY+PAvYh6FJE4CJe0P
	 WaA7mgd6aU21SeO20lT5pclWYRp8KizM0k6kebuczjck7AAUY38aUKx4dE48hw8mDgjJp
	 S3SoAxCk5WFacdldIn6u39LMWi2eIesxN/unoIUp5QJ20NbwVRf+4rA1Er6t1+SV3aceM
	 1XJ2VBTBCwNchU/3+JubYrIdt3UYgYH6e+Rj4zdN+HTLCZ7W1l7V2LVzk0hyTbn/p2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XwL2dDMd;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBC6606A31E
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 18:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DBC6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XwL2dDMd
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1b238436265so3466072c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 10:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795630428; x=1796235228; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:date:message-id:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8KCb3jyGQ/bigmlFvziRGIAlAhwF9099ubuYHNXm/ls=;
        b=XwL2dDMdxOjPh99q4ez5iWWLaf9tJx/AtmO2pKfFiCzsJ3Ibas0cHzNoIbMtwP3lMm
         2P1+gdy33p5DYB7CzEfLaKB2Q0jnJIpfMoBttk1ToJ3AYC3u7IIIO7rRfH0RblTvQ5TT
         B71obICAjwtt3tPcgrEdgDiWInH1SActGSuN8hS2dObRWKDHmDWB8R+AYczXu+AU+jd7
         6GBSeq90n7vxJCTQX2Ylt6hHSneouOgbdZngVNLb0TG78ijxYYVpXPNb/FSiwUg9FGv5
         JkqFNs1ukyMy7R42tFZn6xJsaIjv0xmUU8ieAWOOrvUurIJeIB8+VYWXUKqN2KmxrvXk
         trYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795630428; x=1796235228;
        h=content-type:cc:to:from:subject:date:message-id:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8KCb3jyGQ/bigmlFvziRGIAlAhwF9099ubuYHNXm/ls=;
        b=1ITyy4DxaUTrNOoA9nqytYy+sX8h29crd6+zsRQxAl8biZck4UolDwbu4B08JME58O
         Fp4RN2Gz6A6bWckgSmvyV0ugQ6Km1k3g8fZnqtEi0X+ruzVqLqIzwen2DGcwUYUkTt1N
         bfb+1ddOX+XLI/etWR6yHHHdbAVGoHS3H3bT7sVIewoQo6W4o7iflkQQnWsuFERnmj4L
         HUegGcCSO6dBq1OEEEuC4Gj1qlR2NRfim609E0OUN7pyiBGGLtoZXsmYZiHfcP4g5cD2
         /I/7eaStEXAUmrBb3id/cDxzQgIph8JoCdvRYapRXYdBdGAB+tZUHa/EmpGTXDj6c6L+
         UIGw==
X-Forwarded-Encrypted: i=1; AL+hErE7aP4yt8e2h0i86HeQaSfVrnjEBnU61h77wu1SVo/dD7E7llb09AMvXjtW5RHHylCjtpzofm4RW4fxnYP5MVG2@vger.kernel.org
X-Gm-Message-State: APuU4Z+YeW065xgOws7wdVy9rXLz3TH6iBFoTvN7Dy6uTXPK05u+TDpK
	KKHZ3tSj4INaIk7l0trCXHdk0XGtw91HYLKj0aOc0deL5i8uOagzEbSXwfreaqpAXt7uEiKZIe1
	oX5LP
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: from dly27-n1.prod.google.com ([2002:a05:701b:205b:10b0:1ac:f9af:14c])
 (user=yabinc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1e0c:b0:1b2:5884:a020
 with SMTP id a92af1059eb24-1b5568700c2mr14495372c88.6.1795630427906; Wed, 25
 Nov 2026 10:13:47 -0800 (PST)
In-Reply-To: <20261125-perf_aux_alloc_optimize_psi-v2-1-b2ac7ed12849@arm.com>
References: <20261125-perf_aux_alloc_optimize_psi-v2-1-b2ac7ed12849@arm.com>
Message-ID: <18eb5c5c4ab1b230.3137322e32382e34342e3133.0c82.0000sendgmr@google.com>
Date: Wed, 25 Nov 2026 18:13:48 +0000
Subject: Re: [PATCH v2] perf/aux: Avoid reclaim for optional higher-order allocations
From: Yabin Cui <yabinc@google.com>
To: Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Tamas Petz <tamas.petz@arm.com>, 
	Tamas Zsoldos <tamas.zsoldos@arm.com>, Michiel van Tol <michiel.vantol@arm.com>, 
	Dev Jain <dev.jain@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Nov 2026 11:54:53 +0000, Leo Yan <leo.yan@arm.com> wrote:
> PERF_AUX_GFP includes GFP_KERNEL, which contains __GFP_RECLAIM. On
> fragmented systems, costly AUX allocations can wake kswapd. When perf
> falls back to lower orders, the allocating task can stall in direct
> reclaim or compaction. Yabin Cui reported that the resulting memory
> pressure can trigger Android's lmkd to kill applications.
>
> [ ... ]
>
> Reported-by: Yabin Cui <yabinc@google.com>
> Link: https://lore.kernel.org/lkml/CALJ9ZPO9XxF-kz5K67Jg8RtpiEmK7XFU3e+xDak6LyV_We7yBQ@mail.gmail.com/
> Suggested-by: Yabin Cui <yabinc@google.com>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Thanks for updating v2, Leo!

Tested-by: Yabin Cui <yabinc@google.com>
