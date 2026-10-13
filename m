Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C94B4A6884
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 20:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922738; cv=none; b=GFztS00jyVdGqjcGfqRRXLJ+VyBOM/+r+H+0Dba2Q/uUGwPSpgQ8uo6Hp8irNPlAWCr35gyQ3lsxbBphxD9nwT2hOL5YKgf8Qs5eB350w251jO7apLcc1sfCNLzfoqiClQ1NTK0sHT30Vtau3b836HMqKLH4XZlOcPBkZgDQuQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922738; c=relaxed/simple;
	bh=EziAPVx/OwrB9NQg7pmEIuGfM6hV215Sb/XxHmU1hac=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=OByowCVw8rbavxTcX4Kwqwr1qdEm6h83eR8BaO6D1OcocEhpVFeGdPnUd72YzR7KTMfN0SVW+mn0xvNvSFd/eYZMkRHbRZjRHED5HZ2W5tf5Vt+6dvZSTw9ST1P4GuPw7bbbX470gf3NqIUxCYluUTrU6gzYT2eQyKF2JuYQMQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0OjIodS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0OjIodS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548511F000FF;
	Tue, 13 Oct 2026 20:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791922737;
	bh=NbUgp2JdiJRmMjpCHCzqgheq8U79azBx6ZrGoYuFsfc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D0OjIodSZTTENGmWW/F5HC+qdBzzgoir5lqcpW49z0foL6qEn+5Iz3lkhjMAGYloa
	 HZFNrSbtaUxrgaXkzjMMxxF8Ouf8YZ0CBYJG35RePTah+G7XpbfQSJrdwUj+WEw9iX
	 PobfDPhFPU/tfrv5Yx76KchjwCBE0k4dnn6YPyS70OVY/OgehwzcgyFM8mpwApHn2s
	 A69H6ot6UQCv+1/YHkC310seWx5U9ilCJHGgTHNuht1ySw7wamnel8WoxNPnbUZkuP
	 59/CJdZpbbHa+14k4k7U2gyez5rkNLv2rco7vsB/M8FLxOCNokHZ8YIkeup+wV3Ov5
	 KVBG5eTt3nlQw==
Message-ID: <sashiko-outbox-170443@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/19] perf test attr: Relax group checking for
 ungrouped expectations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013201415.36428-6-acme@kernel.org>
References: <20261013201415.36428-1-acme@kernel.org>
 <20261013201415.36428-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 20:18:56 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> When matching the recorded events back against the expectations,
> attr.py requires every event opened in a group to match an expectation
> that declares the same group.  The perf stat default metrics open the
> events of each metric in groups, but the test expectations only verify
> the event attributes, so test-stat-default fails with:
>=20
>   FAILED '.../test-stat-default' - group failure
>=20
> Only enforce the group of a recorded event when the expectation it
> matches declares one.  Expectations that ask for a group are still
> verified in both directions.
>=20
> Fixes: c7adeb0974f18da4 ("perf jevents: Add set of common metrics based o=
n default ones")
> Fixes: 2dfc0cab3da4a205 ("perf stat: Add detail -d,-dd,-ddd metrics")
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013201415.3642=
8-1-acme@kernel.org?part=3D5

