Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC79648A8B8;
	Mon, 14 Sep 2026 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789398344; cv=none; b=ckM6fFdd4Ypn+LP2/qlMt1HXN0ewydEhENDiarrCdp+bcuAD0tLXAs4PvZ6HmiEk0582xuqWo0aH5IZHuUefUMSZYnRhXtzKcQS4nJgdsICBUFC6HGStf5i7ee83NmTw8DW4KdmfrWgOTbxRvNf4N8706gTa576+VoJVA6Qu7U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789398344; c=relaxed/simple;
	bh=ET0yXmkysazteFRPJqtcVlNwWFiiliVjQUmGg+deAHI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EFMqaZAZL49jEpLdVHyqWXhP8DhGR5wvZkPDaLK6wfV0HPg0EcNPyL77iZAnHbY4q/aIrc24rb79BG7NaIErH2jfLAmiK/uLU+Uj1TClPnd5oEiZm4wJlcMCu5lwwTfB3QF5QyuziHQSLqK+31hShqrqURUIS7tB36nhQxDdSLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRX7qyBC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRX7qyBC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC3A1F00898;
	Mon, 14 Sep 2026 15:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789398342;
	bh=ET0yXmkysazteFRPJqtcVlNwWFiiliVjQUmGg+deAHI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NRX7qyBChK2Pv8edpf+OSPVSWXaXOUmsVW/Qmqt6uEV9PmXJYTPEFzbvlYwUFnzyb
	 BVyM1b3jmH0rv6dkgCsasG++aspcsYxQT63XuR3i4INQOdZcFHepZfwO5lyt87bL3j
	 cg9iZfltDsgEHJ9F4ZTmpQOVal53534GE8PHxj65EY5XzKSEvI24y21SSo6d9xTwtL
	 BLXWPx4OpOwW6rx+n19shSPsKg5PjeuygkIR0kBHENPo3Ru6hBPp6dVRjY6IjPqBhu
	 Im/AWQ33GGEZvNrUHv/Nn6klnBJ3TNVomrAg0esCyWuuiazy3zOwbX8/deDqsLWS5x
	 YdgvqLOr6T7zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 11/13] selftests: tracing: Add wprobe trigger
 testcase
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <178939030777.94750.5923936292118351595.stgit@devnote2>
References: <178939017565.94750.9431053336761330458.stgit@devnote2>
 <178939030777.94750.5923936292118351595.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 15:05:41 +0000
Message-Id: <20260914150542.2FC3A1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add a testcase for checking wprobe trigger. This sets set_wprobe and
> clear_wprobe triggers on fprobe event and static trace event to
> monitor memory accesses within the trace-events-sample kernel module.
> Also add a testcase for verifying wprobe trigger syntax error logging.
>=20
> Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c=
2.1785067572.git.wangjinchao600@gmail.com/
>=20
> Assisted-by: Antigravity:gemini-3.8-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178939017565.94750.=
9431053336761330458.stgit@devnote2?part=3D11

