Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C741946B8
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Nov 2024 06:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731133144; cv=none; b=kzo0ZuBQOAPjXyOiEbUpMPEJ2L0MsR+sT7i9UwXmHTHsPrJvJSJ1nD2ACrV8xqS6WsWhUF+OrlW56mibeYy6dZHztRZnzCDCToIz8xcqyhyYkAu3vNYzk8Qz9zr0rU+N0tR15p/CSldz18BKXG0bd/5iLc6jfxZniOA6aYKirOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731133144; c=relaxed/simple;
	bh=0iUYu8ZIw3nC+tEYsru/9b2KOk5bw5n11avghkE86XA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=V4pGDDvPqfrTgyZYGN/2Cf5/mUQSLNWuhMNTsWiGMw4GZijfmMjJ0n3dnDRG2uF3pt+OlZvmAuDpgK12RsUWbd4PMkUxUuDS0LZEhSrAv9BDZVG4oLnp2CWPSta/Bn4VxxPycS9sH00W5g2SH9lhgDGd6m1XTr3vADYN4LBQk1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pe0PyR/b; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pe0PyR/b"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02fff66a83so4821515276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 22:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731133142; x=1731737942; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S5SFBUvJ8uwJxM/+aez6JFuBLxdqirz/XmWsuAyloP0=;
        b=pe0PyR/brtyINSUrq2YTH4JmbZYi3hReROvO0OEF6Ey8JmnRYdQRaZIkIob624UDNt
         c0dflv/Yc88+fTaoh0mPokfV1pDlHh+Z8U+H5yzHsSE0XxcVrvHstRekv22XGREvqGn4
         6IwAyT8TxQrOLgVW/CiKM50T+zK5rEKoJYcR1lA6AFM3ZxAfJVUAMaeRrwf6jS/t51zf
         EpnHhx0vcxuCVYnkp8ablv6enA3tuvLNbsTQ01ta68TKMWQFTKEj9P4YNKBgf8pX6fXY
         ORI/KuAzmSa0pQ49B4PhfTd3WAK85i/OpXigEHwJqDSYZFlVhM6ukkFsHJaJuItrdyf4
         9D4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731133142; x=1731737942;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S5SFBUvJ8uwJxM/+aez6JFuBLxdqirz/XmWsuAyloP0=;
        b=WDhtGzDQXyglmCc8aW3i0de7bROhqHAISbTvmjpixRgKxGxt14Ud5QhYkS/tKGBgE5
         f899ybEPekr6k93VGHQiWtIcSx++SVFS57CgbibtRJTNITc64E672Vr/UpNs2XeDxgO+
         utjh3zs5MfQvkHuiGXpfInIfs4uvcx0ZlomGxuQyIxs4o+amZMhUYWTYjqUPYqC0ldbz
         1HEaqgSoxnf2xchfJN7lQ4K4aYgwobNGEyDog7BX20b6vEGEE0c9Zvmz7TPh0JKJ2CEE
         9sx1Qbw2OQCor69//81lQ5vDNsYHdIM2eGX/I+LgShxGRNYbzq+98jxL7MC0v58rmcxt
         o/5w==
X-Forwarded-Encrypted: i=1; AJvYcCUvRIykK9htEpOYrIx+mzQlNxHrbcpccCR6+cVfQ5XcanmS3vBQkhbarD6Z2REXF+3WJ3djuSgsOK1hW5qThoJw@vger.kernel.org
X-Gm-Message-State: AOJu0YyYhN1Apdt3iQWCLP9dZSaKVowPsDgsc4i0SRDZP9HsK0rlNq0j
	atge2A/R1Low3R5Xl9iHxhz087T1H6CLbycdY9zaoufDbKpY4WuhmHGRVLLc1ljKvOWCM6FWoun
	lxKkc6A==
X-Google-Smtp-Source: AGHT+IH9AHh43wZI95SDyksqtxouXEyTkhOjimgLo4B9ZLCzen6gdneqeJ2en9MS4bz5JA8JbbcbHNuqPciu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc2:d48f:a998:5915])
 (user=irogers job=sendgmr) by 2002:a25:3355:0:b0:e2b:cd96:67a6 with SMTP id
 3f1490d57ef6-e337f8c133dmr3844276.5.1731133142342; Fri, 08 Nov 2024 22:19:02
 -0800 (PST)
Date: Fri,  8 Nov 2024 22:18:05 -0800
In-Reply-To: <20241109061809.811922-1-irogers@google.com>
Message-Id: <20241109061809.811922-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109061809.811922-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v6 18/22] perf build: Remove test library from python shared object
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

With the attr.c code moved to a shell test, there is no need to link
the test code into the python dso to avoid a missing reference to
test_attr__open. Drop the test code from the python library.

With the bench and test code removed from the python library on my x86
debian derived laptop the python library is reduced in size by 508,712
bytes or nearly 5%.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index cbcb698cea38..adbc7ab325c7 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -487,7 +487,7 @@ endif
 EXTLIBS := $(call filter-out,$(EXCLUDE_EXTLIBS),$(EXTLIBS))
 LIBS = -Wl,--whole-archive $(PERFLIBS) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
 
-PERFLIBS_PY := $(call filter-out,$(LIBPERF_BENCH),$(PERFLIBS))
+PERFLIBS_PY := $(call filter-out,$(LIBPERF_BENCH) $(LIBPERF_TEST),$(PERFLIBS))
 LIBS_PY = -Wl,--whole-archive $(PERFLIBS_PY) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
 
 export INSTALL SHELL_PATH
-- 
2.47.0.277.g8800431eea-goog

