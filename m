Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51D535C6A7
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791299105; cv=none; b=ifS/m3CLsV7F33NH2BlUNkKDOLeiwgG86Nasvbd6WUCHm0c51F9WL4xrXViFVX5Gq8jNAHnDqst949ocUBvnswhj/+eA0wlghAVbjm2BrVPsWZJ445YxJmzD8H2BqAEdKHxmIVwDtJ4disWrXUnWulMjrMzIrKakchtapPNHCyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791299105; c=relaxed/simple;
	bh=kR1EBqS0EPhGesLAP+HNBosDBc26jJtbS1uCDkCgUng=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q7r/FUOqM9UHyhAf6ET9OrKVxzKElI0J3gz/+CVIBwPy/faCcEaqrLCbIT8+ncqQ0ovKs8OdpGPiBIQJw7Ds5LHXKzQpcDAMzZTur76oXouZmXZwqAFFzwCBXzHsj4DEJTeg6s5voEbh6rGkvMi8LSXVgIc32WzytbAzYPV5tSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4IJ6Fni; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4IJ6Fni"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF061F0089B;
	Tue,  6 Oct 2026 15:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791299104;
	bh=oYBQOtuhyLtb7SsTjwCAL7DQBn66kY3XlbCpVVz83qM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q4IJ6FniyZeXzr2LOsnCX97giNY7tcwLOx0wkbG9oPtR8M+PGMn8M6bUhRvx5e4FK
	 yb20GUxMv0WqSD1+Jyd3Id3dGppuYRqQBXL9yQ6quaH22I+rOsEFUMY2RfVC2Q/wwR
	 H0WuLyWq6umiuyC780It9WA86VJfXmRA+ZtUwosEgUWG4JCML1PiZi3tjAcFbqqtIF
	 7sEWLfezQPAjAX0WU0Z3inXDtehuYHGUc9vu6/bUzqEUHfYISaKT+mMh2vHJF+PWQF
	 xYzzCnGf01MZrHB5J4I42gR8k0SSe7NLFbI2lhgTNviBt3lcmbjt7hPiDrR7suasv4
	 EXtOA1s53bHwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/8] perf config: Make perf_etc_perfconfig() never
 return NULL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006145729.3028247-3-acme@kernel.org>
References: <20261006145729.3028247-1-acme@kernel.org>
 <20261006145729.3028247-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 15:05:04 +0000
Message-Id: <20261006150504.ABF061F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> perf_etc_perfconfig() returns what system_path() gives, and that
> allocates, so on failure every caller dereferenced NULL, the
> pre-existing ones in perf_config_set__init() and in the daemon
> included.  For the usual absolute ETC_PERFCONFIG system_path() just
> returns a strdup of it, so use ETC_PERFCONFIG itself when that fails.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006145729.3028=
247-1-acme@kernel.org?part=3D2

