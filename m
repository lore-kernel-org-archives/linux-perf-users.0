Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793051578;
	b=5eh7u2engPa8GjSQ9TMywBjBxsPaBPPrTRy2F4uqjsL19n1li7RRqN11WT+09XP2R1is
	 qdZJ0JWicZ/iXuxXiynKI/UW8rA4Mnu4L5cXUfWF7DSFJhkk7DwYDNGrc9aNmNjX8C6Ra
	 mWKwfnHceBr82s9ltwXD41ME4yDQiMagRECK0VODyhWltk1k7f1U1+Czi3wgM2s/3L6Jv
	 Ssoh24xGbo7Z+GU4KwQdFPOSS2FqXqPZe+ukOFZkUSdwdSjHd/gIQk/OhUnrpj+IW+3up
	 5G+26n+fB4Tm6PGjTDmT+cflzMspJ9k32qkmhZoJ1x3cbAC/lpJXpXf9FmMDessf1Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051578;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=HQqGCLRyEFq1Qmw7LfzuGpexsFHiUvTKIyODgPSn6eE=;
	b=ndcYhv6vv/6cy7Iy15YLttHiQCoHJ60ymDsAnj/bgyM11UJ5dZ4DFCjWbTCKpyxmvO6T
	 9uUphmHCaED/gm1Qi9/LuIcJ9ADB592drK64nAwU6sc0/opwmxGV02xgG1brpj+eS3yzM
	 y6YsEtnrHrW3u9dAjfJjM16oMNoPFn4AUxRe16+bB1FeihTyrP3ozqT2OPyqs2QFoFPUD
	 zcnVs/hIbiLMJFaRyHQMpHSOFvv+Z1daFNquEFZra2fJ4Dm+zYhinE4Tpe/0XFYjszBsN
	 ZmVk98yEdm1pRHvG5XdooaQpN9FyRf0x52ILxXjjU/rFM1l6WynhItJhlmXVFflE6sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ZslLM7db;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28946606B4D8
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 21:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28946606B4D8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ZslLM7db
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ada8bc8575so5309150a91.3
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 14:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793051576; x=1793656376; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HQqGCLRyEFq1Qmw7LfzuGpexsFHiUvTKIyODgPSn6eE=;
        b=ZslLM7dbmVgAFSoPUZOqKRrOoyj122fasUGdKYfOjOXbcRPiRB7feP6J+Octqg8Oa7
         CYkNSyaJ5iygpnvzIZzKMr56CyR1UQjGhD0SeSiR+jnjKI891alYSFsfCdQyY1fP7lfK
         jjHyo984JGh2+H77mvNAAdFd04oUnBl94P2xuFqBjmjJW2DRxyJuLJmIcvB/faohDtvh
         cqjWch4Zsyk+B3JEvHSIHxZJLF7Wuqc+8XgYW91lxZJfWyN17H1WnMId3q2wh0N/6TLC
         csdE1br/thP+JMpWf4qCqC7rGrBz4jRcA0dSFFpspmprnoJ9hiOa+NbLKfXhqIJIfOQ1
         +hfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793051576; x=1793656376;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HQqGCLRyEFq1Qmw7LfzuGpexsFHiUvTKIyODgPSn6eE=;
        b=cWGtpcz5FMu0KXBXFpjFz1yL/FInPdR8RuNVrfsXOfbLO5jp2zIWQVU/AkUTpcVG6K
         H90WAfRDYMTb3R+A2JVIkMBXE75soXeX6KAIRcsbMv9okGOlaLLIleOLd9uX8lFazAEu
         uw76MqEBQ2AfOowSjzUBIqPyQYc4bL1R5U41+bwxxFb6/jIvJZCa1dceGujlvBXl5x5s
         wMtS6USPVbQGbvebNXsEcg3zZKhcLTvF5Qnuh6hHB++fK1W+1BB0OYOxzAtj4IITyKes
         Ipr7/X3H/zgj+1/XN13cnsXTHTHwNRFd8g7eSt3VnggdIfCLGFOKuWSyyS8v//vqW708
         GDqA==
X-Forwarded-Encrypted: i=1; AKwUvBz9pLGG5ULkCufAWNuD5PGgvI+XLQ8sf6RU1MwFQhz+7n0hYSM+KRyBbLi2RbMQ9tFeCJkL+ct7aXU0sEKrpfTe@vger.kernel.org
X-Gm-Message-State: AFq9FYKscTOwlZ64UuzjYcUXJCz2v8cQvd2A4Jw/Uwm99WX2mwbkNA5X
	/aZhoMIZD3Hok+emcfyIZzdm7s9kc9GB0LcH7WibZCp2Io0OWIMNJ6wcdfVWfTuhsO+ewt1dzdT
	GXdFb1EfhzYEWuaoyU5CCpA==
X-Received: from pjbst6.prod.google.com ([2002:a17:90b:1fc6:b0:3ac:989f:b65f])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1a92:b0:3a8:211b:6c8c with SMTP id 98e67ed59e1d1-3adeaae6e15mr7057279a91.22.1793051576336;
 Mon, 26 Oct 2026 14:52:56 -0700 (PDT)
Date: Mon, 26 Oct 2026 21:52:26 +0000
In-Reply-To: <20261026215226.3713941-1-jthoughton@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261026215226.3713941-1-jthoughton@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261026215226.3713941-11-jthoughton@google.com>
Subject: [RFC PATCH 10/10] uaccess: Move the NULL mm warning out of line
From: James Houghton <jthoughton@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

uaccess_without_mm() is inlined into every user copy, including every
copy_{to,from}_user() call site on architectures that define
INLINE_COPY_USER, such as arm64. Each inlined WARN_ON_ONCE() adds its
own __bug_table entry.

Keep the NULL current->mm check inline, but move the warning into a
single out-of-line, __cold function, uaccess_warn_without_mm().

The trade-off is that only the first offending access in the system
warns, rather than the first one from each call site. The stack trace
still identifies the caller, and the access is refused either way.

Compared to the base of this series, with defconfig + KVM:

                     inline WARN_ON_ONCE()    out-of-line warning
  x86_64 total       +5,884 B (+0.014%)       +9,714 B (+0.023%)
  arm64  total      +40,948 B (+0.10%)       +24,609 B (+0.06%)

On arm64, this removes the ~16 KB of __bug_table growth, while text
size is unchanged, as a call is the same size as the inline brk. On
x86_64, the call is larger than the inline ud2 and causes more .cold
splitting, so this is a slight regression.

Signed-off-by: James Houghton <jthoughton@google.com>
---
NOTE: This patch is included for reference only, to show the cost of the
      inline warning.
---
 include/linux/uaccess.h | 8 +++++++-
 lib/usercopy.c          | 6 ++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 7d26d2de9599..6a5b6c2b3388 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -66,9 +66,15 @@
  * that keeps user addresses belonging to a specific mm must check
  * current->mm against that mm itself (see e.g. KVM's kvm->mm checks).
  */
+void __cold uaccess_warn_without_mm(void);
+
 static __always_inline bool uaccess_without_mm(void)
 {
-	return WARN_ON_ONCE(!current->mm);
+	if (likely(current->mm))
+		return false;
+	/* Warn out of line to keep inlined user copies small. */
+	uaccess_warn_without_mm();
+	return true;
 }
 
 /*
diff --git a/lib/usercopy.c b/lib/usercopy.c
index 9146c729c47a..3d547ecb74df 100644
--- a/lib/usercopy.c
+++ b/lib/usercopy.c
@@ -26,6 +26,12 @@ unsigned long _copy_to_user(void __user *to, const void *from, unsigned long n)
 EXPORT_SYMBOL(_copy_to_user);
 #endif
 
+void __cold uaccess_warn_without_mm(void)
+{
+	WARN_ON_ONCE(1);
+}
+EXPORT_SYMBOL(uaccess_warn_without_mm);
+
 /**
  * check_zeroed_user: check if a userspace buffer only contains zero bytes
  * @from: Source address, in userspace.
-- 
2.56.0.307.g5fe7bd680c-goog

