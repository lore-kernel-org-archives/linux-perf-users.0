Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793052412;
	b=RRO+XyaL3EcuPpFkd4UL+HPgxmnnDUlHCBioIyRTfM5DbK77yPXSZmkRz2wmd05T3fBR
	 m/A4+lAB+nW14mFsPX4SFIB3L3dlXaj7fBYLtuERQhAnPkPU0HkV1FrPIaehZyEerISzh
	 eK65Wqt+wL+7o9zIaer3uHkIjJzf0KHabLu2PSwQDWA3bfW7UQ9i4qM4GYX/gfT5M3u/t
	 YGfvi67pTGtaxS8OxNS1edZFNtq4DZ5nOvZ/RalCk4GLXko3xPGaeVTP94/AFiBAR1nvN
	 Gu9CnNqpCLqedWu9hIfQcV+pWHKZvtqYHetNX3H89AmPgavvwBdclkTDTSUiSyw5XzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793052412;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=w/Z+clFb5OcsFT5CZgWyK9KSMEBhWASnf6wBQReNukg=;
	b=MRjO7YfJiUVSV/ByS9MzQCVL169C/xgQ/FKxLcwCi25Ft7O7qSiiQOL8/qdERcbgTRZK
	 HKfCPNwnTTCJw8cW5QeZBLRFXuQ8qs5kbt52D8wK/4h4/t5CQ33fG81HxYIsOa9s+vAX+
	 t6SKKXwI+gsKTsrylmRRlKFK1NJtmnwNBIroDj1TJxHBSX2wZFGQkpzaA1jv8P14B1ltM
	 iORxF3JU2SVJ70+MOkjTG9O5Si0jeL7/fh6MLSTeVu/goYuVHz5Yg1dfO3Qsx3HNUeeGL
	 vLUcfubdZMOPQHU7R+bCKliJTSfUm6YRNo8IkVWr5+/tz+AYxMNRI3jv1Eu9FAoi0BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fpS/wl1B";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CB2606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 22:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fpS/wl1B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75A11F01825;
	Mon, 26 Oct 2026 22:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793052412;
	bh=w/Z+clFb5OcsFT5CZgWyK9KSMEBhWASnf6wBQReNukg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fpS/wl1BZFQTcdQQtBHywFj9k3z0HqJkkhbuZw9VPR6zYTMCzzhCMhDCNgeXs+j+k
	 J4G59X0acx0SrgU8tKR8tlashjtMoRbFWz3h4qT7/BUYfuV4+oKjQ5yl7Zsunn1ao8
	 ttlgiaHkmIqYhFMbDZi7HAn1BPMBds02+/JY5yG7JHrc8Frm8gUikRrcA2jTUIkdhb
	 SdXmkyu1KHvIvglUuQ+m6mVt/4JKqWeZIaC7/j6PXSa6DCMoP8nLNjGY6zLmY8QwNX
	 Ryu3SpUtCaJZB6I7NjURYui/xeSb9QjW9yrzMEqt0Zit7M9xRg/Z1gcd2eHDgTFp7B
	 qlNVCn4il5Zfg==
Message-ID: <sashiko-outbox-185781@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 02/10] btrfs: Don't copy encoded read data to user
 memory when canceled
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Houghton" <jthoughton@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261026215226.3713941-3-jthoughton@google.com>
References: <20261026215226.3713941-1-jthoughton@google.com>
 <20261026215226.3713941-3-jthoughton@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 22:06:51 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> btrfs_uring_read_finished() copies the data of an io_uring encoded read
> to the submitter's buffers with copy_page_to_iter(). It runs as io_uring
> task work, but io_uring may also run it with tw.cancel set from other
> contexts when the submitting task can't run it: from a kworker when the
> submitting task has exited (io_tctx_fallback_work()), or from
> io_cancel_local_task_work() when a DEFER_TASKRUN ring is torn down.
>=20
> In a kworker, current->mm is NULL, and the copy does not reliably fail:
> the user half of the address space belongs to whatever mm happens to be
> lazily loaded, if any, so the data may be written into an unrelated
> process.
>=20
> Don't copy the data when the task work is canceled, and complete the
> command with -ECANCELED.
>=20
> Fixes: 34310c442e17 ("btrfs: add io_uring command for encoded reads (ENCO=
DED_READ ioctl)")
> Signed-off-by: James Houghton <jthoughton@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026215226.3713=
941-1-jthoughton@google.com?part=3D2

