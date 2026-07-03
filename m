Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C172F7EE0;
	Fri,  3 Jul 2026 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783111074; cv=none; b=iJhA3+kOWBfQIS/x7mjkrw/yD5njOltd4nt5lvU6JhE6Y3csBtNqpNhaxgaOPx3GQjfWjpA7iwPZN+1qj7vqubEiaZgmwF09wy9CxwrPcGhXDDJcejql8Fd5PoQ9b9kOClLxOrUVTu0W/ryLXF3hpumJoCEsdpGQK3+4PLORIns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783111074; c=relaxed/simple;
	bh=Za9yXvHkQfkjJXXt6uymBVw0/gXHZQ4lI42vyR/M4EI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Wnpek/GjEDR++y+Nh3rlXA+5Kw3rwnTXVBu8MHW2TvhyW3TRZdkRLDzHteOAZYg96jFx/b5GxN9Tsi00XNJlkjSVNHTJkYPryFnxy2SlVZCj5j2u1tKO853ZqWgAuqTeSShsI24Lq/8HIvPvD+lyg+XbAAT2Qz9/Y1QZU8u9aRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UM488dx0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UM488dx0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA0C1F000E9;
	Fri,  3 Jul 2026 20:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783111073;
	bh=sVGdAiH3yeQ0fimEbXiACYn+zkk4nvtbcqoiQIxMUPg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=UM488dx0gdhDmFNVdA5hH5XsfE2zlLXLXdlrPk6Q7vJZFLjeSPGIPi7xE8Z+BEn99
	 iKHxSoRU2BOrxquVNYQxZEpwKQXs96iUd87Gb8MaroyfPY8b3KE1O5slM1nLyqLyzk
	 ghAs3izqG6gGU6F0/7PnkFaEk6mQBBMLZUx4Y4DUMGev9nlprhR0w6fP0LSbAxDKRy
	 yh7C3AQjnAHfYZYnFgCv2t5SETCOBGrU5C3XBYc6wv5xEHUMwCXC1pBxdkK1NCh3OX
	 Y7wewQnp6SMtIZTATQdQN6Dctb9h4NXY6YkTQvEIiltQP+Hf6JTK3xiTI0uUUqovXg
	 7LBRRos7HAqFw==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 Trevor Allison <tallison@redhat.com>
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
 jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
 james.clark@linaro.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260626182739.53294-1-tallison@redhat.com>
References: <20260626182739.53294-1-tallison@redhat.com>
Subject: Re: [PATCH] perf build: Add LDFLAGS to dlfilters .so link
Message-Id: <178311107301.772470.790326592630391585.b4-ty@kernel.org>
Date: Fri, 03 Jul 2026 13:37:53 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 26 Jun 2026 14:27:39 -0400, Trevor Allison wrote:
> Build-time linker flags were not applied when linking dlfilters.
> Pass LDFLAGS for consistency with the other link rules.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


