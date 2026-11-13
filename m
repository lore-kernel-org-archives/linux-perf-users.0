Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597737;
	b=KSG2yMbHWBb1mlVIZSnB6QHx3EJJjRYHgJSJrNAqh5w5n6MMHCbXiGntU7T/SXECmOw4
	 el9FjXhvdxDBP0XZ0eBjG8+Fvqy+XdpqFOhxTNDknXCPGbsMTLUFK3vJGRX9MTmIj0xVI
	 8JazD2T8RIStCSSMgAfOYlqxCJaeuEc63LjpYYG9idurVk+X+s17d34V70LqqpdycyI81
	 00XgoxEcD2dX8BTLooKgPbup1CXX0z6JfNYVoBa+2uxZMx+xcGxgggKxGuVBD016tD3Rp
	 ktU2/UdO5ESL5b1ECDrmnvMNZvTuhOj0sRtqrlUo81c2TiExO6QTzS6Sln611qvMH7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597737;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uJlsucvLz1pbYoLsZ3yU7tLHBQd9XWr9MwuxHkFREsE=;
	b=byWxVkbRej8v4qP+4Eey0T1cVVO8aK+MA5TBWIMNjCSPwCU94t1PuKV4g87oR7b6sIl6
	 Gj1W7KMJaA5reaXT3iUCm6fLwsN+LyLr7J0fLdjVXLAxvtxMTXEGJVGz/0CROKnjE11lp
	 Rw5D5Ex3exCsmME4wQXE2NceC9/4KEZH1mdL8mjSu0WDPbUuj4OToR3qczdLUaKqVakLg
	 X/s8xwED/PwVqRk4ck5+twSOxKbLqZhOvMO9U8H8aGy/BWDM5UYDW96KVOb9Dn2HtnoUS
	 HCNNuvyUBU1OWbI8KpQa4DAgCzrycQpVenARpHyNIyQpSGXLytwklO5vJm0LAInrE2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KH4gj48d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C94606A89E
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KH4gj48d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC0F1F000C9;
	Fri, 13 Nov 2026 19:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597737;
	bh=uJlsucvLz1pbYoLsZ3yU7tLHBQd9XWr9MwuxHkFREsE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KH4gj48dDGRPfro4oKpQYctJ5w2wHWu+z7VUHv7jqvq+jU5zUR6dtKt7yugkFPFQW
	 J/Po/wiPrMSNiRaYbFqq+xc2BZV+9z6erfz7UhXu/09XIbpTbEKRXKCjWKyExw00CM
	 sJz8pvodoyva77Azus72lTN7P9QSoPGMIu5XaJml2wsydPc2zMt0qtEe/+CjI6whVZ
	 bt7eeTe6q10ApfeU2HSozp4dy0kKvw1CEc2ShXerpbAPanV1yO95A4PMAElpqk6KMy
	 83Bzyc0kqvdg93SVcDecNr41PoXMDUGVhRgIXjOq5UNCMGz9Y4CMoklkBJA84QOXST
	 rK4kNBIPCcu2w==
Message-ID: <sashiko-outbox-213543@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] perf build: Add libnvme feature detection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113191234.2509964-2-irogers@google.com>
References: <20261113191234.2509964-1-irogers@google.com>
 <20261113191234.2509964-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 19:22:16 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Introduce a feature check for libnvme using pkg-config so that the
> tool-provided NVMe PMU can be conditionally compiled when libnvme is
> available.
>=20
> Add libnvme to FEATURE_TESTS_BASIC, FEATURE_DISPLAY, FEATURE_PKG_CONFIG,
> and test-all.c so fast-path discovery and individual feature checks stay
> consistent with the pkg-config flags used during linking.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113191234.2509=
964-1-irogers@google.com?part=3D1

