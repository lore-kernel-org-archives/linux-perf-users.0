Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942658;
	b=iKZ62k8IrGZuB+uFOhDWZ1BUs+CEGVbl3CDnTzZ7Umf8A0S7aEx3fAEmkizPB5bUMMNg
	 /d8Y8sq87REkIJPoUBwikl0l6n17S2T+W4IfiUmNGBTFyFVjHMiik6xd2gT+v7bKlIIgp
	 5MboywFBGuDMTDW3U3MFWfHYWcoa0ibEMRff2PB7UFPvIK48tZAwjxpS3Jiy55XCWEcIH
	 byHMw+dBDx58DGBUjpgQaqBztcdXpts/wyZoWL60WUTDSasE1qdjWaOAaOIM9MthVUKua
	 NDv17ahep4AokMQ+r/aFBfbC3WVhSnXXJthQRJrA4H+M1MDuk76Tp17G2ViK8MPqZtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942658;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VVdhQVG1Z8SAediBZcUrpDEeHYHOBD/pIZ/scOEqHy0=;
	b=vA+93R4mXgxhjOcYlg6/PAX5B5VWxa2nsixwlq0/IBc2MRvqgnXb3FlO2cMTlfurGEil
	 Lu6UgQJENd/FT3wDiyvkJAKi4LALUmOg23QJROjirri5GBB/AGsxr6ZLCpEAtZB/w5cwb
	 ypK1VNBSNXztCjHZMT9sU3DGZmpUWN2Iy+FqwOKmDsem0Q/nBmTfOCeDMNmRblH2GaX95
	 XWGR95LxeBlSv0H/h/0oIx0CR8CR3n4nBJ4iYdQ6tzwvvwELSWRug0OP0EEKbmGikj0Jt
	 o+Fs9DmS19vHf6oXaInXMETKsjrGBey/2imdDtF0ij1WH+fMOuv5OQuhDBZnsAdOnbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mHSh0BZG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97059606A88E
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 19:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mHSh0BZG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BB91F000CF;
	Tue, 17 Nov 2026 19:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794942658;
	bh=VVdhQVG1Z8SAediBZcUrpDEeHYHOBD/pIZ/scOEqHy0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mHSh0BZG+TzYE2Rfetfqa/oRNFxihZ9BndN0SfzfTErgK+ZGEEqwRtUOL7/Ydqfg4
	 LDtc2genlceLRgd0sGkgT8de2krrh6mfLJvlBqfqlDGQdqQjNJU9FunsrDZT66GUVg
	 IPEROw9JDEA6t6JI0GwHwwmxmPmurTNifw2IkCaPaLWARtQWCWYOVSqVEWJOC6Kdz/
	 VJ4asCpYMJ8K6BfoNWzb0GcnLvj8P1uhsOtXGQl/6Jx8Yg+EA1p0sxLckW5baLjJ0w
	 d/JYg5vGNssPChmVj1BRcISumWx+PvocLEIY6CNfJ1abSupEYQ10tiNChY+HzmW62g
	 5CT+gk6yRli+w==
Message-ID: <sashiko-outbox-219448@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/9] perf maps: Optimize tail insertion and
 small-append sorting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117185305.108003-5-irogers@google.com>
References: <20261117185305.108003-1-irogers@google.com>
 <20261117185305.108003-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 19:10:57 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117185305.1080=
03-1-irogers@google.com?part=3D4

