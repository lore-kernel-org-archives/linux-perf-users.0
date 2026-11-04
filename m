Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793827109;
	b=fNwNuf+c5C5ysaEkIGPtzvjoDnXpoZ7HMVn9lFohvNMF5V43xp06togR7s9C9kVKQmW0
	 /YBd2+LzvsQ4MGKW78vhSWXsO965oKBXQKjbAje0+e1Hv2X9rAmjzUcl/KmIeyvYL6UZ3
	 oaI7ZhnbYiDIvoJcEgwbmkR1IzG8TnBev7qPmYaZPxAjsODOw/zr5wNcghgl+sbhq7VCB
	 s/hYrbREyWqv/EViEJB8L+5xqFwsxyqUi38xnO4R5EP6WV7yjAQsyNK4wjFnF1T4j9cT6
	 CGP1VL/2PC9ejJL2lj1NvH9YmW+EuCLA2o/bctODWr6epTLZegZzIQu0ASHKyZ5Ycgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827109;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=yaFgj1eDp7Y/u38ZPUdrhSnfnXtmtVwv/VbWSHbZvLU=;
	b=dTuN18HuBMpq1p4CocLy/Sv1Nn0xn79434wKmagXvvUtFWDaDJIF3YEdQwLCmnfZRvt3
	 cywtvX25D6Ew0O2vXNdPkg0IVtBKOOvgF6/pU12C+kZmUf3w48ZT4V7KvMec6T6GzxkHP
	 9Vti+x5OhBkHU7WvmNSVqRJNDdp7Bsa/j9EagR0Y2xxYiyPiOPzgiwmDWrL4Ta+9fhVVk
	 4S46BzDmydwBhegxeeAD2EqlyjWiTkWyGcOS+gjfjctaHVLL+GShUnpO7nWCYybGXMt6b
	 hTbAGFYDSdqBSDvdZWYOA3SozUmJ9whNSEUyz49Z3K4XqlIDAL3z9ECL5+fr80x7HJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SBg5sUgn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD88606AE33;
	Wed,  4 Nov 2026 21:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SBg5sUgn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17CF1F0093A;
	Wed,  4 Nov 2026 21:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793827108;
	bh=yaFgj1eDp7Y/u38ZPUdrhSnfnXtmtVwv/VbWSHbZvLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SBg5sUgnY1XdJBkwcT9hQnBe2Wp623X9Ws+Vxvdo9ppb2koYF5yMqLv8SnfZOH0SQ
	 jZgrf2PllUaH42Vr3/aDRujDolbIdnQ1gvnf2zOOoaqXx/U94Px6B0JzQZfGyIDNIP
	 rofNurVJQr2nNe0gAe4sdz4JKsh2+lA+AFe7HZqaZPPQg0faxFy9WKQQ8P7H9tsR0m
	 PM3E2JlX6Xs/e6pWw4sGZ6kwDixdsz+V25uJ8JSWk0fhk1IJcb84Di7LsYooL+8WlR
	 gkfaP+fbjoM69KfyTC2eTMWjJG3+1IehVY2+VBAoz2PnmYLvpPEtCcILtXzhZP3cxr
	 5s90yU3296R5g==
Date: Wed, 4 Nov 2026 18:18:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: lirongqing <lirongqing@baidu.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf intel-bts: Free the old snapshot reference array
 after growing it
Message-ID: <auuhIWt8Xz9jXBot@phoenix2>
References: <20261104022042.1894-1-lirongqing@baidu.com>
 <c1e052c6-531b-4c1e-b671-b5a214ae24c4@linaro.org>
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
In-Reply-To: <c1e052c6-531b-4c1e-b671-b5a214ae24c4@linaro.org>

On Wed, Nov 04, 2026 at 10:00:15AM +0000, James Clark wrote:
> 
> 
> On 04/11/2026 02:20, lirongqing wrote:
> > From: Li RongQing <lirongqing@baidu.com>
> > 
> > The snapshot reference array grows when a mapping index exceeds its
> > capacity. Its old entries are copied into a new allocation, but the old
> > array is abandoned when snapshot_refs is replaced.
> > 
> > Release the old array after copying it so expanding past sixteen
> > mappings does not leak it.
> > 
> > Fixes: d0170af7004d ("perf tools: Add Intel BTS support")
> > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > ---
> >   tools/perf/arch/x86/util/intel-bts.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
> > index d44d568..9403681 100644
> > --- a/tools/perf/arch/x86/util/intel-bts.c
> > +++ b/tools/perf/arch/x86/util/intel-bts.c
> > @@ -299,6 +299,7 @@ static int intel_bts_alloc_snapshot_refs(struct intel_bts_recording *btsr,
> >   	memcpy(refs, btsr->snapshot_refs, cnt * sz);
> > +	free(btsr->snapshot_refs);
> >   	btsr->snapshot_refs = refs;
> >   	btsr->snapshot_ref_cnt = new_cnt;
> 
> I made the same fix here [1] as well as turning BTS snapshots into the
> generic one. But that doesn't have a fixes tag, so maybe this patch is still
> useful.
> 
> Reviewed-by: James Clark <james.clark@linaro.org>
> 
> [1]: https://lore.kernel.org/all/20261102-james-cs-unformatted-per-thread-fix-v3-10-dbcb0c281b9b@linaro.org/

Thanks, applied for v7.4.

- Arnaldo
