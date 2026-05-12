Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB854D98E3
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 17:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608019; cv=none; b=kewp6oVUmI0RhRmRrkTtJBSyoT/Hd7soHzJ7cWTniU3pgdLb8h9yxL0BROrrkjpiOINildMvieIQbzHLeDaR6084RyGnyBrkXeTPL2ruybbyZuSOddqUbtMGGXxtwPO6bzGKzpv7c9pBVFhnVhmrjeCKrPBM1I2KepJ248TDXUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608019; c=relaxed/simple;
	bh=3q0g8O0ztwV+78aFp8RPw4sh9x5Uyk5RGK7knh3apw8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lsDzSIv0PRd7eFBIAJ4vCZ0vF3lRSq+mGSfhh4Ns39p9SdXhAwThQFLq1m6uvpTK9dNL6ZAY4Ki4YDhBkQ0MtO06xBkTI+pN3EKkIn4mUAUfwJvbnjgmIFcWn92IzW6YqLp9JiPOXzAkE0QwBfJThPaBIu9d5+IOGdqP0xCjI1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wb21vXsI; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wb21vXsI"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2f3ec2e8d07so10448164eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 10:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778608017; x=1779212817; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nTNOVWRvce3lC7h3emxjjZvlJvb7j/kAaYdkg8DKpPI=;
        b=wb21vXsIja4rjwH3QC2n5QDhNuEyNTz4mESpAiOQx87m+H6XdrdX8zQZQz03jF852L
         zcqOviopaJ7e87dnycBkLlLZTsXEQuPSkK6sNcLdwD+Mh1csiD6lgyF95iZCfmBgE936
         i4LDhQK9xto+yggWkkql9vuFbtje68krKniUDdaXkzlJNyDkliNoc5LQXaEZQJiAP2AC
         1LqeeNHrjBZ/Gg1hWfAHt0BXbISB/tEv0d8sxElzVGrBL6l2JMJMOc/9fLWhvb6khCFi
         EA9MBAzV+MNVsMHul132jA087gk81PXzplz/GUm9U8NJ7qiFs73NXrK8A2+9LH5apkat
         ooJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778608017; x=1779212817;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nTNOVWRvce3lC7h3emxjjZvlJvb7j/kAaYdkg8DKpPI=;
        b=eRelB4f/1rRuZ6mijuPv0zPeL0w0/Xf0bFp0oC3sQddSaHXxyFjV0a+U4ol3G1Ndxa
         urXrg80I/FZN8tQZFlU7+bf3tjfMu2/19ekE1eOR8AxehDlRTbf2e4aHco2Xu2Mpt2I5
         MIFGL8C5SOXsE7hPJDSpXSq+DtqtiaB4RjUPS7zXhe8u2NyuowE8ope7j5zA054Faqoq
         VfNpqjs5zyt6+xHDqkgNa7Oy4bpESujFxMk6Mtf7OV3HVnMjhQoE6Ed6KfRUG1mwdXqH
         yZCO2wJhqFGVs2eUIOjezZSg8UitC3gMWnjPB04M1ZmhAXDs5bjYEbQjcxKtmTGmDI0h
         fOXg==
X-Forwarded-Encrypted: i=1; AFNElJ8w36f6mx5LQBFWdNtgVdXIyU70JqkJXSSpfBIJgLcBRyYXRTeyyrfAU9Hr3Bv8M3cB0xEqGXc2W1NUfVkmsSOl@vger.kernel.org
X-Gm-Message-State: AOJu0Yzonpu/+1JeIXTGFKRGaIZgh+k7l0YUmrJDvGDOVLC+d3HLTB/K
	/aAztD5H0qw8RoPmZmsBBAH1Oi5G1DgXf5tiCpb+Y00ugkibQLAlvhsZeaM80Q1d416eVmyczyd
	KQ9BwUgmmqg==
X-Received: from dydr14.prod.google.com ([2002:a05:7300:50ee:b0:2ca:9b08:e7c9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e105:b0:2f2:6dde:df67
 with SMTP id 5a478bee46e88-30118e9ff09mr51836eec.22.1778608016683; Tue, 12
 May 2026 10:46:56 -0700 (PDT)
Date: Tue, 12 May 2026 10:46:23 -0700
In-Reply-To: <20260512174638.120445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512053539.3410189-15-irogers@google.com> <20260512174638.120445-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512174638.120445-4-irogers@google.com>
Subject: [PATCH v2 03/18] tools build: Fix test-clang-bpf-co-re.bin to
 generate target file
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

In tools/build/feature/Makefile, the test-clang-bpf-co-re.bin feature check
compiled test-clang-bpf-co-re.c assembly on stdout and piped it to grep,
but never redirected the matched output to create the target binary ()
on disk.

Because the target file was never created, Kbuild could never cache the
result of the check. Consequently, Make treated the prerequisite as missing
and continuously re-executed the Clang BPF backend compilation check on
every single sub-make evaluation during build startup.

Redirect grep output to  to guarantee the file is created on disk upon
success, allowing Kbuild to perfectly cache the detection result and avoid
redundant sub-make forks.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/feature/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index dc828523b50a..f43f85738b5d 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -385,7 +385,7 @@ $(OUTPUT)test-libzstd.bin:
 
 $(OUTPUT)test-clang-bpf-co-re.bin:
 	$(CLANG) -S -g --target=bpf -o - $(patsubst %.bin,%.c,$(@F)) |	\
-		grep BTF_KIND_VAR
+		grep BTF_KIND_VAR > $@
 
 $(OUTPUT)test-file-handle.bin:
 	$(BUILD)
-- 
2.54.0.563.g4f69b47b94-goog

