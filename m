Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E59241CB5;
	Sat,  8 Feb 2025 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739034260; cv=none; b=JJqtU0sYQyCf8anWl6ClnbDlMZC9TdxKuLAjPuvzK4Tan9WjW5p43UQuGPU4QltWROJLtbJ6Er6AccBrYCV6RGtaRhB8+QXqimqpwQ6PF5z45Zo0f1Z/ArrDRTG2ufhHpVyGoQ+ZiSEjECwFQubW9nBSiBP12RRxNo+JrTT+Frg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739034260; c=relaxed/simple;
	bh=N+voSFAdQoo8KTnq9lsMXewQAOQf3zrHYlGvGEm0Zq4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=B7NI0pNFmJG28Ux5ehl6yrS0BDTXXL3kaDY9CYheQmDaIlLrR7frsfIFjSOfcimP8s3Dj/RLk7vHUX/0JHYKP9hIkTbEUOjpWNHlPR74LdjUfD2dawKjX349H4fongpi1GPAySy7OukynYEVNR/2QeUXlfvTqVnFzbsXn9ibkZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BbsrXZOx; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BbsrXZOx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739034175; x=1739638975; i=markus.elfring@web.de;
	bh=P9iUCwoXxW9VD6ZfW1OnEl05YHOw5juIEdog6aL+82o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BbsrXZOx0RyT/kRRfxhBqK8Tq8B96dKq2dp8E1e6rtg3ZWCiSB9uVeUXWsymf4/H
	 l0zlJQuFv1CYGqDvlFDaofNURRdckQ1obeSQwyIoilq8FVlvaDwTDNft3jlFIzSLk
	 wxPtWcsUZ/Wsd/SBw4zElFhoDlW7GIEufITBeSfViBSXC9kpnq1XNFbiKLRMxG24J
	 9rYAwXYG/7MMd2hP30nKKbO1ioqQyiiiUbWcfqowRFo8Qd9l9GgYixOjUUwFgIDC+
	 UpZTAsACzGDv4z9keYbQlsafKiSjVLgKDnI0LqDH4aHL9CLO0olXvQSyH++nfhiqm
	 2XXM+Fa6JFaBhK/AWA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.11]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MuFD5-1tPxIY0ymz-013lZv; Sat, 08
 Feb 2025 18:02:55 +0100
Message-ID: <af27ddaa-ca9f-4796-bf33-574a39f9f5d7@web.de>
Date: Sat, 8 Feb 2025 18:02:48 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Anne Macedo <retpolanne@posteo.net>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>, Ingo Molnar <mingo@redhat.com>,
 James Clark <james.clark@linaro.org>,
 Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
 Jesper Juhl <jesperjuhl76@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
 Junhao He <hejunhao3@huawei.com>, Kan Liang <kan.liang@linux.intel.com>,
 =?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
 Mark Rutland <mark.rutland@arm.com>, Michael Petlan <mpetlan@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Sam James <sam@gentoo.org>, Thomas Richter <tmricht@linux.ibm.com>,
 Veronika Molnarova <vmolnaro@redhat.com>,
 Yicong Yang <yangyicong@hisilicon.com>,
 Zhongqiu Han <quic_zhonhan@quicinc.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20250207232452.994822-2-irogers@google.com>
Subject: Re: [PATCH v2 1/7] tools lib api: Add io_dir() as an allocation free
 readdir() alternative
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250207232452.994822-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kPg47Y0QLv/9DP5hyZurbD55mD90ukdPxtztk8/NL5QUP2PkYFB
 5uPiEGg3A1FV4tlr1mF2SQFilzZh6sntnibAi7voTlkFqFzC8qkJXacveOwe6K+RWH+iHiE
 2853t3AgT0lpOkFOUfQvRdJ21DX8ZnN5xiesOChwBEXw7FkMhP2IZvMFDjkwF8o6HBsGJBs
 IolyKwbxpRM/LikjPrxgw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:z36/jg/MFZQ=;z3nkb9ArlZEFtgG2wQ8diIY2zQ+
 iGerMGsVcyE1NQUjIbq3XYkej4nxOGODE5MogpZ7rT8Dwo24gMCz8jIjZxDYHHUWHFkAZ/jBD
 B998yqgvIpbrmClkNWawzgm/nO6+BI5KGeooBVuQHn9PRd7Jr1yGxc8LgXWRTcg0NWLdQLmby
 qq0/54aLoHVh1eT411Qp1sxdKjrT2pegwA2Lee17KWC+edCHq5smtEvJk8zV2YIQvd6Zu+2tx
 YqY8yzJY8ab+SAwJwVGZkz/cjvAjvaXYUsmMKV/u+xcFa2FLgea6Pf1Z/tYGhF2vXUG7gQwMd
 wRJWyaIgQ3gfz3JeGe5pTrHscI94Z6j1/rBDOX9HdiFIG2ISazXNo/t610CYhv3AOlflx1NRR
 Xn9vbEs1Bgyh9oy17zIk/EsaBwlp6VsCkyAIXaTPPJYKx5yzGLS3pWDzVWz5sEUbDKk7aiqAu
 WDgqB24DLRYtNIaod1sMkAMu+Vn/p+wNeM++0iNkKDIBUc6oof8yLa+zeHnC9WpEFFQMlaf1J
 Z+tL+Y/jUR2fY/hSyin1mV4eY5NKEzG8mkBz71T/0h4xwbA9A13AAXZ6fEppr/EcuvXFqT4gO
 1QCezeqcKQ3djMwI8NPDRYd+2Ix2a3FbHyUCVQoJNOxAQ2S1f9DyJoxu6qzhbVrDps7zeIiAa
 BBAu9gdbrDVnXPvFuqJeh7qMkSb/phEM945Q/HEl8vaDrIyC6qnGNgteOz73eha9KQmGJ5Xm5
 TdjGGFgblHnsikHQNcCON8mcaUYv1e5w6IL0gES/DBXZbZbLvgXy3I5rLSIcNYwoHK/X+GSyK
 9yHkxOytqf+zFKw1xTgpJ0Iv4UoGBktNmmpwRG7j4NuYV8648TBqbDwjVrcd0dORtQ9YDR5+1
 4YPCebOGlGzUSzhMdnUVefBJfV/bzAWP5I8Ci4QoQ/l+sUUp/3gOMqUo9v88h2Qt41kZ1+0N8
 KVw0OxuS4qsi+8ixsxc+TFtDKgtFws6Xs5he1Of3pq0IbE83GIFVQ9joVov94owwfObUz++Ym
 Doz+8G3wziG2iLQPrNI7umcbdDpkStUkOU5g2CU4NaetM8fFIyxkqlQUTb6lb65VL5jfP7eQJ
 XKliWVduekXJqZkW3tHJGjpMCllEcOHBUdQqnFonfxeXu1YCzGcCCh3wPJSfk5NaFnUc81dA8
 gehlktMKJlezBa5e5PiC7JTlhhZ5xCCQsaQGcm1kroqvAORpOY53GJyBzbCbBzQ6frpSczXs9
 cmwCLdqZ0CGb7o0F51Q1S51slHzeZnp4Bp2F58WOyW82ghVdJYGghnt7nVwippDK9HNdxAbiR
 4iSetIY08OTmwxeKojP/GkT9j8PrvwYCYJ2wZvrIEkY3XCxRtrk4VK0cjEiTR0x/ysjOMQL7S
 cpv4hNihG5XYOLxHt6KIZpgR2cwCDuo/CWN2YgCJyQfE4TB8+dqPPICnJF5/zVIyChcq1gjEp
 hBnx8bA==

=E2=80=A6
> syscall use was made uncondtional to work around this. =E2=80=A6

                       unconditional?

Regards,
Markus

