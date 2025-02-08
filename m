Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A0F194C8B;
	Sat,  8 Feb 2025 17:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739036287; cv=none; b=f2VFYeNOt+UY8B9OxEXXgelo+sgZGc5da/etcJq+kht3bM3FTOKh/4KHHf6hRNp6xDRBas96QE0whtR6kiPMGkW3GxjccHSGbbCq3PGlSLwDiXEUMQXheDjXWPcFOaHlxAgpjArsNE2piwiaupu3wyv0fxuTloKg2Y02PJurZxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739036287; c=relaxed/simple;
	bh=trQ5V8IeZ77zLFFvlWVpfikaXzktHRX+7wWFmCnfTqQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=RiMOGsJf7Ks94erxlQRY4w+pKmtzZuDyuIAOq7uVZ4HOoIXOYrcdY2STwCzhRdmGJff5G4PcYLOv8A9nAYWG4psk5Z0ryu9aj0xl3ROAzEt0fxl0kqLLoEuEvNzJ/QydLvZtKe/b4qq3ObDG25g+pv+5mecr+fWAptKGyQnXyYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HwvI5s8C; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HwvI5s8C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739036260; x=1739641060; i=markus.elfring@web.de;
	bh=xEiw6tA4dD9l23HqnH4yh77MThhAZVmqqkMgLZfg4ns=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HwvI5s8C55j8Fcz6ntj/y2VTUxgiFuDp8CZ88VOBC4r+gEmGLu97igiJWnBQoyvJ
	 rtQrd7ZOko1XaECkRayVFQ363oopIBKVc+jAMJts+lrfDCa8cZtahVgnAu+mlPx7O
	 hMPkJcNqH3QEqTqqTaWziGD8W2VcZ8TdcxIRYZc7ZML5MSk349laj8IdZz4myMMAo
	 rGkowTb9L0ABEJ+4LD4E4W0tYTAiUsVyLkTOsz8G23j9mZ2gc/xYB9V7bzhNi7YN7
	 pWMqHeF7oHM8FWXFko4/50G/lRgDGX/7BUWQX4WFk3Sdg7ajcPTNQZXo4luGwHE0K
	 cWX5ZCxgqPVBn9PLXQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.11]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MK52q-1tz2Ne1vpO-00TsYR; Sat, 08
 Feb 2025 18:37:40 +0100
Message-ID: <a926f05d-03ec-4c78-83f2-3a50299e8be4@web.de>
Date: Sat, 8 Feb 2025 18:37:34 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Luo Gengkun <luogengkun@huaweicloud.com>,
 linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>,
 Namhyung Kim <namhyung@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250122073356.1824736-1-luogengkun@huaweicloud.com>
Subject: Re: [PATCH v3] perf/core: Fix warning due to unordred pmu_ctx_list
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250122073356.1824736-1-luogengkun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LBDwCtf3pYQH7Ic9Ip3zlyABOhdxq1TR9NV7qouWWcN5MwGGESd
 r2G7WbB3+xBqgGD2hB2PY2aYgLjhNDaSFfoaP8W+jyyOh5RL2ilieRo1VXguNSW/Q8vGIg+
 xYj+CZFseI0eaOgyAxaeLzxHeJuEVG6pRZfM4NVZGHet2FewFoZLYArTS0EgYfCw7Q7u9Dj
 z+NjzFl8V89YqsOyB5DdQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zPLTwgLKboI=;iyC+1cQSwUPJoHSx/jvEqJ5sQYr
 /el/ffJU396AP6/CAFTRdhvpckLnbcpmlByT/ydaEIFJY3woxUn9Ec0lf0SouwisY8d1PMIli
 /aKiFzhp0/JN8z+CE7389rqPS95VYjLo/V06eXlpdqUt+XdkeNXyEEIzKoXCsSA6L1+i90ra9
 Ib4BSzHl5koMlO6h1N5FbSJ1ZA0w3FKsPZssrSdZZXqas7Zy+MtrG0J93MTtWVYzAj33rJK6p
 8MVN4RfP8vSPLvsJ5N9P7SIPffr0ahEsARv11Gm1EDXLTTEqGU1XYSfXFUB1pwnounfQ5NpwB
 1FvB+c8lMr1XUMWL/OREBeC7R++fxtRp9741rbUqPLY/Z6klUOp1j1rg3VAcuICGEe2S5a1B9
 TccWl1Iffbae/nqZKHq7lvymrDwRdf4yf6YOc6Hjj6LLDcv10oYT+WHwzc/n5yDD+Ic8rmOGB
 9+bGWTZY2zl4NZRdWutiuZNO/ZHX+PcTJSnD0fvcCjjrg4HhHbKSnWGHi6NsvnpuSSgNfgrVz
 4uJQH6H66hFqA5zUhfuC5R0i0iBmcS6yzHeUvlHY3hXveGZOGaM8UXA6SR+x6kda10auLJGxB
 jF9porrgp+AEQ1myzyEYPiuwVvEOBg3bRO/h+hleDQNpP1WJTUrS3qW3EYpvlBtNvJ5TVF2A5
 RAR41fiVZPUFKAS2OCmIs2SgvgJJzlvbK5QZf8BaZssXMPXDCnDgnDDr67RxNw8i8OWWfXPFc
 tGgXsZkiQIrtxNXD4bXi++dUSnim+oyK1soYrP5YXzeuQJ4c0e/96WFa/+VEX3Z0pWoaQuwe9
 Q1+IYgtRl1MdjpcsXSPZr3WW1z691+72z8Qvo6nNRStWhWz7GtuhsXjzWUDB7jkDvwHOg6P+W
 a4UiMmYMkH5iwERCNwj9+V9JrLpg8bD6C3FDjhwd3PKroLyoWQDkwRbIVzjNW/AfEhbunDg91
 b1pr61nTLwv21c3/Q3RIyLRRaaiUGgRN5cyZJc0j0eG6yHFRs+5S8ieFTm+2zDCLwRlV+qY88
 VlcGh2h3w+3pIZiSQ9HvyE/oTVe33Q2ola4W4WLLzGGkYvBdhKk3YlRtfpC1s5+cJI/A0K77v
 lZscg7CDhwpFvzOCJyFYKpVxhtzP9ldwwWhyjiPL/kfU7FAJZsvslmJ9zqn+BsQp2M6MA180h
 TsacKvNLhw5S3JSWG57IQ5H1B0YYlSd6ma3QK8oSFJulnGQPbKsQdJU9nUpqDD3ekoADeaEFU
 XzKiOGur24qpPfBNPULFV5B8FkZLjvzE8Kn/GYI4jtZjZIRKUOT6ejeBmKL5GpcO/U7Cy+X3P
 bmMW8gVaNsCaiG7eFvwowbSa3mhmrlfXJZxlWDviHzn7gxcnLebpjPx/m2dRXPYZgyhNIBokM
 aqgqyD7WyGzPA4rrOo3bLClMSv4fA0llfaVKbDR6wNp1d1yRv4Se72yNeH5J1WwttufPZGAiD
 fuE5jdQ==

=E2=80=A6
> The follow testcase can trigger above warning:

      following test case?


=E2=80=A6
> The testcase first open a lbr event, so it will alloc task_ctx_data, and

      test case?                                  allocate?


> then open tracepoint and software events, so the parent ctx will have 3

                                                          context?


> different perf_event_pmu_contexts. When doing inherit, child ctx will
=E2=80=A6

                                                inheritance?   context?


Please avoid a typo also in the summary phrase.

Regards,
Markus
