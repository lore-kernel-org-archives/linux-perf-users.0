Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F4E142E83
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Jun 2025 21:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750887238; cv=none; b=dDyM8SVLRqZuAGo2FaNysn6MzjK3qT+mkZff42qlhPObVM2LRSfDG7YqN1mDGsLBpHegDOQfUncnYT1OW7jT7H7SyZslJOl2hYUY/lPlVsViYL12WRdo762v37M5m07qgDMtBTFXYP80pRBEXxeTqk2+u4cxcSDEAlGawBydcW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750887238; c=relaxed/simple;
	bh=ggYYtkSgsTIFM6TYXPIenOdMm5KXbE0dEHr+DwJiqoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2TIQMEGcXDnXxP5W2pVy4UdDDDeknBceoMq738OtmvqQYEoyyc+sfp7K7GKoyRVc1rwf5UyJemDIiXR0X/wTfblZUyIFIxqOiQrEUs4OljrvNHfZSfB48OZGA+oGG97tQJZ3IGKHGJtp+zP3vKBBxqW6j1acNHTJOO3mcKNQjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qzlIjk2G; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qzlIjk2G"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3de210e6076so10995ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Jun 2025 14:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750887236; x=1751492036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viXeojWpY2MRwpzm578tuXycnwNkllpVf+Pl0j+tdQo=;
        b=qzlIjk2G4psWcznCmortxcjfxR9UDKA/6tfkkEKloCoCXZKO0/DRzP7Zz9WuJA6cXe
         RUtzeR5/QNAK7yOGBB8ptPKzoUL+0+oOijwVIFKipTJFk9T6ccQ7HcRD3wzo2v5K1jCJ
         5dxPPKeDOcNufX1snvfbKMHpf94RaWmxwLSarQ+ly7oDj6o+lWr3EgKrYveszBuJaNCH
         l/DJL5qkRvJI/Zg3LV2QVrUJesXmVVe1UmZyYieBPZjnpCOtisKgZXHQ3WSwYLFCSwOR
         EJXJsnBygo74Y+3TAm3h56RFgFFb0TXwCAWQEoRS8A0dRfk2p6Qj8V9hw7e5DT6kWJLD
         oyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750887236; x=1751492036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=viXeojWpY2MRwpzm578tuXycnwNkllpVf+Pl0j+tdQo=;
        b=qQxAFWN4NrRHUrjb3nOFi3EWIhIGGcq6+cDnCkpk68iBUJSpDyOOHWL5HVPs+VRW0B
         yopiu18e7wn5H1NHZC40RgC3t+ir2tF7+vN/CbUyhL1KrZUAQY7JyiEsQ4sKtnq7tW6D
         4BBP/lXVtVSdHnmiOEbzOINXOD8gK9N7afIKtt2ZlRial8Ei19UM1S1N0+kMCRh88VeO
         t7RvWeOLqNrZHUOPK9maJdXjtI99GVqbn1rzx+bM8lxI+0fLiiXNyfyReqS816bbNA92
         cAf3Q9IK4Ki2bnwka841Blb5aoFcQYReHW/L0Mbg2I2j3j/uJeTXlW/vObiEe0B8i1ZP
         uQEw==
X-Gm-Message-State: AOJu0Yxo9PNUDwHG080+bICaLH9u+RO83AMeqn8s7jaJDCBxeYotlguC
	GYJgllzS5vd3/o/a+4ZUHWckO/ZYVt8casL21a8LhBLsdrwlxTzFRog4tXuYY1yfGWTOLIvCPQL
	dU7s2jOLb29yLq79vcryMHCb4QNAaSa/1L6kwC2mv
X-Gm-Gg: ASbGncthFR4PTMgIFH89qDju9KnL50LH93HDTKWSUA2os23UM9sCTZ6gNQtLEjvc49/
	AmGbpGsl7W9hqfc5cf8WsoIiOdKhNsS5IvnNi+lwv3gDAYpDNmW6VCYXGgAvFJYKxHjIvgziiU4
	1ihz86k7zneIsqv7Ht9T1/CxKpKFxqfiJgQD66VqlaEPpRZAfSUvQ2x2KzqO1bDCAGmiXswgu8
X-Google-Smtp-Source: AGHT+IFdX/8fYSsxuNYM2MoFbGqUhMTT49vo4RGaIl8cUl0EIead4y6GT4JZEpDoxZw3twfDLccf6rZ+VZzuw7LaJrw=
X-Received: by 2002:a05:6e02:1aaf:b0:3dc:7e01:6f6a with SMTP id
 e9e14a558f8ab-3df3f5fab27mr981365ab.26.1750887236188; Wed, 25 Jun 2025
 14:33:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625202311.23244-1-ebiggers@kernel.org>
In-Reply-To: <20250625202311.23244-1-ebiggers@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 25 Jun 2025 14:33:45 -0700
X-Gm-Features: Ac12FXwHyHpNvyuthY1qkC86JQd06byT5GjQhW0vfB34IuD7BdSTFxs2oIntQFA
Message-ID: <CAP-5=fVkaO5Yyij_Hh=R56M9ECcH1gEBQLO1QDuOmQBqBNoN5Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] perf: Remove libcrypto dependency
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang Kan <kan.liang@linux.intel.com>, 
	Yuzhuo Jing <yuzhuo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 1:24=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> This is a reworked version of
> https://lore.kernel.org/all/20250521225307.743726-1-yuzhuo@google.com/.
> I've changed it to add a new minimal SHA-1 implementation, instead of
> trying to pull in the kernel's SHA-1 implementation which is not really
> designed to be extracted into userspace programs.  I also added a test.
>
> Changed in v3:
>    - Rebased onto perf-tools-next
>    - Removed unnecessary parentheses in array indices in sha1.c
>    - Updated my email address.  I've started consistently using my
>      kernel.org email address.
>
> Eric Biggers (2):
>   perf build: enable -fno-strict-aliasing
>   perf util: add a basic SHA-1 implementation
>
> Yuzhuo Jing (2):
>   perf genelf: Remove libcrypto dependency and use built-in sha1()
>   tools: Remove libcrypto dependency

I'm trying to make it so that the -fno-strict-aliasing is unnecessary
but we can remove that when the changes land.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

>  tools/build/Makefile.feature            |  2 -
>  tools/build/feature/Makefile            |  4 -
>  tools/build/feature/test-all.c          |  5 --
>  tools/build/feature/test-libcrypto.c    | 25 -------
>  tools/perf/Documentation/perf-check.txt |  1 -
>  tools/perf/Makefile.config              | 17 +----
>  tools/perf/Makefile.perf                |  3 -
>  tools/perf/builtin-check.c              |  1 -
>  tools/perf/tests/make                   |  4 +-
>  tools/perf/tests/util.c                 | 45 +++++++++++-
>  tools/perf/util/Build                   |  1 +
>  tools/perf/util/genelf.c                | 85 +---------------------
>  tools/perf/util/sha1.c                  | 97 +++++++++++++++++++++++++
>  tools/perf/util/sha1.h                  |  6 ++
>  14 files changed, 156 insertions(+), 140 deletions(-)
>  delete mode 100644 tools/build/feature/test-libcrypto.c
>  create mode 100644 tools/perf/util/sha1.c
>  create mode 100644 tools/perf/util/sha1.h
>
>
> base-commit: 9c9f4a27eb1096beb650f312a1ce996a9960b56c
> --
> 2.50.0
>
