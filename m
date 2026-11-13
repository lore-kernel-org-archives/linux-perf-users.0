Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584658;
	b=LSXGng/GsqczprLfivfQuOdU5wkXYlhtiY1s7mge7N0xUalOziEnbJ6O+6QGpzF7oBw4
	 FhD9T7zlwFdDChSuee1DnTp9Ml3m1TFF62ZA019nJjpTqCUh0jGprv0Q/fmq8vfdk3x8K
	 PsR+bpEueRgcFAre1omNyPJIoGHpcUBw1xQhPwUxv0pF6imxtkHtaWmI4xH91WZ/kDxxc
	 gHIRrfExAils4afdtAk8CqLBo2JhKUn79yLC7iihPQadNAb/Vh+phebppRR1G3D4SlRdc
	 kahAaP5EMeZAWTKzuyqYptNx+4yP99jqI3kO8VMTe+Dmq9tOf2bK/YapURKphQNAV4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584658;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7ipdU4NShK9NHKtxIzN62KHORTD2IxCH0UZRsSqS4WQ=;
	b=xn26OGkDscnxVc81V++8FyeoW5jjGMfrLw3GeYHj2Ut9XII8772wIxeQEGVvHn8hJSQ/
	 SKL5cyVHxIrLTTcgU3o8jkn+/oQvWZcnfyj8GaAF6hewdbiEFr60madCKAa63tE6z1Iwo
	 /SHfaX7oXSuWkptxXDueMdEr57DulnNzype4KvcWJEqfjOn0Hz06G2p7xBj2IGeezPqwZ
	 1aroJczlP6wwFtV4lzVo/AG0C+/Oe0bsk6kr2AtJCB2uvWSauvbAzbg1Ib9R74QML00Zt
	 kK6NDIjuElKIDZiPgRmB0PrgqqPraMH3fzy5UvQKSn+9Gcr+wV/2XvblzjtBIVDeC4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U+J9FvyL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631D7606A323
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U+J9FvyL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206D31F000C4;
	Fri, 13 Nov 2026 15:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794584658;
	bh=7ipdU4NShK9NHKtxIzN62KHORTD2IxCH0UZRsSqS4WQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U+J9FvyLwVVYWyu6J3cMg5xkqjNzrSwK9sJzSwPOjkWv7B5KHwgrUR7qfowaPRfCB
	 WmzzBvXJRFxgxpOj92nLiVAha0jWP1qlmR5a0YYJmaBNt+j/eR61oKXFU7QfH7Jak+
	 O4qdioZudjALMOgG+1L3ji4v87khxHKufX9WnAFf2+klJyYXjr8YJaTVf1H2NZZ9Tn
	 PsAM5hgLqGGtl5K9xIUWn7VjhCFBZCpLsEe2XxuJUsWWSKu2ZrV/hk507v1SBcVCnS
	 Swt6JUFQYN8oxVNe+XWxK9BWkZFtdWAdf6aur6EaOF8pnZFW4/W3jwKmWT0kEHIlyA
	 XF5tMt1jqEXbQ==
Message-ID: <sashiko-outbox-213111@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/2] perf timechart: Add a --live mode to the TUI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113152622.1991001-2-irogers@google.com>
References: <20261113055926.1159033-1-irogers@google.com>
 <20261113152622.1991001-1-irogers@google.com>
 <20261113152622.1991001-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 15:44:17 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Alice Rogers <alice.mei.rogers@gmail.com>
>=20
> Add a --live option to perf timechart and ttimechart.py that runs 'perf
> record' writing CLOCK_MONOTONIC scheduler and power events, or I/O
> syscall events when -I/--io-only is given, to a pipe and displays them
> in the TUI as they happen. Only the most recent --window seconds of
> history (default 10) are kept in memory, pruning older segments and
> tasks that have no remaining history in the window.
>=20
> Pressing space pauses and resumes recording using perf record's
> --control pipe. Because perf record only reads its ring buffers when a
> watermark is reached, periodic 'ping' commands are sent on the control
> pipe to flush events promptly, and a synthetic finished-round event is
> injected on record boundaries when perf record goes idle or pauses so
> ordered-event buffering does not hold onto the latest round. The refresh
> interval adapts to the measured screen refresh cost and backs off if
> unprocessed data builds up in the pipe.
>=20
> Like 'perf timechart record', the whole system is recorded, as switches
> into a task and idle states aren't seen by per-task events. An optional
> workload may be given after '--' to stop recording when it exits, and
> '-o' optionally saves a copy of the recorded perf.data stream.
>=20
> Signed-off-by: Alice Rogers <alice.mei.rogers@gmail.com>
> Co-developed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113152622.1991=
001-1-irogers@google.com?part=3D1

