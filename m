Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ADE335C0;
	Wed, 26 Jun 2024 04:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719374509; cv=none; b=oPBG2mwXeFPIU/unoSCpVmxixEdbtxX+C9okclz09dVB3I9SLFGTb/AC4Z2d+Ys4Vg9dugRwglU33LFIiQLZAqz1Yf58m1gcPRNd6f6tbmR9BSQW007TxaJnU387okL/QlNNAIQ4XUOnSZgi/Ba+XjNS+I5pWQEZCg2cSFrIwPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719374509; c=relaxed/simple;
	bh=sm6QrUJc7zHzDNHXskLS9kahZ3Z/tTkBbdSbfP+9waA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kxDDT9ArtF4SOrdYmsD374NXZlXLos93lmQEAW4ncV3LgNDI+ifNbirDOZhqAuQC0mwxzp+njFn/nK0dEDoD+WS3zH7IFFD0mhvSZ9c1+ImMd94HbbezSOIVxPHpgSR5c+NKYZiLW992rwpHIyWa/7zBLE2uRDYm9DeqSXcVNCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnJRVibD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnJRVibD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B8AC2BD10;
	Wed, 26 Jun 2024 04:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719374509;
	bh=sm6QrUJc7zHzDNHXskLS9kahZ3Z/tTkBbdSbfP+9waA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BnJRVibDNcgxMh97fUYrEcMyXoFTETwg69v2OiihvQl++TlGfOURzrT3SZtW5Ucer
	 VTx3X0PctIfGymsvusWg0s+Qu+9DWyyLha744fdYGUNBYAFqG6eTs5OExvoTPjL0pP
	 ICPkkZWmYKA8b0EaH/Ii8EkZGL9GfYfP7tLe4QK7PgjXezcTO5rDy1KTHu8TpGAoeC
	 8Bed0a4EzsAp6+XD0HBpJoG7xmi9FwktGvKeeSBl8OtknrZgXaiWVjM0CkDkPbCcct
	 gWvU1/06yXxuzwsVZarDczzExM3uWtI9tY9Q0DSSse5gWaE/xl5aQLXkwzqLKZA0ou
	 d0uIt8Hwvp2ug==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org,
	acme@redhat.com,
	irogers@google.com,
	Junhao He <hejunhao3@huawei.com>
Cc: jonathan.cameron@huawei.com,
	yangyicong@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxarm@huawei.com,
	prime.zeng@hisilicon.com,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	cuigaosheng1@huawei.com,
	mingo@redhat.com,
	james.clark@arm.com,
	renyu.zj@linux.alibaba.com,
	jolsa@kernel.org,
	john.g.garry@oracle.com,
	kjain@linux.ibm.com,
	kan.liang@linux.intel.com,
	mark.rutland@arm.com,
	ravi.bangoria@amd.com,
	robh@kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf pmus: Fixes always false when compare duplicates aliases
Date: Tue, 25 Jun 2024 21:01:46 -0700
Message-ID: <171937447098.2860644.3823008923122929164.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
In-Reply-To: <20240614094318.11607-1-hejunhao3@huawei.com>
References: <20240614094318.11607-1-hejunhao3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 14 Jun 2024 17:43:18 +0800, Junhao He wrote:

> In the previous loop, all the members in the aliases[j-1] have been freed
> and set to NULL. But in this loop, the function pmu_alias_is_duplicate()
> compares the aliases[j] with the aliases[j-1] that has already been
> disposed, so the function will always return false and duplicate aliases
> will never be discarded.
> 
> If we find duplicate aliases, it skips the zfree aliases[j], which is
> accompanied by a memory leak.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
