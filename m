Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8C022F177;
	Mon, 25 Aug 2025 12:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126560; cv=none; b=S5BfqqnHc21YN6A2Pi/OGj4lERmcj4Mi/d8rwQjtsA+r2SJH6x5Kj4rG8jBSC79DesibGyWl7+EM03wAYp3yIZ+SFfjqCA9s906jlr2mdVfi1uPbrLD6bX+E9I4FK40LZRP2B6mIkoPF+ZxyVJxFZ/pwZJQSW3Kb7oobUT1unJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126560; c=relaxed/simple;
	bh=qZFcnicgofqpjKSbgJm94yUCACoa/H1JOn5FGmcxNIs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=HrkJ41DZfiURj9BP5fSUTgGGGRm3S1nrhUiA0xEs0a0rY4cYrT3Wg+l4inpu0ubsgfCfrMvih7Npb8FJLzt7cLhK6ifYuqOliFabXGEUJddPo+JtOKpdYnQL4HycIDBva80Lb/m8m+qAQaXjSYrsmMNgYyInzQE2jtUfkuu1F1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ECD2Sp7d; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ECD2Sp7d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756126555; x=1756731355; i=markus.elfring@web.de;
	bh=+KxtocZo7lEdK5wtDyMmQPcclmuh1chlangADQx2sl4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ECD2Sp7dn4oE6+x+hfdevKL6Eup0JgBe3cIravEN8EHyaeTsmKeY4qnzv2rwrg/d
	 0QC/wSuVuxJ/6rxw6aP2//JQAaSku+eTOhQahvjpgAJehYSO03eKBeLW3Vh7xH+Z9
	 EE1w/C+NVldYLg5Pw4u9U2y1Ces/0PeYvT6xWHig9Q1rTNDutIM9ewUSykeZVah+t
	 2MiA4nLskkfilhJy9KAL7pLuZ7Egolqy4C+zq3dJCuA3/eDDcT0N455bUaDBNDkN5
	 s9KttDvNnoGITc8r6gGc3Tvqp0xf8ppfmFR5nZoaTjhj2pUoIIVTmnT8SvZxntowq
	 QaTLmYLnk10RwHjJEw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.250]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MsaRt-1uXcAq1jH1-00tJ5i; Mon, 25
 Aug 2025 14:55:55 +0200
Message-ID: <068ddf68-f24f-4041-b4ab-2d7d5f8a90ee@web.de>
Date: Mon, 25 Aug 2025 14:55:49 +0200
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
References: <20250815072008.20214-1-zhaoguohan@kylinos.cn>
Subject: Re: [PATCH v2] perf parse-events: Prevent null pointer dereference in
 __add_event()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250815072008.20214-1-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iQzby21TKxhmzFYiWw3/RjQH1DvJ7TOKLKrB34QOSb+NYnD1c7M
 GKawo2Wqp3+BLcEHD18RFAfabKSZkbACYl5GgqiynMngVclH/R8EQCNv7iJxKMSBThD3qqX
 ezhPl/ueTBDWtAgSj/y0ErDYmj1m8wrZzzBZLgRieSQiAyoRiuaV8yMcxILTHxWt3m8P2J3
 uQBuXMibyEkr6wO7kpylA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vT+qCPSsDEI=;xS7Oye+GX8o4hUDqdRGBk+TaCyU
 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

=E2=80=A6
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
>=20
> Changes in V2:
> - Extended the goto chain with separate error handling labels =E2=80=A6
> ---
>  tools/perf/util/parse-events.c | 15 +++++++++------
=E2=80=A6

Please move your patch version descriptions behind the marker line.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17-rc3#n784

Regards,
Markus
