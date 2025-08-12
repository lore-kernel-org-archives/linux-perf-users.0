Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7441D2E8DEF;
	Tue, 12 Aug 2025 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990598; cv=none; b=JytYUZQ1EajFyqBsaNkh752GhqgdBz321Bb+gKIwhZFJEeofzkYg1I4BmCDJ2pKAXnc8RqcqLo8+F2sYj3qLaJwlMy5EQsxI+8MET1RcXpvPqQb5hLW+ryzRzN5yNksivxRdi94BbzIAndBAr4w6C5jOU3y6BVeQ6RX/OcIA9XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990598; c=relaxed/simple;
	bh=F0JCsvxp2KSiNsqw+e6p8pqMJjyP4dxWClz/SZQ4STg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=kZdIPZ0gMCq0gx77nzn0SYFRHqj8xh3O5nRU2EOuj+EaVDdTVSMDJoWqWrBoAMjaHJR5OIZ3UamPVyR5f+2dctBUffxvMoYLOXsUZt/cVIGFpmiqQ6a1zoTD8ArfCynbiQguW0P81OKTaLMRoRbFdj1FIaNYIj3Q7lFPxlIvrMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=etulDBWh; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="etulDBWh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754990570; x=1755595370; i=markus.elfring@web.de;
	bh=DlQ74IAYyuXXvfkcXZAxGgtcU70uGcbNe3fwcVohW3w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=etulDBWhaVEtgSmEWvcqJI3Fz51dCkQzup1mBNOovot4AQELy3+bMJPqJ5IvdeHo
	 0yU3qJH2z8exkF/7PiCX1VNK4uJ1RyRLjIuCDP+6LzjXlo1/X4B9eiHcKLa/S1eT0
	 VD0RTPVgC6ADnX0tUzLfmp87uIi6q0+RPmFqUdF0o/d+jiuFo78m+/3QyF/8KeQtt
	 JfP2q7RYvmfXLSsSBdtfl+kIQjIr0YUnhMXlVecfRtp3qYY3QG8ImsdFatyuzNVMa
	 nPajrgMy07l7QX1wPUUqCLZAC5E06ClXplEZmuXls4IcZTWyGsbCPn8cpKN3xLxmM
	 Qvjn4zX1UXX3izKPZw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.213]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4bUg-1umIuq3RmI-008SPM; Tue, 12
 Aug 2025 11:22:50 +0200
Message-ID: <2d1c8222-cfc6-40e1-b26e-9cb1adc90202@web.de>
Date: Tue, 12 Aug 2025 11:22:43 +0200
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
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Falcon <thomas.falcon@intel.com>
References: <20250812085941.19982-1-zhaoguohan@kylinos.cn>
Subject: Re: [PATCH] perf parse-events: Fix potential null pointer dereference
 in __add_event()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250812085941.19982-1-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:repsrdyvNaflICgSBMKjor80pa66cCn/EuIVK/eEt3ah92dd/Nw
 AtlXS++diGmWc9ISY5OB1/tcBv8lqo/Z6pyi+9sPUp0loRSz4RBkuQrU9rv8tfCiK9QSqWd
 mniYnpeA44tRL+6F1ECsLwdfMDoAFEcFZHBX2eyDmCCOHeLOMoXePKC/w3eZIPCkPO9kxzn
 4j19NyqG5f3j+ez6FxrgQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:L27j632a4xU=;KW2w6k2bvCahaEqkvDx+yBK6RMe
 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

=E2=80=A6
> Add a null check before accessing evsel members in the error path.

* Please extend the goto chain instead for better exception handling.
  You may reorder jump targets accordingly.

* How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and=
 =E2=80=9CCc=E2=80=9D) accordingly?

* Would a summary phrase like =E2=80=9CPrevent null pointer dereference in=
 __add_event()=E2=80=9D
  be nicer?


Regards,
Markus
