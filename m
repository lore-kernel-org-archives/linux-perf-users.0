Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795476820;
	b=Es3q9SQ8EdH0ebfNBLaBaqU8PgWKDL8q4ACTasXuz36AHgac2AShUkhdx43ts6oIiw6p
	 hz6XIu9SucypYzxxfsHtZF/0ge4YeYEc0hVhzp0PTzRtlrK0Yj+2hxe1F8HZbnqUlh0sx
	 mi56XaCs8IU0raARjgqnISYBmiXCrYsSgttgZTXKBK5w163mc6wmpA53tm+NwzPOvQoW5
	 dpMeXlIyaFGh7rcXYtbFqSsr56YUnvW6+5o3UiRqUEAqEOBuhS6/5frSfHdmORqCNJ2ve
	 3dArXtYfBNH3pa6t3QNkOuPt3VSU7wUSrfsACdrg4oJ6f22dbOXbC5rZDtxqJ9NZ+Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795476820;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ipWK6H3RcLD94bD7s5tKLPPowwMtqr/+GuY64lW9Ip8=;
	b=AhOiohGXBCFeh6JMhA0TIhYqoL+xaXnPP2L87yRAJ3TfkmVUIUgL8ltUBeVAGcxKmaEb
	 3P0QHQbDjBlb7Bm6YnWieruQMR4kcth+OsCeFd1dLLK2cgI696UWo3W8ilJc2a8DPund6
	 wgK/KwGtZVsNe6/dBf+sbl2rfFz4z2Yhs4Kf2zkC86uDBeyPgAc2hNz8sbwYS7vAv11jO
	 PcUFa2QBhfU+1X26smLmjIICogVu47sto1vBfBF1fBUsKdHWpYdpBGU0MxW1M7YlTN845
	 x3nfcYjgstjZ2i6p8NnYPPyOky4zUfryVNcVfohhf4JWG40d1SNBiLGNbhVr6ORbI8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UDv+Cuwf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD5F606A31E
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 23:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UDv+Cuwf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9138E1F000C6;
	Mon, 23 Nov 2026 23:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795476819;
	bh=ipWK6H3RcLD94bD7s5tKLPPowwMtqr/+GuY64lW9Ip8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UDv+CuwfX8gDJVcgK2ILWTdoLCNaE6Aasxn08u1chLyZL1iQnz7wqhlxCjvFFLtrW
	 0J4qGQcFuCt4ksnGDs9yNRXLJ7cmbOcpUT+ZOstjO+7/QLOsCve6/eE0JfDQiy95Ih
	 q9aeJRJLJblHW8I+X9zXz5b9K6MsOX5UKchbSWpHr2+rDlI0JXp+qGI6p4S54kxBF0
	 VPv+qFRkWngUwHFMmDLbvbB3XB5iX7SrZwpV0aKebTtsf8GVlRBG1+b/juA9Ne0gS+
	 qrlmoz0CWU5GVCMC8P2TmaI9eKj+cKwuAa6atgHmmPh2UOg9dONGB14cq9ICxfO87l
	 cLKNhutWTUgSg==
Message-ID: <sashiko-outbox-230212@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/11] perf tests: Add namespace, nsinfo, and boot ID
 tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261123232025.1406560-12-namhyung@kernel.org>
References: <20261123232025.1406560-1-namhyung@kernel.org>
 <20261123232025.1406560-12-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 23:33:39 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] perf tests: leaked thread ref on failure in
  test__nsinfo_thread_liveness()
--

commit bd9ea809a4bbf37b8dd8dcc52bfc3183504775fe
Author: Namhyung Kim <namhyung@kernel.org>

perf tests: Add namespace, nsinfo, and boot ID tests

This commit adds a namespace and nsinfo unit test suite and extends the
header and pipe shell tests to verify boot ID handling.

> diff --git a/tools/perf/tests/namespaces.c b/tools/perf/tests/namespaces.c
> new file mode 100644
> index 0000000000000..2e332c333960e
> --- /dev/null
> +++ b/tools/perf/tests/namespaces.c
[ ... ]
> +static int test__nsinfo_thread_liveness(struct test_suite *test __maybe_=
unused,
> +					int subtest __maybe_unused)
> +{
[ ... ]
> +	machine__remove_thread(off_m, off_th);
> +	thread__put(off_th);
> +	off_th =3D NULL;
> +
> +	thread__e_machine_endian(off_sub, off_m, NULL, NULL);
> +	if (machine__find_thread(off_m, self_pid, self_pid) !=3D NULL) {
> +		pr_debug("thread__e_machine_endian() unexpectedly recreated exited lea=
der\n");
> +		goto out;
> +	}

[Severity: Low]
Does this leak a struct thread reference if the check fails?
machine__find_thread() returns a refcounted pointer that must be released
with thread__put(), so assigning the result to off_th (as done with th in
the later perf_event__exit_del_thread() check) would let thread__put(off_th)
at the out label release it on failure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123232025.1406=
560-1-namhyung@kernel.org?part=3D11
