Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CD633A9C4
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620642; cv=none; b=RwT2WbCa6Grmnnc/94Iy5z3K2udS2sTcc5oGmJ+ZnR/vAn/UWX/1K3yxfgaU6eIISIRsI70RFLzwa0ApLOl/UR5VKJSepBPMAjncB35PrrxWna+KRw6/S1qFLVPG4+vfnCUTwL7EUPSqZkAM0aKGk3eX8obRSBbNrU8oGI/fNSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620642; c=relaxed/simple;
	bh=WWAjVwhy9JWF7KSChXpo29MBsTuWs59EdBfwf/aEDXA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i2z+xPRUEgC4O/9ZbUNUsskbnayXERn8Kn3WfzmFfaVP3RwqeoxvskuXN7+tdISy47EHrjxgGa237PC1ef7S99GBzKj1YtgQjf3+ShzgO0tijLILGfKEG+SKvXh1cc4IQQkmAcOnYHbhwVRsS/XYzLIy5yOEw2eDF72KmKPJs9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a23inbgu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a23inbgu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08081F00893;
	Mon, 28 Sep 2026 18:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620640;
	bh=WWAjVwhy9JWF7KSChXpo29MBsTuWs59EdBfwf/aEDXA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a23inbgux3BPaSARmKX1orRowB+Z96XluQV7u7BZneygd1sybQh4fT7EkHqXVG1EJ
	 Wg/ICVrwxNGe7D+zTRBygRnX3V364vidj/dLBPoM8PNwLh0ZkcZP8Nn03iiUz8J6NM
	 zB826UOTgbqaY1kgbmoN4FaukITDYBEfmAkjyIuaLp72USSmBz3Ojyp6Rp96kdWkPe
	 Gq5hTuXSjWuOtgMD5k+HRq6bCHQRBua0ssZEDAI16t0H0RqeX1qRTb9/S+a6El3RhT
	 l06wLira+/HlEx2qGmMKzLOJ5n0Gk+pEouxO1UFnYEFLKWlIDkHhilgvLzqrAyHQ0z
	 VdPqGTVv2H4uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 19/26] perf trace: Add an option to disable syscall
 augmentation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928182605.3649015-20-irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-20-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:37:20 +0000
Message-Id: <20260928183720.A08081F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> perf trace falls back to the raw_syscalls tracepoints, filtering in user
> space, when the augmentation BPF programs can't be loaded. Add
> --no-syscall-augment to use that path even when they can, so both can
> be tested. Suggest it when tasks are lost, as the tracepoints' per-task
> events don't limit how many tasks are traced.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928182605.3649=
015-1-irogers@google.com?part=3D19

