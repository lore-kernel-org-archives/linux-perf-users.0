Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6833D75A2
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882775; cv=none; b=MAKeDCuatx+ULzVo683RBZJpn8f1e+oyDc/uf3QmQ4Dk+mbgUYn5fwPtOx2m+XGZDywvi8Bo6rSnDBLxYwPphT6nWiaGH/jpxYm6WALvzjGHwhMlrH7g1h6+YD8u0sQLtBVFFsNLFP5rmOy5j1TymsgmAIdIAFNLULbD3zANzok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882775; c=relaxed/simple;
	bh=mObUh4/Hhz15SYpq0Knu1INbeMGqlPb2kKIU1zQK4wo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c+pbgNPjIz07pQ3dAeOACF+JuRbgQOdWmFikL04n1SfpuAqLfcnm033vtPc941mSeZHP7lt6OzTXD6Vy7CHdG1OfScZilrkKYOfnLbgZzQB5IL1i95Tfmb+Mcb5zovyD+EJOOnOtKtAT4Cm2sZbvXDjXOwnYAYumJRJSykuhjtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSNiGP2B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSNiGP2B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99891F000FF;
	Sun, 20 Sep 2026 05:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882772;
	bh=r0KcAywH8VHTs/V4miILqJiD7MKx0JmlQ+mAvNIlyWc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cSNiGP2B8wCcTL30lbyMBcFRre/Pnn3mMEPJbewpn8DvMZ5FQ9PKMy9C0eImaQv2W
	 xb75j8lvHRqRiBJg1oQLXCl18wSK811krcCGDwkjLvLQ7lgI6zOWO9dNdyf2a+fQov
	 nJFGiDmB5K7XSVLNzS01wSYr95qEo7hjUyDJvJ+yf0aoOuBON0GaydQ9I0I47tDftl
	 YioYcbL+lFoPe5QyBeOO/nYgJMq/Vq2Qbz0AXf7QumfynCRBKjXwSiZs9/xLIFXNcI
	 Gx7pxJzg3jqSVZKxZfLONse/BKR5Jd1Clo4CDkGVmDbjgNzkXS+EopfCy9uK3/X0Hx
	 l1r46EPaGioRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 36/49] perf python: Port netdev-times to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <79644055228b6065ab6c822895d29f81eb8c95b9.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <79644055228b6065ab6c822895d29f81eb8c95b9.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:39:32 +0000
Message-Id: <20260920053932.B99891F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: netdev-times drops softirq entries without packets
--

commit c6636c9bd9c585465111cf327e6ff4a6ca1d6bf2
Author: Ian Rogers <irogers@google.com>

perf python: Port netdev-times to perf module

This commit ports netdev-times.py to a standalone script in tools/perf/pyth=
on/,
converting it to use a NetDevTimesAnalyzer class with type annotations. It
replaces custom arg parsing with argparse and adds a shell test to verify t=
he
standalone script.

> diff --git a/tools/perf/python/netdev-times.py b/tools/perf/python/netdev=
-times.py
> new file mode 100755
> index 0000000000000..68f85bf890a00
> --- /dev/null
> +++ b/tools/perf/python/netdev-times.py

[ ... ]

> +    def handle_irq_softirq_exit(self, event: dict) -> None:
> +        """Handle irq:softirq_exit event."""
> +        time =3D event['time']
> +        cpu =3D event['cpu']
> +        irq_list =3D None
> +        event_list =3D None
> +        sirq_ent_t =3D None
> +
> +        if cpu in self.irq_dic:
> +            irq_list =3D self.irq_dic[cpu]
> +            del self.irq_dic[cpu]
> +        if cpu in self.net_rx_dic:
> +            sirq_ent_t =3D self.net_rx_dic[cpu]['sirq_ent_t']
> +            event_list =3D self.net_rx_dic[cpu]['event_list']
> +            del self.net_rx_dic[cpu]
> +        if not irq_list or not event_list or sirq_ent_t is None:
> +            return

[Severity: Medium]
Will this condition incorrectly drop valid softirq trace records when
event_list is empty?

When a NET_RX softirq runs but processes no packets, event_list evaluates to
an empty list []. Because `not []` evaluates to True in Python, this causes
the function to prematurely return and silently drop the receive hunk.

In the original script, the uninitialized variable was 0, so the check
correctly evaluated to False for [], allowing empty softirq executions to be
processed and printed. Should this check be updated to explicitly verify if
event_list is None rather than just evaluating its truthiness?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D36
