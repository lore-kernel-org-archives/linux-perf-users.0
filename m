Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E78B15687D;
	Wed, 23 Oct 2024 08:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671038; cv=none; b=LHiZ2+9UbuM3qk99BRqoHN2JHPVxSjfA/doTarivefkaRfbH1mDpD6Yx5nx2VNoqdVHcoPMylcEo88jL2MimPtThtAoiT2uL5tVCLvQ8uupyJE9CvfW+o6B0XM5wWIY77vglz6C8/DTZMF+24km5I/G9Nfw2Zi5Pkw4v3iX3yEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671038; c=relaxed/simple;
	bh=Obwu5qUpWeqyEqihVWaUPPgnlrdnP4XgH+6QRoE9Pzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gmvj+xgnDvN5Yrckv3oyy+Fli5X57+mrzfETmwnP+GLyWOXlj9azCQUWisRJwtUSsZLJMc6KJse+oG9RAjzjeCg3cNLc1d1/B3L8SUabws7yJIytiEwhw7WzwuJJxzafjSYE/jC5BQO7Eyzmzi3Lt9ykBfyEFxpFrmeCL/giLAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=exx5z6js; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="exx5z6js"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729671036; x=1761207036;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Obwu5qUpWeqyEqihVWaUPPgnlrdnP4XgH+6QRoE9Pzk=;
  b=exx5z6jsLpVIV7dyMqbdKT9kqL4nwBPyy+Zg9odGuq7+pzJNjKqp2Hc0
   6n7g/LWoapms90hrPZmebqJnYy8bCqWyu1aG+DpNKqqSzxCpgVgfc+9fE
   d8SK5SgXaivmdqz1MCoBCjpfqsGQ0BIV72ZwcDrN5RZXi/YO2SGc9Aypw
   PrjssUijXE78pSFyBf/GMPIsS22kFjPeMvsZRZcikXad73DQQp/S//4s9
   zczZuHc5y86iUwUZPNJYP5l4ZPmVKRyOPZE4eajYnvvIStyKrhu6q0jP6
   2aH940grePOPayD5Ry9e0rurtjINsk/6HlsuS75SIy5ApHB3jY1tljuRv
   Q==;
X-CSE-ConnectionGUID: asPQGpqpQNO7AM/SYM09ZQ==
X-CSE-MsgGUID: upkPrnPyRw61bm4XnRSdJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="29348524"
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="29348524"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 01:10:35 -0700
X-CSE-ConnectionGUID: Y04k9Wk8TvixbxJBlBu38g==
X-CSE-MsgGUID: ffFedwpURneBmcgtGIrLsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="80051502"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.115.59])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 01:10:23 -0700
Message-ID: <5b7b2b5e-8ed9-4180-907f-81c11e76d268@intel.com>
Date: Wed, 23 Oct 2024 11:10:18 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf cap: Tidy up and improve capability testing
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
 James Clark <james.clark@arm.com>, Oliver Upton <oliver.upton@linux.dev>,
 Leo Yan <leo.yan@linux.dev>, Changbin Du <changbin.du@huawei.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240806220614.831914-1-irogers@google.com>
 <cc7d6bdf-1aeb-4179-9029-4baf50b59342@intel.com>
 <CAP-5=fVXvus+7PMO=WU+V3CnVNSboGgwS5EcPgXhJKb5MtRAWw@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fVXvus+7PMO=WU+V3CnVNSboGgwS5EcPgXhJKb5MtRAWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/10/24 19:34, Ian Rogers wrote:
> On Tue, Oct 22, 2024 at 6:56 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 7/08/24 01:06, Ian Rogers wrote:
>>> Remove dependence on libcap. libcap is only used to query whether a
>>> capability is supported, which is just 1 capget system call.
>>>
>>> If the capget system call fails, fall back on root permission
>>> checking. Previously if libcap fails then the permission is assumed
>>> not present which may be pessimistic/wrong.
>>>
>>> Add a used_root out argument to perf_cap__capable to say whether the
>>> fall back root check was used. This allows the correct error message,
>>> "root" vs "users with the CAP_PERFMON or CAP_SYS_ADMIN capability", to
>>> be selected.
>>>
>>> Tidy uses of perf_cap__capable so that tests aren't repeated if capget
>>> isn't supported.
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>
>> I find I need to revert this.  E.g.
>>
>> $ install-perf.sh
>> $ perf record -e intel_pt//k uname
>> WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,
>> check /proc/sys/kernel/kptr_restrict and
>> /proc/sys/kernel/perf_event_paranoid.
>>
>> Samples in kernel functions may not be resolved if a suitable vmlinux
>> file is not found in the buildid cache or in the vmlinux path.
>>
>> Samples in kernel modules won't be resolved at all.
>>
>> If some relocation was applied (e.g. kexec) symbols may be misresolved
>> even with a suitable vmlinux or kallsyms file.
>>
>> Couldn't record kernel reference relocation symbol
>> Symbol resolution may be skewed if relocation was used (e.g. kexec).
>> Check /proc/kallsyms permission or run as root.
>> Linux
>> [ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 0.061 MB perf.data ]
>> $ git revert e25ebda78e230283bf707ae3e9655270ff40a7f9
>> Auto-merging tools/perf/Makefile.config
>> Auto-merging tools/perf/builtin-ftrace.c
>> Auto-merging tools/perf/util/Build
>> Auto-merging tools/perf/util/symbol.c
>> [master 752707588a700] Revert "perf cap: Tidy up and improve capability
>> testing"
>>  7 files changed, 70 insertions(+), 73 deletions(-)
>> $ install-perf.sh
>> $ perf record -e intel_pt//k uname
>> Linux
>> [ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 0.065 MB perf.data ]
> 
> Sorry for this. I couldn't immediately see a code path that should
> impact `perf record` and the reproducer works for me without the
> revert.

Sorry, I forgot to highlight that capabilities are being used
as described here:

	https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html

i.e.	# setcap "cap_perfmon,cap_sys_ptrace,cap_syslog=ep" perf
	# setcap -v "cap_perfmon,cap_sys_ptrace,cap_syslog=ep" perf
	perf: OK
	# getcap perf
	perf = cap_sys_ptrace,cap_syslog,cap_perfmon+ep

instead of changing perf_paranoid, kptr_restrict etc

> revert. Running your command under gdb looking for calls to
> perf_cap__capable:
> 
> 1)
> ```
> #0  0x00005555557f7abe in symbol__read_kptr_restrict () at util/symbol.c:2429
> #1  0x00005555557f759f in symbol__init (env=0x0) at util/symbol.c:2523
> #2  0x00005555555e7ca3 in cmd_record (argc=1, argv=0x7fffffffe390) at
> builtin-record.c:4114
> #3  0x000055555569775f in run_builtin (p=0x5555560bda50
> <commands+288>, argc=4,
>    argv=0x7fffffffe390) at perf.c:351
> #4  0x0000555555696e13 in handle_internal_command (argc=4,
> argv=0x7fffffffe390) at perf.c:404
> #5  0x000055555569762f in run_argv (argcp=0x7fffffffe1dc,
> argv=0x7fffffffe1d0) at perf.c:448
> #6  0x0000555555696a74 in main (argc=4, argv=0x7fffffffe390) at perf.c:562
> ```
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/builtin-record.c?h=perf-tools-next#n4108
> ```
> /*
> * Allow aliases to facilitate the lookup of symbols for address
> * filters. Refer to auxtrace_parse_filters().
> */
> symbol_conf.allow_aliases = true;
> 
> symbol__init(NULL);
> ```
> I don't think this is the cause but it seems unfortunate we're
> enabling symbols in perf record unconditionally.
> 
> 2)
> ```
> #0  perf_cap__capable (cap=21, used_root=0x7fffffffbd87) at util/cap.c:22
> #1  0x0000555555878236 in perf_event_paranoid_check (max_level=-1) at
> util/util.c:330
> #2  0x00005555559574ba in intel_pt_recording_options
> (itr=0x55555610ada0, evlist=0x5555560f36f0,
>    opts=0x5555560b4818 <record+320>) at arch/x86/util/intel-pt.c:619
> #3  0x00005555558a46ad in auxtrace_record__options
> (itr=0x55555610ada0, evlist=0x5555560f36f0,
>    opts=0x5555560b4818 <record+320>) at util/auxtrace.c:619
> #4  0x00005555555e8139 in cmd_record (argc=1, argv=0x7fffffffe390) at
> builtin-record.c:4206
> #5  0x000055555569775f in run_builtin (p=0x5555560bda50
> <commands+288>, argc=4,
>    argv=0x7fffffffe390) at perf.c:351
> #6  0x0000555555696e13 in handle_internal_command (argc=4,
> argv=0x7fffffffe390) at perf.c:404
> #7  0x000055555569762f in run_argv (argcp=0x7fffffffe1dc,
> argv=0x7fffffffe1d0) at perf.c:448
> #8  0x0000555555696a74 in main (argc=4, argv=0x7fffffffe390) at perf.c:562
> ```
> So this looks like the cause.
> 
> Would it be possible for you to trace (strace/gdb/perf trace) what's
> happening in perf_cap__capable? I suspect the system call capget and
> its interpretation are the source of the problem, but I can't eyeball
> an issue in:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/cap.c?h=perf-tools-next#n53
> 
> I'd prefer a fix to a revert but I'll leave that to others to decide.
> 
> Thanks,
> Ian

