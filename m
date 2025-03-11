Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20631EEC0;
	Tue, 11 Mar 2025 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741698655; cv=none; b=CNhRTWgRCIVNWbaZjP02gj5VPbEMzypCNMtf/aYakWfqDVaf65EP7iwEjXKyucQeU/V9uClQDHEbeCcPqPZBGj1sQIsBFleG+MUbHtD22lQkeekw9dDUlfB0DbziW8X3X3Imlz0F/49RLLqShRImk2Spm8lS2vz4Vauwgj2acHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741698655; c=relaxed/simple;
	bh=x2wx83Af4auGESkptVyzXE8x4VbScnVfHSrzRSy8Sis=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=sRW0VKszPyFAexROzKeceAMWGFqlZZOYi2PDyl82h9Lq7/me6yeoLNLJK8bIwRlzEOsNd5v54CyJF7dSs04X1lZ8i9EoDUeaGqf2eSPIpScXBgHWqWSJjohpgPe6FgMBfW7G+MmadbQ31sy38O16q0AsITETKEY7TBT7KLKIb0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=hXXU4nzr; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="hXXU4nzr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741698618; x=1742303418; i=markus.elfring@web.de;
	bh=d4+v+/FFY1NFCcEvkaRdbNdq0w4BmXK0lz0GP1TGRu4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hXXU4nzro6J+l+7pD5Mes3OaAGI748t3bffQODOyUCJb8rQpiJa273PJ691hNk61
	 FCvPFYRnuEgTU1I2e0UNuvu6toIWs/1PN/k7Ytm5Ykevyus9R3lhZ+5Nh4bUeAVp+
	 MIp7YXaQbNDgcU+9z4MxiPxw1KffhJR4leAvAVE/vFxevDkBzk9sWPuGtssfXYE8Z
	 p0IeZsCaLF6TMGP4fbG/JBkdUm+wWmW4X7bYSj2pdN1rUf2Ok8/eTAf6D7uTVwd3M
	 /zFaAaVOJdpE7WESeIkd5JeyPOWDyPiu5MiSxY77nQEXXAayYcrL2UnAZ6uy0/UCI
	 wkknlg+z3MaLUH/rog==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.40]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MBjIG-1u43eQ010e-0092uf; Tue, 11
 Mar 2025 14:10:18 +0100
Message-ID: <d5ea4ef6-f6ca-4135-b339-fdb8b4ca1360@web.de>
Date: Tue, 11 Mar 2025 14:10:13 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Swapnil Sapkal <swapnil.sapkal@amd.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ananth Narayan <ananth.narayan@amd.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Chen Yu <yu.c.chen@intel.com>,
 David Vernet <void@manifault.com>, "Gautham R. Shenoy"
 <gautham.shenoy@amd.com>, Ian Rogers <irogers@google.com>,
 Ingo Molnar <mingo@redhat.com>, James Clark <james.clark@arm.com>,
 James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>, Kan Liang <kan.liang@linux.intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Mark Rutland
 <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Sandipan Das <sandipan.das@amd.com>,
 Santosh Shukla <Santosh.Shukla@amd.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Yang Jihong <yangjihong@bytedance.com>
References: <20250311120230.61774-2-swapnil.sapkal@amd.com>
Subject: Re: [PATCH v3 1/8] perf sched stats: Add record and rawdump support
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250311120230.61774-2-swapnil.sapkal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Np+1EWQXjLlpql+1NDX0O7syvijYDw/2V0a0UsG9NA6ezKwhwt9
 6PY24Nkq0vUUr5WQcf0hVaJ64TgShyyxzGp4gXJCcIu6vyl3LIO1bNE8DPFlX2IoCS9j4kj
 UGurIZQNbLS/fFvWNRXsF0EdUqi8VKMydNgphKDU+TxMcCn2hdhtN/dHisF6C1ugXBCYVJI
 y97E1MpZPm4MmhUcNP41A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BzBHoab1J0Y=;+CfozBFERwrLP4bnqCwy8YkNFSN
 j/c/Q81YjwCvZRJpgozH0R6CvSmsjalRV9FQGlHUq49Vj+y6CpGLnMd5kzJY6yUxaCAigbG4k
 ZyHlys7J6m2cBzUuw0FudGTVKxsQGAPcg/bTXL10R9AA9hdGEh7xKMcBF1C43xXeQk06vfvjt
 KFQ/sinuZmXKZWE6AbN1UNurvOWyGLykM6SowLLqKRHf83sqf9izoWR7VZjJW1RrrAX6lOsQ2
 3hERtkntrCnURNeQP+cXk9x+J8gB9qjeTTJNS+8hKReEPnSD+g2DMBeqwUM0bGa5KZCYSfNNX
 uZ75GU2UrS46Ul1fo8tn0I1uJPd176uLIS70OjRIW4h2moi0q4vlOSzIxgr1s445mA8uhEfRl
 h/Aec1LCBDEjCa67QO2s0JJTGJosmlPehUx4yNmqwUFJqojDnZBidjE0Qmq972rf56FlicZAG
 csvotgZB4zcZIQED80x/bfP1F114lVCwQ7Id2IhNrLZ4YFtRGVURxezPkEARGEoC2lPSc3jFm
 CeQWqR+RLAhuH+pWoFA1qpI5lFCPh/dkxTWDtoAFHDUIQCkV0btKUb2CsCctTP88CB7NDBOlE
 CXOIVlNb4w63OX4Gd/DELc0qZq3sB8FS3GlqsJuoCu88h2aF8tAICG/BTRHihP1OOFBKN/zyn
 t6yjuSPbCIDHTfr5EoGdYxKGHHtneUMxsuXNh1B/iXSc+/3Yi+pcmatmo3gM9sR9+BSauZHdM
 UAiRgBDBGDaxIo3ahyDirim+WtgGxFitbj9qbFYd6K4UI8jWXsZbeIp3QELMQIAadz6UgtTK7
 F944J7PyPDx11sJTNp3vN6x+WbL1p7jMmKN+OSWcAwcwbToum2NYnguc2b37xPlNtma0TEhB+
 pLdFnrfqV4QHl+5t8CSsdbKeHNXl0YNhTMb3oaXhnDhzz7Ty/gUaYC2AfVzwRbkzlf4tQHo4B
 LBDM1/9GmQ12eDgMblRTsjT+ijG3lTf/5Zr7fDzuXb8BDJfXXLdP6WhdQR+RIo7LKS11fmtRX
 60KInQA8dG2B7w1knAsxMF/eCfrPb9ZNJdyQrke6NgVVtSJ3NUi11laj0NsvmMmbd+qxC2APc
 Y+4vKaL9N2iBrOhXsATziGem6gjaOxKBbZO+droXAv/OpIQFJANM+5sKCmqcejq0KLTZgtFL0
 IG6Xi59VuthA2YdtXGWiQErQJk1HkPXUvPZrgA8tf//eWUYHcO9LAqvFjSIiQv1v8/Dx0dmHq
 BFrjlwFRCROJAQ/tQ3wuNT6KCbdA3a3rmpTeuN9G2r5aKt44zeu/e8bwC292FP9LTWH3nRljd
 A8nWj17HkSgIjtotnYXOzStjpHD0En9I2t5AaaRsrecxhTlMrljUi4sR3mPo/F3cD8Dx1Bpai
 uEDg73E2rkAg8yLTPBmbB14tVQlO0dGon+RSwymNuh++JIQ+gAoR/gnMjmkE/l5wThgRKaPN+
 WFBGIWamc4W9fRjVtA9c74x7lsRCpyrqzcO+9jRtkNIpC35duNgMmQQrlnHRndcc/OT97AA==

=E2=80=A6
> +++ b/tools/perf/builtin-sched.c
=E2=80=A6
> +static int enable_sched_schedstats(int *reset)
> +{
=E2=80=A6
> +	ch =3D getc(fp);
> +	if (ch =3D=3D '0') {
> +		*reset =3D 1;
> +		rewind(fp);
> +		putc('1', fp);
> +		fclose(fp);
> +	}
> +	return 0;
> +}
=E2=80=A6

Is the error detection incomplete so far?
https://cwe.mitre.org/data/definitions/252.html

Regards,
Markus
