Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F6738DC72
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404526; cv=none; b=nmo5rLVbng1lHVeuaByOaAGWjeWZfgXbckC1rmvrDGuji7gVQSYwZgrA7IvgvftchZRDoUJjnqPdf7L9gx+Tqf9FQyfb1aIuhSoei1X37t0n44Vt199AsCu0F9GNk3KZoWs0kj7WOA1VMl3BCYS7ze8+/iJDTvD88FcWCof+VyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404526; c=relaxed/simple;
	bh=aBrcmwefAJShINwZHTQzKI/VhZ/XszCo08yr12DV/64=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=clg1y4jGceg2yObFgRsHRjP8jJDtG4rGGzDBIjzpT+5fVwGS+D+VpKmwE8icP7rDy0Q359GkPUfFgYUZciv2xyZBfwQWSuReI4YKllnFak/J73HDYrggY2r9agq5YSh4sE/fySWjsZoVmAL0LaaaUDXcbTg5NsKzqv0zpBud5bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9aB3WGK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9aB3WGK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D551F000FF;
	Sat, 26 Sep 2026 06:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404524;
	bh=TDRwddtR6PYcp4qSiNGUnbmCKc4auV37cuq369wFFO8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H9aB3WGKxSCA5a60rsi0M8rSBo0fJy+l8KLNwuB1pxWOGl0CeV81J081M6EDa23AY
	 CqDCilrPay/Pewcwzc5q1WF7bN/zjN0xPoxT2vkBPr8PzK4vqYXRF//o+zV8qyA+k6
	 iQUg7jCuP0G7COM/akO6RUz+JWc7TIsvt+YgLyDHx749cIX83lxnryjZcgeoKD3iX4
	 sStxDqIsNa7CByD7cuW64GJkq427uJziv5GckhjGyHz2eBgoaW/Ezpjuq/GSeiEPNl
	 lxITwbzLV7BOZSJnsRiMUSG42TPpbr0Qn5ygteHwqD52ENxapIZmvoOS62wodPpfv8
	 C/A/F6wex0GLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/49] perf python: Add Intel PT call_return and
 itrace capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-10-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:35:23 +0000
Message-Id: <20260926063523.E1D551F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add support for Intel PT call_return events and itrace options to the
> perf Python extension so standalone Python scripts can decode and
> inspect low-level instruction traces.
>=20
> Specifically:
> - Add a call_return callback parameter and itrace option string to
>   perf.session, treating explicit None (Py_None) callbacks as omitted.
> - Expose the perf.call_return object with db_id, parent_id, insn_count,
>   cyc_count, comm, pid, tid, call_time, return_time, branch_count,
>   call_ref, return_ref, flags, and call_path (resolved as a
>   perf.callchain ordered from outermost caller to callee, populating
>   frame->map and frame->sym so call_path entries expose resolved symbol
>   and DSO names).
> - Export perf.CALL_RETURN_NO_CALL, perf.CALL_RETURN_NO_RETURN, and
>   perf.CALL_RETURN_NON_CALL flag constants.
> - Expose session.e_machine and session.is_64_bit properties, preferring
>   recorded thread ELF machines (perf_session__e_machine) over perf_env
>   so pipe-mode traces do not prematurely cache host bitness.
> - Support optional vmlinux, kallsyms, and symfs symbol configuration
>   parameters (and PERF_SYMBOL_VMLINUX, PERF_SYMBOL_KALLSYMS,
>   PERF_SYMBOL_SYMFS environment fallbacks) in perf.session, resetting
>   symbol_conf pointers and freeing vm_tm_corr_args, cpu_bitmap, and
>   ptime_range in pyrf_session__delete().
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D9

