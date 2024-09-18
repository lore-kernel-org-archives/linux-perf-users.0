Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DEB1C9EBF;
	Wed, 18 Sep 2024 20:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726691222; cv=none; b=Wyb8eju1k+vCXqZbPU363UWr+JErNlXl1K8+UPqBlUqoRbzhtGBjEThs7KRUOKwJagsfc/XVjvpKoXiRkPPRSqqTG1zVJ6KrXuh3I1ZScD+FoxHsHOH+ym9ZNML7PFKsZd5yYtLv/NYzuIEcJLTio7CUQIV82HQ3Vmmg2ZOglyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726691222; c=relaxed/simple;
	bh=WuhzO6bynCgX48WtRDDzGwgzs3tibIgTcvcbFL7ZzSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uACHUY5ie+/DrW0vFOf6V6tpGJLUzTazasMG7wclhfNstDMhXXpG9uqXNX85VY8y81Mds6DthAYBORfT2HS22UwToStPm4EgLni54L/H4hYOQXJTS5ovhj3FnRRyyCPWgsYuRqeW92lBxMJhpUjm7X3phGJfS0n4w6+kfOxMfhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cN+NvBAk; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cN+NvBAk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726691221; x=1758227221;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WuhzO6bynCgX48WtRDDzGwgzs3tibIgTcvcbFL7ZzSA=;
  b=cN+NvBAk6DDpo9JGjAgh6LBM6Mb+FbDNnuFTNm4sKnjRMHYCexOBA6RR
   gKTA6UABU4BHZqGBHs6ENwAFnzZVlUpG6cSCZ1wq6Hb5JDNxv+pWSCqth
   TJcOijf8T7kln6n83sB8iLGdjtFPEjkS2nHCFsTLrcCJUuPiPWtZP2bac
   1cUxwXnOA96P6wkFhNdoDQEY8HHQ4IYgPzq4XdKwELunpngPFTsWEH2xm
   nSasaDCrxEYa70kKlHGZYGuuvT+Wax3eW8IpKCxejIlNaNgbzwn+p4HDm
   D1W+YTOMsL2+1FBKVKQ8QPvHxi1jnZYi9b6+e6CRQ/osMIv+PJgTMZz/3
   Q==;
X-CSE-ConnectionGUID: o2O1IQh4SU++KIZixGn6kQ==
X-CSE-MsgGUID: 0ybjGOmpQA2G3DnHxngFzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="36295239"
X-IronPort-AV: E=Sophos;i="6.10,239,1719903600"; 
   d="scan'208";a="36295239"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 13:27:00 -0700
X-CSE-ConnectionGUID: kM9FXNm3SZW4+V7VrRsrow==
X-CSE-MsgGUID: tW191H7GQleOTdVK8VJkJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,239,1719903600"; 
   d="scan'208";a="69937228"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 13:26:59 -0700
Received: from [10.212.22.202] (kliang2-mobl1.ccr.corp.intel.com [10.212.22.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id BF13820CFEE3;
	Wed, 18 Sep 2024 13:26:57 -0700 (PDT)
Message-ID: <f554bf58-a1df-4ef8-9045-2d1396f30ef3@linux.intel.com>
Date: Wed, 18 Sep 2024 16:26:56 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/PATCHSET 0/5] perf tools: Support deferred user callchains
 (v2)
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Josh Poimboeuf <jpoimboe@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Indu Bhagat <indu.bhagat@oracle.com>, linux-toolchains@vger.kernel.org
References: <20240917222820.197594-1-namhyung@kernel.org>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240917222820.197594-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-09-17 6:28 p.m., Namhyung Kim wrote:
> Hello,
> 
> This is a counterpart for Josh's kernel change v2 [1] to support deferred
> user callchains.  The change is transparent and users should not notice
> anything with the deferred callchains.
> 
>   $ perf record -g sleep 1
> 
> I added --[no-]merge-callchains option to control output of perf script.
> You can verify it has the deferred callchains like this:
> 
>   $ perf script --no-merge-callchains
>   perf     801 [000]    18.031793:          1 cycles:P:
>           ffffffff91a14c36 __intel_pmu_enable_all.isra.0+0x56 ([kernel.kallsyms])
>           ffffffff91d373e9 perf_ctx_enable+0x39 ([kernel.kallsyms])
>           ffffffff91d36af7 event_function+0xd7 ([kernel.kallsyms])
>           ffffffff91d34222 remote_function+0x42 ([kernel.kallsyms])
>           ffffffff91c1ebe1 generic_exec_single+0x61 ([kernel.kallsyms])
>           ffffffff91c1edac smp_call_function_single+0xec ([kernel.kallsyms])
>           ffffffff91d37a9d event_function_call+0x10d ([kernel.kallsyms])
>           ffffffff91d33557 perf_event_for_each_child+0x37 ([kernel.kallsyms])
>           ffffffff91d47324 _perf_ioctl+0x204 ([kernel.kallsyms])
>           ffffffff91d47c43 perf_ioctl+0x33 ([kernel.kallsyms])
>           ffffffff91e2f216 __x64_sys_ioctl+0x96 ([kernel.kallsyms])
>           ffffffff9265f1ae do_syscall_64+0x9e ([kernel.kallsyms])
>           ffffffff92800130 entry_SYSCALL_64+0xb0 ([kernel.kallsyms])
> 
>   perf     801 [000]    18.031814: DEFERRED CALLCHAIN
>                   7fb5fc22034b __GI___ioctl+0x3b (/usr/lib/x86_64-linux-gnu/libc.so.6)
> 
>   ...
> 
> When the callchain is merged (it's the default) it'd look like below:
> 
>   $ perf script
>   perf     801 [000]    18.031793:          1 cycles:P:
>           ffffffff91a14c36 __intel_pmu_enable_all.isra.0+0x56 ([kernel.kallsyms])
>           ffffffff91d373e9 perf_ctx_enable+0x39 ([kernel.kallsyms])
>           ffffffff91d36af7 event_function+0xd7 ([kernel.kallsyms])
>           ffffffff91d34222 remote_function+0x42 ([kernel.kallsyms])
>           ffffffff91c1ebe1 generic_exec_single+0x61 ([kernel.kallsyms])
>           ffffffff91c1edac smp_call_function_single+0xec ([kernel.kallsyms])
>           ffffffff91d37a9d event_function_call+0x10d ([kernel.kallsyms])
>           ffffffff91d33557 perf_event_for_each_child+0x37 ([kernel.kallsyms])
>           ffffffff91d47324 _perf_ioctl+0x204 ([kernel.kallsyms])
>           ffffffff91d47c43 perf_ioctl+0x33 ([kernel.kallsyms])
>           ffffffff91e2f216 __x64_sys_ioctl+0x96 ([kernel.kallsyms])
>           ffffffff9265f1ae do_syscall_64+0x9e ([kernel.kallsyms])
>           ffffffff92800130 entry_SYSCALL_64+0xb0 ([kernel.kallsyms])
>                   7fb5fc22034b __GI___ioctl+0x3b (/usr/lib/x86_64-linux-gnu/libc.so.6)
> 
>   ...
> 
> Notice that the last line and it has the __GI___ioctl in the same
> callchain.  It should work with other tools like perf report.


It seems it only works with perf report -D, when I test it on a
non-hybrid machine.
$perf record -e branches -g -c 3000000 ~/tchain_edit
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.397 MB perf.data ]
$ perf report -D | tail -n 17

Aggregated stats:
               TOTAL events:       8235
                MMAP events:         78  ( 0.9%)
                COMM events:          2  ( 0.0%)
                EXIT events:          1  ( 0.0%)
              SAMPLE events:       4060  (49.3%)
               MMAP2 events:          2  ( 0.0%)
             KSYMBOL events:         12  ( 0.1%)
           BPF_EVENT events:         12  ( 0.1%)
  CALLCHAIN_DEFERRED events:       4060  (49.3%)
      FINISHED_ROUND events:          3  ( 0.0%)
            ID_INDEX events:          1  ( 0.0%)
          THREAD_MAP events:          1  ( 0.0%)
             CPU_MAP events:          1  ( 0.0%)
           TIME_CONV events:          1  ( 0.0%)
       FINISHED_INIT events:          1  ( 0.0%)
$ perf report
Error:
The perf.data data has no samples!
# To display the perf.data header info, please use
--header/--header-only options.
#


On a hybrid machine, perf record errors out.

$perf record -g true
[ perf record: Woken up 1 times to write data ]
0x58a8 [0x38]: failed to process type: 22 [Bad address]
[ perf record: Captured and wrote 0.022 MB perf.data ]

Thanks,
Kan
> 
> The code is available at 'perf/defer-callchain-v2' branch in
> https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Thanks,
> Namhyung
> 
> [1] https://lore.kernel.org/lkml/cover.1726268190.git.jpoimboe@kernel.org
> 
> 
> Namhyung Kim (5):
>   perf tools: Sync UAPI perf_event.h header
>   perf tools: Minimal DEFERRED_CALLCHAIN support
>   perf record: Enable defer_callchain for user callchains
>   perf script: Display PERF_RECORD_CALLCHAIN_DEFERRED
>   perf tools: Merge deferred user callchains
> 
>  tools/include/uapi/linux/perf_event.h     | 21 +++++-
>  tools/lib/perf/include/perf/event.h       |  7 ++
>  tools/perf/Documentation/perf-script.txt  |  5 ++
>  tools/perf/builtin-script.c               | 92 +++++++++++++++++++++++
>  tools/perf/util/callchain.c               | 24 ++++++
>  tools/perf/util/callchain.h               |  3 +
>  tools/perf/util/event.c                   |  1 +
>  tools/perf/util/evlist.c                  |  1 +
>  tools/perf/util/evlist.h                  |  1 +
>  tools/perf/util/evsel.c                   | 32 +++++++-
>  tools/perf/util/evsel.h                   |  1 +
>  tools/perf/util/machine.c                 |  1 +
>  tools/perf/util/perf_event_attr_fprintf.c |  1 +
>  tools/perf/util/sample.h                  |  3 +-
>  tools/perf/util/session.c                 | 78 +++++++++++++++++++
>  tools/perf/util/tool.c                    |  2 +
>  tools/perf/util/tool.h                    |  4 +-
>  17 files changed, 273 insertions(+), 4 deletions(-)
> 
