Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B7731197C
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Feb 2026 21:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772053744; cv=none; b=Z6acFDzo+C1fCOpMQvIj/o0w4mh2VZYa/hpsxSOekWxsafZ88iVcxaJVaxbUqlCd+wWFe4z7GVKXpu7SRat/9Mz6LD4x7VmNtIKi4fexLolB/eOTTE/n8sw1qga3kq8uIHA4M/Zu/iNyUC9/+2QqQC21Wz7BbgvsOyIk5+K7Gb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772053744; c=relaxed/simple;
	bh=7S67oRMclfJREt5gae/g8weoq6cbrehCfSKxGhXJZx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1vaKEPcF2cvaRY1E3WUCEwd0LrpE0ZnGn/YsabxO63k7KD56PA/H0te3Y6b/aK6JQW6h3ZSIhCZQmAaxzheZtu3zAz08+mh+3MPZm3zo9oYBPRZVMDvTQOcOCfqFXsUJ8BnFfLSRJoIwF/9kTI43EIaLYpNsfb/bfryr5/RZMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aPLRKa94; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S4phJ6sN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aPLRKa94";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S4phJ6sN"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PKJ9Cv789059
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Feb 2026 21:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VBmnl9PJw1wesdKZ2FfBJpI0
	enm3lW3EvYf0jk7sk7w=; b=aPLRKa94YDUOW/qMnOjRcpCcH8aILpYCYua+iSRW
	oAz+0avS3bsLqu+Or7sIXixWe1zdVa3PvO0vshaSlXLCKro7vtqWlirNpNkmWZrH
	GmgxwyIkc2ADY0hO5A8AGSPA5S+v6s9XuGkeDAFa4yPVzkqE7TCxZnnLVxgUHFT1
	3BfDm1X2MPQzsPdvIFj+fbuJU61j/J2lduCDZ0m2nVzvW1QEe8F9mVnPc7ASwZRc
	kDtUrRXDnkKY27sa4HaxdUdVKg6GFM4EUX+Kp959gwvrkRk1qkp+FC9cxJZYoC9J
	vFkU6d2moA9Ruqp5l1HKEe2pG2U5DIQIIyBpk+zbAxLHxA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chyv9htdr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Feb 2026 21:08:58 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2bdc5078895so2069860eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Feb 2026 13:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772053738; x=1772658538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VBmnl9PJw1wesdKZ2FfBJpI0enm3lW3EvYf0jk7sk7w=;
        b=S4phJ6sNnU/oUGSa/emzc6IZcn6wICxMlAjSgsLW+GKSdwSYFlNjx6bdBYgGMVFkB3
         5yq4qmZDFrTiXyo3FyuoAyrhlyptYxW8/7SdwW+6tJaQBVf0r1waAD1LGk27HbisTnr7
         7S/+3usM/qICThJvUx7R33CUZ48pTUivsmNFDD3Pw7YaAVDY1wzlp/NRJ0qZTILVIJCv
         9z3zIKAEX6TcpM645UZSJWBVhClzyz2fHFdvGZWYr2uf7yRiuqzyDC17M+vN05d4OHFu
         Sxq4wOqeZQAsGWlTcmIsG2R7lXxqKupPUgbxUcIjq9bi7ZTWSU5HFrfacn5SY30JUhRf
         /q4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772053738; x=1772658538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBmnl9PJw1wesdKZ2FfBJpI0enm3lW3EvYf0jk7sk7w=;
        b=sH3rtOrslbvvqLWkUfzqxB70LB+j1mbFAqptQrsmX67X/TbwE/YgyWCgM62Qab2ryY
         0AntiDvb5XZjuXDeIqFOx6dUrVZCrBcwy9BFmaiZ+mZ6GIiY1THiYh/fLzMqldaZ+rBS
         VN1cVc/dh9YOVIER2qnUEKoYnBSqmou/KQ1VSwE2Wl4KuRg1J4K37LEiw6kgXPg5zdd5
         M7monCSDg0GCkcnvvtaXtDUJSy7v5mF57KJMximkA1XGDOAJgV+Y5f3uyFMwXABGtdBF
         1J206/x57B/zJkWRZbm0/zcoQ6Q29c8z5otHhYXLu34iJLi2Co9bjd1fiaHixQjUhHjK
         +Lww==
X-Forwarded-Encrypted: i=1; AJvYcCXKbosBBnT+gBiQfXuBBI64s5u6jHH3kw0CyobOs5dgLtVa6VcCfLw6USNov807lJdD7IZMOUNJ2dBrfgheJsOU@vger.kernel.org
X-Gm-Message-State: AOJu0YzCHjPVdkOe26kCRyflYSKCvyJNrHOsjSbljqBbB+pcJAMH3Lyw
	3NKmTutvI5BFotdvKwlk0llNnzTrv2xjRKrN8yC3I8JmwuLK7H6c5hrie2eKxPHEZdjKZQhwVgi
	rVNwQMrQvb0JljH5oS07wdzPPwNWJwT9hTibyHbKPRrv1Sdf/ykR+7zBf5yeG6mOxaxndLnEu
X-Gm-Gg: ATEYQzzu9xeE4qMFb6DdxaZf2fTVqcR8fGkAPbtaiNYZmf0yQ42mSHopI7GF3WcbLDG
	L+zrPYE2iHnHHvV3Seb1m9O+q+4OolrCM0VlQNU7u29jQG/oW1CBdxCqrG3YdYaqZeqh9+o7HFP
	YTkGKdtWp1en+bJkB3xMq3tAgDcwieIvs9EL2meGuBbCN/Do/Cx1E1HC1cCF2KbDoSu70lJVMhu
	qHdi3gX6WWlm0q5u0G51S/UmgfYJTZG436+fBBWQiOmwxJuq3QFkGrx6TF+V1aMKwb0vqqRodxT
	/beiQHSe6WoMLzsTVbZL09yGVcbwd9Snr2IapFkY1ACmiv3WGOPsxdugqkD6VLe05mmRilWwUhE
	h86rMSgpw3WoOJ9m4br057fu1LzvOOLri
X-Received: by 2002:a05:7301:678a:b0:2b8:5159:eca5 with SMTP id 5a478bee46e88-2bdcbf7ebf5mr946964eec.14.1772053737573;
        Wed, 25 Feb 2026 13:08:57 -0800 (PST)
X-Received: by 2002:a05:7301:678a:b0:2b8:5159:eca5 with SMTP id 5a478bee46e88-2bdcbf7ebf5mr946947eec.14.1772053736987;
        Wed, 25 Feb 2026 13:08:56 -0800 (PST)
Received: from localhost ([138.199.100.237])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1df6b0asm188889eec.12.2026.02.25.13.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 13:08:56 -0800 (PST)
Date: Wed, 25 Feb 2026 15:08:54 -0600
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>,
        John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
        Leo Yan <leo.yan@linux.dev>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Blake Jones <blakejones@google.com>, Tomas Glozar <tglozar@redhat.com>,
        Yuzhuo Jing <yuzhuo@google.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Shimin Guo <shimin.guo@skydio.com>,
        Athira Rajeev <atrajeev@linux.ibm.com>,
        Chun-Tse Shao <ctshao@google.com>, Howard Chu <howardchu95@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
        Thomas Richter <tmricht@linux.ibm.com>, libunwind-devel@nongnu.org
Subject: Re: [RFC PATCH v1 7/7] perf unwind-libunwind: Add RISC-V libunwind
 support
Message-ID: <q3oys2ukvylrd7xfn7267bh3wpumyxbbxpk2udhps375cmk64p@l7sjnlxll6c7>
References: <20260224142938.26088-1-irogers@google.com>
 <20260224142938.26088-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224142938.26088-8-irogers@google.com>
X-Proofpoint-ORIG-GUID: wq0FT6xtV2meevXzrq7zaXAQEjZmUrn6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDIwMiBTYWx0ZWRfX+ad2pOyZHRE0
 w8cgV/MOvYnOg+bu7i7X1A0NLyzPh/Rd4h8HycnVZKEIdweDE9sSg6f1mmNImjVrgSPXemlyZ2s
 90m+eH/dYTrja9ftJl6bPaDBJDyJje9l4EhXKFOGRhnlsLOushjvUSPeqUMXWwGQCdGXnLR4fx+
 baDnZwsUdWMHz57W79q9KmMQwBsf8o747WQ7r9XMW4rxH7wAteo4LPbdYtkk7LoTjWoBI+8xLHD
 aqnXdwqDRcsxEWxpisGmAnovUqhzLqmPDQ+06GPSyPOFOsth3ZISqah7dOFfzqrXqNYmjRmOL5k
 ZvOgKaoTJScu34PdOJ/XIe3qTM0p1GexfZtP3fMPTw5ykL6DYUYtemQSGRRL2CajK6cGX5PBPYw
 9tXMmwXfs6tD9qPPFapI6eyOvCrR4YThbRKtDr7Pj91R40RqS9oRSdtg/+SOdlB0LybcydjC0hT
 7IrZZrQmAAqD6FDIOAw==
X-Authority-Analysis: v=2.4 cv=GZwaXAXL c=1 sm=1 tr=0 ts=699f64ea cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=OC80/TC5XWgnnCQ5Z9xtWg==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=8mPsIthyXUsASUFpomQA:9 a=CjuIK1q_8ugA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: wq0FT6xtV2meevXzrq7zaXAQEjZmUrn6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_03,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250202

On Tue, Feb 24, 2026 at 06:29:37AM -0800, Ian Rogers wrote:
...
> +struct unwind_info *__libunwind_arch_unwind_info__new_riscv(struct thread *thread __maybe_unused,
> +							     struct perf_sample *sample  __maybe_unused,
> +							     int max_stack __maybe_unused,
> +							     bool best_effort  __maybe_unused,
> +							     uint64_t first_ip  __maybe_unused)
> +{
> +#ifdef HAVE_LIBUNWIND_RISCV_SUPPORT
> +	struct x86_64_unwind_info {
               ^ copy+paste issue?

Thanks,
drew
