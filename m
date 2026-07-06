Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C23434E2A;
	Mon,  6 Jul 2026 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357102; cv=none; b=SQXjyavQqITOIM+NF5YcfOuPRT/idlMN7NM17Cf81j6SKQA32ALG25BH2AZH5oOnfqTM4KIfklxq+xvdAKVfPZKYYAZqXYLCm88TnP6DqBaNHjau/2YPOhR7bxLlroqjjqYRvxtVx6iV5otUOT0VXWI7Zak5zJiwcJLAFqNShBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357102; c=relaxed/simple;
	bh=iIkGRGBLO2AJq8oJuVduZ7tUm+/xRLpDbLt2gq1Jnxw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RxmYo0v0fcarete1RNf7xZkTi2I3nMjJZ9xI9jzibLdyIZ+h3pq7fK44GGui56SVTBoKl0s081p5h9yv1VHCmjVX8kcj2n8a5DZ/zGNNOKjaR6+PPzOgMucHwmLjlt1/kY245Zfm2JA+qb+xevrbdx53Rz96KPcwkyI0B+PDBPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0jTsi78; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0jTsi78"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E831F00ADB;
	Mon,  6 Jul 2026 16:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783357100;
	bh=KtMI+bnhEY5C1yiytYHDoewRWdbn2hl0eJHaVKfrGv4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=P0jTsi787C+T1oZK3LVsciYcAjtK9VOGkg9mGuCMFuA0ee0lhwCFjB3GOQbL4gSuE
	 ucZ06q7ag9lrNxp7hslNxj51WKDI6L+bDP9VJg3N/BhP3iZaSCHKl0ATjo++XFs7nF
	 1Z+15N9JH0jfgLW0bKJMrsc91av1XBtAnOca0nf77mL1P/kdXkSM9QS19U+qWJJN4B
	 TJo3SOoIGU2vGrlqCh7XEquejUnP3Esl+kIXtlD14CxsgT3rDV8oVac2XKZtZBqt4M
	 MaKARRKJKn00sO5ovo/i/SgUXLMx9JCNaq6k5lJ22Gpd44PPE6nxJyEeDF/9yrfrbb
	 txzEBhQIPfkRw==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>, 
 Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>
In-Reply-To: <20260624093316.1439582-1-dapeng1.mi@linux.intel.com>
References: <20260624093316.1439582-1-dapeng1.mi@linux.intel.com>
Subject: Re: [Patch v4] perf tests: Add auto counter reload (ACR) sampling
 test
Message-Id: <178335710038.2202965.12531774755192340308.b4-ty@kernel.org>
Date: Mon, 06 Jul 2026 09:58:20 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 24 Jun 2026 17:33:16 +0800, Dapeng Mi wrote:
> Add auto counter reload sampling test to verify that the intended event
> records can be captured and the self-reloaded events won't generate any
> records.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


