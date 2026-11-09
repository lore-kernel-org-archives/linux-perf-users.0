Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258802;
	b=Om20Y1GPavsgvT3D/sYZx3kdCQJiB324b8PeU6pmhkF/ABJ8qcQpT1DQe2/4aJ4MNTf3
	 4tVjm6PjZb8Blb33zFcNqRw7v4xoFB7uZODUCJ0PxcDTVi5bc/aktKCb16yI+P96kMKkj
	 4vUaizvjCS+wflGlkfN0Oce2VLI61xiP7UEoYXRVVy9PLjQELB5F0IPkzaXJeWNDJrFrp
	 VFULHKc1zcQ4HkOAA0u1N7NcawkTPbBRJht5jq2CxoeZTLM0GZPm/+13alVy7Sy1Kz1Xw
	 XnE3NcNAX+EgUBq1MLr/P6Beu6uLu+cKqixdvbv9HNkVGsa+QePGvceZfUN3BdXXPLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258802;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cW3GThpjwPc+RSBzeeA/JHnoQrs79yhnIWM+/74126g=;
	b=5qG6/jcE2YLH1fkTB5KVSLAgjGv17J3gC6flSC1MUBKqrRv261fs0UgD0/a4igOUDpuq
	 6pKDj45ulq1quUesjl9ZzbBrOOr+JpnlU7sLGhGMw3NxG/vziK/zY2KtJqXiwPouYsFTf
	 J8MQ8aQBXHFzE2o9iXOSaMEwCKHP+Jkifl0X9YSG6SPPohBs9zyB+bj4CCwQiIUbBvWub
	 Xa5AUzmOJuc3JANbqPKx569/iI/G8BRnlWCtJP4cjfsZ5c4jzf7+yu0ZB+n5Je7eZtJdG
	 8/YBOlsWPzw7HvW4UNT2vaUCz0wrKt/Mai694g2jN2hLahvciYBYoq6c3cDk2oVCfjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GSB17fBR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDFD606A326
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 21:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GSB17fBR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C401F0089F;
	Mon,  9 Nov 2026 21:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794258801;
	bh=cW3GThpjwPc+RSBzeeA/JHnoQrs79yhnIWM+/74126g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GSB17fBR4zDa8EuqXhikr7FXbpoBST/ZiQCm3nLo3JMuBfD0caxoABuj8u5xZz4uw
	 gD8S8A0UboZB7yrtfrtTNw+uduBgKUVgfhXdUybxH9vyb5Ri9AQhujxoLoxfRn4jcn
	 NmERt1KzpiP9K7+zvW6gz4qlT6oJbxhlyKdR0jB8mikQQIUvg8eAkJFwQ82rxZ6As3
	 RRvBZyhJiT6z1SjS6NIsiWHcqsLk7lrM40/FeX5CPPdOSLwyOZs4kffq1sXNpaKdrH
	 XkfsSyfz4P6gTsOhf7dq/OmBP0S3dYDfJVn5/AmKsRDwrxczBr8Jr1owUkSr/FLjJb
	 gN47YsmjyxtXw==
Message-ID: <sashiko-outbox-205647@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 10/20] perf dso: Pass dso_data to close_data_fd()
 and dso__list_del()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107044102.1506626-11-irogers@google.com>
References: <20261107044102.1506626-1-irogers@google.com>
 <20261107044102.1506626-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 21:13:21 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> close_data_fd() and dso__list_del() only operate on struct dso_data
> fields, while close_first_dso() retrieves a struct dso_data * from
> dso__data_open. Pass struct dso_data * directly to close_data_fd() and
> dso__list_del() so close_first_dso() does not need to recover a
> struct dso * from struct dso_data *.
>=20
> This removes the REFCNT_CHECKING dso pointer from struct dso_data and
> avoids dropping _dso__data_open_lock in dso__list_del() to call
> dso__put(), preventing lock-order inversions and races during EMFILE
> eviction.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107044102.1506=
626-1-irogers@google.com?part=3D10

