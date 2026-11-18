Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794989030;
	b=UAoV7Xrnl7g0l4BNnBNCr3m21dbEz+fJgPBdIp9igHbbf3fBHGfoa34sufzkpX5Weidh
	 3T7MVyg01nV93X4FrLjSmC0pdmKvqTv41xL13xuCyhtXH21arsnoBVWZvronL/Xd64F27
	 cXcNn7PwCxmVqJfgPGTUa+uEHpeoNmB/I/+1UFC7YjxJm7f4viq2oYWy10EToUR7W+jjy
	 NQLMnUXooyd4AMgA3kD2zqXqakxxahgCF8FZuP6d+QuQAkv+5uT+abiBqJ1aoRU/4QTCA
	 cJnfsrIzHrUwK1IaqOkA/SjZFYznB8Tc+CjyeEdKFd1t4Zo1hhHDT158O1T1RWeFHMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794989030;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=t3PjScTkyuxbtO1zEGqrtlGMTSH8jVbDW3xqCfLUXbY=;
	b=AZWdH1NaSBuum85BI73GOqSpLjfvK8Gg4zYnof8wzUxxFTJspv4I7Mjb4sbOIdXzPXOV
	 I1gHAe89oBMFwPuJdQdNS7ldu1tKzl9d9AO4B7yESE6Y3xNmE8kcAVVy5kX4MhN/hG0Ay
	 Vd1Tdnl5+teQzJ5MqieFLZzygbhJoWqcwPQhQhesaXDKYtkJtLn/aVKj9xeD+QsnP7lOz
	 rwVKVuvHHguVg6tSXAervY3+dmwMDwQ705iE1TuWmPkDmJefFEcrm3xW830UBdQNSQ5LW
	 2aNrZjM45vqTFYP+Vdusm6G6t29CSxfwqRzfnvUaEEXi3rQVTPElPRz4GBqJ+m1DKnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hb7MbUu0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9F6606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hb7MbUu0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26AE1F000C4;
	Wed, 18 Nov 2026 08:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794989030;
	bh=t3PjScTkyuxbtO1zEGqrtlGMTSH8jVbDW3xqCfLUXbY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hb7MbUu0hSK5ONf5yUCnaPEfYRzo16BaaGP4Bsq+TTdDJG98dPiWzwDlImVe3cyrg
	 2ULr3JiTZ44Gd+Gfmn9f8EmZZVzFZ15f8SJvSQuEGlVrAnkizRqNjZSsndXyXLOQc1
	 2mmnd5yth9r+niVWvkydzKr6ETj5K2PZMpRPNTppQweH1eYy+AwW+2JeSHPDurXh8U
	 7nY2vovAAPRo7PzMPr7JkB4KFzkZKttLV0J8OjCqTUhVlMdPqZ7MSxreTAt+YXRRNd
	 jv6DJK6EQ6pTROVrH2eXfcYx43Glf8+vnoSx6IulrAjOdDoE78bvyYHM06P8rkqxhU
	 w+xh8cKSNjrAQ==
Message-ID: <sashiko-outbox-220410@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/4] perf threads: Don't resurrect removed threads in
 last_match
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118075516.1278903-2-irogers@google.com>
References: <20261118075516.1278903-1-irogers@google.com>
 <20261118075516.1278903-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 08:03:49 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> threads__find() looks up the thread under down_read(&table->lock), drops
> the read lock, and then acquires down_write(&table->lock) inside
> threads_table_entry__set_last_match() to update table->last_match.
>=20
> If threads__remove() (or threads__remove_all_threads()) runs in the
> window between up_read(&table->lock) and down_write(&table->lock), it
> clears table->last_match and deletes the thread from table->shard, only
> for threads__find() to overwrite table->last_match with the removed
> thread. Subsequent lookups for that tid then return the removed thread
> from table->last_match, causing stale event attribution and keeping a
> cached reference until another lookup evicts it. In addition,
> threads__find() unnecessarily took down_write(&table->lock) to re-set
> table->last_match even when last_match already hit.
>=20
> Only update table->last_match on a cache miss, and recheck under
> down_write(&table->lock) that tid still maps to the same struct thread
> in table->shard before updating table->last_match.
>=20
> Fixes: d436f90a64f3 ("perf machine: Move machine's threads into its own a=
bstraction")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118075516.1278=
903-1-irogers@google.com?part=3D1

