Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794344063;
	b=OSv6j6gnlohlHvzXaNEvsOl2TXk6junFUK5UQ15lvfiUcp1Onlq2O+1yvnuX2tUPzeQo
	 24o75Sa3XTcPp49aZpW1aJRTaLgK2Dz46El9YUkfdj5YCRcntXzj+bORdYp1WnXj/3pB7
	 7MaKtN+iEos2MH7ltPVceyFBPdPoVVlY3+7bf5sC67EgpyEmxygvXSWF5BXYxVi3y0dLp
	 8q4dhdGWn4q+Pj60Ab5Za/9eNxsY+kWzb1yajxh2Px7IxeKGDZ9IbL2n/whrgSdZxAp11
	 g+xkbxF8CjRINVZ/Sy5EcrOVxMJTgtUJSJkdayu4Mpy6Yn+Pxq5iyeDs8gAGHsZ8/oA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344063;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yvRZ4NPr9zuipnBz8AO8lnblNbdj7j1u7mqaDBMXrDI=;
	b=4GVCFyJYd7b3c1qitEsh3nhfQ10hvEEvBK8AQRnmkOA+HnM0rdwDfJlkQ/uSz1Y7ZcaM
	 EAkAzNqFjC4JTkMdMfhwpdB5vIQ5ph159+d2t/VjF85A8w8TMoVd1CEUeKKIl07FN0N9S
	 9LuEg2UkGOn7Q4uovgJtxKSQwkixY1kLJ+toT3EGoVTBzP/wtbFhJsQz5iMWJqFrGfsi1
	 6+4034V4i2oGFv0RzZuYi1XhvTu5ZCAxAqdtIgm64CZoewYVn7tF1Ro81mazr2AuiCsE5
	 +dbdBA6NSC/7r7PRG55kTJoSNk74bRGFS5AJskWqUHdjtLKOshvlOjqPbpv6B/Q7nww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JgZ5Sbyj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EEE606A320
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 20:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72EEE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JgZ5Sbyj
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-54492d8a988so9971cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 12:54:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794344062; cv=none;
        d=google.com; s=arc-20260327;
        b=VnJYnF9BIRt2fC912/LHbHa4C0caJpknvWRbcrc7RMYzXHyS/RMKuJJQ0mcY2YSKVc
         cq6vf55x3LHNsruVE/JSuNSoAlCy3HGDOeth4l8UXTWdxaSE7eOQE8NI/K9hFKrV3m4H
         MNWp014uuB9oHHT9J1AS655dtu/kVRGYoOWcYgYTR2F2ZebBAh+3l2zWsFWJDF4/c00P
         rX37ERzRECL5K6niPGYgltntolwCfhIPaZbcQ9eIebi/ep47s7iQRKc+/4IshYkEi2pn
         a+1ibYbiTNrg54PUlxlkLuvSLiAg7RzkYLKWSHCJbDXg4TCyyxt/Js0lrajPYrPZlHNS
         J29Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yvRZ4NPr9zuipnBz8AO8lnblNbdj7j1u7mqaDBMXrDI=;
        fh=A6OB7Co4ufmtR7OZGw4ey1sSg/2MTVtrJcOjEhZ7Aps=;
        b=leXoYJzuUVaybm56eb+MrLqR6ABsZwmiSL2l0hcqBN+fwqf6j4l1wBu4SzEioKJYdY
         6S/l9Q7Cpla1CXeLt8VJ1qPIsfAAve+tQ9ocesg5CdTmzmlTDRETu8rfNcNIccM0b+JH
         nSGb4KXNy2BbFG6KExtsDRkzRZQziJx0HMbKX0rAcCkpN0q2rZr4UjxNzJEcoh7y1yEa
         EohdAb1IzZ5wcfshV91nkegoKbmH6zOnrV7dNufYOg+ctFlnIOW2dyKzLZDNis4+u9Ls
         7TftXQi2zTDrrRVlFL18+CJUOt9+hsMbh0Q5YBPkx0Pik+1tWMgz3axRt+f8ZnXp30kZ
         hbew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794344062; x=1794948862; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yvRZ4NPr9zuipnBz8AO8lnblNbdj7j1u7mqaDBMXrDI=;
        b=JgZ5Sbyj/bfTX1B8fNhEYDl5JbvzsY1ATjB7buyxeVt+W8gB3qInKF3nG1mSpWS7Hq
         HOm4SmWKKTKKCnp3ZEBCWtqjTye+taOOsvKWqAl/+6vCDSMwmWTk6TVM/AwaW2zXSmaX
         zpC+XqEpMqOgmJj7MIOauDRJgHLcDHQAUFouhWC2eeugb2VFqD2qkbIWB/GZSy3Wv0zC
         VoPe2Jw1B1RSXo1orcbn1RmOrLIivsFCJeGUzmuzrRSdEdYjFAtWJjMgftqBs/UtEcVa
         n+sEaWQ9fLVVINL5CH2z/MyOc5Nb25mNy7hP0DVd+Aji5+Blze+HOfFUjkYB3BCAtYgj
         IQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794344062; x=1794948862;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yvRZ4NPr9zuipnBz8AO8lnblNbdj7j1u7mqaDBMXrDI=;
        b=IEqA1RxZIsPiG3gNAAjzeNX3+hyfRbHjjCGmZxsa4enlw96dOMFxWDfMTwZM2hWHqK
         I+byR6W+iz2cyhuqHt7o2TKBzyMUlH5KtCD57KfHXUZI/ACcXG3YIJ1dnJGxFBBRF1Ii
         YQ4fhfJlOUW+PhK5qdYzxandl/EO/yAV1EH3CgsTk11n/7ykxEvE0LD0Px/Xz/BZBiap
         Ryf0ZY0PddevQMYnmtzb1PBKF2gtTPRV0/Us4gllMEHMBOIIQ1HYqnvHGl/q/shFzIf/
         jj4h5soi/TymtMHZ+OrUJqoebhdKF882ZVdmKaAse0ySI5ngkxTUoXTewEDZBq2wBGCw
         9lrw==
X-Forwarded-Encrypted: i=1; AL+hErG8KL0F6W3RQeSqVX8MFRTmG6MQtgXf4/RNcbdi6dvVVbN4Gi9ubPn6RzJVPYMez4Hsy9xJ8TW4tUHuHNtalmlj@vger.kernel.org
X-Gm-Message-State: APuU4Z8MpJ3dDyJK85BwiLwwjPynHbzD0gOjhrml6KssOzUss06denG3
	5KlQbmxe7cO50YkSQUkyXgi8wZQhIkrrgipJPx29WqHK2NjIkJ+dl3/v55po9NPqJGOz1spT4pz
	tWOGLYxvXsU89Axr/ZlruqUtg9vf51etpBTyqe1DL
X-Gm-Gg: AYBFou1j0YTWM76TIS7Iq9QThUuIiYA08Oge1U90Clyvm/qgNPF3Xw/qWH0N3JXLJe1
	62ztRdJkNtZT3P4jcBehWh6EzITIbA+iHTyTn4jX/QNMbxlaI3iLqFbOk1fewzb7I6BZs4CYKt3
	IbL/oXbA+xHFtXHRh98rOIhSxSHqw0n7D+kUVkmLlY8+R6dBv0xRqVSqU55sHsRr/n65pfBPUps
	943Cseu+AAqcUKOrA7gA1FU5Ru6vdlKyGQRVLpcSlGos3XECLKmDSA2y2JYkJIFF9U+f+Vqylq1
	xE+CXNsRRS8ONjSD62PY53lTcSrasjAWbw16hUHIaD7dPdMDmqPgYTozqQeqdTuA+RCsV9VgB71
	0MdnemdsUDT4Ys5l2MbVJto5U/WTFi2qba1Repw3/VeuCwcQMzSLNX6gCBs/uYLXqB+E=
X-Received: by 2002:a05:622a:4c8c:b0:542:fc60:fe23 with SMTP id
 d75a77b69052e-5569edef00fmr3545561cf.3.1794344061730; Tue, 10 Nov 2026
 12:54:21 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104043006.1199857-1-irogers@google.com>
In-Reply-To: <20261104043006.1199857-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 10 Nov 2026 12:54:09 -0800
X-Gm-Features: AclHuK8u7iu3KreUV1BOly4WRgYcjdLxbePAeQ91RkjuMYcADS4FO3F63l0qY-8
Message-ID: <CAP-5=fVJfHEt1NTJg43tyGoQuJO4AgBaHzBZQHN9fqPef7i5=A@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] tools build: Fixes for libbfd -lzstd dependency
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, James Clark <james.clark@linaro.org>, 
	Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 8:30=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> This series addresses build problems when linking against static
> libbfd/libopcodes on distributions like Fedora where binutils is built
> with zstd section decompression support (requiring '-liberty -lz -lzstd'
> together).

Hi,

Namhyung/Arnaldo, could you help review the tools/build and tools/perf
parts of this (patches 1 and 2)? The objtool and bpftool changes have
Peter's and Quentin's tags.

Thanks,
Ian

> In v2, commit 89d001d48ec7 ("tools build: Add zstd to the binutils
> library feature tests") landed in tools/build/feature/Makefile at the
> same time, creating a merge conflict and only adding '|| $(BUILD_BFD)
> -lzstd' without '-liberty -lz' or the corresponding
> libbfd-liberty-z-zstd feature check in perf and bpftool (so even if
> test-libbfd.bin passed with -lzstd, perf and bpftool would link only
> '-lbfd -lopcodes' without '-lzstd').
>
> v3 rebases onto perf-tools-next (v7.4-rc1), fixes commit 89d001d48ec7 in
> patch 1/4, collects the Acked-by tags from Quentin Monnet and Peter
> Zijlstra, updates the LIBOPCODES_LIBS comment in tools/objtool/Makefile,
> and moves the AI assistance disclosure from commit trailers to the cover
> letter.
>
> v2: https://lore.kernel.org/all/20260909204122.1993010-1-irogers@google.c=
om/
> v1: https://lore.kernel.org/linux-perf-users/20260909181030.1870496-1-iro=
gers@google.com/
>
> AI Assistance Disclosure (per Documentation/process/coding-assistants.rst=
):
> - Tools used: Antigravity coding assistant and Sashiko automated patch
>   review.
> - Summary of prompts and assistance: Rebased the 4-patch series onto
>   perf-tools-next, resolved the conflict with commit 89d001d48ec7 in
>   tools/build/feature/Makefile, incorporated review feedback and
>   Acked-by tags, and verified with scripts/checkpatch.pl.
>
> Ian Rogers (4):
>   tools build: Add explicitly sequenced -lzstd to libbfd feature
>     fallback
>   perf build: Add explicitly sequenced -lzstd to libbfd feature fallback
>   bpftool: Add explicitly sequenced -lzstd to libbfd feature fallback
>   objtool: Add explicitly sequenced -lzstd to libopcodes fallback
>
>  tools/bpf/bpftool/Makefile   |  4 ++++
>  tools/build/Makefile.feature |  3 ++-
>  tools/build/feature/Makefile | 19 +++++++++++++------
>  tools/objtool/Makefile       |  7 ++++---
>  tools/perf/Makefile.config   |  3 +++
>  5 files changed, 26 insertions(+), 10 deletions(-)
>
> --
> 2.56.0.385.gac671c819a-goog
>
