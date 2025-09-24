Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BE730214B
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 12:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758715265; cv=none; b=E25AgZ58YHxwlmJXQqjQTmuB6GcoOvI2FdyYL2sK9udC06cndQtTZ/vZde2Gi6oeum/wKmvdDg7C8qx2LtXQv2CinyN+uoVp2NYWgX7DY6fEFGEjT8Mqy0QQhqs4nHLVPQnf/BN9P5YGgxQMTzuDdIyPqFTDu9hUus4mXtTqU24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758715265; c=relaxed/simple;
	bh=1x1tZkclSlUAFkeAbCTbg9ur9vKYhrQAjAn0c+iWPHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QPWHJeT8mefyT1JIXrBY1Jzx3E6+iuw4ThoH0Xan2dIzvWAOYk3WaYfqUw6pasgsdj0nDfgwq/dvgn+5wiqARuSZ9Had8Co5EGVxm5wK8FzuOcSxb/EhQoj1x+ljqYck3IfUMg4GmZxeiNts/3XJ1H7+Vpbsc9hn2koRmeZyKss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAZMVh/2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAZMVh/2"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2570bf6058aso90468275ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 05:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758715262; x=1759320062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dXdR7Vr7GvNxroOAYy+aBhMqtIGh2YpUvjEzBf0MIg=;
        b=HAZMVh/2JYtZudMoe4XXzvbN8cfJTp+1ewB3T/14JMdxAMmQUdV1sAPK4EhX5456pA
         IJbDNXECjuz/otNjpvs39d1j3CcW3fWdwS76EkMnVuFa2VpJvSTbr/RsqnyuQxdSTxtj
         dhy4qdtGkSJXzSTsgKrItD4dIzVmPmhcmXlHLcmQJwdad08oBW/pwZb9cj4ySnrJrQ3Y
         EGyi0PL6oDC9i++W3JJ8HBzXDll0vzf0iyZuzMzN7QHw69E9EpzSm0FAmi2tpOvhGgCH
         hBR4czKYJO+nVjr22x9NKy445yHJFosrRrF/jYzNWRXvyaL560zJFYv0dKiKUTMyUV3I
         umvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758715262; x=1759320062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6dXdR7Vr7GvNxroOAYy+aBhMqtIGh2YpUvjEzBf0MIg=;
        b=A2KcwdP7dkrxXO/QLoOdW7r7QkyiaexcdjVTQRsVrRJzb2IpL/KkK3ztaNAxDHN9tS
         u7k9mysySjrJk8f+lG1L3vNrj30zOtawTd4gtT5gDPqzAenkUmAgdkZDs+zGcoL9gf81
         4ZU9ZhnURBPzsbQDhpqNQKTa/fq2sA06O699NajUTYEKX6NRVPsr/Vv8r2vCM3kew0mb
         2f5LhNwOOc3BUJ2Xl48mrnnuiEperAv4bHgkyM2LCdnQaSGo91eZ0/2xyOMB3K68DhV4
         VCW2Mt5G/P5bBsqoWJ7MjgqxvQvwTNHuENQQnqF8LlTPGByyhgYqwhmCzGgeaPMm7KME
         uLcw==
X-Forwarded-Encrypted: i=1; AJvYcCX+/WPCk0rrEs+aFeUDTP/eX6pZe7GgOvleH/Y5DTo1j4R9dI+e7qgzderAcOtY5FYgE8wyBhOYiZCR1oBI59++@vger.kernel.org
X-Gm-Message-State: AOJu0YyVDmZEMCnvUiu5NOqAEXVDHCdbfT6fbfWuT7Z8SD05tUX6u1V/
	IS/iQHbBD/MmYeIJ+T1UlXzoVL6pJCgPjYWXwhEdJOleYxDxWcCHSdw/
X-Gm-Gg: ASbGncsq+qniRy2gBPJhuVS5A/3kavwnJt2XgkPRuEhiY1hIF9x6977pgvMgwYNlQsb
	DkDIzzStAPafshdlac918GtDW5zMoHHVD2JOdpSuZ0mmG6bDPJkBnoGlDFfb7+u5qNYoWEbWm9Y
	jxEsAy8RQr4eWrHe48QNxeZUnBp/+sRxC0Vv6wnIsbM0vQ/VcBFugdDKqTyamQwUo/jDrwn5nQT
	d80FBVlmKzAxBfquPSa6d+e24r94MEuUj9cyNKApSPjr/4pfr+2PfCn9Fgs2mcQslmaDadmVwka
	vpTS3fy/hw8yNThueCauq/T+T2YPoFBUREc0puPa67vHYoIESuLHZ/LDyfJfn0pg2kcynXOVjze
	WjNCSNVowDtd8vmLKGMIsq7c=
X-Google-Smtp-Source: AGHT+IGVP919XNHolLvfLc++BjiI5XDU3e+i/BPRLdij8Ir9EMWggkhD6kjR2mYU+aqH5NAU4i53wQ==
X-Received: by 2002:a17:903:2450:b0:268:f83a:835a with SMTP id d9443c01a7336-27cc9a91248mr60333305ad.60.1758715261649;
        Wed, 24 Sep 2025 05:01:01 -0700 (PDT)
Received: from localhost ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053d25sm191276975ad.12.2025.09.24.05.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 05:01:01 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <kees@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Rong Xu <xur@google.com>,
	Naveen N Rao <naveen@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Nam Cao <namcao@linutronix.de>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com,
	"David S. Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v5 23/23] MAINTAINERS: add entry for KStackWatch
Date: Wed, 24 Sep 2025 19:59:29 +0800
Message-ID: <20250924115931.197077-8-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924115931.197077-1-wangjinchao600@gmail.com>
References: <20250924115124.194940-1-wangjinchao600@gmail.com>
 <20250924115931.197077-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a maintainer entry for Kernel Stack Watch.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 520fb4e379a3..3d4811ff3631 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13362,6 +13362,14 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
 F:	Documentation/dev-tools/kselftest*
 F:	tools/testing/selftests/
 
+KERNEL STACK WATCH
+M:	Jinchao Wang <wangjinchao600@gmail.com>
+S:	Maintained
+F:	Documentation/dev-tools/kstackwatch.rst
+F:	include/linux/kstackwatch_types.h
+F:	mm/kstackwatch/
+F:	tools/kstackwatch/
+
 KERNEL SMB3 SERVER (KSMBD)
 M:	Namjae Jeon <linkinjeon@kernel.org>
 M:	Namjae Jeon <linkinjeon@samba.org>
-- 
2.43.0

