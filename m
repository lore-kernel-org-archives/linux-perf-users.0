Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3183BFAD0
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 06:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158855; cv=none; b=jKlOIxFHyrqF+m/pHGJ0Ep8q8fWBEoa/ejzzrqqyazi7vq8KOHz+1IkxEhE50niRzZ+2vUII02ephD273kQHWGjqmE4Oow1wzjOD1Il/i9F7wPXKb3ZA6HiiEsGf9WRmVHzwZSCnSWvJM4csb3M8Y9kNt6gOazMbRIPmENvf+xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158855; c=relaxed/simple;
	bh=pw630f57ffdqko2V4RPHwFzSpY3WTWug1qHcwBIn6yI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mGvDvjBw4sTH0JqF3X8wICUvr2CRtHWTlQso583rco8vrpXmkknOHYyuT/OU+jeZ6kwgftXU2kp3ftbEGH11SvCNxk3LAB22uWQH3O1GnJGaSdxMT9m8T6YgrI9bPGTy6aj8blBWmJDAnJ8Va+p4bW8ZSscHVrbiU//32zCxhTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeHE2zQV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeHE2zQV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14AE71F000E9;
	Mon, 31 Aug 2026 06:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788158854;
	bh=l1Q+m0kd8i+4KYU5luiwWJRanhSCclvzSA7CW3blsBQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VeHE2zQVkuRiwd2RnRM1W0ynrDGM5OjeY47uoKNUJsuIOq2zZbLLitwKI+6wr32FI
	 GoBrdqUNLAqEkL/sW3BC9LChJJkYrS0cX+YRO1frI9AsmMacKdReBygawNfd0bbY/r
	 DGKvDwfzK6RIyPDFs9Au5u/GDzMdPwnQjIjoj738nZxMs6/kU7i6I5taK/F2vhn1eq
	 IiV2YQDOV/dZ8GL3NsskJViPeUw+Df/vbiGFovHk51SvBijiffZ2yN0jEkWfWrk0Wc
	 ee0l1tSPbXVurxiSGtDFfzKFG61d3lyBO9rEX97wTOdihRWMyzYrtI6UWag7+Iekx7
	 Uspt90hi9S/fg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf ftrace latency: Do not read trace files when
 BPF is used
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831063938.756610-1-namhyung@kernel.org>
References: <20260831063938.756610-1-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 06:47:33 +0000
Message-Id: <20260831064734.14AE71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> I've realized that it didn't set up the tracing files when BPF is used
> so poll() just returns immediately.  It ends up with calling poll()
> unnecessarily in a loop.
>=20
> BPF still needs the loop to wait for the target process exiting or a
> signal from users.  Let's use a semaphore instead.
>=20
> Suggested-by: Ian Rogers <irogers@google.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831063938.7566=
10-1-namhyung@kernel.org?part=3D1

