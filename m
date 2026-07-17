Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9363624D4;
	Fri, 17 Jul 2026 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784310398; cv=none; b=A4JbBkOctZTqP1SAQ81GiE87X7agv0nB6cIe2IqI/YzwsUfZgzt5iSv4TH8UP2jJcZbHgAddlO84SAOPhhXbSffZj4p+ei7CnO7tdiGznTKOq3BQSmGFl/jd1x15CdZBphwe1zPGQdMU3LY8hbbCVpZ9gUviarNwucwZ6pJzPa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784310398; c=relaxed/simple;
	bh=jR81HqQ9FOTiiQ1AgXOP3oMoxjSkOIT+/ar1xZYFX0k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PAc7Y4eB2EliBis1BskisMZAJaL1eiXOg6I3yHb6/A09ym8xXmTAlI02I/Awp4ZCpg92Sm9hbbZGfYh+Mruv8izUYsGfCNkA2MTHzMHBvt8IXXsItbRgUYdijKTdFp+Cgg9xlmLGKTVTgoL0I9Djxj7CCs1BU55OOeAVf1rj/cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqjkOuS/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqjkOuS/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33CF1F00A3F;
	Fri, 17 Jul 2026 17:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784310397;
	bh=7qgR7AO95PnCYTPdfH462I0DZXAXcEGnNpu6UfWcqTQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=QqjkOuS/suxSg4RUYcMvdi5LcCykv7ivHt78K8V/VtGhxhX6OKtJPvirX7cghxTBB
	 K5qpHdcu8EQduQa2R5ixQSPLIvq70Ut1AWLaqVAtxu7PmnNoD3aqISvg58/fU37A/N
	 nNT/N668dv0kDwwHOLPT8/vcYWs7dbd0+9XTdGwdOVgwLAQQcVc0YV3rvrWMiIcVp0
	 hITEjBbmPp9nudI7D9J6D/MfofN9KpBqqDdQAuLJJAAQvVxQoStYfGsGDJL2jaZ18j
	 XDo/BFk/yWsNIxExNRwX+EP/eKqMjCjO4ME4CRK7UnFoFo+q9y5f3AGezseJ/9T3dA
	 RRoSF4EA+HYRQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 linux-perf-users@vger.kernel.org
In-Reply-To: <20260716004336.2731086-1-namhyung@kernel.org>
References: <20260716004336.2731086-1-namhyung@kernel.org>
Subject: Re: [PATCH] perf build: Fix a compiler error in util/libbfd.c
Message-Id: <178431039676.131573.10381408929906185414.b4-ty@kernel.org>
Date: Fri, 17 Jul 2026 10:46:36 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 15 Jul 2026 17:43:36 -0700, Namhyung Kim wrote:
> The bfd_boolean type was gone and converted to the standard bool type
> but we have some old code that uses the type.  It caused a failure in
> the build test.
> 
>   util/libbfd.c: In function 'slurp_symtab':
>   util/libbfd.c:94:9: error: unknown type name 'bfd_boolean'
>      94 |         bfd_boolean dynamic = FALSE;
>         |         ^~~~~~~~~~~
>   util/libbfd.c:94:31: error: 'FALSE' undeclared (first use in this function)
>      94 |         bfd_boolean dynamic = FALSE;
>         |                               ^~~~~
>   util/libbfd.c:94:31: note: each undeclared identifier is reported only once for each function it appears in
>   util/libbfd.c:102:27: error: 'TRUE' undeclared (first use in this function)
>     102 |                 dynamic = TRUE;
>         |                           ^~~~
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


