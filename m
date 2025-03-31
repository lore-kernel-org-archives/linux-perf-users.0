Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69682135DE;
	Mon, 31 Mar 2025 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743440223; cv=none; b=aqd8U0AS6k0BNSOVaKJMS9+uSgGQWgqxcQqGFixzhHXpNpyl8caUTOXiqEH4JlALZw681ujqDavXYgJjkOh8OGJWKwUYqveSU5e06sdy+MiT3zmlxM8P2Rt25KpWdNrHw+fSZm6ShvDVRsow3VyTG1wxlPOuzGmJ9iXxq3rkM9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743440223; c=relaxed/simple;
	bh=KXzfr50z8suH/Zn+DK4mQrLrvFQqWPegMJXUym/r4y0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gqv0q32Vfzc2C7xCc5j8ngUO79JpWnOEZBShbrc9s5PORxWkXDebHfHjB1LZtp9FWuffrMMjWzrwEuXjVRdyj076tKuhx5RgggY8XsyMfQoJ/dAcQNXkYve4ughkFP2Wxo8lk/ivZa614lVWN5VYQLEWsOMt3OVH/dOhKI5am9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buAbKnPe; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buAbKnPe"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2254e0b4b79so120380065ad.2;
        Mon, 31 Mar 2025 09:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743440221; x=1744045021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gRlw5rYFCnNVSj1ZUd6YWmxU/HMSu1RH7ZjmPPT8mtI=;
        b=buAbKnPeRc+sORhgUDzOGkqoGMUqzRKZjc/PWCMp81ri+BOBrqOyz1lyge1thejrsV
         E6UmgWb0km7Vav3aQSPj3PECni+yqJqJclB6CzNv3WBZBbgfQgtipMAeYl+ygNEdHiGC
         OtEyLVVsUH+XMYFHug5DEMuvPAV9Uvl4xAb0SDOaIxVjN0ZHwhkcNd/MsL3uvZc5tZ/q
         bl+P1btlrTN/90l24LS7/aTzWRhcsZLfL2Sg+M+55HOCsJ4zHkmGZlOQdNsL4HA5nqmR
         U18DC+5DUxBmNXaTCnIq4fNurgkiNxohl58YnYeVABKXaWjFSsGXnaOnzVNLsHea1TSK
         2csQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743440221; x=1744045021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gRlw5rYFCnNVSj1ZUd6YWmxU/HMSu1RH7ZjmPPT8mtI=;
        b=j9UEd0/9fGLJHVMWiHlrdJGhWD7qGRLr3aKHgywxH8BcarcoTG9uRoLxvpup33XbkT
         52GlSMIJhAG5irXESp7DLUqgd0lwgYplTxgSbmITaTwBQaRH6qfMQam4uv3r4DJmr3S3
         4HtpLuQpQV6BsKOH9WX/8I+wVi/fFp+X5+J2+pdalUansHoBACCaMOcDVEYxLDaq2BOU
         X9EdrYX9ZunEqerUVkJVbeHjxYmCmXRmbdLTaKFSU+0xcVa4SMiUNJ8Sc6hOEaaxBmIo
         PKQajAmKM3L8GNbIVKCl9xE3gClhowjNDUuR3xu4DeTcmoUGzf1mCKX/51TYmiknf3eR
         x+fg==
X-Forwarded-Encrypted: i=1; AJvYcCWTx+SU0SCcPxfmr7+fImwnMfny2HlnmzI+eb7//QgHOPTQdR0ShoKxDgBkWUfdRzXxecUWWO4zULgHuxk=@vger.kernel.org, AJvYcCXNhNv9VLiH8+HUjcOkVInKUr802RVttSatW5vRCIAxlOdyYM2ReWvUEokgPlaxvoZB/1evhcPdvezi8gRf5qL1yQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm3CsH44937BjAOIm3WqFhk6rMV++vXrSHpH/o4SPF1vmhC9hV
	cGNpXCagcgk7wWHzqq2mLaZYxXkbtTFJfURnDpykjKrFUGsD55rG
X-Gm-Gg: ASbGncvzNDiFEWs0xvSS+LXwCqeRsbBkevUoRDrC+Xh66KUeEgwPvK3q2c6e3bbdKiI
	DdQKb7T9l6p1aB834ekJ9mKKzz12wTvfDFxd4AMQkbQec0rS5CiS4DprHgDU5qtIkncHReKVIEb
	n1iLwcFIieQCI8D63pdsxmrMx1HdiTUI/c3J6sTIUvv14UN2KPKKdCA/YPnb1XQVbqFpnbUfqGz
	U2+Yy/C2YXML6l/phqc8Asf2g7M73UvniR48QsZq1kmRoGWvtWxdAUWJHN9pDWQBbGc/bt9ecMe
	/6bN0lUhVY6gbEBdLqATbflN0Rq0cfNtEaJYuvUvFpqESvVfsTpWkIoIYgFnrOZjrFxuffr8lFo
	pewnLFrCtTV1lqE0=
X-Google-Smtp-Source: AGHT+IE8OCRlIaQnjODeJL17gbi8prQ1mqRT+j0dJHleO8pau6UyhjbDiw7gnlGIGUUCFF/gb7NCgg==
X-Received: by 2002:a05:6a00:1309:b0:737:678d:fb66 with SMTP id d2e1a72fcca58-7398033f18dmr12362785b3a.5.1743440220955;
        Mon, 31 Mar 2025 09:57:00 -0700 (PDT)
Received: from howard.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970e22496sm7436011b3a.50.2025.03.31.09.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 09:57:00 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v5] perf trace: Fix possible insufficient allocation of argument formats
Date: Mon, 31 Mar 2025 09:56:58 -0700
Message-ID: <20250331165658.2566079-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In my previous fix of runtime error [1], I made a mistake of
decrementing one unconditionally, regardless of whether an extra
'syscall_nr' or 'nr' field was present in libtraceevent's tp_format.
This may cause perf trace to allocate one fewer arg_fmt entry than
needed for the accurate representation of syscall arguments.

This patch corrects the mistake by checking the presence of'syscall_nr' or
'nr', and adjusting the length of arg_fmt[] accordingly.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
Suggested-by: Namhyung Kim <namhyung@kernel.org>
Fixes: c7b87ce0dd10 ("perf trace: Fix runtime error of index out of bounds")
[1]: https://lore.kernel.org/linux-perf-users/20250122025519.361873-1-howardchu95@gmail.com/
---
Changes in v5:
- Move the link to the bottom, and keep the triple dash (suggested by Namhyung)

Changes in v4:
- Make the patch apply

Changes in v3:
- Add 'Fixes:' tag

Changes in v2:
- Simplify the code (written by Namhyung)

 tools/perf/builtin-trace.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a102748bd0c9..439e152186da 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2022,9 +2022,6 @@ static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
 {
 	int idx;
 
-	if (nr_args == RAW_SYSCALL_ARGS_NUM && sc->fmt && sc->fmt->nr_args != 0)
-		nr_args = sc->fmt->nr_args;
-
 	sc->arg_fmt = calloc(nr_args, sizeof(*sc->arg_fmt));
 	if (sc->arg_fmt == NULL)
 		return -1;
@@ -2034,7 +2031,6 @@ static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
 			sc->arg_fmt[idx] = sc->fmt->arg[idx];
 	}
 
-	sc->nr_args = nr_args;
 	return 0;
 }
 
@@ -2176,14 +2172,9 @@ static int syscall__read_info(struct syscall *sc, struct trace *trace)
 		return err;
 	}
 
-	/*
-	 * The tracepoint format contains __syscall_nr field, so it's one more
-	 * than the actual number of syscall arguments.
-	 */
-	if (syscall__alloc_arg_fmts(sc, sc->tp_format->format.nr_fields - 1))
-		return -ENOMEM;
-
 	sc->args = sc->tp_format->format.fields;
+	sc->nr_args = sc->tp_format->format.nr_fields;
+
 	/*
 	 * We need to check and discard the first variable '__syscall_nr'
 	 * or 'nr' that mean the syscall number. It is needless here.
@@ -2194,6 +2185,9 @@ static int syscall__read_info(struct syscall *sc, struct trace *trace)
 		--sc->nr_args;
 	}
 
+	if (syscall__alloc_arg_fmts(sc, sc->nr_args))
+		return -ENOMEM;
+
 	sc->is_exit = !strcmp(name, "exit_group") || !strcmp(name, "exit");
 	sc->is_open = !strcmp(name, "open") || !strcmp(name, "openat");
 
-- 
2.45.2

