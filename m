Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941355;
	b=h2Yhe+WkXv77TjAVGueOOhagXVn2mqnbipIOqu0ssJZeOrhszabkog7WZ6iEj7BTcwuz
	 fjSOm/15IMcMJJn106z21+CELHGQdg9GLRfHZsgrgQXFOIH0odqHlMNIIO/lmzbz3MJgf
	 fv8/oxSGF5TFEKJgJHIwoqA05YeXmMskr69M2KZPg8Yu1MZBblA5p7CC1ypR/HvFi+zKt
	 nwtjKC5wLHfIPYEkVlQ7iUlJqcjOJ79zI6NjGn0uzGIMANKca9ucG9G2SeTL/TjxKJf6B
	 pdR1kludBrc1MfLaZAfNHj5yda43zQkVWS5g3fk9Et68jZAqSMN7AntGJ7BmNeJFt3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941355;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=LHtzWDYaFZz13wQ5JYCoSdb1hq02GKKhEedHTIwsK44=;
	b=0t+LO8SwVp7bJN93xSZqrlIWHtqjT29yEU/uLpVFzddxAtJaQ1sB1/myYJl4yz2gVAI4
	 UvSg0iSDqyMEetnNHivAljvQN89EglMAishgkwb/BlSJ+6CFeB82sA9eeWDbY94f0gIrx
	 xJuQywImHy/3zCH/WNPLmxcxLlufp8odCzwJj9CwaiUGms1r2coSJPBpdkcAXRN33HIMh
	 DMj3CVvo+I6OZKeYEfgepMSvotrdNtpltqGzQA/KRzITBdGWNJzABD57ExmmEzN56iz8J
	 qjhhgEc3XSsfCatXk3P+mmyr90w1jgMYNcc/uvRCTmD6T4NWWt/PAShKrrpAWjzAGRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="LnNLp/Sg";
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52618606A889
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 18:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52618606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LnNLp/Sg
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-16bc6f3fdb1so80525c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 10:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794941354; x=1795546154; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LHtzWDYaFZz13wQ5JYCoSdb1hq02GKKhEedHTIwsK44=;
        b=LnNLp/SgyUV7z2qpCx+IwK02xt4uTrMmOUk3ztOn5DYGd/ER3048M4AgIHcOe8eSQ0
         I9Yg4oxALF2W+sRXCSWpGJUJcSf6O8YF7qA7ohsmYWjaNGE6/vbxS0FiKz86XEwS2X4s
         nHjXfFNZ2HyDboazIbwE5NgQMkaB1DELMPN91GWHc5qIHFvXAZOJP9dewoiVh67iy8AY
         x6pGR8cEaKJn0mkHQ89/Qn1r4QL8O9l5MCzloE+TdK2iojHETDUBpJaNZFYLVN0dpa/a
         w8ct/XcMkX3hEZjDy2Rz4EyHIfZdA2enY+y40wUqrLsLyVBoUcSg7VboKgHttCbZx+BL
         jcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941354; x=1795546154;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LHtzWDYaFZz13wQ5JYCoSdb1hq02GKKhEedHTIwsK44=;
        b=vgMqmg6a5WtE0sfRaFCbGIda3g0gQsO5XgJLk85MT0WgsUGNj5k21SWU1DErYMl7Lx
         PYOINzq98GFNL4U1QeW0s8ip/xE1dUnybgTwdGglciPx19uyg+KzaUuJMTCP+jWBP8ht
         tHSD9yCz/LJKYK8J5oRTHUUhP70Tp0MTbm2gSMZPVqpimawPmehlts35CG68/gY1PQry
         t0c7hJIIzAriuv9QEiKpv9YKWNCvGgMpzwEuc3ijXqaXIex91Dp3OcufOH/wWbM8FCoF
         cBh3N9zaF6297A9nBZwVEDbvpVCq0SSeIxQljSC7dDkNUbKj8imbeWAoCZg+NxEfiQRQ
         RTRg==
X-Forwarded-Encrypted: i=1; AL+hErEGIiacWY9AnhS5dWrYY1DiZbBfZuvh05HoJgBNUwrLpynAMna8R9aVMI6gJnJCWLtVYP0uRKzW9UGnwqn9ISf7@vger.kernel.org
X-Gm-Message-State: APuU4Z8n9tWvdVHkElV9GAd/7vLNcK055Ku6q5MbpZg5F2gUipu0qORk
	2chDalF/moVpErMo9JIOTe+IJ4WXPn9w8vtQBMSQhxSGQMLtkCHBLjicCLj1Da8hBaHHjJPu+mZ
	XjNyrER65cg==
X-Received: from dlgw34-n1.prod.google.com ([2002:a05:701a:cca2:10b0:1b5:31ed:e280])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:424c:10b0:1b2:6eef:3f32
 with SMTP id a92af1059eb24-1b543d0c613mr389344c88.37.1794941353640; Tue, 17
 Nov 2026 10:49:13 -0800 (PST)
Date: Tue, 17 Nov 2026 10:48:26 -0800
In-Reply-To: <20261117184844.99889-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117184844.99889-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117184844.99889-6-irogers@google.com>
Subject: [PATCH v14 05/23] perf build: Enable additional Clang thread-safety flags
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Align tools/perf's Clang thread-safety flags with the kernel's
scripts/Makefile.context-analysis by adding -Wthread-safety-pointer,
-Wthread-safety-beta, and (when supported by the compiler)
-fexperimental-late-parse-attributes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 7605079544a9..3e391f6918a4 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -64,7 +64,13 @@ ifeq ($(CC_NO_CLANG), 0)
   endif
 
   # Enabled Wthread-safety analysis for clang builds.
-  CFLAGS += -Wthread-safety -DWARN_CONTEXT_ANALYSIS
+  CFLAGS += -DWARN_CONTEXT_ANALYSIS -Wthread-safety
+  ifeq ($(shell $(CC) -Werror -Wthread-safety-pointer -Wthread-safety-beta -c -x c /dev/null -o /dev/null >/dev/null 2>&1 && echo 1), 1)
+    CFLAGS += -Wthread-safety-pointer -Wthread-safety-beta
+  endif
+  ifeq ($(shell $(CC) -Werror -fexperimental-late-parse-attributes -c -x c /dev/null -o /dev/null >/dev/null 2>&1 && echo 1), 1)
+    CFLAGS += -fexperimental-late-parse-attributes
+  endif
 endif
 
 include $(srctree)/tools/scripts/Makefile.arch
-- 
2.56.1.703.gf848ed807c-goog

