Received: from mta0.migadu.com (out-159.mta0.migadu.com [91.218.175.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E6A368964
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 06:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789971622; cv=none; b=qus4uY41whCcuxVUiaXRGnvrYkC5TmTSOt9t9/d23y98gx4/07KIds+bdOBw9zMBVo0PoM62d3oxaqzgKY1rdJmZhb+ntZ0KzOpcbEbbnlnMqds3Ige7rxFckuGcTV8gVRU1uz1Eg5P/1F7Ef13e/M2ntO9Me/jR2kB9EsgxWnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789971622; c=relaxed/simple;
	bh=n/AdnmXxXRbpGFInqaTSJTt65XZiIYjARrVazbI6Wb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ltQOSLWhIK7H8DUoWDJgy5YOgoXRI9hDy/b7rBOa5/DoErmypwNxp/RcGZXa7I4MPmgxVwWSjHnrNZzLg8h5TGUgzLraADPQ9uNlD7UiVxq3a+O5290cElMhd0GCSmkGsqCS7GD/BwggktTEpld6mxZhMLSTFcU5MfvkSfDnhF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WM4tumaP; arc=none smtp.client-ip=91.218.175.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WM4tumaP"
X-Envelope-To: linux-perf-users@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=n/AdnmXxXRbpGFInqaTSJTt65XZiIYjARrVazbI6Wb0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789971617; v=1; x=1790576417;
 b=WM4tumaPUMfSkp2/LhSaz0bfqlBPUiGV4paOgePn6ocrt2vV1GqT5T660mj1aSQ4tG7SXUpn
 oUBa5L6yv+db9pePHr4Zgl7QpdzOMDO6OX6zyMSI1hNv1jDl8OkTPSLdvKANRJf+Rd2nk8KboAc
 ieKZi6SvU5Pl1XufUEyEgVpc=
X-Envelope-To: linux-perf-users@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f802e06ae86065bd;
	Mon, 21 Sep 2026 06:20:17 +0000
X-Mizu-Trace-ID: f802e06ae86065bd
X-Migadu-Flow: FLOW_OUT
Message-ID: <32b465d4-0881-425e-a199-f40af05f48fa@linux.dev>
Date: Mon, 21 Sep 2026 14:19:56 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/17] perf/ring_buffer: stop using PG_private as AUX
 page high-order marker
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>,
 linux-kernel@vger.kernel.org, Ryan Roberts <ryan.roberts@arm.com>,
 Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>,
 Nico Pache <nico.pache@linux.dev>, Peter Zijlstra <peterz@infradead.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Usama Arif <usama.arif@linux.dev>, Barry Song <baohua@kernel.org>,
 Dev Jain <dev.jain@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alistair Popple <apopple@nvidia.com>, Qi Zheng <qi.zheng@linux.dev>,
 "Liam R. Howlett" <liam@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Kairui Song <kasong@tencent.com>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-perf-users@vger.kernel.org, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Michal Hocko <mhocko@suse.com>,
 Vlastimil Babka <vbabka@kernel.org>, Muchun Song <muchun.song@linux.dev>
References: <20260920-remove-pg_private-v5-0-bb68b6a21869@nvidia.com>
 <20260920-remove-pg_private-v5-2-bb68b6a21869@nvidia.com>
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20260920-remove-pg_private-v5-2-bb68b6a21869@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/9/21 10:27, Zi Yan wrote:
> A high-order AUX page sets PG_private on its first page and stores the
> order in first_page->private. Stop using PG_private and check
> first_page->private for AUX page order only in the ring buffer and its
> users. This is fine because page->private is 0 for order-0 AUX pages,
> matching the page order.
> 
> It prepares for a future commit that remove PG_private.
> 
> No functional change intended.
> 
> Assisted-by: LLM
> To: Peter Zijlstra <peterz@infradead.org>
> To: Ingo Molnar <mingo@redhat.com>
> To: Arnaldo Carvalho de Melo <acme@kernel.org>
> To: Namhyung Kim <namhyung@kernel.org>
> To: Thomas Gleixner <tglx@kernel.org>
> To: Borislav Petkov <bp@alien8.de>
> To: Dave Hansen <dave.hansen@linux.intel.com>
> To: x86@kernel.org
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Usama Arif <usama.arif@linux.dev>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

Nice cleanup! Feel free to add:

Reviewed-by: Lance Yang <lance.yang@linux.dev>
