Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1052560AAD
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873318; cv=none; b=a3DLddbKcE2Ln12GmHPQ0sWzYECqTslk+xeOlGfr53DCFFCSXoJ1lh4hSZIZXd/F/MzTHsVAer8df3EpxdJ2bovOKM9q9FGbn1VNKQB14zQ8vTJT8Zpxny1v1jyyFtoVqUIAqd+GbqA0zjlg54hnbA3EeKvz5wyqX+iNwwae3Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873318; c=relaxed/simple;
	bh=Z5ZOdTiBa6J+bg/2o7tocJvhzVlf4bjoiMRIP/TecQ0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mBVRODUlnsZk8/kzVK8orTSzxzjUEAclpi5VPvSZMz9GOZsjBDUrb77br5l5fPRYv65cAdReotDgGTjWD6rEUT/CYKwwLDBk6LR56PvqQvCb2DR2RSql8gNm4uGrGdX8Dns+HeIRLc7rk9m5Z24Xgk0x4hrUH125whD7jpihumc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwbyTpB6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwbyTpB6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C991F00A3A;
	Tue,  8 Sep 2026 13:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788873316;
	bh=Z5ZOdTiBa6J+bg/2o7tocJvhzVlf4bjoiMRIP/TecQ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AwbyTpB6/+AAmWb/LXZz9PA2ihbESd7ma5uu5L7O66gnwEVrkjs2H8Wv7gdTtHxE1
	 ge9Wj5zqBq0ESfYdgHY422ZGwY0BXf/9745ColvbIk5SrI9WAy9loqyF5alQHrrX0p
	 DOEdmXISUxvz9Bb4PycYNfV4jXenCk6azd7avjMccusT/X27tA2MegFjk/M3SUBa1m
	 XKG6aauTn8SvFPUll25liXU9h2uGttKesvf15/x7bQ8DLZUUIal0ZpUpJBiAn39V8h
	 YzJuwVoeppRmJpkzunEZeht5DVAhoZhRCHNyJhy4PFFqxQoTJdwnwRA/Ha9ixLPm00
	 GEYhGuXrPLDHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/26] perf annotate-arm64: Handle load and store
 instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <37f13e322f75aa96f9cb8b71f401c9911523f8c5.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <37f13e322f75aa96f9cb8b71f401c9911523f8c5.1788872630.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:15:15 +0000
Message-Id: <20260908131516.31C991F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add ldst_ops to handle load and store instructions in order to parse
> the data types and offsets associated with PMU events for memory access
> instructions. There are many variants of load and store instructions in
> arm64, making it difficult to match all of these instruction names
> completely. Therefore, only the instruction prefixes are matched. The
> prefix 'ld|st' covers most of the memory access instructions, 'cas|swp'
> matches atomic instructions, and 'prf' matches memory prefetch
> instructions.
>=20
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788872630.gi=
t.wutengda@huaweicloud.com?part=3D4

