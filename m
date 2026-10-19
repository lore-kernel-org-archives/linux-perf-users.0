Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA96F48AE0F
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 08:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792397423; cv=none; b=rwWdF7u85WeNS69szxkDELTuQW0tPByhncQiyTUr6+w5o2uhfwNiHQ6LCmd50pOVP21T5Q0/v7IbBgXRfPts0PUE+6GWJKsfxF7hxMERO+VdZr/ZT0f6/Vt6pUrvHNBJEyRdw9uK4cvPWB8/P6aZVEtP/bj/JjG5itR4UXM3HOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792397423; c=relaxed/simple;
	bh=jR0yYrfae9d7yL54tWDagmmKf0Q0PkImbU7nBy2Cavo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=dalN4fzetsBX+ZR7fOJR7BNFf+rYgEJubq7fDG6PCZHUomkJ5Hma//QeRMkZdqq452M8ySC2YZjojJqOUPWmZpE3GGyTooXFSG91/s20lCwd65Q9//NMsFoxSCyF67zr/YAWAhAXXCufucjlvn3YjZFa3dQj2xTE5HM1/KbN2Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcgsUaGw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcgsUaGw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7B71F000C4;
	Mon, 19 Oct 2026 08:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792397422;
	bh=Ta02U4sosaI2gduB43kR2HA02h5FU8e/MW1qbDpi8pE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dcgsUaGwhabSqc9mEYN6rUbpDaTs8HA9hYJF8e+lJI38tQGq5/nyl3bpyhqrrOpPZ
	 2cZezFwCi0Qr/rKxBx7Pxv9w6k5Coi0vL/WjDYol0hKUUmbeIdXCcc7RIiLlrcKHqv
	 LQcigN+dlTYAi5LewTFl7qtfyeZNipjBJkENku615JMnSjuT6geGSBxDFQV9S5NGHR
	 nCXL/6u8kqIEiVAIQnHdM96OqzMT7je4ysJQcBbZwRe6r2j9W4+AKWwqaBIBTsysFH
	 0P/s4Mh1e5rLnkV7flSY1C6UqJRCelYsErD+e8D9llwb5pCI2FX2n0HaRc907HSRsw
	 yb7DpfOSpM9Ow==
Message-ID: <sashiko-outbox-176777@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] uprobe: Assign session ID before publishing consumer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Binbin Deng" <18983559317@163.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019080709.477548-1-18983559317@163.com>
References: <20261019080709.477548-1-18983559317@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 08:10:21 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> consumer_add() publishes a consumer on uprobe->consumers
> before assigning its session ID.  handler_chain() traverses the consumer
> list under the trace RCU read-side critical section and can therefore
> observe the new consumer while uc->id still contains its initial value.
>=20
> The race is reachable when an uprobe at the same inode:offset is already
> active and a task hits its entry breakpoint while another CPU registers a
> second session consumer.  handler_chain() may store the stale ID in the
> return_instance consumer array.  By the time the function returns,
> uc->id has been assigned a nonzero value, so return_consumer_find() fails
> to match the saved ID and the session ret_handler is incorrectly skipped.
>=20
> consumer_rwsem does not close this window because handler_chain() is an R=
CU
> reader and does not take that rwsem.  Assign the ID before list_add_rcu()
> publishes the consumer; the release publish of the list node then orders
> the initialized ID before readers that traverse the list.
>=20
> Found during a static-analysis-assisted audit: candidate sites were
> surfaced by a Coccinelle rule, and the reader/writer paths were
> confirmed by LLM-assisted (GLM-5.3) code inspection.  The issue was
> not observed at runtime; it is identified by code inspection only.
>=20
> Fixes: 4d756095d399 ("uprobe: Add support for session consumer")
> Signed-off-by: Binbin Deng <18983559317@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019080709.4775=
48-1-18983559317@163.com?part=3D1

