Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795613124;
	b=xCh3qEs+kJy8FWmS8JClhwg8Srf8/nhMANGuJH6eD01pZ4UMAM2H/NdqTu5l98OA0K9e
	 uLscJ+XIahBptaqxqnm4yS6NmSWysEc2fwMuycsdbOcLnEo1mZo+ZIijYtHdG7PQLxnu2
	 eBqUf1S3i9wRlL85gwqWoWdMJIqdep13fbANg7lYRdaX4lXg1skYRcMe0z3Dnqv2nnQqu
	 GOeckZqpd0G9xRFKjQs/1AvYobaWv8Wm9JC5JBK5PcY0Hmtgiyezn7Ige5qp4tfsrizPe
	 sgEp5nyZPblu/rMsr8EN/V9al/sQA2K2ALNshcrKvuaO4hzLTKZKoBpmR/F5FyafFqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795613124;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=U2yD8YmZMJRUWKYRhLK6Rpzohgna9XQ9HdqUq83TEiQ=;
	b=OT2KjY/oXXh+QTRGlK+FmsXL6QOTx1uhmOqqV4+ZBTwbWnIyDP5HK72O7nXYWahymIwL
	 zDgaEWqpSWbzOqa6I/AfioznkuugFspGl43wMh5rRCVSOR8+iQdh1uVkQpFGS6WySZxHq
	 SxZMKAqoIJ45gmgKUk9cepxcTQJ8xzGJJ7IxuCYsT9WCiOcVK1xLzS1imELEwOZJCH4XA
	 bzIpwej9vha+g2TZCbxaUXpvp1zvrLFqMXIZRGmVZzcHrJ9e/Mad3p45vZJ/RgWXFq19L
	 ylGO+2PqEVeiH62rUU5cf9meX9ppvYunz5DX2wpqu6sKx94Gofo+JWFmNU4dnr3lsHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=HFUc4+O7;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A779C606A335;
	Wed, 25 Nov 2026 13:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A779C606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=HFUc4+O7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=U2yD8YmZMJRUWKYRhLK6Rpzohgna9XQ9HdqUq83TEiQ=; b=HFUc4+O7AkwkBgYTur/jc53ngn
	8MFZ6vBY/W9c/s7d2UaTQiMShV/WFpalO1Ormwd3dqpBCkhnFQkC1+s66NWWbEEAd/a3l5sZSBHZY
	JtnDKP1P207MoP6Xkzxm+gWojJZS5govBXZv6CrmZzFfHwSZ68WuYtrGI+ghbYh0fluVwOenUVhlY
	ROOoJ+qirW8Eks+DnptM1JnPnGvbsXFXa6VmbSW6U42pgNZNGc30fqnEHjdGGD1/XUPBkHD/zU3kL
	+MM0qIr0W1n6B1LszgiwDn3Fy2mIvo5EFG0J/RDcGZIoQNV41ZKcFN1Cvwmamcp3IFVbRXBXQTYPD
	CFPfij8A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWCzq-00000005LTp-2WYh;
	Wed, 25 Nov 2026 13:25:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D9DE9300446; Wed, 25 Nov 2026 14:25:12 +0100 (CET)
Date: Wed, 25 Nov 2026 14:25:12 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Leo Yan <leo.yan@linux.dev>, Dmitry Vyukov <dvyukov@google.com>,
	"Steinar H . Gunderson" <sesse@google.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/19] perf/uapi: Add BUILD_ID_OFFSET sample types to
 UAPI
Message-ID: <20261125132512.GB2668804@noisy.programming.kicks-ass.net>
References: <20261125005108.1020003-1-irogers@google.com>
 <20261125005108.1020003-4-irogers@google.com>
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
In-Reply-To: <20261125005108.1020003-4-irogers@google.com>

On Tue, Nov 24, 2026 at 04:50:52PM -0800, Ian Rogers wrote:
> Introduce PERF_SAMPLE_BUILD_ID_OFFSET and
> PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET in enum perf_event_sample_format.
> 
> For PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET (and
> PERF_RECORD_CALLCHAIN_DEFERRED when PERF_RECORD_MISC_MMAP_BUILD_ID is
> set), encode a deduplicated table of variable-length build IDs
> (u32 nr_build_ids, u32 nr_offsets, followed by packed { u8 size;
> u8 data[size]; } entries padded to 8-byte alignment) and an array of
> 64-bit offsets whose top 8 bits encode the 1-based build ID index (or
> 0x00 for unresolved user addresses and 0xff for kernel/context entries).
> In common cases where multiple callchain frames belong to the same
> binary, each unique build ID is encoded only once.

Why ?!? This is insane
