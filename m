Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1424C26562F;
	Mon,  3 Mar 2025 16:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020936; cv=none; b=FkeIQ9QSYj63Qs8f+b9x9N5W7igamLkLqDIFZyugyUfICkdossaU51LQrkXlrKwk8TPKrC18e+kBYuqWaYJDtfkxOIdMvvkKOK19aMpqKdtgzXyq2wbcMLvd6X0+r5jxpbg9+LDPMxJs+74BpOprGMuqd3jQhNKmwj85ipdg/5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020936; c=relaxed/simple;
	bh=4b2iAAXnzxjx2KNwXEErToGyYeBBBJqenqp5NpTi+Ts=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gINzTb8NOHW7QT/3OgufJlnZ84AY1CV5myUqZkuKguEiUD8WOjASm+LpJOkS/D2wjfUNjwRP49geSGnwHkU3habS8FqXmFRud+mc4j3T66H3HlB5/n++ekPoR4AA291V0/HNDBhSAEAnhodnK3vfKP/Z1HwIDBlsC6nDJtXeBDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRUGQn5y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRUGQn5y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2922AC4CEEA;
	Mon,  3 Mar 2025 16:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741020935;
	bh=4b2iAAXnzxjx2KNwXEErToGyYeBBBJqenqp5NpTi+Ts=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kRUGQn5yi/ah1EqGttgZMoWBp8HQEXGvmxRmnBXVJlk5WyVYNHUBujLw2HZdMezNW
	 wuOuX7eFGbb1usrHTv+c3wHnSCSrHK97nJC+wqMa9i72ls3/mISdmhwvmNawsDGkK1
	 PMHrJx5pZxLPjkgtqETidFgH+OcFEY8a+sKjBYTJ+ZZFIMMhkttu3Khucqu1c6QeV7
	 JwXryJOqkDZ6GHcLqdSwwtb3NKu31oN+9GEeK4EqOZICq6LCUqHpk2GiKZPGYb3f+B
	 39+ulE1BDJTgWR8APJk2HGNi3/QL1qXfr/QFHZpbMJJJXaLM7t2B8KZ3V/BfmGdMG/
	 XUJd1rFMBwFrw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, Song Liu <song@kernel.org>
In-Reply-To: <20250226203039.1099131-1-namhyung@kernel.org>
References: <20250226203039.1099131-1-namhyung@kernel.org>
Subject: Re: [PATCH] perf tools: Skip BPF sideband event for userspace
 profiling
Message-Id: <174102093512.2010975.13598814458942907316.b4-ty@kernel.org>
Date: Mon, 03 Mar 2025 08:55:35 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 26 Feb 2025 12:30:39 -0800, Namhyung Kim wrote:
> The BPF sideband information is tracked using a separate thread and
> evlist.  But it's only useful for profiling kernel and we can skip it
> when users profile their application only.
> 
> It seems it already fails to open the sideband event in that case.
> Let's remove the noise in the verbose output anyway.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


