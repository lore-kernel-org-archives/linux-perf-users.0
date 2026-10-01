Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E943BFE3F
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869701; cv=none; b=SWaK7eD31f0/VxRnu3uTZzL9OBSEhkeoX25J1kfR9FxGO7wU0pXsJDpGmqzTO5vvivzY/FUvn9d6WezMITmeY4g2ov0B8cB0eZquDHxCPHAe72lnaCMBWHpJmzY5uwQkHJmH7a+2CyRR9jgYRqmW6lD1SEvXVR+5+r+oGfKLevI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869701; c=relaxed/simple;
	bh=59iH1F5Vy/056HDKnHHLy/flOtWGquaR/K7OywQ7VtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uIuUMTKTB5IB0vnz5IbjelLuq9oRauy8X07xnTiOR/g0Vr666L7Gr+6YARbtMvBnyx1wRU90eVWV0RY41m6MZvyge1y2Xa/6gtoLTVTCuJ6cXvzgbPYxxCdB5sAy/wEBuVXLXsPJYavkKWn3Jae5co79X1fKwnZ9hvGN+W5XWzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q4lxFpE/; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q4lxFpE/"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6351831so3938885f8f.1
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Oct 2026 08:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790869698; x=1791474498; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WL1Ngs5P1NZipTs1d2xbqdAnfg1+txQ9m6WSod45AOs=;
        b=Q4lxFpE/aEjp0ou0LTuBSx8M6eO+92MIhgT70HFT8t5eXa0ioIn+JpMANFr6relxLg
         6eyWYTrTCgzlDEnF5DEgn1BI525mCkAEa1uXptD69OeleFY9wzOTWgZqCiByPWSubju1
         RVdbT7aDhkKmHZo+NuapfZoB4CCQsyzcI1n/nsSTG1WbioeuDNNgg2TgNPj1xlmsnPBo
         X7CgT5T0s2FmMa0jhwUsE0g8ym2bNkeetxzAH+jZGIDxr8p4SfL8jdHAtxxrCt7mH+2B
         1DNOwCwxYAtkKH06CIRRMRv0cCzBBRffqJT77vcTPYP6lKJh1gVEVjhvR4HZJ7oYE/T9
         Wk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790869698; x=1791474498;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WL1Ngs5P1NZipTs1d2xbqdAnfg1+txQ9m6WSod45AOs=;
        b=M18vqfTgknOqCQUzgzLj61WLaaaN5lU+vzHQIehLbQL7xZSzwKcHjeAAEWy1NsMxmq
         J/+81oss5D/a0cXqkHZwdBx7OX2LC07BiWpJwejJLW4yUByP7WyO4zW7M/CJTo0+clSN
         GzMwX/GpAK6Ej4w/0gRe4ARvMdT87UVAAiZdIUkDFjcCjTGVDUq6PBjArtLWwnPjWhjN
         O/CMeqovK5Gw55UfV4S4oOLNhBOPuBeR19um9mj5BT2o6mLFbP+jrqYDK0GI1iEMs9am
         vFqgo7n0qPJWkp7kQqI9kVoHCS92aGqgik9QY//j6pQBSFGKPGLdiw5yiPNr6ZvRqPYe
         Kz+g==
X-Gm-Message-State: AFq9FYJVM5BSN5RU+Lhz7M8amz6LovrsivGkqXOCV13f8OY8x0MjMs47
	DjqTE6o9PWWP+tyiaLgKmFvMccz6I9Xyfbk1SzyNxfoc4EcPNWlNKHKw0FQYH1LwWFE=
X-Gm-Gg: AYBFou1xzqewTC+mRLxglaxLYT3Wpx8hlTvQX5SW5Wn2xIcv29y0RBdtGXtQOFGXh8x
	gJRTiHnlFm/LfPAofN5kTdvTb8dl8fyGwvDK9OZZ+3TQZg+nJGVgqXbY2o1SKe1APplew+GLcw5
	pMd4Gu97CXOvk2nrP6S8g7FzpHk1R+9K7BKt3+861wtNfD6L4N1lZBlKKGOn0UU4ObJIvfw3VUF
	JO+kBMVStihSXEmEjUlrBbCLjbtbgmwJTHWVR+MkMaSjydHzL6lpaamfu0OIn2Q5IBJVL2q+1C4
	OwJDi8gk1YLXQvrRPeOlIuTqx2bLaTJeqjCmIudPh7BpW//A4zsm7EV3xNjn8lpT4l9IJPqKx4l
	qvyvyjfy8iUSS9Omt6DAAt8IC+yVlszYOaUQLE6Z+ndHJ2THK+4dkHAwsXp4eidno4To1gX8/qN
	o2ionstL3uTJ4idoM1IEl7AjsoSUFOP9AzF6n0Xa0VU1HEcOZ5soAokUvMVfJvtKbfJJD87laka
	Q==
X-Received: by 2002:a05:6000:4556:b0:48a:fdde:523e with SMTP id ffacd0b85a97d-48b126bdbd1mr52828f8f.8.1790869697968;
        Thu, 01 Oct 2026 08:48:17 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b0691d681sm6214047f8f.23.2026.10.01.08.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:48:17 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 01 Oct 2026 16:48:10 +0100
Subject: [PATCH] perf python: Track linked libraries as extension
 dependencies
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-james-perf-stale-python-build-v1-1-dd3b14644606@linaro.org>
X-B4-Tracking: v=1; b=H4sIALmAvmoC/yXMwQrCMAwA0F8ZORtoKkzwV8RDu6YuY3al6YYy9
 u9WPb7L20G5CCtcux0Kb6KypAY6dTCMLj0YJTSDNbYnYwgn92TFzCWiVjcz5ncdl4R+lTlg6D1
 dgrPRngnakQtHef3+2/1vXf3EQ/2mcBwfShAv3oEAAAA=
X-Change-ID: 20261001-james-perf-stale-python-build-d6b17da2f231
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

Since the Python extension switched to linking perf libraries, setup.py
only lists util/python.c as a source. The libraries are supplied through
LDFLAGS, which setuptools does not consider when deciding whether the
extension needs to be rebuilt.

When a library changes, make invokes setup.py, but setuptools can skip
the build and the recipe copies the stale cached extension back into
python/. This leaves perf and its Python module running different
versions of the same code.

Pass the linked library paths to setup.py and declare them as Extension
dependencies so that library changes trigger a rebuild. Include
EXTRA_PERFLIBS in the shared library list so that both make and
setuptools track those inputs as well, preserving the existing linker
order.

Fixes: 9dabf4003423 ("perf python: Switch module to linking libraries from building source")
Assisted-by: Codex:GPT-6-Astra
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/Makefile.perf | 5 +++--
 tools/perf/util/setup.py | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 7ceefc1da774..dbf7cceaa005 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -526,8 +526,8 @@ endif
 EXTLIBS := $(call filter-out,$(EXCLUDE_EXTLIBS),$(EXTLIBS))
 LIBS = -Wl,--whole-archive $(PERFLIBS) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
 
-PERFLIBS_PY := $(call filter-out,$(LIBPERF_BENCH) $(LIBPERF_TEST),$(PERFLIBS))
-LIBS_PY = -Wl,--whole-archive $(PERFLIBS_PY) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
+PERFLIBS_PY := $(call filter-out,$(LIBPERF_BENCH) $(LIBPERF_TEST),$(PERFLIBS)) $(EXTRA_PERFLIBS)
+LIBS_PY = -Wl,--whole-archive $(PERFLIBS_PY) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
 
 export INSTALL SHELL_PATH
 
@@ -559,6 +559,7 @@ $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
 $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): util/python.c util/setup.py python/perf.pyi $(PERFLIBS_PY)
 	$(QUIET_GEN)LDSHARED="$(CC) -pthread -shared" \
         CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS) $(LIBS_PY)' \
+	  PYTHON_EXT_DEPS='$(PERFLIBS_PY)' \
 	  $(PYTHON_WORD) util/setup.py \
 	  $(python_setup_quiet) build_ext; \
 	cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/; \
diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 8380980ade4c..3b6a59f66944 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -173,6 +173,7 @@ def main() -> None:
     perf = Extension(
         'perf',
         sources=[os.path.join(src_perf, 'util/python.c')],
+        depends=shlex.split(os.getenv('PYTHON_EXT_DEPS', '')),
         include_dirs=['util/include'],
         extra_compile_args=cflags,
     )

---
base-commit: 705da5b15ab89ba97b11eedbe507c2fd83d31cb9
change-id: 20261001-james-perf-stale-python-build-d6b17da2f231

Best regards,
--  
James Clark <james.clark@linaro.org>

