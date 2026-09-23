Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075AE361974
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147659; cv=none; b=Dra/GNjRQrdMemZrFVsTtuSW7j3OUGR3WvblLhN78XhVWGP03JylntrpCh61K9JmM97T18I2S3kvQ3n4k0ZVJ6ewPHCQXdBOm79DmZCFQx5WuwIHvchsogyPXGIvKle9ZsfIG0Tonxq/Mj7XjXvTX6c5FUifMAxDOCvt4W/hbPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147659; c=relaxed/simple;
	bh=OWJ9liMtUqNhKqaHQ382r8ukgbu/MYHo9cgf8A5Mqyg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=db8yVZ1KfTngA4nnznkQKMDFDaHuHfv7S4LcEEzPSUjlsmdnDsQSgveKvNLiAR3OgbAGLcew9l0cvDfMM1NzzFl5i0QrWNkNJx/VIdQkYxXvUWsKb+QKk6Z4+a3m0tZ0U/CdMYLjzCmiAabxdKSh6klJivN8iG+KcLaCjsqC5GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lGOaThnZ; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lGOaThnZ"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33713e5e6daso732653eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 00:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790147657; x=1790752457; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qMeOUeotXgWQhh7PGWu6xio6F6uBeBIPshzRfQOnbNk=;
        b=lGOaThnZTHzBaxbULsSCt+XW/06AdMElawoZjUKmnRmti2MWPQmfbYQyeS+EQLhszy
         6FerlfMvoBu0P36tYvvNMLUTv2G0GizIGM5bx4U8GLFK+i7ywJi80VCdKnWesLSO+1aF
         cBOoTmIEgUuR2xmspurZs9iTx1hY/ci0OwU6GuP2n9ZZbB2Gcv1634gcJ5ZgKrVt23B4
         QgMRndF4Jl9AobHFFkl8zQUuEw8EKlmtBA8DWiTGx4/RZNk33BMz9Z9No2Fl+puygycF
         IvmN2+2mx2+XSXGR9LH9eicPruHw9SFmeQpAdtBWzH0ImY0YUtBATnCyHinYPpuD94yh
         zg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790147657; x=1790752457;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qMeOUeotXgWQhh7PGWu6xio6F6uBeBIPshzRfQOnbNk=;
        b=vbHxir/p0fRKd3yTh5AxcnRI0ok37s1kcfSsY26aw0VMNXOATb8txm9wARs9bRCSdw
         76xH2NE7Se2j9aXaG8/LhGfrZJIishLYyi3i0ZEie49uZZyRd3TlJLVfBK1F7oYvhx+i
         CId7DmT5JnEh+JYshGh3BYDPxo88d8pofve2qo1twzvuG22KW9ARjKG4iUKsp35okGX+
         pHC1r26626eQPryMZdba5r3LzvxjqlXJt4MZHaGQUsWJflVOIlKUa9uGG76aatla4o0q
         tb4/kuqEJIe7En8syevxr2RcmSwfq8btZmOBgsIyBAzYVL/2Yd0F9FgW6BGFRLhDodlT
         QfGw==
X-Forwarded-Encrypted: i=1; AKwUvBylcJOZvRH0SCjZQIFwmWqvzCBAxPOyfsFhEVc7/HlBS0fultOTcHBjnxTFLiErv74yH6hy/wTOGhzDa6tcqW+A@vger.kernel.org
X-Gm-Message-State: AFuF++nF65y8vgARgxVL4Djx1fN6o1GoNvrZ+Z9baHqx7rFbCr6mEXOm
	8kkNmn0QLKQnRp5frwZYqjRs/nFTapWpzToiq+Y9uuNQ7lDw9Kj1EGowapM8z8XQ7NNSctz5Ryd
	BdetYrofuQA==
X-Received: from dlea7-n1.prod.google.com ([2002:a05:701b:4207:10b0:144:e5a6:137a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b044:10b0:144:eac6:cf37
 with SMTP id a92af1059eb24-144f92ec87cmr1963768c88.47.1790147656883; Wed, 23
 Sep 2026 00:14:16 -0700 (PDT)
Date: Wed, 23 Sep 2026 00:13:42 -0700
In-Reply-To: <cover.1790145937.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <f022c34f984e5037f4f4bb0daa75963ff8912e4e.1790145937.git.irogers@google.com>
Subject: [PATCH v5 02/23] perf trace: Include the augmented arg header in
 nanosleep's payload length
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, howardchu95@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

sys_enter_nanosleep() sizes the record it outputs as

	unsigned int len = sizeof(augmented_args->args);

where every other augmenter that appends a payload uses

	unsigned int len = sizeof(u64) + sizeof(augmented_args->args);

the extra u64 being the size and err fields of the struct augmented_arg
that the payload follows.

The payload is copied to augmented_args->arg.value, which starts 8 bytes
after the tracepoint arguments, but only len + size bytes are output. So
the record stops 8 bytes short of the end of the timespec, and userspace
reads the tail of tv_nsec from whatever follows in the ring buffer.

Count the header, as the other augmenters do.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index dd3aa5bd910b..18904bebf672 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -426,7 +426,8 @@ int sys_enter_nanosleep(struct syscall_enter_args *args)
 {
 	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *req_arg = (const void *)args->args[0];
-	unsigned int len = sizeof(augmented_args->args);
+	// the size + err in all 'augmented_arg' structs
+	unsigned int len = sizeof(u64) + sizeof(augmented_args->args);
 	__u32 size = sizeof(struct timespec64);
 	int err;
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

