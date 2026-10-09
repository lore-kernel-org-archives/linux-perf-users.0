Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4FB2E7622
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Oct 2026 02:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791512563; cv=none; b=XwK2yCtpYsH+CFXgbHlIzpwU6vdklcBO+wXPOHCKa9ldP+rKIhOUNB8iBPCN1JeS7/2hBtecBy8PdMPjndIf1iGmONXnz7/68luaiMte1x8Dadj5OrgNfqGCBYp75cblY0lhJsPOvH7yGVsMJZVat3mPa2j+sGX0oVFYc8NbQME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791512563; c=relaxed/simple;
	bh=rZnfs9jlSy7nC72mCIFsVJ0m5TXQkQiypYbpWhi7fg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxRftuA6Xmo2QRUC5ae+J7i4dIwT6MngVZitdjbONSjh6Ovp663t/zs8UYVyUCDxIuS40EDL8fOjXXOlH2GGY/KHsmHuL1JCmdTQstxqep3tRED3/g9A5pmbWWPVOy11nAd/Fn0qiMjb/adoSx6qirBJpGCQKu+QMh6aE/558J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+B7Xs8m; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+B7Xs8m"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a171b677d2so25994375e9.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Oct 2026 19:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791512560; x=1792117360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pJgi0wCSIv3Jg52XE1Hkh6T6+QnvPZ+aw5SFZUSnXYQ=;
        b=E+B7Xs8mJ39DnYfuvLafpSsMI9xQdyC9cNyzu6GBEUCvuM3p1vOeJ2SNxU1U9hWeoP
         llX8QFlTR0Y5xDfwlyyDIPAqnOdYyjAciROlGiyI4bZ9N3CK4cON0y3nDM11ZpmX258H
         Z/0+IYbQvbiyfeK/koGYbkMc4rqKLTuIckSKIJzRDdjKlpPMyQHY5XLeK28OLxkQJU0c
         6tFGLG31y3SIiI8SKKdzyAdBAnHPPrRPl9PeUDMZPzYFfHlxRSz6tK8dsaYPqtpwxia5
         gIC38HiAjlqyQLhOl9EJ9TkyafBJFKcDO43qLbqUlS955crQtSMoeVC+DztPfHKefkWx
         7FHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791512560; x=1792117360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pJgi0wCSIv3Jg52XE1Hkh6T6+QnvPZ+aw5SFZUSnXYQ=;
        b=kNT1rztyQ0tNZn54TZbXhOfwBCXepXdBJlCTU6gkcKR0X3Kiih9JvZ5PedVcM7/zeL
         lR9qICvh24SEgzhlNtkrC3YiW2WczvAkyLSiq5cwIYymtXWGCLJTvE9cMgPi0kgBjf7U
         a+tN+oI1PbdMIQChZRU8UIDcxmWKhTw7pbYGSSw1tryQCD5uI8uxK9SJQfqD0ZvHkXHn
         l78jfu8jwmnDSTN+JdjwAxsdt9HJ+o8GezliJyHt6mVizy0dCPB2KUjQBRib/Vq/Ny76
         7LwE72q+keEv2YAyc5KBJQGEQZT3enIfSWzi8nsG+ng2RRQejWqe3/cMfBE5AD5lEwzK
         RWng==
X-Forwarded-Encrypted: i=1; AKwUvBzb3e3u7EdX4AUaXOR6859d477VpX+MIMNIJAaKczZvrewGqVBqeZFE427ug6jp5b9O9eOKsf0MRfYsriNWGN1Y@vger.kernel.org
X-Gm-Message-State: AFuF++nqSi8ZGwJDr5IkhDFrvhVsMBdjTDm6XfhSwiQIHDFI1BmnAfRA
	6vE/w5Kso7mNNLOUwaS1BVH0VL0TOXDfg7N9kyKIINtO4S80nuQXwC3q
X-Gm-Gg: AYBFou3/WP48zu//e7TuDATb7pnQy2LPOhsrMJ3vyA3mj/PwBK40vTGGzpCNB8x2oFR
	mMDGvVnh+1hNoIs0hhBKGTOJH7+Hogb9eEFQ9Zx2GEB3WQQiDkumoUqqlOYGJ6dy81cPiPqrMWA
	LYkyXzUsn/zCHuK+x2FzdvNAsHScpGwy5t707VhQjuI85dwbVltjUK+8hZH/hz3WJ3z9Czr4Dl9
	xsEkzx95sBcQ2TGIRU04hT0/w7Z6l6taCDs4e9wTBfsEXfWUWfg4Qc+ji4Mc54WzARU3Tq1dw8t
	W0M1Y4yzY5cZkGBiiy88cLx+y/yZ3vmL6/Hifw9XShRPvRX5swTbxugcW15IsaH09gCLvF0EyHX
	zrkEb5Q6nXrbaQfssTnJR7kHC+kJfXKWyWuX1Ds0yobRyDDRV7ETuml1qmxlYtbYSaoAf1pG33J
	UOvXB9irbATGYEj2HUV/cByeWyDHE1dB3nmEjDwbsDDK1Etf9LxPtmSh6ZYuleQUMfOH1xheyJm
	p+ptv5ot58i5k2rexWhyTJ0mF6OyvvXy9lEVcWDIvIWAxQecSdehR3+g4qwqwR5a/PWN2SX6HR2
	UHm0+RMTL4s39+OSwpi2nQEJMD09YeolR+5SiwPuvyLLa++pJ2M=
X-Received: by 2002:a05:600c:524d:b0:4a1:80d8:aeb3 with SMTP id 5b1f17b1804b1-4a18e4a95c2mr5608385e9.12.1791512559401;
        Thu, 08 Oct 2026 19:22:39 -0700 (PDT)
Received: from mikebook.tail5724d6.ts.net (83-244-142-114.cust-83.exponential-e.net. [83.244.142.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf3e044sm21438765e9.14.2026.10.08.19.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 19:22:38 -0700 (PDT)
From: Michal Pluta <michalpl2003@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	acme@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] perf symbol: Grow the Rust demangle buffer geometrically
Date: Fri,  9 Oct 2026 03:22:34 +0100
Message-ID: <20261009022236.992515-1-michalpl2003@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <asVUvfhz4wG5CnZC@google.com>
References: <20260928010227.1903673-4-michalpl2003@gmail.com> <CAP-5=fVe=VxnxypQYNt1h-s+3=Me8D_fpBL3LD1Eeb1cGvUc3g@mail.gmail.com> <asVUvfhz4wG5CnZC@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Sep 28, 2026 at 2:43 PM Ian Rogers <irogers@google.com> wrote:
>
> It seems changing the scope of this variable is unnecessary.
>
> Thanks for digging into this problem and exploring a fix! Previously,
> we guessed the demangled length was twice the mangled length, then
> added 32 bytes for each retry. These were numbers I pulled out of thin
> air, so I'm glad you've found them to be wrong :-). Could we estimate
> the initial demangled size better? Could you get data from Bevy and
> Typst? I'm a little concerned that a demangled symbol of say just over
> 2KB might require 4KB with this change, instead of 2KB + 32bytes.

Thank you for the reviews. I'll move the buf_len declaration back to
where it was before.

For context, the other demanglers in perf don't size their buffer by
retrying. The OCaml one allocates len + 1, as the output is never longer
than the input. The Java one allocates strlen * 3 + 1 and truncates. The
C++ demangler (libiberty) starts with an empty buffer and doubles it,
but it writes through a callback so growing doesn't restart the
formatting. The Rust one writes into a caller provided buffer and has to
start over each time it is too small.

I collected some data from release builds of Bevy and Typst and a few
other large(r) Rust projects. For each binary I took the defined symbols
and counted the number of attempts that the buffer loop in
dso__demangle_sym() makes for them. I ran both the current +32 loop and
the doubling one from this series in a small test program. No symbol
went over the 1 MiB limit.

Builds (mostly v0 symbols, plus up to 148 C++ ones per binary from
linked libraries):

  bevy         0f38358f573a  cargo +1.98.1 build --example 3d_scene
                             --release --config profile.release.strip=false
  datafusion   acf5c89e6454  cargo +1.98.1 build --locked -p datafusion-cli
                             --profile release-nonlto
  materialize  54a6aca7b5f1  bin/environmentd +1.98.1 --build-only --optimized
                             (clusterd and environmentd)
  polars       750bbaa9054c  cargo +nightly-2026-09-01 build --locked
                             -p polars-dylib --profile fast-release
                             --config profile.fast-release.debug=0
                             --config profile.fast-release.strip=false
  risingwave   be77a6149e97  cargo +nightly-2026-06-21 build --locked
                             -p risingwave_cmd_all --bin risingwave --release
                             --config profile.release.debug=0
                             --config profile.release.strip=false
  typst        9dfd3a08500b  cargo +1.98.1 build --locked -p typst-cli --release
               (v0.15.1)     --config profile.release.package.typst-cli.strip=false

Firstly some data on how often initial guesses are too small and how
many retries they cause. "retried symbols" is the share of symbols whose
output did not fit in the initial buffer. The other columns count the
extra attempts after the first one ("total"), and the most any single
symbol needed ("max"):
                              symbols   retried      +32 loop       doubling
                                        symbols    total     max    total  max
  materialize clusterd        295,365    5.66%  3,500,913  17,844   27,960    8
  risingwave                1,051,376    0.87%    297,151   1,561   10,180    5
  polars libpolars_dylib      276,797    5.61%    247,424     236   16,149    3
  bevy 3d_scene               218,042    1.09%    205,030   1,135    3,493    5
  materialize environmentd    377,085    0.51%    117,485   1,539    2,302    5
  datafusion-cli              175,020    1.10%     24,304     125    1,957    3
  typst                        36,504    0.12%        907      66       50    2

Only 0.1% to 5.7% don't fit in the initial buffer, but with +32 this is
very costly. In clusterd it adds up to 3.5 million extra attempts with
one symbol needing 17,844 retries. Doubling does the same job in 27,960
total retries and no symbol needs more than 8 retries.

You asked whether a better initial guess would help, so here I keep the
+32 loop and change only the initial buffer. Its size is the mangled
length multiplied by a factor N and rounded up to a power of two. The
code uses 2x today, so 1x is a smaller guess than today and 4x and 8x
are larger ones. Each value is the total extra attempts for that binary:

             N                  1x         2x         4x         8x
  materialize clusterd      4,507,480  3,500,913  2,460,193  1,528,046
  risingwave                1,306,091    297,151     71,074     25,133
  polars libpolars_dylib    1,254,174    247,424     14,214        305
  bevy 3d_scene               357,175    205,030     94,936     29,978
  materialize environmentd    271,354    117,485     59,697     22,265
  datafusion-cli              179,241     24,304      1,003         29
  typst                         7,066        907         15          0

A bigger guess reduces the retries for every binary, but the symbols
that still miss are the ones with many backrefs. In every binary, all
the symbols that missed the initial buffer have backrefs, with a median
of 53-138 expansions compared to 1-4 for the symbols that fit.

Running the same experiment with the doubling loop from this series:

                                 1x         2x         4x         8x
  materialize clusterd         70,399     27,960     11,231      4,073
  risingwave                  106,878     10,180      1,016        128
  polars libpolars_dylib       84,502     16,149        634          9
  bevy 3d_scene                15,742      3,493      1,115        192
  materialize environmentd     22,668      2,302        365         73
  datafusion-cli               15,366      1,957         38          1
  typst                         2,310         50          5          0

On the 2KB example you mentioned, a symbol that barely misses a power of
two could get a buffer up to twice what it needs, but the next patch
shrinks it to the exact string length before returning, so the extra
memory is only held during the call. I'll move the realloc patch ahead
of this one.

One other way I tried to avoid retries is a minimum size for the initial
buffer. Here the initial buffer is the larger of this minimum and the
current 2x guess, and each cell is the total extra attempts.

First with the +32 loop:
                             current      1KiB      4KiB     16KiB     64KiB
  materialize clusterd     3,500,913 3,500,867 3,181,650 1,425,379   216,505
  risingwave                 297,151   296,929   151,909    14,567         0
  polars libpolars_dylib     247,424   246,715    15,413         0         0
  bevy 3d_scene              205,030   204,818   132,911    17,038         0
  materialize environmentd   117,485   117,455    79,073    37,531         0
  datafusion-cli              24,304    24,277       866         0         0
  typst                          907       898         2         0         0

And with doubling:
                             current      1KiB      4KiB     16KiB     64KiB
  materialize clusterd        27,960    27,945    18,824     3,260       183
  risingwave                  10,180    10,117     1,887        63         0
  polars libpolars_dylib      16,149    16,043       686         0         0
  bevy 3d_scene                3,493     3,472     1,574        64         0
  materialize environmentd     2,302     2,282       419        88         0
  datafusion-cli               1,957     1,939        27         0         0
  typst                           50        47         1         0         0

As we can see, a minimum does help but it depends a lot on the size
chosen and would mean we incur a large allocation per-symbol albeit only
during the call.

Sorry for the long reply, just wanted to get all the data and rationale
across.

Fun fact: the largest symbol I encountered was in materialize's
clusterd. It is 1,091 bytes mangled and demangles to 575,074 bytes.

Thanks,
Michal
