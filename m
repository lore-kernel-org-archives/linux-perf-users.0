Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F49B7262B;
	Wed, 23 Jul 2025 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291846; cv=none; b=ROAArxBRnK8HnnJ1IwX7XSwDbNEEAx4fpOWIRQBMe8sj4qYwZu5RKl5YeOdil4j8QZOzCxw4wcYxjkLn5SHLrBHYwsIvYEddqV0kjvW0775Zj3+ES8hOai38pdel9DMKT6+35d4THQIon27g37BWD6C/sQR60WtAKeTIE4rgVfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291846; c=relaxed/simple;
	bh=5kbDHJBDt91yPJpWqpTjlQNKjspG21vEOO5BD8wsh0I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=b2mq+Nd+E2bJM1cxrjD6F3ZxN5hB/YDkAreHiJSTiFmHDAU8938F6ziGy4fct6ODsIFC3dSIrEjSEiDLCZRzq/Tj36/pLVy6gROmyv3cKsIOIu9q8GDldUd7at73H9TtQxG3PXhHPAO9m9qfvovBQOmwgfyzBUsUE9Ng4nS2sHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcQRP4Fb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcQRP4Fb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42834C4CEE7;
	Wed, 23 Jul 2025 17:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753291845;
	bh=5kbDHJBDt91yPJpWqpTjlQNKjspG21vEOO5BD8wsh0I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DcQRP4FbjHC/WTvDxeSV8W8DJkm/03KnMeSpvt19yXTjDLMekFVq47AH50jYGX9/2
	 87r2oXesc8gGDsGcVAYNDKJ+YSMBG7AyORlumpCpjVYlJWbO0i65arMQQoXgf2eyoL
	 9As/MyDDLMKtiTOazxMJ/mMPfYPbjx6N9TnuQWOVDXsGNeQAMVlPJaJovK+BSNCjfa
	 TOz6Sx2i6RoWjLl/a6e4RWlB5BRWjiXio4a5vrhlnyu/x/9zwJHlobKZ+PlViNzsos
	 YBLCR1qnwzkBg7okNd0TmM8B024LB65iJNM4XyKxN5D2sb8s31mRzQeeNkTNmYfj6/
	 r7VKg6IlmSNmQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Changbin Du <changbin.du@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250613114048.132336-1-changbin.du@huawei.com>
References: <20250613114048.132336-1-changbin.du@huawei.com>
Subject: Re: [PATCH] perf: ftrace: add graph tracer options
 args/retval/retval-hex/retaddr
Message-Id: <175329184520.30139.10951827776162604991.b4-ty@kernel.org>
Date: Wed, 23 Jul 2025 10:30:45 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 13 Jun 2025 19:40:47 +0800, Changbin Du wrote:
> This change adds support for new funcgraph tracer options funcgraph-args,
> funcgraph-retval, funcgraph-retval-hex and funcgraph-retaddr.
> 
> The new added options are:
>   - args       : Show function arguments.
>   - retval     : Show function return value.
>   - retval-hex : Show function return value in hexadecimal format.
>   - retaddr    : Show function return address.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


