Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910BB4CCDCB
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 23:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791330591; cv=none; b=ZbSdNO0kKW6B2bEY8+D953n/KfUsDnf/cr0ARHrGphuxbq7lBhNjZjxVSZCqcd9lxySZ5p2j2TkOSS7imQQKrwtgfjLHyznbiMHG8PBR/csTBco4F+C3m1+2ddalsqVE+pBQEzW5IfJ0Lu17VP8H7M9CLYq2wnE4/G7M//S4RPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791330591; c=relaxed/simple;
	bh=KkOmEVXZ90A9naVTa6qvc77rc0A9nDyUFa2ujnoLMsA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ZO/V07D8pUcEN9qjUpG1sOssj32oLJ25g8DXjFRhlyLjFs7ke+A0zEx3wPhaD++zuO7kosfIZPaConr+jpYcoMCHqK+ceFvoaFZJ3Z/aFyxyXxMl+cWhVQ3GKuIQS2Oyj/eInzysEK2ZtFR0UUvF/sQmkRAqwPHJxR33f+BscDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQxD9uch; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQxD9uch"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C121F0089B;
	Tue,  6 Oct 2026 23:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791330590;
	bh=KkOmEVXZ90A9naVTa6qvc77rc0A9nDyUFa2ujnoLMsA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VQxD9uch9WClvC3z0OoMcsRDcW/kKjldnheKVMDIC949qZeHXAQbDGOS7c/OuTAyI
	 Wx1DfH/8HT1+fBjTuMirAbjaeDdltycwEaudlnmtfggiU/q9han+pm8yDa3Fg3FQ58
	 CPfiuE15qwUEI0l/+I2vNQXoC9cMtiaAjiJs+A6GAFbVTKNqeeDCHR5nvvKHAGQvI2
	 hLY+m6BFYKH5A9/5otXAtiBxx7RwBjiYARChoU0sk++tm6OsN7rHhA7KE8PohVknyC
	 VP2U7CgdS91jL1r/wt96/1g1lF/tYcuRc7bUU1fpgW3lJ9ISnzP/UNFT6nLgq7jlH1
	 DexQ6HwDyNSug==
Message-ID: <sashiko-outbox-162525@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/10] perf tools: Remove redundant dso data init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006234315.920817-2-namhyung@kernel.org>
References: <20261006234315.920817-1-namhyung@kernel.org>
 <20261006234315.920817-2-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 23:49:49 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The fd and status are initialized later with cache.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006234315.9208=
17-1-namhyung@kernel.org?part=3D1

