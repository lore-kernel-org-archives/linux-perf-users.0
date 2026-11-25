Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795643135;
	b=co9tgQ2qIyHEFUO+C//lnuWbUbpWi5gYgmAUjKQcz5NIfOFwJsphbR9lSYffLv9cUj58
	 UI9lX4iWpctEwe3yCFkz+ctgn7KeEPVXvgIHpe3kHVhgloPi95SaSmlK/57hSmxI86QJi
	 szVydrCnWyD1bxdyiNnBNv8xnthBRTGGh5mBmBCooUui81bEGY9IckUDRxhnVL1wEldzN
	 oZCX1VCnhAUqo33g5ocJ+6DtNO68Ww5h9F8EJ0U2PH75tzwU1wfWY8XhffYOg10nzUA9W
	 Vb0T11fXokG63yaF5JpugY6aDYoqaEAorxUcmFoXmkG3Tj2A+9ZPR2JJXSGKHOa/i4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795643135;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Jo4SEKF41tVgFr7rYNyyPCaU7SHDrcS+GKvJm3KJFcQ=;
	b=NtNXwrWsENpZLf+WkoIEvDC2Pxb+zaOqWEYVCOrFWldpKyuY8Vqd+VqDOJjFz693bH4K
	 3wqEwUGKC8WZUI4YeyL/jXIry6JZFC5AacEar/ysSy8NHnEdXAGQSWEc4jvmheev/RHoS
	 DVrPf6Y/VQzkv4fqsNGrvAPwbjrKzy6hMuHT6RMVrUOOxyatA+Pk70eD0RgJKlt+l4ijJ
	 ZmSJ/tm/lwUiNpgDDrrMyJm34g6TlY84HbJEFiiTU6eF2YGLqBcEqmae2/xntzDbRDc4E
	 WN5S1mFUbnDDiU3sqp6Vw7B4zXBscxU77vPRPle1bqJKAwJtQ3m1bBIg1rJp9YkA/qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oxpD+fAm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ED9606A321;
	Wed, 25 Nov 2026 21:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oxpD+fAm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142CB1F000F2;
	Wed, 25 Nov 2026 21:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795643134;
	bh=Jo4SEKF41tVgFr7rYNyyPCaU7SHDrcS+GKvJm3KJFcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oxpD+fAmaAmRA/r+MbxpVivJH1l4Aes+TjzfBYuCVvNxsL072nZd6psX9L1xfDgeQ
	 8ePtke9iN0M9k/B1RFyKujsTuLMmw9nnFwJKMz3NoCq1rIgcKIvRUPcaUUdu1pInP0
	 HSn3gq9sUB7edeNucfnBU63vRTN1meBqEOJCOnKTGL0bnOwoOFtvXdhDrj3zgcC2Vv
	 5RvbvvOZc5niEXEme7K6CeIguth4B2W3dCq2m569znxaTv04Z1ewf4yBcvdGVQZ7di
	 ObohOJcob2tqZItQVFAbM4rKBY3zFNwcQ5ExpkSHv+32dgnzqDSwm4825h9Z2rOVzf
	 k3Tx7JdLll+SQ==
Date: Wed, 25 Nov 2026 13:45:32 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Message-ID: <awdW_Al_OhIVCimV@google.com>
References: <20261125005108.1020003-1-irogers@google.com>
 <20261125005108.1020003-4-irogers@google.com>
 <20261125132512.GB2668804@noisy.programming.kicks-ass.net>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261125132512.GB2668804@noisy.programming.kicks-ass.net>

Hi Peter,

On Wed, Nov 25, 2026 at 02:25:12PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 24, 2026 at 04:50:52PM -0800, Ian Rogers wrote:
> > Introduce PERF_SAMPLE_BUILD_ID_OFFSET and
> > PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET in enum perf_event_sample_format.
> > 
> > For PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET (and
> > PERF_RECORD_CALLCHAIN_DEFERRED when PERF_RECORD_MISC_MMAP_BUILD_ID is
> > set), encode a deduplicated table of variable-length build IDs
> > (u32 nr_build_ids, u32 nr_offsets, followed by packed { u8 size;
> > u8 data[size]; } entries padded to 8-byte alignment) and an array of
> > 64-bit offsets whose top 8 bits encode the 1-based build ID index (or
> > 0x00 for unresolved user addresses and 0xff for kernel/context entries).
> > In common cases where multiple callchain frames belong to the same
> > binary, each unique build ID is encoded only once.
> 
> Why ?!? This is insane

This is basically to save space for callchains.  When multiple entries
fall into the same binary, it can have a table of binaries/build-ids
and use indices instead of repeating full build-id for each entry.

It'd be great if it could have a global (or per-session) table.  This is
a per-sample table.  Please let us know if you have a better idea.

Thanks,
Namhyung

