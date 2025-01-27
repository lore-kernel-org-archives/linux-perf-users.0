Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790D018B467;
	Mon, 27 Jan 2025 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738002907; cv=none; b=M/Yg3cA1BVUyHWhA1oE0lqTzVa2QzoLYs2Tp11SrLJ2Pl/VwErnj5QTtFTnwdnAWTgdh2LzdyFrCjhFKSbdenoiRYAFOohgTonLMlWJSX0AMiZ0CtoB9MW7vvMrErUVJoLwGevkV5JBuxwr2yhxEj3X7PFdm494GtyllaDn4CNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738002907; c=relaxed/simple;
	bh=KkXO+wk63YOHnhFXr3OeVWZBpb7ezWakm+Fgh4Mep44=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oegSG9xC4gWH+z0v5sx8SSi3BtSke+zLNeVwd90QKajbe9zxt50TVvsSgaXUmJa/YUvFRoY8xvu1rWyJqaFbo/6tYd7NSJL7xMrhXWhmPJ5ihVkr1BMyTQDp8xKWNdgk8wnrdq+XDBTD5V7zrBVBY1mePlGZpa2HkAppaBUSTSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qis5jJH8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qis5jJH8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3190C4CED2;
	Mon, 27 Jan 2025 18:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738002907;
	bh=KkXO+wk63YOHnhFXr3OeVWZBpb7ezWakm+Fgh4Mep44=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qis5jJH8IIgKACEavyMcuokS/18NP7AIVI8XosrAZEtgmQPH315dl2+b2RsJg1hwz
	 GghfIc/9HnPf+573ZaCz4XaJa9Ni07RfRUVfvF0dDLLUDSVz2Ck5/KPKytolcljmwA
	 ysKcYWtz+vGDxWqeSMNysSP/GERehcJnL4VdvUE+g5KWnU4OnE1sJaiCyAmfxmyd/3
	 8M9P6LBBhSJXjaYNaAevprxz3owpU87sq+74L/lxfq+m7DpQKx/Ro/NJYmN1ApAj9p
	 4s1c4UOcJjU489IAIqicSemVESGqtlIB+ucIIEQheRFBdcPaxhSdfTREeeFb5UwDzc
	 Fq3oW1Lf7R1sg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Benjamin Peterson <benjamin@engflow.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250123-void-fprintf_tp_fields-v2-1-6038f8224987@engflow.com>
References: <20250123-void-fprintf_tp_fields-v2-1-6038f8224987@engflow.com>
Subject: Re: [PATCH v2] perf trace: Fix return value of
 trace__fprintf_tp_fields
Message-Id: <173800290695.34478.9011536215323080712.b4-ty@kernel.org>
Date: Mon, 27 Jan 2025 10:35:06 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 23 Jan 2025 15:59:35 -0800, Benjamin Peterson wrote:

> This function formerly returned twice the number of bytes printed.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

