Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF217260B;
	Mon, 20 Oct 2025 02:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760926321; cv=none; b=NEouwGymESKz+ClzcqOr8shZk5ERhGR1+QGYeY7uM9IYJtKauP2eGNd7siW/1bfVP64TtlUMdIaFCsWld+Mc/goQiEBPdQb2QZNn1Wx3rjgFNC4pc7RqShhHUXZqmhUTCbscPgGsCF4yFIu2GSffImkbpcp6GkXV5kKOjPrmnws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760926321; c=relaxed/simple;
	bh=nk9lUQ57FowhzDUDoZD7IXuyNjD/OC9kujKEQlryVIA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DQ7rk3hMIEw8WaNu9GRejQuKLTQvh2nbCO9fUsjIpBHzX0V5P/WKA4g+CW3+kgcT4JI4I2fAr7ajtm7E5tDYAt1TlFJlQUb/WyLkQwE811E6WQpU0MwnlLHgez3WLb2U0OMjvHrTA2f22jldifsOBrNNdOWzEYRx8VBSX2pweW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itnrxwY6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itnrxwY6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4607FC4CEE7;
	Mon, 20 Oct 2025 02:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760926320;
	bh=nk9lUQ57FowhzDUDoZD7IXuyNjD/OC9kujKEQlryVIA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=itnrxwY6BN35H7Hml0n7qNchdhlrJp5ylV8WK0iJH+46qUfbGfPhNCtZ+z1UdXAvO
	 4jkdT/NgW1vOsOniJmWowdMdUPBaw9m6Dqne0/mhHW3TgODfEHccF/YzsFRdeKglCK
	 t88C4ZFaXMepfQ3s5xGxh0s9VZJRMKLLin6tAt/m2HQYFdaKzos5hOtIDpLUq9Dyao
	 oUc813j6HalmhXjAHV0PLU/SsJM/XYrQAwWbjz+bFtwy6sVYp9+Gyqq5VvF/SXcyJ/
	 Ayec8Pi994QzuUiKy18s7jpn6chkLjyrxWeiSuAJpfHzqMj9Wv4I27TnPta5D85B42
	 PqWq/Ptxrri0g==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>
In-Reply-To: <20251018045902.21665-1-irogers@google.com>
References: <20251018045902.21665-1-irogers@google.com>
Subject: Re: [PATCH v1] perf trace: Don't synthesize mmaps unless
 callchains are enabled
Message-Id: <176092631797.143093.15280030045114294969.b4-ty@kernel.org>
Date: Mon, 20 Oct 2025 11:11:57 +0900
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Fri, 17 Oct 2025 21:59:02 -0700, Ian Rogers wrote:

> Synthesizing mmaps in perf trace is unnecessary unless call chains are
> being generated.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

