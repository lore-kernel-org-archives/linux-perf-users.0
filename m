Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99FA42FCA9
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790178396; cv=none; b=iweNvgKqBFqBtSmj1/iNmRk4tqJ0Ytb7wkIAqhSGnghTHzB9s5Eva9NYPPJJmMOFcb92uBs03010wggUxxvj5vwSVXN56Z50RQ6q6IAQ2hrFF5X1xmq+xjc9El6HC+bSpFKkQZIxSAVDU+pqcTowxWujrENawcmHfLjf2e+JjBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790178396; c=relaxed/simple;
	bh=U9k8OgFgOZN6UhW824OrPa6q1/JQELuX1qlPGdMEmww=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U+5chppTlTvew5RIjlQAgCtd2ija2DI+Vj9Jk+HH8x/Zr43AJgf0kb46+aQuHx1pBwQFJl3ah7rWueOy5XEj3wIQ+dTk2M91pKhPUw7qI+ODHzW2B3xHvpHHHdCfW6Ef1aSwi2Xt3nwqL4VtycFZrZtqfeHnagiuHb27UvdDIT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJRQKCIL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJRQKCIL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BB31F000FF;
	Wed, 23 Sep 2026 15:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790178394;
	bh=U9k8OgFgOZN6UhW824OrPa6q1/JQELuX1qlPGdMEmww=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LJRQKCILmbVf5t2HeUNYUIvqnV/Le8V4FwD8X8JKXZe4z4nlJlkOiNMmnKAjRjc7y
	 UOa+s8Fl/YyRHBCCMse4yCnYTj1HTiM3Hdz0vNUe+DISb9NrHPEBAxS/VuWLBaxAFK
	 7eGxW3vG7UFB1jXxY4Hg8F2dzbJzLSNAKqqFt6TD/WYF0j8N3s9zB4gJaYQVaw2l4L
	 9gsyHwq+hvzIiEPFi1t+ja3Ed8cJErixb76h9E1AHo202/d+VTXMQW0/MhslSbVD36
	 a09Tg155uLpx6QnNPMEdR3xmBoZGeXo59gha2QoMNC1yykEbyUWcr7ojaa+Hc7Mc0D
	 9YQ5X9m9fAOQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/14] perf cs-etm: Break branch history when
 instruction memory is unavailable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923-perf_cs_etm_fix_non_taken-v2-3-6ab8c07a5455@arm.com>
References: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
 <20260923-perf_cs_etm_fix_non_taken-v2-3-6ab8c07a5455@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 15:46:33 +0000
Message-Id: <20260923154633.E9BB31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The decoder currently ignores OCSD_GEN_TRC_ELEM_ADDR_NACC, allowing a
> subsequent range to be paired with stale branch history from before the
> unreadable code.
>=20
> Treat an inaccessible instruction address as a discontinuity and flush
> the pending range and branch history before processing subsequent
> elements.
>=20
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-perf_cs_et=
m_fix_non_taken-v2-0-6ab8c07a5455@arm.com?part=3D3

