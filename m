Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CA51C3785
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Aug 2024 11:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943955; cv=none; b=HX3U1dJvihXkwmYeLgBto8drKTygzc2Kj6al3GiSvZy5a63yBew7MuUD4OZs4qinwmOtR/o1JIUKoTFp2tPEltuTF15e4er+9QGeRzQQJR+gDf0v/MY8AX1uAfFL3IhebYaSaYVbR2gxrkZ2JvLY9svFXbugmQrUmoQEJR/vm1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943955; c=relaxed/simple;
	bh=qIjEnSp/JD5JYvreiYWkbvBNFQ5Bxx+6BfLNwZTCc7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VYcM47vnhhLDJkH/CNvpkGG+IVGNanlfr3v8ZtuRW4LPfeYrECz2YEapM5ec+W0ttNQkKy425Lfn5yka8OMSOJWw/5jruIFpbgDdLL3JUN9FyLFNFPjrqPLDJD04q+ee90RHtuZsbwkHPwlkBH063a4hgSFmeEri0XUJjEqT/w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=D2Ul20yW; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="D2Ul20yW"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d1fb6c108so382070b3a.3
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Aug 2024 04:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722943953; x=1723548753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAh5UOxYiMS3JZXwzAnpcBRKJRQgjrownZOetlAThLM=;
        b=D2Ul20yWvyrX0ZpDxGjW1oFrz1CNqh4TeVwOxMzQTeapL4y5lxFs+rIDTzHyrH1GU/
         F9/6ybVUICer9d6B0Nnq1CDc2h1Hu8su/48T08+bq0EiiWnVaVA1g5BwLDivNNiTtse5
         EMqXX9hClaXpmDNhJ+DAtxGxhxTYWK/wfGObc8QImQCk5HQl6be43hmmAZ+HHw1iigCP
         4kAmiF8HPqjXpQ0QtSh1CvAIIybN4bHTlj2NUwA0vj3zShqXachO3FNn+iUvTWPCgTa1
         FkubmOOAfc1K6qbygZhkFYNLqURRBKpJK27ryFSYp468q/pImLupLPhnoYb3/tuA8goF
         uT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722943953; x=1723548753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAh5UOxYiMS3JZXwzAnpcBRKJRQgjrownZOetlAThLM=;
        b=iFSXWx6H9WqBBBXNrdQbZHWs9rIXpeaVEx6X7cNzL2qnBYfCVchJGyLIANc7FA/yQJ
         zDFbOmalLxQXJMsqr9r0hqPul8a0Lyyj+QRlMBpeG0toZNwlHwItF0+nN9nEJSHFph7P
         7fuCDWtu8N2bGUuI0SXsZ7n8CbHRZU+tVNQoju44Wx81s672kVJPhtyHu/JaAVyNQzVR
         4CQ0HKTA+7DHsyrqSUFg01+6YM4WWDZicSRhbLF3IHqju3TtchB9PaG0PohQtnZ1J7n2
         i+5TEZvXGmj2eNC97ju6FWsvJOuDfG7NbW9SAjYOQRJMOxuznrS/l9p3aiu2SoVPFryi
         vI/A==
X-Forwarded-Encrypted: i=1; AJvYcCX+0UeASCN9IjGN7zD3FHj5hYQ47vgF4wQ8qaxIRGDQchCfU5VCz+Iegrp27UWoCtjVROUD+6lTo5U06OwDOMyfHN/5vEKXLZ9inbbYSs0uXA==
X-Gm-Message-State: AOJu0Yz6vzGO3mu0Rf9AiKrqsZM8nvjeZyb3QAmfRq9RpoDlcFZD9lfy
	mk8EoYjqvVVEzyf9pGiE2yQwrywh1chyPdiwrohzHrtNeKOq57vnVAzYyP++1fg=
X-Google-Smtp-Source: AGHT+IFLkMm1nd2fsBj1xrh3zpLNwTqpqzJAdGAu26eIbMgvxuF4IME8khxZS1c42atzcqMwOFNk0g==
X-Received: by 2002:a05:6a00:1253:b0:70d:3587:c665 with SMTP id d2e1a72fcca58-7106cfa14damr15822735b3a.2.1722943953092;
        Tue, 06 Aug 2024 04:32:33 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec010a9sm7037636b3a.10.2024.08.06.04.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:32:32 -0700 (PDT)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH 2/3] perf: build: Fix build feature-dwarf_getlocations fail for old libdw
Date: Tue,  6 Aug 2024 19:32:09 +0800
Message-Id: <20240806113210.1649909-3-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240806113210.1649909-1-yangjihong@bytedance.com>
References: <20240806113210.1649909-1-yangjihong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For libdw versions below 0.177, need to link libdl.a in addition to
libbebl.a during static compilation, otherwise feature-dwarf_getlocations
compilation will fail.

Before:

  $ make LDFLAGS=-static
    BUILD:   Doing 'make -j20' parallel build
  <SNIP>
  Makefile.config:483: Old libdw.h, finding variables at given 'perf probe' point will not work, install elfutils-devel/libdw-dev >= 0.157
  <SNIP>

  $ cat ../build/feature/test-dwarf_getlocations.make.output
  /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/9/../../../x86_64-linux-gnu/libebl.a(eblclosebackend.o): in function `ebl_closebackend':
  (.text+0x20): undefined reference to `dlclose'
  collect2: error: ld returned 1 exit status

After:

  $ make LDFLAGS=-static
  <SNIP>
    Auto-detecting system features:
  ...                                   dwarf: [ on  ]
  <SNIP>

    $ ./perf probe
   Usage: perf probe [<options>] 'PROBEDEF' ['PROBEDEF' ...]
      or: perf probe [<options>] --add 'PROBEDEF' [--add 'PROBEDEF' ...]
      or: perf probe [<options>] --del '[GROUP:]EVENT' ...
      or: perf probe --list [GROUP:]EVENT ...
  <SNIP>

Fixes: 536661da6ea1 ("perf: build: Only link libebl.a for old libdw")
Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/build/feature/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index b18513ec4da6..1fc651cae9e5 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -179,7 +179,7 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
   # Elfutils merged libebl.a into libdw.a starting from version 0.177,
   # Link libebl.a only if libdw is older than this version.
   ifeq ($(shell test $(LIBDW_VERSION_2)0 -lt 1770; echo $$?),0)
-    DWARFLIBS += -lebl
+    DWARFLIBS += -lebl -ldl
   endif
 endif
 
-- 
2.25.1

