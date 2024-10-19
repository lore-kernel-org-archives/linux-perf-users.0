Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C096173;
	Sat, 19 Oct 2024 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729354992; cv=none; b=n+xE/c+WcwCrWlUqTc0aqJr5UV6+kOW0O9ONaOZpmeF6l8XHv+KjiS0w9d3AMP2iQvxD/I7ZBLR4EffYP4ulY/0tuik2PkUNO1f5sPt9hOvXZZipjZ4RDaTYkaHrA4UBY3WajJe93jnCSRI9mhjrFUC91kBEgbRnrIWBQFWJXAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729354992; c=relaxed/simple;
	bh=mcuO5wxNXqpn40QCC+5ATBwUwZ6THwiREuzChC5wZhg=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dwR962oQ7Kc2vkyh7j8+zDxO7R+9hb/Olj4P77GTDmzD2dyCeGjBIYXPCCI+OzwiNzg9EKERhc8kCATxMAkBwce5KUcp9pCSW4NjhqhZt/+jinWZD1n1NaWNIaWcrl/MzhuBB3c/VwBqZTTr+Qf5pZWo7f9W8l6dv4wwQ8QUsQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONVh/KVY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONVh/KVY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A9FC4CEC5;
	Sat, 19 Oct 2024 16:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729354991;
	bh=mcuO5wxNXqpn40QCC+5ATBwUwZ6THwiREuzChC5wZhg=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=ONVh/KVYXZcbyCX/rGFoDGAHAX3cUfatQe9BIzEkW+srF3i+8XT6QIvCdSwdNzqEz
	 MbZOTgy4C072BCeXEi4Wfu/m8yZtoGKyDfdOnvm3H0LaTuAybHagzmeMZ+CFRU7JWY
	 pEqPPi0nN/lCLuWzZPfl+xIb3U/Q60wlGIE1V266vBIgYCRvgfpuUOJMg7JNhhz87H
	 DNTdS/m4JXnQyl33iR2w8kR/VZrXqzJa2/6J6rVSZksA0cUPjQEwclbMwzU2gCLFuA
	 cBgXefQujb3z7+czO9JNqnzMR7vkM1ETIMHbDb45LRDR1axbTB9bHrWm648TMQh1gX
	 OVzrGzTyPOqyg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
 Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Guo Ren <guoren@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Nick Terrell <terrelln@fb.com>, 
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
 Changbin Du <changbin.du@huawei.com>, Guilherme Amadio <amadio@gentoo.org>, 
 Yang Jihong <yangjihong@bytedance.com>, 
 Aditya Gupta <adityag@linux.ibm.com>, 
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
 Huacai Chen <chenhuacai@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, 
 Atish Patra <atishp@rivosinc.com>, 
 Shenlin Liang <liangshenlin@eswincomputing.com>, 
 Anup Patel <anup@brainfault.org>, Oliver Upton <oliver.upton@linux.dev>, 
 "Steinar H. Gunderson" <sesse@google.com>, 
 "Dr. David Alan Gilbert" <linux@treblig.org>, 
 Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20241017001354.56973-1-irogers@google.com>
References: <20241017001354.56973-1-irogers@google.com>
Subject: Re: [PATCH v3 00/11] Libdw/dwarf build clean up
Message-Id: <172935499069.2388898.6689149497765145884.b4-ty@kernel.org>
Date: Sat, 19 Oct 2024 09:23:10 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 16 Oct 2024 17:13:43 -0700, Ian Rogers wrote:

> These patches were originally on top of:
> https://lore.kernel.org/lkml/20240924003720.617258-1-irogers@google.com/
> where it was pointed out that a lot of the libdw conditional
> compilation was due to features that have now been standard for 10 or
> 15 years. The patches remove the conditional compilation assuming the
> features are in libdw where the feature test is expanded to check
> there pressence. The patch series is now on top of:
> https://lore.kernel.org/lkml/20241016235622.52166-1-irogers@google.com/
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

