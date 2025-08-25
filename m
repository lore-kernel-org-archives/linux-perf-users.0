Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A462EAB6D;
	Mon, 25 Aug 2025 12:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756123640; cv=none; b=s9Few/ipt3EhsnO6CWYWcICKayH+8G5xq06gBlQhm9JDTXcRl81qqEgPZQ/up/a5eHelJEp5NDFnlAnyiKSPd1HX5XgKUdxw0D691bdtielg5YpR2ixLFO0mgslnB8MQl+CXwjzRkw0P9qzrUsrK4A1p4bh/rtmwExY1ZIWDeyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756123640; c=relaxed/simple;
	bh=f6hBfgXJFuHE+QCyvRPPXOb9cvGuBqp9UxMfM+gbSKA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=m68aELY+Fy2avOgBPr4/wvmRbei09dnKJkDyJ97RtENbV/DRjXIcbXPnl24yrzWWCuaF8idxW4beAi4MHEz1422ETJOn++DfqpY5G92kYYQPFzOfYLnRN+aAYDLqJQj4zlud0Tw544+Xgv7+5Jkhd897v7coA+QaPglavWn4kcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=qbQnqDmd; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="qbQnqDmd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756123621; x=1756728421; i=markus.elfring@web.de;
	bh=TU8YXUyknRzow0ZNzCH7qy3sbT+AYKbh8NruHzz+isg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qbQnqDmdySaP9NsRKJ3n5EDBj8iOOdYhsH3INoLHyXH/5TgiznTHvUSkcDtjRA8G
	 BG/zULaINOAFGsCnnkOPsvXtZRq55SizP3ec7b3NNZpaxYwLRO+eoAjZb8BJaZpCI
	 LTWE+9Wz9ln4hjaAX5E0qy8BdyEWpLkROrdGtr4q0JHcuQsSpY3cB+S8Jf6efR/aQ
	 kMP0ouUaBbAiqsUxYj3QD6Xc/ndE/UluiC6LYc00WuhgeBterguUoL26a94PrxteI
	 014LmMqIF1mgSByHhwOxdGieYwmhDKQeGoqxLVgbAPOz2arT6LVDLTn68IBZ0qz0s
	 eXCfCbPEGmmZIxKCxw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.250]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9IOj-1uucyo0ktD-0062n6; Mon, 25
 Aug 2025 14:07:01 +0200
Message-ID: <bcabd7c0-9ca9-4ef6-8114-fc80a890a17a@web.de>
Date: Mon, 25 Aug 2025 14:06:57 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: GuoHan Zhao <zhaoguohan@kylinos.cn>, linux-perf-users@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>
References: <20250813033432.8943-1-zhaoguohan@kylinos.cn>
Subject: Re: [PATCH v2] perf drm_pmu: fix fd_dir leaks in
 for_each_drm_fdinfo_in_dir()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250813033432.8943-1-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Mf6oMHTb5y/O4XXXvfz5doT5ZwzuzLl7tI/KYEictDrZsp1T97T
 qeZenVfM7xM5Lfc3x7+jhMSE/ac9pK16iawyFMZJ000qS1/V9iej52Jj3acL741YCKVa5PW
 N9xMA6DPq7XbfgsMGcCncnlSLP/RoHaoZZghiM0d1orjF9IXiL25+DEAySeCG32s6wFWjYl
 q/InD5mF63DDSH8QoNsOA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9vpuh85sMsI=;KeZ3qXMi3pz1LVw1IDJt7QnfXNc
 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
 4omAp1E=

=E2=80=A6
> +++ b/tools/perf/util/drm_pmu.c
> @@ -458,8 +458,10 @@ static int for_each_drm_fdinfo_in_dir(int (*cb)(voi=
d *args, int fdinfo_dir_fd, c
>  		}
>  		ret =3D cb(args, fdinfo_dir_fd, fd_entry->d_name);
>  		if (ret)
> -			return ret;
> +			goto cleanup;
>  	}
> +
> +cleanup:
>  	if (fdinfo_dir_fd !=3D -1)

Would it be nicer to use a label like =E2=80=9Cclose_fdinfo=E2=80=9D inste=
ad
at this source code place (so that a repeated check could be avoided)?


>  		close(fdinfo_dir_fd);
>  	closedir(fd_dir);


Regards,
Markus
