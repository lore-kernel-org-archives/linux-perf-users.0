Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1B532B9A6;
	Wed, 21 Jan 2026 06:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768978715; cv=none; b=Yd7ZcjDwDJJt365ROj/+DgcT5eom5YcUZ9ZYw8F5XISZcygdAIb29A9D5maaE6PCHPCgLk1ezAd/En+6I5o6kTtQdFaigspzKNmiZ4r3o7icEaAG6zXNUKT4J7/Y8Y329Ts37OS//qwuSVFUhFfGVEfpeXYMsh8QsYihJhhTD1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768978715; c=relaxed/simple;
	bh=gQ2iJQpnPdN/VjaVdp15xX/jvrsDqvjipQxnEurzx0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DpPeEF1XskF8RfzPwW9MEbgEcpdyM+rb+LvhZF5HJBdwSKs44u6B9FXt4o8dd8IvnY+IeZE4zDhs6KVmqN0DSyVoulpbct4Hyfg4r0F36MOU78CTeqCATfxOuzQS6OmdGysx4ju292VAtilIC+2OGt7dWNlny1GVM4bnEpj3/2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=keTalmMk; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="keTalmMk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768978714; x=1800514714;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gQ2iJQpnPdN/VjaVdp15xX/jvrsDqvjipQxnEurzx0o=;
  b=keTalmMkRLRdF4G6aEANlcgH2YcAAGb4SVDcRaRS+h5vzxCMVjNkPPqy
   MCkloiY8SDu+LXLY0Ui5TnPgEiqrFRAhZ2B7LbOLe1Wy192Qw7+vKha+R
   zm8uODdm1H4yCmVnt9PQUPJISHRAwcROCP8kBCprdkJQQl9r8UhlAmMnD
   ca9h7nT745A9WlcfR0DIeDe+T6KJnTFKVYYVdBjGNBGdvxmaA/ijPo3MY
   PSDL26OaWUxfFsS2NHMslBu8f40kga8A6Et3wwuhfbpQZIiv8F4MyPoDY
   bMPrjfWEprPrPCR+GWSdWzEH/5syxm2a8JsdG526ZxQ/GDZiZj6GeMpnD
   Q==;
X-CSE-ConnectionGUID: z7BmyPYxTv6MrKLvaUHsdw==
X-CSE-MsgGUID: 8oZ8MzWpTRy4RmYUeum+3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="87613443"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="87613443"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 22:58:32 -0800
X-CSE-ConnectionGUID: RTr0u7XLSeaTx5XBU3ytxg==
X-CSE-MsgGUID: XiL39KX7SleqSNkWfdr/mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="206775947"
Received: from unknown (HELO [10.238.3.254]) ([10.238.3.254])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 22:58:25 -0800
Message-ID: <8c1fefd6-4f4c-42a7-9007-5c9df3975080@linux.intel.com>
Date: Wed, 21 Jan 2026 14:58:23 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/23] perf perf_regs: Switch from arch string to int
 e_machine
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>,
 Guo Ren <guoren@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Shimin Guo <shimin.guo@skydio.com>,
 Athira Rajeev <atrajeev@linux.ibm.com>,
 Stephen Brennan <stephen.s.brennan@oracle.com>,
 Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>,
 Andi Kleen <ak@linux.intel.com>, "Dr. David Alan Gilbert"
 <linux@treblig.org>, Dmitry Vyukov <dvyukov@google.com>,
 =?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
 Chun-Tse Shao <ctshao@google.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>,
 Haibo Xu <haibo1.xu@intel.com>, Sergei Trofimovich <slyich@gmail.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-riscv@lists.infradead.org, Mark Wielaard <mark@klomp.org>
References: <20260117052849.2205545-1-irogers@google.com>
 <20260117052849.2205545-9-irogers@google.com> <aW_OV72q5rAVrgRE@x1>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aW_OV72q5rAVrgRE@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 1/21/2026 2:49 AM, Arnaldo Carvalho de Melo wrote:
> On Fri, Jan 16, 2026 at 09:28:34PM -0800, Ian Rogers wrote:
>> The arch string requires multiple strcmp to identify things like the
>> IP and SP. Switch to passing in an e_machine that in the bulk of cases
>> is computed using a current thread load. The e_machine also allows
>> identification of 32-bit vs 64-bit processes.
>>
>> Signed-off-by: Ian Rogers <irogers@google.com>
>> ---
>>  tools/perf/builtin-script.c                   |  17 ++-
>>  tools/perf/util/evsel.c                       |  14 ++-
>>  tools/perf/util/perf_regs.c                   | 105 +++++++++++-------
> [ Include dwarf-regs.h to get conditional defines for EM_CSKY and EM_LOONGARCH, not available in old distros ]
>
> - Arnaldo

Seems the change would introduce the below building error.

util/perf_regs.c: In function ‘perf_reg_name’:
util/perf_regs.c:48:14: error: ‘EM_LOONGARCH’ undeclared (first use in this
function)
   48 |         case EM_LOONGARCH:
      |              ^~~~~~~~~~~~
util/perf_regs.c:48:14: note: each undeclared identifier is reported only
once for each function it appears in
util/perf_regs.c: In function ‘perf_arch_reg_ip’:
util/perf_regs.c:114:14: error: ‘EM_LOONGARCH’ undeclared (first use in
this function)
  114 |         case EM_LOONGARCH:
      |              ^~~~~~~~~~~~
util/perf_regs.c: In function ‘perf_arch_reg_sp’:
util/perf_regs.c:143:14: error: ‘EM_LOONGARCH’ undeclared (first use in
this function)
  143 |         case EM_LOONGARCH:
      |              ^~~~~~~~~~~~

It looks EM_LOONGARCH is not defined in the <elf.h> header file, not sure
which one is better, include  dwarf-regs.h suggested by Arnaldo or direct
add the define,

diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
index b58d59b84fb1..ce839df19fa3 100644
--- a/tools/perf/util/perf_regs.c
+++ b/tools/perf/util/perf_regs.c
@@ -6,6 +6,10 @@
 #include "util/sample.h"
 #include "debug.h"

+#ifndef EM_LOONGARCH
+#define EM_LOONGARCH           258
+#endif
+
 int __weak arch_sdt_arg_parse_op(char *old_op __maybe_unused,
                                 char **new_op __maybe_unused)
 {


>
