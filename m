Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A753470830;
	Wed, 18 Mar 2026 18:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773859848; cv=none; b=k9qc1o54+6gC0lIdXEJnEoxE4V/i2Xv8n9nsBFwpFnPttoGJpbD3RChlk0AYZ2IxNOmBO/8oUWj0NxTXkKRlUL4k9DLPzp44vOOH4DcpYsU9rF/BVbfZdeVt9D6VQWnsh9LrX5yi++lAktHdnReIN9iV60/Wb+jpJWS0DVj+R2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773859848; c=relaxed/simple;
	bh=p0OvOX5i56H0VbVf//CwGB/CadnwRAJSDyXx7UEXOAw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Dm+z83AX/uYJSb8X5pvnlbH24otMCXSm9rjMlIfPt5fPDYG5G9JskMefYKiFtrS2/ySWtbCmjR72qv2s3QQnhMrtN9Vh5AeQ0/y4QjrMRLL4c2kxASLziXpRZi/pFtJ+emgkxZMzt0W/CvFUQh+ArMJsXlfSSjfnHKBtyqen0OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gm8x3Vrq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gm8x3Vrq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA9DC19421;
	Wed, 18 Mar 2026 18:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773859848;
	bh=p0OvOX5i56H0VbVf//CwGB/CadnwRAJSDyXx7UEXOAw=;
	h=Date:From:To:Cc:Subject:From;
	b=gm8x3VrqoTt7vBH3anbV59inyX6MVCboTlSB22P6msV0X2HYW++vTF/0v5Y0myi2R
	 oWinHK4lvptjNACJD1yHtQI4t0CJxoLb/N3t6JnZN84SbSyHc0k9+W6UFH/ezW/6yK
	 gfVdxuyvNaHdn+CO2Fa8bCn6pSSfwYarNJz7AFf6l+fZO47oIrKiCb9cMASPryjeaT
	 yBIMgYvf+rU9uRk+juUp59sTDAHxA8+fpTlu0O/Xl/U3lbv63Qco2SuOrilAWRQC3y
	 7PMPXNL7u2Aeuzal8OXTIUWIQi3uDt+trIKy1EoBwrUQgB9fRcNCfk19/t0HJpwlwl
	 v7dm7NGzbr+nQ==
Date: Wed, 18 Mar 2026 15:50:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1 fyi] tools headers UAPI: Sync x86's asm/kvm.h with the
 kernel sources
Message-ID: <abr0BF9jG3NRFJEP@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tldr; Just FYI, I'm carrying this on the perf tools tree.

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

See further details at:

 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/include/uapi/README

To pick the changes in:

  e2ffe85b6d2bb778 ("KVM: x86: Introduce KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM")

That just rebuilds kvm-stat.c on x86, no change in functionality.

This silences these perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm.h

Please see tools/include/uapi/README for further details.

Cc: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/uapi/asm/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index 846a63215ce14b43..0d4538fa6c31abf3 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -476,6 +476,7 @@ struct kvm_sync_regs {
 #define KVM_X86_QUIRK_SLOT_ZAP_ALL		(1 << 7)
 #define KVM_X86_QUIRK_STUFF_FEATURE_MSRS	(1 << 8)
 #define KVM_X86_QUIRK_IGNORE_GUEST_PAT		(1 << 9)
+#define KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM (1 << 10)
 
 #define KVM_STATE_NESTED_FORMAT_VMX	0
 #define KVM_STATE_NESTED_FORMAT_SVM	1
-- 
2.53.0

