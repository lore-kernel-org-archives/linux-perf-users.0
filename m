Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D23544063E
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Oct 2026 11:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791371177; cv=none; b=TbqMgo6UUP4zWczZ5tolKDOEtCCUah5cSREPQT6y5S02C6OVGrpjIAgTOuhk8sYSARUALuAtVVsJOAHZNAIb7RTeLN7NuNmRAk5xKdKyu1Td9R8Q5hWPKeadNr2j0+FC6GZFd2yjvdFu7oyvK4OtIV0o/7VlmX2/2So3NdueZDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791371177; c=relaxed/simple;
	bh=VQ8wWbn4s2hYYFLx7t8RfWru4NotlyVkFbp4XmYhzIg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=F0ifHuuAKxlCUGo+cUd8n1ymjn+RalBYYbwHAHawyXjW7bZSthuR3Pz/2Majugm5dLH3rlZOil/6fEeozYO3OK7olSlBSY1BGT4YxYJxhOCU70c6MdTMnBsE8CsN7otvLbPEwxb2KUIWMKSqojhXZIKtSvu8iHyZThUTikYaZ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hB5YmGQr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hB5YmGQr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641101F0089C;
	Wed,  7 Oct 2026 11:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791371154;
	bh=VQ8wWbn4s2hYYFLx7t8RfWru4NotlyVkFbp4XmYhzIg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hB5YmGQrT1fLOYb90OTGgK22D2dZnMOEBuphJll9Nhyu7A/3E5n48aGJKFizjwP7v
	 VmgMX16MPvngTPWUYDBZdsmld39GlnB5+h8ypoVkqRS+2gppAi9WwQMZV2L12UP92i
	 dcwetcSC9wKIMBkHcWOxBwU0VY3OJeTeM3q7nJs+OEQVJBDKrxN/CI2cHrAbiv4pPw
	 LTDmDhmMw9zLdM9Tvsh5Sqw1azV7E7fQd5yIcBdSzad3uOSSqr/rdq0kJZ/6NzyrTZ
	 cgnmWZp++cxkhTur12Mn4B6pfPoAvvj/eG2QMeAm+YaE1rPKiSG/5k3jNKFARJmYw1
	 4cDkGgw+bELZA==
Message-ID: <sashiko-outbox-162907@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] perf tests: mmap-basic: Only test userspace
 reading on supported platforms
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261007-rdpmc-detection-logic-v6-1-d7ed6a85f864@linaro.org>
References: <20261007-rdpmc-detection-logic-v6-0-d7ed6a85f864@linaro.org>
 <20261007-rdpmc-detection-logic-v6-1-d7ed6a85f864@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 11:05:54 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> mmap_user_read_instr() and mmap_user_read_instr_disabled() are the same
> test for platforms that libperf doesn't support userspace counter
> reading for. Only run the 'enabled' test for platforms that do support
> it in order to simplify it in the next commit and not run the same test
> twice. The test can then assert stronger guarantees and have fewer edge
> cases to handle as we know it only runs in places where
> 'rdmpc_supported' will be true.
>=20
> "unsupported" hasn't been a relevant skip reason since
> commit 588d22b40480 ("perf test: Expand user space event reading (rdpmc)
> tests") added the UNKNOWN fallback for unsupported platforms. Remove it
> and leave only "permissions".
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007-rdpmc-dete=
ction-logic-v6-0-d7ed6a85f864@linaro.org?part=3D1

