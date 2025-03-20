Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835B72066DC;
	Thu, 20 Mar 2025 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486442; cv=none; b=SfLKXj4UJkU9rvIM7D4OCqaNPUtH5Yd+FJYbndVeJywJHhEzGYppIvJRPHw6b9pKncJV3RLUDmh9aPSUhgbGY+oFncySQ/vObAodXXMlv31agvmeUh4DbruW04iaPArID6z2N9iyx+5/MPDM+Qqu1yrzjKTCs9jOlMdgBxOfXqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486442; c=relaxed/simple;
	bh=4jMeTtmBaorbabAAMf8Jl20J3QEuUuQqaOeS/cfvbVE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gyGwIXqFeGmV5BPdMk0uGR3I3LBg+ZA/iXSwmQtd/L9JWldODTZbf2Toym6S8JSdlQMcGWFV9W4QIHfbc9VcHFKmliZ7DEAD3HP71WzJYhUWOjcrTJz5tAToprnvu5DAVpUkBb8UHnxhIPMa76/rhimiOT9dGa7ZOIv3d5eF6oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKgqTLse; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKgqTLse"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD052C4CEEF;
	Thu, 20 Mar 2025 16:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742486442;
	bh=4jMeTtmBaorbabAAMf8Jl20J3QEuUuQqaOeS/cfvbVE=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=bKgqTLseJXr5xwhHH7jTr31YoA+ZRf0Oud2KDRzsCc8LZoXonIx+HmEMC4z2vHL1p
	 dcjIPnRt30XzJfzKx6q/FcqyH2jYP8cXSseJykxuRKisM4lv2VkNPxgpV3x2ctKgAI
	 x+5rw0urbnK88dXu5ogeDMpO99Y/tDWZz4t9o5y4nhViZzU/ttCcYo2IRmi9bXAnLQ
	 q4Xl+0NgEe13b8DD+wnw60FhJNGHfbDT8P7gbNxQaEp9vEdJ5rSOZIr5iLCcBXlM90
	 4z7xHv+COCeUQ+4oAylIB5m+APtsFEfY4cPDiVn52Px0cJTQQKjPYVKcYstLgXHB/6
	 ul8FkfNcRAsEQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
 Levi Yun <yeoreum.yun@arm.com>, 
 "Dr. David Alan Gilbert" <linux@treblig.org>, 
 Thomas Falcon <thomas.falcon@intel.com>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20250318171914.145616-1-irogers@google.com>
References: <20250318171914.145616-1-irogers@google.com>
Subject: Re: [PATCH v1] perf cpumap: Increment reference count for online
 cpumap
Message-Id: <174248644166.3704425.11921703615469719002.b4-ty@kernel.org>
Date: Thu, 20 Mar 2025 09:00:41 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 18 Mar 2025 10:19:14 -0700, Ian Rogers wrote:
> Thomas Richter <tmricht@linux.ibm.com> reported a double put on the
> cpumap for the placeholder core PMU:
> https://lore.kernel.org/lkml/20250318095132.1502654-3-tmricht@linux.ibm.com/
> Requiring the caller to get the cpumap is not how these things are
> usually done, switch cpu_map__online to do the get and then fix up any
> use cases where a put is needed.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


