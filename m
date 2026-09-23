Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7467244B694
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148417; cv=none; b=AkXVYXNAs7xoSkfwn7LvH/7UUKi7zBDZq56AwKqPTw14YHXEjErphfrzQKMMrvGOh65L/y9Z+hK+77Bln8czmigwTqC8nqOYx3HMuCo9Ru5fD7TA6wJar/ZRy9z+WXaq1ibAIboXU74gjolE9MNLsJaYkKmYFz9L7e5gNCjjmqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148417; c=relaxed/simple;
	bh=bF2EmJ3x26SaG9fZYqwNxzi4CJnSelDITPCiJcQT7FI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gs15Gokg58aVzcCRkC4OOPsh0dmwngkZonreiRopTVT8PC6BMdcKqAMOxNQP1iPQdotJOBQckk/rblvWlqKCJlCsJ+1kuRpaCAKvoAlfA++Kokb2pzKWLdp/D6UM7evAKqpjkFfAaZSNAFCznCVCsgJ73JonnckfEZVMd+ZLq4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7TMWbCW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7TMWbCW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3BC1F000FF;
	Wed, 23 Sep 2026 07:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790148415;
	bh=InLG0bB3N9x3ILmgIN3DCGQX6nhpb7+nqJWdbdTFSC4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M7TMWbCWMiNX5CpTEuQfuWAOH+nGl/Mgz1hEoZz6WtL/hFdXUmpNPVxkmyfVFhYPM
	 ia9Trnuxr6oil8WXu5cK+hVCi0oUAdpz8l+oXErPeMrwPWIGqxYvZdFK4UwEKY7E7N
	 HtfaWFAVay0hB/R0yegoFqXKF+4cNKwz6TdYySKBlbcAXHMZ9QDUvkDIVaLy5eFrMk
	 EctsfrkSloMf7kmrQJjJHCvB7HzD1c9QX5t7B/itNfBXDYmfYLqiwiso3zdNU7QMbc
	 rWK4+NFSUjdI4atd5R3V5ldVpI2YBYOt94fqAI+W2Pco1wrNtTP2hf75Ei9VhgfqIC
	 //ww+ZRXJl2lw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/23] perf trace: Skip internal tracepoint fields in
 formatting and beauty map
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <4315f435177b66e0b25ca9b74a89cc2f51d3801d.1790145937.git.irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <4315f435177b66e0b25ca9b74a89cc2f51d3801d.1790145937.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:26:54 +0000
Message-Id: <20260923072654.CC3BC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Linux 6.19+ added __data_loc char[] internal fields for string
> arguments in syscalls:sys_enter_<name> tracepoints (e.g.,
> __data_loc_oldname in sys_enter_renameat2). While is_internal_field()
> was added to detect them, several places did not properly account for
> them:
>=20
> 1. In syscall_arg_fmt__init_array(), when an internal field was
>    skipped, the arg pointer was still incremented, causing the
>    subsequent argument formatters to be mismatched. Leaving the slot out
>    is only right for syscall tracepoints, where syscall__scnprintf_args()
>    indexes the array the same packed way and sc->nr_args is counted to
>    match. Every other tracepoint reaches the array through
>    trace__fprintf_tp_fields(), which advances the field list and the
>    array in lockstep, and for those a __data_loc char[] is an ordinary
>    dynamic string to be shown rather than something the kernel appended
> [ ... ]
> printed by walking the arguments and indexing an array that was never
> allocated.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790145937.gi=
t.irogers@google.com?part=3D7

