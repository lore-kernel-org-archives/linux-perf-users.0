Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793273905;
	b=dXcyrefMzuClJ7xIoWgCpte7bq23+civbzZ+f29kpAqhjU0nPzkiebRl0IwnxTV7wfFi
	 h+RQf8hpMudlCDqjJ89jmfSygN9pjwPNUQToI2avkEsLLKtBs/LYQHAcRX4xmMTQogKh8
	 4Q/K3bhxl/daWO4P7fVtQVmzGEhWV96EQs0Mr8YVZlApeAAx/iDjttNs8aWc6c/iMgRfi
	 gBd/bb3gRfu/cnABNcytZFRWYmYbvns+nAhSTn7IkLfw/jagW/CvmtQxLNWjdR3WKjFqe
	 I/oHqNYNQ2/tLbXXBqi+sGqxkj+rbF1PYOEZExfvfJIQwmb2nCiaU+KkctIzMNB93Ew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793273905;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=d+gMCI5zJ/0ncCjFjxtCwKE+NZWsbIHy4vH2hFbUCDM=;
	b=CUxCYz0CYbqQcpH1tEfDE+g5j2bvuyx5RgrR+BaU8C2PXM/pJg50u49mupdU1BiuyEze
	 pQkz0P55yOgYEh87IjQzegBss9Rmkuf437syEblshMmkG/WL5uaE/79VawhjLlBdC3XgE
	 Rk/7cfw5bsGMxGZKs7IYJLvBJ6U8gfBJRIrY76sZgicWFt3P9G2GEtWbzQ1mdL0iiPr9r
	 tWOPJTnXMgTdbJPlpjbCmuaTUZY1AhONLI2E7U+9k0CApL8ZF4aleu8h4j5gWdlhVzbNg
	 ymUD250MEiMh9v29cDOz4Q7HLUR0Mq31HFSfqTQqNASH6uZwK82VyMe5YczRjKXv7hQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D5ewi8Si;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ButymcXZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B9B606A331
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 11:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82B9B606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D5ewi8Si;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ButymcXZ
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TAJtiH875500
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 11:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=d+gMCI5zJ/0ncCjFjxtCwKE+
	NZWsbIHy4vH2hFbUCDM=; b=D5ewi8Si/yyUEb4CJLgr2xpoJW6pK614WmguzPBw
	J5FlTgxUj9XZAh+NE9KOm3uJhnohYq0oODVnzC0zXuWRlnWGEa0EpKshXqVexq/V
	YeIqos3s4ctK6PgTrZ6nDAyJaIyWu7IfJZ/H5eVqFhw8q/upJZft8UhNmy5g4gYs
	5v8oEy86bTKoZ6WTVHwQUa4cduU9NSj2a4xh3DaIcSJ5A2gq/4mbwNdYKh7xEi5s
	DKBN7/aB+9Nu0ERYvB0Gej2xy2JSoBHcXD0V+8L2FOtcQj8jg7gAI142AY7+jX4L
	45TLVh2VKZ9QfCGDALDlCzP6GcXAKCzO+bqGPqH3BCm1Ew==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm4a2086t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 11:38:24 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-341eff9e381so4286226eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 04:38:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793273904; cv=none;
        d=google.com; s=arc-20260327;
        b=NVhC3KRmGp4WgdIpdk6am8jLcGCqCEjc5m9sR3u+czQg7ZH4vM/4SXIzQGRlmfTv11
         Fr7Vh9BOO5VYjBXJ+t8wbCZFFYIhFAtejsmN3xaeqS1HPp/tEnqY9q3sBOslmB03U8Rk
         dRxoSBWYFqGeOR6bTwoyjMmMSRSW4zF7XDdGc0pH4UudFbxNDjPgEXcPH10CF9HZmJIL
         M9W94rlKAF7hN89e3EAM+4NKLAj2jVTNAx94AE7VfHWJg4LowvLFCK04XC5KdgSjbkSg
         95Ddcift6E+J/8MOak+QdxoTOec1FBKijv5Tv1cOSi4+UrcxirmEWXJfch7RDqfudObD
         lUMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=d+gMCI5zJ/0ncCjFjxtCwKE+NZWsbIHy4vH2hFbUCDM=;
        fh=Z8SkXpJa3izmowhVjVfp0VKacnjvjjd3Jt8RLKqzvAo=;
        b=SRXX+COrg9VqoQFO3sBG3aPN6+G395zDSvEWMRoUIAjoHIBvFIiuejipJ7zqXY8OjI
         ORkE8Y+S8qK6redgMMKL6TuRcFPvLXQh1Hm5NDbCA/Q/oG2MS/tLwhhI3slah/IJ5883
         OtRkjCXfPRBnL+IjnH+WVKRORwCs9nyZIekJinIsh45WwhUeNKxYQV+3dJ7xFF62xlSA
         zrLN40tmcaXkjZGGLfix9XwkcgUYy36bLDSdX564q70bMSDGMJIvfvWJf8tJ3Jq4GoIS
         kf+VyRBb6kZ4b88YoCK/RaxuTZn19q0AbOLL26z4aPngPU0ska45dT1/+gNQgzOPsxTp
         T5Sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793273904; x=1793878704; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d+gMCI5zJ/0ncCjFjxtCwKE+NZWsbIHy4vH2hFbUCDM=;
        b=ButymcXZfc0Waii9DJ0T72l6Uvi/Zrzco27bvXxYF9jTsh9AYzmGH6HwTZ0sov38Uf
         aStY4Py+kaowk1I5SZUme7PVp7X6OZEHCG/L/8QcFF+YHrMpdbYF3NJwDau/uwcoX2a2
         ToOkgaXgM8eIpVjlvKRpRhyu7GEQ4GnkdYyQtmOwdzZavjJ+uk47K7vpYpdJWFieE3tD
         EM+W1arS2GQ60K8qYWJm+l/z1KzWIqKoaDKEW3f1+3Xkb1BwWTS1r/qlkN5WiX802hxc
         OJTGUtQ+XoBGWC6TAkt0IbIdmeud+Bw68m+BQ13lDMLX8urlhHmsVAl9gOr1qagk0mRz
         FeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793273904; x=1793878704;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=d+gMCI5zJ/0ncCjFjxtCwKE+NZWsbIHy4vH2hFbUCDM=;
        b=Ql1LWeo3830Q26NjX6r2TmB3uWYXcbXgzmCaw6p/Gzav5d1F/6uk30GDk1cShhY/8Z
         3xmPMnA+dtz8xvb890t5vA+qg8bf066Yusu5eJyLyn1bXmebC1h9zrjSnnXA+QHEh9vo
         DwQhaab+welbcGgqqFo9g0lQA1GlHKLvd5H1jzQPgPS5EZjdi0YGMKoF2rzEfurdF9qc
         CzJs9B4NL37GjlTYFf21cCk4zoa2a7k1ed/XhBf44T+oXWCmV9/aZlpIx+RNZg7oE/Zk
         /sK8ja8j5iytXsT093RpdSZmIBDjb8bHAE/+1dslVosda8cXgrpXS03S+Cr/5n3kiw8W
         3R0A==
X-Forwarded-Encrypted: i=1; AKwUvBxp9XJbtZi6mQhb6BGZgogK+fvh85liee6NzUtBVnHi2/thfjigM1BvGHpdGfLPWVMOak1+AB2mnV5TpNRgTo/r@vger.kernel.org
X-Gm-Message-State: AFq9FYKEXXJlRDi+AiRWWlVyyg7//5Dx1wMVKtuWlI5mnSSyvN146Hgb
	Z0OFuVKf0lRIvRPxw8OL8IIkYC+fNlbtDs05uoyn6iSrCzwe62gOGkmWn0o73dXTPjj3Ksh9zWd
	lY0Y0Swrjr7dnhHBtbcqQC2b9TKh+ukTJJOm3DOpJOSiDIeiP57DaFI2s9dfqJ1/7eyWZ/IoKaD
	O8F2eK88GhTzSdgryYPX02JrURYGaMWsZkSN7P5SXAFVa0T1c=
X-Gm-Gg: AYBFou3uebgVvJ3djIOoyt2V0gzNrG/4htdJs6UPMRVj+hqP+s7ssCmMXO/uDJDxA9C
	TJKNzp3D7KY+4Z2XA/ohhniRzfS5gAETdKBJGwQknH6TAH1ZeHX/1H4yyK8Ojuql70pR9wzuyRP
	+VObK+KnW6S2Ica+3MwTyiClQ8tyo+SRMnK/meKDJd9kGNJsMB8/lIA5gHuA==
X-Received: by 2002:a05:7301:1888:b0:369:e930:6bc4 with SMTP id 5a478bee46e88-36a20440ab1mr6660861eec.30.1793273903987;
        Thu, 29 Oct 2026 04:38:23 -0700 (PDT)
X-Received: by 2002:a05:7301:1888:b0:369:e930:6bc4 with SMTP id
 5a478bee46e88-36a20440ab1mr6660831eec.30.1793273903447; Thu, 29 Oct 2026
 04:38:23 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029074853.35467-1-zhangzhanpeng.jasper@bytedance.com>
In-Reply-To: <20261029074853.35467-1-zhangzhanpeng.jasper@bytedance.com>
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 17:08:11 +0530
X-Gm-Features: AclHuK9mkpiY9HLm48B-7iSzfqzEzMPXUUWrIwq3MFK1djLB6MzLTJk2GLxddQQ
Message-ID: <CA+Ht8=YtrKJxr7YLO2z1389NPDnws8hSppAzVnYYJp5K1duvOw@mail.gmail.com>
Subject: Re: [PATCH v12 00/11] riscv: add SBI Supervisor Software Events support
To: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Conor Dooley <conor@kernel.org>,
        Anup Patel <anup.patel@oss.qualcomm.com>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        Atish Patra <atish.patra@linux.dev>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>, Shuah Khan <shuah@kernel.org>,
        yuanzhu@bytedance.com, yang.yicong@picoheart.com,
        yang.susheng@zte.com.cn, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0NSBTYWx0ZWRfXwkS3B+VT6cKu
 80IztJXJLQA1FM804/7VB9CQhTokrr3N5es9nT4Mp45gSXtSFxNe0TrFp6SZl+wmSpTuvsKH/Fg
 +1m8bQ6zquWy3AnE/3kcFpAk2T1lQcBUDCtI+hDw9WEyyQd3rK+lQqFgAbbg215Q46G9IrgYtOG
 dlCIdu4V04+1Jd2coF6So7yj+Tjvuwq7HEH/P00iLoHAYtpZq7pR85gtY3bGDbohCJ+3x8UTNqN
 4KRXmSoKpt36jJdHssil5HivUeVocNjAXkG+6qeH0iN+XFTRG4CGubF9qyuA4xNPOUgsHArowj2
 8Mvjsl2JGACfXwZZghCvtL31erJtiU/mZySjIGvedacUaBS4MyiwUFdvuIoEfRusVNP/QMTnvpi
 OZT9+1Iq4wXW8kAvrIi+Q+Oec0lM7h2A+jt/A0Fe5NYORqV84N9a3quhng9baOBXVBSgafTHawk
 CK3K+XiS1X0dZ/jt9Tg==
X-Authority-Analysis: v=2.4 cv=E8tYNqdl c=1 sm=1 tr=0 ts=6ae33030 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=ojhntA04eiNvkV59mfQA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0NSBTYWx0ZWRfX5oQlN2hVMN0h
 TgpaTXPS8MRSJRqdP4qv+4OsAsWLX0jbpg6dhPxFau2KJaasqaKy1m0b8sicQfYTuRg1K6UpCdi
 JaIY8hSBPcocwFOhqkgciLITOwNB+8g=
X-Proofpoint-ORIG-GUID: FRuvOvpjTMCoOXT465tRl3C8P3PtdZsA
X-Proofpoint-GUID: FRuvOvpjTMCoOXT465tRl3C8P3PtdZsA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290045

Hi Zhanpeng,

> [PATCH v12 00/11] riscv: add SBI Supervisor Software Events support

I See only 8 patches out of 11.

Regards
Himanshu
