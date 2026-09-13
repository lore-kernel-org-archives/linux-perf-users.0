Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1560376BC1
	for <linux-perf-users@vger.kernel.org>; Sun, 13 Sep 2026 02:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789268001; cv=none; b=hUbA++CfpzBUYdBsDDpMbAC6V8F97o5u9OR684HxaMpdAvGogAjxJgSQaKdysWcKE3xvIE8mqG7k0Jz0y02Gof6yLvvgK8qzK9mrS1rZl1+gr0M+E9WzjQcIOIpmw9fxPZfj6Hy/EAIRRfEBOiT7ryvPYxVTlMbGurOXwad26x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789268001; c=relaxed/simple;
	bh=kfEjXAipj6qApeJqKavy8rIsfuxdUkbJpurX6RC/BdY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aMEfKq2ayNmZGITGTF1pR2eA26uNpzTX4xhBWo1Xekba5j4uxhpR6SpsLXVczJaOdchqxRGCaMleifgkZ+nhAIar8V2gDvIT/qKXKRrl9UdnxSYnDJsiH/42MGcKVx6t9nTip7IZ5cLn4hF9JuPa1ZK4sYWdm61Vk1voA5bKbgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i40rfMJH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i40rfMJH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A3A1F000FF;
	Sun, 13 Sep 2026 02:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789268000;
	bh=IJTyFAKYEZNqFtC13ZfQqHmm+qOrhcthpm6Sgn7IVMo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i40rfMJHOLJPvPLBV33DMv5QHbzUtLQKrg7+fb30jO1XfNczLTFWf+3rDtgEaXiAd
	 kow34zN+UXHg2yHFRuzdVhfhNIpDuH6lOxkOBONk2PdRExew1pibn7qpFntitNYAfK
	 uQdJzKPvJhqaaj/annsV0U7mF+isNSDOmhjIPLdie7/svwj6hSKL5JHi1NcjVNj0nj
	 s8erpvTuysd6cGCzHmPFN160gAWykHtDRsecgP52ObQYOULYfKofLBpRUKE9eJcB7g
	 O+bBVEH9NExH6F4ZhqcciqclobhQV0tbZTdSvXISbw8/h7Wbi0ktqZejvpVWqoqB4e
	 3Qhoqkbsg/IVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 8/8] perf mem record: Request PERF_SAMPLE_CPU by
 default
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260913023459.112654-9-acme@kernel.org>
References: <20260913023459.112654-1-acme@kernel.org>
 <20260913023459.112654-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 02:53:19 +0000
Message-Id: <20260913025320.24A3A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Insufficient allocation for `rec_argv` array in `__cmd_record` cau=
ses a heap buffer overflow.
- [High] Stack buffer overflow in `get_sort_order` due to unsafe `strcat` c=
alls after a bounded `scnprintf`.
- [Medium] Missing `.feature` event callback in `perf_tool` during pipe mod=
e raw event processing.
- [Medium] Memory and reference count leak of `cpu_map` on error paths in `=
perf_mem_events__record_args`.
--

commit a9d649273551560b359198abf2d0080276d35896
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf mem record: Request PERF_SAMPLE_CPU by default
   =20
The data-type profiling per-sample stream requires PERF_SAMPLE_CPU to=20
distinguish reads and writes from different cores. This patch modifies perf=
=20
mem record to request the CPU id by default by passing the --sample-cpu=20
option.

> diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
> index 6101a26b3a781..a708e2549bae4 100644
> --- a/tools/perf/builtin-mem.c
> +++ b/tools/perf/builtin-mem.c
[ ... ]
> @@ -135,6 +135,15 @@ static int __cmd_record(int argc, const char **argv,=
 struct perf_mem *mem,
> =20
>  	rec_argv[i++] =3D "-d";
> =20
> +	/*
> +	 * The data-type profiling per-sample stream keys cross-CPU
> +	 * contention on sample->cpu (PERF_SAMPLE_CPU); without it the cpu
> +	 * field is the (u32)-1 'no CPU info' sentinel and same-instance
> +	 * reads and writes from different cores are indistinguishable
> +	 * from same-CPU traffic.
> +	 */
> +	rec_argv[i++] =3D "--sample-cpu";
> +

[Severity: High]
This isn't a bug introduced by this patch, but doesn't adding this=20
unconditional argument worsen a heap buffer overflow in rec_argv?

In __cmd_record(), the rec_argv array is allocated using this formula:

	/* Max number of arguments multiplied by number of PMUs that can support t=
hem. */
	rec_argc =3D argc + 9 * (perf_pmu__mem_events_num_mem_pmus(pmu) + 1);

	if (mem->cpu_list)
		rec_argc +=3D 2;

	rec_argv =3D calloc(rec_argc + 1, sizeof(char *));

This calculation doesn't seem to account for all statically and dynamically=
=20
appended options. When combining optional flags (like --phys-data,=20
--data-page-size, --all-kernel) and discovering one or more PMUs supporting=
=20
memory events, could the unconditionally written base arguments (which now=
=20
includes the newly added --sample-cpu) exceed the rec_argc capacity and=20
corrupt heap memory?


While reviewing this code, I also noticed a few other pre-existing issues i=
n=20
related code:

[Severity: Medium]
This is a pre-existing issue, but does report_raw_events() in=20
tools/perf/builtin-mem.c omit the .feature callback during perf_tool=20
initialization?

tools/perf/builtin-mem.c:report_raw_events() {
	...
	perf_tool__init(&mem->tool, /*ordered_events=3D*/true);
	mem->tool.sample		=3D process_sample_event;
	mem->tool.mmap		=3D perf_event__process_mmap;
	mem->tool.mmap2		=3D perf_event__process_mmap2;
	mem->tool.comm		=3D perf_event__process_comm;
	mem->tool.lost		=3D perf_event__process_lost;
	mem->tool.fork		=3D perf_event__process_fork;
	mem->tool.attr		=3D perf_event__process_attr;
	mem->tool.build_id	=3D perf_event__process_build_id;
	mem->tool.namespaces	=3D perf_event__process_namespaces;
	mem->tool.auxtrace_info  =3D perf_event__process_auxtrace_info;
	mem->tool.auxtrace       =3D perf_event__process_auxtrace;
	mem->tool.auxtrace_error =3D perf_event__process_auxtrace_error;
	...
}

Without mem->tool.feature =3D perf_event__process_feature;, does perf.data=
=20
environmental metadata (like CPU topologies and build features) fail to=20
synthesize in pipe mode streams, leaving struct perf_env unpopulated?


[Severity: Medium]
This is a pre-existing issue, but do the error paths in=20
perf_mem_events__record_args() leak the cpu_map allocation and reference=20
counts?

tools/perf/util/mem-events.c:perf_mem_events__record_args() {
	...
			if (!e->supported) {
				char buf[128];

				pr_err("failed: event '%s' not supported\n",
					perf_pmu__mem_events_name(pmu, j, buf, sizeof(buf)));
				free(event_name_storage);
				return -1;
			}
	...
			ret =3D perf_cpu_map__merge(&cpu_map, pmu->cpus);
			if (ret < 0) {
				free(event_name_storage);
				return ret;
			}
	...
}

If a subsequent PMU iteration encounters an unsupported event or fails=20
merging, do these error paths return directly without calling=20
perf_cpu_map__put() to drop the accumulated cpu_map reference?


[Severity: High]
This is a pre-existing issue, but can the strcat() calls in get_sort_order(=
)=20
overflow the stack buffer?

tools/perf/builtin-mem.c:get_sort_order() {
	char sort[128];

	if (mem->sort_key)
		scnprintf(sort, sizeof(sort), "--sort=3D%s", mem->sort_key);
	...
	if (mem->phys_addr)
		strcat(sort, ",phys_daddr");

	if (mem->data_page_size)
		strcat(sort, ",data_page_size");

	/* make sure it has 'type' sort key even -s option is used */
	if (mem->data_type && !strstr(sort, "type"))
		strcat(sort, ",type");
	...
}

If the user provides a custom sort key via -s or --sort that fills the=20
128-byte array up to the boundary checked by scnprintf(), do the subsequent=
=20
strcat() calls conditionally triggered by flags like --phys-data append byt=
es=20
blindly past the end of the array, causing stack memory corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913023459.1126=
54-1-acme@kernel.org?part=3D8
