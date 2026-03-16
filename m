Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780AF392C20
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Mar 2026 11:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773661865; cv=none; b=QMEQ/1o6ut4EkKSjAjKRIfhXRnfUMAJULhz/2rv1NiO3TMCNiV1awlLxleaadSgsTNwsFruU4rQXM3CHa7Ug+VtxMesrKQ2ttKWCtGu2NQm1WbKjzwCWGzDNCqwo5yKCThQX5IJPBJpfGgShFM8a980Yw+dQgGbRoHpE5Q6e1y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773661865; c=relaxed/simple;
	bh=qajJOJLw9mBKXM/E3+A51MHsuJgG4aC81Z0RI5fTgEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mcJ2Pv/b1OSpSB1ZH8zMfurfPT+1SmV16E/3rJU+xVfNx+IabYXFIn2LL80VeHT2cg0Vwi5pCCEbkrU4WYkLtIXwprH5uXakL6B4m9usK7Lj/mkIup4zL1FoEdwFPo8/k8YC+adYOTR8/rkVtdVk97//h1Y3hoCcz0KyUeqqmqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ojJzDsWN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dnBugXEN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ojJzDsWN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dnBugXEN"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G7mp4i041519
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Mar 2026 11:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qunPmJdABJcMXtrTkw0tgSEaTgsE7szyRj+/D/lI0Nk=; b=ojJzDsWNfjCQlG+b
	VxYlZjBAVLSeZCHiG4pmkK71Flhmt+ZrHnldp7v0YaLF7XkcVedMQxvFMAiyN79/
	/4TvNGS/J+5ix6BkUiTiXquQ0tLHhujkdJkbA73eeIyniWCE9uUQIVEFS/0GEPP8
	q668pYC6r4HN58sH1YKslxOB+MKerr4cHKe4RFYc9xGchoe3r85b4Xd5nEpiV/fU
	y2cy00oI0nPtmtAhjlana8tNoA6w7aZ4d1Nm3B62NS9yLeIHczsCFp7lUpAPfYOA
	TPt1AGMTUGSYAJRsiejp1D1TvQ7yRZW9caLbeBzy/k7boBHE6Pa/F8sh5LP1tvfi
	AiZQ5w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxdt80ymq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Mar 2026 11:51:00 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd80bea54dso2836742485a.3
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Mar 2026 04:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773661860; x=1774266660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qunPmJdABJcMXtrTkw0tgSEaTgsE7szyRj+/D/lI0Nk=;
        b=dnBugXENY2Dk2Gr1xJ496hXdeFA+/UrPz7kEO27XzLc4sm3W6dyUny6uNBzNY9p9bO
         NUVEmf6BtuG01Y5Xo1nEL5Sb74ux19y53e39Ypfvi3OrVayv7LSDVhvSf3neIPUCOiwH
         D/J17KXyWoo9EdjjBGSZ+uubFIMHJjF62sbcuOC8Q34SxYzkALKdOIdMOFCzpbkZlI20
         Iltx6arimaw77BzEg4o4EHeZascj0zv5qGyf087+tj637jzW1EwSkFdeoKpsdRSzNLuH
         jeQo+gnCWl0cVV5OxkONAg5vV7HmoXIC3MrB6CwGvS469KbKawLMUrwedV1zWsyG4kOS
         mBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773661860; x=1774266660;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qunPmJdABJcMXtrTkw0tgSEaTgsE7szyRj+/D/lI0Nk=;
        b=K5cpZ2+IQMYoNOaj1Aeq/+sZlY4k/td8J8Sf981EJ/rULemGPRItbfA4KxoupoThXs
         UCEhq2W3h0sLP8hdffF4dWMkAFrsJiyllAEe7E1WRRiWtGjO7jyo2mdZPAjiZpxMHl1D
         xI/Krp1958J54JDe/okxLzylqXRsJG6f3zktyHfrljyq9qW+oyGE2nuRnlUFnH4uSPUp
         SJvPk6q3AvL3d5tpzd5Or5VrNmhGpQuQQbWwh5v8THG0298G65EYznrPEos6xr1TQwfl
         5ze3LAp7id9he9cQ/1YSHfl+dmMYprFzoxkVMBgoCj8Y+5H+4DvCJQP+64ppc+wM5bS4
         2R1A==
X-Forwarded-Encrypted: i=1; AJvYcCWAcZqbNjR2d1/uRRV3NvE8AcmrN1DotaAVVRVQ0Sn2F9GCzD7rJy8rAxQv4NlPnyAB+wMtiKAFfE0XwjRUmBLJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyMtqIB55WmGxGr0+VickIOTGodKO+rK1vbSOPrn2fzC/e7UjLD
	dX7hmLctd41Z+MDLhgkFieCt+LBgJB8/QpYgWqlg7oaJtSdWI07g/jObcM8v7Qsz9iZyzt8GBgw
	SLWkWOH29h9M2GNyWSGP9XTLkmR4/RenOZx/HORPyzoLtHiUrwgSdvlCYfZnbdh6zITXuQxOl
X-Gm-Gg: ATEYQzxlfOH2GibMDV+T3O8e+++GVtkX4nez9k1JMskL1nA6LN92eoW6VruJPpoQie9
	E/PjXZfW+QDYrYssNsHO4h726n/FWlWx52aYDtWPBSCV7XdYuLjowKKG4xRfCqlw+hWjWxNXw6x
	JKtPXByGCylXkJpYMM/PkLdCqEKSszzHs+i/Jp9FwPrAngdDtDR0lnOZkEfx8ON6V1jjIg3KHqk
	0tQQpR3BDWNuoJfPM+9Z3uTJB0h93ctP19dQaPV+JBRHEX/T/+gnDHvzsxN9h/WGT79atCUz/R2
	Z9HOVS1wpRSDzJCBGr99nTlEE1B4d+9XkfQMNp+ZIrqaKbPtRbfcn9QMSYIrWrx6c6cr2bK5O1D
	LWlOI2qHwJt2ZYXhh/5nr6ORdsD5ZOXBl/rdz4GqBN/4JL75gcXZkHj/yt8Xu5Xm+dswi8vkQfn
	ihTIxnYmyu
X-Received: by 2002:a05:620a:2916:b0:8be:6733:92ab with SMTP id af79cd13be357-8cdb57a672dmr1626231785a.0.1773661859805;
        Mon, 16 Mar 2026 04:50:59 -0700 (PDT)
X-Received: by 2002:a05:620a:2916:b0:8be:6733:92ab with SMTP id af79cd13be357-8cdb57a672dmr1626224385a.0.1773661859231;
        Mon, 16 Mar 2026 04:50:59 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:5dfc:3995:22ce:d286? ([2a05:6e02:1041:c10:5dfc:3995:22ce:d286])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485696a12d0sm23785665e9.13.2026.03.16.04.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 04:50:58 -0700 (PDT)
Message-ID: <e6c0df77-98e3-4a34-be84-6b43ec263215@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 12:50:56 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/30] tools: lib: thermal: Fix typo
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
 <20260311-tools_build_fix_zero_init-v4-1-9e35bdb99cb3@arm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260311-tools_build_fix_zero_init-v4-1-9e35bdb99cb3@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jBDV6Iiytb2FW0Zxj4Wm5F_hLOWnkWLJ
X-Authority-Analysis: v=2.4 cv=CKInnBrD c=1 sm=1 tr=0 ts=69b7eea4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=7CQSdrXTAAAA:8
 a=VwQbUJbxAAAA:8 a=Qrd8ctaAbqGiTqi1YC0A:9 a=QEXdDO2ut3YA:10 a=u2kJyrKl4JkA:10
 a=0lgtpPvCYYIA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: jBDV6Iiytb2FW0Zxj4Wm5F_hLOWnkWLJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA5MCBTYWx0ZWRfX1Q8USDNjKF5e
 ozzBTC4/y99P91cBrOEnpII6pEGIKaJWbNKLME5IEBJUfeAwBK1R5UsWbI9Rbogx3g+5jU/iXbv
 jbqasgTXpXoA5J4+bAmPCGbP2TQgWmBEgKmMptgmTV37YrOsbLAtFp5MNEUPf9zT7IXDM4EvGkF
 SFxxaA4cm3wr9BqgyuOYxn/dxaa7MeS4dR3Sts7hBCZDMChhaobqURqqJfUJz3RuJccQiXvuNu6
 HdALIbKoHIViKXfd1mH87+piMF/OH2XXlQEQMPRFShN+blTRrmMqIz6f0exSl0odmAz0KAUqOoh
 7PXHRSUq4CJbLVbIvueXtNMjxOUbKik8RR5HGzc3F6F4aKpyEVsOleeRNTnPVT7bWurZQIUtpmz
 GPc+MObg7uz1lL7lRJbq6w873Gob0qR72227XSR5un8p8tjVEr7baTfkkH2UWVTGf5p+debnMpj
 JxKrIJIeCzoQbL5haIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160090

On 3/11/26 09:29, Leo Yan wrote:
> s/CFGLAS/CFLAGS
> 
> Fixes: 47c4b0de080a ("tools/lib/thermal: Add a thermal library")
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@kernel.org>

Thanks !

