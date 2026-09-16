Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BBF4BEE37
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 03:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789529818; cv=none; b=fdKlVV7s6tZ2SeSoHoqssJDKvcvVC9VQFCnuwnrwYsx2QnVEk/j9sNZ0rwa7Pg0JYxlgim146i5nyeqj6doS2ZCGFmchtB+xwhXnHJT1RDMFSxMwGGseHk2S6Tsk055wTbb5sGWRdxuBOD/SUVF2pmJNV/uBzjhi9gIcSRn58dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789529818; c=relaxed/simple;
	bh=t/7cVk6CHt9sC9kShR8pkY5ALIb3l5eigwsYVtwI5XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HiqvNxlkJZtw9O+OWChnwZYbIkhgvs19qDRdpBUs6VSuPhBiSodcGVZ3ohFzTIR+SNBtDnByvVqem2vf1Oy837cHaca1W08z4wArWOLH+LZzmj+S4dj8M5bmX9eRP84KvfWXXIvpegb+7pKzEFQMEdIgwGc/xOMkW7svRbK7rAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nvzkRl4h; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvzkRl4h"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so409460a91.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 20:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789529817; x=1790134617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RXF/2VuP88JGCim1C0zobHtH39G+DpBhAl/bzlRf5Ss=;
        b=nvzkRl4hFkXBm02xxee46PG5hT0RD1XUmITGTuIP1zbnbBm0TRYs99Ku+5W7VYuKq8
         /9OWwYu412wo9K9xa2sHMZMZouAKySByxbnNfn7Lj7jPBa9CEr1cx13jmI7xnbfeJip0
         8dTQ1gYJaFJYHkgUxRVDnz1reNyn84OA29dMWxLoIu35FaprWKeRvuQzaMo39LSg9DlD
         lEPxOgRuTU4swzRKQaxJPBZOmUq/WANFAQzfmlvGQBNVpXZQ5wmxBnXFt9uRRQ/Z8HEg
         /qQOzByQgd7mMCHTZ4vRhzwfiXC6YknrlHsk9bfcyCfrmrneeTUCNMBvsOUe/jUldyDd
         SM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789529817; x=1790134617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RXF/2VuP88JGCim1C0zobHtH39G+DpBhAl/bzlRf5Ss=;
        b=NBA6WhmSDDrEs2ArA8Qdc3I8V5Fs5al7oi0jPDH9r3yVQgSWZOl7zfJCn5PeisPI+7
         SvKgB2Y9mqimwZGrZdDcWf4i860zw+n8G0fatMonbvB959fJynaPfREQt9fP3K20v6a9
         Y4dTlPAIScc/hKJiaJDlWGPSok5Ha96lrf0vDUCbLlEQMqcr8mj52WFPmEFjoJAtAWuH
         /L6MlDlpLL9fXYUk7maQP9r57y73FN1KQrTmWbJCUnqu4eddqMpTq2tXuGluBn99W/4A
         eBDMe3hrs3r+VjgAcsADYormYI9eHCWZYC7PlBP1jraz2c+rsR1v/GMiSUax7qdBIKiu
         NjUA==
X-Forwarded-Encrypted: i=1; AKwUvByzi4z7kRZzLMG8XXKfLIkChSP1uDz893FsmFl4st9We+hjkdJ1w1OghkjBdTlUh1rF7bowRv1B51gwFqO7LtCK@vger.kernel.org
X-Gm-Message-State: AFuF++mfKLze+Fb+/EYhf6UbI4tilLMDkx0ET1gYRP04LO64NX3cYerr
	U+Ze7hJU75bqeOptkvmRm9KwewChPAy4iZUlx5XQ+97iD4YYpvljI0ETiOumlA==
X-Gm-Gg: AYBFou2EUxRPPRDL6iBY5EAuLLrPhP7vY+c7ePoaLzOXlPat7Vt2HbPzkv708ADWDr2
	BHKLX3i6D6hUICz24GkZd2hXQOgh9FP54pHcOs+JOOYYNmPS/V+Pcy/oAqzn7nbC2KLGpucHPdO
	P9CIyc6iq2WxY7HBvS6uU+YYK4UDnerOxXYhnes6ovcQPHnVdc4TJnqoSqkD/wGRj4KtbgwF+09
	GFNENSccnzeicd21AUHwOCnZrAk1X6dcYjOva95OBqyLpkkaHn2Y7GFeDb/hrNvAbynJPCXQT9v
	JYnmZsdUZfezFU9rrukhrT6VR6QkvHWbGjcPtypzCxPtw0LOUadyTxMiOoCvF+fyQCIcA1aIji/
	w1fEwXXbgNcE4hISmZGTria69oy/HApln5WMRjjQWevRkzmDjFlQKbYwpmeMHW0vYmyNfzz3ym/
	5bf8eF+7hjALOgKFLCUu2ntYFyRCw3LvBwAQ5OPK32zDkowcDgZrQpSf6QD3fowR12CLbCQb/Kt
	XXy5yLNXkE=
X-Received: by 2002:a17:90b:5388:b0:39b:92bb:9eef with SMTP id 98e67ed59e1d1-39e1e509fc1mr2522206a91.22.1789529816787;
        Tue, 15 Sep 2026 20:36:56 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b75bb3esm1871298a91.11.2026.09.15.20.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 20:36:55 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Ian Rogers <irogers@google.com>
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Changbin Du <changbin.du@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf symbols: Don't apply the symfs layout to synthesised paths
Date: Wed, 16 Sep 2026 11:36:47 +0800
Message-ID: <20260916033648.500387-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAP-5=fVXYFvWOEiH5R+Gc29nfKBGA6y6ULsT68Gudw7ErMVFsg@mail.gmail.com>
References: <20260819094621.844115-1-zhanxusheng@xiaomi.com>
 <CAP-5=fVXYFvWOEiH5R+Gc29nfKBGA6y6ULsT68Gudw7ErMVFsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 01:31:16PM -0700, Ian Rogers wrote:=0D
> In those before and after examples, the 'before' case seems to better=0D
> match what the user is requesting on the command line, so I think I'm=0D
> misunderstanding something.=0D
=0D
Neither side is the flat layout.  The changelog showed the prefixes and=0D
not the full paths they end up in, so there was nothing in it to see that=0D
from.=0D
=0D
For /usr/lib/x86_64-linux-gnu/libc.so.6 the base name is libc.so.6.debug,=0D
so the flat lookup is /s/libc.so.6.debug.  With --symfs /s,flat, the=0D
FEDORA_DEBUGINFO path actually tried is=0D
=0D
  before  /s/debug/usr/lib/x86_64-linux-gnu/libc.so.6.debug=0D
  after   /s//usr/lib/debug/usr/lib/x86_64-linux-gnu/libc.so.6.debug=0D
=0D
Both carry /usr/lib/x86_64-linux-gnu/libc.so.6 whole.  perf_basename()=0D
only ever saw the prefix, because the DSO path arrives after it:=0D
=0D
	len =3D __symbol__join_symfs(filename, size, "/usr/lib/debug");=0D
	snprintf(filename + len, size - len, "%s.debug", dso__long_name(dso));=0D
=0D
Before is shorter in its first component, which is what makes it read as=0D
flatter, but the layout that was asked for is on neither side.=0D
=0D
BUILDID_DEBUGINFO is the one I would not try to defend as intended.  Its=0D
prefix is "/usr/lib/debug/.build-id/", and perf_basename() of a path=0D
ending in '/' is "", so the prefix does not become shorter, it disappears:=
=0D
=0D
  before  <symfs>/ab/cdef...ff.debug=0D
  after   <symfs>//usr/lib/debug/.build-id/ab/cdef...ff.debug=0D
=0D
Where the argument is the file being looked for, the option does what it=0D
says and the patch changes nothing:=0D
=0D
	__symbol__join_symfs(filename, size, dso__long_name(dso));=0D
=0D
/s/libc.so.6, /s/ld-linux-x86-64.so.2, /s/sleep.=0D
=0D
So the patch is narrow: it keeps a flat request from rewriting perf's own=0D
fixed prefixes.  It does not make flat find distro debuginfo -- for a user=
=0D
whose debug files really are flat under <symfs>, both columns miss.  That=0D
needs the base name taken from the composed filename instead of the=0D
prefix, which is a different change and not a Fixes:.  I can write that=0D
one instead if you would rather have it.=0D
=0D
8 paths change across those 4 sites and 13 are untouched; hierarchy is=0D
identical between the two builds at all 21.  The doubled slash comes from=0D
path__join(), it predates this and shows up in untouched paths too.=0D
=0D
The v2 changelog also said four paths differ while listing four call=0D
sites; it is eight paths.  That did not help.=0D
=0D
Thanks,=0D
Zhan Xusheng=0D
