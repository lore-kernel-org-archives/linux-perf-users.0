Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089961DF983;
	Mon,  6 Jan 2025 21:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736198735; cv=none; b=NXWjBh2b/zr/Sh89G2F49AFOO4YKV/pmN++XsuHq7ZY4rwf87+oQhbu6aYhPhX3IRq6fcMx4tomfHjez4wlMis386W4Kwamtgif1IXGg2t8T//deumWNsqyLHAl6Vw5vN8sSMfiNkRDDby2KkCpAjZz8DKbnsSQQhb3YDP4xN44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736198735; c=relaxed/simple;
	bh=hi1GMaWRkgQ+46UxxVoQ3+2NmjCT2Y5rvyleUJPSy0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxFzJVHJ9L7xXFJ3bgQ0hQsazIfNYF8dpVkT7wuVgBFQcb2X2Zqa5Rub1Rv0/XVi0GP94zoYn9LfzTbdzSNKyX9Ieg50iS0kEUaxdvqT63977lyF5qi671dkNWIlasT0hK2fZj1V4J0Tbzp8JjbOhsiasoTeVAPx9CsuzEXLM60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2gJQqCa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2gJQqCa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09358C4CED2;
	Mon,  6 Jan 2025 21:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736198734;
	bh=hi1GMaWRkgQ+46UxxVoQ3+2NmjCT2Y5rvyleUJPSy0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t2gJQqCaXjOVITG6+z2iI7AUZ1q5sJ+NaMpfM3nks3w42avbACcCaVuKGG3FHpMIh
	 KYlNRBYYYaI/yo6n7bRcgAq6Y3gG5nHBPtYVqos9+Wy9SKm33PIsfSxH+jdR4XRRBr
	 iBGGzgGEHcu/P9d1VClrMQTt7A/pdbnXXtKQgXx4clkCemiw5GTjmslFlnhn8dXa+h
	 fDWN3c/07GcMYEm8e5pVo64g1G1SRNVX6xqmNrNgafudSHv5ZxITmop66fOJj7ANGP
	 8+UsNNDKVsY7jszAY4G96rzt+fMn5XM+jJPhirQHDTQaEwJJgynY1hNkPSUV62OLsI
	 98oAfaD4qAV1A==
Date: Mon, 6 Jan 2025 13:25:32 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	irogers@google.com, hbathini@linux.ibm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
	kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH] tools/perf: Fix segfault during perf record --off-cpu
 when debuginfo is not enabled
Message-ID: <Z3xKTKkVSf7tWCtD@google.com>
References: <20241223135813.8175-1-atrajeev@linux.vnet.ibm.com>
 <409D0233-93FF-40D6-BC2E-B7625E4E1B97@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <409D0233-93FF-40D6-BC2E-B7625E4E1B97@linux.vnet.ibm.com>

On Fri, Dec 27, 2024 at 04:18:32PM +0530, Athira Rajeev wrote:
> 
> 
> > On 23 Dec 2024, at 7:28 PM, Athira Rajeev <atrajeev@linux.vnet.ibm.com> wrote:
> > 
> > When kernel is built without debuginfo, running perf record with
> > --off-cpu results in segfault as below:
> > 
> >   ./perf record --off-cpu -e dummy sleep 1
> >   libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?
> >   libbpf: failed to find '.BTF' ELF section in /lib/modules/6.13.0-rc3+/build/vmlinux
> >   libbpf: failed to find valid kernel BTF
> >   Segmentation fault (core dumped)
> > 
> > The backtrace pointed to:
> > 
> >   #0  0x00000000100fb17c in btf.type_cnt ()
> >   #1  0x00000000100fc1a8 in btf_find_by_name_kind ()
> >   #2  0x00000000100fc38c in btf.find_by_name_kind ()
> >   #3  0x00000000102ee3ac in off_cpu_prepare ()
> >   #4  0x000000001002f78c in cmd_record ()
> >   #5  0x00000000100aee78 in run_builtin ()
> >   #6  0x00000000100af3e4 in handle_internal_command ()
> >   #7  0x000000001001004c in main ()
> > 
> > Code sequence is:
> >   static void check_sched_switch_args(void)
> >   {
> >        struct btf *btf = btf__load_vmlinux_btf();
> >        const struct btf_type *t1, *t2, *t3;
> >        u32 type_id;
> > 
> >        type_id = btf__find_by_name_kind(btf, "btf_trace_sched_switch",
> >                                         BTF_KIND_TYPEDEF);
> > 
> > btf__load_vmlinux_btf fails when CONFIG_DEBUG_INFO_BTF is not enabled.
> > Here bpf__find_by_name_kind calls btf__type_cnt with NULL btf
> > value and results in segfault. To fix this, add a check to see if
> > btf is not NULL before invoking bpf__find_by_name_kind
> > 
> > Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> > ---
> > tools/perf/util/bpf_off_cpu.c | 5 +++++
> > 1 file changed, 5 insertions(+)
> > 
> > diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
> > index a590a8ac1f9d..4269b41d1771 100644
> > --- a/tools/perf/util/bpf_off_cpu.c
> > +++ b/tools/perf/util/bpf_off_cpu.c
> > @@ -100,6 +100,11 @@ static void check_sched_switch_args(void)
> > const struct btf_type *t1, *t2, *t3;
> > u32 type_id;
> > 
> > + if (!btf) {
> > + pr_debug("Missing btf, check if CONFIG_DEBUG_INFO_BTF is enabled\n");
> > + goto cleanup;
> > + }
> > +
> 
> Hi,
> 
> Looking for review comments on this
> 
> Athira
> > type_id = btf__find_by_name_kind(btf, "btf_trace_sched_switch",
> > BTF_KIND_TYPEDEF);
> > if ((s32)type_id < 0)
> > -- 
> > 2.43.5
> > 
> 
