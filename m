Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1613BAD9D
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 07:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784532152; cv=none; b=AKlq/9rxphKmeiHbVWj9SvvtU6Dc67iIsbl8t7pBHEryYy0RshYIgLQ9xaHDnqcvtPlhKK37n3KKUT+1LTmM2Mc1Ua02i3eRsjbSZq4JheMkcB5ZE2YEPMWKW8Wk5wOJipRh+ZT6teJHEYWtrbEp+yHBJXifrNgggxVaMIuPlJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784532152; c=relaxed/simple;
	bh=xKIYy9gLfjK0ErQeo2wTtFZ4ZjVBR6dJaUHPV79mAoQ=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=rN40k2DK9syl9a23O/1Jh8CUMtHubdrv26T+NVz5xRjKR4a4Gpn+WQpPLSO9aDGp2Nwm5B1g9/0aK+Q0bSXLB20OQ1KzNV/JT4A7NG3lfZ4pUMjyPCd0/aHOd6wyvlQq9GeUB5IcCRxEwA2KiJPukwK2OnD9LHijxKkgFjz+zXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCRHRtVf; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCRHRtVf"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e041ea211so7551799a91.0
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 00:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784532147; x=1785136947; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=81wMdawUXuj3EXOCHXXMqn3Ymvgxt/Q4XO2qMQYsZSs=;
        b=jCRHRtVf7dYTY5GNaR2bjf5gXsjsF8w4YiThme2M47Kn2Z6eH4ksYC+FnaDa90fIqd
         OJVUGMElqlQEN1lhPCm/d3FWjl7wqxzcguxAf+sepQfoJVJazGxD1gNmoti1GT6KyRR7
         zAI9QYCP3wRugouNHWXuRGeqqCgNfwGVZC20Ni8Yl3tXTS2VpDf3uo1iyDvnMfQr9asj
         JNnPf58S2EAYDCrMegmQaUfdDkY5EVEI67dmweGnoFqIqR0OZwn8Xy6pbVN6aM/Qy1NX
         jTa5cYRiNZjubvKwbQUiXItr8VopFraOPe1/tVV4nmOwDROnMwNT5oL6SIr2vqod3O5t
         QKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784532147; x=1785136947;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=81wMdawUXuj3EXOCHXXMqn3Ymvgxt/Q4XO2qMQYsZSs=;
        b=JU+ssZKjhNwgSlaOVHtIwQXp69rbDt8uo7elMGXy3bwrid+C0bVzwdEvUeQk1uSWDk
         k7LPd9c7oSNZhyTPRP6jV++haAEML7zAJStDj+50odDEF88CSc879dQyCvdZCeRnisnA
         viY2CBwwrFPzikoe/XkogpwkyRDrW2n/8ALbfoDCcYb37+TVGXUDZ4alhUo2e88jdYDR
         h8A127L743t0Pf9NSExlb81OGSwQ+H4sgKgrjnUrGAAQMDdTHq9ajGJRKP5B1Kg28S92
         /Kg9mSzbGzhxuoWwTCPQDMQI8N5J/Q/7LE8je6PUyaF9OXBIQROJigFGra1Strm1PYGM
         hxsQ==
X-Forwarded-Encrypted: i=1; AHgh+RrfXZnRRqvbJ0VTmv4Zwiwvq4YqkewqI+34xiZuDXeihk8YmQv5K9rlXb8xjZ0XvgoCNGaR9j0W9LsSPqwTURVA@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm22TdXCu0go3WSnTswhMQRGPH7tdW8CAmeDx+/kq7W+fzsftc
	hdVlaErXHXyxH9F2KDftbc2Gm5JmigT7T8yAribtlfuK+suL5jO3iPoU
X-Gm-Gg: AfdE7cmMrTFMzwZdVnu10se5l7KfvTcYB2ktouDvWDPcXKZ4uHLbhXHWpIugpzT4Ww6
	dg1N7E+aydniCJiAorAC9DkWPFS4vcv6uscuGeedmenxH3p/rvRMOAUj4h0TQKMUUzL6eXW8eXh
	eDCojP3CwZrERccezy/2Tbo31pdRmKbJS+NGC7qHkY18z2+86XxCRdtVpm3Cc8AlkFNeZ7PJ1B1
	YsSHML63Lrce8IBGXeilRPFsS7v84F/lVyhmkq7TjNLLrq71pKz1Q34jCJTDQKPmaiAfp9o2awy
	1W7Vok0Kla3URjHKY0e3spYB4hD0O1McC/sPhobsycOQPOlgHitZ57N1Go2d6q1/ZYtab67hG01
	zzgqifHcxsypLYG/Zh1hPEcXnPw7z1ulKiYs/6AHtXzD0rWIule4f1MYCSY+5dx3F9devYwC3We
	p4K8Z58gWfgUiXg9zq8fjKBv9bfkzH
X-Received: by 2002:a17:90b:4e8f:b0:38e:2524:7272 with SMTP id 98e67ed59e1d1-38e4b57d481mr13255018a91.39.1784532147198;
        Mon, 20 Jul 2026 00:22:27 -0700 (PDT)
Received: from [10.0.0.29] ([2601:647:4000:5070::51d7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4afcc067sm5153318a91.1.2026.07.20.00.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 00:22:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v8 16/22] RISC-V: perf: Use config2/vendor table for
 event to counter mapping
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: Atish Patra <atish.patra@linux.dev>
Cc: Jiri Olsa <jolsa@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Namhyung Kim <namhyung@kernel.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Ian Rogers <irogers@google.com>, 
 Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Conor Dooley <conor@kernel.org>
In-Reply-To: <20260701-counter_delegation-v8-16-7909f863a645@meta.com>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
 <20260701-counter_delegation-v8-16-7909f863a645@meta.com>
Date: Mon, 20 Jul 2026 00:21:59 -0700
Message-Id: <178453211939.543975.4098345314278669087.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784532124; l=949;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=xKIYy9gLfjK0ErQeo2wTtFZ4ZjVBR6dJaUHPV79mAoQ=;
 b=Ly3CRkq9fX7mfbzsfqw+WnDr1CsLgIAkSJ/QQHpnAJqY8KMG3MPlUEx/DORUyeO8ps+EOVR5Y
 5Eq4Nbwj+loAsV8sFj39MhmKvuNa4s0QIzqT0Bx0tILO0RH6WWklGo1
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

On Wed, 01 Jul 2026 01:47:04 -0700, Atish Patra <atish.patra@linux.dev> wrote:
> The counter restriction specified in the json file is passed to
> the drivers via config2 paarameter in perf attributes. This allows
> any platform vendor to define their custom mapping between event and
> hpmcounters without any rules defined in the ISA.
> 
> For legacy events, the platform vendor may define the mapping in
> the driver in the vendor event table.
> The fixed cycle and instruction counters are fixed (0 and 2
> respectively) by the ISA and maps to the legacy events. The platform
> vendor must specify this in the driver if intended to be used while
> profiling. Otherwise, they can just specify the alternate hpmcounters
> that may monitor and/or sample the cycle/instruction counts.
> 
> [...]

Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

-- 
- Charlie

