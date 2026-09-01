Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566FC353A99
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Sep 2026 16:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281287; cv=none; b=LxwY/zGQE8+mdrDUanftT1BfTjohGxlGBDvhp59KUGsuBer3okZtHxH8JEFP7O7STVCwjdbmqI1tNYGkI4z7AzlLKlNe6JOg71xUMnw3drInOJ4tj5YF2ehVvpU2vdtNUByJbx0IS+JnmqNujpaDcaOYMJjVaziqc83pInYHOH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281287; c=relaxed/simple;
	bh=ZV257ltXk+h4F/MEtD40Vmnn9DLM7aep+XDOR5+M4Cs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QVabBg3DQ8Oe0QB8POgULzrzEP08J7e0fW4PzWf6p4j9Puo4qBrcderQmkFlPNj52vS5zrng4mk7kD8hO4qr+0faXmlxbj3C5/IdvVu/KoB4hNS1W/LtCmHJ95Nd0+xASHTchgwVR4LJEoKAFnoGxT8QixxFxh4cWnIgXjMQqKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Up9G6EpC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Up9G6EpC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A7F1F000E9;
	Tue,  1 Sep 2026 16:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788281286;
	bh=ZV257ltXk+h4F/MEtD40Vmnn9DLM7aep+XDOR5+M4Cs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Up9G6EpC1lf8o1bZHW6CxTrCA0jaUQT8Jgt2EViEXx3mNuYTttOZEGvifYPv99tvK
	 jllzYPmI/ajcJ68kmVdoSV1NbYRns7DFByZAd1K6LUyD1O71jOKYMDDcKTGL6mwR+D
	 /4U/0gXjuQmcBC/GDrMRdoofEabO28SiahMRnQJ4ngPFno77ZHXCG3lnETVwK6kxO6
	 i//bWf3TEiTAwskD1Bg/kZ04OQBtFgBrivFtOGQoPjNxBiY8yVxJffKn4r3+rEwrMO
	 LUG8UqhI+HEPy79ibJXbH4zZyRwAYgtKioqnZhCko+G/kblB1m1A83WuAnI4/2iOR+
	 /9lfAnMt4RnDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] perf/core: Export perf_event_itrace_started()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260901-perf_suppress_itrace_start_records-v1-1-c4fbc6860859@arm.com>
References: <20260901-perf_suppress_itrace_start_records-v1-0-c4fbc6860859@arm.com>
 <20260901-perf_suppress_itrace_start_records-v1-1-c4fbc6860859@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 16:48:05 +0000
Message-Id: <20260901164805.C5A7F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Since Arm SPE and CoreSight drivers can be built as modules, export
> perf_event_itrace_started() so that it can be used by these modules.
>=20
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-perf_suppr=
ess_itrace_start_records-v1-0-c4fbc6860859@arm.com?part=3D1

