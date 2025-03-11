Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A601A28E37;
	Tue, 11 Mar 2025 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741710041; cv=none; b=tghNxeX13Ec83JWhU949AKTFgVekT4AWIqhG7cDRUnWBO/gvm1aCdSFVR2Eo60j06GzRbpTbBE2chYBzE6DAf2tTWbPULtMbTgcZnTrxYIwx1FquZ3Ydm1MmLab/rOUfxLuh3VU6DEyXKlc26KyoqvU20t0U9zy6vgqUGr98/Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741710041; c=relaxed/simple;
	bh=n0yYeqbK1TtZfiX3S5Far9ApkfCzsUX7ORiF2PzYhAw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=NrSmlLiLK4bvwnlttgJKrcD1sR7X206P+7coiqLOOqrzwqer2E0zO4HIYfGx4n1Jb0e3+wi9Gt3k+KxtqJTs49xLOVlpHHungmAuMXrX76k7P+iz55W1NnnW5cOCHL3yAGlJrV+U+McTW8XLUiSVBvVV8wb50LZx2XD+BQsRB2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=XlaK9mEl; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="XlaK9mEl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741709998; x=1742314798; i=markus.elfring@web.de;
	bh=Q0YquWyi0aeoObq4PH1WiYn9z1rRfx0PKsLFH5ftUKc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XlaK9mEljy/pUx8AeXKK0bdSOhpYINQ50qAm/eIjFO7/rooBkaq3GfMDiPItUHM7
	 PXYizrb4L7ikh1wp4/ntfbaVnFmqz8u6qt8Lq4qpD8AhU5t2YP0dRE9pKhQbqDYL6
	 jh/+y5TgtuK0juXIlEh7gH3eODVUQrmr+XLOaY/iATczc46O3WBl6KgEjJaB22kdg
	 tRckTZXaGWpXbMP6DeyHOYrnSbLgbsLgIYN1kATTKhBQsLHX1ut1H5OGRDlEo6N/2
	 W114GAZn1bmiwVYPJ4y3yCRINF9kXmF0QIRYNItoC2V5c/ERWAXotjbPD543zZ5Co
	 q0m8lfgvRdZQSU868Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.40]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MFayw-1u0HOV3jVW-004urc; Tue, 11
 Mar 2025 17:19:57 +0100
Message-ID: <56db239f-77db-4b78-9928-8e7cf4e8d793@web.de>
Date: Tue, 11 Mar 2025 17:19:53 +0100
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
X-Provags-ID: V03:K1:uHgbISX4hapVCieXRwSHryBlCrirMnK/ApGQTOTVBAQr+6b2POO
 Yb572YGGrDTNH30K/5WdhvcS7P+jDmNd4JkfbrwCn72+WKJxc6Idpa0G+4ARNIXAuFWIDsI
 v0JRC2VeSaNaxlHYwOlBcq/OW9b51m6/3gNnS3g5wN3GT0KC10Odc29tcio+bVuEM8esta5
 h4QQLl+Tq4araYDgtfgIQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h6h/3T5md7A=;9JqbLFTtNwd+hcGVTt5CgINt7Ny
 2VKakjFYKTqRxaT6npCDM4elwcz2bqd8nUwHujGFHTFkuG3vmVbi2kg0mnfb/iGHfgsR0a5Cy
 NTqeaXTEZFUtFXh9jIyZ9Zl3rTlvCTQoyW1DnTzdHGhMk3hCWC3YTwiM6iuYSgMl+QYBDggPP
 Q92VIqgZOA1TO2i6QpXyQqpze6W8XdxSsccta6Xq3R2EMkz2+jzr/wFSc94TExyNq0PbjiQGi
 BkJxg+EFqUpyQTqe+eYB79aoUuGA1g2DImyQWavRK4H+uO8CCzyPVab1HMJPhfeREcOh++0Bd
 5LxgQnu9WEn9XZHDsALnoZ/wUXvfLy04RDTHv/LJpbMG/CZPGuYbKDDQ5O6unV5DyvcMlCTpt
 px2Ht0zVlh5oLxOp4WnMzIGKV25vtOMhd9/edy8XJ94MZdr3LwWPWjHCDXKN2ETg5XBHmvjJF
 s6wUuLBHABtmSM1ot1dr2GsoUYMDFR9tCmaX8X5XQaHqxHMZ/AXzXwXaE6/SIg1t4lF+nb2dH
 kHF6oaIti+n/oghQiu/BYTcznwfB44tqI50shmX/Ce1mn7llGs0DtDSeeoaViejfeNAw8u2L3
 EYo1uFcbVE6+PH9h6It6ACwqSAEK66/cV62ugJkf90EMGBbQ4S4Yeus8hINZ6HGn6oXgLLiOO
 YrjAU0kAZxMVfgHXdsBwRDwk1MLbUH2NUbXJGKUZdGUPBXkOQPFS5tI+UDDiK37quyuP/n9uJ
 2d+T6aN8E79ymAEuVyG6W/irdN1nBaZUSikdyNPap11TqOp6xcfwkZw1KGPWCrV+dRCVvRm3A
 cmw8jpGkCXYYxS0jAR7Z4Qr+XOa7SrxA/piwz49obqMIbxpuaqkt+F7vnrJP43i9IxwkdjKGX
 dN3gJutAmLN57JfrXf+2dNqxgAe0VT0CRB1FqESJdyRQFJ3bejkIOwfxfl6PeKI9VHEGwL3ac
 6ArX/dkb3hbTHg6ME92TtMDwtHtR3qX5r4qEMOuJiIc7l9lZWkFW5Lhe6ExJqiPElNDvGmYv3
 sl3PYWZm5Tuq2ojH6pVCP9j5bWkz7PmUTVE4ekmymTCY4IRsS84Ap/dsdGfJrNHOQTRKnzMW6
 lyzriYHxDDiFjWWDO20qU3gBL3+QK8bAn1CeI9vT7G6tdZZcBHsC/je4NCvy4aGvMGD29NYYG
 7B8/dr+KhpV5+8GX334jCo/zI0ssBCqMJul6S2S0tlO1mzBcWPR4ddoV0kPSgvbcQ3TBEIInk
 1MUo+lMJrhBYdzTk37mYJF84c5cJmFkHI+WGQKNoX6lgHtI2DJC0FVmZ7SU3VDGVnkPFlY5yw
 6XIpxV0OratnbcE/oDzrc9+TLc4J3WJ3hRnQk124MGjKny0FXHZEnWK32kS+xuVbLvfkCsybL
 Nk8qW8PJh7Aa1ZOCtq4oxieFwR3RnlQOd3dekxGVrMXKgOS01rtT1oROgu/g7D8PCQssFY7mL
 Cf7eGFA==

=E2=80=A6
> +++ b/tools/perf/util/event.c
=E2=80=A6
> +size_t perf_event__fprintf_schedstat_cpu(union perf_event *event, FILE =
*fp)
> +{
=E2=80=A6
> +	size_t size =3D 0;
> +
> +	size =3D fprintf(fp, "\ncpu%u ", cs->cpu);

I find an other code variant more succinct.

+	size_t size =3D fprintf(fp, "\ncpu%u ", cs->cpu);


Would you like to care for more complete error detection and corresponding
exception handling?
https://cwe.mitre.org/data/definitions/252.html

Regards,
Markus
