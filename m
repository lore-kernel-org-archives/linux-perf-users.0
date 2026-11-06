Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793941989;
	b=p/Rsk3h2+n9CgB9ZBJN3x+FaDByH8USYqUgwUT7C2jvq2wLyjkcHnEwEra/UuwcxDp9a
	 gFHWN0CYxHPD3hnqiWAXYA1D7pdAhIIrOByRDRDjdalvPan+p8jvwUkO3Ipwc/UKMBc7k
	 9CfJv6XfsE7tToMNTp1AnkLPx4J1UFemKLq2+oPYXuGFwrH9Rs0czIMPRDo96DIcoJj00
	 Cu+HWxfCq8qFl1ImtTFIg01fmkZrTQK/9Rg+1IktdKq3ndf/FKPgeSBtXImn2YUFsRTOr
	 HYO6Lvu/2LUuhMrgZntb7eFBceq3qtacVI9LGMG0PFr60G10z+sf8AP2u7+6Lkl5WTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941989;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=80f9Z6larh29cFZKrHb5jNIpBmK0kVVoSTJqe/49Nyk=;
	b=Bhr8/ACkzocn+JxQORldZbMsczjuS+pwTLIgJktpv3Ec6S1wKE614fkXTqeWwKEzRgGH
	 aOdgqY2M1Dx7mh87pcrOmrJEbWef35v5ouXZvs2NUyQf/GSt0ARNCZgTv1skFXVPv3a1z
	 rAs37hMFSxFw/SPbsW32w2TEVNz6oOH1Pl+TyzrG9fdcuZu8YWIJir1GiD2ogXplQD4kd
	 7dyUjTbcIE19FRVkxFQNr5JWxNTB9t8nntj3yZkm1eHyP6YxHlNHTwVZyo73xsO7GweRK
	 2BflhlOocrzBNx7ODfTQHfk9YUi3W2YON9CMT1PU6r5S6hbcYljnULyJEUSCOdpiV0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lZsq1ilI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811C6606A326
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 05:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lZsq1ilI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DFE1F008A1;
	Fri,  6 Nov 2026 05:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793941989;
	bh=80f9Z6larh29cFZKrHb5jNIpBmK0kVVoSTJqe/49Nyk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lZsq1ilI1X+jA4Ha47DMznEs0zNZ78ElhLoQAu1waxBupVkJAM8plveUIHSCS4WWz
	 ZQexA7GR2QGbo2x8a8nIkiWalTMSRNZX+k2FRlbp3ceKD2NYiqsE7RqW7j1Lp4kbLP
	 05OE4AHbunI0O1Ol2T2JFRPX/OK6GfHh4hzxvOwlldqRcK3zFbRp6mTlMO+aAz2FEv
	 kq35vnoAb4Qujd67aMjoT0F8dqgVgm3qHXVhUmiJxQH6wcG8t6kdvSHQpeLK2utChV
	 e0HZ96LudWs6FkP1rYPXeNO7j4j5KVyBwVeaOsbymzNVLL6xwXrPoBzzU9PKkqp8Rp
	 R4VA0/OM9sR7g==
Message-ID: <sashiko-outbox-200804@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/14] alpha/perf: report the data source of
 ProfileMe memory accesses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-alpha-profileme-v7-11-c474e892abb0@gmail.com>
References: <20261105-alpha-profileme-v7-0-c474e892abb0@gmail.com>
 <20261105-alpha-profileme-v7-11-c474e892abb0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:13:08 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Whether a ProfileMe sample's memory access missed the DTB is only in the
> PERF_SAMPLE_RAW data, as a DTB miss trap.
>=20
> Set PERF_SAMPLE_DATA_SRC for the samples of memory instructions, so that
> the memory sort keys see them. One that trapped on a DTB miss gets an L1
> miss in mem_dtlb. PALcode fills the DTB, so one that retired without
> that trap hit it, and gets an L1 hit. mem_op comes from the opcode, as
> I_STAT does not say whether the access was a load or a store. A load
> into $31 or $f31 is a prefetch, except for ldq_u, a UNOP that is left
> out. Samples that fall back to the interrupted PC get none.
>=20
> On an EV7, a loop that loads one word from each page of 64 MB in random
> order had as many DTB hit samples on the load as misses: the miss trap
> aborts the load, and its refetch hits. A prefetch into $31 takes the
> same trap, and its samples are reported as PFETCH misses and hits.
>=20
> I_STAT[TRP] is ignored for an instruction killed before it was mapped. On
> an EV7, TRP and MIS were seen set for killed instructions that are not
> even branches.
>=20
> Suggested-by: Ian Rogers <irogers@google.com>
> Assisted-by: Claude:claude-opus-5-5
> Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-alpha-prof=
ileme-v7-0-c474e892abb0@gmail.com?part=3D11

