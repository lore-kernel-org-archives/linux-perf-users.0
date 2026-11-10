Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279145;
	b=rn/bWzuy6hTCRBdBWmAZj8wVw+xa7C0Za9jjqVzaeNXzeIdxNTcKnORPMYTjLCdY+xgZ
	 f34QSzIxWxaEnR1kYOa7sa/NL/9xvEAjGfdC44rOkuqsjOvQv76HAnF5a+MxELo8IjaTJ
	 8P0mBo7UEh/UuPXOvzNfZBRXbamjy8qBJgoEFEmWMUii7N3O2yJp2RH0fAe9s7gnY9saE
	 kpqa1PbZ1S9SygwcEtLGdTG6NV8ASp7/ZL6YMmziurm8vyd+K6NZqInU5XlxqoAWazBih
	 7rThPm2LFL0cXALmCqKKzo8RSvmquKhYps7zhjMCubXGV33+1AA3ypkwfrKSmRKAJGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279145;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=GCNh8rCwpmmDQZpc3CoZJd1saCmgyCH/Tl/4l8t6VlE=;
	b=tq7QMj/ED2jD23YAxQkcWxn2eyYNJiBV+jA33W2uH42Hexdlx7Xcy8q3FbWCimYf5gE5
	 E9CBGZMp7Ev0yunWJtQjKD6eylP9pX/caB6MSayJS/r5ECO1abPbmkZvMgryeyxvfkwlP
	 jKvREroem7yXJzYIflX/LaqqwYMVy7xCw57t0pE0xR44S2Y9tkne+JU/5JtOJfkGiMaFv
	 6gYitJS7GGqnVQqoDLlH8tPff4bx39V5YpHJ2oaidfoLrViPaTRnrCcAyiJeCIg64KFqk
	 OV+vKy8lWFwiRSWwKe7AP3sdjqsVTNbFTupmuiuqq1S56sLjOguSct50bFy3xTnEmvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oPvQXeLR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04042606A337;
	Tue, 10 Nov 2026 02:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oPvQXeLR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784FC1F008A2;
	Tue, 10 Nov 2026 02:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279144;
	bh=GCNh8rCwpmmDQZpc3CoZJd1saCmgyCH/Tl/4l8t6VlE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=oPvQXeLRWFJ70UmdHzTsD+fpfOx5v7iLHQVqDfwzhswbjeeUsJiH7IAHDGdKLu455
	 z4o0BcAyjJwRszduBjnpbRARDL+UMoc4r2QpNkuVsP5YUHIIo3JCFBkiW3+2+hs4+i
	 k1b62wDaVFhaqXun4pzh3kQqmEhdFH+KZo6rVEOI94PZ8Tk3aYFBy2rXccJ1cNrfSF
	 dyHsCxWOtEhEC6SPkI8Lg0IjMKOUvC0hkQlkGNF+VOk0A8wxxcmY/UeptQRO/WUXW1
	 msTyzHIF1sYVD9mV9AVzMKkpbY4cyZ//HyeBTkuLdSNunTU2C2l6TTqiWEm9pcuYuk
	 iFwBpvULZsx/Q==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, Gu Bin <gubin@cmss.chinamobile.com>
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, 
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
 adrian.hunter@intel.com, james.clark@linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261104103607.1903-1-gubin@cmss.chinamobile.com>
References: <20261104103607.1903-1-gubin@cmss.chinamobile.com>
Subject: Re: [PATCH] perf evsel: fix buffer offset when building the EPERM
 error string
Message-Id: <179427914444.13444.667196473911264825.b4-ty@kernel.org>
Date: Mon, 09 Nov 2026 18:52:24 -0800
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
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Wed, 04 Nov 2026 18:36:05 +0800, Gu Bin wrote:

> When building the EPERM error string, the scnprintf() that emits "No
> permission to enable %s event" uses (msg, size) instead of (msg +
> printed, size - printed) like every other line in this case, overwriting
> the "Access to performance monitoring..." preamble and truncating the
> following hint. The message shown to the user for a failed open with
> EPERM is therefore garbled: the preamble is lost and stale bytes from
> the overwritten content remain in the buffer.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

