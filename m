Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853364718D9
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 21:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789076358; cv=none; b=r0RKE28hwQG/sHPBmHGWQPiSwLEVfU7mZR+q5KWEWRphBU1Py0u9dfk0f3nyG/b0zc/oVsZ/s5BQmYzh/YdvuQOYpz3e8p0luAwjN+mL8RDQQYJcaajAC+AvNZaFXfELeRQq3aRpKJtwAhZ5+ePj/NNN0w1WI5Re0zvefY1HRT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789076358; c=relaxed/simple;
	bh=VZ7i9g/d+H47coYO3Xc9M1wiqaAKR5dvjmJyK4FiQPk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Mc4fseOFrFJqosE4V0wOdHdfFfSILrm0ZKl2LjyluADaDonAeCXKNrh2GapXeq7OvmAdF0JGiRDx7Q0VIZgdg11yM/QvqvwA+Hz99TNkqiqVf8yzAxvIAy4OV70IGocJMu/QUotxFivaRQN4/2XExyBhGly/SNcYzCYTFjAKOJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=psf1nRm8; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="psf1nRm8"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so327924a91.3
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 14:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789076355; x=1789681155; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:mime-version:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6fbf9eOsE32d1ZOxCGBZBdmKD77pEwD9k19mpGO+TR8=;
        b=psf1nRm8pyZ5OcEswNdDl0zaYmyEuhYApnmTgbLffPHub5TfTThZtLyvuUMbDc9zIk
         FAIkxnHKlYQLbdGs/BXNcqHoFEVScS9yR3RMzEOPoRizKNHogmGoMlwNph6h8N+r6BS2
         3UxXIddPQPrwadzGSTHcR3jwTlbH7sXcka+pr9lOq/sn5hI4sDP6ffVLs7fjZF1KT9jV
         5kOXasWCt11pEOPr2uuX5DUwRl5Pli4v2VSsBuPYhikNafzeTV0iGbxjxmhLeXyAcSzT
         tmjEewAe+MYR7MOhZnrJ6Pg2Bb/T69PEFH+07Ccx2M5v0otGVlPMdqXyv+GPRatjmnRs
         VWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789076355; x=1789681155;
        h=content-type:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6fbf9eOsE32d1ZOxCGBZBdmKD77pEwD9k19mpGO+TR8=;
        b=eYChllsjf2Fu7RG+SPQTpLyGc9vt1V8kz+R18+/dDdd4GYAJG61vOJh7G+ZSF1L5pV
         ao1IM9lXkIgy7NZSXlxnPEBCZWMfk9bMh6TXhoNkVUFTPTuX7LyVRroHrCaAQ77lY6FS
         zOAOK2emsdyr0MRKaMIkx/9b0jy7rSnLy3v/PpNoIqPJl8ATJL+/XoGJQlNfeJ4089Qz
         WVtss/uI9ha4XW/gbPpnOtjVjyNlnI0D4Qw/X+wVjLrDuz2Ix7FdkMzH16im+PJrCwqT
         5Bz5tRVM+flFjoKQ5e4CxO+1z8a+Xo64lyMktil1m/bxxuVDuz2urAUAO9l38XsHUDaD
         SeSg==
X-Forwarded-Encrypted: i=1; AKwUvBwU8ohp9Syzr6tNh1ExAQo4m7IGIYul68dHCmqrS0mh0ktRSnSCYQogSHqI8tmK4glkEpAQZoquGPy/n2mhNhv3@vger.kernel.org
X-Gm-Message-State: AFuF++kNFIISPbgQ8vzxryIY+8u4rc5G8sDinKoT4wvFAzXae13m7RPa
	MOEShpwh4VDElVwfl2/lX2BKmLwasyBao1bKZZ/t4JtjdPIFU+qUWm7AsxQ5KdhTdq9jMplXc4X
	CwRniM8KniQ==
X-Received: from dlbbq8.prod.google.com ([2002:a05:7022:6708:b0:143:65eb:f1ec])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c8b:b0:398:9c00:29ee
 with SMTP id 98e67ed59e1d1-39d9c38fa48mr1037351a91.22.1789076355117; Thu, 10
 Sep 2026 14:39:15 -0700 (PDT)
Date: Thu, 10 Sep 2026 14:39:07 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260910213907.3206529-1-irogers@google.com>
Subject: [PATCH v1] tools build: Fix timerfd feature detection with clang
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Clang's uninitialized-const-pointer warning causes a feature test to
fail when building perf with clang. This disables support for 'perf
kvm stat live'. Add default initialization to new_value as a
workaround.

  test-timerfd.c:15:30: error: variable 'new_value' is uninitialized when passed
			       as a const pointer argument here
			       [-Werror,-Wuninitialized-const-pointer]
     15 |         if (timerfd_settime(fd, 0, &new_value, NULL) != 0)
        |                                     ^~~~~~~~~
  1 error generated.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/feature/test-timerfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/build/feature/test-timerfd.c b/tools/build/feature/test-timerfd.c
index 9c72c697a9df..f88e8cc63ef3 100644
--- a/tools/build/feature/test-timerfd.c
+++ b/tools/build/feature/test-timerfd.c
@@ -6,7 +6,7 @@
 
 int main(void)
 {
-	struct itimerspec new_value;
+	struct itimerspec new_value = {};
 
 	int fd = timerfd_create(CLOCK_MONOTONIC, TFD_NONBLOCK);
 	if (fd < 0)
-- 
2.55.0.1007.g17ff1f9808-goog

