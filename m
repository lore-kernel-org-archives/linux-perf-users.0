Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0136C214A6F;
	Thu, 20 Feb 2025 18:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075975; cv=none; b=UAuJfiFFpuVF9Fow4jgniNiQ1Lu3spBZ5K7OHlN4mx+0JBubmPfxS1EzNpJiSVmfYnSq7cMLLKlZ7nZSatasfmxRpdNKKMxDI6HrU4GcuOZemZDA2/xxS4BB5T/GdYKHo0Zk1mgyT/5Wwfel0zynn1jSL5u/Th68aABspohLO1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075975; c=relaxed/simple;
	bh=fF4NKFqp3EuYjj6or+U2IeqKQJgw+vQ+u4MMJj32JQE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g+3d4G0cEHtYZ0GFUfK3azf+9WD4FTMso6bMhcF0gG2WWzYzGfvwPduh0ob2jucdqTHsYHTw0kG2hqv1OmhHkO3oGe2i3H3rbGDVtEjZLJCqpK4f4BF+i6v6w0md7uGDgfVD1jy4T74T+boZ/zg6okmNDX1Exdoll0gjIparr+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euOOVVtL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euOOVVtL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739D6C4CED1;
	Thu, 20 Feb 2025 18:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740075974;
	bh=fF4NKFqp3EuYjj6or+U2IeqKQJgw+vQ+u4MMJj32JQE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=euOOVVtLqPzlw1UQDh/Wx8fAHZxaeMSnHXPcyiN63ND+appVtRtsRdh/4dzsyELwy
	 JnZ/5+X+xLs7k4HXvt3GWmzn4gDoSeyWZNIAi0cbXRT3sPBdFs17ByTl4dwvuruJ5h
	 ekI7lBWOHd18nUbOJDl1sbhhIw2ht9LcP9dgKOJEGZkXHvlqjJaW+xJRvm0NW2mKPl
	 jOeCgnTZt9+Hm6aeIQ+MWA1H2IKbfw5rbqBMYjW3oomUdmqhf0GDGE1Ds6vfjXdWfe
	 jUr9IONXB9a6euNjjpf4JfB75tmVJgtom0TJaQDzz1RvYI7uQGVHcWxsF3mrRemavh
	 u/wxt+y46fHzQ==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, james.clark@linaro.org, 
 irogers@google.com, Yangyu Chen <cyy@cyyself.name>
Cc: acme@kernel.org, adrian.hunter@intel.com, 
 alexander.shishkin@linux.intel.com, fj3333bs@aa.jp.fujitsu.com, 
 fj5100bi@fujitsu.com, john.g.garry@oracle.com, jolsa@kernel.org, 
 kan.liang@linux.intel.com, leo.yan@linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 mark.rutland@arm.com, mike.leach@linaro.org, mingo@redhat.com, 
 peterz@infradead.org, will@kernel.org
In-Reply-To: <tencent_D4ED18476ADCE818E31084C60E3E72C14907@qq.com>
References: <tencent_D4ED18476ADCE818E31084C60E3E72C14907@qq.com>
Subject: Re: [PATCH] perf vendor events arm64: Fix incorrect CPU_CYCLE in
 metrics expr
Message-Id: <174007597343.1790567.6925222970795406098.b4-ty@kernel.org>
Date: Thu, 20 Feb 2025 10:26:13 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 13 Feb 2025 16:44:09 +0800, Yangyu Chen wrote:
> Some existing metrics for Neoverse N3 and V3 expressions use CPU_CYCLE
> to represent the number of cycles, but this is incorrect. The correct
> event to use is CPU_CYCLES.
> 
> I encountered this issue while working on a patch to add pmu events for
> Cortex A720 and A520 by reusing the existing patch for Neoverse N3 and
> V3 by James Clark [1] and my check script [2] reported this issue.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


