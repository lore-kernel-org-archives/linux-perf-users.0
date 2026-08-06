Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E385481FAA
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033066; cv=none; b=OE52fXUS2Cm1x4dut6ORJ02XCavltxTOZdF0SNxi1rkRryOjyiXMueqFEBdZfecuyYYUxeGG9HHTT9efHylRNuZ90QCis/E8+IefKlgEnr+bG7ND3RDNSIUhQjdirmx8HSmMDDi/NJJS2u7PNZEdKfKVJ+N4Xd3GWGdv0aUF+0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033066; c=relaxed/simple;
	bh=fF7WVnf+WrZSySrt8VBlerieGX5S73xFZaenocrQFd4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GBTPv/ReUhwGYVg93rcAFjX6BbYSCWQf/Ix+JzXyIIJ4n9OlxIwi4NeYC3lWYfj6/LVONcKZbJPIU6TZipR7ObnAm6gWLpFlgG3+Z8VoIw0VFIpFLt5kBYZcSMxIrhkkkn/pt4TrrK/rydsAKhQxriuY6NqG9iY2u2ZV3Og0hfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLPb0sfi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLPb0sfi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C0C1F00AC4;
	Thu,  6 Aug 2026 16:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786033061;
	bh=hnBlfXJsXaIiSYhJCF745YIsLdwuhGEKGIc9NgDa0/U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=KLPb0sfixqc567iKbJnqdy7pW/Ov5eDqPyLz+OcDPQBbvxLSp6l/h/vyqX0HcM5Ag
	 ga4gETeKZ0dOT7oL2X553ufujIbgnlSGgmzepBDt75VTewmL7h4dxaAyVGFj4g49LX
	 o9HSQE5IVaYrt3tq/E+4caPJBLsQ5Yy/XAZZpRwyZSIgBWRNjCCA8vfICGY/CypmZN
	 y7IeHdYfb7bp9OXcpghtqTcldacXorKTzALeFXosoFXi0xFglLVi0+o4e2JUVwzrsh
	 0FBA0j3ag6N1M0IA66xVPpoQVNH0KK1LB+11j7CArEnhSQ+k8wU9h5FnHkHUlTMzSN
	 J+qw4taiXJ7Dg==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
 vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com, 
 maddy@linux.ibm.com, irogers@google.com, 
 Tanushree Shah <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com, 
 Tanushree.Shah@ibm.com
In-Reply-To: <20260725184953.234759-1-tshah@linux.ibm.com>
References: <20260725184953.234759-1-tshah@linux.ibm.com>
Subject: Re: [PATCH v4 0/5] perf trace-event: Fix overflow, loop and
 cleanup bugs
Message-Id: <178603306100.1984988.9265776445175930441.b4-ty@kernel.org>
Date: Thu, 06 Aug 2026 09:17:41 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sun, 26 Jul 2026 00:19:48 +0530, Tanushree Shah wrote:
> This series fixes five security issues in trace-event-read.c and
> trace-event.c:
> 1. Stack buffer overflow in read_string() when a string exceeds
>    BUFSIZ, due to a missing bounds check.
> 2. Integer truncation when passing 64-bit sizes into do_read() and
>    skip(), which use 'int' parameters, causing uninitialized memory
>    to be dumped and parsers to read out of bounds.
> 3. Double free / use-after-free in trace_event__cleanup(): it frees
>    t->pevent but never clears the pointer, so calling it twice on
>    the same trace_event touches already-freed memory. Also fixes a
>    related leak in trace_event__init(), which overwrites
>    t->pevent/t->plugin_list without releasing any existing handle
>    if called more than once on the same struct.
> 4. Heap buffer overflow in read_ftrace_printk() and
>    read_saved_cmdline(): size + 1 can overflow to 0 in malloc(),
>    allocating a tiny buffer while a huge read is still attempted
>    into it.
> 5. Infinite loop in skip(): it does not check do_read()'s return
>    value, so a crafted size can spin the loop indefinitely.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


