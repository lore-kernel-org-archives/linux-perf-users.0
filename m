Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256678;
	b=pFzrflQIpaWaReG5RP21COhLk3RkVZoWYIFIv0m8YsvvpxYL8j8ylE5xNRv1IFqI8RKe
	 UVT0FKs9zOX+egv3emFSXGk4UyOHRmpO1VFB2SZjBY901HGaM2ba+0n7qijuUzqVdHEwX
	 7EMlGtxB0fPGn7ErZoRc3b880mnnOm7voCNoxhyiwxAk3e10Uz7QWwpDq9SnplUXoBBjC
	 b8yKtKn+Hh3mn0JG4lK1uRdwJcpA9/shODz1A9eUqvNmWV5ygX7ircav0fyaswbsTIf2D
	 Ha/eOeDG1wtAGrJzv4qqV729N6GrD7bBVGfYwYG8ce85bibfKyZny8knhH6Tbk4sYUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256678;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VQjfX5R+Gjzw/7+GtJ4hUH7F0FcSrNrStBoxPFhqZXM=;
	b=kWfg/qf8Z9y9IffKKmoIvvm20K3k7oo/ZOKdTVkLz4HL/U+qwypi/RFiiIhc0hCkRUKQ
	 vkX2QJPjwJz8oLYwvTe/U3ZUF24vAfsfvelgIU4/zo0Omkuadx+6Tn7zQjsZ1URmQ1wW3
	 EB1qffmmjrTb6v59/5ALUOYpWrO2XHXkNGL6oaLGfGu6tCg0XtLSoV682xs8KF4UYhJnE
	 8NGwixQlQgaKFNOFCLeJFZYzH4s/SIUwQPgPzt7L8w9Fc9/qyqKVCPQ41mSY85D2cVeW8
	 mRNsWuP/DwYPEihBaO6do4BlFiYA5JcvtSqlKMlPa/2T9wYg4FSCN9V0GhMZ93UnXXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggur5f1e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C512860A2605
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 20:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggur5f1e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494651F0089F;
	Mon,  9 Nov 2026 20:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794256677;
	bh=VQjfX5R+Gjzw/7+GtJ4hUH7F0FcSrNrStBoxPFhqZXM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ggur5f1eX4pKXhnFwRQ9yiRdTc1V/W3uCp7O+I32lHv32qWLjAFjXmG7PQ+8XfA35
	 WJDJ5PTj/h7SMuXMuW3eef0uuRnQOU7xBFcqwDBxXvtfYhVMmxO6QeD+eVdAq8iCH/
	 5YuPXGtZRZYRRWuns19k/U19Ln90+CGvrPh3Z/6aC9+1pWJxn7nsv9eKBJIuUjZ9Gl
	 P1ckIp9hlmkiPiIbHvxwXvMP8MYoTzpbqZW5eAPcCZ92bJ2tvRl/QBcbIh+fen1OoU
	 p2g5ZaorgjzWhEvlxXNjXAJDPD42DB1exFQnc/Cqj5qYLpzCX1YTDrK6g/4fmn24Mz
	 GAd6iPJkleuvA==
Message-ID: <sashiko-outbox-205589@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 06/20] perf comm: Add __guarded_by annotations to
 struct comm_strs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107044102.1506626-7-irogers@google.com>
References: <20261107044102.1506626-1-irogers@google.com>
 <20261107044102.1506626-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 20:37:56 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Annotate strs, num_strs, and capacity in struct comm_strs with
> __guarded_by(&lock) and __pt_guarded_by(&lock) so Clang verifies all
> accesses hold comm_strs->lock.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107044102.1506=
626-1-irogers@google.com?part=3D6

