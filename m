Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ED652CCF2
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 21:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766937; cv=none; b=RwifRosW4pBFKzu0lr88zYIIWMidaR47GX6pIINWHt8bF/rjp5DXc2ho0BuXvcv3zorDwGOqirVjKK9AwYtZgn/1Fb4dHOAFFJ851CDyuFMXGiRSzI709+rNuySQh4pNjdlbFiCWGjKy7iRBkBPlLlOt/xzvwvZDYShPQXPL2uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766937; c=relaxed/simple;
	bh=1cZoOCXErdETK817OW7jVctsS73AD/t2VZxAeqJWMck=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IV/AxsqDZuwOgk97Hy9WbKzJrB0pcOi/RmXWSGFFcNzuynNLALtIVJ7MqiBQNWn+Bt6IFfzoDXvHqhCp9DXy0SnktGVbrt+R9BwnO6/j7WO3I6tE5FR0RamxhD5X5x6cXNOZFA30xulHKhlv4NwRemJfF/63uAZnDvsyfqLSKV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMQeHQQ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMQeHQQ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B661B1F000FF;
	Fri, 18 Sep 2026 21:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789766935;
	bh=LMRqhYh+tuFySXiytJcHGkKghz1+hTKhBHttzlAFmXM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hMQeHQQ5iw4uOao2InXZs5QWwC6PTuM60xNdDsPW1f1HLao4W7YsLe43pT71IOOX2
	 f7pnCYorEamowPJqb5I7lmBuY5eUC6knO3rHICcErSqN3VhZDWFvUpSPzLLquvsNTN
	 UdANpu46mhxqooLFScn5mISHb+KC1Tz95gAUbDbaa4I51CpkEFcfX/LI+frlTUsSSv
	 9ts+AWLmrCaGiel8N0XSY80vHy0sJCnA4ErBdkLbJvj53V0vIpVQSimtpucv20ckDG
	 pE087uFrwXezpueRP5zK3Locbt+DcYr+oyo4uv6aaH6FPuVUNJEF5/vkLDcYr69xtz
	 RZ1d1uK9VxvuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/18] perf trace: Skip internal tracepoint fields in
 formatting and beauty map
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918211932.2966061-6-irogers@google.com>
References: <20260918140659.2501976-1-irogers@google.com>
 <20260918211932.2966061-1-irogers@google.com>
 <20260918211932.2966061-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 21:28:55 +0000
Message-Id: <20260918212855.B661B1F000FF@smtp.kernel.org>
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
>    subsequent argument formatters to be mismatched.
> 2. In syscall__scnprintf_args(), internal fields were not skipped,
>    causing spurious trailing arguments like ", 0, 16" to be formatted
>    and printed.
> 3. In trace__bpf_sys_enter_beauty_map(), internal fields were not
>    skipped, offsetting beauty array argument indices and breaking string
>    and buffer augmentation.
> [ ... ]
> printed by walking the arguments and indexing an array that was never
> allocated.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918211932.2966=
061-1-irogers@google.com?part=3D5

