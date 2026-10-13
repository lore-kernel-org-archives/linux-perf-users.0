Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7D1501F34
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898741; cv=none; b=MBWHn/WeUtmPffHjUrCjaIBg5bZ5ni4EfXPMeXt3yiVkxvVfmvvQOD8dnQ/ipFjK9yMXt+w6cWnUz4+DM8dfczLvybfJVzMhRJOWBEZKmd41ze0szYKVyjRTHeW02aRPEG2jQhKzppILBL5sKDx5shBjjRthcAJtxI6aETnln44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898741; c=relaxed/simple;
	bh=0dozks8jXApp4+41y8r66bQgCrxDqI0F/oH+ZCDE+E0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=u5lJsc5z6z2+8d+p/zc2Nzs8vxHb9jVy3WLCRqS5xtUurqCZnISPa9UqYZyfbFB0EneWvqqP+3GNSAvPlciB+jLs7zAV8Dm5J9g7lTRvhxPe/bdsTJW8xhuDmk5o03vpI6l9azmo5NLzS6Hk9qwYs0+Q8U3KMyEE1oSnOyrn4EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpriS8oU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpriS8oU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D4E1F000FF;
	Tue, 13 Oct 2026 13:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791898740;
	bh=0dozks8jXApp4+41y8r66bQgCrxDqI0F/oH+ZCDE+E0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kpriS8oUuTTmiEh9JZJp6qBdn2MDIsX3t7nLsenB/OqwNQLRNewBRvZ69QeuBdDKD
	 USfMTPJAu3gPU93YyQ2np4Y+vOCEzwbzV0HOg7jEdIDwdWZuyQECOTFyYQ+0yfN9WB
	 ZRS4Zcu77rWDNeclWXL+BRz3UWiu380ed85LNHt1cRh8p8AIgTiBM17zNDuvABzuXp
	 wgYf3wxOiwRq67ejTuWxYjoK0K4gR5qGfemP152UArfPl+8dyGMhE6mBd+AVS4eWAr
	 vYcKfZz6ZGqCT/kS9fDVFiqLMc2kpg3AO63S4y98SXkwx83LvHvctlT8KKozzSRtrB
	 ZvrG1YIOO4BJg==
Message-ID: <sashiko-outbox-169836@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/15] perf annotate-data: Add arch_get_reg_offset
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <f5639b97bb0aa19662cb1c230db8dc73fc00d986.1791629326.git.wutengda@huaweicloud.com>
References: <cover.1791629326.git.wutengda@huaweicloud.com>
 <f5639b97bb0aa19662cb1c230db8dc73fc00d986.1791629326.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:38:59 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add a helper to compute the effective offset from a base register
> for instruction operands. Currently handles arm64 addressing modes
> including post-indexed, single-register, SIB-style indexed with
> shift/extension, and constant-offset register pairs.
>=20
> Fallback to instruction's raw offset for other architectures.
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791629326.gi=
t.wutengda@huaweicloud.com?part=3D3

