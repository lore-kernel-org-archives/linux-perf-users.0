Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E1F2BD030
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Sep 2025 22:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757112466; cv=none; b=rRiUTdZSBQGTeBBrUdY1kBdDz0eZMDJ+lXLXlhfZkh+6QT24wU+5yy4WuyneMtTyYQa6+uULN5hU/TtEL7UqMWSud0mj3NkNcBcWu0KRaakz0arHRsZb4cn7givLGk5v5fIk5uP2EuO1Vsbm1lnVR+Ddfxfztiqwmb2pGQg4wMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757112466; c=relaxed/simple;
	bh=+5NpxcP9jnj9qKT3QZ4Bqj9fuj7vqjFeNcFJ/my8LuQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=MKwiSMxNORkbzA+VViXGw1MqWLjKmmIDSk16mo9p+1daTWonFKt4PDqdtzh0Ie/St7g43N757yTmeXCezveJlODZTgg24L/lxg0uqFxvnmwbJbL6gOLdq7qd7NspyS+bT2aIki0GLRgHIBnR1npKaMaPB+PAWJ+/UZxanKU2zGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G//KPMMH; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G//KPMMH"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b47630f9aa7so2183686a12.1
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Sep 2025 15:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757112464; x=1757717264; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SIMim81pQReDOt0+L3Rj0SLjBTyQCKyPXsqTC1Lqb1I=;
        b=G//KPMMHqrKS8H19uDqg8eHtPPpc4FfdZ3svWkT4FYdP3sRGDETS7O++ggdc6xbpro
         81LsYbdDzuIvpunhMFOF++ppRp6vl8Vm69TTlmGNWh8MJPjO4J07lbm1vD8eZTP0V1Eg
         lVpB2v90men5J9U/c5Xs/WlalhrNBYXtOVpDd775WxuwukBjWAIuNxJWBOW8banGwbcG
         OWr37HswfkHG3JOwWa/MrPUXENfqtfgorQnAllCkUCl+UledOUgPN53y8Ax0CuJ38ROH
         9kpCDTgsxO8knalVqH3k08jGeZ5cUYAo9Wya1kWd0ygRMzQLwbKRm8gEd/EfSSY0z+df
         2V8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757112464; x=1757717264;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SIMim81pQReDOt0+L3Rj0SLjBTyQCKyPXsqTC1Lqb1I=;
        b=YoU1EgQ0HvNgHxWQw3dC3qDnuUMoO+g2IVOUOOU/qgjldoEaMdzfvWeAEqHfA5lxsk
         PmH5L48n9yTq52MrbaZ957t/0hzo9EYWz1Xej1LO2VMaVCR6Q6FbcOQ32WtHNX/zY6t1
         mQzJX6wmNVLRFKO1GjlU5Ak3Yv8wSu6tnYODuJBiLAkNvXuyNP1Iq912rAXJRQHxNtjw
         8W7CXDlpvffz4sOUtvzcl49341XvlyFUUnEZtaH97A2U108acCpfqqrdggRVSuZnVQTt
         PebQ+hR74LC43L/kfVaCqGHcfnOQAyzpQGA9huv15Xg4ne5ZC1QQpKnVJ6a5cY5JLKms
         ERZg==
X-Forwarded-Encrypted: i=1; AJvYcCWVAoQk1rj0SbvMxEa1u05+YVQTCpngS93UG420biQj2tmTaqtSjNTZinOLaaiJDJqoI/1lC7nioo1C3Q58RCCw@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1QpioU58+fj/aGmaZFuJP/pR6rxUjYX39P4eSGK9E9Hl0wuWp
	ewd+xlfvASOfArlml71GCs66k1SX9uAm/kBwy1QEw2oWU2sRrZyQHx6wh7QptYiKo1byvfb7vVI
	gks7Kopuq5A==
X-Google-Smtp-Source: AGHT+IF4jzY6mRc/AB5FSBYfW8L+P81GFGI8tfKxroAVbasaAzh00quVtqRegIyo6LThcr8QIaE1PJCYJh+C
X-Received: from plsl3.prod.google.com ([2002:a17:903:2443:b0:24c:a63d:ed5e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1585:b0:24a:8d5e:932
 with SMTP id d9443c01a7336-2516e981584mr3792745ad.23.1757112464206; Fri, 05
 Sep 2025 15:47:44 -0700 (PDT)
Date: Fri,  5 Sep 2025 15:47:05 -0700
In-Reply-To: <20250905224708.2469021-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250905224708.2469021-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250905224708.2469021-2-irogers@google.com>
Subject: [PATCH v1 1/4] perf bench futex: Add missing stdbool.h
From: Ian Rogers <irogers@google.com>
To: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Yuyang Huang <yuyanghuang@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Petr Machata <petrm@nvidia.com>, 
	Maurice Lambert <mauricelambert434@gmail.com>, Jonas Gottlieb <jonas.gottlieb@stackit.cloud>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

futex.h uses bool but lacks stdbool.h which causes build failures in
some build systems. Add the missing #include.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/futex.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index dd295d27044a..fcb72d682cf8 100644
--- a/tools/perf/bench/futex.h
+++ b/tools/perf/bench/futex.h
@@ -8,6 +8,7 @@
 #ifndef _FUTEX_H
 #define _FUTEX_H
 
+#include <stdbool.h>
 #include <unistd.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
-- 
2.51.0.355.g5224444f11-goog

