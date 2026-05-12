Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB27637FF58
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 05:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564166; cv=none; b=QqPREqpuQBrwF6SmNpfdOG40q/4DFK5TQRmjIkgJD9abINgPq4MAjPoxo7cSMiEHE+zmLteyuCdra6X/1WgppZj9EH17UFCpMPUfAtk8fKNWNfKCQZ2xjqYhSEIpQzJ+H9aTuMkujcpOJvgr2CqU4jQpaZYbSYSyO7V1Pz5/PcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564166; c=relaxed/simple;
	bh=4IFG868/6JHvA0p0jcKGtKYfpyMyLtoR19Xi4djBeOc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pGKHBovI/YH13x04vZhcEQDAMCEZQ15F7jhfxYGwFtzYG4ZPhHn63kaRZ4n7glfWL1fgwESqAAGlK0BVnvvu28zFgqvsm4RQ4eHQubzDg/G8k1XZj9PTp8zNQ9CijrxdZWrZo93CDjnfytKQCv5V8YKjdQwcT7vPVoWUhb41mpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Px9vdOg+; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Px9vdOg+"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-132a8f93432so7562346c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 22:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778564159; x=1779168959; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rw5Nz69HEAvLl7hnisIiKYJkHKdAFDDtbfFS8C1qvgw=;
        b=Px9vdOg+pIm42QGNNqKd+0AoyePjs5roMct/vl5IR9ye7HI9POghBXfpMFjLDlwmoz
         r9EAKoI4cbYHKMaBck/vaE0XosyYRgeK+jLsBoyeEfTP/84eE+/ihULRwjflJWC3xepW
         A6oSrjkp/N/ARXhZV8CAhcW5dsZpYo67rK9TKETt/QdWTRPEohK1uZZ1fJIOHWWtQAAx
         Ld1I8NOw0ieacOFoar9cakFIzf167MoCW8SLvgreFXKjimw8s/c8mQnXh/vNt5BwNjEY
         AOudtH+Lt3JzMolB5BJayNc0SCoXySjt/j2Q9Rq6Ge7qGmuZPEDrsVoIY/zxJbuWSOVo
         HaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778564159; x=1779168959;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rw5Nz69HEAvLl7hnisIiKYJkHKdAFDDtbfFS8C1qvgw=;
        b=eUcC5fbQTrU154kwyQIMrQ3btkPPRlPfPvq2etBHeeiiiURgNkKhKxQKHORMfG6oPG
         P/jz3U5mphZfoowy24Gj/5/L5duQxaQKtdK5JkzcfXDlccCO13rZRdvkiTrnpwX08ft4
         vFkOQFj5f+2uutTTSTD5BNu326NiRZZT0Y4oNzNHZ1VnLDd5TpyxGtunGqtexElWLa5C
         Tub9La4Rn5//YeadVk16conqagv3zqdw/gdiPFw2W0SeMsXh0nkbK9znW8DP7lcU4Hrb
         gyGNVGGdY8x4vLA9f2uFYmwlycG08xmQrltMk9wNsjXei2/3CMzK12iesnsIPJjUQYw1
         kRxg==
X-Forwarded-Encrypted: i=1; AFNElJ9Kp2QXbqOcLFQcFvlzNabJN2PaNQFH6HuekT02oWVVRA6bIreLjxjNEpKMMK6MApeMYLCvJLXhE9/i0+6MZHxW@vger.kernel.org
X-Gm-Message-State: AOJu0YwrUtnRebCWQ5Vi35d7WdqVZ1pmsmkutzsYIZvVaFpfm4QS0vcO
	UwJkZaD3jQpPoixAzLd3d6jjfFUPI5xfY0P3qJaiI26Yvq+KLw6S+skjD+179se1on+UD0z66NR
	M423DhJpDKg==
X-Received: from dlbts20-n2.prod.google.com ([2002:a05:7022:b054:20b0:133:52da:4092])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:207:b0:12d:de3f:d842
 with SMTP id a92af1059eb24-1319ce482c7mr15316661c88.37.1778564158886; Mon, 11
 May 2026 22:35:58 -0700 (PDT)
Date: Mon, 11 May 2026 22:35:29 -0700
In-Reply-To: <20260512053539.3410189-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512053539.3410189-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512053539.3410189-5-irogers@google.com>
Subject: [PATCH v1 04/14] perf build: Remove empty archheaders target
From: Ian Rogers <irogers@google.com>
To: Quentin Monnet <qmo@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>, 
	Nathan Chancellor <nathan@kernel.org>, Tomas Glozar <tglozar@redhat.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Leo Yan <leo.yan@arm.com>, Ankur Arora <ankur.a.arora@oracle.com>, 
	Markus Mayer <mmayer@broadcom.com>, Collin Funk <collin.funk1@gmail.com>, 
	Howard Chu <howardchu95@gmail.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Ricky Ringler <ricky.ringler@proton.me>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Remove empty target that doesn't do anything.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index c66af4c825fd..24581941e912 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -627,7 +627,7 @@ endif
 __build-dir = $(subst $(OUTPUT),,$(dir $@))
 build-dir   = $(or $(__build-dir),.)
 
-prepare: $(OUTPUT)PERF-VERSION-FILE archheaders \
+prepare: $(OUTPUT)PERF-VERSION-FILE \
 	arm64-sysreg-defs \
 	$(LIBAPI) \
 	$(LIBPERF) \
@@ -1070,7 +1070,7 @@ FORCE:
 .PHONY: all install clean config-clean strip install-gtk
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
 .PHONY: .FORCE-PERF-VERSION-FILE TAGS tags cscope FORCE prepare
-.PHONY: archheaders python_perf_target
+.PHONY: python_perf_target
 
 endif # force_fixdep
 
-- 
2.54.0.563.g4f69b47b94-goog

