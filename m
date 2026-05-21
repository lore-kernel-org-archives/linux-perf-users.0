Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD741A5B9D;
	Thu, 21 May 2026 17:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779383560; cv=none; b=F+mJfQvypxhuf7Z3qZ9aaeRg+gV3NIUiFxD4py4S3yc3j/3glfDyblTcRUVZtbZeFTNckPdV8oL6N7WeuEWsEaRRSX3StAymuJt4SIuownNYDI9GUQJwY2j5BpujiazwOvCbXZKx08KvPx+oe8GXXitKuw5GVsU4gyOU+0Qshok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779383560; c=relaxed/simple;
	bh=qs7+Ssc1SOYSL+xNIzpQuobxlgrail8mI0NhebGi6Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPBp+BhfHVPzBPu8rp0s0XZpwKobdcTkc4oMPAFPLufAiiujOd7zx6I+YhWZCSR7O2EubPlSJ+7ErS14GTwKFOwqegHVImwGwSNzXgRFZ6OrmycCYuZy1J04GlMmIr+01cLKdYaNt7n2xmGwarevwzza4mCzDnqNAfVarKf1I1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=tTf5T57/; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="tTf5T57/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=8m+/Nu7P8LoZPsC1cIf6ObOiiGkzTS5zPt16g01JGf8=; b=tTf5T57/U6KAvypL3p+kOL/6co
	9MBwnM2q6iPGyZa+pdOjaWLbqLGxRh1HfykUaVXhwnWEqLpSY18ILJlHHo3xH3Xm73eJyqTMdrsOP
	iMCTh9Z7Gpuz+ZXNjVcAw1nmZNMfc7m/4FPKjt379xo+IArOcWPmIP8/cVbnDulGNXRO1GDASnjX6
	IlxENSq5ZUME9pC2wko4U1XKKSF40vizYwa+OCXzJMSGEhJH8wNB7Ad6jf2Bu8Od3DewP9n9UR6Ma
	x44FYMZ8uqROyKbcCJmDYK8NGfM8pEjLmqTSaRgqlTTjSu259fo3hKkwdjsPKKiRQW01vbGChmN69
	eETIyL3Q==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wQ6wm-0042JC-2E;
	Thu, 21 May 2026 17:12:36 +0000
Date: Thu, 21 May 2026 10:12:33 -0700
From: Breno Leitao <leitao@debian.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf bench: add --write-size option to sched pipe
Message-ID: <ag88W3-LcSt131jZ@gmail.com>
References: <20260521-perf_bench_pipe-v2-1-720b6ff7f0fa@debian.org>
 <20260521163951.2E2FB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521163951.2E2FB1F000E9@smtp.kernel.org>
X-Debian-User: leitao

On Thu, May 21, 2026 at 04:39:50PM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Medium]
> Are the file descriptors allocated for pipe_1 and pipe_2 leaked on this error
> path?
> 
> The pipe2() calls just above this block allocate four file descriptors. If the
> fcntl() operations fail and this path returns -1, those descriptors appear to
> be left open.

Technically true, but not a problem in practice: bench_sched_pipe()
returning -1 bubbles up to perf bench and the process exits, so the
kernel reclaims the fds, and there is no real leak. 

There's no actual leak in the running program; it's purely a static-analysis nit.

The rest of the function follows the same pattern — pipes are never explicitly
closed on the success path either, they're released at exit.

Not planning to fix in v3 unless a maintainer prefers otherwise.
