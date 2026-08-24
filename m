Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0499D3EC6B9
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 08:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561989; cv=none; b=O+RTBDheLYx19oUM3VqzuHOdgagc0mmuHbQHXpw1Dbf3qs7GLFGqfaa7INKNq9GrkmmRBCeomyqsKAuAQI8P7Cv4Xl6fiFSZYeQkJB1eBWdmgrj/kKx6GY3q6JAKBK+ui2Tc6f9RdEbYK9qX9681/SwXD3ZQ6oke9CsBR21dQ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561989; c=relaxed/simple;
	bh=tktUyrneczfI384F5owD1Vg0PwW1kPNu1Gr4KoG1JQw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ed9DpOcOgffVx2WkyJY+M8J5temsqkaommrLQjE2B95bBdjk8xevEkaQLbv5i7YfnVwMjjVyoirP7Y1o34lSBpH78OORryG2Ua8vaoWl7Qie8UDRUhFsX4vI91HXTYX6qZ6qhq5GjUd6Rrz3IiJM+snsntzzOg7B5TMJEgXpxto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LON7jMP3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LON7jMP3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799741F00A3E;
	Mon, 24 Aug 2026 08:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787561987;
	bh=tktUyrneczfI384F5owD1Vg0PwW1kPNu1Gr4KoG1JQw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LON7jMP3ae7DsmQ8NnEIEVML3fSXvfcMSJjX9lZdVJrLgIDBfRHQbgcGLuuGVC8Nz
	 LwuJEGtuhE/FVewY0rUWvk2JPwZJLP6pmLV+3wrlEIHZaL9QiWuJ7ojGAokf3H0kTz
	 UaRy1U+TkToA/YcJIKnC4DRKWbiaKbcoh5huczHseIvTWVZgw93QWFECvVcRbsr4gb
	 kVx+h+EuwNhkICbfR7n718Iu3P+Jy7BFr9rXKyybkIgA5fKXksFfCXffjFy0mskse+
	 uXzSrep+2rOUPY4MwZUXUWpFzcCeuFcsDIMabY4TyZczXQg9/hq9b1XJtSFRt+Dmpq
	 zV7MG+akRGSzQ==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND Patch v10 18/23] perf/x86: Support eGPRs sampling using
 sample_regs_* fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824082731.1013973-19-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
 <20260824082731.1013973-19-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 08:59:46 +0000
Message-Id: <20260824085947.799741F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Support sampling of APX eGPRs (R16 ~ R31) via the sample_regs_* fields.
>=20
> To sample eGPRs, the sample_simd_regs_enabled field must be set. This
> allows the spare space (reclaimed from the original XMM space) in the
> sample_regs_* fields to be used for representing eGPRs.
>=20
> The perf_reg_value() function needs to check if the
> PERF_SAMPLE_REGS_ABI_SIMD flag is set first, and then determine whether
> to output eGPRs or legacy XMM registers to userspace.
>=20
> The perf_reg_validate() function first checks the simd_enabled argument
> to determine if the eGPRs bitmap is represented in sample_regs_* fields.
> It then validates the eGPRs bitmap accordingly.
>=20
> Currently, eGPRs sampling is only supported on the x86_64 architecture, as
> APX is only available on x86_64 platforms.
>=20
> APX eGPRs sampling will be enabled in a subsequent patch that sets
> PERF_PMU_CAP_SIMD_REGS.
>=20
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824082731.1013=
973-1-dapeng1.mi@linux.intel.com?part=3D18

