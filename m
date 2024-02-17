Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07A8208CF
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Feb 2024 00:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708131522; cv=none; b=F36fzNYggVPW1Xmdy3qI3mAvdu+YEkfgxn7sTS7xwbd64hoZFy3nCmrD3/yQ6t4tKqr+MxHqL1WUUiKDeu4ey69KfXQxFpo3gCVvP7rK9GaQBoehB/lH5btYdFRG51lJxNXSFX1aScc058H2b3lpsLqQJwHR3M8l0lJhbi2itoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708131522; c=relaxed/simple;
	bh=bv/FYmkztJnwsY2iW6Bp2G7/4vfUAi73vHt5Pq3FWHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bjx4JFqIaWf5i3Jl+uY+qOs8f3rr+44nskJPypuu1SbYQ0aFrfSJqajw9f7bBSy/mnxlbQeSMxpBynYU21LlUi7qRzf4E/oxBar+S9VO+1sveTEu0LkdHaSyrxdVl1bAAdvxYHVCPYi8esprbaSMyL5ErtYPUPmNjUn+4Mtu3Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bCl3uOfV; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bCl3uOfV"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7c40863de70so65077339f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Feb 2024 16:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708131520; x=1708736320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jA2bwMTLdR68IYWhAHQk0vem/FIvLYvJUSgd6oUDROA=;
        b=bCl3uOfVV496vzz46fQ0TikB5r01tMiO7gRsNhHvbY4pQ9W6hGfXwMlcbfPIKuqOut
         Ui+SYKp0nopFJ277DEbYuqOyXEiNq0r92OFfc0wVNmUtlcjxpBPwOe7WTIhvbmb1p9We
         EaQQSmbc/uNb4EY+3HUa2Rv6zdfYXkzgv+UpQIZHGDxrR1nz4Fj+FRV6MsB4mVfSGd8L
         gbfL5O/cAoJ0fnGh8x01qUJK49Of6AG1anwve9tAodeUGGaNNoAXmiglB4I+Up/3aqx3
         KRQMygnqvcEUAG/hwLNH0NCiFPZ2jBD1E7ziP83lc/OjHz2j8GqN5EDYh3t52V6KOLMo
         xdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708131520; x=1708736320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jA2bwMTLdR68IYWhAHQk0vem/FIvLYvJUSgd6oUDROA=;
        b=uKmZKyL0YtniZTmEL0+rtpHilWUcwWuVU3EbEmtBUUfeWrV5nndy3b0M4fAyyROUBg
         NZcJ7pDcTYu/g4jnDA7mwD4tVUN0CqpsCr5dCpHJu5eVBdMffGiWsi+3waYg47JTpSOz
         qDiXb6N4FjoFahjTC1VW/A1vwOkrYvASHe1EUWewaJxiSJ1iPpeNgMmkrTcX2JEBAJue
         cAx3+E8XeY1BxlMwtZSk7jaFWnP2SBOlKtnMZw65pueg/a42EXT0i7etQAr9azpVV6bP
         YGOoUS+xY8c51XFPjIoTq/Rv1QTxHBxfzqCdA0120TW0omv7zzImYvkgWlpeJ5tv/Qnx
         s+7A==
X-Forwarded-Encrypted: i=1; AJvYcCXWpalYsWnKSVEEXsAv25tQSl9bXB5M4Zj5Vn3e+1vp576XQP6m/vbn9ImBTn6E4HBl3jpyzib1nNcLYgNorMQ22CVQVC1DmTT04NUgSB322w==
X-Gm-Message-State: AOJu0YymbqAmpt7aoPjNXOQ7h6jeHI19iZiriO4TiE151AnfMGS+rI39
	wz0pSqYU2suuD8CPVrjjh8yDmWDqJe9u9aYRs4IAgow7wbQgTwDza7nbgp0WuVQ=
X-Google-Smtp-Source: AGHT+IEdeqVqcC/VKKKrXOEHY/VeTvf9ltSju1U8A00Dr62R9FD2Xfm3+udDPMEcDgQNQ3u+AM/jrg==
X-Received: by 2002:a5e:c10c:0:b0:7c7:2e71:bb74 with SMTP id v12-20020a5ec10c000000b007c72e71bb74mr626708iol.4.1708131520123;
        Fri, 16 Feb 2024 16:58:40 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d188-20020a6336c5000000b005dc89957e06sm487655pga.71.2024.02.16.16.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 16:58:39 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Atish Patra <atishp@atishpatra.org>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor@kernel.org>,
	devicetree@vger.kernel.org,
	Evan Green <evan@rivosinc.com>,
	Guo Ren <guoren@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@arm.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	John Garry <john.g.garry@oracle.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Kan Liang <kan.liang@linux.intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Rob Herring <robh+dt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Will Deacon <will@kernel.org>,
	kaiwenxue1@gmail.com,
	Yang Jihong <yangjihong1@huawei.com>
Subject: [PATCH RFC 10/20] dt-bindings: riscv: add Smcntrpmf ISA extension description
Date: Fri, 16 Feb 2024 16:57:28 -0800
Message-Id: <20240217005738.3744121-11-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217005738.3744121-1-atishp@rivosinc.com>
References: <20240217005738.3744121-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the description for Smcntrpmf ISA extension

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 15adeb60441b..149ecf2a8af3 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -135,6 +135,13 @@ properties:
 	    directlyi accessible in the supervisor mode. This extension depend
 	    on Sscsrind, Zihpm, Zicntr extensions.
 
+	- const: smcntrpmf
+	  description: |
+	    The standard Smcntrpmf supervisor-level extension for the machine mode
+	    to enable privilege mode filtering for cycle and instret counters.
+	    The Ssccfg extension depends on this as *cfg CSRs are available only
+	    if smcntrpmf is present.
+
         - const: smstateen
           description: |
             The standard Smstateen extension for controlling access to CSRs
-- 
2.34.1

