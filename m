Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1B93624DD;
	Thu, 20 Nov 2025 19:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763665351; cv=none; b=iMyy7sc/iFzqJ285sPUg7DUyb7/o2dMGJsjKe4uA8jOMCpZhqWaVN8UQ/p4JBIuvbFLHe23B4/U4R2TzbaAejLgwYuWwHcsdy97qn1mIT/twt1QS/bGkrGo47fLBhFPWV3eY3EC/Rlk2Vzbmd6CdLARogm8YAP9b04GsWOIsOv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763665351; c=relaxed/simple;
	bh=km9TFibaEgGF+2wlcomK1uiNd9/TnMdNVk2tKPjxGWE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dezuIIwRrCcA4DIWxH34tZDqcg0hw/zN8UGVLbVKQVIr8R8Cmd8mwR+w9a/r7zmkotSTX0yejuYzCWwGFo8E2SUmUnONqHaN5OnULdJQ58JooZ2ztoGt+KrsJqvv8Xd9fa3eW0MoSggKIsP9D5h+hH/DKUHTyPE9UIEMcfxrCMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcwCDbrd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcwCDbrd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5F2C19422;
	Thu, 20 Nov 2025 19:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763665351;
	bh=km9TFibaEgGF+2wlcomK1uiNd9/TnMdNVk2tKPjxGWE=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=PcwCDbrdFuXa1QhWoI71moUaWx33WcfWRIEzLG1nPdj4FABvmq/F8CEl5JRxj1wP1
	 S8MEk1mLLrVXdtFBLdehUzwIK3IEirhQNtxWuucTjmzkI64Wqp1jiQcOG47229qIMq
	 kH4+tLJXBTsWz/pSAO+7cUcxQKMgejs2qvTRbDmuQX3YaxJQ8yP4l9tiZfvQoXosb4
	 ZqupbE2XRoJjuf/bV3IGxt38DmzEkknGGFkkG9hehnHf0DPTWkGxWIvuzUHn2u1IO3
	 7wyttA5rNvG9rwMIDF58L6e7O07GLDzeX1cVJXzdTVkhPX9VbbtZIzhjF03fZ9EuYE
	 8q34BZTwH72uw==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
 James Clark <james.clark@linaro.org>, 
 Zhongqiu Han <quic_zhonhan@quicinc.com>, 
 Anubhav Shelat <ashelat@redhat.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20251114220547.496562-1-irogers@google.com>
References: <20251114220547.496562-1-irogers@google.com>
Subject: Re: [PATCH v1 1/3] perf header: Switch "cpu" for find_core_pmu in
 caps feature writing
Message-Id: <176366534947.3323482.7239021870712774147.b4-ty@kernel.org>
Date: Thu, 20 Nov 2025 11:02:29 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 14 Nov 2025 14:05:45 -0800, Ian Rogers wrote:
> Writing currently fails on non-x86 and hybrid CPUs. Switch to the more
> regular find_core_pmu that is normally used in this case. Tested on
> hybrid alderlake system.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


