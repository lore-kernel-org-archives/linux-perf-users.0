Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A836EEEC3
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Dec 2025 06:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764916409; cv=none; b=XBUnQCRjOU2wQjgJCR4o5nh0q5aohHQp6bSFg2DqRk61bD7LoAvMaqwTn9v/89uiuZ8PbWe8Yphkpwlw1UYLsT1cc7ex9An8YAWvAN8Si/MpjVGNUWfzzKC+Mr4iqNQLS4LydFVkGA+r6YmUB/3dVRidOqP5tRde3AyEZPa0EFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764916409; c=relaxed/simple;
	bh=smb4L9f+ODK16Js7BhzWHUI8LWs3ba2bZ37b6L4KX7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cdIUDuaOZx2ldSmmECO3bYkraW/Uad6dIiyBaOC89Y8P8lcv/kPihIeSuk4jE76DiJru7Xd3TsWCuozk1yFSp+flt6a4zPYC4Gc+ABtmRbBd03aWvFt++N9dbSE7rZAnZ6IRrg1CpRa/kpTCYXGJ1hLBXCOhHY8qUngcRA1rk38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4WKF8hK; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4WKF8hK"
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-37b935df7bfso17255261fa.2
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Dec 2025 22:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764916406; x=1765521206; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=smb4L9f+ODK16Js7BhzWHUI8LWs3ba2bZ37b6L4KX7s=;
        b=O4WKF8hKOl5eLtw2cfb82I5Nvw1ez/K6bB6j3ffjZytIwYLwS+ycnkUfHy9FQxm90U
         SQRCIPBRxuN0LEDji6g3BtwM/337cjGuVkXucIQCzpjwkyBZOqwAhzsvZWS/j2b6SRGc
         M98O0dPGLJ9VuXVPRpaSCb5ds0xQ6LZ66F+Ahhd5Nm9M6j+7m7vZWt8/Bir8fD3cEs/W
         NUaom9yeztnqKGyeZe8Ac2cVWJjyWu01nDb6vkGvFpdCt5KvpdU5bxI0eJKIZ7AOs4au
         lEZUHo63pvbeMDYpwdXQQhebamaha1RtY/YNamh74AlgazBaOPejl80xGtlKolBzHsCK
         YGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764916406; x=1765521206;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smb4L9f+ODK16Js7BhzWHUI8LWs3ba2bZ37b6L4KX7s=;
        b=gU1J7bpXKm2L8sAYbIQHCqUGp8TNh/EnnkGGF/dpZqwjfKrJCwbnKhHoR0B5YOGEL2
         3qRF9pY7ghQ9ozAz82G8qMUzHOe/mC5HSOtOPJgr1bqYcnJbHF00RYzFrFPvTGpQQkgG
         mPi2vZvqrwPPb1rZnWOA2vVE0DIb51MHWh20eocvAxfMseJtdJafPRuhDNVmQNhg9JlV
         ugvQeOQWD7WiZNQIjKwrvwWjdl9SisLmNuzVuGwZIW/OJ7CebZrBnp0DbyuiT0f7u64s
         jysWihBGOkgq8ocnpt7cGtzmaz/hUOATyD58Po9Glb+gjmyReoIeV23ttc5yVByEim9l
         L9MA==
X-Forwarded-Encrypted: i=1; AJvYcCVQl8xZ6Hg65zvej5apc7DJ7UCmpcxKc8y3m4m31OH1+pLJ1gfJGVLJtTKoORIxCcR/ZHwemIsMSw5xfcNxfhaJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3vmDFs1RC6XTpL16wMuTPHEjQA8rqAZrAKaipBzZ9qnofeqEZ
	ZWfTRQdiNx6kL0htK/Ly6cewNFvalcn7mywcBrcg/NEILpLgejKIEURNvoOXzOkJnKIp1aGS5Nn
	k/X7UZ3JFlx9BoRcyw2jG33Qgn1EiNfA=
X-Gm-Gg: ASbGncuzrLQjERfMgvf3sOHJUfLbu7PlQXTmmgUXvMuF9k8ZyU3yTTh+mIBIrOR8lJF
	Lc+OhSI1XhQHe+EwsH/raDJJQYBdvk+zsAi0LbptUXlY8CkPeo12HY7Wxz9tS09zMSnSYZj6e5+
	4el/cjRI08+74QK9aR3w+dsFBlDZnV1vb1L3v/NmlejtZIZHEaJO1CihZLA3n6OhX+nfK/mj/O4
	7z1Mje03xB3JzeARttEX/9CzOVIJi7PcihONIIJaHyxiMdd6IzPdxqbt92ytZbC7Dfdcp/a
X-Google-Smtp-Source: AGHT+IF7MPZdL/i3cW6HIDZeZ10Hcif641ryuj+fUtzm7V1Eq4swI39eySrPopVVUoMKESaOQnpHtbOmt6lXCmKHLhw=
X-Received: by 2002:a05:651c:2556:10b0:37b:ba8d:c0e5 with SMTP id
 38308e7fff4ca-37e6396bc2bmr22178191fa.21.1764916405734; Thu, 04 Dec 2025
 22:33:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADHxFxR-8NRN0Fwj7jhD1KKACrb0PdUp1iOBKJ+xkxaNQn_tew@mail.gmail.com>
 <20251124073445.3709-1-hupu.gm@gmail.com> <aSVlQHJ9xcGcZULp@google.com>
 <CADHxFxRY5Vse0UnezDg8hCEgbVy5qXkoLbEMRGaA6pH5aLoNxA@mail.gmail.com>
 <CADHxFxSXMvmeL4afJPh9Ycs2ABrnOVHkxJ4pRBdhJRJWBAvnHA@mail.gmail.com>
 <20251125161026.GF724103@e132581.arm.com> <CADHxFxQ2kb2pRhn0-_PJwmo9pykHzDMJDPQay5GaqmmZF1nwSw@mail.gmail.com>
In-Reply-To: <CADHxFxQ2kb2pRhn0-_PJwmo9pykHzDMJDPQay5GaqmmZF1nwSw@mail.gmail.com>
From: hupu <hupu.gm@gmail.com>
Date: Fri, 5 Dec 2025 14:33:14 +0800
X-Gm-Features: AWmQ_bkPlD4PykwH-CrTv2xJWzsq6yZdxnmNgB-1pPY-FRdEM_S7LQkFKXiP6Uo
Message-ID: <CADHxFxRdqBFq1c7wNViP0TRdopCCw+9y+hmaU5wNZLodKBq3Cg@mail.gmail.com>
Subject: Re: [PATCH] perf build: Support passing extra Clang options via EXTRA_BPF_FLAGS
To: Leo Yan <leo.yan@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Leo,

Just RESEND this for your attention.

Thanks,
hupu
