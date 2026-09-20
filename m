Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8871356748
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882369; cv=none; b=rvR9YLUuMBDHToAkj6NIKswzGaGX+x6jnVrfdqhcvp68JJjD1Aj27H8BbDvr6kg8YOnNbVf1HU0hCf2Tsk12lqG4mqtgTqEHwFDTYA5IUmDwEMjTsUaE3RZzU39iSmRF8doX02KfVs3CU/51fSbt3nDY70V4G60vUFS+BisT1d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882369; c=relaxed/simple;
	bh=6wHMefcjERpZdyIWU8OUL75EY/cMRQFS2ORoiIeI4XM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=brPFBIFQ59+ACvXMgWoYUm1gIMD0T1v1N5mwrj6oXuLzkzImHP95SvVzXH1jkt/f7qrMkTPEt/GX0cfAuMm2mpUO2KPrrnFzr7IN5wFQly8/SpORDWlBfYL2tMPgP9LRghCcXxxTMN0JduNTkvaQmF4Cx/p8O9XBx4UXwD6Ie14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHPHjvb4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHPHjvb4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CF31F000FF;
	Sun, 20 Sep 2026 05:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882367;
	bh=K8ord6f2NiNRcrc/nW6FsBAu4hmUxk3lwDpJaewC5NY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PHPHjvb4DVNwbaEZX/ixNG5rjkm+fVrp3GpzVqKR4iXV3rNIlj1aOT/bEbrN5THrm
	 tEajDCxcmMXJFckSeg4JHbJrFNZurZnYEQWV6Tl167ThKjek+WX/G5WxHFCMy0mzm4
	 fTPLLaNji0eFAWAa6P2+P7l8+cAHhkhFxVBRUTGVIhtcmiC4ocAOCTLvR+0JXilKso
	 fSmMvjJ6cgtTU33GZWCbl1aZksH31adEXGDrxnW++8KU3gNUWcJ9vzpmwAgt5URIdo
	 2h/iWWzSvkruWMFmi/cx7JkAU91ICVQqQIKhKQ0BBv8Qj2aq27cGlAJG2sG4rksSgE
	 kUD+1qEuW9+xA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 04/49] perf python: Clean up pylint warnings in
 treport.py
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <700d8e8c23a22098e4a7b142f4a488da577eac65.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <700d8e8c23a22098e4a7b142f4a488da577eac65.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:32:46 +0000
Message-Id: <20260920053247.43CF31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Clean up pylint warnings in treport.py so that it passes pylint without
> warning suppression comments:
> - Replace broad 'except Exception:' clauses (W0718:
>   broad-exception-caught) with specific exception tuples.
> - Pass both pid and sample_tid to session.find_thread() so guest and
>   process threads are resolved accurately.
> - Rename parameter 'args' to 'pos_args' in FlameGraph.__init__() to
>   avoid shadowing the outer scope variable 'args' (W0621:
>   redefined-outer-name).
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D4

