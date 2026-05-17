Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511F83C7E0B
	for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 18:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779041624; cv=none; b=TekL68L+CtUKrP6Gw07lrelauFo4KaUtmeclOOBhA887yFPGYEQLnWwTQw55qZwd33L2Z/CU2n0+UHiJr4d1LdQCtrTaaFfUdvc84aRMeuCYGZho6KDbqPUk3ebH/VXC2r32IpvoECrTLyax8JDOXzAoXHck3PFp3yY7Xj5DDx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779041624; c=relaxed/simple;
	bh=8eVmxtcYmSeoUBzl3bHvfv6EisD5Oywosw3966cGgXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8nZm4ToT7xP+45GhfDY8RT1ENHWqi0+u4r3fjGZsF5ZYGCkluV8UrgmbFfhGz1JXFnnQYo23M6tIoYlVaBsrjieNAkJs0V8UZl65EV/ocOoXKEdmzt27bS1uXe8hM5QSYr9+XKPBFCWO7I17aXoKN8zvpAWnT0lI5JNedS1IwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T/luTTRS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eoGtqcNK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T/luTTRS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eoGtqcNK"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HEuWCT085630
	for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 18:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1Qv0uuV8Ex5OvKUJ759UY79R
	1wNp48m7rDkw4nsWu9A=; b=T/luTTRSCy6ThZnqIMq4Yv9t7QpQoo3sMj3NuAPs
	RfWctSvaJ1iz8NPlEmCJxGfPfEaLbU/o6srfIXsRyDzyj/WfigponPfPIqjUJdia
	8QF0U4Go3zbojf6o5Jn1DgtCS33XiUZYfw/BqPIRxGRH+AJBdh2XCYluPWmsk86F
	TVpSGq/sBx2kRcUdD6r9jk9uKsC7k6Hw+ut6Xjbde5VS2NNbrETq38gtMpq1koWI
	IJZ0S+Wu0kgDCe7OcjRlAgv3vBu+PQX0eX/XPqvcPEVXo1zb7mzXhejUj4cJickR
	5vyVHRuVAmCRA5/v9kM9GTEQ+Fxd2iP2J8gOkhMVD/npaA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6gy53cj1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 18:13:42 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8b459fa5f76so18533986d6.1
        for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 11:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779041621; x=1779646421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Qv0uuV8Ex5OvKUJ759UY79R1wNp48m7rDkw4nsWu9A=;
        b=eoGtqcNKKy2dptGtrTNgKWXbnNe1bwR+OVEyw+1BQj7m8nB1hrjm9d+ZfKAw4uH/HS
         1KyClEIoQEqFfcIXiAEMhl6UEpaeWF0UK52xZ0OOcNdqqgfR98VUwriRfS2628ovBsat
         wjTiJr6715TgPwDMjzexAZB8f8NWHUNp0tN0zqtIRC3PqmVue7iVHnZtdCBfcf+oNrKU
         Ei5mphVgHmW7FOC0fqk0e/3D8Tz4uvFso+ILSZOtTRIkJoiMUzVLmhN4kQ3y5hsY79gz
         0MuGo8cZ7/eLQxqbWxEQ7+bb86zzhLQuKcX/pHTLl1GCnsXuLF1spkMTOFRqyurd4US3
         T+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779041621; x=1779646421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Qv0uuV8Ex5OvKUJ759UY79R1wNp48m7rDkw4nsWu9A=;
        b=LOfYlcoe37K+1Oel2rsuXlVN7QmWJZ5Ork31Ia9iGR9cN+ao/UsyiaSb+FSpzY/RvV
         ariCHGIU/wn60QrTtrZ9PdV4N0PZXvQlosLgmiiRhyayWehZt+NrR1SajFumcweNQPoX
         6WoTptFSseNjnE/YqwSbXAq+eUlpC+lcP+PG163wY49xtja6ysS0NlWCe9ZxQroWpwzx
         TQlXa0IIO0QfSiY9jFTftENU06J93m9wv/FSkrrajhRnl6g2tUQh1NKxEJOoYs+IXVB4
         RcQrDSIhKWwxbjFAv1y+OY1WISWsr7SRHHo68vY14jjwltr+NrMlGDwREqXABdRfOxMn
         plog==
X-Forwarded-Encrypted: i=1; AFNElJ8P7FOTKuaH+IillUHqC1CBPTtrPEra+uEmpNCfl6PMHyc5TXVqKqc2fQQbfnPFX6XynQnDpcFDykrJbIUC6TYY@vger.kernel.org
X-Gm-Message-State: AOJu0YwhL43//wIp+W8vbclQhXkt4xvl/ZgdjOiW4+M4F9raQRUDUnaW
	Q6MlPRbVadwfDs8xTeqfqdEOMW3twZRtWDcSULmMThc34qKIqOoiCbmsRvhjEFEDgk53P63Epu0
	ex//DYKUZJAYpLkXsLgEgFrWn8v9aSO9diTud/ncNUfQU1DDILfBfR0gOUuFGT3Wh75vLYCOb
X-Gm-Gg: Acq92OH0EztRRknCpNBsgeG1t0CShU9AdYc/qp7xvXjXys0bqGBd1plipaKVZ9dmXvz
	SRNQzgpEMLXay/IvLG6GHtI/vs4oa17daXIaubY7V3fsm8Uv3xXKCTX8LzFKgymPo8djhbIf4nW
	ync8KP/TQyJKhbMhqSGHxJDfYOCs5WscVU6wujeN2SJtEZqYww156fJNI5i0AgVZ6Ou4NqE3nQm
	iFbk/YdGnMwWeA82LN4whJxWR48fTBqatfHE0mW1mB7e+znICzql1gg+59CHtxWz4qx8NDaNS2h
	FnKS435knpitMUsf9Xq2IB7RwrQlQ8TW+ykTdJIF22MRqjy8kW6uWUSDNcyrl/49OnPeh7Wozn+
	NI5H2rLkzK4ZL86tbKGB0UcYwHCXpBs41BLuF4Tn5fbDhmmqH/j7sD7nhSXvI7AAAfa4of7iw/3
	QNtuEJtch+PZOlO0LFfAcQbkpc7OmRKtOR898=
X-Received: by 2002:ac8:5cc5:0:b0:50e:62ba:3ff7 with SMTP id d75a77b69052e-5165a075923mr178267061cf.26.1779041621528;
        Sun, 17 May 2026 11:13:41 -0700 (PDT)
X-Received: by 2002:ac8:5cc5:0:b0:50e:62ba:3ff7 with SMTP id d75a77b69052e-5165a075923mr178266581cf.26.1779041621074;
        Sun, 17 May 2026 11:13:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395882c41c1sm6557951fa.12.2026.05.17.11.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 11:13:39 -0700 (PDT)
Date: Sun, 17 May 2026 21:13:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Oli R <sigmatwojastara@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>, Shuah Khan <shuah@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun@kernel.org>,
        "open list:DRM DRIVER for Qualcomm display hardware" <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER for Qualcomm display hardware" <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER for Qualcomm display hardware" <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER - DB..." <linux-crypto@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] treewide: replace /usr/bin/python3 shebangs with env
 python3
Message-ID: <u7c5s7dtvzmqteqvrhr5p2a6wc7sdtmhfksw5344grs2gzgot5@n2ybljjcrju6>
References: <20260515180806.246914-1-sigmatwojastara@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515180806.246914-1-sigmatwojastara@gmail.com>
X-Authority-Analysis: v=2.4 cv=Wusb99fv c=1 sm=1 tr=0 ts=6a0a0556 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=Vby_bzTUFChIRH6wvO4A:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: U-rNbU-7ZLF2j5wFroCo5nCtphqqrbAs
X-Proofpoint-ORIG-GUID: U-rNbU-7ZLF2j5wFroCo5nCtphqqrbAs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDE5NyBTYWx0ZWRfXwPgXBjkKC5AC
 E83frgKiQWbgVoCt2zokZGYcakCy/ZbN8djFoGEWbBuMXRVCZc7EulwkIV01ywAw03A5SIaavD1
 WBosRYQCp5NKuCtEe49LnkF0rOkF4eI2mY+T7BY9bCoDOW75S7KWIZJoKK/q405hn+7ADnqikhd
 qHYkmF8ZDj/kYmvtzBVEQfvN0dqFpBPt1r1A4pvWqXwHhrg+TdpN2+M+bICj1uRC/RJ8PydSXU/
 7h/hbGVmiruoGjWuyKbpUBm27gDmjGA+AIE86vnI1DW4lSl8g6LBh9nlbvK3RrXIXIZDTD9DLaS
 2UsmkVTa0SPOpMOYdFAxsr91fEL2jnSlOow54Hp7PEcQHGAvZh2X9Ymjjp9PcTqYkSnbJ9mcva0
 uaYoiNfc6jvwZn+9c0xlmaKLWuAfuCtcjzaFKZHhxLvv/5MEzYxsOm/JnmTekZdDLq0Rc/TxhWF
 hYcA74udzM/6s1rVTjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 clxscore=1011
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605170197

On Fri, May 15, 2026 at 08:07:59PM +0200, Oli R wrote:
> Use /usr/bin/env python3 instead of hardcoded interpreter paths
> to improve portability across environments where python3 is not
> installed in /usr/bin.
> 
> No functional changes intended.
> 
> Signed-off-by: Oli R <sigmatwojastara@gmail.com>
> ---
>  drivers/gpu/drm/msm/registers/gen_header.py                     | 2 +-

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> # drm/msm


>  scripts/macro_checker.py                                        | 2 +-
>  tools/crypto/ccp/dbc.py                                         | 2 +-
>  tools/crypto/ccp/dbc_cli.py                                     | 2 +-
>  tools/crypto/ccp/test_dbc.py                                    | 2 +-
>  tools/perf/tests/shell/lib/perf_json_output_lint.py             | 2 +-
>  .../selftests/devices/probe/test_discoverable_devices.py        | 2 +-
>  tools/testing/selftests/rseq/rseq-slice-hist.py                 | 2 +-
>  8 files changed, 8 insertions(+), 8 deletions(-)

-- 
With best wishes
Dmitry
