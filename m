Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="VVwDBW55"
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8768132
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Dec 2023 08:35:14 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d1e1edb10bso9540865ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Dec 2023 08:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1701966914; x=1702571714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWj1IWQKQUAn53hJd+8gzkbOyC7Uc3/+Xnz5vVEOJAM=;
        b=VVwDBW55m0+CDPNtEo5vhp4IUC/kBBuTg9UYkGBv86g2h2uAjCqobJRyhnpOQVvSbG
         qATy2zfqJ6o4+Kkj5+W9rp2Rdv2C7Hsx86tKWmsJTlH3we8umq9P5y+/kqoQn8xTMFSS
         3TSpknLzz1YrQRWyRl7xdHsCusaNWCrP+5IfhGReajs7G54gnc+u+TaBrmUz0vlTH08O
         iUec9Ff9BoKUu3RpIG1XVYA7Fns4e0RAKZB9lk2TWN1yOssf/JchcpWxGguZj1Vo+9Xl
         l1bYLVMtDf5CSkPUtmEsqBWmkLfP47Q6G8AEaXrhQJieSN0+JyOiNTYU5JmQs8r9nBwQ
         ffpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701966914; x=1702571714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWj1IWQKQUAn53hJd+8gzkbOyC7Uc3/+Xnz5vVEOJAM=;
        b=WqVrMn1f+RXfISs+h5Qm+fhhusgqICqIQfCdFHFTqup0t6v3TUD3V+X0+8NYkm5FTD
         sV/x01AzZyrpMjZRCwUlImgbbZJIJtX38dCfZRqYxUabds132IOabtdS5i7cs/y2LGje
         S1aoI7zvzM3JZUFMAaAP0S6jpL+Uis48ty+7YCBUIdAA3enq1SO+ogZ6SCvphA2BY736
         uOV+i1t+ZoqVewGG7M94IDprhep0/GPVY81+U2hi6ZrjOvbLBzGTls7jY1H19MyHfNlr
         W9fPENi9NwAQeIChsRdgQACgqTTVVfwyP3Y15pQLzqpTfXf6hLhrW89mma2476nKZFIJ
         7+9w==
X-Gm-Message-State: AOJu0YznSVr6fF8FlLtW5C9lUVQ3JnmYcgLhrnMbIyEFRlWlIkKYGPQf
	kjbgqudz7LHzD65QTyw2pJMwxQ==
X-Google-Smtp-Source: AGHT+IH0TFiITQTxzBEHpxgF8GFh3P2TkSCdMsEPDdMQqCIAwlhGDm2o/wCZc9VUC6HmQ/5p2aYgcw==
X-Received: by 2002:a17:902:b48d:b0:1d0:6ffd:e2ef with SMTP id y13-20020a170902b48d00b001d06ffde2efmr2666645plr.137.1701966914046;
        Thu, 07 Dec 2023 08:35:14 -0800 (PST)
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id iw15-20020a170903044f00b001d1cd7e4acfsm6143plb.201.2023.12.07.08.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 08:35:13 -0800 (PST)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	linux-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Marco Elver <elver@google.com>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Robert O'Callahan <robert@ocallahan.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 2/3] perf/bpf: Allow a bpf program to suppress all sample side effects.
Date: Thu,  7 Dec 2023 08:34:57 -0800
Message-Id: <20231207163458.5554-3-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207163458.5554-1-khuey@kylehuey.com>
References: <20231207163458.5554-1-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Returning zero from a bpf program attached to a perf event already
suppresses any data output. By clearing pending_kill, returning zero from a
bpf program will effectively pretend the sample never happened for all
userspace purposes.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
---
 kernel/events/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 19fddfc27a4a..6cda05a4969d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10421,8 +10421,10 @@ static void bpf_overflow_handler(struct perf_event *event,
 	rcu_read_unlock();
 out:
 	__this_cpu_dec(bpf_prog_active);
-	if (!ret)
+	if (!ret) {
+		event->pending_kill = 0;
 		return;
+	}
 
 	event->orig_overflow_handler(event, data, regs);
 }
-- 
2.34.1

