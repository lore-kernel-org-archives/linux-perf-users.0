Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC7FFBF2
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Oct 2023 10:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUuG8It/"
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990BE107;
	Sat, 28 Oct 2023 03:41:28 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c59a4dd14cso40476071fa.2;
        Sat, 28 Oct 2023 03:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698489687; x=1699094487; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dNMR79gx4YlEM6/vC0ctcm4csKiAR8AMBm30muHjlqM=;
        b=GUuG8It/EQwfUT//O+SntxRk5HX2TJVjYdiuBGR8NM3P70knVOsmCalIH4G1M5tti4
         G+tSE2irZudoHIRi8gd6CpKtVSj+652T3elMm7YoEZZggfuh0QUpir02M/NIybqAjF4V
         KQtKAVMUgsYYKINsCYcfWEPpvXT9nlTUmMkiKVbZDpYtVhuBir+dIhFwuiZJb3RbJmHm
         XYGWukB2YnmEK0Uox37b1EYvobPMCFwKEdy5o0VocIbL+zHXZJQg1J6vHvfDVlgk5lsZ
         g0pPWKDswSp5HWVAGmW5x9JhtZ5sfNSAJno+7XlvnMUQv7P/U8sXnC3Vuf8XxRf4jzk9
         GHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698489687; x=1699094487;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNMR79gx4YlEM6/vC0ctcm4csKiAR8AMBm30muHjlqM=;
        b=ltbNA+lEyi339x1TSl6KxTJEk5rKKyaXNok9Bf0072WyEU1y5IKbL0oWQUdy8TRaWF
         unK4cSKBwdx5+y+R74xSB4u5gaybVfu+8tHZwOkCuwinfpHJTz9iumF6IDaR1oEUnQ29
         oOWfIfi5qc+HAY+cQL+FB9bwelvz1BfHnHGx2Z7xOt9dIdvuRyeZ/BUdlX5q/OcbQRKi
         P/pU3OtdfoAwADIt6RMm1z/Swy2B8kqQN95y7YdokvcEREHE8tWuZSb6tTj/n1kWVQpy
         HcUZi2I+UbsOyKfDeSs75VuYLnrw2pse2j/P+fe1XW9OvS54wCCFELElo5T+DgUI25UN
         bDFw==
X-Gm-Message-State: AOJu0YwfreQ9GG/jVdzXXv5p1fhU9EZd1H/zz/L2vvh3Z0Fo9T0nX0lv
	0RaEGZxUPLdnegZeszV/8is=
X-Google-Smtp-Source: AGHT+IFX4jpNbHwTpxGnd0cVnfbHWzie32rxupnmU5XuRdroZmWoUBbUwJZ89LJ2GKfy6T7tj51Dzg==
X-Received: by 2002:a19:f51a:0:b0:503:778:9ad2 with SMTP id j26-20020a19f51a000000b0050307789ad2mr3251553lfb.19.1698489686512;
        Sat, 28 Oct 2023 03:41:26 -0700 (PDT)
Received: from gmail.com (1F2EF1E7.nat.pool.telekom.hu. [31.46.241.231])
        by smtp.gmail.com with ESMTPSA id f12-20020a056402150c00b0053e15aefb0fsm2633342edw.85.2023.10.28.03.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 03:41:25 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 28 Oct 2023 12:41:23 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf events fix
Message-ID: <ZTzlUz5PMxr36K1S@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest perf/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-10-28

   # HEAD: a71ef31485bb51b846e8db8b3a35e432cc15afb5 perf/core: Fix potential NULL deref

Fix a potential NULL dereference bug.

 Thanks,

	Ingo

------------------>
Peter Zijlstra (1):
      perf/core: Fix potential NULL deref


 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d0663b9324e7..a2f2a9525d72 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13372,7 +13372,8 @@ static int inherit_group(struct perf_event *parent_event,
 		    !perf_get_aux_event(child_ctr, leader))
 			return -EINVAL;
 	}
-	leader->group_generation = parent_event->group_generation;
+	if (leader)
+		leader->group_generation = parent_event->group_generation;
 	return 0;
 }
 
