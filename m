Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E971F4282
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Mar 2025 05:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741064664; cv=none; b=C9EYwjgzVTON8vwmAf6w1GRMJ08IzTGrrsiS8SRLQB8FqhplmmVdXGa8yyckRL++J22hSB2LVk9K1eRvG7P4WfAjcjMBwy9cObDBTEot1lRv2uqvUPDkMVMofo7YpPSMRlpMHKQtx6lUEmMybD8cbylZ7nqEX8gCLc9201ygPcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741064664; c=relaxed/simple;
	bh=KrPBT2BP1FIt1HzmJhzqOiRjmGa314IsSEmR7HsAVPw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=LGhZWOEWusnnOGYxN4ckbc8Zk1JKTrrsev9rNafngyNkSapHqYhuZqPWsOAkyiSoPL5/8JIyHp7FdQ875jDRmALs5eKgu0qz6mbrBx4cX9mE1dcDUN8xONgLyhd4XSKoFYqRzpivqNPp8fiEWwLx9C734KHugcIdCTZHdZ0aB9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G+Xtz0A+; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G+Xtz0A+"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e60978290acso6758345276.1
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Mar 2025 21:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741064662; x=1741669462; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DvRfiETt9/vf5K0lL/pnBeyo0XjXyN5OT4Sb89ZDY2A=;
        b=G+Xtz0A+f2Q0anmeUeFbxp3jUm4cKmlgXxBMV6gRKJUQlpo8fE7wBCmkZVum00NL0x
         WDxWCzMgOu9fXNee1xKK/AqkQNfz88y1SlUX6anYkGnjoAaxjRNTx3PLSEYyYhlt0uPg
         3hlxGotLI3535bUatV1IUQh4E53k4R/y//KM4i3rWNrq1UvRWV4ge4OyXqVYCu6Me5bQ
         B+AkYoWmG7KU6EHTWh9k6TfyoFmF6MdlY4ZFoNz1oTviP5oF1H6/gZS33JaV4dmpObZc
         zR0qtBH/9vRp3KTui23MYHLtlOWEYsFUltD3yRG1q9aFPu+PAQoiJCJqohcSNVEef3tQ
         b5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741064662; x=1741669462;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DvRfiETt9/vf5K0lL/pnBeyo0XjXyN5OT4Sb89ZDY2A=;
        b=cGrIT6vOIhsnzFKxOTg69du7Zz0rNvYqvqzOl5obVhZWHqhRjRW+1+dq2gaXWCJ9RY
         nMt8b1CyNkRYG8G5SvwbY4vGDydzXzm9QWIKikK0meEJQO6qUBEVWLLg5g9zBtq4BB35
         ystHZS+vLFIJAX4HcC+Km4k7FV+H63KDGyoASdSRM0ExqCe7i3wQz13OR0kKJbKq1RlB
         w6rUtoMwXWXzIpJYXZWV/QPSc8UqDzo0yuR6CKU3XzVKTpiLDNMvkEPOAnQMTOYLHpv4
         0Q3Z3uDnltgtuh5TpNf3o3l1pEzg4bbF4lbLUs1xn3e+T4xsBShfTpeDGiSUmGrvOpgO
         apZg==
X-Forwarded-Encrypted: i=1; AJvYcCUTxwG9LKM1Ou6wZHF1E1wqytuew9WfWxVjFDPe2X8VReH1EG30XMuECu8ahia/i2VHnUloHUx2Rn+1i3Hs1QS3@vger.kernel.org
X-Gm-Message-State: AOJu0YxnhZmfYbNGmIiMnhcvXjQJ3GgLSo0rrx4r0mMkcTtdhmXwivQW
	jF2fW4uKujOeD9nNIrBtpVyXrtZvqeJrFbl8Bw2oxdO33tBxiQCsCsut7OsgPnHAVYXS9Qo00uX
	t9382fQ==
X-Google-Smtp-Source: AGHT+IGBQB6dZZ9Csl0mZ1y8IMIjXPBoV0Vt7a8kIB2h5g+5h/WV1kubj5dpIBkqnpDzwoAkqybaXtIaN5v8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8af9:d1f7:bca9:da2])
 (user=irogers job=sendgmr) by 2002:a25:7104:0:b0:e5e:1496:7371 with SMTP id
 3f1490d57ef6-e610c1e48d9mr214030276.0.1741064661618; Mon, 03 Mar 2025
 21:04:21 -0800 (PST)
Date: Mon,  3 Mar 2025 21:02:55 -0800
In-Reply-To: <20250304050305.901167-1-irogers@google.com>
Message-Id: <20250304050305.901167-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304050305.901167-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v4 01/11] perf dso: Move libunwind dso_data variables into ifdef
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
Content-Type: text/plain; charset="UTF-8"

The variables elf_base_addr, debug_frame_offset, eh_frame_hdr_addr and
eh_frame_hdr_offset are only accessed in unwind-libunwind-local.c
which is conditionally built on having libunwind support. Make the
variables conditional on libunwind support too.

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
2.48.1.711.g2feabab25a-goog

