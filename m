Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795052304;
	b=njezX2kN29Lf4ZftnTW12nEUEHEzTWOuey2FCqOwqVikKtRhnrf+7g4P9QpDEh9w23t4
	 BbqyKa5VVH5pvNLClpq4GP+2v4UMeJbzy+vF8zd78dtN/omIkuoFHuAeMeKVp+LKzFC2K
	 MGb/EB5X1KOq9j3okwbdxV87MoPa9ypoqWJzwKfIdterCDDNoiYxZ4WrXWq/dzAI9/nam
	 2XmZBhcl9CIgZ8D98rRx1seqHh7Htrg0jcd5IpcDjSIGlck4O5LM2TGAFaM5tm50vyh/f
	 UlwuvUMjOhbtB+0yjiWXV/LlxjVLhRvPmf9R1ZWAKP8cwYDDN1HPan1mIl+ZQlxkX2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795052304;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=EISx+aUN2h8+Y5wGuLkSbChaUhZOj0j975QB4nl6i2Q=;
	b=OLSUlKPPI1QiwSha61ceYVh1lHkl3bhuxeeYJwV64O6vw5HvbaQtFkpxo0k7TYwTepx9
	 M0uW4vUjB4bddTcbYfaofVIC6D3un8ymoMQSgHWDBBIU/OVs3BmkKZBpwYDbekltEUEiv
	 j8ErwD5i5QPY7YRDD4zcZFDzewp/9W7p87wzi0kNEQesoOx4/6j9pb4paNc1YEm2DauP+
	 1avaSKi6HWlZ/aE1Z57Q1ZSAxm2qZtALea785qvPYrqWw7megzu5r3i807Z8wKgJgVZRx
	 trkA/8jwaVj60UgF4xF5elmlhulRGNrXDzTDfWGFt3beUlF7bkCgI+S5UcXlLz/OGvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hYxbWfXv;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63F7606A331
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 01:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C63F7606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hYxbWfXv
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cdb15cd8558so1042601a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 17:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795052303; x=1795657103; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EISx+aUN2h8+Y5wGuLkSbChaUhZOj0j975QB4nl6i2Q=;
        b=hYxbWfXvJ6ud+jAQmE7BAwtWAQsm0YQ5MB/3jHgNtwVyCeGJaHuRdKjKEpkEDf+4Vy
         2wOvLl91USwMMQ3ILsmBrnBPXmCqDdApOFUKhuGcNAdkNhC7DvOLDdZNbZULuJsEVYc2
         lDNdOPFKUmTvLw8DrN2WD7B0N36RY4LW6Q3tQ+EZBFBDuvG1ZHBKHXbSSE7SMZA5abjr
         Qein5V9+Gx3pyZ3TMjPuz/gNXAFFJOlrzfmBm8r+iplCQXpg2VY32j2u179MXh3DPOqz
         JLKwJkhuetD8OOcyHmotTHfgrH9Ebx7IdqimtrSQFNNyq0KgjbM9T4LefnnjxUC61zsm
         Q6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795052303; x=1795657103;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EISx+aUN2h8+Y5wGuLkSbChaUhZOj0j975QB4nl6i2Q=;
        b=1ILsgifjgEdYFehIafdvgaIetDPxvhNq3QwWvTk3TlmFye3kxqhvYyGlLkXydUO/sh
         D8xVbmWmV+3/aDclXzBRokIBTVpzUdojuQrhNDDaJYTPZ1XoRACpy0Gc4gzs0rjaQc/P
         /y9fi/hm908DSD4gitUiMIHW0CJSH3R/Oc7MxmNT863tOwG9FkXQJYrQ28UCgHPB/Vma
         NUw+jW7zVoMuk8HAp2B/i6OMPJ3JS62otah13dTmIjgWTuiD9G0kY8Byv8R1mUw9z8F6
         ckEVaPgUrFW3q8k8OQd08IXkImLc4qouIx1upovvlWeIvrJRmJ68JPnfYe8OTH5h/w9l
         NuhA==
X-Forwarded-Encrypted: i=1; AL+hErGRMIcN+LWo+eJ104Zl3Kc4TjtvaQOcb8K7naplLHvHKV3YrCv8X7giiTiaTJKhET8L/eKCvqJC/vc3i27htTU4@vger.kernel.org
X-Gm-Message-State: APuU4Z9m79w36hD1W/c+erbQ6XaS744xuGCaQfq88QFPNkTWIUieDvvB
	SHJiH8oC51KuQS8rznYgr0FGd0LpyJpd0HL1JFaaL8v0drf42E2+I+LE
X-Gm-Gg: AZFdTZccUz2hYcQNZUZ2qqdsk+Mv2cNi0QvFGLZap3Zp5FzfEL0ASXpFcIdtfp0905p
	uTKemu1aszqinZHJfYnzI+z77k7hLKpy3MPL8HLNdMzPT5V7QDhNzx86soc6zPnpaVAp76l4Q9a
	ttqsHmppelu6hDyeFsTUtBh3U5V1VpexsloQU/1wJFiGtiN0x1C34YiupAIrOxMtmtTocXm6vBm
	n28gFfUP3gunaD9xSvolWgjlXa9bvmLFtesaXlBZBJbdN8EVRsxfD185NgWSqugKbRCt7QnEYOl
	Tl2feXsf+SkTTFKia+grneEhMdV3MV02Q+7DtY8MaN+4fSZmL/vRMS1u2FFSHBPV2kyLcYPvQ9M
	F9apcaqJfadWqEqGrAAyDFINmIQcIMs6DvI1vCu79xj+9WG/u3A662t0weXjyCPXZGWMdbEU3ng
	iHCe2acUL/7wdigG1qk4TgX7Qfe8b1+dMzflyFy26dzVcn5C3NE5WfKxrkh4cEA5oCuuLJv6etq
	pGnuEzZRPWgRUiU2vLUZjBbpbjrirIf0YMYRWYsqLU96uGiIlX3FCxiNtbJDqZ/BZ9BcHubKw7u
	J8wkezeB9jxZ+dj5W/FrrbBw7QBnwyaEz9nrVmE6uBrIU+Qiq74spVQM67fH3N5aQ7gEAQI67gy
	RGpUkp40I6Hd0KALIH0hCbJ1sGnPkuuQh9Q==
X-Received: by 2002:a17:90b:2890:b0:3ab:5832:72af with SMTP id 98e67ed59e1d1-3b3d07b99a8mr3639797a91.32.1795052302815;
        Wed, 18 Nov 2026 17:38:22 -0800 (PST)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3fe0b62e7sm685981a91.11.2026.11.18.17.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 17:38:22 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 01:38:22 +0000
Message-Id: <DMYSXNCMOF26.38XGLPOW4K29X@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Andrii Nakryiko" <andrii@kernel.org>, <bpf@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Cc: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
 <linux-perf-users@vger.kernel.org>, <peterz@infradead.org>,
 <jolsa@kernel.org>, <rostedt@goodmis.org>
Subject: Re: [PATCH bpf-next v2 1/3] arm64: perf: Don't report the caller
 twice in caller-regs callchains
In-Reply-To: <20261119000112.2377949-2-andrii@kernel.org>
References: <20261119000112.2377949-1-andrii@kernel.org> <20261119000112.2377949-2-andrii@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Nov 18, 2026 at 04:01 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> Do the same on arm64. Set pstate to PSR_MODE_EL1t, which exceptions
> taken from the kernel never have (the kernel runs in EL1h, or EL2h
> with VHE), and skip the leaf regs->pc in perf_callchain_kernel() for
> regs with that mode. The unwind still starts from regs, with the frame
> record at x29 walked by the unwinder.

my bot thinks the following will be a more accurate fix...

diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index ee45b4e..7c5ab65 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -13,11 +13,12 @@
 #define perf_arch_bpf_user_pt_regs(regs) &regs->user_regs
 #endif
 
+/* PSR_MODE_EL1t marks these regs for kunwind_stack_walk() */
 #define perf_arch_fetch_caller_regs(regs, __ip) { \
 	(regs)->pc = (__ip);    \
 	(regs)->regs[29] = (unsigned long) __builtin_frame_address(0); \
 	(regs)->sp = current_stack_pointer; \
-	(regs)->pstate = PSR_MODE_EL1h;	\
+	(regs)->pstate = PSR_MODE_EL1t;	\
 }
 
 #endif
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 3ebcf8c..de394ff 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -357,6 +357,13 @@ kunwind_stack_walk(kunwind_consume_fn consume_state,
 		if (task != current)
 			return -EINVAL;
 		kunwind_init_from_regs(&state, regs);
+		/*
+		 * With perf_arch_fetch_caller_regs() the PC is a copy of the
+		 * LR in the frame record at FP. Start from that record.
+		 */
+		if (processor_mode(regs) == PSR_MODE_EL1t &&
+		    kunwind_next(&state))
+			return -EINVAL;
 	} else if (task == current) {
 		kunwind_init_from_caller(&state);
 	} else {

