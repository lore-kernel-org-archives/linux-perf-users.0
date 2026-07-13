Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BD437A839
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jul 2026 23:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783986894; cv=none; b=mfaaDGqFrK20ju2yVGjoHs72GvBUVPA3j3ql0rbF+zKuXiTyRMXVQdhOmZCBVE/eBh+tgxwft2TCLw/S8mvsFd+1c9fsOH1Oh1/vhEVKAe3dR0+7gatAOEVgM0aNv9GOpCJ7n5Zf7i4UuqOM0iErqnfHwQhMrj9UAHvVzHJFOCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783986894; c=relaxed/simple;
	bh=zEVVH3vwJ5FlQpmzaw7rFtcWQT2M2zoO7cQ6F+xuHPU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JpTHpQqJd3gGfx1LEIjTDWydpFzMHDyjVaThRxDdbLJdRbTzvlJ+g9HjLAT+LqO0oeb+72XcWAr62gbV2C+L2JAzTLAIqeV932ynf6BLZv+cjC8k52+E31qi/CHJlR/wvnhF+A91qBB/6xLX7/pVUz8TjRLbkIGGlz/eh8u/tYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eY7GpQs6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eY7GpQs6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912481F000E9;
	Mon, 13 Jul 2026 23:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783986892;
	bh=R35dSG2QLVyCaFiIuY6Trj+uMfPkLV+uVZbRKBdVZeM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eY7GpQs6ulFkGqhKgww+BrvCh6SiAGaKxGQkqoZ8gNS7LPFIVoHwwiUHVhY15SVd2
	 vYcbhNUxzbmuebhbFHpVgehCDQ2kd35LdVpukDASdH927ffGTzsXMjxl2VwnFnl6Ij
	 fTfGyaqXQiHJt/dJoMfBfLbGkGE8OEGKH4JfAN/tVJOwG3C2IZyxcmG9qg7Ew//yyj
	 DLZsmivkaGWtH0A1UymVjmVz9c1pLqo66Ib5FXj2M3Jz95XrWSeQ0fCrucALdvvDmb
	 I7mu4iXYggwPNlAKTPf2LR+rWp9HQ0/seQxR4pMlh7bjOekL7Si75pjNGpimN1HFJo
	 2dDTZA07nUpdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] perf sched: Fix memory leaks in perf sched stats
 report
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260713234536.2280374-3-namhyung@kernel.org>
References: <20260713234536.2280374-1-namhyung@kernel.org>
 <20260713234536.2280374-3-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 23:54:52 +0000
Message-Id: <20260713235452.912481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory corruption and NULL pointer dereference when processing an =
early PERF_RECORD_SCHEDSTAT_DOMAIN event.
- [High] Out-of-bounds memory access and crash during second-pass list iter=
ation due to missing bounds checks.
--

--- Patch [2]: [PATCH v2 2/3] perf sched: Fix memory leaks in perf sched st=
ats report ---
commit e4c15a9e591e133dd7ddf5965e12d5b6792f096e
Author: Namhyung Kim <namhyung@kernel.org>

perf sched: Fix memory leaks in perf sched stats report

The second pass data is not saved in the list and only used to calculate
delta from the first pass. This frees the data after use to prevent leaks.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -4626,11 +4626,13 @@ static int perf_sched__process_schedstat(const st=
ruct perf_tool *tool __maybe_un
>  			} else {
>  				cpu_second_pass =3D list_next_entry(cpu_second_pass, cpu_list);
>  			}

[Severity: High]
This is a pre-existing issue, but can this out-of-bounds iteration cause a
crash if a malformed perf.data file has more CPU events in the second pass
than the first pass?

If the iterator advances past the end of the list, it will point back to the
list head itself. The subsequent code would treat the list head as a valid
struct, read misaligned bytes as a pointer, and dereference it inside
store_schedstat_cpu_diff().

>  			domain_second_pass =3D list_first_entry(&cpu_second_pass->domain_head,
>  							      struct schedstat_domain, domain_list);
>  			store_schedstat_cpu_diff(temp);
> +			free(temp->cpu_data);
> +			free(temp);
>  		}
>  	} else if (event->header.type =3D=3D PERF_RECORD_SCHEDSTAT_DOMAIN) {
>  		struct schedstat_cpu *cpu_tail;
[ ... ]
> @@ -4647,10 +4649,12 @@ static int perf_sched__process_schedstat(const st=
ruct perf_tool *tool __maybe_un
>  		if (!after_workload_flag) {
>  			cpu_tail =3D list_last_entry(&cpu_head, struct schedstat_cpu, cpu_lis=
t);
>  			list_add_tail(&temp->domain_list, &cpu_tail->domain_head);

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for a
PERF_RECORD_SCHEDSTAT_DOMAIN event to arrive before any
PERF_RECORD_SCHEDSTAT_CPU event?

If the cpu_head list is empty, list_last_entry() evaluates to an invalid
pointer based off the list head offset. The subsequent list_add_tail() would
then access invalid memory when trying to link the elements.

>  		} else {
>  			store_schedstat_domain_diff(temp);
>  			domain_second_pass =3D list_next_entry(domain_second_pass, domain_lis=
t);

[Severity: High]
This is also a pre-existing issue, but similarly to the CPU list, does this
code risk an out-of-bounds access if the second pass has more DOMAIN events
than the first pass?

> +			free(temp->domain_data);
> +			free(temp);
>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713234536.2280=
374-1-namhyung@kernel.org?part=3D2
