Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599076;
	b=kFVdNEg/W8JYsd8vOJD83OhN+SdEl/z8QOUqWa+d3gVBSDpnyPNMmN4zU1B/6QWL+1v0
	 0tpbaIlFH33kvQHj8RZw8OVXxfA9ST6di+yRUqxJy9Q24FI3CqjtjPvq6am8DzgEVBOy9
	 copakvtvTP8i2F6EU2fDQOonOuP92rO5PmvhVnw7CebgSr8puM+vqEgoqU5qFrxNgYxLt
	 NnIgFOFpqK/ZymzcE5Svrup0ABLpxZa+Js5R9D1rBseurb792BjUI98Ln5IJ8moP+/sE0
	 3rbi5b6yV3ckAQM8dzynoCn2VaiFDjuASgAKtv2n5C+X7t1m2qy+Qlr8wkOY29Xk/nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599076;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=pFZkk8GSif8a+05DQi0f2eWQqaqvJmxfe/oV6ObPwzg=;
	b=0IaA/vtsU9sQi0OZyBla95JYORbpTSC46RaUCy/CwBRuWzv35A93onw6Qv7Tz2pJZR8A
	 x9z81JPzL6WXLS7Xp6K/kjZ0GUShgwev7Thy2zubh5Ea7RVbD/Ruv+wvkyhm0LKayFFv7
	 NzUGlTcM5dpwErsZBTjgqeCVg03G4VGD2T7OeGGolEpf28dvJGcD1mHA9xrH1yjJDMRC6
	 fLtM5dkW9AK2YuMNqAxRrkZ6d0ZWsJilSCOPZe0y1wY/No3+MdyBQIHPPdhwi73mNFIXj
	 iAmzHXgvbckEgNTjlN3dKi5E1rMgfb/4sP30ShSgClM557rgtAQINje6BeykDZ1GYGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YZBV0ug5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3497606A333;
	Fri, 13 Nov 2026 19:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YZBV0ug5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C921F000C4;
	Fri, 13 Nov 2026 19:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599076;
	bh=pFZkk8GSif8a+05DQi0f2eWQqaqvJmxfe/oV6ObPwzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YZBV0ug52ZeDeHR13YHljC2hoLrQVK1kJBT85iIp9A17ndKdf1Yv2NXChIIOGufPS
	 iNGmWho69ov3rs0ZR3gpNuSRIUUPVym5mbxm3PYun1euzRvRSmuLjd6QbMe/lJ9EzR
	 EyE2yQrNHPGDTbOPQGwl0AIioMb7PHIWKJ/3XDSr88ocNKQ95rpmI38Wnx/eSu+dLW
	 uCV7DCLVj6P8gizgt55ktVMhIZ3Y0b/ZFnKYuHblff3g2Nf1eavRURSXdNMCVFkFro
	 9DLVvVA6qqjJmEFR8e6D+KMMrO3KDTr+pjMv9Sv8MPJD9nCasLCpDhZbzG7hOIfDMf
	 PrEnHQVyAEqUA==
Date: Fri, 13 Nov 2026 13:44:33 -0600
From: Rob Herring <robh@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] libperf mmap: In user mmap rdpmc avoid undefined
 behavior
Message-ID: <20261113194433.GA3321047-robh@kernel.org>
References: <20250914182437.1959331-1-irogers@google.com>
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
In-Reply-To: <20250914182437.1959331-1-irogers@google.com>

On Sun, Sep 14, 2025 at 11:24:37AM -0700, Ian Rogers wrote:
> A shift left of a signed 64-bit s64 may overflow and result in
> undefined behavior caught by ubsan. Switch to a u64 instead.

This change was just brought to my attention...

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/perf/mmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> index c1a51d925e0e..ec124eb0ec0a 100644
> --- a/tools/lib/perf/mmap.c
> +++ b/tools/lib/perf/mmap.c
> @@ -508,7 +508,7 @@ int perf_mmap__read_self(struct perf_mmap *map, struct perf_counts_values *count
>  		idx = READ_ONCE(pc->index);
>  		cnt = READ_ONCE(pc->offset);
>  		if (pc->cap_user_rdpmc && idx) {
> -			s64 evcnt = read_perf_counter(idx - 1);
> +			u64 evcnt = read_perf_counter(idx - 1);

According to uapi/linux/perf_event.h, this needs to be signed to sign 
extend the counter value:

        /*
         * If cap_user_rdpmc this field provides the bit-width of the value
         * read using the rdpmc() or equivalent instruction. This can be used
         * to sign extend the result like:
         *
         *   pmc <<= 64 - width;
         *   pmc >>= 64 - width; // signed shift right
         *   count += pmc;
         */

It looks like a left/right shift has gone from implementation defined to 
undefined behavior. According to the internet, the right way would be 
something like this:

u64 sign_bit = 1ULL << (width - 1);
s64 val64 = (s64)(((raw & ((1ULL << width) - 1)) ^ sign_bit) - sign_bit);

>  			u16 width = READ_ONCE(pc->pmc_width);
>  
>  			evcnt <<= 64 - width;

The left and then right shift here is probably redundant. I suppose 
there could be garbage in the upper bits to zero out, but I think 
read_perf_counter() should ensure there isn't.

Did the need for signed values go away or was wrong to begin with?

At a minimum, the header comments which documents the proper sequence no 
longer matches the implementation.

Rob
