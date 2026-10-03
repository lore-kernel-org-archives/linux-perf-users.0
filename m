Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32763537E5;
	Sat,  3 Oct 2026 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791014596; cv=none; b=DTbdW/LYox3qkNIK7Hab2X9vNsng8FmQjiNvVNCqc42ITlQlb5h1QNml8UuQIiKlvKat70Skxsbm73OaMZHUhu1/kOc1fyZQfZN2NptRF5O/cDnm2HQM5zErMrDinGflaPAX4D7L/5x4wAhghzXtwd8oCuWKLpXoDB/cqqCnXrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791014596; c=relaxed/simple;
	bh=eeLudBaaahxtsYAljsX8c/ipXHdZPlu0DG6pdBo2mKY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WQlOvbH8YVuJ846Gzyp+Gm8AYtQEWVBdPqv5cUDxJM8tV4FNHjLLYuI2m78hp3M6cFSk8/NnMPIigdlYR0olZTt+/VCxOX2oIqUSP6xEVeLavB/9MyGui079ovz121UlbQ7UA1oeTaoenOATmWg5s/I+Uo7pd86LQU3YAYRqrM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhCUxI5v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhCUxI5v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297DB1F0089B;
	Sat,  3 Oct 2026 08:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791014595;
	bh=eeLudBaaahxtsYAljsX8c/ipXHdZPlu0DG6pdBo2mKY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QhCUxI5vxO0uUBmMH19b7TFhXf65UyB3jSJnfvo9bLamYUCQSpbjzmaB7uHPjIPs6
	 Z6P8ZlG9HY/nVzdnQHArwb7whvVkzYOlUzojZIcuYBht2sOdKa6BmoEbx80KXbPglr
	 KUXf6797npJxaRkEw3uwgYSB80gPANor3Ku8T/nq39ejvTQ4lKCMkujhZSNHxeZ3oa
	 5SuW+xGE4IXRXkxr07qHuOxBMtAGFjmTOZossf7DTPq46kLcqshhBmiqMTiuHEZNlg
	 fQGH3jrsUuxcVIGuMoD6lpa5/q/BoOfDLClkLuMR0XYcGPp1imeW0nYW0yU9gtOGzc
	 CYZYRlzz79ztA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 02/11] HWBP: Add modify_local_hw_breakpoint_addr()
 API
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <179101395802.22872.10335167261010884492.stgit@devnote2>
References: <179101393469.22872.5895666191299551553.stgit@devnote2>
 <179101395802.22872.10335167261010884492.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 08:03:14 +0000
Message-Id: <20261003080315.297DB1F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add modify_local_hw_breakpoint_addr() to update only the watched
> address of an installed hardware breakpoint on the local CPU without
> releasing and reserving its hardware slot. This is available when the
> architecture selects CONFIG_HAVE_MODIFY_LOCAL_HW_BREAKPOINT_ADDR.
>=20
> The caller must provide an installed local event and a valid address,
> and update other CPUs separately.
>=20
> Link: https://lore.kernel.org/all/f9c49dfa49bdc57ba8c0574bc9981c1e581acf9=
2.1785067572.git.wangjinchao600@gmail.com/
>=20
> Assisted-by: LLM
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179101393469.22872.=
5895666191299551553.stgit@devnote2?part=3D2

