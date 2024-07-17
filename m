Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957E6180A71;
	Wed, 17 Jul 2024 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721224595; cv=none; b=bvWP6U0pBOBbw5YST8dzZRI5yD8pntPj0lfKV7QRsk0x6HO1MCgEmLZFP4S4ECJSxAtKy7HlwcuJGgY58BIMf8nkq+jJAqiIDzA3pVJBo6qW/yAKs22yl6geH3L0nljmzsvZvya1F64tZSkdr+NzpC9jzXWn90Z1cV4Uu70oWP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721224595; c=relaxed/simple;
	bh=ueo6YeuqYBrwR97RPNPcL3NG27I21SlFoh0T9ywCRcA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=G6tAl8bR+cpFlFpjzrDP0Cd3+tEtJs/DEqn/9YcfLB1/Y1EhR+JHBxJaPJAvv/27tFvKW8B4PA8kHjmtDBC4XuM9BfQz6KkoPAEBHAgq6VxO8yE6atNEQpzi1A8/T2ym1DvpeGLi/RjMwKRrbQYOS6WlxuQvp8KIPGLUJnoYP/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=j+6EoMgT; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="j+6EoMgT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721224553; x=1721829353; i=markus.elfring@web.de;
	bh=ueo6YeuqYBrwR97RPNPcL3NG27I21SlFoh0T9ywCRcA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=j+6EoMgT6uRZenobEAy1gGzxA4Ox1J2cZ7uZWZNHBka0BYCfQEff0bozJZlkiXNv
	 gt7yWjn4/VTAvOt6x6TH0KUZej5OSlYo1oubEwtnhSUUJrjhTnyk20MdzOFinEzQG
	 pLaa5swR06qcFecn0BWlxUZr92DAjWjMHYqYd1zq2+7ld+TvZetZgJG7RGL2WAvii
	 ifNLZ2yoL3jlOfJQEu9XP4+z18gDiVKVAEgByoQobB/gDhabFfVPF1ozMV5AI2+QR
	 Pj4CQmgxintEg56JGcD2LIsJG+Qkdv/ti/fhmXJJW94vr4hXH7uHaj2RNseqxpUIO
	 N3e1ITwW1WUebD0zpw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MpCmT-1rzSfm21iZ-00muYw; Wed, 17
 Jul 2024 15:55:53 +0200
Message-ID: <6ede4925-8461-466e-ae09-7016ed92d314@web.de>
Date: Wed, 17 Jul 2024 15:55:50 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [RFC] perf script: Completing error handling?
To: linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fDXUSdWFcLIkBEJAhXka5DyKKV6W0WvCAVbX/pry/GZc3hUwHW9
 62sZLZSh2zMd1f7p26+iEhlXHFtJQXVHsoq/yEgNcUX6K1aDIDyPrHM+zWeNXYaRphc8HVM
 ftr0/hlTAl3N5rf8x9gdqadjVojAQYH+t9NTDBzkBz2TuOPR7oujxM6vs33NxBwFFTqtunO
 8u88CzFwyueWij87mhiLg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zRhuL6EUs7Q=;VrKJbBFUm5qLyKmfqjh4dEDm4WV
 NJfk+sLn9QZMN+pYG50XYa77Lq3HGTM7j9I7aPTt76IrKs/qVVCfQSg0y6vJjsCYDn+a+jpXj
 mhH22GynIahsqu2bdlNSA3k1R1QUoERB97nbRxlCHO7HbksNLI//TcI8GzFJlnfU6kBRnmVo4
 DOU3wOt56Qn28PSdQuqAv9Zq/KSWDvkuK3HQyognT7eC8Gg4WYTijaizsYNnUxZSmazW+mrVT
 QvTDYxKtWY29sAoIbfBmQVwj6/bIEpNC1unXWhsKpjKOACbuGpqgEtuJ5BWsJGTuj8xOgEDqD
 oH0pRbpKaXgyct8ncdwFsH1jAy4tvav9+C7o5H5Z1MmhmgeMyvxrfDfvDq7iQBKg5Smxns7DF
 nf/+gXasdg0J+w62vebSLtSso1JCKp7jnI3oSFWSllmA/CyKXJY40Iyxs5n4cLtoDR9HTA4Nl
 2ROgT0vrUVjbTAXXgAzwr85ScoTlMgn6WLxEQ5YUw3iYx2OSIRcfvMIqF8UbzWEDsj+gstwk6
 6AV3h9j8e27ZG2TYFV67QopQwxso7Vxlm7uDzNZT6xB5Xim5nFNlbcDNITzETs+qCwdWlphmh
 Vu6xV6hXI1LHoL8cGLwuChXmhuReq2Ablnok5HOt5XjSCjALZ6NdY6riZXp6UyVHFRMwSbC0q
 gDngxrbVyTeeY7SzKWBnOFLH23CKKUKqMHH16edKiwEHN2iJGqfdJgLMxmxR9pyKOLOpBsqfg
 QlBShsGPkPhFVgyPsiNEBJCyOO1IATR0HyogdLiDGFUfOY3aeT0Hk2eW7La6QgBW2n8JMULq8
 B1BTdhyNCNdPmnjWtLvowRkg==

Hello,

I noticed that source code like =E2=80=9Cprinted +=3D fprintf(fp, =E2=80=
=A6)=E2=80=9D is used
in some function implementations.
https://elixir.bootlin.com/linux/v6.10/source/tools/perf/builtin-script.c#=
L697

I find that return values should be checked somehow at 63 places.

See also:
* https://cwe.mitre.org/data/definitions/252.html

* https://wiki.sei.cmu.edu/confluence/display/c/POS54-C.+Detect+and+handle=
+POSIX+library+errors


Regards,
Markus
