Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA42174EFC;
	Mon, 22 Jul 2024 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641516; cv=none; b=QUhnIwDsuJdk3spdt53gQFSY5lwP5N14IrtmY97OU4KRJ7lItZ4oJaGt3Pm8h148BfTR4LgNztH5kTKWFgmgRmf4pHOkP5hlUkdR1r+j94OmXq/344GLP0jcbkWm5KHVRyT6tarLEcvyeGTfd3js4BpmEcs47MGIkrqGslIHCZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641516; c=relaxed/simple;
	bh=tziOP+ESQ+W1d+CgJqInvXWL3SJa/jSdbKvvNhetQG0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=szHcU2ek+z5Bo1FDWwXH/2eZAQN+MRNq1FNt/2lwY/VAA0gAqxKTP9XgxSHCnV4RDaxWpLnM61Bw+VaUGCOQxF28/+M9M6XJOS9J8Q1XuCfRqNPOFcwgFiA/FIxxmIZYtS5FFvVDoOoAT/k+XzHjY0N4fEtuZz4RiYWidN+91f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=A/5kNF2l; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="A/5kNF2l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721641469; x=1722246269; i=markus.elfring@web.de;
	bh=tziOP+ESQ+W1d+CgJqInvXWL3SJa/jSdbKvvNhetQG0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=A/5kNF2lRMUjggCZ4wGOPqkTrq42CzdOPyhxw1j29l0Mp2DWwdy+yBTFunqkfZc+
	 AZlfWaejYfVie2dWf0nSTOiloryKbzHKRTwraP1uv4GvsoDjSXEuNvYSmyYAOWaUh
	 uBylssfEpB9dvPpL04TJ/0VCkzH7Sb9pxu1Cz0Ldgkj/MtXKEUUNJLnCMrSI83Nt3
	 q1PCF4dPf/+BZjTFwwmq1Zj7XUdOiFagHgkHqwb4C28VcP5d1xOvcGeY+oYp46Dgi
	 mhHHc6tdH3ZYn27Kvp9VKNoLs4aByHCZQYloJ4o9VC6yIJZyyhcwgawoUEm0UZTbY
	 di/IvQ5AdxZTHROxHw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Meler-1rvwsK2mij-00mRWx; Mon, 22
 Jul 2024 11:44:29 +0200
Message-ID: <39a3552f-cbaa-4e29-ac76-95684859787a@web.de>
Date: Mon, 22 Jul 2024 11:44:25 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ian Rogers
 <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
 James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [RFC] perf bench: Adjusting concerns around
 asynchronous-signal-safety?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+M5y8U2ej04KHX+Faz4b48gH9S4gHWTqaNOo+v9UVE4NgkX70WA
 OfYAT/Lti6ztx+nbiHqmQotKWwnGyUeH17yhQKx0uQWhJjSByP+ZcWuQoTzrYhRpzE4QTOd
 uoBP3+J4YXvlmjvamAgpnZyWlsY0zTb70RNNT60ITJ3NT9hPegmn0bdCWhhSgLWn9TRmK6X
 Gu5Lo4D7nIgfDXOksOGQw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:g5ULUjZTu1E=;tz+ZDqwUFZrB3qnJkQ3Zj2fJ6aH
 LMxfHpSBvYMO1VhL1Iv33ILAspZi2/6p0Gj0dsmnTMDA+qkrNr1kANnBxkpUvmIZHsX67aw28
 1q5XX7aBQ0d5ybOKdP6ha3qHAM5aPJX08Zee8Idn1FkOWUzJ/hPlBcmrCY9uGxQsiM/Bn09f7
 X5CtFkurw6noxmy7aqEMRQv3DlMtMoWnu/k1VHBC/a3yewZyZuNaZaHT8l2rb1F2F3QOe+YST
 Rro/ILvUztqAuGQWMZeDDsj03Z1JoqZXMCNyn9Y28g9bpEVNVO0dOsrKuxBWy/vThwor/GmD/
 H6QnOj3eQw6lWRd/2C7IoMiip2MJbWYs41q8K3WcMN+9DWjwwb5KVNneqEyFRBLulndJm22nE
 rc9aYx8/7sfj6dVDRCeSIHuYVJYQ8vH3ZdvW4z28SZcUY4fwUrxhAi4Pmx3LG5epountNSip2
 XDXlmj7BA89BqXZVVd6w3BdAoLybxwwnKZJixw6YscKwtYvXXYjlqKtsKMmlw+x/+7r4vXGUO
 8Rr2V6E2MnHR+bTYHtljakcBog8lrbKF7PyHwVvhGXf3nIJW6StUJ7iNpDcc946aGKhIxE7pM
 pQuAG0aVcTBE82cLs6r9CxyCgoEpg6MWoGkDaClzOQjDug30qgPN/68jV/TeBioKRhATpngBy
 CyWGZU/bCOs6urEtLSHzP9sqG4uE5AuspPGrDfAgv1X5mLD9C8D000C6BNV7bytllVzdbKDWi
 oUpiHC6/Tlyf+GaQz7Ie48Q5d7uRy68H+T12QfiPl/7mQ3UoiJgcthyYTNiQU/NUTG++/RFjq
 fBxdGq7JKyJS9tqeq8b62zhg==

Hello,

The functions =E2=80=9Cgettimeofday=E2=80=9D and =E2=80=9Ctimersub=E2=80=
=9D are called within the signal
handler =E2=80=9Ctoggle_done=E2=80=9D so far.
https://elixir.bootlin.com/linux/v6.10/source/tools/perf/bench/epoll-ctl.c=
#L90

Do such implementation details trigger any programming concerns according =
to
asynchronous-signal-safety?
https://wiki.sei.cmu.edu/confluence/display/c/SIG30-C.+Call+only+asynchron=
ous-safe+functions+within+signal+handlers

Regards,
Markus
