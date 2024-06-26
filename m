Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A62139CFA;
	Wed, 26 Jun 2024 03:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719374400; cv=none; b=kd2E4/x7FX6IyMyhgdGksTI/r46XiAcw2ZY4a+16rFiS0SsumUNYJRcYftsj/aXSZNk+xAwvglYRT5dy6c3IanNVMh0hRBEfFKKVpP5ODwWMSarGPb83KAMKKvzhi+UZFPTlPJ2IlmhjeSReQewo84xxVi/iWyBB6+Zdjn/qzsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719374400; c=relaxed/simple;
	bh=5yu0ifpXDdr3tupYScp2XkHcSrLvWfGCKP9mbZwWzHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ajfn1ChaQFVr5pB1n3zLhdaq8uDTkkgJ+saZgz6f5xRduwKRsxZf+AImmlpPI7ERO5zGwsZ15SI2k5Lu7w6zrZ5Tm+45BSPn+Bp9Bf7d8bHqHoqfoLstAzEV18xQ5PoqTMzEp5ze4guniiwdnRl+X39tcIr9Sr0RjSe9Xd0x2pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0Kx8Wno; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0Kx8Wno"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62919C2BD10;
	Wed, 26 Jun 2024 03:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719374399;
	bh=5yu0ifpXDdr3tupYScp2XkHcSrLvWfGCKP9mbZwWzHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O0Kx8WnoyDsRmmlO5H4BODGx4XXfcbe9xxlhf2vC8LqrELwstD6JyRCV7mCOcgTYj
	 pSu60bI6acm3v+9FLkrVj1oLrKZeNRnYT6Ra009d4N+YwrqBS/dqwv8IJD0H6QgjXu
	 jn1c1dr5n8U6ZmASISRPWklnfvTitOzQvVS9teaQ3B7W5UsrRqrBq8Jq3tfkbqmikb
	 R1IQei0tl6d60stZwPZHYR5wwDZcUIxd6jAFueaGDSHZg4FG6fEun0ylYg8iQhfgBG
	 4EViDpjKfUkwqZTxDub5pZernfeinipit07Zf8tQK1RIO/fuxfybnQEZc4uq2x5F08
	 NO74Zjz9GpSkg==
From: Namhyung Kim <namhyung@kernel.org>
To: Fernand Sieber <sieberf@amazon.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: Re: [PATCH v2] perf: Timehist account sch delay for scheduled out running
Date: Tue, 25 Jun 2024 20:59:58 -0700
Message-ID: <171937438265.2859655.8730491101054759651.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
In-Reply-To: <20240618090339.87482-1-sieberf@amazon.com>
References: <20240618090339.87482-1-sieberf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 18 Jun 2024 11:03:39 +0200, Fernand Sieber wrote:

> When using perf timehist, sch delay is only computed for a waking task,
> not for a pre empted task. This patches changes sch delay to account for
> both. This makes sense as testing scheduling policy need to consider the
> effect of scheduling delay globally, not only for waking tasks.
> 
> Example of `perf timehist` report before the patch for `stress` task
> competing with each other.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
