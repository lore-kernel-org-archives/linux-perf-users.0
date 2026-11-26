Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795684833;
	b=quy7VBK8++f+eO/PsjkQvlHbQwVLXocdTlCBRTe/GkhALyUJE8I3I7Q9R4i0UTcD1pYV
	 lY86zYDy1BDq8OxawePpsAcSQQVxWrzxQr1d9T00+eAP/dZC+5wDf/dxA+FrzGev6ym8N
	 LMxWvAC4DBsL78pE525t7zKOAoskb3EfW+cEBm6G3IoB45wt+9Ns6fK8V1el8O8sZ8wjO
	 7oOm2x7on6OQ37aYxdqQmkelHWnDkljPw3YgcKAO/RMSoK3+cIBUEEoDfds0YljfESxro
	 po8qKTUfMMm0UoW/LpVuXS6ORc2Gi2IMMtNKksPwPxWaT/FYP7Bc94zLBH/i+xGIr+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795684833;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=lSqRg0RUNj0kY/4CIIdRGV/qsXk7Owu8UlnJI1VT0Yc=;
	b=bJFI7nniSlcIW8lDXp65TnmPwgL/JKMmPkXFdQ1P7Gn6Zfbg718VBCXEmup+3gYJvcb4
	 siUZ8vtTLWkmxzVIeTw17bEO98RwdghMtqzHS2rhDa+Vbl8OuhUQZr2kF631GUHvVeuBt
	 I1MB7pWv9SnIHP5B2jL7n+OXzMbE/2wStDZzjrmGNwg6EgLfw69rhE3/9c7tnOLWzEXYd
	 x3ch+pKs8Z5UHjzcKS+T5Ajsts4C3cqQ6p+vt12PV+mQUNf2lH0eT7rFvUAJtYeTCZ844
	 fH+2/5AIjMp2GQxMCfGPNX1tdg++p9UCxz1S/QkGa8HOUvRZO369fI+B6KGrhvg98Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=FbawLYDg;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1D6606A323;
	Thu, 26 Nov 2026 09:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B1D6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=FbawLYDg
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76FED1BA8;
	Thu, 26 Nov 2026 01:20:28 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F31EC3F632;
	Thu, 26 Nov 2026 01:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795684831; bh=HAQRsB0+/tqyR15APxGRJS/heDfgLUyCA6emv8ask7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FbawLYDgalcPQgPc2gvUQMZNIc91WZvVP9InHeu3oPtx+GG84vZKXLeZsClhNzrZH
	 6oQe2cD85i8oHmgsvhlpQdMcUB7o0JuD5z+wxz8rftBdPShT5fIEvZIMVOl/r7BItw
	 4gs8voBNW1FnB2W3hqtlQ/JzW41a6l0/RWY/Uyjg=
Date: Thu, 26 Nov 2026 09:20:29 +0000
From: Leo Yan <leo.yan@arm.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Yabin Cui <yabinc@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Tamas Petz <tamas.petz@arm.com>,
	Tamas Zsoldos <tamas.zsoldos@arm.com>,
	Michiel van Tol <michiel.vantol@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf/aux: Avoid reclaim for optional higher-order
 allocations
Message-ID: <20261126092029.GC7209@e132581.arm.com>
References: <20261125-perf_aux_alloc_optimize_psi-v2-1-b2ac7ed12849@arm.com>
 <57d719b3-c701-455b-b467-1f50dd07850e@arm.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57d719b3-c701-455b-b467-1f50dd07850e@arm.com>

On Thu, Nov 26, 2026 at 11:08:10AM +0530, Dev Jain wrote:
> 
> 
> On 25/11/26 5:24 pm, Leo Yan wrote:
> > PERF_AUX_GFP includes GFP_KERNEL, which contains __GFP_RECLAIM. On
> > fragmented systems, costly AUX allocations can wake kswapd. When perf
> > falls back to lower orders, the allocating task can stall in direct
> > reclaim or compaction. Yabin Cui reported that the resulting memory
> 
> When perf falls back to lower orders, how can the allocating task stall
> in direct reclaim? It stalls when it is performing the high order allocation.
> 
> So let us write this as:
> 
> "On fragmented systems, costly AUX allocations can wake kswapd/kcompactd,
>  or worse, they can stall in direct reclaim/compaction."

Will do.

> Reviewed-by: Dev Jain <dev.jain@arm.com>

Thanks for review, Dev and Yabin!
