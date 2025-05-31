Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1ED235076
	for <linux-perf-users@vger.kernel.org>; Sat, 31 May 2025 07:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748676394; cv=none; b=tVayWLaDfPy6sIdjjAFOJpzYxlFG4dbT63UP8pvvmhVCTTpRQ2VPVcxQjIr7fcgk8wFX3vKnxwLt3cztcA+Lzzh+5xmqJnBRDZOOO4X48Nno16V+jUABr5JA25/yCtwDmNQZfVfu7jXsddB3qFF+ckAhlpdTxoBUAKQtDF+4nyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748676394; c=relaxed/simple;
	bh=X0LYj/eW+1AU4BHmHS1Hd51x+t+f70loUF5+rqrYZxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ll+xYF6I4FaW8dvSbeEvyQJzuV0K3xC+6oCzVvAAova1XZIetCnUis6tM3sKGGjkQcFfI6OrmkmYEGKrGzTAGVJUElKf3btcoqsgLFgUQn5bxAe1PTC/ihPeepP2TthcabL++2C/Q/D2jSELqvvsROGrw7I5CNEQZiitUJskJVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mVF3H8vJ; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mVF3H8vJ"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-52f22008b6aso931712e0c.1
        for <linux-perf-users@vger.kernel.org>; Sat, 31 May 2025 00:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748676391; x=1749281191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0LYj/eW+1AU4BHmHS1Hd51x+t+f70loUF5+rqrYZxI=;
        b=mVF3H8vJudZMrlnGnshjFuzUdweko06tEBl8b4UJ52uh+KP2QtcTmFavN8kud80HBY
         HcyiRasg1RfAkMA4WOxMSS0e4DOGX0+vkQhaj6pFp9DbAvxnPJgmv/vhmxk8aPm/nF5P
         AJnBVLBGTeO+BFqpungoaRPzm0V92qwO37DRm8a8bdJz+dhBH5lOxK5UoX1NscTIbzj8
         lTZryJpe9teUSDaMeu7JJVdIjCYpTVgEEoZPXA0EYwlyl55Y8RY2hxhNtzxtIxb8jl9+
         EynNYSMaggaydKTZODgwso689k95czVWem3vfTa+PPYvKMzcYyx7YXjS3d7PwbEJVf4v
         2VLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748676391; x=1749281191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0LYj/eW+1AU4BHmHS1Hd51x+t+f70loUF5+rqrYZxI=;
        b=fJgwN0d/dU0BG+0aRTIrMkfq1oUwjvPh7l5KlmYe19PO4yic0nt8d3jh/qDcyVwTh8
         x2ZRJR+xQhY3Sc1XG1tmwv7C579pYAQAaFEvTNKtWBqU6ayUahvQqlEOBg/MB/auGiWt
         RXfTRkDs3nT9pmgz3/1a3y5XznuqtUg9k33h1UoMJ6CyhNk3yuNVyXOJQF3twuk37sXX
         xisHIF1PRQElSPS0rXSeiNNoHKRsATRCwZF9iUngWXUILJqZKU2YWTIK/gYXvojISGQ/
         9csdbEuKVvctcPnMu2nTp+K/uba5BS9T1DDeu03QXnniwyCIZwGcU8zCCFPS5DETKNCS
         nWNA==
X-Forwarded-Encrypted: i=1; AJvYcCXG5kS/xr1JeONJ35NwrCaueAHcVOiuIJj5yPwriZrpPf7VK6N7DnmXjJykp0MchLiXTGVB/nNPqYQBNjoR5OT1@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4WBPjtNB3Shise+42/tU/4Rg+XqA8En7RIiWXZgYeNzmUjEpJ
	efZtiIn+FM2yNV0MRXSoRwEJyMKim5fiD5x+ZtKxDTxqxunYAhMgmE21LbmpMhG+vt/mNgv/Hxj
	40wFmszfbGvcvinF05aa5loSthU4DJTaeSENuxd9r
X-Gm-Gg: ASbGncsBbBollxHRAldCMd49svX7OW5z64Ai7A1cR1tfUF/8+G64r2HwW4WiL2HSfyt
	GWhSetrkywGWAEuLY8Sg6J1FDtLkSH4fnG3nrPtdoU8/NQe88vMY8AS6A6Hbn/1jcGJwN7eP9Fh
	nLZBlNjukyUTW3b7O/sJbWYKbCwTa2V+/7Q8OPzIm1V1Q=
X-Google-Smtp-Source: AGHT+IG7+8v8kogFT0/mnSqsIheQS6+VT2Gk/Es74puVTsuV9tUkd/CTGzoaKIcaMncezCtLdPZlZwKfCwPXYDgxLD4=
X-Received: by 2002:a05:6122:8285:b0:520:61ee:c814 with SMTP id
 71dfb90a1353d-53093688632mr459050e0c.1.1748676390966; Sat, 31 May 2025
 00:26:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521222725.3895192-1-blakejones@google.com>
 <20250521222725.3895192-2-blakejones@google.com> <aC9iF4_eASPkPxXd@x1>
 <CAP_z_Cg_vH1+BAm87U4gYQ0hDRGtHkkYb2DHtTRSd_QNvg3ZLQ@mail.gmail.com>
 <CAP_z_ChErhmooT5rhyXH8L-Ltkz3xdJ7PG20UKDpn9usMUgqTA@mail.gmail.com> <aDntjJcJsrQWfPkB@google.com>
In-Reply-To: <aDntjJcJsrQWfPkB@google.com>
From: Blake Jones <blakejones@google.com>
Date: Sat, 31 May 2025 00:26:20 -0700
X-Gm-Features: AX0GCFvP4PKt3NFBYoQVdhXB4HmMLosfmYPKc30P1NvRJeaacdkCzkp9zNZYmwU
Message-ID: <CAP_z_CjLtMq_FvmijnFUQbD5UUw=T9jP_pHWCw5fS=38dgSh9g@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf: add support for printing BTF character arrays
 as strings
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	James Clark <james.clark@linaro.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Ben Gainey <ben.gainey@arm.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung,

On Fri, May 30, 2025 at 10:40=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> I think it's better to go to the bpf tree although it'd take longer to
> get your perf patches.

Thanks for the suggestion. I've sent this patch to the bpf tree, and I'll
resend the rest of this series once that change makes its way to this tree.

Blake
