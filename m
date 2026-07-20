Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED653B71D7
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 07:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784532144; cv=none; b=bVvF2eMKJxe4jed5i3nOz4vFQ1UvwunvOsAgoETuMfALS4zIg8hNo2D4jrsor1wS/IR61aaJ9VOyf3NIU6N9zkYNjib4nFBdDWxMTpQhBCgOPnU4KorWjJ/+oiGNc+WFDxtRDFy/1o3ZC/933wXX8c0CQIoPhsgfoxRd3baj6mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784532144; c=relaxed/simple;
	bh=y1PqojkleYsBjG9eN+IIxqwXAQObYxTJP42EfflWB+Y=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=TVOfnRZDX7KgdEfqfsqEZcg4SSBQdauwnXIMYDp3j8xY7PozNrdyPeyfh6+0UHSU/wV71RH1PJNZPn8+0iK4BCaVtls6PUiV63jrxpBEXd8vEbheU5n9SX5vOe8sLdM9HOP4mq6Je+IAhbK7uL0qY9RXEzH4viWMSaLe0+ycIdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICZbhrjH; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICZbhrjH"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e3617ba36so4153911a91.3
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 00:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784532139; x=1785136939; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TUztZ0b7q+NpMvvYDHyOAMUqlB8mjssu5zGv0A0NKH4=;
        b=ICZbhrjHDP7P4RcV31DeuKFCwPADSBG2PzhE1lMagpk7Y6Cp7wX6stAmT/s14fc4FB
         Vhq9DITgcueZ2bZrliWX7+FpPEb/Zit/N2WGtg2p3qM32l/1kkADY9MlJa9/Tkk8MJ68
         6V6A9HAovwtxlAA/lHbJEDX+yHjPuxaxmS0t5BdRMwUrGOs4XgWA6LW5XqKtmrBAbmYr
         PR/inXfdhalcFTfuXeU5RoSc6lRHHaQxjukv2fHBv9LMHTrHyoYodP7EAAbPwvX3BVt3
         +Cx/vta72vjUOU2vcurJLKNoZ82gn8fRt82CgcuXAWdQgKvRlH6r203X7LxE6zZwcx9+
         Tcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784532139; x=1785136939;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TUztZ0b7q+NpMvvYDHyOAMUqlB8mjssu5zGv0A0NKH4=;
        b=Xjh12aiK8f7aDn6J3aIH6Zmwh9G6g5hYNXUyr4xbXWdRMigM4aQjH0y2x3qdl/+Bt+
         7glc9tAwsMg+MrJRTyINM/z3FfOsyXXzEMdoATWHRXE8CLnADSmhslitOzRZ7uV5LnsT
         Bv4bi51eEtFtgRbEa7B1WV6N215uwDvd8KgXgbSm91QxZeX19mms/X1t/a8GxIX3IMe7
         rl6lKeeRTzK4ebcnL3ADEU88yfFi/P/DK9DuPrbSbEubxTLp3h9Ujh7E6GVe6vb7u/9F
         dhyzJOPx2gQqPBChOn8PgdFH3lGqoPJ/bkOk0pNURBuO8gxK6VecWVWlfgBCt2aoMR4u
         g7aA==
X-Forwarded-Encrypted: i=1; AHgh+RrWnJ0beVah+hDIGF4O2sNOUrBNdZSl4q0lCnTNa4JGicIVYpKMXQyNccR8aG/S9SD0y4LKVrAx+SqGwT3sVF85@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6dDbsDbSXQcVDW7pJlQklOjsVXkuWJJ4acbNsHrHDXhIhr35u
	tRologXP9vmtQ7tYAO1RU0uCC+MVYcMgr0g0iRqK/FCdOohNTPxHjwCe
X-Gm-Gg: AfdE7cn1AQa+BglhMxMrvpNtzOrpkQY5/CnavOgNH18UOKZYAHArsmFjLyG11xPCyYl
	Yr5A1vlAiHzNyEBC9pWf9PBEt2Zbx5SvGM46wgjLQNAkFmUNxaoEmg2KrroT2+TcNKjKrlZxBPk
	NJ9jOriXbBgZ5bArkvIWKInQdUboI7X3gnFFZ6DQHZwRPxUQRU8A8Qs/o3pYYXHi9dV4OGEw0H1
	MMZRKDAyHQfNYhRjnMeY/Fb+WvHduYuQQwK+H+K6lGxIeHdjcydJ0E/xpoSxlU8dttJ+vg0tqqO
	C5rXQUQgYyhx/whpXVmAXoLrMaXAl+XcN2qH6yxbL/El1l27RACIwCJ8OsiVCuaEh/GTqhbs4k5
	sSYu4kEulVzvOuduIakISs2nrtKPywpSigkmFEgzsnjBAwRZwQGtTYZ//NUVDTzoq/SCjlanYRp
	iBFZiXnQAFCDNKyov33TrOhu724mx0
X-Received: by 2002:a17:90b:4a4a:b0:37f:9ce1:7369 with SMTP id 98e67ed59e1d1-38e4b54c1e4mr13295798a91.31.1784532138762;
        Mon, 20 Jul 2026 00:22:18 -0700 (PDT)
Received: from [10.0.0.29] ([2601:647:4000:5070::51d7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4afcc067sm5153318a91.1.2026.07.20.00.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 00:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 09/22] RISC-V: Add Ssccfg/Smcdeleg ISA extension
 definition and parsing
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
In-Reply-To: <20260701-counter_delegation-v8-9-7909f863a645@meta.com>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
 <20260701-counter_delegation-v8-9-7909f863a645@meta.com>
Date: Mon, 20 Jul 2026 00:21:59 -0700
Message-Id: <178453211937.543975.4322402942834410024.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784532124; l=542;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=y1PqojkleYsBjG9eN+IIxqwXAQObYxTJP42EfflWB+Y=;
 b=liGw0+KRk7gLM9mGkWcbN8G4nDkwP2C2I7Zb7ri3m83b9lEN7e/fB+kwHHa/mofODnnb2zsUF
 IyWdYB0weUKAFFVTMYgNMYOglCZKygWyFNgG8v9xFhmJJw7QYjPTAMU
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

On Wed, 01 Jul 2026 01:46:57 -0700, Atish Patra <atish.patra@linux.dev> wrote:
> Smcdeleg extension allows the M-mode to delegate selected counters
> to S-mode so that it can access those counters and correpsonding
> hpmevent CSRs without M-mode.
> 
> Ssccfg (‘Ss’ for Privileged architecture and Supervisor-level
> extension, ‘ccfg’ for Counter Configuration) provides access to
> delegated counters and new supervisor-level state.
> 
> [...]

Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

-- 
- Charlie

