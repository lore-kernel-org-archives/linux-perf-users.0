Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A5E80BEC;
	Fri,  8 Aug 2025 22:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754691715; cv=none; b=o76qTSehJrYjC3hHeYwIGAmFY2loZNNmgnMpoyc14glY+g1Ymh+FnLMq4KdrKnDot9m0cdfCm80Vj9YTpoJtxjtVEnfrZdRB0kG5RPuWmVIUpT8mFIHaFm8QQYkXuJmYiVKniNhTnNvcy+3f4I80aCNQjABIT9tktYPMywH/dvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754691715; c=relaxed/simple;
	bh=fNAp7xZNr7w0+ZIJmblEMbM01V1xqVpwRC08lJdSRio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3OPvdhmL8TGOjHz7PqfXZS4eOulT0vL1+Bfy0xcqIxEDbKDBKY2p19DmjAAUh/MReq4wm0lgSJYOcpVqYlZOraudjaYVMirRxDSqyQl8DJtVWDipjwV0xOl6JwWfZ9NGmHVvxXc4zyhbK7OmH6gYdu7gatykmZClFT6nAZY5iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTHlVTF/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTHlVTF/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9682DC4CEED;
	Fri,  8 Aug 2025 22:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754691715;
	bh=fNAp7xZNr7w0+ZIJmblEMbM01V1xqVpwRC08lJdSRio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MTHlVTF/lTQ7jSgVqnMtt94RiZMpGpYLK9viQ0CnV3xl9+E5YHJwDh/7WpPTI6BPx
	 dtcSeaQvqu+iDHCFbyYBHVjkaOq5AjoWXbJmBQLI19yaGe58OnLqkOwIur0SypddUQ
	 PaayWybUjt1oangxRREynFPRA20P8wM8+uoV6n/wmIu2GpjEAZmmajPOFP9jKySvVl
	 7GCH/SKGNsqWB1uRKBkKArY/mLgONoQ0CoxYMQK/TyLTeHPdEbqwAsWwxUEtvLEPaI
	 ocsmmlm6Xthu4A7JcOx03lVXHVUV2HgOiwxCk3zHD2+pVOY53YU5d22SvBqXk1WWVH
	 mBRe/rHN5QzZg==
Date: Fri, 8 Aug 2025 15:21:53 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jakub Brnak <jbrnak@redhat.com>, peterz@infradead.org, mingo@redhat.com,
	irogers@google.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	howardchu95@gmail.com
Subject: Re: [PATCH] perf: use standard syscall tracepoint structs for
 augmentation
Message-ID: <aJZ4gXyOftCV9tHw@google.com>
References: <20250806130017.541416-1-jbrnak@redhat.com>
 <aJPgNMi-6J2ewGza@google.com>
 <aJUJh8oDaH-2Ptll@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aJUJh8oDaH-2Ptll@x1>

On Thu, Aug 07, 2025 at 05:16:07PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Aug 06, 2025 at 04:07:32PM -0700, Namhyung Kim wrote:
> > Hello,
> > 
> > On Wed, Aug 06, 2025 at 03:00:17PM +0200, Jakub Brnak wrote:
> > > Replace custom syscall structs with the standard trace_event_raw_sys_enter
> > > and trace_event_raw_sys_exit from vmlinux.h.
> > > This fixes a data structure misalignment issue discovered on RHEL-9, which
> > > prevented BPF programs from correctly accessing syscall arguments.
> > 
> > Can you explain what the alignment issue was?  It's not clear to me what
> > makes it misaligned.
> 
> Yeah, mentioning a "misalignment" and then not spelling it out precisely
> doesn't help.
> 
> Showing the pahole output of the expected structure layout in both
> kernels and what was being used would help us to understand the problem.
> 
> For instance, here I have:
> 
> acme@x1:~/git/bpf-next$ uname -r
> 6.15.5-200.fc42.x86_64
> acme@x1:~/git/bpf-next$ pahole -E trace_event_raw_sys_enter
> struct trace_event_raw_sys_enter {
> 	struct trace_entry {
> 		short unsigned int type;                 /*     0     2 */
> 		unsigned char      flags;                /*     2     1 */
> 		unsigned char      preempt_count;        /*     3     1 */
> 		int                pid;                  /*     4     4 */
> 	} ent; /*     0     8 */
> 	long int                   id;                   /*     8     8 */
> 	long unsigned int          args[6];              /*    16    48 */
> 	/* --- cacheline 1 boundary (64 bytes) --- */
> 	char                       __data[];             /*    64     0 */
> 
> 	/* size: 64, cachelines: 1, members: 4 */
> };
> 
> acme@x1:~/git/bpf-next$
> 
> And:
> 
> ⬢ [acme@toolbx linux]$ pahole -C syscall_enter_args /tmp/build/linux/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o 
> struct syscall_enter_args {
> 	unsigned long long         common_tp_fields;     /*     0     8 */
> 	long                       syscall_nr;           /*     8     8 */
> 	unsigned long              args[6];              /*    16    48 */
> 
> 	/* size: 64, cachelines: 1, members: 3 */
> };
> 
> ⬢ [acme@toolbx linux]$
> 
> So yes, it is "aligned", the 'id' is the 'syscall_nr' and both are at
> offset 8, then we have the syscall args starting at offset 16 in both
> cases.
> 
> The layout for rhel9 then we see the issue, the id, syscall_nr, is at
> offset 16, there is the misalignment:
> 
> sh-5.1# pahole -E -C trace_event_raw_sys_enter /usr/lib/debug/lib/modules/5.14.0-570.32.1.el9_6.x86_64/vmlinux
> struct trace_event_raw_sys_enter {
> 	struct trace_entry {
> 		short unsigned int type;                 /*     0     2 */
> 		unsigned char      flags;                /*     2     1 */
> 		unsigned char      preempt_count;        /*     3     1 */
> 		int                pid;                  /*     4     4 */
> 		unsigned char      preempt_lazy_count;   /*     8     1 */

Oh.. RHEL9 has this new field.


> 	} ent; /*     0    12 */
> 
> 	/* XXX last struct has 3 bytes of padding */
> 	/* XXX 4 bytes hole, try to pack */
> 
> 	long int                   id;                   /*    16     8 */
> 	long unsigned int          args[6];              /*    24    48 */
> 	/* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
> 	char                       __data[];             /*    72     0 */
> 
> 	/* size: 72, cachelines: 2, members: 4 */
> 	/* sum members: 68, holes: 1, sum holes: 4 */
> 	/* paddings: 1, sum paddings: 3 */
> 	/* last cacheline: 8 bytes */
> };
> 
> sh-5.1#
> 
> So if we always use 'struct trace_event_raw_sys_enter' from the
> vmlinux.h generated from the BTF info and have it all as CO-RE enabled
> (preserving the access index of fields, etc) it will work on any kernel
> you install on machine.

Agreed, thanks.
Namhyung

