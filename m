Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A5727E049
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 01:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789350137; cv=none; b=jeqpNBoB95fhw8KxIWnbe6cUaq0DBK9hp4ZonfcXjS4ghdl+6rXJf5GpU6UOj1xCMmrruQ8v4B42OLzS9zo0x7ehhWUGfafNx9hwMJa+bXRzkkwfMo2L2OKmKjQfGr3C9wYhAqzfSHTK120maESaTK8hw83sIb/0YAuZt8h8erM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789350137; c=relaxed/simple;
	bh=tVfmxalHfgzgvjyhis7ZEQDzlVjdczS/++M8VGqr8Fw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uBhOl3pGLTfzE5osMIFHLyhTQXRj3Mn5BQHg/n6/ch42Mor3LDsL6+h5boYiRoDTr/gegNQ8xlgzLYA0M1nHabd9FvATpLioTvi2sw45qFmieujW6bZwP9wtBcurTjBPzup3XjyLnXNste7re0c2VlN5NbWveJqI4TMimntGZoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bH7ZS9ou; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bH7ZS9ou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365131F000FF;
	Mon, 14 Sep 2026 01:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789350136;
	bh=tVfmxalHfgzgvjyhis7ZEQDzlVjdczS/++M8VGqr8Fw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bH7ZS9ouItJRNHq79wXNfUJ/YUcn9xa0Nw/LbmkvE+uNH9B5a3x7EiCTV/87vJZ4E
	 qJA1UExvy+LJufeE7vmHgiZS99onXhx9uM3XH/FkOgl0O3WGtijR0F2PIVefnmv8dr
	 S8H5htWVkWx2jaAX96IiIHkT2hht+ZaLMZ9kK5DAWzvlkP58UdEcvMeJWi4jbUbUIe
	 9vYoLTsE9F2EmuLuyKUjIebKZin+/FZJ6etQGRaeUsZRGdymFQkec0QCg4gsGPobP3
	 LSw3yL3nptMs5xoP9vaFf4kKzM71tJL797wHpo2eZ9cHOLAnXkT1qthgTV4XzvkTWa
	 wX3MrJRA8u8Yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] perf annotate-data: Show the sample count in the
 data-type browser
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914013604.7702-5-acme@kernel.org>
References: <20260914013604.7702-1-acme@kernel.org>
 <20260914013604.7702-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 01:42:15 +0000
Message-Id: <20260914014216.365131F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The data-type browser has a samples view, selected with -n (or with
> annotate.show_nr_samples), in which browser__write_overhead() prints a
> local nr_samples variable that is initialized to zero and never
> updated, so every member is listed as having no samples while the
> period and percent columns for the same entry are filled in.
>=20
> Print the histogram entry's own count instead.
>=20
> This predates the load/store counter split, so fix it ahead of that
> patch: the split then only has to adapt a line that is already correct,
> and this fix can be picked on its own.
>=20
> Fixes: d001c7a7f4736743 ("perf annotate-data: Add hist_entry__annotate_da=
ta_tui()")
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914013604.7702=
-1-acme@kernel.org?part=3D4

