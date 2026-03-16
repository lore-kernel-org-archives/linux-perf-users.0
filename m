Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485D52BE62E
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Mar 2026 11:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773661916; cv=none; b=Zvful/pwVs4Sw7AeSclOrXjdvOYb0UDXsS0jfY4xxLYzNncfHmt/n43M43hat2n8ZX7inlOO23iPR7tFuLcCXAqtl9qazHJ6wm5wCxWYL5WW1tO8WWMdF4UmGpqbBjo9Dyrlun1ARCg91a9aBVqPpZX1KReBiwWr/w3DS6z3A+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773661916; c=relaxed/simple;
	bh=YLpCc002qTAuD1kMTo9L2KKQ3cL9ptha/TF1A8yfeIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQ3hggg9A12xZjtgeTyWJR9z3gO5B3i6KIPtda0aZTZuZSe5dCeY+d6ICa6KXStFEocv8J+9Ts9TnYYQuOITC+y3BlsYmaTJMXuMlBAezgQHlnzb91Bw5VBiKhAOSMNFM/ZW2SWfxbcM2Si5fLJpKUPL/9ZgzTeQfaC2Nx5cYAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R7gZHh9X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fz1ndhlW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R7gZHh9X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fz1ndhlW"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GBn1V21067822
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Mar 2026 11:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JVZQrImfTrVRlq9EnXFdF8VyCUmvC/OmzTav/z10XOY=; b=R7gZHh9XPlUicz4h
	ApdGvsVcPW0AlNGGFSPnNMHzdRsfpQ9dZkk8Q20sXtLvj2zpPxt94+PE6ukW3SWI
	IUDl6ZVbt2JjlXZURxrJLC79qRoPNWHVhIxm52CpLWKffjY/oW5UQhdj2EW+90gH
	zpK1zTzp1q/qH1JH6UHZWJhFYlBwn6bS4cs9PhHWk3mK28PTq0dI9PxFdgIcZXSI
	QI+TnToLJdb3zKgYYBV1CwXAMuR4CKCCfF9ne1ryeYkg2MjOjEzDIowzWK3azep8
	OtpOD7W4dslo6YhaoDF+jNlZmZbzzYaWgBiCYuUHPMTRASEL/aC19DYNk+klafHL
	IH5BjQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw027dp25-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Mar 2026 11:51:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd849cd562so3013565485a.0
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Mar 2026 04:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773661913; x=1774266713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JVZQrImfTrVRlq9EnXFdF8VyCUmvC/OmzTav/z10XOY=;
        b=Fz1ndhlWkJoGaj3/p8V3UwaH1DhwuccaCJK0/7kKpnGyxq8SleFIOzODnPyqOX55ek
         hRxnG5+5WJlp7Hq82VXGU0HoFC71IKVm9d7OO1OATH4mO3kFVLyt4pfQdsXyz9OGAOaK
         e1HPtdaZ3QIqbW47+We2nIxx780QktkRFD/d4mrJQl710JmPgXB0/6x7G33ebfpGw07H
         PU2phW9hD/Ox31Psd7sDtzbLrf7ScHLI34+X5Ek1qSB2hkWH34hl1/oS0bbsJkrnbRkh
         UREAqLZkYQa+rAUrDt6TkzjqWNt9dQH0iWLggMYCvasCF3zRBlIpdpPfmIE2xGGvgWGV
         GX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773661913; x=1774266713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JVZQrImfTrVRlq9EnXFdF8VyCUmvC/OmzTav/z10XOY=;
        b=QjxmmhuFANvTXYAMw4MBCJNQVO+Z3J6d+n+gHDDdy1l0iisvHT55Hj0FCSvBynThw+
         BXeOiI2cHaJgd3Z2ISiZmBZwGF6d/jVyu5OUDijtLhzsziR6KTzTFYIdSaiBcVljLTfa
         3vc8kAOist4mXFrsyO39psnJ4oNSYbtdrQ+dxc4GLoHi1by3w4UhNYHv5HtoGz5C5J9w
         paDWfRPB1k0Va3vP6lcaQM0SQZ4JMcb2GQyU6j8iIwV7ODqDfDlu0lb41c1ElMBEeuPl
         MqD8htDG4lDYpGVVR+bagvw5+C1CZzJhaBgiZbgwoJ3Tl8TKOHZRK62S0H9hH8pMFw9H
         UcFA==
X-Forwarded-Encrypted: i=1; AJvYcCVysA0zngE5UdvDRFMXP8kvXRXzfncQZff/8Z+6Jrfg/dl+DlrTkFTyvqY8ovOXVjH+wS7nvOB5KxlWY9MKQaXb@vger.kernel.org
X-Gm-Message-State: AOJu0YzYu2OHDDKjZOoqcYcTYYbZXYteKiVDG0DUemOXiw1NQdKK2Bkg
	yC1q29/SIoa0nmmxIW4h169+DUfntC+MHtSQGd23VMmhRxWqX1tBZbVu92vmPLFGvMDGuwolZqj
	2b351T63fOg6S7+vgFfYRKSp3osOAEc1vycI7lbmrZOy0fPxe29ajadp6AV4RJAbODMe1Fp4t
X-Gm-Gg: ATEYQzzNR+Zqvp3JPgcIou6RK8BIaMfb0gSFQ68qJ3HpoBRUMkqUNg3f/lc4K6VZ5j0
	/X77yfXbKZcmTLvO8rBG2XmdoNu5xSMnbrX8mCSnhhauf64OTW1Oa4cc1tYYufoZryyzq0OacL6
	eiP721G9H9tE6jVj6prK3ug0xRGImjM9jl4PVMSmC1qox8szpdo5PJg6DU/FBxiOYy/qP+Nu2Gp
	kwJaaDq0MHybT2tGALZoOzlnLPxlk0HYzHmhiUcaexCv5DPEqYoRctJMYOkxXWIe6PQUktldbR5
	MN7tByACGev/ZptBC40c5K9gdq3YaVaqedppFGXYwRwqrdQZQwmB/dC0hY0KtOaZW6AS2RpMGYl
	US6QmJY7GWZH/ZxqA07ZwmmiNGblKMU7KLlE0I3WlHmN9heKYVX6QPxKs1tqaNQha2lZgB3y6AS
	M4EXzHUBMq
X-Received: by 2002:a05:620a:4691:b0:8cd:8f04:50ec with SMTP id af79cd13be357-8cdb5a5479cmr1654671085a.2.1773661912740;
        Mon, 16 Mar 2026 04:51:52 -0700 (PDT)
X-Received: by 2002:a05:620a:4691:b0:8cd:8f04:50ec with SMTP id af79cd13be357-8cdb5a5479cmr1654665485a.2.1773661911989;
        Mon, 16 Mar 2026 04:51:51 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:5dfc:3995:22ce:d286? ([2a05:6e02:1041:c10:5dfc:3995:22ce:d286])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20b899sm40444943f8f.23.2026.03.16.04.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 04:51:51 -0700 (PDT)
Message-ID: <c214b66c-6ef0-494f-8f13-9d6000068e7f@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 12:51:49 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/30] tools: lib: thermal: Initialize CFLAGS before
 including Makefile.include
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
 <20260311-tools_build_fix_zero_init-v4-3-9e35bdb99cb3@arm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260311-tools_build_fix_zero_init-v4-3-9e35bdb99cb3@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: IXQnZeN-r5mZtmUSIJybGcjAvHQNtWNP
X-Proofpoint-ORIG-GUID: IXQnZeN-r5mZtmUSIJybGcjAvHQNtWNP
X-Authority-Analysis: v=2.4 cv=AqXjHe9P c=1 sm=1 tr=0 ts=69b7eed9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=7CQSdrXTAAAA:8
 a=VwQbUJbxAAAA:8 a=xTKRYfdV9gSblPpQG3AA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA5MCBTYWx0ZWRfX7X7JmiHyUiMs
 482SW8MG13uqkQ0humjZVfbdez/IA4i8j5ZVOdX2osQfsjL9ytlPVWrESYxMQoGtMWATDCjD6uA
 vfU1soAgwqIBtorVhrzV8fyfxk1p7VaBKBqE7vMS4YGv9HTAekf8EYpq4X109+C9jV9mhPC5yeG
 3zAF+kEsoRHaDPMOeRJ+6i9xhsqL1Wg8kPyqnucWNrgcOQe1Bdxr36iPxEw7OLEpAw55/G4GloZ
 bsV/fgO+Dkj8jDuDOUsHWlux3U8A0l7nBt0YccbpM32+wzw0sJahKaf0G6UC94kmGtFVwVBIMaE
 Z+BKviMjfTmE3ax0kR2oXQ9gy4dalxj6bgu6ihBwIA1auyf93xfBKtDoECMPWIGffMwSE6Qa8X5
 lxAsrVvHr4SaZcQ34Viz0FMQ/KWWmy5iu26G+CqvPawqOCdxDAKQW8xAcwMju3JT8Iz3riz0XPb
 bUyg0nykQvTE4sNDmSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160090

On 3/11/26 09:29, Leo Yan wrote:
> tools/scripts/Makefile.include may expand EXTRA_CFLAGS in a future
> change.  This could alter the initialization of CFLAGS in the thermal
> Makefile, as the default options "-g -Wall" would never be set once
> EXTRA_CFLAGS is expanded.
> 
> Prepare for this by moving the CFLAGS initialization before including
> tools/scripts/Makefile.include, so it is not affected by the extended
> EXTRA_CFLAGS.
> 
> Append EXTRA_CFLAGS to CFLAGS only after including Makefile.include and
> place it last so that the extra flags propagate properly and can
> override the default options.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@kernel.org>

Thanks !

