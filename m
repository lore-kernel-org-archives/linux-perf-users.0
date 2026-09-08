Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E7B48F01C;
	Tue,  8 Sep 2026 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788905305; cv=none; b=ZUvbR6UUDcCg+M34p+EizF9JPzADiHG5DliThBIzOv3Vqz1hIwUtsv/fMpmt+rqWNX+AdM0AuBZU9xpVP8+0nLHZCE/E3Ah6PEJw2P5HPwLVC55w49wvNmcz8QPf38wwpIxppqmvXHVeI5kpnTSbWxzfm05xRUp5LaJQ+13t8xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788905305; c=relaxed/simple;
	bh=K7Sgj//k3LSpDDnnkUDYla2vUvLEHdOhl0+MPce5hp4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=R8k797RU71bHZe5yuMu5WHd10ttyov6UPjAuGSkE9/U+StDhPgQifY+zZcQBWQaqBxj7xORjHFZF3elxy+IU+bex0nW1GiJlxDudnQaDwQOnu5RD0hMdySaXHy1nO7kfXnXKoK4Ces7jfG5D/S5STu/eB1DhYIcvyuYBWpxIRZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUaKFQS9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUaKFQS9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315291F00A3A;
	Tue,  8 Sep 2026 22:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788905303;
	bh=hClBpnqNRj3SJ7e9iMNGOxdDeCVPyI4ivqixfWlNz3w=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=IUaKFQS9pSbsIw3Tw4ZHjzkSPlkXdgSekB0QZADMLyC9l02rqPlx5HMsMZQNahhno
	 CBsJEri9/8xHohyZAPxgf+/wh4uNIz4lwoFGdybGZ+/SQXy9Kk02Dw0ORRQ+aeOnAK
	 pdzFKgaWX49gc/q5ThZZ3Ib0H+Ni4cVddbjVBBpAsmZiIXfNUuG/DmUWigN84twJ4I
	 AIWEo3y5oQ39r4OzLJasw/H/kulelGZR9cDw73TIwbu1Fyw7/BKYiTGrX3D/Zycx9L
	 Lum26mlvCLX7buptthf2yGvKxERq64bKiKMONvKtGZ3mnZyvFCpTiU/uCwbNKK4qmQ
	 ncmAJjXauyYwg==
Message-ID: <7942d2b1-8e0f-4707-8c1e-604b66d2ecf7@kernel.org>
Date: Tue, 8 Sep 2026 23:08:20 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next v3 3/3] bpftool: Scale counters and report cycles
 per run
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com,
 linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20260908-bpftool_cyles_per_run-v3-0-60e86f325c35@meta.com>
 <20260908-bpftool_cyles_per_run-v3-3-60e86f325c35@meta.com>
Content-Language: en-GB
In-Reply-To: <20260908-bpftool_cyles_per_run-v3-3-60e86f325c35@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-09-08 07:27 UTC-0700 ~ Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Perf counters can report too few events when the PMU multiplexes them.
> Scale each per-CPU value before aggregation.
> 
> Use the same CPU set for derived ratios. Report cycles per included
> program run, and preserve the total run count in JSON.
> 
> Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

Thank you for this!

Acked-by: Quentin Monnet <qmo@kernel.org>

Apologies for missing the review (and your question) on the previous
versions of the patchset.

Quentin
