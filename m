Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A254B2D8796
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 08:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994648; cv=none; b=mDShycjLIGDJ2AqnpbQTpZ6DMgjC8mcVMz2lZSEfh7jA7m383da2c73VlYZmYlHDk4rPsJ7ocWILoXHIh08pOLnKBBlJddekcGICh5JLmPRX2pIHn6hQaArEC4nEsVNi2Qbm3Lw8/qXG6oMgqLJk8Mmcx+FrcAn1hMnET4kD5WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994648; c=relaxed/simple;
	bh=u0IDK3TyFMm4oeFKwxrkE6ieRW9bQkY4NtsRANzfnBw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oCs7tq4meTHvtaCc+N80ROZmE8JZ2Dx57LwA96qbsI+LAdRu0jhxeWdn+UEeriO+IeQXxEUKa9PgQRMf5aL7+fuu/7oa593Kd2WDKgKRx8TkNQMymIOnZPsnoHzIq3rqKrqWOThoCxJSyYNH8p0xLYnsYaL0HyCrGS/K2/SEd9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n62cqRF0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n62cqRF0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185991F00898;
	Tue,  9 Jun 2026 08:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780994647;
	bh=UMdLExpqgam8Si8Ousi+m9LF7TOFVcHiD1cps7TscoA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n62cqRF0u2kO+SxMHxJNVogCC/kKAzEcFnP8NteBRy/LfnfCuHpkjjYtO9hTlgs5R
	 n8sCXZzh0nCEOmmDKb9sUy6FjK2lhWE6mYQ1gtkMcMyEOFhtKt7K9MrmjdEO9M5/n1
	 9c+fSmfL4VDyMjxKNowaBwhnoRrDQgHbrCGyWO322P0JS79dlAW83uOUWw7hazD4dX
	 NINIda4+9WOWf/39vHZlpDNsjTB3I7TKvcSl+DxcbuFgjjoZW8Ouxx4rl8xBAZphev
	 BflbBetyaYURI3ond2mhyxTABJDBAsd8lMyxe2Xo8INjN51lYutyTRRaaX4MqkXusV
	 NduX7LO+QmXKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/8] riscv: stacktrace: switch to frame-pointer based
 unwinder
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wang Han" <wanghan@linux.alibaba.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609063002.3943001-6-wanghan@linux.alibaba.com>
References: <20260609063002.3943001-6-wanghan@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 08:44:06 +0000
Message-Id: <20260609084407.185991F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Comment inaccurately describes the memory location of the metadata =
type field.
--

commit 0eadbda136e709b7b12de76094d4f29e825575fb
Author: Wang Han <wanghan@linux.alibaba.com>

riscv: stacktrace: switch to frame-pointer based unwinder

Replace the open-coded frame-pointer walker in arch_stack_walk() with a
robust kunwind state machine. The new walker tracks stack bounds, consumes
frame records monotonically, and integrates with function graph tracing and
perf callchains.

> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrac=
e.c
> index 2692d3a06afa2..8fcf23b046d59 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
[ ... ]
> +/*
> + * Unwind from one frame record to the next.
> + *
> + * On RISC-V, the frame record sits at fp - sizeof(struct frame_record),
> + * immediately below the address pointed to by fp/s0. This applies to bo=
th
> + * normal frame records and metadata frame records (embedded in pt_regs).
> + *
> + * A metadata record is identified by both fp and ra being zero in the
> + * frame_record portion, with a type value following at fp + 16.
> + */

[Severity: Low]
Is the comment describing the metadata type location accurate?

It states "with a type value following at fp + 16". However, since fp points
directly above the 16-byte frame_record, and the type field immediately
follows the record in struct frame_record_meta, wouldn't the type field be
located exactly at fp rather than fp + 16?

> +static __always_inline int
> +kunwind_next_frame_record(struct kunwind_state *state)
> +{
> +	unsigned long fp =3D state->common.fp;
> +	struct frame_record *record;
> +	struct stack_info *info;
> +	unsigned long new_fp, new_pc;
> +	unsigned long record_base;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.194d76e3a15b.=
v3.riscv-livepatch.wanghan@linux.alibaba.com?part=3D6
