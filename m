Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD9237DE84
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 23:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780701799; cv=none; b=hc8DmzLc627RGnzZiXupp8mRFLpIm6hZ7G99qWXIuWjIRIwiuZQLqoXjeJ9aFFwvwB+xnborAcQPVvvlUl8h80c9eNyiq27VMdJAjUIs1n4iSaAt3g1q0LfIhc4cddqPNd0PinZqpQhIWI73WTLgkF+Jttjxaav48th1N/tReUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780701799; c=relaxed/simple;
	bh=2NkFYgVEoDnmpaozQD0bFxukuRc+GZUnxIZjZgCdjew=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ai4UVpt+Ul1dgrJh+TqSe6ABhqgRhVFT8/VTOtSrk46gu7xt1Oo/FE2L5Rj3McuR1qZ54sTdrcODxDSGcnyEpFYXiXvsR9NuxnnKU+Ifzhpi97i/+80oENLI4PTIaHKstk2UZ6Zfioz9AGLOHMZMgcNNYPTIJTEDtfO2W5Uwhl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqodOnFA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqodOnFA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218551F00893;
	Fri,  5 Jun 2026 23:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780701798;
	bh=bNrdahGsaWLYaSv5SCALoOobO0lijSXUr297Y+Q7qxk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mqodOnFAdE2lpaRuHKriYyj5eJngXkCRiq59z11+q7gI2xv5MCd/x3qCcuMhV2fL9
	 FfcyblJ26x3QSX2nm7WUVTcg4urFfUQdchJTh/QFqQ/ZeR63jXQL5+9EjuaTdb+o9C
	 D7TJkZ0P3y5ujArJoCtsJEvj75J4rZo1KHi3tNal6RfbxGaGZAFJw7+pX3Kck34rf3
	 14yHpnTXwslGtJs2IVDGn3SOIpj5tziXbZn19lZxualTc71NXLKVGfoA3K4q4T7yst
	 ezN4NALA7yss7DKZ8HsRbHgbhScZ+uAmIyXCs4DXw2tRSLeRKfeNjbJxDwJYEU1Yre
	 UCtJ0G6bQ5IKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] perf timechart: Release event samples at the end
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605231155.2415760-2-namhyung@kernel.org>
References: <20260605231155.2415760-2-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 23:23:17 +0000
Message-Id: <20260605232318.218551F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Double-free of the `backtrace` string in `timechart__release()` du=
e to shared pointers across multiple `cpu_sample` objects.
--

commit 3e2b8bb6971b84cf83df8b57e574d558c36bdaf8
Author: Namhyung Kim <namhyung@kernel.org>

perf timechart: Release event samples at the end

This commit adds timechart__release() to clean up data structures created
during sample processing to prevent memory leaks when the perf tool exits.

> diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechar=
t.c
> index 28f33e39895d3..73a08236ac299 100644
> --- a/tools/perf/builtin-timechart.c
> +++ b/tools/perf/builtin-timechart.c
[ ... ]
> @@ -1509,6 +1509,59 @@ static void write_svg_file(struct timechart *tchar=
t, const char *filename)
>  	svg_close();
>  }
> =20
> +static void timechart__release(struct timechart *tchart)
> +{
> +	struct per_pid *p =3D tchart->all_data;
[ ... ]
> +		while (c) {
> +			struct per_pidcomm *next_comm =3D c->next;
> +			struct cpu_sample *cs =3D c->samples;
> +			struct io_sample *ios =3D c->io_samples;
> +
> +			while (cs) {
> +				struct cpu_sample *next =3D cs->next;
> +
> +				free((char *)cs->backtrace);
> +				free(cs);
> +				cs =3D next;
> +			}

[Severity: High]
Will this result in a double-free of the backtrace string?

Looking at sched_switch(), when a context switch occurs between two active
processes, it shares the exact same backtrace pointer across multiple
cpu_sample objects:

if (prev_p->current && prev_p->current->state !=3D TYPE_NONE)
	pid_put_sample(tchart, prev_pid, TYPE_RUNNING, cpu,
		       prev_p->current->state_since, timestamp,
		       backtrace);
if (p && p->current) {
	if (p->current->state !=3D TYPE_NONE)
		pid_put_sample(tchart, next_pid, p->current->state, cpu,
			       p->current->state_since, timestamp,
			       backtrace);

Because timechart__release() iterates over all processes and unconditionally
calls free() on cs->backtrace, won't it attempt to free the same pointer=20
multiple times when it cleans up these overlapping samples?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605231155.2415=
760-1-namhyung@kernel.org?part=3D1
