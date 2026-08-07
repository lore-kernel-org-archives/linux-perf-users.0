Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E823B4E81
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 07:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786087111; cv=none; b=FlQRoow2pFOEI3azmfRlpezOTYO2Ass659drHiCUd0+ljXvZHXYkVOvvlX4N5e3neaYeu+MYXgs8j8+VKmoYcEAi90to+T59UaVZoixKa5TDNBqgslovs+623lRJdmMjzeTx14h3SI8e5XigmbMIHanOdd8cJcIKD1iLuxGSTQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786087111; c=relaxed/simple;
	bh=6iGRZQU5iqk18vK28n1WtlfO4rJ+lBelMHpOKQwJLXQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=d1R19aBkZrGM8b4ixEyKrFRWYAV0ImxmTcbmj5WZyAk640EZ4yqEjuptjuHiOnIZgVzgZ6oOaLApxgxlx2a8FM8VyfrXYxIv9cxzREYVVlsv4h356xMEQ1sDiLxZMZr6fZr5CO82Ayl2KzAfF74+oK8czGpp1+opDcWNzSmhj3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qwYmsc9U; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qwYmsc9U"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38ce7fabf76so4941571a91.2
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Aug 2026 00:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786087109; x=1786691909; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+/LzAIB86djFW/dc+XDdigV1b7wOoI55acdChTs0xt0=;
        b=qwYmsc9UmV9EIf+RxELrLKKTgYvimST1xCeb5eUSAJYMJDX+brOrIVcVLeLswx7fmh
         q+DNyRJevZPSFB2cD7Pk04OyBSGT5onmJ+x+ZhJEvca0ZdF33feAb1t/9Ij7/M/q7g8Y
         /UYU1mnXO5V2k8Be9pVMp21vIQL7uUIfERfDwFl5dYGl7L803PcBiIbAlapg9TCPNKDb
         gQWWQxTolNAslHc75Wi3iErTgTQyr0iu1A0b58B3KjdizP6oqCrTE23q3GSpfdjXTjbQ
         Z+/YrSkjlRPxm0b5x/E/88vzhP3o6yqjPht6M0uyPpRmI0PQkO9rLY8m3eCatBeIrZhE
         Uopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786087109; x=1786691909;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+/LzAIB86djFW/dc+XDdigV1b7wOoI55acdChTs0xt0=;
        b=Mrywk5Lir8URq7a3G/JT/7BGPbBt0mbaUJSXkrgvtUmznQe2NErag5gRQgAp3HK4sh
         PFumo8SOpLVa4Z/gbukQHdqDUDAyhhk7XXrPyacB+FlYyE2Fz7y9kXY+FW+DRltYlnTB
         skyibQVrT8YM0UXLiaxQU2xKmqa8vUv3gPazFdn/IfLLy0GSV4gJh1DO2WJCDa+dGuIF
         sRHi3xiKravXW0MhYq220vPtv/RV8IyxWo7r7y0hz4+XrfrDnHsr6naikGybLhdut/FB
         feOZMB1+OCP4WT2WNJSltgbdJOS7c0A5no2JYQ7VH9cS+t68pfmXY4QrGFhHehL0iMHp
         NqXQ==
X-Forwarded-Encrypted: i=1; AHgh+RoHLXkPoixkl3TCJUDLeLsCq9u9tqEq2+jSu+XJw8QgPGJjLUV/GMHAf2LCBcwMTYArojnVMCTbx3ZDqLZWtMrJ@vger.kernel.org
X-Gm-Message-State: AOJu0YziwEntjYxd0lPiTYLhU4atwQa4S7Yp77571Vgk2vdJkPmteZBm
	fCubj3EildOJEuhzrpYWNf97JF3U0poOUfiH3DLT9WsGGN7IrbYz7hbXb0vP2kl9UycdyJZZoHK
	Z0n1PW2cBZw==
X-Received: from dlj3.prod.google.com ([2002:a05:7022:503:b0:13b:962e:3bc8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:578e:b0:383:5a16:bd70
 with SMTP id 98e67ed59e1d1-3903c5ebc8cmr21858591a91.16.1786087109050; Fri, 07
 Aug 2026 00:18:29 -0700 (PDT)
Date: Fri,  7 Aug 2026 00:18:12 -0700
In-Reply-To: <20260807071818.718751-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807071818.718751-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260807071818.718751-3-irogers@google.com>
Subject: [RFC PATCH v1 2/8] perf/core: Add BUILD_ID_OFFSET to UAPI
From: Ian Rogers <irogers@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Eric Biggers <ebiggers@kernel.org>, Zecheng Li <zli94@ncsu.edu>, 
	Gabriel Marin <gmx@google.com>, Tengda Wu <wutengda@huaweicloud.com>, 
	Derek Foreman <derek.foreman@collabora.com>, Tanushree Shah <tshah@linux.ibm.com>, 
	Ankur Arora <ankur.a.arora@oracle.com>, Aaron Tomlin <atomlin@atomlin.com>, tanze <tanze@kylinos.cn>, 
	Rui Qi <qirui.001@bytedance.com>, Howard Chu <howardchu95@gmail.com>, 
	Chuck Lever <cel@kernel.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Alessio Podda <aleph.pi.gh@gmail.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Introduce PERF_SAMPLE_BUILD_ID_OFFSET and
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/uapi/linux/perf_event.h       |  4 +++-
 tools/include/uapi/linux/perf_event.h | 11 ++++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index fd10aa8d697f..f0712c1471d3 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -165,8 +165,10 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_DATA_PAGE_SIZE		= 1U << 22,
 	PERF_SAMPLE_CODE_PAGE_SIZE		= 1U << 23,
 	PERF_SAMPLE_WEIGHT_STRUCT		= 1U << 24,
+	PERF_SAMPLE_BUILD_ID_OFFSET		= 1U << 25,
+	PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET	= 1U << 26,
 
-	PERF_SAMPLE_MAX = 1U << 25,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 27,		/* non-ABI */
 };
 
 #define PERF_SAMPLE_WEIGHT_TYPE	(PERF_SAMPLE_WEIGHT | PERF_SAMPLE_WEIGHT_STRUCT)
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 2479a38883d0..d5660e2d6b60 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -165,8 +165,10 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_DATA_PAGE_SIZE		= 1U << 22,
 	PERF_SAMPLE_CODE_PAGE_SIZE		= 1U << 23,
 	PERF_SAMPLE_WEIGHT_STRUCT		= 1U << 24,
+	PERF_SAMPLE_BUILD_ID_OFFSET		= 1U << 25,
+	PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET	= 1U << 26,
 
-	PERF_SAMPLE_MAX = 1U << 25,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 27,		/* non-ABI */
 };
 
 #define PERF_SAMPLE_WEIGHT_TYPE	(PERF_SAMPLE_WEIGHT | PERF_SAMPLE_WEIGHT_STRUCT)
@@ -1054,6 +1056,13 @@ enum perf_event_type {
 	 *	{ u64			code_page_size;} && PERF_SAMPLE_CODE_PAGE_SIZE
 	 *	{ u64			size;
 	 *	  char			data[size]; } && PERF_SAMPLE_AUX
+	 *	{ struct build_id	bid;
+	 *	  u64			offset; } && PERF_SAMPLE_BUILD_ID_OFFSET
+	 *	{ u64			nr;
+	 *	  struct {
+	 *		struct build_id	bid;
+	 *		u64 offset;
+	 *	  }[nr]; } && PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			= 9,
-- 
2.55.0.679.g6767b8d81c-goog

