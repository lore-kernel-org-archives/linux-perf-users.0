Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768D41C3C00
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Jan 2025 13:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738329525; cv=none; b=A2fFcA8YiKPCMkEIFlKW+QfItQBM3LDBCQAshnu2tNtJGDbQq65bIiiFpTqLw9LAIQairvjhiXFJR3r78qXOaoqkdl0MnMhUFUgMnTjWkIe1RL7c0xTdU0/Puqmcp+EmyocfiuSBn9Lp+Mrai0gd2UvuUwPIZASUNelH0+8iTns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738329525; c=relaxed/simple;
	bh=qmlSF7FCNklHjqAga+EjJiQ0fZCMBsaVoy9DtcIt/do=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MiAVmIjCddG487slaf2fRBTZBWsbJWPN5Pa5+CKV2WHcWBnd4I0qw5B4MckgQbYjjmFqcqoh2iUJjeY20gjTS6SkEr/ChdRQqg9KYcODs+iF0Cr7FtGch/NJLP2v9DAOYjX+ueCE0eXUFKSiOLaeY1bCNBGaNz5tvhWctbYJncc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CK+NSEE/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CK+NSEE/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738329521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QeKcBbQXrPx3/GptxkDvFxxbSFlE5iz5Cb+9xbnZIIo=;
	b=CK+NSEE/w+wgmt9/sxXzl0SDjZmXlUHBj+0cvkHphKnsP5YkmXiE8aePKReQzyRgb7dAhX
	dXTSKMI7hw9+Lg5gwt62P2VZHDDR+ebeXfSY00p9zyfXhHSjUHNaM5QHS3dS2vcP/dwyxG
	9kMp8QAJoAPDMkdufe7FLg4HqsGvdpY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-6KQGgkmmNYiphmHwS1TlwA-1; Fri,
 31 Jan 2025 08:18:36 -0500
X-MC-Unique: 6KQGgkmmNYiphmHwS1TlwA-1
X-Mimecast-MFC-AGG-ID: 6KQGgkmmNYiphmHwS1TlwA
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E2BA9195608B;
	Fri, 31 Jan 2025 13:18:33 +0000 (UTC)
Received: from Carbon (unknown [10.39.208.36])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CBAE1800980;
	Fri, 31 Jan 2025 13:18:28 +0000 (UTC)
Date: Fri, 31 Jan 2025 14:18:24 +0100 (CET)
From: Michael Petlan <mpetlan@redhat.com>
To: Anubhav Shelat <ashelat@redhat.com>
cc: acme@kernel.org, namhyung@kernel.org, irogers@google.com, 
    linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
    mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
    adrian.hunter@intel.com, kan.liang@linux.intel.com, 
    dapeng1.mi@linux.intel.com, james.clark@linaro.org
Subject: Re: [PATCH] flamegraph: force flamegraph-report script to run in
 live mode when using 'perf script flamegraph'
In-Reply-To: <20250130213526.2626749-1-ashelat@redhat.com>
Message-ID: <14d94add-75cf-d6d8-3512-8341275e3597@redhat.com>
References: <20250130213526.2626749-1-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, 30 Jan 2025, Anubhav Shelat wrote:
> Currently, running "perf script flamegraph -a -F 99 sleep 1" should
> produce flamegraph.html containing the flamegraph. Howevever, it gives a
> segmentation fault.
> 
> This is caused because the flamegraph.py script is
> supposed to take as input the output of "perf record", which should be
> in stdin. This would require passing "-i -" to flamegraph.py. However,
> the "flamegraph-report" script causes "perf script" command to take the
> "-i -" option instead of flamegraph.py, which causes no problem for
> "perf script", but causes a seg fault since flamegraph.py has no input
> file. To fix this I added the "-i -" option directly to the
> flamegraph-report script to ensure flamegraph.py gets input from stdin.
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>

I'd suggest adjusting the title slightly, e.g.:
"perf script flamegraph: Force stdin in live mode"

Otherwise, thanks for the fix.

Tested-by: Michael Petlan <mpetlan@redhat.com>

> ---
>  tools/perf/scripts/python/bin/flamegraph-report | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/scripts/python/bin/flamegraph-report b/tools/perf/scripts/python/bin/flamegraph-report
> index 53c5dc90c87e..83d5738c75ca 100755
> --- a/tools/perf/scripts/python/bin/flamegraph-report
> +++ b/tools/perf/scripts/python/bin/flamegraph-report
> @@ -1,3 +1,3 @@
>  #!/bin/bash
>  # description: create flame graphs
> -perf script -s "$PERF_EXEC_PATH"/scripts/python/flamegraph.py -- "$@"
> +perf script -s "$PERF_EXEC_PATH"/scripts/python/flamegraph.py -i - -- "$@"
> -- 
> 2.48.1
> 
> 

