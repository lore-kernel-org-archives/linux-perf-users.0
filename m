Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6127C1B4156;
	Mon,  7 Apr 2025 17:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744045562; cv=none; b=nHsWUP6ClQmOKmsN61iyvWdJW5OlTAjfDjyL0xooRll3j+O0QJcVu+/aNjCXVsWcusMIwfO5E1u2H420B0Vje6AV/WwfWMcixi7WiLCIIQzvR3BsVtX5QyDeKxDsTLXgAVmquNggURLoH4b6vyafoH11BCxrVzGXDnmyEilX9Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744045562; c=relaxed/simple;
	bh=9V0lfouGxb5UozP7FtMEYe9s2GtpCHTjoBx36GD2Qlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIi/8shyOooiOOB/BQIXXtB6WL2UBqp9aYPwFlcR/gG+uzIijX5fgP+sAL0eQlDX+wVhy8yPZoGEWqtoBv7W7gs/fEDjOOVl8hf10+fcD6I6cuHP2hwZJaDf8KMZYqWb7kFI6N8lm/SBUUHjllp4aQwR+FP4DgGjKSe6qoR5uSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/+VevJb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/+VevJb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA755C4CEDD;
	Mon,  7 Apr 2025 17:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744045561;
	bh=9V0lfouGxb5UozP7FtMEYe9s2GtpCHTjoBx36GD2Qlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j/+VevJbO6nXb6efJ/NAN8+sUvGwif2YsuAM6CyluJIekZnpnuFSQKSQ55EjvFo20
	 VJs9EUREZwI+SJ4razifPQTTg2vZb9EBpNRt3udJ9uQ+Q6H7kLXG8ykCCHBBe76/SP
	 lVG76iCG5gXA7UdNCh0QMAVb2rUHoFYYZu7O9vRij4LoqvI9Bc8BVtjmUh6KU3nDxc
	 fjWEYcJHqUvKekC2qi44aLG3mWpnyRsw5lvGsoRSNAaVKY2DdvZ0/qX0wQtl9pveq9
	 CItszg5yvM4xn9Qw7KNYGjZa2185La6hrjeYs7vVie6wMhS1VnYiX+oYVzjjQSChyM
	 3NCfzjhBou3jw==
Date: Mon, 7 Apr 2025 18:05:55 +0100
From: Mark Brown <broonie@kernel.org>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, thiago.bauermann@linaro.org,
	yury.khrustalev@arm.com, kristina.martsenko@arm.com,
	liaochang1@huawei.com, catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] arm64/gcs: task_gcs_el0_enable() should use
 passed task
Message-ID: <e786824f-c339-4ebc-bdda-11c240b0e4de@sirena.org.uk>
References: <20250407161951.560865-1-jeremy.linton@arm.com>
 <20250407161951.560865-2-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dpNB0fpoEEl2bnSN"
Content-Disposition: inline
In-Reply-To: <20250407161951.560865-2-jeremy.linton@arm.com>
X-Cookie: Meester, do you vant to buy a duck?


--dpNB0fpoEEl2bnSN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 07, 2025 at 11:19:46AM -0500, Jeremy Linton wrote:
> Mark Rutland noticed that the task parameter is ignored and
> 'current' is being used instead. Since this is usually
> what its passed, it hasn't yet been causing problems but likely
> will as the code gets more testing.

Reviewed-by: Mark Brown <broonie@kernel.org>

--dpNB0fpoEEl2bnSN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmf0BfIACgkQJNaLcl1U
h9CBHgf+PvE8MD+KytGjnYRLpCcxcNcm3+mVrqBbfnyr/Jwxx/PfLhkgt5YGCuAH
spQ5q/5j0j3MjBPvdBP1xen3M3vFvsnlz1RAGK9vpbe67lLaGKioUv+5SbuepvJg
cW7KGtZINGAJRJx6OnVojBgdbCx4CY10+uLap1B0XW/wH9xadMK8o7RsmfHGwYiQ
dIGjCH2nZY128IluiEtdI7lUduVZOcvV3+ZYNypRzeHpDT7xWNlSw9InZK6W5LJg
oKGsNFEPQ3it8kKOzyhZ8yYA2YiEceXtQf3NOZlee91Zjr4JE2z3l/f6uqAEtWdx
q+yHWxpyDdVUs0gEg+xmUUQ86KwPcg==
=hlgQ
-----END PGP SIGNATURE-----

--dpNB0fpoEEl2bnSN--
