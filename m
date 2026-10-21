Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590606;
	b=teLkrUOZTyNkV++9Ng2h14lbYLXg7GoV8+Z0CwStqpJMn+Cu9+HjbUfq2WKD8I65JKJ7
	 78KsoLUEhhUv8MxQpzayjCq5i4WNpLfmAhU+G9Dc4k2PGuPyOhwd9fZepDdqnaf1UTcQg
	 ySPlgTCK6nwQpCcMV/sZ3Gfr53q/zRA25+JNwP2WNHLKwQNg7RGsIaIqsFAK+oOonw1Il
	 vN0UGOnB/sX4Xg9oQxGQCXs9ObyeHkIUmTzXT+ngQHkE6I9IFrUeh0EX6M1Tt6bKFk9eT
	 DuO41HGq114RciqqyFwU4s1vTsY1GAgKIfVPIc97gai5njTmXxK+yzsQ8NJw0kDVVRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590606;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=v1YiWdLfzEcu7fQY4ueusVJXfXfBkH/pMzgprS/6y8s=;
	b=HJydo0dD7rHLq4DJfLmo/fZ+apTBFlhJ7Pu2rUuTIwAGZGc5ZIOLu0asNRS2JVA6cMVy
	 nmPHjTgset1qOk8wd2n2XWF95XOn9xFKNHCBOfDb7weZzDUEbWgSsW1c2JAH7aM2aHBIm
	 MG6YrzMajCVAoaul4zljN6wy5VvFyQYbtSbri3sLAtx6N0TXKnrFYHXJ6VqNdGXtGwzsR
	 zMdJHWft22EcCLwv35tYWbLXbSGUPMnuTagIJ6bcYmNqCq4NR4ErePm1oPnlfv03EwZ+e
	 xI4BA0ioXQFanLereYcgAW26IB8PpSKDaLMoa9KKxKjAPDoRQdF5tQOCQaixSgCUNPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tayxm9lZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2567F606A319;
	Wed, 21 Oct 2026 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tayxm9lZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1081F000C4;
	Wed, 21 Oct 2026 13:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792590605;
	bh=v1YiWdLfzEcu7fQY4ueusVJXfXfBkH/pMzgprS/6y8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tayxm9lZ8glz7CAEW+XpWoXqPogPvAVP5FyRHysSufMVpYFOd5kAHe4eGeJbgfeec
	 lN9UQ6X2/Svm+vKebPAyYr7ByWM+3x5XdfX8TkZij5/m5+vjiA6rkIP/rYabTfcAzu
	 IptdY7DH/bWaKtMjjuZT9anmjj9eoBnVO/+RTyv5Jbn2C3S2B1YcP1vZ9byQgNLmvv
	 RntpHNTTo3qYRgECnXOXprEcrGC2viaZg1w1n2ZdoYCWQwnrPthWmeAIBh3SFkglBr
	 3xt6O8Z9juiX9ctKSXg5b2Uazj542hNEOlHf2l2DCNC9TBxwApcU3K30t5eOWxwnE4
	 2GB3ctpiCEY9Q==
Date: Wed, 21 Oct 2026 10:50:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>,
	Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@linux.dev>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v3 0/4] perf: cs-etm: HW_ID improvements
Message-ID: <atjDCpTIrchbCLt7@x2>
References: <20261002-james-cs-hw_id-output-failure-v3-0-1d8b6ef339c8@linaro.org>
 <2bc4b058-3a5b-4a9c-a469-eb8c93215594@linaro.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bc4b058-3a5b-4a9c-a469-eb8c93215594@linaro.org>

On Wed, Oct 21, 2026 at 09:42:24AM +0100, James Clark wrote:
> On 02/10/2026 12:15, James Clark wrote:
> > James Clark (3):
> >        perf: cs-etm: Don't add global v0 HW_IDs to unformatted queues
> >        perf cs-etm: Free partially created queues
> >        perf: cs-etm: Respect --no-itrace option
 
> Hi Arnaldo,
 
> Is it ok to take this one please, Leo has left his review tags.

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
