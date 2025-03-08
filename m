Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163159475
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Mar 2025 00:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741393937; cv=none; b=pLvfcLRMUhFIXzozHS25yJiuYGeKxEaHwOESASjeq+BrRLKikGzKT8ry31tNUT0NPx06ZMeA+G/WBr3c98QQQ560x416Sa38QQ4SgU9+P22z0+HrKrpaOy99LhNyTopWOW5BxBPc4S+QlWEuvAcBq9b7wB3VR79psF2iRzd72ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741393937; c=relaxed/simple;
	bh=itceXzcWP1atjoAHUjimAtWQITJXd7w88z0cdHciNBg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=Xcn+HuPgm4vIVBwJ4CIwRdlBRUPGLWpeRk5DaPM04jq8numJjT6i3kZZsxrFO7z0QSW0kdJJvrq5Qxw1+lCdCUTLUgJ4lvegNrABzwTDhly8+Nqn59I/P4UhmhuNNPRv8A8L3bRrnop+rbbgTSHUeRWG/GeUSJCjGcAkDMeaqDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2nRQ8Mfe; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2nRQ8Mfe"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e575f472438so3871916276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Mar 2025 16:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741393935; x=1741998735; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ivnbhuhI/ixgKyNuqtV9wf0AaXG2gqT9U4XDml1DXZU=;
        b=2nRQ8MfeNrUSJ6y6rPfcxnWaA8gwbOXfckKIHh2z79iH8cNP+tmWFrBknL4/jecJmA
         UK6kDxjQdQ74SkrzHNgVJY1arDHjnBo3e6MTtUg+aPMvayhaSvl+r2rt6UI6phukmIeP
         5FPgsx53FkBsGKk4QOHZRhGBBUOeUFDkjxRo6QNkabpM5CVR7NaDnzNnuqvzPbhRYpMo
         Lnzu//CR6TVKKKQnBxcEy0vy0qLuBg9tx1YDVEuqRAFtnBAqvQOaPO0Pemmk3mA1cwHw
         u+WgC2GuFWwTp96+c7MqBoZUR722Yx+Ga5iL6d6n63EjBlOigfey8ruilN2PjguTwRlM
         h3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741393935; x=1741998735;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ivnbhuhI/ixgKyNuqtV9wf0AaXG2gqT9U4XDml1DXZU=;
        b=OeLspUrMkzOdqMcKfwUkhBqQc9ijqKApoOI/xTYKJ/OCaH8RonWcOi9x7Zw/vi/zR2
         5a0FL/K31dXprqUHj5M1fhkDXEKqU6uwVhcxV2KHW4eVh6Ji3W8p/3K3M1M9rWDNyXNa
         sOIzyxGYvyy4+MCNprvJQbXspQKCoeC/3SogdS4HfH/g3d+8UlJpWLIl9lH+cvkIRKG6
         bC/89WnLYEMmcUtnXQKzSFhZIbISvrPKNFBz8plmtvK1JzsKLqkoqTshH+TAUNdkxlbi
         /9nej8pXLDlhx4VTfrnND0cHOwK18a5ZFe180LRqmLKcoY34355n8C4pEPIQfwxlbH1p
         3CfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCZnwQ+quXx3VZVY9MjLYQ2pWNDRhdgULfMtBF9RGNy7fekPTtu7Td8Xy2b/py0ZHQiUyitEVeOA22ZZ4cEsld@vger.kernel.org
X-Gm-Message-State: AOJu0YzFajxTXDQmuTdcCvL7gWG8wZ4ioTuvq6nGug/GzcDuHRDIkrbR
	69FgnysPD0yt5kSfZEb2imn/C4gN/WhBdYZqdFfiwrqZWteZY4BMU8EQ5Egcv6lOpDRYx4rkPW7
	jfUKNPw==
X-Google-Smtp-Source: AGHT+IG6YNEzBmSnRkSpppexP7sY3bjIUwdOpxoYGty73UlROUhquWw1r9gEA9sFFMJohI1jVlJGdzxY77PY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:1541:e490:aa80:5766])
 (user=irogers job=sendgmr) by 2002:a25:728a:0:b0:e60:96b9:bee8 with SMTP id
 3f1490d57ef6-e635c1ecad7mr49692276.7.1741393934929; Fri, 07 Mar 2025 16:32:14
 -0800 (PST)
Date: Fri,  7 Mar 2025 16:31:59 -0800
In-Reply-To: <20250308003209.234114-1-irogers@google.com>
Message-Id: <20250308003209.234114-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250308003209.234114-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Subject: [PATCH v5 01/11] perf dso: Move libunwind dso_data variables into ifdef
From: Ian Rogers <irogers@google.com>
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, guoren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Charlie Jenkins <charlie@rivosinc.com>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@rivosinc.com>, Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-riscv@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

The variables elf_base_addr, debug_frame_offset, eh_frame_hdr_addr and
eh_frame_hdr_offset are only accessed in unwind-libunwind-local.c
which is conditionally built on having libunwind support. Make the
variables conditional on libunwind support too.

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index bb8e8f444054..dfd763a0bd9d 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -154,10 +154,12 @@ struct dso_data {
 	int		 status;
 	u32		 status_seen;
 	u64		 file_size;
+#ifdef HAVE_LIBUNWIND_SUPPORT
 	u64		 elf_base_addr;
 	u64		 debug_frame_offset;
 	u64		 eh_frame_hdr_addr;
 	u64		 eh_frame_hdr_offset;
+#endif
 };
 
 struct dso_bpf_prog {
-- 
2.49.0.rc0.332.g42c0ae87b1-goog

