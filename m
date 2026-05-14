Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2BE344D9B
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776476; cv=none; b=PgKzERA3yInoCHfPQKHBcoayUjipnsApL8eg1P8Yw8SP26Xvb2/1e3rjbU5kJonZYtjyvhU5Rt2TmC30dbcxIaKb1YEbtZTaJBG0SJxCbjdmkv/Bv1Ax95qcVZj1sQMrtywNaz4NDGoU73kdf7cW3Q0cVVUMobDMuQB12iB6gBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776476; c=relaxed/simple;
	bh=xokYndru7r5U27QA5IiJ9grDU4CmNf+aSc8fRA9ncZg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Um6icgfIDHCEgiX2LkJqWuHkHnY1qea+XqNxwCYAVj0lwp/V+lar1KHShZrPKblx8RO6kj0qXrsTZY+EWUwEIsIynskyMWDURlhpp8Q4QdKZ1B7fbkpH/CbFngFq+pq84WgLTnJgGSoRlS/xr9SiEEq55tN5Ia7PHi7FiC6UhCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qtxBa4TN; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qtxBa4TN"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-132d5ad9c32so7974575c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 09:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778776474; x=1779381274; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r68S8jxOjdQsq88pAcfrL0Nqp+mR1s52o0SNFT5DPPA=;
        b=qtxBa4TNUD9OyR2rF246snAMNlGr05/E3aBo3BcFNvyl/Ui5IUv8MdP+kUXGvBs0Af
         CjThkou0ANwhChcu4SkD+Ea5ZYgYx/rjneiRjIs1jm0+ZtXj8bU1iWMXlVlyHod7FpW7
         fQW/rLLxkRpXHBbOSStRBJ9k0f9Tr7qkj9bN3q8t02zQ7e39CrpSUibNe3pZp0sHchy8
         h5BQubEJqjnDzZywe2rVBaudW7Mcgx2oUZAN+ueHy9BvlsvlXIsWT++Mu3Q0lqBBXO28
         Dfq+AxPgfP1ww8xeTX6PEsRJSgV+XsYRPHjugGWrWwx/XohlaFzRAIWnwUZIfBWfjsKz
         rkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778776474; x=1779381274;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r68S8jxOjdQsq88pAcfrL0Nqp+mR1s52o0SNFT5DPPA=;
        b=k3qNKXhxsyOXBDm4F0yadwCkvIFSv5LEYBzkcJmsyds0btTE3mmpQYzCNsiWcq0fA+
         BUKdv//duA8LvFB1FdiAMlHRusJFUCfDOfwAv/ZpGzqHEI+BYef+BdKLuF2u99Nc8X3J
         f+CyYubkLvOS5zdVBQ/hMXXttEDUSwLsmBWdrJwEpl9VKPnyU0szb+eSPk3Ik9FdPWvS
         2S/0vBIX/Io0gMvpAkPezahznOLHuMjwwWBah77B9q4uS7E2sY2gK1DFcIrxgZ8V+D1h
         7rD1ps4zRHnNJ86REhQouL2h9YRbmBoNwLpstXESqzBl7Qd13wpXPUCk0g9eRAEaItP4
         93UQ==
X-Forwarded-Encrypted: i=1; AFNElJ9lE9NrNuu/xPPlbW24+ZJJN8MoXP3O2jKgHpVDW9QQ+s8A8w8TmEylDAxf5qRZYPTciCYVjndpBmYH38a9G/aY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/5g/bKO6cxmQSbSWglyndsOhL+XEk42cPErJTB4AZEyd5lvyo
	EPdtnY3b5tGaDvjORZF4Ed4et7d98PzG1d+1S1NemZjekhOnKIxrhZJwmIy6DCbXHeF8igApZy3
	fI/odytNo7g==
X-Received: from dlbdz8.prod.google.com ([2002:a05:7022:ec8:b0:12c:8bfc:84e3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ea2b:b0:133:1cfe:5120
 with SMTP id a92af1059eb24-1342ee3a1f0mr5673761c88.7.1778776473729; Thu, 14
 May 2026 09:34:33 -0700 (PDT)
Date: Thu, 14 May 2026 09:33:58 -0700
In-Reply-To: <20260514163409.927816-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512174638.120445-1-irogers@google.com> <20260514163409.927816-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514163409.927816-7-irogers@google.com>
Subject: [PATCH v3 06/17] perf build: Remove empty archheaders target
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, james.clark@linaro.org, 
	namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, andrii@kernel.org, ankur.a.arora@oracle.com, 
	aou@eecs.berkeley.edu, bpf@vger.kernel.org, collin.funk1@gmail.com, 
	costa.shul@redhat.com, daniel@iogearbox.net, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	mingo@redhat.com, mmayer@broadcom.com, nathan@kernel.org, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, qmo@kernel.org, ricky.ringler@proton.me, 
	song@kernel.org, swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
	thomas.falcon@intel.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Remove empty target that doesn't do anything.

Tested-by: James Clark <james.clark@linaro.org>
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

