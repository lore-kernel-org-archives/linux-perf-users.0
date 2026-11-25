Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795587385;
	b=PZFOj6QnLOBwzXGJYqFkrzWUT48eNziIqQlyukXEbtBa4aqIYx8NZVbUs294TgmvmVDY
	 kkd/Y9tkGKfigq19iqyDVBAxT24ypdQE6kl1uMp3Njc18hOhIKd8QoiAVMwCU+AK3uzIb
	 jEYK1CdNSjiU4K20ryW3BO+OKbGGiwHYaXyvV7ObUBFQKPhs3TeCgpPmf/yN/wam7KetI
	 zm/4VJePSanDUsz8uZ6YiywuGCds+hLcjasmibXPc2FoXQpnGSucSUVE7GPxx1BeJ3a2+
	 yTeTzCgowSkIi/sYqv4Miure+0M6Unh51yUMUUCtWia5isuLNRMyT3IjIBNZ2+u6ArQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795587385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=8IYxPCQoD7cmdiQr4ia+kH+yRcXKtjpnJvYpxZTFR9g=;
	b=d+sM1AdFlWwnq34g+D0HfP3q1OKZMRH/KJKyPEVEDG0xgVLv6chlaFv95uMCg0k3KNqI
	 5AND7graKk5HnPmeohctiYiV0TlzWvXmeTBMVA44QlsauoWhGL137Bx4xnf7gXzIYDxaU
	 DM0G28uqfez/xSUucpcqumKnP7jYVmVZUjyIT0cP0W0Q7fkYgmgdLE+J+AUFtqcOInNK+
	 c2kNS8FOZZQJ1Tm5+wXRGtoU1goLw5bWG+SgFJcrGwc2FghwIk2HhaaGbZ+cscOmA3AwW
	 SUTDhNb/3VsWmn+oXfm/rOOivVjWOmZkdmXM4dPClgR2LGzbOmBGhQRNFKQvrTsYXQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y2V8nA2f;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD9860A6F56
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 06:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBD9860A6F56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y2V8nA2f
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33713e5e6daso9193475eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 22:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795587383; x=1796192183; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8IYxPCQoD7cmdiQr4ia+kH+yRcXKtjpnJvYpxZTFR9g=;
        b=Y2V8nA2ffutoi+r2jF8rX+fCyb/bIC2jJEz/osEvIZf7kV69rVMgrWq4qHlDTUTh96
         UxGNQqHnfG7PJMTr1DZqUUFvAGuVce0+GfD6J/0oq/XSeiJ2ZLfNx7KWsCFuO8pZOiZu
         dJDOfIoXt6snvKHnUqAwblWEZndvROGPo5Gz7B0KmjCGKFHXb1/tuZEcfojG9g4mHpMo
         DJnJtsJPBA8kfPrxpf7YEL7y55ge6yKjYSy5ikAS22rIIz+FEJVNz7c+W9+n9p0GUMTU
         2FEL6+kEqplNwPAgXRgfW/WTHL7VXZ4qoo+KmIgaA7vfOLbQBaCbf0bAwxVlOr4nsgRL
         5lOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795587383; x=1796192183;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8IYxPCQoD7cmdiQr4ia+kH+yRcXKtjpnJvYpxZTFR9g=;
        b=IHqJfyyFLjAxndoiyoERadOp/qJrBvkMF9v7vrYlv+oFYq6Thsx3V0YzkBBj9igcMc
         1a7SPPERhEx+Yh6y82SenNopYed7MMDINyeA+tS13gkNkyuEGYYJvulBEoRRt490VAQZ
         OLcOET2HA78naitT8ZuVlw83ms83Od+BJLlFlVCRrRveJd3kMDy2fT2ca/4Sa7k1eabB
         utphKoemixUMllMNDC2XSUttxw3C9xOszh3Ztz5sVuPLYALYEslu4Etbhqi3xqKAmH2v
         kZW0XKrJHCTeTIwEoF1QdnVgsVyvtjiSt6bj0FcGjnzLJjZsQHkRCvghNlApz42oilEd
         VdXw==
X-Forwarded-Encrypted: i=1; AL+hErGHjpdOQXeozcqZhdSA9mtG439YhHsWLT+TVO5rAcNEYnBhf5msyEpIw0DgHf+QxgCo5nHnBRSqWVv+4wWtfz1B@vger.kernel.org
X-Gm-Message-State: APuU4Z/tnnJ9uUdtowP0+Af9wOZOM7bcyM/Pcgq3P6rCtG9z1StJ/hbB
	CKkTcVXgtnfvYyKeP/cc+//QDH2XgM4ypn1Wa8rc5PRekGDVKcBB2YCd6b9+/k1g7Ngfe5QyqjD
	ys6d52W9/6Q==
X-Received: from dycmb10-n1.prod.google.com ([2002:a05:693c:20ca:10b0:386:c377:5335])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e91e:b0:384:2780:8757
 with SMTP id 5a478bee46e88-38570a3e793mr19421900eec.22.1795587382798; Tue, 24
 Nov 2026 22:16:22 -0800 (PST)
Date: Tue, 24 Nov 2026 22:15:06 -0800
In-Reply-To: <20261125061523.1540234-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125061523.1540234-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125061523.1540234-14-irogers@google.com>
Subject: [RFC PATCH v2 13/30] lib/Kconfig.debug: Allow LATENCYTOP and
 fault-injection filter with DWARF CFI
From: Ian Rogers <irogers@google.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org
Cc: jpoimboe@kernel.org, rostedt@goodmis.org, peterz@infradead.org, 
	mingo@redhat.com, tglx@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, acme@kernel.org, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, mhiramat@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, 
	nathan@kernel.org, llvm@lists.linux.dev, nsc@kernel.org, 
	linux-kbuild@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, ardb@kernel.org, linux-efi@vger.kernel.org, 
	maz@kernel.org, oupton@kernel.org, kvmarm@lists.linux.dev, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, indu.bhagat@oracle.com, jremus@linux.ibm.com, 
	wnliu@google.com, dylanbhatch@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Allow CONFIG_LATENCYTOP and CONFIG_FAULT_INJECTION_STACKTRACE_FILTER to
be enabled on architectures using CONFIG_UNWINDER_DWARF_CFI with
-fomit-frame-pointer (such as arm64 and riscv).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 lib/Kconfig.debug | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2d22638ec13a..650ed105860d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1893,7 +1893,7 @@ config LATENCYTOP
 	depends on DEBUG_KERNEL
 	depends on STACKTRACE_SUPPORT
 	depends on PROC_FS
-	depends on FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86
+	depends on FRAME_POINTER || UNWINDER_DWARF_CFI || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86
 	select KALLSYMS
 	select KALLSYMS_ALL
 	select STACKTRACE
@@ -2188,7 +2188,7 @@ config FAULT_INJECTION_STACKTRACE_FILTER
 	depends on FAULT_INJECTION
 	depends on (FAULT_INJECTION_DEBUG_FS || FAULT_INJECTION_CONFIGFS) && STACKTRACE_SUPPORT
 	select STACKTRACE
-	depends on FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86
+	depends on FRAME_POINTER || UNWINDER_DWARF_CFI || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86
 	help
 	  Provide stacktrace filter for fault-injection capabilities
 
-- 
2.56.1.831.g720f3f5937-goog

