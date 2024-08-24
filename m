Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D87185B7E;
	Sat, 24 Aug 2024 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724517214; cv=none; b=tQCmZ4kDcMeAtsQ8rJzJXGkEBtzCIdUbm6VhB2vY3LijTHFWpdc/ZDFZ5aPQwBWkqv+zecLrQ2vPR2hz5Z8YuAnwvYNBFIAqbjolIGrIgRzpyLd1bvkQRZ3/QxaoGWNPwxdT0Kpa6GNPR+1qvt8EHinnWysJPB7wL9IxZSUdpSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724517214; c=relaxed/simple;
	bh=kOaFaDR+DhlmRt4+1xw22YBHxgGeGE1RqeYgr19yVnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfRO9GbzJG+lMnNBmdLxgdD5qV4Etr9IZ7fHmIkyYzOtMSGOk7B0QsFsvV7fLL0ezLJ8fSXMhp2JqEmFoZJCmTtE6TofRsqnBPjf00xd2a0kxvIq5x549e/xLnWXD08DbAl/Iy6rmTR7GjdH9EyJhBq5FSyhlJDBWytvNUKEBWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPBg2AIH; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPBg2AIH"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d3dacaccfaso2038098a91.0;
        Sat, 24 Aug 2024 09:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724517212; x=1725122012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMBnSHxXkm746u32J0TUWktc3i+DQ1/O7EpofHyk9PU=;
        b=fPBg2AIHzuwsLzbrlzZFWjf32GV8lYWVsHP4L0lv2O2kV6mNqK/BOMg71QwHsSzy8/
         O6BoB/5qCmzq87ynhap38zdhl6tGUgtkrcCNohz2ElBDAC7PTL8B5a2/IWPnAVmk8YG1
         jC1HBTkEFwzU1qN+uxNJ7M2JrQqjnEysSiPE92H/uZmCTQrE9QW5ye+uy6TSwBRlJWTE
         dDIwVg4HHXV8DczsDL1j5tRHHf/sLIZtq5uITWYI7aqYSiIVMrnuHAKCr3834G0YH85p
         hDMmmZVL7/qVccuh2Zk6kgOwlmXuVgtxqybgipo5B6Tb5NxCho3GRyfeUlPeSnVqefNC
         icTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724517212; x=1725122012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMBnSHxXkm746u32J0TUWktc3i+DQ1/O7EpofHyk9PU=;
        b=Ue+J50Kv/CTfbD+LrzmhIQO6K9xpZOr3hzs+3fwBmt5Y9UTfullX6eMsfby82gPL5S
         x5Ar8v9/Ns7oAoR77ia+ZlOZm12O+Iu8hTM8W6Dl1nWyRjshkgjiU+Z2k24z2k3a6Dtd
         v5L0jTcN9/L35827wwqPEQIolZBy1pWsQlNpxxMJiuG/9FHRvM/rRHtgacYqwPNyH8ix
         qs5yc3XfmWDYo1CY6k7Ds2kYGHw04EVWN+ZKuWtvyEAYfhOOJVAHYDXXK9Q2SOZPoYxi
         5qS06zDAbCZZqfrdepMpvpqD49T5EmGq2uVjmP2QcS38zBt2naP4BZUE0yvSro5YOXKQ
         kNXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTU/lTm3AAuNlP3kDt7Ac3SGXy/XihnrowJ5y69P40wkMCJbvYrUxvqG6HaJM4WpjigTXwmEeqt80nfA8=@vger.kernel.org, AJvYcCWhej27VDSyay+ezCwAd88Du4/47E3w07pD6ILYNalGOqxz9Z2UcCAepVqVBPXF8zpmQVytdwGyDwKiKADqGAR7+w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx80SFwPf3c2mE4ERjQZJ6Hpl6mwObuHeySn1es46GPwbSGJ+08
	t3b0FhWG3//v7TfMIgu7LNsE2vutiwzFaOfl+uLSvUAuU7j/AOCY
X-Google-Smtp-Source: AGHT+IFNmWvjqJh7TIaO12e+QxSBbkf82H0IIQr6osSp4N6WTXUZJ0tyEQgxkJtQnMq3GGlJXOm5hg==
X-Received: by 2002:a17:90b:438f:b0:2c9:64fb:1c7e with SMTP id 98e67ed59e1d1-2d646bbb1ccmr5728528a91.14.1724517211971;
        Sat, 24 Aug 2024 09:33:31 -0700 (PDT)
Received: from localhost.localdomain (104-58-203-241.lightspeed.sntcca.sbcglobal.net. [104.58.203.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613941ee7sm6376216a91.24.2024.08.24.09.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 09:33:31 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v3 7/8] perf trace: Add --force-btf for debugging
Date: Sun, 25 Aug 2024 00:33:21 +0800
Message-ID: <20240824163322.60796-8-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240824163322.60796-1-howardchu95@gmail.com>
References: <20240824163322.60796-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If --force-btf is enabled, prefer btf_dump general pretty printer to
perf trace's customized pretty printers.

Mostly for debug purposes.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 470d74e3f875..115f8dffb272 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -205,6 +205,7 @@ struct trace {
 	bool			show_string_prefix;
 	bool			force;
 	bool			vfs_getname;
+	bool			force_btf;
 	int			trace_pgfaults;
 	char			*perfconfig_events;
 	struct {
@@ -2349,7 +2350,9 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 
 			default_scnprintf = sc->arg_fmt[arg.idx].scnprintf;
 
-			if (default_scnprintf == NULL || default_scnprintf == SCA_PTR) {
+			if (trace->force_btf ||
+			    (default_scnprintf == NULL ||
+			     (default_scnprintf == SCA_PTR && strstr(field->type, "struct")))) {
 				btf_printed = trace__btf_scnprintf(trace, &arg, bf + printed,
 								   size - printed, val, field->type);
 				if (btf_printed) {
@@ -5153,6 +5156,8 @@ int cmd_trace(int argc, const char **argv)
 	OPT_INTEGER('D', "delay", &trace.opts.target.initial_delay,
 		     "ms to wait before starting measurement after program "
 		     "start"),
+	OPT_BOOLEAN(0, "force-btf", &trace.force_btf, "Prefer btf_dump general pretty printer"
+		       "to customized ones"),
 	OPTS_EVSWITCH(&trace.evswitch),
 	OPT_END()
 	};
-- 
2.45.2

