Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1D3446821
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 11:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789989963; cv=none; b=i7cKzg11fCUIzITE1uuCjCBx1HgcaZvs6ZmiQEBbORLQC8n/kU9vktAQIqOFVNuSw8LMVm9mR9CEYWuOViSxl3V3bwuFi37tBA0bkUiDWeMJfzz9gIrTU5oLHw852Cxaab+WTlF2aiaLowod8f62uBeLiJUh3rSJJCjf+n13014=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789989963; c=relaxed/simple;
	bh=fgPaQdI9lAnr5OI7GZCXrXGioPwTFAE9WOH+l/CVMc4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dK46342gj6JIQGe1bVXJ9CsIb5t3V29Fqe2fX2caM/XuTxG33N0brLwiYg8rFl7fKo0F6wpEYpn2AUJhQD7fiGviT7E4SNqvrEqG9ALaLyPs9TxJrXUTB7/D6F7FUtU8WjFONZfWpLEi2O5Bm9I+sA/lHVJbnd1yVfu9Gy44KPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgfEAzaf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgfEAzaf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E3F1F00893;
	Mon, 21 Sep 2026 11:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789989959;
	bh=eZQKU2xBn/lZiUlnsKUmEyCrhW8TBMy0M1qHCqoNn3I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cgfEAzafqN0fnxnyLJ2FmPWpynfnMvveZQcQO2i4kvgjGqJ+2TRW9yC2kfSaoWcyI
	 F5Jc8xsD9NE9ktAgTePxZC/JhM3l/F2u7fP7zrUHx6v+gEY/G3tihsJnRePhEKmU3f
	 j6ZgXwzHB+yeucKnj7icFf+DrA4P9yzTekDglWdBJS7sg8DmxVJBARX57hUtdzk9er
	 ENw2zLtFvs9pYrjCYtQ4FRZsIhG2A0ovcp+/kqRwu1weDte6s+CwQXpjmH0acSVhxH
	 AlD3x6CWdLUPxm05/2HfAGG9wHGhBDgsJZUkqzsH/SwrlTGkgB3llMJmKjptXkAhdF
	 AlEHrX4m9/ZSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 RESEND 9/9] selftests/riscv: add perf user-stack SSE
 copy regression test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <1aea2955f0769b00e99c530565d7acc67e47360e.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
References: <cover.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
 <1aea2955f0769b00e99c530565d7acc67e47360e.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 11:25:59 +0000
Message-Id: <20260921112559.A5E3F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> On RISC-V, PMU overflow interrupts can be delivered through the SBI
> Supervisor Software Events (SSE) mechanism. A perf event that samples
> the raw user stack (PERF_SAMPLE_STACK_USER, as perf record
> --call-graph dwarf does) then copies a chunk of the interrupted task's
> user stack from an NMI-like context. If that copy is allowed to take a
> nested page fault it can corrupt the interrupted task's kernel state and
> hang or crash the machine under load; this is what
> riscv_perf_out_copy_user() and the nofault page-fault change fix.
>=20
> The existing SSE selftest module exercises the framework (register,
> enable, inject, complete, priorities, stress) but never drives the perf
> user-stack copy that motivated the no-fault path. Add a userspace test
> that closes that gap:
>=20
>   - Open a sampling hardware PMU event with PERF_SAMPLE_STACK_USER over a
>     deep, partially non-resident user stack, drain the ring buffer, and
>     verify every SAMPLE record is well formed and never reports more
>     dumped bytes than were requested. This checks that a non-resident
>     page truncates the dump cleanly instead of faulting or overrunning.
>   - Drive a multi-CPU unix-socket + deep-recursion workload under
>     high-frequency DWARF sampling; the pass criterion is simply that the
>     machine survives, since the original bug took it down.
>=20
> The test reports SKIP when hardware PMU sampling is unavailable or
> perf_event_paranoid forbids it, so it is safe to run unprivileged or in
> constrained environments. It is placed under the RISC-V SSE selftests
> because SSE delivery is the RISC-V-specific condition it protects, and
> is wired into the sse subtarget Makefile alongside the module runner.
>=20
> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789974241.gi=
t.zhangzhanpeng.jasper@bytedance.com?part=3D9

