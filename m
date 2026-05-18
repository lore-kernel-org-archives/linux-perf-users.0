Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F080F2D592C
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 15:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779119232; cv=none; b=NJAdh9Csu+ydHUsnNnEtF/vLIgPsd2rvRwufZsQGYcVf0cMccuu0HxfDX5QYzaVBGyDcgfUlrakeFsgkrzP3HT5Nlq16+idMe97V2HHpEIaFDP5p0YGzidsmCEpRhVwlT9ce6tya4Y4rRBi7pDFPiP/FPtpV3oQjEhlMuuTqnc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779119232; c=relaxed/simple;
	bh=lKi589raivhsbwyLaj9XtBtQSUnfs3hz++4WpPhAN6I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vymn/bEeaCekiIsrjX1tAf59xTDBCxFEqbTVicxzgS9ZSBPapr/rdVnVLNmZ8ec6eybRFuDnpSBUf3QIS/XI+Zr4rF5lx6di9P1tLREZVlBEvtNpBUHzq0yWE0HtXL7zpOEsMa2gUXYvVBNJEkAVNofvOiZ7ErJrpvvoKW2QeY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tQfDQYF6; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tQfDQYF6"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-303b38ec2f6so3272302eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 08:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779119224; x=1779724024; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JU72sTCFhIbrBstza304DuXmMup6ne4nbZZzxxUn+Wk=;
        b=tQfDQYF6uVhSITmnFhm0k9b8w9og63+p3oU4GXvD3X+XtAh7GyRxJi8ru737j/Jfma
         iqvtRL3gskfQJhEJY74phE7TVjuKcZ+I20cSkguK42SL9fV9WUifi5Kbi7cGWVZPKWW9
         CGXe1XQ9xGKdFaEhnhTYKIW2+NYFbzlhjTgo4ti3bcUsL8Rx3F4QR3r+poQDqs/ZtM6x
         Rt9UvsW///RptG5kfVu+MS/75fcD21DZPKTKLDOqql1JNoC+N0iie+4e/tuFNEXglF25
         yB/PebwC1w1rslq10hvtXcKF3XH6ZDpBgU8/PLwKGRiT4YGqvToYTESGLie2T8M20r4O
         jfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779119224; x=1779724024;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JU72sTCFhIbrBstza304DuXmMup6ne4nbZZzxxUn+Wk=;
        b=jTkTiiDQifzugE2syHKnkgi7sxzMwZhm1qGggO6i7GI6LbpS/nFnM54bb0AiF94iS+
         n+sMcBQx/GNnKYADFmGjVOg012RyimMOYcKc+FuDpnrpoBethMN8itQt4GbwfecgSph1
         hobvKQw0AKzJ6RO4GiuoAAEmFAAG+MNRVMhmzdJxyMmePE9nn1w971DlPVH50rPuiFmx
         3aprBmDti+8wHMsXw8888+sjT9O5n8mhbIhzpPm6sfjtcnBtLtDlAoxe4PRGPEVwcZW4
         et9tpWnuk252E6I2F8nolsO/9fDU542ue4D0kCUZR3g2VUDWlGm2w/k3mn05aafwEQof
         K07Q==
X-Forwarded-Encrypted: i=1; AFNElJ/aC29uXoD+AZ6M8WI8AMc4PU3Av8+vYzk0p5d6AhDlzryp/BbLdsO1IG3pg1nXKIuBVxsEZyxnaS7cn6eoMaO9@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Soe7rcv6GC0O0TlhoiNUgilD3YMPC44XiruIO9taw3PUyBgS
	6owM6PaOZq8dH1BwJ0ABh9d+CmASMu7uo9IyHZtel8B+AGLUpDf0Honfmv9cs2O4XlFq2ezOxP5
	0YnxZZSuJTg==
X-Received: from dycju19.prod.google.com ([2002:a05:7301:fa13:b0:2fd:7d41:249d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:644c:b0:2ed:e12:376b
 with SMTP id 5a478bee46e88-303986b14d3mr7248330eec.33.1779119223501; Mon, 18
 May 2026 08:47:03 -0700 (PDT)
Date: Mon, 18 May 2026 08:46:33 -0700
In-Reply-To: <20260518154638.2798789-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518044740.2526802-1-irogers@google.com> <20260518154638.2798789-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518154638.2798789-10-irogers@google.com>
Subject: [PATCH v7 09/14] perf build: Remove redundant libbpf feature check
 for static builds
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, andrii@kernel.org, ankur.a.arora@oracle.com, 
	aou@eecs.berkeley.edu, bpf@vger.kernel.org, collin.funk1@gmail.com, 
	costa.shul@redhat.com, daniel@iogearbox.net, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, mingo@redhat.com, mmayer@broadcom.com, 
	nathan@kernel.org, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	qmo@kernel.org, ricky.ringler@proton.me, song@kernel.org, 
	swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
	thomas.falcon@intel.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

By default, the perf tool compiles and statically links against its own
internal copy of libbpf (tools/lib/bpf/libbpf.a), setting LIBBPF_STATIC=1.

Despite this static linkage, Makefile.config unconditionally executed
$(call feature_check,libbpf), which forced a synchronous sub-make fork
during AST parsing to detect dynamic system libbpf libraries.

As noted in the internal Makefile comments, this check was executed purely
so that running `make VF=1` would display the detection status of system
libbpf. During standard builds without LIBBPF_DYNAMIC=1, the detection
result was entirely ignored.

Wrap the libbpf feature check inside LIBBPF_DYNAMIC=1 so Make avoids the
redundant sub-make fork overhead during standard static builds.

Tested-by: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 8437c3f72125..26de7528d6ce 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -575,10 +575,8 @@ ifndef NO_LIBELF
 
   ifndef NO_LIBBPF
     ifeq ($(feature-bpf), 1)
-      # detecting libbpf without LIBBPF_DYNAMIC, so make VF=1 shows libbpf detection status
-      $(call feature_check,libbpf)
-
       ifdef LIBBPF_DYNAMIC
+        $(call feature_check,libbpf)
         ifeq ($(feature-libbpf), 1)
           EXTLIBS += -lbpf
           CFLAGS += -DHAVE_LIBBPF_SUPPORT
-- 
2.54.0.563.g4f69b47b94-goog

