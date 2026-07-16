Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2057F3A4F34;
	Thu, 16 Jul 2026 16:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784221124; cv=none; b=LomliPtI3iGQ9TiYQcTUM1/5g0+smViMmTBMbnNBU9Gp2w9E0HaXXu79MMAUdyeGdb5fwU76dyomddOEnQg0UN3bYEEENT6vviNoUbXt+N9DgkdSjwn3Sc845JTqWoOI7vAnjw02eMhjpla3sxMQroznL3MHGm3RQdSZD1GOqzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784221124; c=relaxed/simple;
	bh=1yYIFGnqhWC9Q1ApkgAv2+k3omKjnITL56Jx/ibEnPc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BwrMQuVtUrIMNbVh7TkQRA+OeL3Xz5Xq2LGgsA76UFudaU9xopzr9a7q2pPTk6n1SkbfAFCwhEhSH7YCszXDQefXXeGV75hsS5qLvvUNz3+1YSJL37XLK1zOaef3orbop2a3bYhCK6dXVA3Gwa7zGUEuv0BN4K0GDYwQzgPbYJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUgqT6zv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUgqT6zv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FF11F00A3A;
	Thu, 16 Jul 2026 16:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784221118;
	bh=Dchuk18guX4b9y1HzKuQN5d3s5FnjqEWAJbCaefKgcI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=KUgqT6zv1ChH4Kl7VQFASFDjxRcsbFW+tr/w+o7B1yDjUB+pbJsmnT9k1d0HUAO2Z
	 73dprTP1V8pKh0pggZR2h53M0o+iPYA0MhHkCWTb8iN22LEC7mFKBSrFrAriTI/deb
	 GkC26Xleln8RJs+Hk9mVcFcWpqAoywGzCpMppkkWM5IXZt/Estj2O1nSLzu8XFSd5F
	 /6Y+Q4FwdW86gPLSsJIiciVgJDMqyeFDMUh2TQ4xvY8jY1i+K4BfkMCcTaN7CtSkZp
	 pv2sWxhU3tPIu6KrP8pa+9GUI3lW1i6ZBK+mbTxNVyktdWnzw1Sy3EAHbifjMQxUJs
	 GwpZUDsR/RrAA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 linux-perf-users@vger.kernel.org
In-Reply-To: <20260713234536.2280374-1-namhyung@kernel.org>
References: <20260713234536.2280374-1-namhyung@kernel.org>
Subject: Re: [PATCH v2 0/3] perf sched stats: Fix memory leaks
Message-Id: <178422111844.3439510.5239617032829749854.b4-ty@kernel.org>
Date: Thu, 16 Jul 2026 09:58:38 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 13 Jul 2026 16:45:33 -0700, Namhyung Kim wrote:
> This is a small series to fix memory leaks in the perf sched stats.
> I've tested the changes with the address sanitizer.
> 
> v2 changes)
>  * remove invalid file closing  (Sashiko)
> 
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


