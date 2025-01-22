Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F351249F9;
	Wed, 22 Jan 2025 02:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737514525; cv=none; b=iQ0amyzE02PlNl8rq8TNLB9c+++v349cdvGt0oIWoxbMIXdvHgyqAnUwzdjiWPaXqm0897HTb4/SCFaYpbXg3u8O6802bqswbzE1JCILjuTKJoudGYNqgdlOF6MH3GoNdcxm//rM46f4LuuK6zz3cGn9WyMFtEGxW91hNTxboiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737514525; c=relaxed/simple;
	bh=owsREPu73reOdOGqFXBmOYWByOrrb3fA/ohV8js5ZYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SAASCwdyT1P5aSMJRq5ewdQDQKqswIrZ1/WdYzA9WV6d4W+QHmhU4Cot6AnnqOhFYCFFzCDbTHkrqxvMIM1hxwzTT1qCF+OFcVcKpJfK+AyeqpDF7zrvMA2tFvEraziaCIa85uQLqHAWdul0iaE+gmlaKNa03wc5gh+QOOjO5NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P11IKxdM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P11IKxdM"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-216281bc30fso146562395ad.0;
        Tue, 21 Jan 2025 18:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737514523; x=1738119323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RWGE/MqVRclJs2RoOlJ1F8C5SI97efwbC4+6/PUtfwc=;
        b=P11IKxdMJeV2kdZH1kTMGhB81CXK5s5MgaYkI1+Xk2hH7WbJha1FL7Na4e4mOPByrg
         5weEgeRavLLzdi/VMnysSYvdDbPKGkSz51RI/em8GawpgAqrA3kQ355YEhQYo6DuvNcU
         qF7R8mUgLWfimXsgGxAGhtloma99HEUlUYsKSbXunQsyKwEcAAtvayZohcQmj9D0zb8Y
         /9jlua8/NZoHEmHKtzU6uapH3saMiU1h2gaQRBdbU6oEerRL3K8/VVqcfrKICtPBOxzR
         5aA8Wu+nh9K/HcM1r4QlYM24wo3hZzTNoXVNZKzpJTu360V86pmoQXAR4353fzROkIkf
         zGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737514523; x=1738119323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RWGE/MqVRclJs2RoOlJ1F8C5SI97efwbC4+6/PUtfwc=;
        b=lKmR63I85XX1Wx6UPC8lq+KJdmOMJ9T1aieR8kEAi8sw/f4+r23181Db6eragNwgWs
         q602HPHFWoiQrGi3P9YHnADOqa3hXaC4b2BQgWJLrCmXjXEuOKSIvbR4az9MA/5xC7BV
         E/iqoAZT6cxcz2by9QSXSKY6mQZJ095jjMhT2OOnDIJISpQ8/zezXtqYoTsw3j7B79B9
         HNRr4EobAYjA2O4Kcv83U4hpALretyXL+QMAdiHyj9ctyGGE1w0mqk7qeBn/gt+mdzH4
         VD/B2o2M75vVJEfdWf5DFdF6nlb/TGCUgSTkgivsJb2ly5OzewCeicP+h+u/OVE/30ml
         QNGw==
X-Forwarded-Encrypted: i=1; AJvYcCWCRBaxCqgBUIoMlgA749VCH7FPyelHMSn5ZuWBqJa0N1YHxWTazV0ST5Ghi/ANq7hqOz0J8JptizfEZeK3aU5ykw==@vger.kernel.org, AJvYcCWlsKEtLmBu3VbWOoZb0awHPPqWaQwtgd7+yu3etiYedeq/zCkUfhXoOVqebjH6LMG4n3gpOCna1JqXYec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMvlreD1tlWtKWgT0wct6wHWxYPI5k1kU783NZQfzUMFS7hDZ6
	kDmJhS2Z64I+e+EoAjGm4s31mirH4dGuDPGpWCNvF8gdKI5P0D46
X-Gm-Gg: ASbGnctn2Uw+DL/hBb+fafg8vUSysPFltI9JFEGQx4dwOam9pLLoICg07nylnrTxqES
	Ykx9SZX/H33eb84u+4BNMLOb4qLlW7c7gzv6XxOJOVk37OKfjFEUkNgrz1TpUpCp88YBRCOZtUP
	2mRfHAnK+jjhWK4cN3PdAc7Xr0ftY5rENUdfS80D/wdCiPqsMindYbH4AH5a96iRzuPkaANjfzB
	eZCxQKKVXV3GDezBM2C6QgCpbm2I5lYjVlER8tog5P3wYQlRi9l4goOajUOKvUmYnmuHulC6+0/
	EwIkb+kcz7+EK0xteMs/oiXrMA==
X-Google-Smtp-Source: AGHT+IE4we7e1x4y1dhztqc0aOIMQ3eqPIwZwNaMqsEuasPMYm1B5aLGa3dAEplUxQc2OQRm9Quo3Q==
X-Received: by 2002:a17:902:f78f:b0:216:7cde:523 with SMTP id d9443c01a7336-21c35630682mr284911755ad.32.1737514522620;
        Tue, 21 Jan 2025 18:55:22 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ceb9b9csm84621145ad.94.2025.01.21.18.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 18:55:22 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v1] perf trace: Fix runtime error of index out of bounds
Date: Tue, 21 Jan 2025 18:55:19 -0800
Message-ID: <20250122025519.361873-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

libtraceevent parses and returns an array of argument fields, sometimes
larger than RAW_SYSCALL_ARGS_NUM (6) because it includes "__syscall_nr",
idx will traverse to index 6 (7th element) whereas sc->fmt->arg holds 6
elements max, creating an out-of-bounds access. This runtime error is
found by UBsan. The error message:

perf $ sudo UBSAN_OPTIONS=print_stacktrace=1 ./perf trace -a --max-events=1
builtin-trace.c:1966:35: runtime error: index 6 out of bounds for type 'syscall_arg_fmt [6]'
    #0 0x5c04956be5fe in syscall__alloc_arg_fmts /home/howard/hw/linux-perf/tools/perf/builtin-trace.c:1966
    #1 0x5c04956c0510 in trace__read_syscall_info /home/howard/hw/linux-perf/tools/perf/builtin-trace.c:2110
    #2 0x5c04956c372b in trace__syscall_info /home/howard/hw/linux-perf/tools/perf/builtin-trace.c:2436
    #3 0x5c04956d2f39 in trace__init_syscalls_bpf_prog_array_maps /home/howard/hw/linux-perf/tools/perf/builtin-trace.c:3897
    #4 0x5c04956d6d25 in trace__run /home/howard/hw/linux-perf/tools/perf/builtin-trace.c:4335
    #5 0x5c04956e112e in cmd_trace /home/howard/hw/linux-perf/tools/perf/builtin-trace.c:5502
    #6 0x5c04956eda7d in run_builtin /home/howard/hw/linux-perf/tools/perf/perf.c:351
    #7 0x5c04956ee0a8 in handle_internal_command /home/howard/hw/linux-perf/tools/perf/perf.c:404
    #8 0x5c04956ee37f in run_argv /home/howard/hw/linux-perf/tools/perf/perf.c:448
    #9 0x5c04956ee8e9 in main /home/howard/hw/linux-perf/tools/perf/perf.c:556
    #10 0x79eb3622a3b7 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
    #11 0x79eb3622a47a in __libc_start_main_impl ../csu/libc-start.c:360
    #12 0x5c04955422d4 in _start (/home/howard/hw/linux-perf/tools/perf/perf+0x4e02d4) (BuildId: 5b6cab2d59e96a4341741765ad6914a4d784dbc6)

     0.000 ( 0.014 ms): Chrome_ChildIO/117244 write(fd: 238, buf: !, count: 1)                                      = 1

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d7c7d29291fb..8d3260bad10a 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2108,7 +2108,7 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	}
 
 	if (syscall__alloc_arg_fmts(sc, IS_ERR(sc->tp_format) ?
-					RAW_SYSCALL_ARGS_NUM : sc->tp_format->format.nr_fields))
+					RAW_SYSCALL_ARGS_NUM : sc->tp_format->format.nr_fields - 1))
 		return -ENOMEM;
 
 	sc->args = sc->tp_format->format.fields;
-- 
2.45.2

