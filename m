Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24978433A0;
	Wed, 26 Jun 2024 04:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719374547; cv=none; b=f+NczlKifalmoG+QG/VVYBjKKP/NfAcTgetmmcSdhQn89J1uHQ7/yjJb/iOvOONplndssE+fICdNfScSTKx/QepT+yXWxon3IM/kkOxldC9mLHK8GBGMWwz/J1MtiIFU89XR7X56tBJdsBd+bAl55R/9Gq+lZBbgop6lRxwhPP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719374547; c=relaxed/simple;
	bh=ySmJQO2StpSihnjR74Z+emSnGENbsI/nQFKN5NxBaL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NpWMFUWM1IQRRPfVMXsJZBH5HJ1fppgbyVOYnIzLzGEwJhbJw59v443BtTX+qyMpmPQOW1gGdzRpYpvDVvUOSR8ZKY3q/Btm+5ZIhcqpA7DDJ127ElYshKaL61grMArRhVc5zkOx2+qDEZipOtNrZbLtwdcX5PKIg9JtSjsQe88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SM0Dqoxx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SM0Dqoxx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79ACC2BD10;
	Wed, 26 Jun 2024 04:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719374547;
	bh=ySmJQO2StpSihnjR74Z+emSnGENbsI/nQFKN5NxBaL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SM0DqoxxLR2FFwwupvkzz/F+pngga1yNhhDBZHz/bALda8PbNumRMWZSDoJ+Q5Syf
	 /6c4rdc/wtiR/8J4VP760ytFRDElnGA25Fumw1bp5BYgZr3VXpk2b5QbWPQEMdukBW
	 gpsxjYH6AdOYu1Aku6qKrxhw5p6tMdwQtcCp3yCme0Byf8JCBlmwghrHFqUhXcP0kL
	 XP7fj/SUDFCx/r7+VWnl5Z0U30IxC4TJTQTrZrF/ND+nOQMsAQ/p09DPuPbdMnA7Ei
	 TYYnTc2NjbYEghGPrJL0jhsrzhQ0QP95YwOrxibVBJFglPopAHwp/+WW2hb4dnA0Dj
	 Uft+BdNQAT9gg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/4] perf tools: Assorted random updates and fixes
Date: Tue, 25 Jun 2024 21:02:24 -0700
Message-ID: <171937451717.2860946.11251220985425097175.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
In-Reply-To: <20240621170528.608772-1-namhyung@kernel.org>
References: <20240621170528.608772-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 21 Jun 2024 10:05:24 -0700, Namhyung Kim wrote:

> I found some misc updates and fixes are still remaining.  Just sending out
> together.  Please take a look!
> 
> Thanks,
> Namhyung
> 
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
