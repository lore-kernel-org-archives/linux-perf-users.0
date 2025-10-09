Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BD32EC082
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Oct 2025 10:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760007522; cv=none; b=i8QermPwdAZgaV+RFZoSAMJjJc+uvcn5SHG6Tkt0UztiTdgeZZE+mVnl7D4WLXEUEoM5UEVk1OQ4wCvCH/gDsWxOG16xK6ba2mHgyjBNzexknRQIu0ljhFBe3u7E4pULxF5X3a9KpDTpJN6iKXy7YZF234QwSsepgNfSIM02jUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760007522; c=relaxed/simple;
	bh=JE2O3gXCPzxmYnUAKlXgnSjWi6sqfl5NW64CDq3b/SU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TW+z2y/OPSnUaFhC1ldByOoQZ8En7meJMpAOIPXaiiUo2KeiYIAsHSwstK3KNA+D8SKupsURYEdiZxuOXS2E+LNnLtslqqyyLegUB4YfUWriYELy9GG7XoA50QUNBZ6kyXHBuyQHcLkPq4KBLYbIrUf2pSa392go3du1onKRD04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neiksZ1z; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neiksZ1z"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77f5d497692so1022259b3a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Oct 2025 03:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760007520; x=1760612320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ApAR8xSadwKhwismNq+uPz91ksCPHZtzxjh6qDdbHI=;
        b=neiksZ1zocphckHCNdcqvCB0SEeovXjopGI6pfpT024hB9TvNjLbNBW2fKJWGPduwr
         GiSupT6G/yLKjBEtqqAeENNbRPdgnNYMqthN122C5+pJxCOkOQWV61nbV4w1No4FRyYT
         9g7DxBp3MRACp4vLb8XCW/2HHHgm5bx23ER9ozH7ZIeGtwfRIqwfncfD6BJPQ5NyKi1E
         Dzh9XGRvbkafQcDpkHjTfZE9vZOulFBQ/n2M24QNnDblwnATtnrubC6H9rY+1HNqoS+l
         PoUlGHQwpEkwR/1UpJLxl8LX14t+gP/LvsFdcPZctWanuRItuk1buoqPc1yuKN9qKZtL
         6DAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760007520; x=1760612320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ApAR8xSadwKhwismNq+uPz91ksCPHZtzxjh6qDdbHI=;
        b=rIReT888DvhdFp27gp1m8c7td55ieZ+VJs589BOjACBhUq+s/dAzoq0e5Bqr82B2TL
         ESfX2UKfA4X/5JMGH+8VbFnBlTKZAMog/l6UHgCMlOaV7yjQxOw+WxMImma2bkK+68uj
         uJCYNI8oRNx7aDmw4qDcHHyAbxFoNPXxTTKxEvMldXEpdaQY8gNW3JtB2E59juBDqmvG
         PBU1FiJPoQxelZV5/AB0Xw+dsPY1Wmx+CcEqgA9eVBiXwbPokQsYNmS6+AgXnPpdF9L1
         8jcne20mVBJIxtXk4opcjYrYwnsiW4gfuSEnUL/4i28S1pdhM39lwsY/4hzTQCve0WXL
         uhsA==
X-Forwarded-Encrypted: i=1; AJvYcCVvG8Q5IrhT0VReBgvgozlZzUT/VyDeHytGUk3axzHI7/CITNn7+xnsuqDie1hz3lYncIeDGVNyN18yponxbO1q@vger.kernel.org
X-Gm-Message-State: AOJu0YziKBjk4kqw3xL41vapO4vM/tOYqcCBH35avZsyeZeTnkLPe3Rs
	jy1iCT8GWp6u925tz3140kTQX3z+hk1y99Tm32S9uxPXZ0S3xXOGwLeS
X-Gm-Gg: ASbGncuB75b+DBcW1Au7koFsxclu/tBODamdyRFQDjizHoBbjunKaPnPA4nlsX3G/vY
	ZwyxT8l5jNDxBPugkaWBrPxoqND/LWdUexadxQFIGL0xj0OXUJ/b1aNgdcTvJV4AqxD/XAxrwch
	37y5oe7y+r7fx1AD2ChLlENUkN45uZ+1H4v2Xv/nep9tpXSnAgEy85FzmKVlf9N8lXL2KqAcxJ9
	zj3tzqsD6GrHBtqpnsp2UasHib3/g8FTx5GVidGJP+rIS5YovUl1WchsG0GO9+RAB4GBQxrHGnE
	2vTTa29NUkAqttY85C9Y+DuGi71QG3K/LAWyKvzsQYOFVKU4A2eB73gQhOMdaCZvbthdUSMfGyB
	/2vaqgDwBKwpXXnx+fPHpLeaYenHArK2c2Z7RrnItbe3vmRhEDJdWpsCW94jZ+Txb98KUjhk=
X-Google-Smtp-Source: AGHT+IFNGlIpEHO7TMNSv14SEeeL37qmV4fa31y9HfqA5Z8RmIIJBkgU1nSNu4enoYA+m8tb63ySAw==
X-Received: by 2002:a05:6a21:6d99:b0:262:1ae0:1994 with SMTP id adf61e73a8af0-32da845e6c6mr9710336637.42.1760007519707;
        Thu, 09 Oct 2025 03:58:39 -0700 (PDT)
Received: from localhost ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099d4d324sm21591393a12.27.2025.10.09.03.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 03:58:39 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Marco Elver <elver@google.com>,
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
Subject: [PATCH v7 23/23] MAINTAINERS: add entry for KStackWatch
Date: Thu,  9 Oct 2025 18:55:59 +0800
Message-ID: <20251009105650.168917-24-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009105650.168917-1-wangjinchao600@gmail.com>
References: <20251009105650.168917-1-wangjinchao600@gmail.com>
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
index 3a27901781c2..d5e3b984e709 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13596,6 +13596,14 @@ F:	Documentation/filesystems/smb/ksmbd.rst
 F:	fs/smb/common/
 F:	fs/smb/server/
 
+KERNEL STACK WATCH
+M:	Jinchao Wang <wangjinchao600@gmail.com>
+S:	Maintained
+F:	Documentation/dev-tools/kstackwatch.rst
+F:	include/linux/kstackwatch_types.h
+F:	mm/kstackwatch/
+F:	tools/kstackwatch/
+
 KERNEL UNIT TESTING FRAMEWORK (KUnit)
 M:	Brendan Higgins <brendan.higgins@linux.dev>
 M:	David Gow <davidgow@google.com>
-- 
2.43.0

