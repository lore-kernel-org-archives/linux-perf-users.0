Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709691FBBD2;
	Mon, 13 Jan 2025 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782148; cv=none; b=PGPku1kbO76aZcZHf07arLg5HUqVhfj/7MH/PTepLiofabRhS5I1k2ss956Z7yba9Ph54u0MXFm0oDFpNgmmY9vbOMUepQa4D11UNmj2Dgg1l/EYEN6N7nXm5E2uK8ge5LaVrOXQbH2VGX3wOYeTCVVKh0N8xNIza5OTLoNZNEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782148; c=relaxed/simple;
	bh=Mad1urOLYXF3ULSZA3PhDLGLRiXSoF16DHteM4lHd8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQZMQ08U1MKBy/v0FRLTDJr5kbpd+wX5YTWsUExjKktClet5j5/CUHjj1Y5tm9Pubtd5mR8IAI6gdpm6zBnjwkq7XCI6TZbCkIQwA90afKoFpPtBqn/Qk4MU9ZzsSfUXj0FmNxyPSnFNhXUIFxbTGAybw356w29rBkWgOFMJ7mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThebVNAA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThebVNAA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A193AC4CEE3;
	Mon, 13 Jan 2025 15:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736782148;
	bh=Mad1urOLYXF3ULSZA3PhDLGLRiXSoF16DHteM4lHd8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ThebVNAAfg9N90RAsY7ktteyhw5L2dF120/5JUXRlrh3ADokjN/CEPb8vWs7dUPxd
	 /2zBHZmn70JTdMoABKHRABjzGGueRA5++NyGbQjJGiKl6n92ddtgQ+4c6SbidSFIyt
	 MsPmxlTO6f1HN81ICicPTv1IRLB7uc9Foi1myRtUKGi1NlH+1tvpsmfUg8ubsQve7M
	 gVywHQaQcuECjOJvdgOCOEqLZAfATtY8nI8JxTlHNgvo6SDvRFOFsNMdZyYUqnag5l
	 Qi/DExumUk0URN7pLdeARkr2HNVl8lE501vCaX6MHMfYmHYhfJnX3c+1gzCJ7f/IL2
	 YD0ug6z/05tpw==
Date: Mon, 13 Jan 2025 12:29:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, jolsa@kernel.org,
	adrian.hunter@intel.com, irogers@google.com, hbathini@linux.ibm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
	kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH] tools/perf: Fix segfault during perf record --off-cpu
 when debuginfo is not enabled
Message-ID: <Z4UxQSAKoLskEILD@x1>
References: <20241223135813.8175-1-atrajeev@linux.vnet.ibm.com>
 <409D0233-93FF-40D6-BC2E-B7625E4E1B97@linux.vnet.ibm.com>
 <Z3xKTKkVSf7tWCtD@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z3xKTKkVSf7tWCtD@google.com>

On Mon, Jan 06, 2025 at 01:25:32PM -0800, Namhyung Kim wrote:
> On Fri, Dec 27, 2024 at 04:18:32PM +0530, Athira Rajeev wrote:
> > 
> > 
> > > On 23 Dec 2024, at 7:28 PM, Athira Rajeev <atrajeev@linux.vnet.ibm.com> wrote:
> > > 
> > > When kernel is built without debuginfo, running perf record with
> > > --off-cpu results in segfault as below:
> > > 
> > >   ./perf record --off-cpu -e dummy sleep 1
> > >   libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?
> > >   libbpf: failed to find '.BTF' ELF section in /lib/modules/6.13.0-rc3+/build/vmlinux
> > >   libbpf: failed to find valid kernel BTF
> > >   Segmentation fault (core dumped)
> > > 
> > > The backtrace pointed to:
> > > 
> > >   #0  0x00000000100fb17c in btf.type_cnt ()
> > >   #1  0x00000000100fc1a8 in btf_find_by_name_kind ()
> > >   #2  0x00000000100fc38c in btf.find_by_name_kind ()
> > >   #3  0x00000000102ee3ac in off_cpu_prepare ()
> > >   #4  0x000000001002f78c in cmd_record ()
> > >   #5  0x00000000100aee78 in run_builtin ()
> > >   #6  0x00000000100af3e4 in handle_internal_command ()
> > >   #7  0x000000001001004c in main ()
> > > 
> > > Code sequence is:
> > >   static void check_sched_switch_args(void)
> > >   {
> > >        struct btf *btf = btf__load_vmlinux_btf();
> > >        const struct btf_type *t1, *t2, *t3;
> > >        u32 type_id;
> > > 
> > >        type_id = btf__find_by_name_kind(btf, "btf_trace_sched_switch",
> > >                                         BTF_KIND_TYPEDEF);
> > > 
> > > btf__load_vmlinux_btf fails when CONFIG_DEBUG_INFO_BTF is not enabled.
> > > Here bpf__find_by_name_kind calls btf__type_cnt with NULL btf
> > > value and results in segfault. To fix this, add a check to see if
> > > btf is not NULL before invoking bpf__find_by_name_kind
> > > 
> > > Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> 
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next,

- Arnaldo
