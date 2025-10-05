Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2762BDC0F
	for <linux-perf-users@vger.kernel.org>; Sun,  5 Oct 2025 21:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759699345; cv=none; b=qvuYINoeo81Ba73Ve7dQpJl9JM89HrAqr2qGUza8SQJn44Fzijp6wKt2YAWM5ynvhk0CxCtbnw1vc3gcD3X7R5MdJIAArS/pC3VCFW3pFDbuwmdQsdK0UuXhGv8Xemfq3wGVVxKGDGQnt6l4f3uOwQv+zB8wJw516Sx4uYNvkb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759699345; c=relaxed/simple;
	bh=/luZGaDcmbSsI2ELFDFE/EBkhdco1hXagnVGpUVsYwI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=jf7Pt3QBuwWTGK0wy6aHAkXoP33HTJHwkD5/cXgoeWxcUh2hFm+cSkb2HH9LvBXeszbeTnmTF2VeIJdNjxlakEVdTGmmuJOUXHPtpQN8TKhPtmbQ22QvpJV72HBnz9xPg6mBtigdM01E4IYXijMVB9luf6BSqTb1DXBr4s5tx0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IXg33RJl; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IXg33RJl"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so63409a12.3
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Oct 2025 14:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759699342; x=1760304142; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hHVoU7VdAErJHQsuyUDkFaSuPa656SpDfPesPL1Iw7A=;
        b=IXg33RJlj48b2bkYOpkR0XWqYzep0REFMiUaUYvH9UfvnRQy6a2KIrV1R+tsyO60Yg
         FNKDIFwQpUv7L8CX/e1Oh0HtAeezREx6kOil8bB00vd0unfWmxZ/NOEMxAwTJpUJsNRw
         1SnBASv9l7OlI8NKalSqK5KNYGx7KECqY5/HQ9S2OT7zoj2dB9Yt9hNGHRa77+aks4nz
         WnCmxb6h74FjAFyQVA/Xe4gqrQM9HOmEkFRDGo0nw3jn87wezKvI2qNwT7gYspywh3N/
         /jyWAwZ/weLeDXTasBTTMBCRt5i5tM2PAVe3m95imxNvC4hVxlvQIzDky8LmWSY3ojBq
         uwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759699343; x=1760304143;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hHVoU7VdAErJHQsuyUDkFaSuPa656SpDfPesPL1Iw7A=;
        b=XJf1WMrUjgzXgWznjJ0F/S+wjqRjvnYz9Pt7rpm4KbLeODcWtD8IHmP1vo8fyWk6hG
         fUA0j8bsrejRw/rtS9l3Z/J+nlBvwI3z85USWJDT4oA+siNTwJUoY3d7q4dcuFSY+2ug
         L1eYMHp2ZbPoitG7rd1NBSKB7NzxidsEITPf3BbfW7y7xcXTVK5t4w/wFssoNKIUKSTr
         i2EIBcY4w0Qx6n9I5g3eRxN+Hk5SYlYhCut41GMHo/NE/Be80QpUxepcap5BFq/Hxsgi
         eFLrEDYyZLp24k3uHWbLmmqesJgVlPQus8KsSmZQ47RKtDoesq18At0PczsFmpDDzdjl
         chhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC4ZzXIjp72jh4DZYaO8eZ+hz+0WYbpXbKNgxZj8vce6+cZj0Y/aN6T/4oKcg30ox8LQYDu12fhHYPPhFA/8l8@vger.kernel.org
X-Gm-Message-State: AOJu0Yym0OUkyBbbbpGwbggdKrWT1caimDa/p8dfyWJzBggWKWuBIfGI
	lDBOhVLHyyYGwvLxWho7eZjsJz755QRqAqQTT7921UtGjSaWgDBVZGQvlYdT3c/QmEu4sBBkn8d
	JTt+62fvDYQ==
X-Google-Smtp-Source: AGHT+IF9xACFD4NCBC8YA4+1DxHgAs4tVBez0mS1xBu199M+awLsaSCkEQ1/ioP2OUdMojXU72RjQE/JWxIn
X-Received: from pjbpf16.prod.google.com ([2002:a17:90b:1d90:b0:330:6c04:207])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e211:b0:240:1a3a:d7bc
 with SMTP id adf61e73a8af0-32b61dff87emr14700817637.3.1759699342575; Sun, 05
 Oct 2025 14:22:22 -0700 (PDT)
Date: Sun,  5 Oct 2025 14:22:02 -0700
In-Reply-To: <20251005212212.2892175-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005212212.2892175-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005212212.2892175-2-irogers@google.com>
Subject: [PATCH v7 01/11] perf check: Add libLLVM feature
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Collin Funk <collin.funk1@gmail.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Li Huafei <lihuafei1@huawei.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Advertise when perf is built with the HAVE_LIBLLVM_SUPPORT option.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-check.txt | 1 +
 tools/perf/builtin-check.c              | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documentation/perf-check.txt
index ee92042082f7..4c9ccda6ce91 100644
--- a/tools/perf/Documentation/perf-check.txt
+++ b/tools/perf/Documentation/perf-check.txt
@@ -56,6 +56,7 @@ feature::
                 libcapstone             /  HAVE_LIBCAPSTONE_SUPPORT
                 libdw-dwarf-unwind      /  HAVE_LIBDW_SUPPORT
                 libelf                  /  HAVE_LIBELF_SUPPORT
+                libLLVM                 /  HAVE_LIBLLVM_SUPPORT
                 libnuma                 /  HAVE_LIBNUMA_SUPPORT
                 libopencsd              /  HAVE_CSTRACE_SUPPORT
                 libperl                 /  HAVE_LIBPERL_SUPPORT
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 8c0668911fb1..9ce2e71999df 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -48,6 +48,7 @@ struct feature_status supported_features[] = {
 	FEATURE_STATUS("libcapstone", HAVE_LIBCAPSTONE_SUPPORT),
 	FEATURE_STATUS("libdw-dwarf-unwind", HAVE_LIBDW_SUPPORT),
 	FEATURE_STATUS("libelf", HAVE_LIBELF_SUPPORT),
+	FEATURE_STATUS("libLLVM", HAVE_LIBLLVM_SUPPORT),
 	FEATURE_STATUS("libnuma", HAVE_LIBNUMA_SUPPORT),
 	FEATURE_STATUS("libopencsd", HAVE_CSTRACE_SUPPORT),
 	FEATURE_STATUS_TIP("libperl", HAVE_LIBPERL_SUPPORT, "Deprecated, use LIBPERL=1 and install perl-ExtUtils-Embed/libperl-dev to build with it"),
-- 
2.51.0.618.g983fd99d29-goog

