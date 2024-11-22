Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F27170A01;
	Fri, 22 Nov 2024 20:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732306087; cv=none; b=snQG4hFEnf/5YAssifXxEr2l7vvpmf01ew+MHWm/j6iWnuh9gCT1wPa9wQCAeAlvZFmuOKX53nrrKwDkOfUYBeUgPL2ZA1jzUN0ujhXWdo9Bixxu9SW3bU64Ev38UX0MOGsS3evwWRrEV1+mRjWzh2gPZwg1DVkZqmdnvlEQnmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732306087; c=relaxed/simple;
	bh=H0WGmc4fhp39hrLk/vQe7lwz9wX1lQ6E3eONcDXE/oA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A9NCzTSSh7IykUD+w6XvpBsmLMD93CBttv418Gqbp6J9kediD+ifSyl9J4Wfc+4Nt2TV5KFketuJCALw76oPHNcagyACoXm4V+nMGF6syZliZ6f58q1S2ut5EsJiZOAv7N4HlZ5ROvqJv/fWV6KLkVJPjxOCVUVMBJjmFtdN1RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlYmRLNc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlYmRLNc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AD5C4CECE;
	Fri, 22 Nov 2024 20:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732306087;
	bh=H0WGmc4fhp39hrLk/vQe7lwz9wX1lQ6E3eONcDXE/oA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rlYmRLNcffA8BvAM4uw6etJfi/PZzuVciDoR8K2G4yoTG/5mD3yMLjxsgG3TGWANb
	 3doU9hmKBXdKwDtm8VOPPY3ZSrU1Idx+Cb4qnY4RnHZFRYc0mCS5zJnt2EUZVdkYpk
	 9LYkwAB6pQqx5JJLgxu8Q/0ImqAUtmjZi4/P1ZOKMgCCk+oqzrgvWTc6I2N++Q0P3q
	 UujM2u8gxY4fSw0r+LLgdXJIs1+3Q58aTxXI5uJV/aNA5GV9ZLbxZ4hqIUz4bcipFG
	 4j1d/2tl6uOhhVUFP3q6zy+2Njw9ORvRCLNvMqRcoTeECfobtjuu/vo+a1365PtVpY
	 NlffSSWBsg9TA==
From: SeongJae Park <sj@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	linux-cxl@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxarm@huawei.com,
	tongtiangen@huawei.com,
	Yicong Yang <yangyicong@huawei.com>,
	Niyas Sait <niyas.sait@huawei.com>,
	ajayjoshi@micron.com,
	Vandana Salve <vsalve@micron.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	"Arnaldo Carvalho de Melo" <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Huang Ying <ying.huang@intel.com>
Subject: Re: [RFC PATCH 0/4] CXL Hotness Monitoring Unit perf driver
Date: Fri, 22 Nov 2024 12:08:03 -0800
Message-Id: <20241122200803.59369-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121145852.00000460@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 21 Nov 2024 14:58:52 +0000 Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Thu, 21 Nov 2024 09:24:43 -0500
> Gregory Price <gourry@gourry.net> wrote:
> 
> > On Thu, Nov 21, 2024 at 10:18:41AM +0000, Jonathan Cameron wrote:
[...]
> Just working out how to tune the hardware to grab useful data is going
> to take a while to figure out, let alone doing anything much with it.
> 
> Without care you won't get a meaningful signal for what is actually
> hot out of the box. Lots of reasons why including:
> a) Exhaustion of tracking resources, due to looking at too large a window
>    or for too long.  Will probably need some form of auto updating of
>    what is being scanning (coarse to fine might work though I'm doubtful,
>    scanning across small regions maybe).
> b) Threshold too high, no detections.
> c) Threshold too low, everything hot.
> d) Wrong timescales. Hot is not a well defined thing.
> e) Hardware that won't do tracking at fine enough granularity.

Similar questions can be raised to general hotness monitoring including that
for DAMON.  I'm trying to summarize[1] rules of thumbs for DAMON tuning based
on my humble experiences.  Once it is done, I will further try automations of
tunings.

In future, hopefully DAMON can be extended to utilize CXL hotness monitoring
unit as low level primitive for access check.  Then, the guidance and
automation of DAMON tuning could be just applied.

Note that I'm not saying DAMON should be the only way to utilize CXL hotness
monitoring unit.  I'm saying DAMON could be one of the ways :)

[1] https://lore.kernel.org/20241108232536.73843-1-sj@kernel.org


Thanks,
SJ

[...]
