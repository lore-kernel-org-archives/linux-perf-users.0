Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794812772;
	b=XYCTgUrvGpzDG1X7aUhaGoo227V/bV7hC/ogyb/XNstjAy3aazDwr1U+1qa1YB8ZTzMw
	 BzSQ46BRA210nqw8sDlmsBIHXwnNOhldU8e15mJTvznoycG2xnFaFBR83GdthMqSPJT+L
	 hnAQ6FsA1Tr+N2cHtgDx7ug2CZD5uLCEeyDay/Bag72nL/Jex/yW7Hqpq+lnyvfSZeSwk
	 a8aGpy/JjWyRpvmky7GriPm1RSf9s+JS6jbGyNMTs1GuFyQVGouO3YTIRdIwkx9nv4vs6
	 1BXTuHtVfooVKCFldpPL2sqtgq6wAghpyXtAhVwJqh7djtu0C3bDiSz0G3zEP+Lq6sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794812772;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zXd47ITa0JV+lDSsDZIOkch2/W/1+pVuqUndSpLTm+4=;
	b=QkoqAEa+rL4UCMbI8NA5NHuFgukrvj45HVRH01NeMU7vO3b01rmnVIeFSEYE3Rl5JImD
	 y2UPq/XxMudAiCPj+1a4I/Sh6+WlXE+rbBDaQqtOOOnVUTXRrJ+tVWcz/oJQFSb28av88
	 FhxKxC2kkkarJ+V8jOgCeIO6DJhkf0xREI2koGoPCjCd6H8gSn6hSSR90Q9fDXhq/T2YO
	 k9zIpqeb/hQeC4YYq4qfwcXtK9ddxfoOH/+84/jV8Fa4+mymjpihJ3vafGB83cqUM7jYp
	 Cb2lY0h7KwA5sIaATCQtQwwK2Rakuq/pK3blzRJItO2GRCg9JSiTOGrVZ6u97B0OK5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mYvVeCQs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA97606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mYvVeCQs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E5C1F000C4;
	Mon, 16 Nov 2026 07:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794812772;
	bh=zXd47ITa0JV+lDSsDZIOkch2/W/1+pVuqUndSpLTm+4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mYvVeCQsxkbvjnCBF2MSJfxhZOSrxzCgeTV2ozyh7wefdSLyotHPhIBrcMQ2TzRVY
	 NG2FIKUz1WXIZGiSRhxsJKHpxpPHRKGoeQeTFXemWkCaQo74nU2hDR5PtLsW75GB6f
	 uQhqwehSykk6uVVYlTLlhQGjN3jK2EqFDR+VrI0T5ehvaYmBsRsLEZHT552Xo+LveS
	 42VYUgmxnHMNf18X9Zq1NG8GD0Au8JFLE2tBMW4n2fpbhRE87ZcPzGPvGCFUUpUNjI
	 0kLSNhNAq/tLjUNnoErbV2UHznT75HtgC1E2h4Ejb9BmKVt+9MRVfUhHuN0GyrSUD/
	 0gWRJFISn3EVQ==
Message-ID: <sashiko-outbox-216380@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/9] perf maps: Optimize tail insertion and
 small-append sorting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116063435.2817923-5-irogers@google.com>
References: <20261116063435.2817923-1-irogers@google.com>
 <20261116063435.2817923-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 07:06:11 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> User-space map insertions (from /proc/pid/maps synthesis, runtime
> PERF_RECORD_MMAP2, and jitdump) and BPF ksymbol registrations all flow
> through maps__fixup_overlap_and_insert() -> first_ending_after().
> Currently first_ending_after() has a fast-path check for the first map
> (maps_by_address[0]), but no fast-path check for the last map
> (maps_by_address[high]). Because /proc/pid/maps entries are synthesized
> in ascending address order, every synthesized mapping starts at or after
> maps_by_address[high]'s end, yet currently executes the full O(log N)
> binary search loop. Add a tail check in first_ending_after() so
> non-overlapping ascending insertions complete in O(1).
>=20
> Additionally, track the sorted prefix lengths (nr_addr_sorted and
> nr_name_sorted) in struct maps:
> - In __maps__sort_by_address() and maps__sort_by_name(), when the
>   unsorted tail is small (k <=3D 8) or the total map count is small
> [ ... ]
>   After (-6.9% ascending, -98.7% append):
>     Average ascending insert + lookup: 58.970 usec (+- 0.609 usec)
>     Average append + lookup: 96.670 usec (+- 1.353 usec)
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116063435.2817=
923-1-irogers@google.com?part=3D4

