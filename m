Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D5D31E849
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Mar 2026 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773218662; cv=none; b=Qb0Bhln+l0rEuzVguIeKY6P1LreQxdhY/FDyC3iZk2kRKZ5JEnsZn6prFuvsFle8k5TP4a2C4jMUZSUQNZ6xV71bEUTAKzG10WtckrkKtYCGntd0ufwaSrYbEvTG5VmYnMD24dYuaJDwmG5bcxsPRnrxxKGdrXZaHaA4oRwPLVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773218662; c=relaxed/simple;
	bh=Imjp1fxzvFdfmkh1WVAbM18uVmKE1yiH3pmg83B4nQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BVE2zHQVqiD+C5+/l/VjbBsC5gqwvetSqkyOdWb9sQrIx/GhHQbpTY92REsUARFFdSq/MQZYyKJiLhB9r/J2TW1BbIC01IZxHCJPUZ7/xmQMWo/wyroxbrYirVuUvGw2EKGdZz3Vh24Fow7ODkkfgqRU+jtc4P8wibTvq5rnQG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XDk3i07k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RN36wmQ0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XDk3i07k";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RN36wmQ0"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B7rG6N508387
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Mar 2026 08:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EqiFk0X3+BAunLh8qic9ybUFgfcvYe5yryI0mSRxLWM=; b=XDk3i07k5AbMgZEE
	GPfzdLbnekR62LdXCUL2wbKO4dJuHBf5HvtlfhVS8gTAMhBWv2G6zp3ww7bY7cvk
	sflliOaL3Vab4D4/NIMSDO1xwwiINd5liCB2ewkeczDYaLxG31LqZW/ER/yrGd4E
	Y2avzBH9FkCKhqn5+qljEzCZ/UNcPCgizEfjtVlQpRLwEJQfm6FKXtM5SeNmhaLN
	q18X+nzPVATsnsGr8QwGTVLO1+ncxpCP/pPLvTK9NXP/Qe8xD8UZcM3ZM6J6QmHP
	nrG68etSME5UCppqhYxYYeR5HJ0y3siqmYNKyTLhDvP5cW+yP/aZt/ara6HDhADI
	UQ0ntQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctppajyqj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Mar 2026 08:44:19 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd7f6ac239so2194579685a.2
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Mar 2026 01:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773218659; x=1773823459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EqiFk0X3+BAunLh8qic9ybUFgfcvYe5yryI0mSRxLWM=;
        b=RN36wmQ0Xbe0ODFQEBx4IUNbl3KSsj3F2FdqFFiEQgtmleuVEzudFWAIqKO4KpZPZm
         yQwy7oz6K9Q3lBBu/PC8NIGATFRhXL2Xb9EPAo2q+U4LlIPxG72DWEQcFA+CQZY29YpH
         vwlvXAo86Acw7qW1EintpCJcEHPxGY8jpzisISCqdPdqXfUsoM0+jMnm97eWzPIo58Jj
         2ejAxN7yejLAAiqH5lLNtEzwhje0QhWmZ3Hf6alMxvHOGg7f7RZdNIuPA6+wGQBKfV4I
         wb6ImTlLpuqQFXoxsfLkvZxMXedYApYqRqTP7GGEL0E9VVIIHZ2DShPWgcFfm+Mof6q9
         KyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773218659; x=1773823459;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EqiFk0X3+BAunLh8qic9ybUFgfcvYe5yryI0mSRxLWM=;
        b=t4UiUDfMpqZqCQYRvOWC1OuGBwByegNJWh1MCjoKmparU5n+NQtlZExMQT75li3+Ar
         Q1jtRaTgEyEt0eleclIz/50blE5oklxTVOxgutGQgrtMxOqQGqsPEG3Um1UUQrjISfec
         FfIui12iomAcCvVYgO96j04+FjSEHWWO/vQiHsUpDG6m/0RMyAVrUA2cTM+ZY5alpump
         sPDrvW6SaFnExK0xyUDRaHsuwWfifTeHETrnVutqQIYoM/PUS1VYIA19QY3sZV3DxAZy
         aM/59DQzbA8T66iswZlrdoWT06WxRoyAZJhAjLGBvGZzf+iHawI7jbj5qBlgFws4Rw8i
         whWg==
X-Forwarded-Encrypted: i=1; AJvYcCVDHl0CmZzOfbmYfzv9mPMPfUQF6DXyOH3Oc/oC+UbECbPuZuVEL1kUK5gt5SlfFWz7Qkc7lGfjXFrJ/g/JR0py@vger.kernel.org
X-Gm-Message-State: AOJu0YxqH5EB29pJFjczlMJ2V/diOj9c9eRS3PPVO8s4tX/t6R43VXk5
	yVyaUcP8MIHznhOnk4yiRYzVJNd4ZZ6NKrAHBrIMHJhNQJP52eLokC4OU+NHNAHovGLgg6rab3V
	skbJAUgq0EW2IYAOB0iqXJh9q5EuXdQVrYNvgg5ihNWk3GtjVubY4y7oKVAGlw/Xp0V5Lmqds
X-Gm-Gg: ATEYQzyeFleba/CfgLQ1r14H9Ij9sGGjc3YErRT09xWEeMv8c+NadyiFejkwiWMv7VA
	IprUuHFR3F7GapN4TR9bZiHlYcDJd9J/wZk5qY3DupA06FWN18RuBel7P/XVqx37MreB6Appa1h
	CrrC296nfX03GzTewRp/hXwq5DJfxh/1SHX0JkMTtRnkARg/0hG8hYBrro/oNbrIA7/t5OFJgLa
	gPsMEO5OuxbyBzQ0vz6K7ouseDiCVHJNVm9/EFUapyhpqZakUMkaKFonMj4x3zUEffCZdhAHoJ0
	noQSWPnY/QpARNucnNVZmTAMZSc0lSqE1onuyo33MrbWGMQWUOKemCMJ3SSnUejmz6kG/XtVRBB
	yXu4ydoEWaGVrIrKHyhU8r73MGrmj/1lyLlqSWOHEz+K2DKbZ19j3DmsCjqd7XrCXkE5gIUIOIa
	kg4NbASJqu
X-Received: by 2002:a05:620a:294b:b0:8b2:74e5:b36 with SMTP id af79cd13be357-8cda1a58338mr222192085a.68.1773218659241;
        Wed, 11 Mar 2026 01:44:19 -0700 (PDT)
X-Received: by 2002:a05:620a:294b:b0:8b2:74e5:b36 with SMTP id af79cd13be357-8cda1a58338mr222183885a.68.1773218658603;
        Wed, 11 Mar 2026 01:44:18 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ae20:597c:99b8:d161? ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f818d5eesm5866352f8f.1.2026.03.11.01.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 01:44:17 -0700 (PDT)
Message-ID: <6707888c-a31a-4d38-a99a-86ae42351561@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 09:44:16 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/30] tools build: Append -fzero-init-padding-bits=all
 option
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
        linux-perf-users@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260311-tools_build_fix_zero_init-v4-0-9e35bdb99cb3@arm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260311-tools_build_fix_zero_init-v4-0-9e35bdb99cb3@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -bfJKIQUi_rznTu8YGWAJrP_aunMKKnr
X-Authority-Analysis: v=2.4 cv=D7BK6/Rj c=1 sm=1 tr=0 ts=69b12b63 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=fUoFdtiNKAmboDELQeUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA3MyBTYWx0ZWRfX7SX8b3aVe0al
 DTyT78peJRlM4cC47G3jpmRoC6pvCWpuu8T1guphC3ZfopS03ILT2H0SrPdvVpADMhJTESlRgeR
 4SHZFKNtWzJeAq+w3UU3Tr2ePSza1ebnFyyEdNJAMQ7xhxm6eoJ5TRpXGVmiRIT6TPIEJv8Hfql
 vbSaAJMO1buP9E7onP6b+mobuGS6GHFbmTW3xslY29uhhSBVQNZ7XKVZ/RZ6NMZll1LGHaKb9Rs
 oDpdjucELKVHrj4EJfGGhUKVn2zG0FtPNCKFng5PUFDExDjfB9Hyhjfq/3ZLxfUdnGZiWLczluJ
 Z4duQw7A30btOPbeAtWHzusPI3wRIA94GvADC+3KsHD58Lf4Qb24sdaOOcE9ftpcbkmbzs7MPx4
 cndx1t9Ju/mDEJlxhJAATDaWbaz4UqqQaQmjDpUrqycUPoPV0zUSFOw3wDmQxLTXMYSCqzfWc+t
 4ATUmOrvr0+YFkWoKqg==
X-Proofpoint-ORIG-GUID: -bfJKIQUi_rznTu8YGWAJrP_aunMKKnr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110073


Hi Leo,

On 3/11/26 09:29, Leo Yan wrote:
> Thank you for reviewing v3 and I appreciate much Ian's suggestions, most
> of which have been adopted into this series.
> 
> For anyone new to the series, the reason for appending this compiler
> option is described in v3 (see "Link to v3" below).
> 
> In this version, the changes are organized into three parts:
> 
>    Patches 01 – 07: Preparation before adding the new compiler option.
>                     Fix typos, adjust Makefiles to ensure the newly
>                     introduced option does not cause regressions.
>    Patch 08:        Propagate -fzero-init-padding-bits=all to
>                     EXTRA_CFLAGS and HOST_EXTRACFLAGS for the
>                     CC and HOSTCC compilers, respectively.
>    Patches 09 – 30: Apply EXTRA_CFLAGS and HOST_EXTRACFLAGS in
>                     project Makefiles.
> 
Through which tree do you expect these patch to be picked up ? Each 
maintainer picks the patches related to their subsystem ?
