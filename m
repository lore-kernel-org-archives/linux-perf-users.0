Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED6928033E;
	Tue,  1 Jul 2025 17:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751392515; cv=none; b=iYhE9Dnk1VcRcDn6vhyfDRJm9FCgEv9BY4si+WtA7ftDwqJgzCJHsb4309IAvq/UNn/s6gNN7IDYFAxKMLVk6poCxrpJRgggeW1MXAcrGrLa3hlGnB97vGJ4RXpKbrpI2CVdeBgTCpD6QJ5l2OJ3kdRQjgzTAhewG4tmAh3iVmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751392515; c=relaxed/simple;
	bh=v8+OLAuTiHAT1pksO527T58c3OopbPn4PuU74fWWd3E=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ADOdoLYVgKpUmNTZFUsbrKR/qnx7DLl9x9RHf79oT5UI5JiNQj0PNFQc6lqKzcl5Lrcsh1xfi+saN9q2C3D2+IQLyolJUhqMmE2TNA846eQuGo5YGlPWjuH0BBJMbN5VhQb3K3dH4xAxWtaOO5WZvEPs3nLYyhVfuKpvB69PuAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYJVIC8o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYJVIC8o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D830C4CEEB;
	Tue,  1 Jul 2025 17:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751392515;
	bh=v8+OLAuTiHAT1pksO527T58c3OopbPn4PuU74fWWd3E=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=eYJVIC8o60nMmf9asbv2HRdpxbMqRfU4vLIRXSssDrW6xAXvXBcY2PtIHStpyvlhp
	 48QeWjPpf6nTRe6cU+KCLzxNgRn+4wcq9l5HxW6PQ4BhJUeEAgut2W50yS6qNQkxzl
	 vIOG2HY1EAsMRRj9Zt0KU7w5TDJ/rmndO9LL4rDxk6gwTojkIQiWZFPfxoPHn4Bwpw
	 5lKa6mMaS1xy2P6/Zp/2gZf5SIKV8GOolXKD87Nz8/1gGxGZhPU/+IcOjkBjAi1sUg
	 mNgNdIYvawGPy1yseDX9A52EY3lIQ1/YZZ3BAdhRhZmoGWqRTc32wfSfvkql7RuR3k
	 McMm+bA6wOZmA==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
 Dapeng Mi <dapeng1.mi@linux.intel.com>, 
 Thomas Richter <tmricht@linux.ibm.com>, Chun-Tse Shao <ctshao@google.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20250628015553.1270748-1-irogers@google.com>
References: <20250628015553.1270748-1-irogers@google.com>
Subject: Re: [PATCH v2] perf test: Add basic callgraph test to record
 testing
Message-Id: <175139251461.738306.3668965739082793830.b4-ty@kernel.org>
Date: Tue, 01 Jul 2025 10:55:14 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 27 Jun 2025 18:55:53 -0700, Ian Rogers wrote:
> Give some basic perf record callgraph coverage.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


