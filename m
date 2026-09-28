Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDC1375F81
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620600; cv=none; b=kuCih09NQ7BwEli0kZuTmEYC72VifNyP14ogm3DDJFxoL1gXP4W9R1qHs9ys8G/ha0oDKQcg+Eet/steLt8JSwCqZ44qmHLc3+6GRj75XnQ8uYhzZD9cuH7xMV8iKsGGBn8p1/ok8KpTgItIKlgxp/1l5K+QIbpb1K28AS5nJD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620600; c=relaxed/simple;
	bh=PjWuo/dMAQJd+pxaS74ETJdd1sXBTa1xSuJ4myXT+Yw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uR1F7TcTViUcrBVU6+dqRy72qxsLlcs16LalumD0JHl5KklkChhrsqXGFos/Cj0Vd1VCODgosIca8tdb31+AQKxeYWV+XPVBHA/DNuSqUcyyWHhbZaNELVROYjkk1b7LyjFH6VLeelsRmGIwfMMybhb3rVgOhFptvi9My71N1/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaaXI/Jk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaaXI/Jk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC0A1F000FF;
	Mon, 28 Sep 2026 18:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620599;
	bh=PjWuo/dMAQJd+pxaS74ETJdd1sXBTa1xSuJ4myXT+Yw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DaaXI/JkP9b8YTUtVcNYUKRNtiPzyRmE8uZHH2R5MaLt1VdYGFqj+IkwGJOAhuqTW
	 Bd9oSSNN7WCzV342R74BXJjuVwWAVld6umTMILpRb0K2Tap+iS7uCRy8hDr9oHF0+0
	 EDXp3DlV7v1wNNYJFtT7D5V9K1o7Wxxr09pnn6VMRIJff+i9XYKkMDrwkmOyZ4joRG
	 fgsWg+Yjwxf4iR8gnZIsSFbeSgNAiGkFeBMW92ro8clU+fpiDOSxrioEEbQy+G+u9s
	 S4DrWmYAN+S6Taju5QAVc+CgZyarB1fZKYkgbWjmDcYXye6vmrxGefIH1uZXxQ/scK
	 3mStTcwVne4hA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/26] perf trace: Don't read sample padding as an
 augmented argument
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928182605.3649015-4-irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:36:38 +0000
Message-Id: <20260928183639.2CC0A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The kernel pads PERF_SAMPLE_RAW data to a u64 boundary without zeroing
> the padding, so a syscall record without augmented arguments still has
> up to 7 trailing bytes of stale data. syscall__augmented_args() passes
> these to the beautifiers as a struct augmented_arg, whose size is then
> garbage, causing a crash in syscall_arg__scnprintf_buf().
>=20
> Ignore trailing data shorter than a struct augmented_arg.
>=20
> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Closes: https://lore.kernel.org/linux-perf-users/arJ-gpzqOHk-gF8T@x2/
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928182605.3649=
015-1-irogers@google.com?part=3D3

