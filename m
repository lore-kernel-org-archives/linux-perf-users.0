Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B876C38910F;
	Tue, 22 Sep 2026 04:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790052108; cv=none; b=U9OiIh7xCFr+A6WvxBoLnJVV2fK/ywbMgipYG4eTNYZJm04iIjukGOeJyfXTO7XKCp2ZSXS+R/YMTh9O37aaQYef6VgKRedMZ8MF4ZvlsUvjAvFx6TPqpHm+UGatlIFNuoYkWeS5t5xycxcfq7SemXKLc869mfphBVVdaquPz4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790052108; c=relaxed/simple;
	bh=KLGhBNPyk99wX00lfPHYXCVIGPCvDsARhTsIvko5KnY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p/gP3EPDm+Iu9on3i80Gza7LrY1BJzbBUl1xtQ215NWCoOC4XQqP/gzgf77bgx3O/ldRQ6m0l9GZXjuMVJ8mIbCZejLNudkl+jUcD6uWzSxXbgJG0V21i71LqZyHg1I9HZt5g8gomAhw6pN59PFT5zx0wXRTkAsOmXbuPCfbP4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaLDD+9u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaLDD+9u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6CA1F00893;
	Tue, 22 Sep 2026 04:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790052107;
	bh=KLGhBNPyk99wX00lfPHYXCVIGPCvDsARhTsIvko5KnY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WaLDD+9uq+TpErWQ06h2Rl42bnoWTTvlbzccpGnWasjxS5+jCrBsOx2ROw1hqcs7e
	 tyP5yN5OrCecZaNCI9yx8km+R8Onzp+SeAk5n9cwitoJ5OiQlehzmSorKq8JMGyBxZ
	 QN85mQqQfqe736NAv0KFuo1QjV7pvGTec/7TvLsb4kGgP/eeW+9KeK+7021Omc89ZT
	 JHjGSGvosMfmIljpyXylkO/tncPghT9tmzazzek5bh1GjDUQiT7oQoG6eiP8Fb+NDR
	 LWNPkMBk/kY2e8X2s1y5JwJhBsAT3qzhvbZduwVGdTXXgthGdJaHEYDDtPe2OBEb7J
	 K3LEMuCa73ldA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 06/13] tracing/wprobe: Add wprobe (watchpoint probe)
 trace event support
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <179005115525.388919.3173173873626389076.stgit@devnote2>
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
 <179005115525.388919.3173173873626389076.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 04:41:46 +0000
Message-Id: <20260922044147.1A6CA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add hardware-breakpoint-based dynamic trace event support (wprobe).
> Wprobe creates a dynamic event on data read/write accesses using
> hardware breakpoints and logs the access context and fetchargs.
>=20
> Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c=
2.1785067572.git.wangjinchao600@gmail.com/
>=20
> Assisted-by: Antigravity:gemini-3.8-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179005108298.388919=
.4535333252892590932.stgit@devnote2?part=3D6

