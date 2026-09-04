Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5726E3655DA
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Sep 2026 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788533783; cv=none; b=kKndt/ohY6Nx4o4sxn0t95UcvIKEZNnkDtC4BliTsYQlxw8UQqJKXPV20uXPUD2shFC66bAip2BBCMu3UGsOxnodCibhA5VibROEHx/hVxghOYMY5G7Db7GnL3ysZz9emt3yCRDU2OFbnJ2Wa2qxQyA8PBJbSiaB0B1K545BHgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788533783; c=relaxed/simple;
	bh=jvsbFjfo0RRyNypieraUCrdzuMKoeLwRitcco3pfHAo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mjhC1NcqI32bCQGVU/yYgt35mw04FLbPlZU3cbVi/lyncOqrB2yfHDTkMAjzE8VHaBpIfK6eaHgkuv7QhU5h7VE7dqzDtHG60EQEpS/lu0MtaCC6T9G4xSY0KQi8H1zv+oEHuZQJFuRlr4e1vtroHW8OfMM65GaMg0+VCGlSgiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcDq+LaT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcDq+LaT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E869C1F00A3E;
	Fri,  4 Sep 2026 14:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788533782;
	bh=v58WB1Zrl6kLt+R+rtSHAae9YYKNJzlAXtREWwCdyVo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HcDq+LaTc6UPMQ1jxDDNZrdKFxbKaNB1fpyUWNHRN36HjUinSCUGllnpR7Os3Dc1g
	 KC0hW36YB8E6D8YVbZNGXN6mKErDCZOlQbVD7u3sIc2He3Zb8GcZIPMe4f6znFUJPm
	 OpoHT4m1RrRaBIaD08aTgo4KpMdtsyem2XY71xuZ3N49B+N765wq4p1yupd0XuE1a9
	 pO6hT8L031Udp60NGjCHopDCwYcHv3YN07/tF0JDKVzDc8HfCzK5jpfNezLQQ5oRET
	 D2cJYDUhlLOQg9s7rWFuLimC4cXEurIYsA8S245G5rsDnZ61Z21rUmz7ZjXf9fKkNJ
	 +NfopS0JdysRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] perf jitdump: Size code_move event allocation with
 idr_size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260904144058.3341-6-acme@kernel.org>
References: <20260904144058.3341-1-acme@kernel.org>
 <20260904144058.3341-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 14:56:21 +0000
Message-Id: <20260904145621.E869C1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> jit_repipe_code_move() allocated the mmap2 event with a hardcoded
> +16, but computes event->mmap2.header.size as sizeof(event->mmap2)
> minus unused filename bytes plus idr_size.  When idr_size is larger
> than 16, header.size exceeds the allocation, so perf_data__write()
> reads past the heap allocation, leaking adjacent heap memory into the
> generated perf.data file.
>=20
> Size the allocation with idr_size like jit_repipe_code_load() does.
>=20
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Stephane Eranian <eranian@google.com>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904144058.3341=
-1-acme@kernel.org?part=3D5

