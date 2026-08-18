Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB9A34E766;
	Tue, 18 Aug 2026 19:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787081178; cv=none; b=TqbuHNBaPPbjU2A//ndIq36jmnL13rWMJ4CxFRyUIZ0sQpIifaQhZEEDrMX9hNMRo9srx3FTiNyxb0EkYj1pXSNuUiVG4rhSvMh4pEo1brOznB0gLWs08jNPIlYy0pLnYjgJwOlMAfkoDfADm3FPRdaQH+4fbJn9tynCb0SGBXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787081178; c=relaxed/simple;
	bh=qb8r1tq+1NmSKEbcZ/shep6GKfwO56cZA3VBYfK8LBc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=W2q5fjJvoWeXnFPl+BUXHQgV8l8pOMhr9cZ9W32qlZ09P+2HSaOBcwrvxEybOEKTyBFs+iEpwFY+W2aTV6jLgH9mEII7h9/7QLDuxyJo0VzXvyBhCMRyMHLilYPum6EOIzTxANlUNy6LvhPkYe4wqypuh1S8v/1zFHs/r0JhuLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BeJ+L9HI; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BeJ+L9HI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787081068; x=1787685868; i=markus.elfring@web.de;
	bh=qb8r1tq+1NmSKEbcZ/shep6GKfwO56cZA3VBYfK8LBc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BeJ+L9HII/J8KVUrkbCgz+EzmlqE8BmR33dnjw2P+/vD4KeVRbcWTYXWwiA8oZvK
	 Yx6SvtHEBa4T1JYdghv2zwhSlSTqnup4zN8tdLMmcRbcfAdi/wwcr847x2CXOo71k
	 Ouo6Wf2XapfNYzMikEj35CHMjo4LAthpqUiktU/3YpX0banfISwD4c+WnUpCqVknB
	 dw7N12dmRh2NrbS3Ime2n37bmySSX+hI1s9JtsZne2/pIew6ZBIu2u9uJ5ycO79Ef
	 R1NtMrmt+5/R1q9o5th6OA9C6sJSCoEakFd+aB7LThL0gwgSzhlRHAowxyS6VkG6A
	 s8d1sZPWnyGEmPkHHQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0qr9-1wiIor2rnp-00u7Kk; Tue, 18
 Aug 2026 21:24:28 +0200
Message-ID: <4cd44a8c-2eee-48a7-86fa-314169973441@web.de>
Date: Tue, 18 Aug 2026 21:24:13 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Triet Hoang <triet.hoang.dev@gmail.com>,
 linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo
 <acme@redhat.com>, Ian Rogers <irogers@google.com>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Aditya Bodkhe <aditya.b1@linux.ibm.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Andi Kleen <ak@linux.intel.com>,
 Athira Rajeev <atrajeev@linux.ibm.com>, Chun-Tse Shao <ctshao@google.com>,
 Dmitriy Vyukov <dvyukov@google.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>, Guo Ren <guoren@kernel.org>,
 Haibo Xu <haibo1.xu@intel.com>, Howard Chu <howardchu95@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, James Clark <james.clark@linaro.org>,
 Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>,
 =?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
 Leo Yan <leo.yan@linux.dev>, Mark Wielaard <mark@klomp.org>,
 Namhyung Kim <namhyung@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Sergei Trofimovich <slyich@gmail.com>, Shimin Guo <shimin.guo@skydio.com>,
 Stephen Brennan <stephen.s.brennan@oracle.com>,
 Thomas Falcon <thomas.falcon@intel.com>, Will Deacon <will@kernel.org>
References: <20260818144837.741469-1-triet.hoang.dev@gmail.com>
Subject: Re: [PATCH v2] perf unwind: handle allocation failure in
 libdw__get_entries()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260818144837.741469-1-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cuMRf356D/qgbgBZdAACC4Xm2H4LXdjWaxl6cnPLShT19AU0tMk
 er+CymHbetJOjCFlSerhpuP3wab2NrPF24NB2X8S9vror23JIXXsOAlaAOi8NLDB9kH3V+K
 9zMVQhW8tTKCkXvgK0epFUgCsbShDt+p4YXDPb6o3EF6Jjgr1AoXRqGqmrbqLbMwk4d6964
 Fq/MKtOmZZOIUo9eK1TAA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WAZUgnM5yTk=;yC42gvkRVknc4koAvQ0W8K9ML04
 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

> Check the return value of zalloc() before dereferencing the allocated
> dwfl_ui_ti structure.
>=20
> Return -ENOMEM when the allocation fails to avoid a NULL pointer
> dereference.

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.2#n145
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/stable-kernel-rules.rst?h=3Dv7.2#n34

https://elixir.bootlin.com/linux/v7.2-rc7/source/tools/perf/util/unwind-li=
bdw.c#L342-L447

Regards,
Markus
