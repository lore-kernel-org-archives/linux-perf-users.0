Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F358330DEA6
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 23:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849233; cv=none; b=G1dt78x8exJvwls5qrYdAUXPEMgHOqQASN99kiw98zZbCkHllamvN1B3tK6XZcf4laLJeDATqnAMP2//hE/pF6B2wReAAUPa+mkzjKvYVfrmnLF6I2E9ARFWRoeuDcRkNfcItW2v8/JST9drSbRuI4UAha1Ml4Xj4F1lO69r+lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849233; c=relaxed/simple;
	bh=/he5EHGy0uEEcG25I279dqmgZ+hmiiQn18MIFc17+QA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=LeehnF4Sd9zf4D5F5nhyDcKbLT9NJC/xP1R5GDrcnjVnrUzDq2syiiKED/Suf3u98aMfKlcmngqRmILgXqEu3RmCFy8oJs5kx7+D53efwnfXWt7NH2EqCGepUVPikQcgZC7ItT8xltnkRa07YOqAzn9+6RzdaBSIAbtbaE3yDLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azvXwAiH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azvXwAiH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E36A1F0089B;
	Mon, 12 Oct 2026 23:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791849232;
	bh=l150IjB35ulH9ET12ssooKXh5/8pzCc+NBeNstOSArA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=azvXwAiHOxmLsp0HfUrbh3xfxX2oWHU5f7l/bstKa5LU8cHM6SxkQy9+lCwFFW/Vm
	 AvDX3OdvOf3TL9pNUd6wpBizEzDOfA4nwQRqq7aqU/r/vvvcohrHt3e1bK5HAtdldK
	 bo1sal2ySyt+KlnhGJSak+s3WHijSQXCm4U1gMbpC8ZNzPWmAnf2NNXqC4KRME5Of4
	 /WfAw8qpLSRThaLUjIvp5RpzlJCvdcQYwoVaIo2O6TyvZzLPe+Zb+qLc+dwd0rKTdB
	 aewJyyVRkNWXcQs3dnmi212DdL/W7WqGBvF7trxyXN359B6CvHgjEICMjKgR4T0uPc
	 GdYnOOWzAQ1Zg==
Message-ID: <sashiko-outbox-168750@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] perf test: Avoid stack trace noise in verbose=1
 failure snippets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012234724.721224-4-irogers@google.com>
References: <20260929025345.88829-1-irogers@google.com>
 <20261012234724.721224-1-irogers@google.com>
 <20261012234724.721224-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 23:53:52 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When a test fails with a signal or times out, child_test_sig_handler()
> appends '---- unexpected signal (<sig>) ----' followed by a multi-line
> stack trace ('    #0 ...' through '_start').
>=20
> In verbose=3D1 mode, print_test_failure_snippet() selects up to
> failure_snippet_lines (10) lines:
> - Pass 1 selects lines matching failure keywords plus their immediate
>   next line ('    #0 ... in child_test_sig_handler').
> - Pass 2 fills the remaining quota by scanning backwards from the end
>   of the output buffer, which consumes the remaining lines on outermost
>   stack frames ('handle_internal_command', 'run_argv', 'main',
>   '__libc_start_main', '_start') and hides the trailing test output
>   showing where the test had run to.
>=20
> Improve print_test_failure_snippet() by:
> - Skipping blank lines and stack trace lines ('    #<digit>...') when
>   selecting context in Pass 1 and when scanning backwards from the end
>   in Pass 2, with a Pass 3 fallback from the top of the buffer if quota
>   still remains.
> - Prioritizing the non-blank line immediately preceding
>   '---- unexpected signal' so there is no '...' gap before the signal
>   message.
> - Only printing '...' between selected lines when at least one non-blank
>   line was omitted between them.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012234724.7212=
24-1-irogers@google.com?part=3D3

