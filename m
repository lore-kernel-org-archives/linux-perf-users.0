Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BF22E92A6;
	Tue, 13 Jan 2026 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768321316; cv=none; b=ofNPom2ZtybRaC+TyCmCZfioOGqDnEFcZBxKh0FPeXTJNaRQLVTp1xHDUmYfUyo4leLituNNjrmffDxuREgFGFyw8Jv3iZuji3kajEc0fzweOUz7e0rbKU7biFkCtfB2MsLk0Z11RGSi35MIIsCIXTt1KaXLba6Haz9XaaCarRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768321316; c=relaxed/simple;
	bh=VWh5rZwYSHDSgrHIq6QY0pYuzjqrowIR1ZRPlT6M5gs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Di8oVWgMzftkQ9tmweiQRJR9LBaxcDh3Bi+rBqwdDuHoLy5R8B3cogBtHXLiQZ0ix4xd5I1tdWUB8Igt2NhmcipzlTXABMU0VBkz03GkscVMEnYclweDMCN4VoF4ZV/rrkK+w0y9Cwt+PPhhttPg1qGr1nKC2j2wOSlYmXskaes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=nOu0YL4H; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="nOu0YL4H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768321294; x=1768926094; i=markus.elfring@web.de;
	bh=VWh5rZwYSHDSgrHIq6QY0pYuzjqrowIR1ZRPlT6M5gs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nOu0YL4H72C+AJzTZjp1lS1yMr9sEWUfBPQD3Nby1jjsHPRdg8xYPUrUjmaqdTGp
	 QMpJ/65pSJvvhTKSeimzbTOPF61/Y4LElwIe7kv8QSdbA2ubfNlzd3KiOGXhXgTdY
	 7Gw9WQNrKktsNtTR59MsSObxpPaPcasRbySZ+p5pT1w891I9tuDjcnKgMv/UixriQ
	 KPeb03IlP94pt4z4S7rBjcQgfPhC16M5eNWV6aIZYuQS/RTfNCZq1Wy4qlxxEQ4KK
	 BbISYq8fST1ENLJWhzfi1sy0LhcHtPob4mDXKAf7gskl005MWUkis+WdHIDbl12pZ
	 3hYJNMkINE1ByQE1bg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.174]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiuOW-1wIJkw1Moe-00c7dJ; Tue, 13
 Jan 2026 17:21:34 +0100
Message-ID: <6213d28c-7377-44c2-92c6-0dc34cfdf60a@web.de>
Date: Tue, 13 Jan 2026 17:21:26 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zide Chen <zide.chen@intel.com>, linux-perf-users@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Eranian Stephane
 <eranian@google.com>, Ian Rogers <irogers@google.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: lkp@intel.com, LKML <linux-kernel@vger.kernel.org>,
 Thomas Falcon <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260113002539.408943-1-zide.chen@intel.com>
Subject: Re: [PATCH] perf/x86/intel/uncore: Fix iounmap() leak on global_init
 failure
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260113002539.408943-1-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:7NDPn+q9fMyY3UKklvv8myRjEtsmepfcdQi0QBafspAeUjvMGbW
 vZKf/FZ+ibWxwXwCHD2EfdbEZiTd4Nb/yAeBesjdS4NylqmK+h/tn2ZMnYp6QC19lQ/xWax
 05tPSvX6nRbFD7/qWvCppUtJcj3wyKM1BILawAhHRGT9QmljPciRuAHjDNIGuAK/a3ukPkR
 Fm7bgFBS7qfxdqzX20i6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:whlJOpJVXrg=;/n11Kkoa/KQ2sn72nyDbAcB46ud
 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
 lqlgGfM+YQ8KFwAqERZgXMtaCqvFx

> If domain->global_init() fails in __parse_discovery_table(), the
> mapped MMIO region is not released before returning, resulting in
> an iounmap() leak.

How do you think about to avoid a bit of duplicate source code here?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v6.19-rc5#n526

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.19-rc5#n94

Regards,
Markus
