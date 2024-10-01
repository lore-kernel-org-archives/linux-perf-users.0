Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3657A19C56F
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Oct 2024 21:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816434; cv=none; b=RGJx8PyOQm1yBxXgSrYADd3aPJk1u+nAPcjXD6vcatb8MG8bNjySTMSq4sscW/aHTtt67FKakxHcet3vJ5piH1JNjLaOIphkDldnj8Tl01pf2pNsoPB4JJXFSbMHBfkr5z7R5BDCpu43xDMkZFJm62l93Y2J8nmIOhjGQ7RXMdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816434; c=relaxed/simple;
	bh=dk5TaP8S924T6KPHDKzITd7SbVXIKAvekNT4n+Zdz0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ISw7+cMFcyOUwsFI8tOsN4QWUwmPLFzxJjOLl5tLFEAYAExI+0moO5b6Df78RuXT5X4RLh1tNpftoxDuINxJZt7vv+ZL2nQPZlt390atnaGUDtGOOzHoxxpOcSmVZs8CXBcOLeH4yxAFwPGW0vVPTV7OIEjIg0qzWZxCa6/bO84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwfU1Onq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwfU1Onq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61AF0C4CEC6;
	Tue,  1 Oct 2024 21:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727816433;
	bh=dk5TaP8S924T6KPHDKzITd7SbVXIKAvekNT4n+Zdz0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TwfU1Onqa9g1sLubBXDaVednUsyAzbqnlRApmkxJgY0x16cCWXy86mWk1eHkHnOIC
	 kg3uJ5sfMwkl1aGlY7Czfbix+ZAGXQVWS4Oi+22JzRfjIbZcOax6lyFxW4uN2qE4RC
	 eZ7SiYLv0Zs2wrTfEHARlWRK9+xnaWkKCQaaWklexHM997Ue60yNBi9R4BvuDW3adS
	 a40bM1w6WC8LRP3zgXoYtPEC5MKsc7kgGSr/GMI9+tTFlJTCVHzRtA3Xbc7n06Ulff
	 nAITG2lSUjMp2CKgNY3+Dye6JzgnRa5mh8xPrc2EubZT+E22TToOmkZ6d1Q6Sqlw/E
	 F2uLIKguufSmQ==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	peterz@infradead.org,
	irogers@google.com,
	linux-perf-users@vger.kernel.org,
	Yicong Yang <yangyicong@huawei.com>
Cc: linuxarm@huawei.com,
	yangyicong@hisilicon.com,
	jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com,
	hejunhao3@huawei.com,
	prime.zeng@hisilicon.com
Subject: Re: [PATCH v2] perf vender events arm64: Use "Topdown" as topdown metric group name
Date: Tue,  1 Oct 2024 14:00:32 -0700
Message-ID: <172781642010.2468569.13804366330312631996.b4-ty@kernel.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20240912063903.31460-1-yangyicong@huawei.com>
References: <20240912063903.31460-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 12 Sep 2024 14:39:03 +0800, Yicong Yang wrote:

> HiSilicon HIP08 does support Topdown metrics but perf tool complains
> when trying to count Topdown metrics:
> [root@localhost tracing]# perf stat --topdown
> Topdown requested but the topdown metric groups aren't present.
> (See perf list the metric groups have names like TopdownL1)
> 
> It's because tool's using "Topdown" as the metric group name[1] rather
> than "TopDown", so follow the convention. This is introduced by [2]
> which allows to use json metrics to support --topdown function.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
