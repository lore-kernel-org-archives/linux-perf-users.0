Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031ED49E15A;
	Fri, 25 Sep 2026 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346484; cv=none; b=Jg/76CRdZU+z7+BQBzwQFy7JlT4fN+puO5YZK+I4GtrjjFqwtsZ9toT84F3tFfQX2n0ig6j49xx+ODLiO5S6x3jpERuVRhoDY6a0ZU0d2uBEob/keneJhc8GXYgwTnlnK5He1f+QHrSbRXZ+E+vAkppGYzOYvWU0udgs0Krk6H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346484; c=relaxed/simple;
	bh=16gFGw7pnYBN5T2lrrKMq0hC2sJmi4qV0zpsGueGOTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QobgAkoH2k8k6Jez46Q/Q1nJolKhDI9kzlx5vRyJUhVun49lDs0VHEMnHDzkN7eSs/Tr679Yyy/Vgav3oBXc0dc1pT7TB3ipE+3+zS+0IgaOdL7vy4yHtwuAy2xYt535GV8q1MlvuvO4NQ6RCFNRGk9KC8JaYhYPl48QJbGavsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7Hi101O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7Hi101O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0883D1F000FF;
	Fri, 25 Sep 2026 14:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790346482;
	bh=eQfH6TWU+8kLhZyhYEPxSS41QwgjPG1zEmLcOr81UYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F7Hi101OPL3YCpxzXmrTUgdz9EAjilg5bruqCGyFN8XYnTggwvFY9ktsD0cyqpqjV
	 F+Q9N74ghoE1OA27zXBlSO3rSl0SXKqXXg2TatOUsj9/e6OKHY48AR9J1sz5t+ETrk
	 L/S+65XjsaECes/wG+K1/l3yy0iYOcjEyA1SKSWfBzuYjfLhcWHZcthQEgKekouFFL
	 sXVl/S+KaY+bSGfwK3zJQIJnGcYY8adupChLr74y6UUSl8XCfQ6N3fmg0AVkTZXfFY
	 NHH10AnqgZOjGTg4X2gnzmFkLLcJXvgj0z40/XKvPKChSsWDW1iA0HbYpyUwzmrP+B
	 z+uN60d6wb5yA==
Date: Fri, 25 Sep 2026 16:27:59 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: longlong yan <yanlonglong@kylinos.cn>
Cc: namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf bench numa: add NULL check after calloc()
Message-ID: <araE77-hIcOcWLdq@x2>
References: <20260902070913.1424-1-yanlonglong@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902070913.1424-1-yanlonglong@kylinos.cn>

On Wed, Sep 02, 2026 at 03:09:13PM +0800, longlong yan wrote:
> Two calloc() calls in the numa benchmark lack NULL return checks,
> leading to potential NULL pointer dereferences on allocation failure:
> 
> 1. worker_process(): the allocated `pthreads` array is used in the
>    following for-loop via pthreads[t] without checking for NULL.
> 
> 2. __bench_numa(): the allocated `pids` array is used in the following
>    for-loop via pids[i] without checking for NULL.
> 
> Add BUG_ON() checks after each calloc(), consistent with the existing
> NULL check style used elsewhere in the same file (e.g., node_present
> and nodes allocations).

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
