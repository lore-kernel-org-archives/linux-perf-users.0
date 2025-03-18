Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C149617A2E0
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Mar 2025 03:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742268720; cv=none; b=klE4e7/+rMyzJrsDzmZ6tGM+AP+wdL/2THpjOl3bnOW8av09P71MC+a2U3Mma/bMovp0xoorfLEMHFaG313O5JCCMTTlwE54cgeI1uwF44t3u9aBJOTkaSXzu8eMJ5NUshg5Ls7owXJr4W3UEnZjqzh021vIJQdMcGIWWKDw1XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742268720; c=relaxed/simple;
	bh=FAwe2RJa38ETcZQHAVHB0U88gFw89Sp4uPb6TswZqkA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=ms1YnTIS4MO8ssrFY+5gxvspVdf2C0lDBdaS0bLfNukXmPju9LW1Ew+NZYkrXdmBYtMctih5au50gaKHd6EbqeT7rhGeU6jPJskBgDtKe4DIVhicj2MQNY6UQ4NCiArqS2UOOhgJuLX4l/k299bariayiKM+sC9r//Xt054sh6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xeSiq+qy; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xeSiq+qy"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e643f233fbeso1361705276.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 20:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742268718; x=1742873518; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jHN6hEmKYf/vVKEYrUtFE+mgr5gUEvxeDu0SIFOEKqg=;
        b=xeSiq+qyZ3irjmwuxb2Vf7IYIGarJInnfgyErKNUOUvDoourmOgqxf6monn5igSne5
         /v9pOTJxGm5UGZY0EmkSbCu7btrby+TdDMmSScueI3G9SdxxUgfjcLDOLm3kuFr2vveb
         dpgaqlMSuyhJTJpPMyJj19VNFcMlz6En9wmVj+4Ea95OpEL0OOvZtY1Fi4vN4dgAxNgF
         Zi5HUHbnMhGLLygz1wp+iE1m1j8fdlTcf9D+h+jiWUmvw3J/c1aUVDXxPeltItTzL7qs
         i2iCMjdwa9+7Gv/QPiLRXV5x9Y/AuyQmiY16c6V2gjtPJ0ktlT5y69qweYxI27kz/znw
         lYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742268718; x=1742873518;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jHN6hEmKYf/vVKEYrUtFE+mgr5gUEvxeDu0SIFOEKqg=;
        b=hPh85cawl9zV4RzvxXEP3DFa1faHNZut90cjBzebvF6VhYk8FjC7AzpXk+eZNn52Fb
         iYhmT9wocSVXYsG+n8PGEoRAexn8ZkdmQHx+J9o47oT98g/qmzU1v2MT2C1blouN+RGh
         /pLi4DftoG33YUcWInYRujDKtbwFz4PtKVYvKrnkJA75K/aXsNNGxC7UsACFukqrznpV
         F3TYAUiQttkrxeDVORSlU6gGvY8A3AvnLoHHBT1WPH1RI4LceydnhHw6w4BgodcMAf1D
         TEUnsrUJoaymNnv7VwwHmsGGtJ8R815YcTqNd0LUHZnPSXKd1XN7AnxANrUiVuGo0H4N
         fijg==
X-Forwarded-Encrypted: i=1; AJvYcCU2y3heL7YC4wK2KfCjnW4LyyvrHGZCSxkUSeTncvFD1Igepc49p/kIvFGbAhFUxGD1KMOTWhuNDFL5zUZNJCcn@vger.kernel.org
X-Gm-Message-State: AOJu0YwcBIUdnbuAParOq/qCVRd3408EXg3V7F7rWBmOjtQ+MOSx9UH9
	qDvS1iSJPIICtvCGWKJQ4FrxeF6611iZi6G5WKWojCEC7Sn9q536L193rwldOKSo6Zg26EfAfy1
	6n0SHnw==
X-Google-Smtp-Source: AGHT+IEPuBvIcSfk3bbRhT/J8hpoCiqCQuC68IEKcGtvvMui3F+mkYkW6NsNtcusm463jvYm7WncQRBYK9L1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ef29:15ce:a42a:b69f])
 (user=irogers job=sendgmr) by 2002:a25:9006:0:b0:e64:3d36:bec1 with SMTP id
 3f1490d57ef6-e65118d8296mr1167276.1.1742268717723; Mon, 17 Mar 2025 20:31:57
 -0700 (PDT)
Date: Mon, 17 Mar 2025 20:31:38 -0700
In-Reply-To: <20250318033150.119174-1-irogers@google.com>
Message-Id: <20250318033150.119174-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318033150.119174-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Subject: [PATCH v6 01/13] perf dso: Move libunwind dso_data variables into ifdef
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
index 84d5aac666aa..14e4ac21a1d3 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -155,10 +155,12 @@ struct dso_data {
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
2.49.0.rc1.451.g8f38331e32-goog

