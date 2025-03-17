Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F7E17A5A4;
	Mon, 17 Mar 2025 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226729; cv=none; b=lkrW6RTcp7HuPIXExo2RmPO7Drjc2BWTtmD+oBsZXFGzjWru5Ntcsgd27XoDRa4Acc2xWxofF6Ep2APZRBNCQg9JebfA9yWZzsbPKRfesVygtKYpQrAasexYuKzqY6KxwzkMPJ4MaykKAekX30K5C3lhYFzie0dTr7TTUX1CtKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226729; c=relaxed/simple;
	bh=VkCAbDUKlok6HX3OVfIlbrktH/ntcEK64hAQas8MqYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kK82WXdoYZwyhogCNqp/Kw0rYSqiqQ+lLvJPJSD+t2M0Kp1GrNa0+QqHZultTxPG2zGmiNv3Fz6A++0dOZWo9mWo9yIZov9mx4qsK8ohBdckjdlQX/iNKXSoGEIyVHQ1wNGCK10cy3g2JsbRWuVNTdbaeI/97BQdCap0gBPJozw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1lU8VNQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1lU8VNQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7B3C4CEE3;
	Mon, 17 Mar 2025 15:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742226729;
	bh=VkCAbDUKlok6HX3OVfIlbrktH/ntcEK64hAQas8MqYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D1lU8VNQm7/iJN4O/QYEiQlYxMgMjvN6NjlchLm1CKgoyWVLyej+p1IrVa4gbptlW
	 tzt7eIAG9BcAGNYLPWzlpUMuzryIqVGndlf/irBfeByvyBCnJTpn9/Zx3bMBQ4eApz
	 NYihf/3DXhvWTQcY0AECBVkhcCvSgbt3ZfzAooUhQjOT+/M7zf1e/JAZt3AGwDNSXp
	 1FDorFfvMI/R+hwoOgmeZQf9gHBZ+EmdVIpkkHcFxn1j6SBtkQyyEsnKWtQ8pskuVu
	 BFJrriQPItq0fwHHC33Ay59sCh/drYln+rIXNPv6hpPondMXjXBx2gg8R700H2KBuC
	 9XlGbWlxs8dOA==
Date: Mon, 17 Mar 2025 12:52:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org,
	peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, terrelln@fb.com, leo.yan@arm.com,
	james.clark@linaro.org, christophe.leroy@csgroup.eu,
	ben.gainey@arm.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf record: Add 8-byte aligned event type
 PERF_RECORD_COMPRESSED2
Message-ID: <Z9hFJtEKfsGGUDMg@x1>
References: <20250303183646.327510-1-ctshao@google.com>
 <Z9TXabugl374M3bA@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9TXabugl374M3bA@google.com>

On Fri, Mar 14, 2025 at 06:27:05PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Mon, Mar 03, 2025 at 10:32:40AM -0800, Chun-Tse Shao wrote:
> > The original PERF_RECORD_COMPRESS is not 8-byte aligned, which can cause
> > asan runtime error:
> > 
> >   # Build with asan
> >   $ make -C tools/perf O=/tmp/perf DEBUG=1 EXTRA_CFLAGS="-O0 -g -fno-omit-frame-pointer -fsanitize=undefined"
> >   # Test success with many asan runtime errors:
> >   $ /tmp/perf/perf test "Zstd perf.data compression/decompression" -vv
> >    83: Zstd perf.data compression/decompression:
> >   ...
> >   util/session.c:1959:13: runtime error: member access within misaligned address 0x7f69e3f99653 for type 'union perf_event', which requires 13 byte alignment
> >   0x7f69e3f99653: note: pointer points here
> >    d0  3a 50 69 44 00 00 00 00  00 08 00 bb 07 00 00 00  00 00 00 44 00 00 00 00  00 00 00 ff 07 00 00
> >                 ^
> >   util/session.c:2163:22: runtime error: member access within misaligned address 0x7f69e3f99653 for type 'union perf_event', which requires 8 byte alignment
> >   0x7f69e3f99653: note: pointer points here
> >    d0  3a 50 69 44 00 00 00 00  00 08 00 bb 07 00 00 00  00 00 00 44 00 00 00 00  00 00 00 ff 07 00 00
> >                 ^
> >   ...
> > 
> > Since there is no way to align compressed data in zstd compression, this
> > patch add a new event type `PERF_RECORD_COMPRESSED2`, which adds a field
> > `data_size` to specify the actual compressed data size. The
> > `header.size` contains the total record size, including the padding at
> > the end to make it 8-byte aligned.
> > 
> > Tested with `Zstd perf.data compression/decompression`
> 
> Looks good to me.
> 
> Arnaldo, are you ok with adding a new record type for this?

Checking the discussion and the patch.

- ARnaldo
