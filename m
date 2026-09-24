Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0D23F788A
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269979; cv=none; b=U1MF8ZC9ju8MfLPtkDbtYx03UVe7Jek38qLNkzsQVtHAcRqtFKqWoZYqA8Bpa1deOY3vF8uAwRC6HxLi3ngTRcbIbCKATs/mZTK+Z56PiNwft+BEZiTlbEOLBofb8fQrAwztYib8k3X8xFwk66ScaLi4yNi+hLc0dCcrwb91rvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269979; c=relaxed/simple;
	bh=s9s2hhNNZxUEk/Xvev+Lv+OrpSVYoM7ET3jThBho264=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=deMTws3oBbyJKD/xpYbOizv+8dA232uKSt9wNL4rXRAD88ZDPLWX6Vfp/wk6qHsYMpdbqir5FVkW8xZqjaM3ePZ74/4XEpkfCvG5iZ6W37vyyZu3oLv6I+p3YWxF2z1Tzn40qXVFZsiwaBSbgiB4NMDYerrsUCfXylofhPXlIYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQeAckZR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQeAckZR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5E91F000FF;
	Thu, 24 Sep 2026 17:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269978;
	bh=DhO0O+QejVPcUA0yrMIUgX4KAli2YeO7vv6tERAO2NM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kQeAckZRlfYUioIj7ULLNmB07crj4g7s8aihLrt8ILqM9u2vGwxQckMAV9Tf5jd3B
	 V48PQxuYR2c+Dnguvk4GA5Mdb8DB0M1xnHPKbshdUIqIXrG6hI4dWYBiTZ/s6IbJgW
	 AbLa8MSazI2FmNhuNI9sfNTBQ5BOW3ySC6z/4CrYByZWtoG6QFTgTjOeeRvetFWeE0
	 wO6BpNHfP6t1opWto3+BwZISJ69cMmZTKq5rfNLq6qpOh8KzaTTPMELyFGB/uOa6hI
	 nIdZtiBvxZCRgps5oIhqvETWlZ/jXCpi/ONMUDNXTteK7rUqbsCPKPJZrgqYTNqtS0
	 K7nqx+7x2uuTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/26] perf vendor events intel: Update cascadelakex
 metrics to TMA 5.2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924170346.3872848-6-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924170346.3872848-1-irogers@google.com>
 <20260924170346.3872848-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 17:12:57 +0000
Message-Id: <20260924171258.3B5E91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The updated TMA metrics were published in:
>=20
>   https://github.com/intel/perfmon/commit/f9358e8da04bec945d8023e3f9b20a8=
87ad46c45
>=20
> Fix uncore UPI event encodings that use UMaskExt.
>=20
> Fixes: b3eb533ca5c6 ("perf vendor events intel: Fix uncore topics for cas=
cadelakex")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924170346.3872=
848-1-irogers@google.com?part=3D5

