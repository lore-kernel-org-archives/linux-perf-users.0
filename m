Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C6F231A3B
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 02:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776307764; cv=none; b=FoZGsguS50SH7hQeVqIkxcPszdSg9X6vBi4UFrXOw4uKYT8azPTYfGQIl+aE1MoH52Q41695Au8zcNYMmiC3BbQlG7heK5hcv0EVNLmk2ZCrU/OcSZ2qHWjbveVfiTBEF1w2pXujP5MJsxRtzwK9dFFY/befLbxBr2Bg1fhGnLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776307764; c=relaxed/simple;
	bh=j7e17LDifneIOjOnZrc8mnGt63vusi8zEfl/w8qeblk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LS9Cwde55daGLI3hBElhfym0HBqZGRUWb41TR0ULuYd2x4pTtpFGr/tTuEElklx9p0XMcp2N9yLnRviI6WCATYVfAKoplvxcfBrB3009wiVKrS4jLiomg5jHmDBXqQ+/sTrUz/3lg3kD6K1jMke56CMOCGPQPte9WKvrMYNE6X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WWtOdCM2; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WWtOdCM2"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776307755; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=5ekEIn/dZVWD2qMUuw46y5eHBbDEAF08FRZBv3kB4Ro=;
	b=WWtOdCM23scA0zNrC06ImOnIJ5nwQuieziqVaxQmoWEsGi2iDWNMWNMRvKJ7E10ufNOjWjb4nNetvYs7F89QrgSx7cuA80tDnGhJe4UYYWk2QLTtcqCIwfwg0yQoCZCA3iIZGpuLZ34ipM7ifaVWhnsydZynZ5JPDdi+hQ5lpqI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X16f.G6_1776307750;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X16f.G6_1776307750 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Apr 2026 10:49:15 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: sashiko-bot@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	sashiko@lists.linux.dev
Subject: Re: [PATCH] perf riscv: Add SDT argument parsing for RISC-V
Date: Thu, 16 Apr 2026 10:49:03 +0800
Message-ID: <20260416024910.20041-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414131753.7E1E2C19425@smtp.kernel.org>
References: <20260414131753.7E1E2C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

On Tue, 14 Apr 2026 13:17:52 +0000, sashiko-bot@kernel.org wrote:

> > diff --git a/tools/perf/util/perf-regs-arch/perf_regs_riscv.c b/tools/perf/util/perf-regs-arch/perf_regs_riscv.c
> > index 5b5f21fcba8c6..51b43e68e0e3d 100644
> > --- a/tools/perf/util/perf-regs-arch/perf_regs_riscv.c
> > +++ b/tools/perf/util/perf-regs-arch/perf_regs_riscv.c
> 
> [ ... ]
> 
> > +/* RISC-V register ABI names: zero, ra, sp, gp, tp, t0-t6, s0-s11, a0-a7 */
> > +#define SDT_OP_REGEX1  "^(zero|ra|sp|gp|tp|t[0-6]|s[0-9]|s1[01]|a[0-7])$"
> > +
> > +/* RISC-V memory operand: [-]NUM(REG) */
> > +#define SDT_OP_REGEX2  "^(\\-)?([0-9]+)\\((zero|ra|sp|gp|tp|t[0-6]|s[0-9]|s1[01]|a[0-7])\\)$"
> 
> Since the 'zero' register is hardwired and not saved in pt_regs, will the
> kernel reject probes with a BAD_REG_NAME error when perf translates it
> to '%zero' for tracefs?
> 
> Should 'zero' be excluded from these regexes and instead treated as an
> unsupported constant-like argument to be skipped with SDT_ARG_SKIP?

Good point. The 'zero' register (x0) is not saved in pt_regs and is absent
from regoffset_table in arch/riscv/kernel/ptrace.c, so passing '%zero' to
tracefs would trigger BAD_REG_NAME. Fixed by removing 'zero' from both regexes
and letting it fall through to SDT_ARG_SKIP.

> [ ... ]
> 
> > +static int sdt_init_op_regex(void)
> > +{
> > + static int initialized;
> > + int ret = 0;
> > +
> > + if (initialized)
> > +  return 0;
> > +
> > + ret = regcomp(&sdt_op_regex1, SDT_OP_REGEX1, REG_EXTENDED);
> > + if (ret)
> > +  goto error;
> > +
> > + ret = regcomp(&sdt_op_regex2, SDT_OP_REGEX2, REG_EXTENDED);
> > + if (ret)
> > +  goto free_regex1;
> > +
> > + initialized = 1;
> > + return 0;
> > +
> > +free_regex1:
> > + regfree(&sdt_op_regex1);
> > +error:
> > + pr_debug4("Regex compilation error.\n");
> > + return ret;
> > +}
> 
> [ ... ]
> 
> > +int __perf_sdt_arg_parse_op_riscv(char *old_op, char **new_op)
> > +{
> > + int ret, new_len;
> > + regmatch_t rm[4];
> > + char prefix;
> 
> [ ... ]
> 
> > + ret = sdt_init_op_regex();
> > + if (ret < 0)
> > +  return ret;
> 
> Does this properly catch regex compilation failures? 
> 
> POSIX regcomp() returns a strictly positive integer (like REG_ESPACE)
> on error, so this condition will evaluate to false if regcomp() fails.
> 
> If the first regcomp() in sdt_init_op_regex() fails, could this lead to a
> crash when calling regexec() on the zero-initialized sdt_op_regex1 below?
> 
> Alternatively, if the second regcomp() fails, sdt_init_op_regex()
> calls regfree(&sdt_op_regex1) before returning the positive error code.
> 
> Could this cause a use-after-free when regexec() operates on the freed
> regex object?

Good catch. regcomp() returns a strictly positive integer on error, so
ret < 0 was indeed always false, causing regexec() to be called on an
uninitialized or freed regex object.

Fixed by returning -ret at the error path, so the caller's if (ret < 0)
check properly catches the failure and bails out before reaching regexec().

> > +
> > + if (!regexec(&sdt_op_regex1, old_op, 2, rm, 0)) {
> > +  /* REG --> %REG */
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260414124655.129463-1-cp0613@linux.alibaba.com?part=1

Thanks,
Pei
