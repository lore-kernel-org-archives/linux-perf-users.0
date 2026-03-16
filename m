Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1EF3939A4
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Mar 2026 11:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773661895; cv=none; b=mZKIYhsa1isS0jyobBzAFtZJmJHsmgmZbOGFCT6H1sQdZ12OzWk908lNwxGkqd5s3JkZe9uRvF4HqFFnr1UQ+DXlvLI381Y6t03UwgplnFtP1t25XDqrgsMVAYt3U6l4YAZPiAXfV7SP97ZW99TCZrsmgBOmiTNH74rqj5tIEb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773661895; c=relaxed/simple;
	bh=wMfcOM1E8NveOMqBTy2g6Kl0T5mgMJ6P36Bxrnzupx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KGRpl7Y1gST3rkJ2VYlOPyaUVG9cgBZSxcZAx7REGD0T7k8tHfpOG1QD3eDeSMQDLoOFkO1TwVOeI/LmNdtxjcfOnNRtIkbY2lPuMCrH/rgwrkPbhVeyf8DiTxiX1shS2vCGNMeXlRstcy05Eu44A1LqWczqie2D/bpSSsopqms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jn5C4KsD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JBvK2FwV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jn5C4KsD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JBvK2FwV"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GBYaOw1282088
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Mar 2026 11:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+ZXaHmFaCXo06Z77INsskRFP9ADKCiNWDgJzdazMXTg=; b=jn5C4KsD9OFzgWxR
	MrdUrbYqFnKXwZzWsOVEVJE2t4JS6NeWON/rsCmqtYcpQQHVPYv11tJWf8J5zN+f
	gWdtYyyxmnjQyljVOuqDhD1ivVpREbikOcLyAOF+dZh6zVYB9NqV8rFeiU88+dw1
	aA1QJYxz+RGOoeMvzffqhiFsi0X4/gK2W4DGa+aEi2Othp6vJIbkQoblbxd6WJZe
	1sIzibrRG1FqL6x6tGR6rauFQ4ZuQlWd9VqnJZSzpgykRRq7SMDUg51COHArf59g
	Xm3xmtxPWLcoVU9MS/4/i2tucosBqVchnPJ7K/RcXhAOhArRWZh+/5lD8/3kgBqt
	JVjaMw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvyyc5ett-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Mar 2026 11:51:31 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd7d4cc049so5069233385a.0
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Mar 2026 04:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773661891; x=1774266691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ZXaHmFaCXo06Z77INsskRFP9ADKCiNWDgJzdazMXTg=;
        b=JBvK2FwVgUdI8j1gSxDCRbIgKj5WR8FoY/V3lfW5iNeUfjLz6dedukEvqIc1EevzB9
         7K7KlnIqReXCfDMiY2rCbepBc+Q1frzXTZH8+PQ/HZ3csP2crqMm1ev1pK9FkIpeuPly
         MMEGP+SrL3ye7vzQB9WnxUmUGtdpn8X1VVdQBFp0yeIrzNe/m6rrrxMVmQRj9Lu0qbSI
         TkzkK08lQm8VVmFW4cZr8CfkSuvLl9pcFFKOd4Un8KZBXw57qEKIvCKE8QOQofrblX9E
         AFwFUrOvx9MXGRF+pAZbYk73xwS9gjO4fMLs+z/qgbOoZCafvYPKuy+nr1T6G2fdqdRQ
         UsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773661891; x=1774266691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ZXaHmFaCXo06Z77INsskRFP9ADKCiNWDgJzdazMXTg=;
        b=LX42Ua+ZNdNn5yktEs9e6+quB/g1xcU+ahn3eGA3TXVHLszdJroke5sHeulb43Y3WY
         dxJyNSC006wqoo+KxboR6urz0CaBAyRm6WpnL1snQYio3asjsrfD1Vx+OjmohzNSOpCB
         SJFTZi38qMzmPgbwdhrBO/FHMl0BhGR+ibYipPaLTSf3knDs5MxCbNyy1xpWc6Gxg+5A
         4GEzL7JO/S7YBHDj7q2J8BoMCWYJyFKrtSrzZ2qrmDMXgLaOrcZKSiYVDN/geu5X4Ymv
         gBKFevtWbsRZ8d9IzCA9uvCofbx5Yk18c+jAxgSlaMSMgh4/vQIn1IQo9umCIRDvd5Gp
         GuoA==
X-Forwarded-Encrypted: i=1; AJvYcCVBzyv4GnkskIsDXR/XyhnpWPZrXrHWOz9it8yqs36Ttw2eljGQkV3kcxoLhQ2LzYNO0JYao5PiW2YxbotA0MQ2@vger.kernel.org
X-Gm-Message-State: AOJu0YwYmxsTjdj8ssRGX4dB+l1oLJWyv+yHtovM2znY+keWxdGJjSqa
	UExAUoZj7GqLZ1nI4qpqGiZtqS2PFqni+1STBVSBc9EgpCHnBC0FiMGi5Ng8YXQp570SGlrxEYi
	KixbrP1/WyaBVMpjGWep9LhQhH8fXI5XXe6/ewVd2qdKJzDUfziYC3wFG64bWW8C6kjpUn8sl
X-Gm-Gg: ATEYQzwkDEDibPrxk5c6IAiDID6bVok9/uFYmQxgNWr0jjLXqLTLbMii5523Ig2s+kU
	Km49b06raK0Xasp3PzpZWILiC7u0FBCh2tz9ng3yCPq6Z8j6QpDshBiuDQVUKes8MLED2J/Eqa/
	jD+/Dkp9aeSNzjGt/kpojxPvrbCno4jQTLPyZIxfiRkrGL45B81heh6x0vQQkD236Pk/AgcjGo2
	bejuQ6DSQ19JXHCs6ssmBR4PubL3ssdGYkMKaDZ2kbI6ewGKGVC80/y53hCm1VALIHg8owvBf5H
	SKPuVxKMMdnLGE1QPP+RhYVkeVdiLSAqHnfnJFcfEhRNH+nCBYNDTj6abwsS8MGB6pheBF+FDPb
	oBMDopKfLTyrkx5eY4IMniBNcuDtd8fxZHdFrCbt9fFt/gFTMAscYjk2mnFumxs2chVtz7v8DGg
	jvVzXPBC20
X-Received: by 2002:a05:620a:468c:b0:8cb:4d64:e993 with SMTP id af79cd13be357-8cdb5a964famr1517107385a.26.1773661890666;
        Mon, 16 Mar 2026 04:51:30 -0700 (PDT)
X-Received: by 2002:a05:620a:468c:b0:8cb:4d64:e993 with SMTP id af79cd13be357-8cdb5a964famr1517101585a.26.1773661890086;
        Mon, 16 Mar 2026 04:51:30 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:5dfc:3995:22ce:d286? ([2a05:6e02:1041:c10:5dfc:3995:22ce:d286])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b3a09e453sm19896229f8f.0.2026.03.16.04.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 04:51:29 -0700 (PDT)
Message-ID: <9de4e5fb-3ce9-4b3c-aa51-f7e09ac5b3e3@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 12:51:27 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/30] tools/thermal: Fix typo
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>,
        Quentin Monnet <qmo@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nsc@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        William Breathitt Gray <wbg@kernel.org>,
        Barry Song <baohua@kernel.org>, Qinxin Xia <xiaqinxin@huawei.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Kent Gibson <warthog618@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Morton
 <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
        Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
        Mark Brown <broonie@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Gabriele Monaco <gmonaco@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20260311-tools_build_fix_zero_init-v4-0-9e35bdb99cb3@arm.com>
 <20260311-tools_build_fix_zero_init-v4-2-9e35bdb99cb3@arm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260311-tools_build_fix_zero_init-v4-2-9e35bdb99cb3@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=euXSD4pX c=1 sm=1 tr=0 ts=69b7eec3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=7CQSdrXTAAAA:8
 a=VwQbUJbxAAAA:8 a=9qkRzJ4zGrA7FPkgJCsA:9 a=QEXdDO2ut3YA:10 a=u2kJyrKl4JkA:10
 a=0lgtpPvCYYIA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: MdjvwEj8D3Pi-NaWKtqonBdJe9ImMNMG
X-Proofpoint-ORIG-GUID: MdjvwEj8D3Pi-NaWKtqonBdJe9ImMNMG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA5MCBTYWx0ZWRfXx7ip2bxjvvBe
 d3BsDGqbAsg5Yzlmi5COkhMJ+4XKQn40Ck1z0OUddX3AJYjxsW4h8zgQi6LqWBjla2h+xOlE2Im
 nxXn5LRHu5T3+YcBrNRYQgiGqCm4Xy/5UJT3p0fDRQRdcLvnR6PPecgIVvoioLugkmGcWAiiFDe
 WtSW6ngqz8pd1FIPb8D0I4uIgMJzR9xUTaAuSt+imRCEEUN4IAM2E0X0lOStnokVy6SI7NcsCef
 8IZi1vradqJmVcVvXFAhROFcCxrOoQj2e4WW2rmG8Vk9KvDahIrEgV+5YLu0kO8gW9wCtE4v4wU
 HFVIBskpb2F0UcymAH3PDMsoy0/qRhTQ0RXLJU43c6WZrCM3/yGqVSMGOrQzch5o6bRqI5P2mQ2
 xGU07vWfhn86Uv6NNz2wv9vzbu5a/XTVFucXaSsi1JeOah0Qq36biN+HvyzTGLQvCru0X2Wzjm3
 uXjdh9n5dX69qRHmDeg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160090

On 3/11/26 09:29, Leo Yan wrote:
> s/CFGLAS/CFLAGS
> 
> Fixes: 3b7c5e8adf9c ("tools/thermal: Add util library")
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@kernel.org>

Thanks !
