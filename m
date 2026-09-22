Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C1153D9FE
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080417; cv=none; b=MHLZgX1KsmxMLhbYdft4c3rnwVzhl5yUuOpQVIZ6mnqNbVbFCyTHhzJxETFIpDVUdMV8hK4Th+K6ZVxuuPUpmNv0RaztnuE6apk6RhAHZle3FwyCvovNrupiM6bsC2J2QkY+Wu+kXK/HD/2C9ErbujA/qbS7uyKvQeSFH9q+Z84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080417; c=relaxed/simple;
	bh=x/+joVG3ajGntCgo5A0FbrA/pwu6z1r6YO6QTI17nvw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bGKoV4oHDEWCN81XUsdnNMrZ3CcMoVemUgYbCK7/2BeOovaY188B8+xxg5loxFik/kHIdLBPNzPCnA0XbvXNX7oF2Af9hOzcDf960KwKwiC9qLWeKgq7V3WFvBnYbgYsGnhayinfP8yIhiIJVb8LIDuXZa9yYb+QmOm7HQ51Bu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMHSQPQ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMHSQPQ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880441F000FF;
	Tue, 22 Sep 2026 12:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790080415;
	bh=MxjPNcaXjFkS3vnl95W/B+TeM3s/6q6834nxfafBdmU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NMHSQPQ1aycp7VmgcnErY0t7P0aNEZjSpHEeJXh8BV5ui7WVTK1G3pESvtxvu7fhD
	 uilRwtu4tEpeNSyHgKEcNNsxit0LuMrHyEWlW8F5yHNPWGsrq+G3othklQ/FZfpd5E
	 tKzZONYxnDq8/Qc5svzcvlXrEfmThC/zzuUQZGVYyDIxUQ9N9584vYe0tIprfTp8G+
	 2eex3eVMd461EUUU92olvfwtoCaTLffmWoyGW9VswN/Pcc8KlQMfDCXyRs9LF7Utjp
	 AF3FyHR4+Ddfl/j4SA+NIGZH8qH5+5wlyA2MEUiVlXo6+Ek1tW2u3blWRypdcxaNLj
	 bkIHaUiVCmD6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/7] perf annotate-data: Show the sample count in the
 data-type browser
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260922122623.1029132-6-acme@kernel.org>
References: <20260922122623.1029132-1-acme@kernel.org>
 <20260922122623.1029132-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 12:33:35 +0000
Message-Id: <20260922123335.880441F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The samples view (-n, annotate.show_nr_samples) prints a local
> nr_samples variable that is initialized to zero and never updated, so
> every member is listed as having no samples while the period and percent
> columns for the same entry are filled in.  Print the histogram entry's
> own count instead.
>=20
> Fixes: d001c7a7f4736743 ("perf annotate-data: Add hist_entry__annotate_da=
ta_tui()")
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922122623.1029=
132-1-acme@kernel.org?part=3D5

