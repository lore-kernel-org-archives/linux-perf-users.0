Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795232218;
	b=LYVD5Wb4ZElksuL5V73PTeKgfQcMiyWTkZ8WLYg+4QtS7HxiWlCW3TjDBNLW01BtzrE6
	 0I6P126clV18TSnEOMh0+QZh3SbApd6tneGPsrCl5KCD/bYR25G9/JDcYPf/p2T/5OEnL
	 b63E+tBEQ/DPHZv6wiP0GO3/RuS9oxOXo9nk79TXQvJzseNBI7C0T+zv+yC8M0WX+gkI1
	 CEtIt6MYDfq2mOFDcEH2Xao7AQ6ywiZroUNZl7fUQYccQxHMllHUYf0H0McVqP6K9LPcw
	 QbvEFeC/wI5MOxG70bwfljs7vsnVAtgGX2M00+cBVUOul6JyenjQJnkI7JCWW7WXwoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795232218;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kUV8Vaf/STBuO5xGAsfl1A7iER1vaGDhZoJzdZWQCe4=;
	b=yR9O3ZXGrMYehgZL5RukkrNM/tfHogr2S0Rq8dj33wRa9jZbMy2H6IR5hQhC2kSo1nZI
	 GGF5SYiELGQ+zHo6rZrEh7qzOV1BUdPlEmkRcvlRi/jvjuuJ9A5JCZnBYWrn+tvpj8bba
	 tVmt6fmbAaJNbvlmgFoniYFfp2AqJS72i8s8hWJZ1v92D3cgLB7GaSFp357cc/33j5IVW
	 hGmcDKzDN5WoD9fMIER2niRPMArGXOSWsHc2Nt9jF3Vb23vqkzvaohnb6dfhenbOTLy0d
	 MtPo/nfzAon916DPNQk4Vxitk5HRa+MrL/7Lm8zj94ToYjy33K+ypqIb3hue1bW1mgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JmPFVGnd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA81D606A6BE
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 03:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JmPFVGnd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829421F000C4;
	Sat, 21 Nov 2026 03:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795232218;
	bh=kUV8Vaf/STBuO5xGAsfl1A7iER1vaGDhZoJzdZWQCe4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JmPFVGndGi6g37PqyWY2fPauwLbiMiXYXxc3GI998/2cLX9quIleS3MlBexPv0fa+
	 75LE5XyYfrXHUy8smS0S9bFOP3MxBrVYaa6vjcqAjSmiIHBhFoXtVzeL8scRPOFY8I
	 pERNyl08PhHRUYJi95SDvg1NHXuhZGAPZ8wchmGz1ZsibSgEswkw+77zj8A3mwqOxI
	 fj2zFf7+miOukSSJbT/Tei5Js3CanSL4ZYD5k5cDGTV9OCoPOh37Ai16X/CwUqV1Nt
	 eQXBnRrM54OELC2qQDfdMFCxHAEBWnpomlwxga5mJ1jtYC0Qr4O+7VDZlhnku1dUsi
	 d896bFV5yU3bw==
Message-ID: <sashiko-outbox-226593@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 00/16] perf coverage: A harness for perf, and the
 fixes it found
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261121032052.1392234-1-acme@kernel.org>
References: <20261121032052.1392234-1-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 03:36:58 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 16-patch series:

- Patches 1-6, 8-10, and 12-14: no issues found.
- Patch 7 ("perf tests: Exercise the x86 operand parser"): 1 potential
  issue (1 Medium)
- Patch 11 ("perf tests: Exercise the annotate stats output"): 1
  potential issue (1 Low)
- Patch 15 ("perf scripts: Add a coverage harness for perf"): 3
  potential issues (2 Medium, 1 Low)
- Patch 16 ("perf scripts: Add a coverage table"): 1 potential issue (1
  Medium)

Detailed reviews have been sent as separate replies to patches 7, 11,
15, and 16.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121032052.1392=
234-1-acme@kernel.org
