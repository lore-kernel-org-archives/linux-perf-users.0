Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A9DDDB2;
	Wed,  8 May 2024 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715187821; cv=none; b=Tuxl0RkyvDBXmTsfroIICKa0E8rbh71BF2bjyKO7O/xnTA7KKp5OEzCOhhcjQS0yLw3jrEv2+la2LlSyKnzSJwMmGtECx9NGS/qWmycYtvNyFqN4jlQUTZfTELjLTRzHidMoaWBEUL4boEfHzWEMs32UAf2vw/gcj4P26O5NGLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715187821; c=relaxed/simple;
	bh=u+FDl3tH7RdzNgAMG/vr0jZH4Fdz2u+wV1+KsTqh1uM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=SsogKdBPUtnGVgPZ0hWheakLF2PzfiKI98uJm9D6+lyD6xGcG0lX60cFZ64mhGCOQ6a2/pL7Rrvt1XGG+fnrikYB02u+o2d9XMq86x8fvOMJf4SFNRn/IcmIx36fRwYGYR0kO0HyLqoQeLxa4eXbXM8HwhXq4j6qogWWSaAkWqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sPoUqj4s; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sPoUqj4s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715187771; x=1715792571; i=markus.elfring@web.de;
	bh=AjnPyjnsrQDPJYZ9uhUAt6VHnSPdsHQWUWsa/Smbu2E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sPoUqj4soztmQ7fatgrCape28SO9n8goudCMAKjg7u+XImp8dStpAehLDR/MgXR6
	 haguGkkEHZh+EKDSnNUBbDhYc8CspXkpfidNj0S7TyzjMksL+IQldbx5qSMMqcSLP
	 FMPy6Homya/3UQYgd5bgdQ5tn4cvqGXs4sFs/q20PG9uMyD4hliNkazEad/5uXtyp
	 wyLl/yb8HavPMYA7RNTms8LnDxTEcNxj4+wdWSfX2Kac0Y1Ef4J7+4+FlLb/X2Nuu
	 ABHgZOGnNNbrwNS3JVuobH2PfX0MQmQjyrS6fvxJxQ3aZma+A5Z0gZ7zfjSAj8w5r
	 3eTDNpGQX6B0f7MNag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFayq-1rprls3eiE-00H5w9; Wed, 08
 May 2024 19:02:50 +0200
Message-ID: <4294f69b-a317-4f09-b775-52439e2ea6fc@web.de>
Date: Wed, 8 May 2024 19:02:35 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ian Rogers
 <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
 James Clark <james.clark@arm.com>, Jiri Olsa <jolsa@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240505202805.583253-1-leo.yan@arm.com>
Subject: Re: [PATCH] perf maps: Process kcore maps in order
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240505202805.583253-1-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LKnRS7MuSAFl/he+bteY1QUAX2irvK6smzp2qbkyj/kinqwqi1h
 uyyAA7lhXKQ8dzcgnzmhStr3IDlsazri2nVcIio+qU5tvQfBICx6crITmo1j6CkDuVAvKLB
 WA1ezTunRPLbh44c96ZL73BpM+lbxtp1WtrTpjipWi1MarX3eCK2gn3Tjgu+T9qzkadlFcC
 x6xERPm/oQeLX2dvLSfbw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qSMLRAMRP6o=;dv54UHQvXakuD/tl3CKU+TJdKIQ
 MjUdd/DPFvsHI5t5Z/a9ZFZmNcSOwGpNcrYWkYwFbn6y6DUP/7CWv0v6ENrve711O6X3RmTpx
 3lh0/7dmMmAnZixj492qxd3y7EWs+563WYmD4EoRKyPWo53R2v3KH0kW+bdPqK0ip7KSkhC5X
 KQzb9lB5WUc5d4LIqeyRgm3ZMUtE6Xa3KNFR4AHhev5OkMDeDey7dtOv8PLHfpTGXxwjKJ3XJ
 lSD/2B8uMQcp8h61ywNoF3O2Z7xfwbUgKiYQqB4n+Ni44djPrCNTqTbwoJ5l8cv4m9jVqkEt+
 vB+xIUjGC4Zw5wQRpoOaSrAQLLFk9cTeFGGInR+D/c794ucUjuRVDcJz6jdMfUWjT5xWynJgu
 BqJ+F1H8iW/ruPCdDzJiKUwLayUNXmoOtc5w/9f7Kgjkh3Zoquv8AGwGsYRg3+wfO0Da/TfOs
 HNYz0uM+datnl6gDzrKrurkaXV5+OWenf2TVWUQRP06fC+L6P9b+nHU5Pib0UHQRVirsba7QM
 XKCvObBvAAtip+2NRJ4K7sBDrSn2oClvu/kpP7ste/UjqXsnItUg5f/213DyAcQO5M2rAlNvw
 k4KBqbjy/9j3XyUtkNlQqvbZOErBcebq5XxV1ddsrbwGfcVTc9lKqjrVmFsP4pEwGgcpQfVog
 DYtr08VEljzkQMTs/XmyplJSnHTFmqZULdyH6/5BHHIYlfMYt63zsA0drgb1wZj5KUcR16Mtj
 aVkpH31CXuvmvzi1cWEx0cgq5+xbEZw02xKpbSEaQD5oYlR09r8TQc8VIMOuZi8EnpuT59+kT
 7Sj9dkTaCa2J86I8zzRor92VuqZC5BfVPU9g8wlN8p914=

>                                                        =E2=80=A6 To fix =
it, this
> patch adds kcore maps in the tail of list, =E2=80=A6

* How do you think about to add the tag =E2=80=9CFixes=E2=80=9D?

* Would you like to use imperative wordings for an improved changelog?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.9-rc7#n94

Regards,
Markus
