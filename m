Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C1D476041;
	Fri,  2 Oct 2026 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932465; cv=none; b=tVE60/EQ7YQjGlUwX8RcjNKl+PxycMOpySQPBurj/bS8LxMczyMBXirfpmDvilQo5l6z9BggY/AulGdGZTBcFa4EFYe9cxjgPTXnafB4H4xOAYSIW4dKcDEOijr+P2QuBgke86tx23ge7M6dG4wqhbTYwsQ+MT7dXajOriNtxzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932465; c=relaxed/simple;
	bh=XeGcLB34hp85mI17SJo/Pa3UOLwn/yh8uzxRgWIwV2k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fJHCm9sEVNih6vu+cugTf9n665i6RFhWj+wTARKspvGBxHHwpjhefYAi9ac4V7YJH4dq/bA2s5KO4ynuGD+EXpst/KDbv8fuzHibzzAJZR+7pL8J+6OK8IEEcO+mzZkuUi0JfGEsfEs+p1NVaZJZQRuioOdcAdVrOpmJJr9/CZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlnOomnI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlnOomnI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743201F00899;
	Fri,  2 Oct 2026 09:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932463;
	bh=XeGcLB34hp85mI17SJo/Pa3UOLwn/yh8uzxRgWIwV2k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MlnOomnIL5fba2Fhs+buC5pVS8R+fxVt8Byek59HhYGeZ7nt70QuPEDUaZ87XkN9I
	 G9KJUdv0jzZXjxLDqCBqaP5EvW7HzAnilJ4ZFZ0THtV2RhBPGdbOxYIpsVWf5oyrNs
	 skuOTyhCgRsF6Ft8U/txKSqpp1H2NooaATkeibiJbSg2ssGMxj1wxUzTPrJbl/0XaH
	 8GasKbnG87zXziYL3m4pMwbctJXga07WWttDTS/RLqzrUQ4QVZpYZb4sw3kwUsO1Qb
	 6/t3jYwbHZGKH2ViwfNBaqA2PKi0GlJIWOEwpXzxx1tJ7RLpgEd9qlpFo+1BfZ0vqt
	 5iGeUuChCJI4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/1] perf/core: Restrict function predicates in trace
 event filters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhengchuan Liang" <zcliangcn@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <e66d86bf790ce51ca865c354a9b7a716c08b552f.1790891867.git.zcliangcn@gmail.com>
References: <cover.1790891867.git.zcliangcn@gmail.com>
 <e66d86bf790ce51ca865c354a9b7a716c08b552f.1790891867.git.zcliangcn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:23 +0000
Message-Id: <20261002091423.743201F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Count-only perf tracepoint events can be opened without tracepoint
> permission because they do not expose raw sample data. Their
> PERF_EVENT_IOC_SET_FILTER ioctl can still pass filter expressions to the
> tracing parser.
>=20
> A .function operand makes the parser resolve either a numeric kernel
> address or a kernel symbol. The ioctl return value can therefore be used
> as an oracle to recover the randomized kernel text base.
>=20
> Trace events marked TRACE_EVENT_FL_CAP_ANY are different: task-local
> events may expose their raw fields to unprivileged users. Syscall
> tracepoints and uprobes deliberately use this exception, so denying every
> filter without tracepoint permission would break their ordinary filters.
>=20
> Check perf_allow_tracepoint() in perf. If permission is denied, continue
> only for a task-attached TRACE_EVENT_FL_CAP_ANY event whose filter does
> not contain an unquoted .function postfix. This rejects the predicate
> before the tracing parser can resolve either form of operand. The scan
> uses the parser's quote rules, so .function inside a string operand
> remains an ordinary filter value.
>=20
> This preserves ordinary filters on task-local events whose fields are
> already available to the caller, while non-CAP_ANY filters and kernel
> address resolution remain unavailable without tracepoint permission.
>=20
> Fixes: e6745a4da964 ("tracing: Add a way to filter function addresses to =
function names")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790891867.gi=
t.zcliangcn@gmail.com?part=3D1

