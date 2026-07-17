Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECBA3FBEBC
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784293366; cv=none; b=l2R8IwnWVvM7ls2+sxDcHoW5ghAjDOxIsjAZSUpdNcb6CiSbe3BYTz5e9ayCMe8fgFxm8uXvpSelkrnhs2P+VtNvujo66KB2Q89HWq2Ebr9TAu8kdibn+aT38V+vuSowdoPr1f5Cl9H34lQLnEiqhAr+qg16YWkHpSdyMI0X2Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784293366; c=relaxed/simple;
	bh=PlLf3uatOB4V7qqPGolTM2wzfx6QOLYYVgfstlgW/F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YsPkKygnphyQeou5YWi1+oo/bN6OrT8ZnAbByd6Mj2F9XIkVV/y9dIe3IJPfh7uTQQmpfyabvM1JskbJpszsUzxeKKH+/LMb1YvtETZX+WP3D7mujmMPTUJQc02O2UzkRq1KzlSBbGP6Q0y5ibbslDTWZUk3KSMThxWEffSwCL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pV8RY9KL; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pV8RY9KL"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9fe3c9bd5fso999306a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 06:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784293365; x=1784898165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/HcjDBHsn65ZCZzOohF40VNQnTu2vZZX71z4vh7Fe7A=;
        b=pV8RY9KL5NRyhBdnkl8IhflMe9EB9vB18xcJdNOZOzs5/28McoDBlIreED8PiraNl3
         icWwx+gQYviKkZd21TqwHoP+bSrbsb3vuXqR1qssn/T5DfmSHm5V5LOQl4SFRj4SxuoU
         88+KfXf//S88mNSOGQW462CKES+QGc4kBiWNjLBpUhVZk5oRs8NBGAmFyQJvqoUF7puR
         J298s1Xg/px1lAHTjezol7Blq9gng0HEFsxox/x+m6ptq/OAY0sfEWcFLJ3kLEjDrEtU
         QJVV8m1mKlUwuOVD7RGoQ7dJC7ruqNXR9Da+eOjHvH4nCvffbaiacf5LCdEc8v4CTNhP
         GMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784293365; x=1784898165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/HcjDBHsn65ZCZzOohF40VNQnTu2vZZX71z4vh7Fe7A=;
        b=STcbqPdflJQtnfxIqXcamiJQoDGfxqW4TPPlvenMZHTUJOxoT3OG84XVLf0bER4hNs
         IZ76JtmhaWNfGzofJaOhnDepB9MNsxQHeUSW3hrjNtqs9ZLmQjjm+A/6if5Xd8wwPVHb
         jCgtAJoMeNYUg1w+oKlcSUMZL+8jAOByALtMQTIz8VWVqkppy+KCz+Id1pCFpMmAneus
         hO1VUiFvKJURgSU0Ur6tutw3r+D6fHQHZ03YeiV7T88AJ/4te9bFLc2MlhAwf1IqfTw7
         bSsJaGg7lX42yNu67Oy5r7CSL38WnPEB2XdmWVuVPqS08NgVA7xSQXSD2WhT5gY8O0xm
         xBpg==
X-Forwarded-Encrypted: i=1; AHgh+Rosp37Fw1fszbfclYWu3D1lE/k5cEd5e9R9xh7N+fqrgCVY1UztQaMAO+wQ+8j6h6DAvt+hRtJA7XJ8HkzS5AgI@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlc8cFEbKFqKMzLvLjxPA4kMM2xzKDQEa0/gAZXXxOBN5l4rHR
	ws3SrqLaM6m0rYpdUU+mL7upTZIQjX8fJl8BdxjHWC379svHV2aUvcbi
X-Gm-Gg: AfdE7ckzrHv474EbZ5XcG9QysxDCEHAmwC9/Ae9dJntXHABnYBNGRbbYm5CmZvJvKk6
	1VHalML4/kpPnlqBIn+Y2qfBvOACWRLia71QpSu82zS7msTcWNbcgKxp+QiLvFhugu63LEBMR6a
	MFqNYeHGRDvPz3WEZ/9jYZcQtuUUZQMLn+IfYYFgRUYWatQBkU5ZKOgOz97u5Xz/0lOpGB2I2vA
	zKDD9grJhmfzFgQ1I8G1PAHEv1QUjtCl6PGHbJcX49wIq2B/J86pZS2rBYL8QCOkfVTTUIBgeCp
	PGwrEGBYRJOsqIdqexFTQhbVEbDs/9/nfVylzg7HDrICxsQgfjNnzS4RNcBGB/EjRq8cq5M8c5o
	IlTV59pO+apffJaoilBeJSEtzF0DaXpx9bVAAIskshShf9mm9coiYzt3sNmpJHnMPU4FQpfP93w
	xJPA==
X-Received: by 2002:a17:90b:4e85:b0:380:86d8:8162 with SMTP id 98e67ed59e1d1-38e3d299be4mr7567812a91.18.1784293364383;
        Fri, 17 Jul 2026 06:02:44 -0700 (PDT)
Received: from localhost ([144.24.58.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1de301sm7390369eec.24.2026.07.17.06.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:02:42 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <willy@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH v2 01/13] arch: add HAVE_REINSTALL_HW_BREAKPOINT
Date: Fri, 17 Jul 2026 09:02:27 -0400
Message-ID: <20260717130227.1901488-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717125023.1895892-1-wangjinchao600@gmail.com>
References: <20260717125023.1895892-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some architectures can update the address, length or type of an
installed hardware breakpoint in place, without releasing and
re-reserving its slot. Add an opt-in Kconfig symbol so generic code
can offer such an operation on architectures that implement
arch_reinstall_hw_breakpoint().

This is a prerequisite for KWatch, which re-points preallocated
per-CPU breakpoints from atomic context, where the register/release
path (which may sleep and rebalances slot constraints) cannot be
used.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 arch/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index fa7507ac8e13..41b3784e0ddd 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -457,6 +457,16 @@ config HAVE_MIXED_BREAKPOINTS_REGS
 	  Select this option if your arch implements breakpoints under the
 	  latter fashion.
 
+config HAVE_REINSTALL_HW_BREAKPOINT
+	bool
+	depends on HAVE_HW_BREAKPOINT
+	help
+	  Depending on the arch implementation of hardware breakpoints,
+	  some of them are able to update the breakpoint configuration
+	  without release and reserve the hardware breakpoint register.
+	  What configuration is able to update depends on hardware and
+	  software implementation.
+
 config HAVE_USER_RETURN_NOTIFIER
 	bool
 
-- 
2.53.0

