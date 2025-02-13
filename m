Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4D62222B4;
	Thu, 13 Feb 2025 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467293; cv=none; b=inLj/EnuhJntudnyS39C2/30iA6OuzdHG+7ITzq/wLDp43ff6ZcqrgSyM5wUqbpyTbhZrKtTh7qQIiRYCLpUcH9sM4/AyCJBC78NQO378/ud8Uh7GxPxPGF5bbQUXnYEVSZo7rpBGXPNhGXBe78s9nhcwvU8vjpRQW/OUJ8BpHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467293; c=relaxed/simple;
	bh=G38jDqfl/AF+iPvssalJ9aOICXGh8jdULDsQ+xgpfKM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=odJXKvVBJzrQMoCxIlUQwi0IFVksJ00H+uJCTa/Vm3QgIm819B5nBId7yGupYUjz1xTdIp4rOgOadOG6VkZ4os1B9Bt39PmO89mfRWFtrO8C2jR6WTKxmH5dQDlvObkP5Kl3ssKHJG6+S3GifDgO53b9CCTvlK68+F4fdIIl3D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRZop5qO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRZop5qO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7B8C4CEEB;
	Thu, 13 Feb 2025 17:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739467292;
	bh=G38jDqfl/AF+iPvssalJ9aOICXGh8jdULDsQ+xgpfKM=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=LRZop5qORX4szK1LIQGbdbzB71jxszl4oayTvfjXqDTHDJyhOyBLRdwe+pwLA9kAx
	 hQ3m7vi7Z7k15EwdWdxPr2Ikcajh9B/AVB2/XdhuE+Dn/rcC2yJOijc5LhJar0lbDV
	 bnjell3mmboNOWCe2PoIOhTXnv0qYA46M28xL1r4NG3JhuWkuE0TJae8nAKcJADhZg
	 SAd8yh9zeWQpQno2oQu1yfurZAUYedL7BhXtZNC/0bIuk7xHuXuq3Qm/PUkeQCfNv1
	 LqKSpUzTKLliKHjd2wRqX4uPzlL4vbYYdaZIbKoMDjPGm8lRUad8Rqc3S+owfjVJGj
	 l0dM/KGJ11Yig==
From: Namhyung Kim <namhyung@kernel.org>
To: Tavian Barnes <tavianator@tavianator.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
 James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Charlie Jenkins <charlie@rivosinc.com>, Andi Kleen <ak@linux.intel.com>, 
 Veronika Molnarova <vmolnaro@redhat.com>, 
 Michael Petlan <mpetlan@redhat.com>, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 coresight@lists.linaro.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20250113194345.1537821-1-irogers@google.com>
References: <20250113194345.1537821-1-irogers@google.com>
Subject: Re: [PATCH v1] perf sample: Make user_regs and intr_regs optional
Message-Id: <173946729207.1291083.11530749886771499675.b4-ty@kernel.org>
Date: Thu, 13 Feb 2025 09:21:32 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 13 Jan 2025 11:43:45 -0800, Ian Rogers wrote:
> The struct dump_regs contains 512 bytes of cache_regs, meaning the two
> values in perf_sample contribute 1088 bytes of its total 1384 bytes
> size. Initializing this much memory has a cost reported by Tavian
> Barnes <tavianator@tavianator.com> as about 2.5% when running `perf
> script --itrace=i0`:
> https://lore.kernel.org/lkml/d841b97b3ad2ca8bcab07e4293375fb7c32dfce7.1736618095.git.tavianator@tavianator.com/
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


