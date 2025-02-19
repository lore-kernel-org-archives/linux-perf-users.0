Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC4E1FCFCB;
	Wed, 19 Feb 2025 20:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997133; cv=none; b=E+iu4nE4E5G6SEVoCjTGWMCajrySMzNpULhyiseWSrViMzOdhbbVMoiruKdnEEfQcllJcYx6tusJyyjO7dkfVzho7U0dQEHIteANrVjPHMv/FtZWk4jb8FrP0cRbqlIsNOs8ZaQ3TMK1fo1tA2BKzkwH+/7MYx7HlZ3KMx0P23c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997133; c=relaxed/simple;
	bh=kw5SvaFEtYB8DCDg/7J+1Xjn10KUv/hk8BznPlVI0XI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=vCA6JdLoizxQ0vvZlGJ+Qq5zr25d/Bt8BjMsnw7yQbO51A3Lie1Z3+7t7OTtY61/qIHpyx3bGPrkaP1AkqU18X0xn0WJXtRUalK4oH9YR2/FiqIhqNmIyRlSB1PoAPrvLNgcPCzShIlESFtcGuptltArLMgq6yk67A+kgnoYr6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkScAySL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkScAySL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712D0C4CED1;
	Wed, 19 Feb 2025 20:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739997132;
	bh=kw5SvaFEtYB8DCDg/7J+1Xjn10KUv/hk8BznPlVI0XI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IkScAySL7a2E1Wlrhq4iFKRCMzHzz/iFbTOTe6Tyq8Of98WbeJp+DyWQx83Y3d8wy
	 udkfrqgjxMWJN3hhPD5AgxBxFz6NePYCEYJog+FQOyg0ZmEjephjutvR9q8C2pOnej
	 h+gK/RMxRdTd9HL9spiF6g8nufvld8azS7AN683GTGHaPKzD8o+LmxJBtD7AGP8VS0
	 yZY+kJXyEBNCoPxtHeV5/+WFZhXR3ZbjifVj1gjeEE7rr3jk4JezRYuRJLGJCxRXSK
	 KBOECRELk0zGi0G8qbPleBSztaks+x+dl/E1kNjoGqvShZNpPs9rFMIJOqcr1gVxe3
	 pgp+QGNlfWZMg==
From: Namhyung Kim <namhyung@kernel.org>
To: irogers@google.com, acme@kernel.org, ak@linux.intel.com, 
 Dmitry Vyukov <dvyukov@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1739437531.git.dvyukov@google.com>
References: <cover.1739437531.git.dvyukov@google.com>
Subject: Re: [PATCH v7 0/9] perf report: Add latency and parallelism
 profiling
Message-Id: <173999713240.1147192.6168999764219054461.b4-ty@kernel.org>
Date: Wed, 19 Feb 2025 12:32:12 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 13 Feb 2025 10:08:13 +0100, Dmitry Vyukov wrote:
> There are two notions of time: wall-clock time and CPU time.
> For a single-threaded program, or a program running on a single-core
> machine, these notions are the same. However, for a multi-threaded/
> multi-process program running on a multi-core machine, these notions are
> significantly different. Each second of wall-clock time we have
> number-of-cores seconds of CPU time.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


