Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795074670;
	b=zaL1jlgrMErMruJt3xAzCaBh+xvdfAGNSacrYLV5ERfCV1bX7sd59bGtCSCoP+zJiL6T
	 slC5h/fsNn7o/yE5vAx6Y+CCrudRYjpjfy6pzDpafZ8H2eiVW/cmgHThSvT+EexVeimGo
	 slHfQOxBPWdphGMy68I24/L6QLnyNkVprgt0Et1VHqcUBV2ABEiDssFYN/mEUBg9mn9+k
	 VWo/JI7JGxkbMCJfH1Q7ebgctxdtcSpInjD1lhZUEaaPzl75uh08rf317/2EzKWoTfPOY
	 C8NQEdl/eJ9s0Nx577ykH/iV0zOiV6CvD07l/SufBSfLmu/CVLbRtFxU37zoDE4HcOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795074670;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=AA8EaKSyD6J0aM0Ck4haMxWs7V7GTUR80XEI81xWqug=;
	b=n2syty5YMZjFSlhsib9TmPcL7h49ljRMGE31TFq7Yb6mkdQaFtLk/v9py/hrKcSKmQ8X
	 QIKhKmzvjaxlw472n7d2AG110INOsStA4x7WAx/CJAi0aqXKK4F3ygcEQWQFbhIa4fbYu
	 /XJ3tPOfq9M9xXoH1y0BTm+TF0YtBPlkDnBBEc7FS2zAzukNc9aNdq9gHWAxpu5EB8VHf
	 SLE9zbKeXgZgnnkVp13T2dOJWR3/0+pPIE58+wTYi40h+/5ALVosTGn3nFw6AAdaAwpaI
	 5RyRw2qpDBqXWuR1XVAl3jNS5H1luZw2QRV5wQ/RLNPWk5ETNXC2ZBlEGGeVRwflq8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fRRpkaok;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FFA606A320;
	Thu, 19 Nov 2026 07:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fRRpkaok
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F9D1F000C4;
	Thu, 19 Nov 2026 07:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795074669;
	bh=AA8EaKSyD6J0aM0Ck4haMxWs7V7GTUR80XEI81xWqug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fRRpkaokMlRnqm+ceQnPDZ9mvUBUZrLCFJ6hR1JNyMEDNDlm6JuumXhb0YRIrDH+v
	 luMgVuC7VcTG40lr9CA6K5Ck0njdG6DtVpnaj3pca2fYzzxfshRSR4LOokTq0MYzoJ
	 933fpGRRuQVBYYPOb2e/03XL/NSlCso+mCN0exEGLbhS2YifjrkIv3OmoDxU5uIzaj
	 ROKbhMkpmtmB4qKJiJX3F+N0I39fp62nzIV73SP2Fzno6utTx3YH1MS5KNLHV9O3uL
	 kLsqnyf7rPlfeMwNTozAetpcLj8DNhc9P1KY1McJaKGNX/Ie69xsR0JofDml1rhxOx
	 2eVOF/8JlTJlQ==
Date: Wed, 18 Nov 2026 23:51:08 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Gu Bin <gubin@cmss.chinamobile.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf trace: guard free(new_filter) to avoid double-free
 on OOM
Message-ID: <av6qbBy6Zkq1PiQ1@google.com>
References: <20261112031810.1899-1-gubin@cmss.chinamobile.com>
 <sashiko-outbox-210269@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-210269@kernel.org>

On Thu, Nov 12, 2026 at 03:25:15AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found no new issues
> in this patch, but noticed 1 related pre-existing issue it does not
> introduce:
> - [Medium] perf trace: unhandled -ENOMEM in trace__expand_filter() [1]
> --
> 
> commit e8aa93f0bab0450d21dc93c231c980b9474cb264
> Author: Gu Bin <gubin@cmss.chinamobile.com>
> 
> perf trace: guard free(new_filter) to avoid double-free on OOM
> 
> This commit guards free(new_filter) on the asprintf() failure path in
> trace__expand_filter() so that evsel->filter is not freed when new_filter
> still aliases it.
> 
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 4094141461f91..f4a67491f5be1 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -4679,7 +4679,8 @@ static int trace__expand_filter(struct trace *trace, struct evsel *evsel)
> >  
> >  					if (asprintf(&n, "%.*s%s%s", expansion_offset, new_filter, expansion, right_end) < 0) {
> >  						pr_debug(" out of memory!\n");
> > -						free(new_filter);
> > +						if (new_filter != evsel->filter)
> > +							free(new_filter);
> >  						return -1;
> >  					}
> >  					if (new_filter != evsel->filter)
> 
> [Severity: Medium]
> This problem wasn't introduced by this patch, but at the end of
> trace__expand_filter(), should the return value of evsel__set_filter() be
> checked [1]?

Yep, this is a separate issue.  I think it's ok to take this patch as
is.

Gu, are you willing to fix the reported problem too?

Thanks,
Namhyung

> 
> tools/perf/builtin-trace.c:trace__expand_filter() {
> 	...
> 	if (new_filter != evsel->filter) {
> 		pr_debug("New filter for %s: %s\n", evsel->name, new_filter);
> 		evsel__set_filter(evsel, new_filter);
> 		free(new_filter);
> 	}
> 
> 	return 0;
> }
> 
> If strdup() inside evsel__set_filter() fails with -ENOMEM, the failure is
> silently ignored and trace__expand_filter() returns 0, leaving the
> unexpanded filter in place.
> 
> [1] https://sashiko.dev/#/bug/linux-cbf4bb01-a981-47dc-b440-68e5c9c3e81c
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261112031810.1899-1-gubin@cmss.chinamobile.com?part=1
