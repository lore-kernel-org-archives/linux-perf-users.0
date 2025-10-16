Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B79E31A7F3;
	Thu, 16 Oct 2025 11:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614647; cv=none; b=lQlUcxxuUZ9p3Y9wEQUobInD6RpCFJ2O/w14p4oiv+edXok/j+nkze5gi0mL6bnRr6CDLAJ6tFqi+Jc3uglmSnoYtn9/+YUNWCnesPUOpOWwRg9msajV1wneJnLM0hTd/yF7srUDI5heg82pRO0PoaPQbD0oDMiQ1/vZTXNQGqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614647; c=relaxed/simple;
	bh=v/p5WbwRu7MI/kgIQR21ZD5+uRNrgnKQRlHjro5dlgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsMsLEtzmRQvGjSdt6iIctCD6w2C9m/K0EjZDhG6myTD6Wzn9+vn6q7ZhBzhiILYqvVAsZAJDu8sgMGP0+h7lUXNzYsml5wHvbptk+B0CIU6jfKexIHwbWmLrSSnr2Gn+4GAvwksiPE9D7XQEl1p4JCsMFwh7AJ/74bPyfeJKj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C64OeU9u; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C64OeU9u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760614646; x=1792150646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v/p5WbwRu7MI/kgIQR21ZD5+uRNrgnKQRlHjro5dlgg=;
  b=C64OeU9uV+bw4ZLAh/i0VZgMig2tpRmWbtPoAiAwp9laSIAOsqXSOjGw
   rb4xG7nvCPLmFpOlCt4o0tWwwfD+rd8sWLrEoGhRjmPV1wlz9xLmyA+CX
   8tAhMUcXVIu7sNH4VZrbxGakMMSAMx99CqLEDmNmWVxfi9RJBLWycAhbn
   aM5LzdUYrCNuqi7zJGNYyGqCzhvjUtKU27T7OpUdZkBxdOqzK4lWTz0f7
   J4G8aR9Ir891A73dSmsSgTjOtocEIWKMI2d3/Q3bTS79FDDt6m+GMdgv6
   ojqYyhhh8gPLQbq78mJna2+LDD96orUYyppKDT8KyA/+QXZWJaPJd+6qS
   A==;
X-CSE-ConnectionGUID: wNbtJxorTSi5Fw3Qoq/+hQ==
X-CSE-MsgGUID: t9SluvHjRlSnIlxR4fGhew==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="73915742"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="73915742"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 04:37:26 -0700
X-CSE-ConnectionGUID: nDMvKVvDQC+P6DB3xtuWrw==
X-CSE-MsgGUID: WiXBWk7XTBaRTcb235v5bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="182228181"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 16 Oct 2025 04:37:20 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9MIH-0004kr-35;
	Thu, 16 Oct 2025 11:37:17 +0000
Date: Thu, 16 Oct 2025 19:36:33 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Takaya Saeki <takayas@google.com>, Tom Zanussi <zanussi@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ian Rogers <irogers@google.com>,
	Douglas Raillard <douglas.raillard@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v3 13/13] tracing: Have persistent ring buffer print
 syscalls normally
Message-ID: <202510161956.5wnA6TUc-lkp@intel.com>
References: <20251015173550.225723717@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015173550.225723717@kernel.org>

Hi Steven,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.18-rc1 next-20251015]
[cannot apply to trace/for-next acme/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-Make-trace_user_fault_read-exposed-to-rest-of-tracing/20251016-014059
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20251015173550.225723717%40kernel.org
patch subject: [PATCH v3 13/13] tracing: Have persistent ring buffer print syscalls normally
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20251016/202510161956.5wnA6TUc-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251016/202510161956.5wnA6TUc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510161956.5wnA6TUc-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/trace/trace.c: In function 'print_trace_fmt':
>> kernel/trace/trace.c:4258:47: error: 'enter_syscall_print_funcs' undeclared (first use in this function)
    4258 |                             (event->funcs != &enter_syscall_print_funcs) &&
         |                                               ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace.c:4258:47: note: each undeclared identifier is reported only once for each function it appears in
>> kernel/trace/trace.c:4259:47: error: 'exit_syscall_print_funcs' undeclared (first use in this function)
    4259 |                             (event->funcs != &exit_syscall_print_funcs))
         |                                               ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace.c: In function 'tracer_alloc_buffers':
   kernel/trace/trace.c:11443:39: error: 'CONFIG_TRACE_SYSCALL_BUF_SIZE_DEFAULT' undeclared (first use in this function)
   11443 |         global_trace.syscall_buf_sz = CONFIG_TRACE_SYSCALL_BUF_SIZE_DEFAULT;
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/enter_syscall_print_funcs +4258 kernel/trace/trace.c

  4222	
  4223	static enum print_line_t print_trace_fmt(struct trace_iterator *iter)
  4224	{
  4225		struct trace_array *tr = iter->tr;
  4226		struct trace_seq *s = &iter->seq;
  4227		unsigned long sym_flags = (tr->trace_flags & TRACE_ITER_SYM_MASK);
  4228		struct trace_entry *entry;
  4229		struct trace_event *event;
  4230	
  4231		entry = iter->ent;
  4232	
  4233		test_cpu_buff_start(iter);
  4234	
  4235		event = ftrace_find_event(entry->type);
  4236	
  4237		if (tr->trace_flags & TRACE_ITER_CONTEXT_INFO) {
  4238			if (iter->iter_flags & TRACE_FILE_LAT_FMT)
  4239				trace_print_lat_context(iter);
  4240			else
  4241				trace_print_context(iter);
  4242		}
  4243	
  4244		if (trace_seq_has_overflowed(s))
  4245			return TRACE_TYPE_PARTIAL_LINE;
  4246	
  4247		if (event) {
  4248			if (tr->trace_flags & TRACE_ITER_FIELDS)
  4249				return print_event_fields(iter, event);
  4250			/*
  4251			 * For TRACE_EVENT() events, the print_fmt is not
  4252			 * safe to use if the array has delta offsets
  4253			 * Force printing via the fields.
  4254			 */
  4255			if ((tr->text_delta)) {
  4256				/* ftrace and system call events are still OK */
  4257				if ((event->type > __TRACE_LAST_TYPE) &&
> 4258				    (event->funcs != &enter_syscall_print_funcs) &&
> 4259				    (event->funcs != &exit_syscall_print_funcs))
  4260				return print_event_fields(iter, event);
  4261			}
  4262			return event->funcs->trace(iter, sym_flags, event);
  4263		}
  4264	
  4265		trace_seq_printf(s, "Unknown type %d\n", entry->type);
  4266	
  4267		return trace_handle_return(s);
  4268	}
  4269	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
