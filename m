Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECE83BADA9;
	Mon, 14 Sep 2026 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789393303; cv=none; b=fPYwmOlcCd7YJalELHvo8+H+KE1WSUw+DgBY66l0PtyNKsSJUv6NZwo8A61lGoizWWA4Wfgo5pO899VB8ls1ZHfn6otuFulUCKXnFfVC9/2JqvktGA1ti2KYSg4+MV4hI/dEsHWI+qZAtNn8aZ5I9qOBVZ9zBIg01ugVqyBDhY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789393303; c=relaxed/simple;
	bh=0GOrp49Egkj0ZMN22eZ5FmAEkpqNT0YAsdxhZ1/nEi4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iVskhD7xLi9+5qx6JYhEyG9lap/cRUP9g7VSSoz5npaS3CT2Tk4sv9336nzzUWffCvzl/pOHURPxWQ7rGu4C8JN1sTJ0rwkj/9eRXjw1AgZqwdewUjUcRkMeW5rJqeVVvG9OB058RXIDIKN538BsgCb0qn5bE6gCIfd6g8Y9NV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cx7v1ETy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cx7v1ETy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE271F00893;
	Mon, 14 Sep 2026 13:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789393301;
	bh=0GOrp49Egkj0ZMN22eZ5FmAEkpqNT0YAsdxhZ1/nEi4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cx7v1ETyHixQOMwxuAxsPjc/bzNd0ZZQufw3Jjb988tK8zSaNY56sd+JJ1Y3/frmK
	 oKiC48LGPdLmxXluc+UTLKPixJjOLnYJvdTMh6hpiR6AVdKM/ohKPTMBin7zWOOUf/
	 rw7fGHw7sxFNj3Yo3fiQ8Lfi2pJd7CQO7+PqcisFKcdjZX9ZS28g8oSCJA9tT5/ZGC
	 4+KUtImIgClplC7sQ7d3yc/WmdVejHXin4LiV29scH9I8GlglS56BLplhQnnWdm6De
	 dgI6jWw45WWqUBWd0B0hLMDdqHlMbPGz/l2UpE3PqpPgcRyL9qhJ57+B6jFf4pCZQ9
	 SrnpggoXC9m5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 04/13] x86/hw_breakpoints: Add
 arch_modify_local_hw_breakpoint_addr() API
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <178939022358.94750.10843461787759740658.stgit@devnote2>
References: <178939017565.94750.9431053336761330458.stgit@devnote2>
 <178939022358.94750.10843461787759740658.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 13:41:41 +0000
Message-Id: <20260914134141.ABE271F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Jinchao Wang <wangjinchao600@gmail.com>
>=20
> Wprobe needs to move an active per-CPU watchpoint without releasing and
> reserving its hardware slot.
>=20
> Add arch_modify_local_hw_breakpoint_addr() as the architecture backend for
> modify_local_hw_breakpoint_addr(). It validates the new address, finds the
> installed local slot, and updates the hardware debug register and per-CPU
> shadow register. The core layer (modify_local_hw_breakpoint_addr()) handl=
es
> updating bp->attr.bp_addr and counter_arch_bp(bp)->address.
>=20
> The caller must provide an installed local event and a valid address.
> Slot ownership, breakpoint type, length, mask and DR7 remain unchanged.
>=20
> Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c=
2.1785067572.git.wangjinchao600@gmail.com/
>=20
> Assisted-by: Antigravity:gemini-3.8-flash
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178939017565.94750.=
9431053336761330458.stgit@devnote2?part=3D4

