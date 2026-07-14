Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398E834F27B;
	Tue, 14 Jul 2026 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784049424; cv=none; b=Fz1keocxhxJXm42HyxJ9KgAy4OuGVC3N/1tPaImRL5EDZ4KViW5jSfKHEyBkI/bEVWDnYsoZEguDCFIhC56mr0SPqud2hjQE87IRhPDd0ORs7krGLApQC8qD7DIIkdXvd18UgT6P3S18F8CW6nUIKNkatnPOApNpxMjlWUQuqOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784049424; c=relaxed/simple;
	bh=F00dEFoYaZPUHRSJsBe2o3vnKG21Du/AfiYCZpXXSgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBZR/DJP+eftOvIALpeZiDGhYoI/KK9r0AwyfSDJo3bYefFNW15Fp5G+y40X16/b2EXcUlZeeAaNjYfgZcwKSGllglXQjmCaUzZb9DOVq0j6hcenO0McBvtT2NTneXKp4kaymEIaEnoc5INfpOOLVvw50F7bQEat8ZKISBavqsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIJ2Z6/x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIJ2Z6/x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB55A1F000E9;
	Tue, 14 Jul 2026 17:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784049423;
	bh=YFd2ODVNqCT1i8ipJRx3ooKY5rDmdUuflpX3ddya/YU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IIJ2Z6/xGS8lxnZR3YJnfAhZfDOQW7vt9o/So/kKG8bQTrgTgP500Jq6ijc1qaO06
	 BkaJF/h7ktt+o1pmWXWE/oX21HphjricQdlTPgLZo6kqh7uDTu7enedxqItWeGPwL7
	 kYIjo7VQUjIskxtrqTGZ8+8Bkj9KvWpo0sA7kQAkoLaRN5S+updcPV9PhXpbIj+tas
	 urAcyq3+BsSSEXoejd9vA5rRKmBy3yNn8SFuXnp8FcaAJ/V5/K4i2p3T/sWyFS36EM
	 gESkqO2RtXEulny2xYYvhFM/MLhbnQ8rVikzUzy7UWszkCZfVHUXAy0/67B80yhUv7
	 iRxGA07A5HA8w==
Date: Tue, 14 Jul 2026 10:17:01 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 2/3] perf sched: Fix memory leaks in perf sched stats
 report
Message-ID: <alZvDSIYFRnYkTjk@google.com>
References: <20260713234536.2280374-1-namhyung@kernel.org>
 <20260713234536.2280374-3-namhyung@kernel.org>
 <20260713235452.912481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260713235452.912481F000E9@smtp.kernel.org>

On Mon, Jul 13, 2026 at 11:54:52PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Memory corruption and NULL pointer dereference when processing an early PERF_RECORD_SCHEDSTAT_DOMAIN event.
> - [High] Out-of-bounds memory access and crash during second-pass list iteration due to missing bounds checks.

These are pre-existing issues not related to memory leaks.  We can
handle them in a separate patchset.

Thanks,
Namhyung
