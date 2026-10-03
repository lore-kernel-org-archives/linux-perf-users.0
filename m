Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024E8157A5A;
	Sat,  3 Oct 2026 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791014550; cv=none; b=gvZBYEq4T7btESeVv5Y6/TWUHEvG4XmluhjkHb+AkWevfUwfMHtNRcsPevVfHaA85AZ8i4icOfbhGUqsslcGPKZZY99UaL9hj2A209Z4poXV0oK9taDVCraf3YcqGeKub7gtMvEel1NcNkvRhqpZdRA1dMlzuRvs9+5FNWRGdyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791014550; c=relaxed/simple;
	bh=5hEMIMshsN1Ad+XY6L6iGyLClSKt63vMr7FcQGHyDUE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BCGJeflmekFOzB/awDJ9IWmSiC6u4l3HtJyojf6TTCTLjiF28mNJKChhupXO+EBuCQdOL43f0opOu5c3B+FQ2BJaS39vxYamH1o5u6zorToxT2xvWFh40Vg8ycMoeLvdo1XNRsjDuxpqE43zeJ7K6gjL7ARSI7mGAUz+ZgoW0A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZjG7ifS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZjG7ifS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B172A1F0089B;
	Sat,  3 Oct 2026 08:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791014548;
	bh=5hEMIMshsN1Ad+XY6L6iGyLClSKt63vMr7FcQGHyDUE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NZjG7ifSF8zLhNJHpbxZ3fiIc4+GQwZslP5fdSYfInkV4zrDOFqSafmesS4YMJ45L
	 zvW40wo4Cm+73s27el3se1gQF6zRB2oEbu6QZ0m/r+Pnlr/rsVxSqBo04AGwqdN7dZ
	 rU4GLR6oG2kDABGrJHjAO6zBVk+wSsVt0ZUOUxUQc5iTRdT1BzWYag8jEeIRcZxwPF
	 ybSk1S28ivhNoYyJgkCrTACHdaHoY4b4hh66TDFrbqKrtvulk+cg9h51QE9Zxn45YP
	 dR0taVAVLt/ffjyH7l/rqmNgjKd86vRumtRFswIFwf3KL1rKDBWfs4aNWLJrT83GZt
	 P8kGNWae+174Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 09/11] selftests: tracing: Add wprobe trigger
 testcases
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <179101403685.22872.560911747833442855.stgit@devnote2>
References: <179101393469.22872.5895666191299551553.stgit@devnote2>
 <179101403685.22872.560911747833442855.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 08:02:28 +0000
Message-Id: <20261003080228.B172A1F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add testcases for checking wprobe triggers. This sets set_wprobe and
> clear_wprobe triggers on fprobe event and static trace event to
> monitor memory accesses within the trace-events-sample kernel module.
> Also add a testcase for verifying wprobe triggers across CPU hotplug,
> and a testcase for verifying wprobe trigger syntax error logging.
>=20
> Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c=
2.1785067572.git.wangjinchao600@gmail.com/
>=20
> Assisted-by: LLM
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179101393469.22872.=
5895666191299551553.stgit@devnote2?part=3D9

