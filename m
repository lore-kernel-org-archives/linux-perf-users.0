Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D728298991;
	Wed,  1 Jul 2026 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916309; cv=none; b=EOnkpXMdQMNw35o06G9AXJbkDKYSa5eYPnEjkNHRpdYg/nD1mCVHJBc52mdTOk7+LncWGGyGxOiiHbybQro1qFTsTSSndJAicS5EUsvmJQUZeXtD+g+mZ4AwE9ZSZQBNiVuDH5yA2n65UXRcNXb9OXziFY5oA+HVz/F788ypkC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916309; c=relaxed/simple;
	bh=hmw/JmklP6CDbven6Y9I9PsyLGXLEKUCPS58Zc+R+1o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Tdnh/iSwNmIs+by5ntqo7+jN/f6JBEnU8Z5s+pqgGzvnJCKLc/WHLOZ4aCn5HIS5jVAX5ydCwXEbZENJ0ZKbpF6f/s3u9+QNFGPsdh4ikD0YCsw9/6zrrOaTaWXvZHFrDGZyW4v+ssWtdaNQypeydfoKIQiwcGOO0OpWLPohYFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ax/RCP8/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ax/RCP8/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4811F000E9;
	Wed,  1 Jul 2026 14:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782916308;
	bh=BSv9yPYteER3Khd6NhAoVMHEZQola5XM3jfHLGD4hPA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ax/RCP8/ydjSA3v73k4p2lrdbCbGbkjusxe+CEMUeAPPIOtT4qGcCAtcHTvBYUDep
	 9PPs5RzBYMwJH6kDxnZ4Z3X2uBVaNddQhWN30D5giAVW1RVqh7nktwDOJaXcipar6i
	 yhET/a/M0LdLD2XOQQ12yGDMxzj6TvxdfNc5ZQnj3ppwY11kl14vyA2wOkgF5UKY9g
	 gsDcJ3l+TcxS+qyyLw7axIwSkCPjLY2TB+ANzznwvDmNJHZfWf/UVyYnZlqeiBIsnL
	 KPPazjwQYyTYR0AH3xnhYjoJMe5GBb+y+8VuNAQnmQmVIo2tvbW/OGubzou5rGhNk1
	 Coy6DZuZvaGkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf: record: Clear BPF headers if not needed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mayuresh Chitale" <mayuresh.chitale@oss.qualcomm.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260701141347.4098670-1-mayuresh.chitale@oss.qualcomm.com>
References: <20260701141347.4098670-1-mayuresh.chitale@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 14:31:47 +0000
Message-Id: <20260701143148.0B4811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch conditionally clears BPF header features based on `rec=
->opts.no_bpf_event` too early in `record__init_features()`, failing to fix=
 the spurious error messages for default and dynamically evaluated cases wh=
en `perf` is compiled without `libbpf`.
--

commit 9515d1b27d6dcc9884718d4505a8cf399d665c9e
Author: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>

perf: record: Clear BPF headers if not needed

This patch clears the HEADER_BPF_PROG_INFO and HEADER_BPF_BTF bits from the
file header feature bitmask when the '--no-bpf-event' flag is passed. This
aims to prevent spurious error messages about missing libbpf support when
writing perf data.

> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index e915390556752..692ab7138d2c3 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1829,6 +1829,11 @@ static void record__init_features(struct record *r=
ec)
>  	if (!record__comp_enabled(rec))
>  		perf_header__clear_feat(&session->header, HEADER_COMPRESSED);
> =20
> +	if (rec->opts.no_bpf_event) {
> +		perf_header__clear_feat(&session->header, HEADER_BPF_PROG_INFO);
> +		perf_header__clear_feat(&session->header, HEADER_BPF_BTF);
> +	}
> +

[Severity: Medium]
Does this conditionally clear the features too early in the initialization
process?

If the user does not explicitly pass the flag (the default case), or if the
flag is dynamically updated to true later (e.g. if updated after checking
!evlist__needs_bpf_sb_event(rec->evlist)), this condition will evaluate to
false.

Will this leave the spurious errors unresolved for default and dynamically
evaluated cases when perf is compiled without libbpf?

>  	perf_header__clear_feat(&session->header, HEADER_STAT);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701141347.4098=
670-1-mayuresh.chitale@oss.qualcomm.com?part=3D1
