Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274E4127E18
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Feb 2025 05:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739512221; cv=none; b=qAMZkHlNUBSoXZCFE+BfGP6sNVkOv9lLS9SGTEL7AwEdg6YsRPD02XGILjxTRRFUvIBYAFGpWnic0holZgXERF+NEcMcLp9al7qX7dSngj/5iHN7ggSO8K6sMv9z2Rjv7vUY3iMpk7fY7kuIsy3H/HmZkFkIE4aFmlBCOfgyjhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739512221; c=relaxed/simple;
	bh=ohfHThwDqdnHseiN1XdlKASf+gl4/vMfEdb7lSYzEpw=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=KX67PJiNFrUYf1tdSL/cq1Rjy53dBNi4/nKU1FdgdJWGXsOHmNatc1ClifKm7CxQrDQVqlpwgud2K76eg1i1Aid3Lghqbz5jXXR7w+/KpVDMpcvQZLVsiONhEx95PCA6hwwBpvTbnslNkZNC49PYtW142i9C8A00b0Z5rE5MWis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=pass smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=f7D8DnOI; arc=none smtp.client-ip=43.163.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyyself.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="f7D8DnOI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1739512205; bh=kuaEfA5jeCLNmqEp6nbVFJU+7x4Nc54jrs4+fyR+x8o=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=f7D8DnOIO5yKaO02aZkkL/gB7pf4JvYkz4RF6lsI/9uMl81HOUgAig9+3QQQQ4LgK
	 EymjO6txLqKT9eIr1q+Fa50oOzISPJWO/XymGlmNZ4xiTP3YXGyUTLANo2R7iKAAOb
	 /sH2NtmSYgF5UL+aZfqyaBMg1aerZHx3xa9tCei0=
Received: from smtpclient.apple ([240e:379:2251:3600:540f:f26b:e57d:d390])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id C783140E; Fri, 14 Feb 2025 13:49:56 +0800
X-QQ-mid: xmsmtpt1739512196to9ryvlw0
Message-ID: <tencent_45B4E91CA370C563D6420A1A25F992056D09@qq.com>
X-QQ-XMAILINFO: OIJV+wUmQOUAhsKvSrCboBLbOvTwz7BPR/J7d+3ZI/zlZHNYocoAT8aGPVQEaX
	 YwuZld9+TrvkekV8QMnu2tV9Ue7nCeulC93wr+3XbKzr1KQo9eyzJ25fJYEXKiFSDUqXVMXkGSVb
	 TGPzok1QGjyGv7zHlb7fFuwPNfSGb89fjz47C8ksozppYKgnD3AN+qTwtaaMIU0sL3w9hNT7AKUW
	 UrN5zPdRckWosm276Q3rntZIDJ8xNHs6D19ttIpAQZguCRSU0mkFnxXVLBwBePfH7P0ZjqsxYy8n
	 kjvYaFTNARTxmMerlNaDdAaRF3cZiv/Ey3hJCDWQcicDSrCvs01XvqggaXDJjHmBlKORVD7BoXkR
	 rWs39F4aZkydcfOwlIOWWO8cP4Jpr/bdTkj/6FxObV2Cr4VqCpqMUCYJBJT4UTgLLcv8/0/+o5hC
	 6vRF06pCW0eLT28weRuo0kD80bDJiZEF8IY7vx0etOpKEqjIFust11o7Me8ebNEywXp3jaE11AmE
	 yPG8h67o+WmKY9Vw2J6MemgCuZDVfnrkAOAfIZErEASh3YmC+pnY+SQVtkTdCfwL0r6yv6J5ZOz6
	 oj08dEDM8ZQ9fXZZxqZE+F216MbQLi1vnVpcIoY0RFNjCT6cJme5CG5mnPIhCrkvNYNmqVfN9JMh
	 TdhStbh/paxUs1s776FcTpNBflTcAhnjQtRwhUUPVYrtXr9EnZ8Cwphc2qYr3quc21QUpOk1c/VO
	 b8JaSpgoISJuTEIR/KlGC0FZusWipNe14h9KEfzFhVNJ/mgwkYneGw5f+uS3OB24V2CsfcLG3Oe8
	 y+aNprM3WhWWcp5ZrKGC+y2TkZa5hM5XZtZ+isYQJUVbIgkLaNMnhsvjEgU0nvi5ujwWy0WASajP
	 R8s6X17hVE9mxALcsYfNSTetBS0+1oUxslL+ALVI6KGkFhc+lJAqkh0PQA92IZPJlIyGiqncFTYy
	 cBUQ3VmETcQOP4upQLqnAkHeEtNTeF
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH 0/2] perf vendor events arm64: Add A720/A520
 events/metrics
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <Z66YjGvjD_yzEHUg@google.com>
Date: Fri, 14 Feb 2025 13:49:46 +0800
Cc: Ian Rogers <irogers@google.com>,
 linux-perf-users@vger.kernel.org,
 John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>,
 James Clark <james.clark@linaro.org>,
 Mike Leach <mike.leach@linaro.org>,
 Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Liang Kan <kan.liang@linux.intel.com>,
 Yoshihiro Furudera <fj5100bi@fujitsu.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <9171D06F-03B3-4316-A82D-DD4191762D3F@cyyself.name>
References: <tencent_5360DA048EE5B8CF3104213F8D037C698208@qq.com>
 <Z66YjGvjD_yzEHUg@google.com>
To: Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3826.400.131.1.6)



> On 14 Feb 2025, at 09:12, Namhyung Kim <namhyung@kernel.org> wrote:
>=20
> Hello,
>=20
> On Thu, Feb 13, 2025 at 11:11:01PM +0800, Yangyu Chen wrote:
>> This patchset adds the perf JSON files for the Cortex-A720 and =
Cortex-A520
>> processors. Some events have been tested on Raxda Orion 6 with Cix P1 =
SoC
>> (8xA720 + 4xA520) running mainline Kernel with ACPI mode.
>=20
> I'm curious how the name of PMUs look like.  It is cortex_a720 (or =
a520)?

The name of PMUs comes from Arm's documentation. I have included these
links in each patch.

> I remember there's a logic to check the length of hex digits at the =
end.
>=20

Could you provide more details about this?

> Ian, are you ok with this?
>=20
> Thanks,
> Namhyung
>=20
>>=20
>> Yangyu Chen (2):
>>  perf vendor events arm64: Add Cortex-A720 events/metrics
>>  perf vendor events arm64: Add Cortex-A520 events/metrics
>>=20
>> .../arch/arm64/arm/cortex-a520/bus.json       |  26 ++
>> .../arch/arm64/arm/cortex-a520/exception.json |  18 +
>> .../arm64/arm/cortex-a520/fp_operation.json   |  14 +
>> .../arch/arm64/arm/cortex-a520/general.json   |   6 +
>> .../arch/arm64/arm/cortex-a520/l1d_cache.json |  50 ++
>> .../arch/arm64/arm/cortex-a520/l1i_cache.json |  14 +
>> .../arch/arm64/arm/cortex-a520/l2_cache.json  |  46 ++
>> .../arch/arm64/arm/cortex-a520/l3_cache.json  |  21 +
>> .../arch/arm64/arm/cortex-a520/ll_cache.json  |  10 +
>> .../arch/arm64/arm/cortex-a520/memory.json    |  58 +++
>> .../arch/arm64/arm/cortex-a520/metrics.json   | 373 +++++++++++++++
>> .../arch/arm64/arm/cortex-a520/pmu.json       |   8 +
>> .../arch/arm64/arm/cortex-a520/retired.json   |  90 ++++
>> .../arm64/arm/cortex-a520/spec_operation.json |  70 +++
>> .../arch/arm64/arm/cortex-a520/stall.json     |  82 ++++
>> .../arch/arm64/arm/cortex-a520/sve.json       |  22 +
>> .../arch/arm64/arm/cortex-a520/tlb.json       |  78 ++++
>> .../arch/arm64/arm/cortex-a520/trace.json     |  32 ++
>> .../arch/arm64/arm/cortex-a720/bus.json       |  18 +
>> .../arch/arm64/arm/cortex-a720/exception.json |  62 +++
>> .../arm64/arm/cortex-a720/fp_operation.json   |  22 +
>> .../arch/arm64/arm/cortex-a720/general.json   |  10 +
>> .../arch/arm64/arm/cortex-a720/l1d_cache.json |  50 ++
>> .../arch/arm64/arm/cortex-a720/l1i_cache.json |  14 +
>> .../arch/arm64/arm/cortex-a720/l2_cache.json  |  62 +++
>> .../arch/arm64/arm/cortex-a720/l3_cache.json  |  22 +
>> .../arch/arm64/arm/cortex-a720/ll_cache.json  |  10 +
>> .../arch/arm64/arm/cortex-a720/memory.json    |  54 +++
>> .../arch/arm64/arm/cortex-a720/metrics.json   | 436 =
++++++++++++++++++
>> .../arch/arm64/arm/cortex-a720/pmu.json       |   8 +
>> .../arch/arm64/arm/cortex-a720/retired.json   |  90 ++++
>> .../arch/arm64/arm/cortex-a720/spe.json       |  42 ++
>> .../arm64/arm/cortex-a720/spec_operation.json |  90 ++++
>> .../arch/arm64/arm/cortex-a720/stall.json     |  82 ++++
>> .../arch/arm64/arm/cortex-a720/sve.json       |  50 ++
>> .../arch/arm64/arm/cortex-a720/tlb.json       |  74 +++
>> .../arch/arm64/arm/cortex-a720/trace.json     |  32 ++
>> .../arch/arm64/common-and-microarch.json      |  15 +
>> tools/perf/pmu-events/arch/arm64/mapfile.csv  |   2 +
>> 39 files changed, 2263 insertions(+)
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a520/bus.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a520/exception.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a520/fp_operation.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a520/general.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l1d_cache.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l1i_cache.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l2_cache.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l3_cache.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a520/ll_cache.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a520/memory.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a520/metrics.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a520/pmu.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a520/retired.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a520/spec_operation.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a520/stall.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a520/sve.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a520/tlb.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a520/trace.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a720/bus.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a720/exception.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a720/fp_operation.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a720/general.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l1d_cache.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l1i_cache.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l2_cache.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l3_cache.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a720/ll_cache.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a720/memory.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a720/metrics.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a720/pmu.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a720/retired.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a720/spe.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a720/spec_operation.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a720/stall.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a720/sve.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a720/tlb.json
>> create mode 100644 =
tools/perf/pmu-events/arch/arm64/arm/cortex-a720/trace.json
>>=20
>> --=20
>> 2.47.2
>>=20

