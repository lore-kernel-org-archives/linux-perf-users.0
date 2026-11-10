Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279146;
	b=1lWW0FKKvmFiwn1lZ1Bu5EOTWcmFRxzO2cQJ9H4WK9zNKEBQOvdS4/fkT8kkzAKRgs7G
	 HvWqLa6Rm6qK4Hjrtx0GDh//tkWM94GB3HGwiC6O7rCcJ8HR88xlYmIQYkBLIX1WPOfp3
	 13LNTUWLm58bBImhxNEH/x8ZQk1lxON9uZ4DmI12BUUf3mo0TOrWLteM3lxTcuCm+uwD9
	 g79saYL6jjY0KLR5+pLTbd+Z33IydJwZQ2uMfEDy9YEN6yVl4F3KqAvGkBDSDqaYc2SRk
	 XCLj7uxGzSHPQuUTKID7Z6OC7e8LVcEfV+E9CvbuKgtmmULpHPJ+iOfazSR5YQERrQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279146;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=Fhlc0g/8wTeR/Kk+PxcfP1Z5o6WckUz5CE+LQEWptaA=;
	b=OwvIMZ2YL7JPWD5XU+mH0FLPd26eYc0K+fCkWy2JROshXI6kEpWzYZK2c68S2ODaSjqm
	 VVy13oh2hgSe6cMjZA9tquPWcKMUyiQDfdDeCsB/fm5cgcHk4o6/rpylRyy8XLpq6UFBv
	 yqgigPDqIslFswOnJb6GqiUEvHVkViQ7+9QhmRBYqj5i7/5fVOfViVwe96SG0WQ3u01El
	 DnPatKkQST1rsjbH0AL+cqFGlgowFs9WuYOjAaIsL0k0F5ffLVSwNlV3xZg4E95ygWbrg
	 YEvIz5NRcg0s9ObM79aT4CnXmzTfRQXMkZGi7WUzYcAQa65O3dlcv6wVpVBRY7FSF0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eyE6uwmx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9457606A31C;
	Tue, 10 Nov 2026 02:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eyE6uwmx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DB91F0089F;
	Tue, 10 Nov 2026 02:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279145;
	bh=Fhlc0g/8wTeR/Kk+PxcfP1Z5o6WckUz5CE+LQEWptaA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=eyE6uwmxigGQMe1V/c12yzQqXC2A9xzIpLQFrD7btaCHKamHZLWsme1Zz+0qBijv1
	 5JvWmc0C9LwVOG38l1L7cNmhdUHcQildXgBaIm+PCVKdZBxuN+U1JiPdUf5WvEspxE
	 Krf0ErEg2DrPbMFpq8My1P7V6W3xanOTLNIO/HyvFtbDWRuIHFXwBgkQ5vJFQqLLbo
	 lsSDT7j2v38e132AOhHQ8q0G0738RL6G9xxUTAlSaCb4ydzgMwuVJ8ePxPVkgM9tM1
	 QbkCkRtTwgAzIt9aSEiQKc2svQY9uPSctBD/vSvc970n+bXPO6h2VV2h1MIp8FuJjz
	 OTjJSIsQIJ6aw==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, Gu Bin <gubin@cmss.chinamobile.com>
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, 
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
 adrian.hunter@intel.com, james.clark@linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261103171127.1628-1-gubin@cmss.chinamobile.com>
References: <20261103171127.1628-1-gubin@cmss.chinamobile.com>
Subject: Re: [PATCH] perf data: fix inverted strncmp() in has_kcore_dir()
Message-Id: <179427914497.13444.12881343888822705562.b4-ty@kernel.org>
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

On Wed, 04 Nov 2026 01:11:26 +0800, Gu Bin wrote:

> has_kcore_dir() scans the perf.data output directory for a "kcore_dir"
> (or guest "kcore_dir__*") entry and reports the match in `result`:
> 
> 	result = d ? strncmp(d->d_name, name, n) : false;
> 
> strncmp() returns 0 on a match, which coerces to boolean false, so the
> assignment is inverted: `result` is set to true on a non-matching entry
> and false on a matching one.  Consequently the loop stops at the first
> non-matching entry, causing the function to incorrectly report a
> kcore_dir for any non-empty directory even if none exists.  Only an
> empty directory or a failed opendir() returns false correctly.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

