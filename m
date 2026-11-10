Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279142;
	b=AZUNOEy4AO/vzsX8Ajam0RKWkVUXOxnkFuwWChdB+CTn/m2dsnFlgZ96Xbcd4Xo+g6tx
	 iYDIzvO14y5ZYFwsIURZG297FHtF/P8CATUGohe0raDr7Pmvvd4w9j/ysz4Z2SFDFsH1s
	 pQ6U9PphBcHVxzzh8gj0eFzXW60Zx6IJrZ0GjmQURLmlI0aSGTofcYxsXV+A79Yn8YHBD
	 Vh/EVGdRO6O8BrLoWuSBvCKzwSrfPUD2z4omRqSKzPIHUlMnbM6OUngrCm7B2fsN/Y15/
	 +UfKQKQcFPmqj5zMk/JP/EcxCd65krUopwb6twKuDPtO1d+Wby9KXyEX97U2dYDaM9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279142;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=IVNJNBwVCUrvpTZr532XZvXnzIFFiae9ctL11rMnMxk=;
	b=Ipi+uUX/wKIU6XAskOCq1ecOr+1L8LnCmeVAwLOPIyWDvuZWw3AaAlXVJ3/LJ0oQ9wWc
	 0cRdFF1q2xilhTwnzCxS9+LuOljyzozBe0eSR2/Sq2Scb/uDT9RerD0ilyX+Q2bEhIm6K
	 IRS8Bawje3YNPpjf7xpQXCxWS5C6DGDxPSHrurzq51wTJfHQXeoI889MNuXZ80BpFf//6
	 7mUxFMw50ShHM8mfgkwTNdX0guP21c0iOWzk8kbJU+trO+T+Qz3Sq9sE9zlmypqF4W+ts
	 rKNCB7t7iRDvrZQjocRQvtxxR2rURrzY4UDwO5Gq8JFqD2ANiwYpgmViZV2EudfS50Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ao28qVj9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28114606A321;
	Tue, 10 Nov 2026 02:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ao28qVj9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1B21F008A3;
	Tue, 10 Nov 2026 02:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279141;
	bh=IVNJNBwVCUrvpTZr532XZvXnzIFFiae9ctL11rMnMxk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ao28qVj94euhgeyeORZydVBfwsNYgy5EQLn5Ny3Iag4v463vUfrEistLWNxFUjcxk
	 /SCVeJXLmYjIvi0uNacghwtHmgEe/pCfV0GBHdzV6xRHdCjPFQfZmZ9y42txD7V1gJ
	 SSgWDyDOSujDIsvPg3P0+kNdCfeRtdtt8DBASUhBd6Aui+Qh1FQrroX/6oTw1pnvhd
	 rOmP74XeLt26VjpMkPauoPHN5T4JRuEQID1zVlYnbXkdNOdfSth7WrASL+lX/8Nzbz
	 ME2vyJvDf1b5FyRHnen6aEeMsKccGh3FkP4md06cbqq+qfkjP/hkpMpgsKOSxPxQ9v
	 yBppWZn7DX1Tw==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261106092808.6914-1-yangtiezhu@loongson.cn>
References: <20261106092808.6914-1-yangtiezhu@loongson.cn>
Subject: Re: [PATCH v1 0/2] perf tests: Fix and improve watchpoint tests
Message-Id: <179427914132.13444.8498342903914689846.b4-ty@kernel.org>
Date: Mon, 09 Nov 2026 18:52:21 -0800
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

On Fri, 06 Nov 2026 17:28:06 +0800, Tiezhu Yang wrote:

> This patch series aims to fix a potential logic bug and improve
> the debuggability of the watchpoint tests in the perf tool.
> 
> Tiezhu Yang (2):
>   perf tests: Assign return value of ioctl in wp_modify test
>   perf tests: Use TEST_ASSERT_EQUAL for all watchpoint tests
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

