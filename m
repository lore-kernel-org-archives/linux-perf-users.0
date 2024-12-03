Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA7920A5D8;
	Tue,  3 Dec 2024 21:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263119; cv=none; b=R3Grjfj8fOjeNFLHG0S3cRIVdiFIunrNaMD4UlJ4XPhJqDCSYyEu7RU9uNPSVgYEBt83CcV0j2yVwcRd7sYFgYGN5BZaCW96VbKKgEtxUZfzEHGiEsuRHbPSqjhoc93Bls9iNQKqCORViTWUYw+377b4vHfIbvBQoIUzmPNwL1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263119; c=relaxed/simple;
	bh=zCP8DqFUziwihWgbI0sUuAd4lZ05ndb4Cx2/xmVnBYg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YvvuxvqrQgSB6upURKJ9B5yUOd5JVzhQgQ3qY6Q5AXFL+09LIji++j09R5Q4cNFUO4WWCBNp1f6cuIRh680rk2Z4HZlVJZFppinzjvs2hZN8K4lnb2MyiSnZQ0F6TAZv+xVL7YBG26xsk5z2VMoOC9hoWhQvNCaKkiQ/1g++SrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5ofcLhQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5ofcLhQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E70C4CEDE;
	Tue,  3 Dec 2024 21:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733263118;
	bh=zCP8DqFUziwihWgbI0sUuAd4lZ05ndb4Cx2/xmVnBYg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=c5ofcLhQ+/5l8kRKAuTy5H0PYIIefeQfnplAmjOE7Tu4+vwGpiccACz61NDPU250y
	 4uJCM3lKyXPZ7j0W726NL85FrTeW+TnZvdR2Bp8fWAbUpYpEM9w//mcwIxAp8vN1Jt
	 8/moXJRiT71JE2bVv4WpLWoYRCo1LnYh50ARgkaZz/Bxh+9U9ijRol8edksTR3acaW
	 aHXRV2H8/OknPgpPtO8lSAfs6h/Y1kUKINAu2SeIlz5zAEEi8kmk4FvUkiHWf20s7c
	 vwGIKcgAOXlmLktf99UM19vi2B7Mi9JYcjUiEAQ7+mJzL9S65RToLvPooDAkfQVTGN
	 /+AncimFgb92A==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Veronika Molnarova <vmolnaro@redhat.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>, 
 James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
 Kan Liang <kan.liang@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
 linux-perf-users@vger.kernel.org
In-Reply-To: <Z0XffUgNSv_9OjOi@x1>
References: <Z0XffUgNSv_9OjOi@x1>
Subject: Re: [PATCH 1/1 perf-tools] perf machine: Initialize machine->env
 to address a segfault
Message-Id: <173326311856.2683269.6372380713007833609.b4-ty@kernel.org>
Date: Tue, 03 Dec 2024 13:58:38 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 26 Nov 2024 11:47:25 -0300, Arnaldo Carvalho de Melo wrote:

> Its used from trace__run(), for the 'perf trace' live mode, i.e. its
> strace-like, non-perf.data file processing mode, the most common one.
> 
> The trace__run() function will set trace->host using machine__new_host()
> that is supposed to give a machine instance representing the running
> machine, and since we'll use perf_env__arch_strerrno() to get the right
> errno -> string table, we need to use machine->env, so initialize it in
> machine__new_host().
> 
> [...]

Applied to perf-tools, thanks!

Best regards,
Namhyung

