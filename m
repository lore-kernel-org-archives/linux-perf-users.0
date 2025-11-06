Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC022472B6;
	Thu,  6 Nov 2025 17:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762450297; cv=none; b=auJh9TzPoDSN/I74SGWh9KLeHNUDQbnFJ/tnJWifxFTiwrdTmqMSpHDPiZJSUSUeTAc7b27DCBZrJsPzhOLtGtXEOmUYrZDN152HvFc31Bv0j32tvWZuGvoxBjkzMsIlUm3bg2ue85F57c/ObW8bJM7UANkh63+evzDWr5OVUw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762450297; c=relaxed/simple;
	bh=5WD5BNzh1FuLBmayQkd/a08wH4PFBEuUidQyNtpNXw4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UGc86dehtvBaCCqyfShd4GcXSV9voG7/qrDE7sqp/K7J5CTets08nt+q3V/nT2t0RyrFgycZNM9bTjy0NVrXSN88Hrf9vIL9abf76TU7uwpIOgFqFsyGLt2TpwjWBChnqI39upv6a75QgNxK/qWelyYkkw5dI+4uyshFB7w7PVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XyvD74Es; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XyvD74Es"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762450295; x=1793986295;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=5WD5BNzh1FuLBmayQkd/a08wH4PFBEuUidQyNtpNXw4=;
  b=XyvD74EsmjJBB/PfWUSxroZ/ooreMj9Vq4yHEGepcuYKmOO/mrcluWrx
   YJJ4vP6apRQ/6lF5T7jvI9XmAcoTqfh+EpA87FjSwV5seQFex87ke1/mv
   RO93TDjFU1rAcQDnWyc+bOTas3SRATNqVJem2B8+/fKMHTKaPuhBMP6XT
   CSI8Z1N55kU6O30yoO5YBq0yrN3K7pX4GewgM3NZMkewD9+pCnDmNU4xV
   yJHn4PNJqwooc1c86zoWF5ALQdZ3BQqa3eb7CJqrkym064UdKdzkfIMHo
   fmCbdzZ304ygLnQJYGpwynz5EsDVUpYTDtI2QpF5jVWEE1iiFasoJMBG3
   w==;
X-CSE-ConnectionGUID: TT92YGZcSzeaSgU9SGlgqQ==
X-CSE-MsgGUID: o01eyOGAT3mk9jIPmEiQ9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="63608577"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="63608577"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 09:31:34 -0800
X-CSE-ConnectionGUID: oY3JpO6UQ4KxGh176TtY1A==
X-CSE-MsgGUID: dIPLHy0CTlmHM8IpPX6iaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="188256663"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by fmviesa009.fm.intel.com with ESMTP; 06 Nov 2025 09:31:33 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id 8744130170C; Thu, 06 Nov 2025 09:31:33 -0800 (PST)
From: Andi Kleen <ak@linux.intel.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,
  Arnaldo Carvalho de Melo <acme@kernel.org>,  Namhyung Kim
 <namhyung@kernel.org>,  Alexander Shishkin
 <alexander.shishkin@linux.intel.com>,  Jiri Olsa <jolsa@kernel.org>,
  Adrian Hunter <adrian.hunter@intel.com>,  "Dr. David Alan Gilbert"
 <linux@treblig.org>,  Yang Li <yang.lee@linux.alibaba.com>,  James Clark
 <james.clark@linaro.org>,  Thomas Falcon <thomas.falcon@intel.com>,
  Thomas Richter <tmricht@linux.ibm.com>,
  linux-perf-users@vger.kernel.org,  linux-kernel@vger.kernel.org,  Dapeng
 Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v3 9/9] perf stat: Add no-affinity flag
In-Reply-To: <20251106071241.141234-10-irogers@google.com> (Ian Rogers's
	message of "Wed, 5 Nov 2025 23:12:40 -0800")
References: <20251106071241.141234-1-irogers@google.com>
	<20251106071241.141234-10-irogers@google.com>
Date: Thu, 06 Nov 2025 09:31:33 -0800
Message-ID: <87cy5v3w5m.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ian Rogers <irogers@google.com> writes:

> Add flag that disables affinity behavior. Using sched_setaffinity to
> place a perf thread on a CPU can avoid certain interprocessor
> interrupts but may introduce a delay due to the scheduling,
> particularly on loaded machines. Add a command line option to disable
> the behavior. This behavior is less present in other tools like `perf
> record`, as it uses a ring buffer and doesn't make repeated system
> calls.

I would rather use a real time scheduling policy instead if you see starvation.
That would still get the batching efficiency.

If it's done it would be better in .perfconfig instead of adding ever
more obscure command line options.

-Andi
