Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982362CCC5
	for <linux-perf-users@vger.kernel.org>; Sat, 23 Aug 2025 00:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755909153; cv=none; b=CALpjZpB5vHv12pFtD/3ILwGLuuKThCkjS0XlSD4gcgV5tfQHRk+n3biSSPJkFjk0QjS2Ydx8TjbCL+paaINqrnl5lL8x3mdFM6w+qJB929qa38SbPjhrptGxAwZJoqU2Uk7DwCBgFjphYSZsr/0nwb0TrWPT/xCeOVhGBL34eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755909153; c=relaxed/simple;
	bh=Dc3cNk44/tRuM2VojGcEzzSNDOPpGyR342/mBE8AYFI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=oZPZIc+ZmfC238cvQ3DhfsovZhBR1uTiZ+uslO/ghxIBYhIA6Cn+ZLXpxI42QXzK7qZlTKI/JTCss/DHct/p/+lepWy5Sr/HQGc6bnpztnQ4oDpSzjUU6uKdr/ZefBOP8mT96veIFKuZwMeD0RSwBLVhyqrSIfG3JUhX+1q1z8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AFKzAvbM; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AFKzAvbM"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-244581953b8so30835675ad.2
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Aug 2025 17:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755909151; x=1756513951; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yQAl8xl/b+1jpLH9+IEKeJpo3s5Nx0HvpydTDpQfd4s=;
        b=AFKzAvbMV3/4suLV56f+kW8wYB1GVQHgU+Ic5MKMWY8F0+Ysh2UEpr0Z4aq994HiHG
         bQQsdVq95iqYzBAcMryylwTYgc/QzQblMpmiDl60qe6qnic7btottAsBe2AK7HIjEpgR
         +RndbXGfCyMYw88aZ3ItGtIM6d7WwmLbFob/RR1tfK05Br6mV52UaTpoQpLBixncaUGM
         WNieaeHSXI5dDV+TmHajrpd2xKqILpHFhTCzEHIEgWZm7Zj9M7jr86XM+BS+t2Xf4axd
         qgOwwz5XCGBlL57kWPNum4OhC8k35QNZiYvHlof/ALUQLVnVPRxCBICDD0iEPwJIJJac
         TGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755909151; x=1756513951;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQAl8xl/b+1jpLH9+IEKeJpo3s5Nx0HvpydTDpQfd4s=;
        b=YViNGWkENgPrRjtRbNFTSJXOvthaz05taTahl9QiTqlepN0iZEI2FL3WE7evPfJGPe
         G5jqPjXMtY3QY15oL1E6zswma8lb619DcDD49wkbvK3x+XAoQ4hweUbpOnCFKorPCCfy
         xfp5BpPi/jBmnDWVPhaL0seSXGwweNwFgfwz7nhPMsIm0uxYWUH3tB17/2fq9dTCMRYG
         KYWHHuAZVI/60m8x4mnT190Fm8oXC1rx5lcFweZZNoyx+35i+cDmNMw03wwGOYZy4iFJ
         omrI/w3QgE/wGd/VVdgqjVrESeOLboa+/jkM2bzX2tZ/9esSDUo0Aa/9bn/87nGA1AP0
         XhSw==
X-Forwarded-Encrypted: i=1; AJvYcCWdTXYrsHSMkkQXHz46tj2haMv+YAtTfkDbztkLAKrCQC/gWr5wZeLsASy0M5fv2M8jEtFTTKEAP1oarcXQXQHZ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm7fZtnYNqbW0kbSkihWpASe9uzEuD0WG8T3yYN1UR1msuhX61
	OhEtqHJjlM5v3ezx8/QiqOE4SGGtoSkE/xcSkak6s8I74CWYUZQQWvcBI5O4FG4RYSxRz4UeBuX
	btuz+inHPlA==
X-Google-Smtp-Source: AGHT+IHRINNwvyZt4lXIFjt25RkSON9R8J4szK9janrxGyoVx2sOxv0HYEXd2hph/CfK/OG2Ux3zgjtJdVez
X-Received: from plbme5.prod.google.com ([2002:a17:902:fc45:b0:242:fe10:6c5f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e892:b0:243:8f:6db5
 with SMTP id d9443c01a7336-2462ee0baa0mr79386145ad.6.1755909150886; Fri, 22
 Aug 2025 17:32:30 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:31:57 -0700
In-Reply-To: <20250823003216.733941-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250823003216.733941-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250823003216.733941-2-irogers@google.com>
Subject: [PATCH v5 01/19] perf build: Remove libtracefs configuration
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Changbin Du <changbin.du@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

libtracefs isn't used by perf but not having it installed causes build
warnings. Given the library isn't used, there is no need for the
configuration or warnings so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 5a5832ee7b53..7bc2341295c3 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1181,20 +1181,6 @@ ifneq ($(NO_LIBTRACEEVENT),1)
   else
     $(error ERROR: libtraceevent is missing. Please install libtraceevent-dev/libtraceevent-devel and/or set LIBTRACEEVENT_DIR or build with NO_LIBTRACEEVENT=1)
   endif
-
-  ifeq ($(feature-libtracefs), 1)
-    CFLAGS +=  $(shell $(PKG_CONFIG) --cflags libtracefs)
-    LDFLAGS += $(shell $(PKG_CONFIG) --libs-only-L libtracefs)
-    EXTLIBS += $(shell $(PKG_CONFIG) --libs-only-l libtracefs)
-    LIBTRACEFS_VERSION := $(shell $(PKG_CONFIG) --modversion libtracefs).0.0
-    LIBTRACEFS_VERSION_1 := $(word 1, $(subst ., ,$(LIBTRACEFS_VERSION)))
-    LIBTRACEFS_VERSION_2 := $(word 2, $(subst ., ,$(LIBTRACEFS_VERSION)))
-    LIBTRACEFS_VERSION_3 := $(word 3, $(subst ., ,$(LIBTRACEFS_VERSION)))
-    LIBTRACEFS_VERSION_CPP := $(shell expr $(LIBTRACEFS_VERSION_1) \* 255 \* 255 + $(LIBTRACEFS_VERSION_2) \* 255 + $(LIBTRACEFS_VERSION_3))
-    CFLAGS += -DLIBTRACEFS_VERSION=$(LIBTRACEFS_VERSION_CPP)
-  else
-    $(warning libtracefs is missing. Please install libtracefs-dev/libtracefs-devel)
-  endif
 endif
 
 # Among the variables below, these:
-- 
2.51.0.rc2.233.g662b1ed5c5-goog

