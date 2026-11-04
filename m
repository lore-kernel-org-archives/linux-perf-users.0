Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793768638;
	b=cFng6NVbNtKkoBky3Rn1/g0t9n1ysqXrcrr3mRN5/AHnx+0gfU9H7JJa6mZn+QSxUwGQ
	 tzbt8mY4hH8h8BAA/oPTJQyCOiAyDfC4ENkXEDejd8PH99p9Zkoszw17o+xdSg0886NVT
	 wbUA4B7JuQ3b/1UPKNeQEXx6F0/q925SDy73K5bPhArCENlXwraiCHCgOYbL0NyNKj546
	 wmIFXKIS2k6LIzXLgKybkLamcTk3x7MlH6OcHHB7nTXvNu9fl3flMoB5zEn4ybFjJK7mS
	 mlhYCvkZvuti2qsdYdWh/ghZid/w7ghSHOLhnO/g0wZRhd7/jJ1K9cp9Uet6uPbe0PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793768638;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=Bh8KfPuJj2iTXOUheCNI6RmSE0TesHaKpRuqz0dQaqM=;
	b=NTUWu/PoCtlKv6b+tcln1VOM7wCgIIIS7w8rRHI2ITiRh5SXjxoG5K1FtNkIkB2zpQSO
	 BqIy5GJzHmwVvQo6ENok+CebNxc3ejrUKXAmHJrlWcxqoR2gYDqY0zAhICJEPobJCaV9F
	 iodhnokp+Y5jCkMZ4a6r0YIMornDc/Gd1ORYTL6da60ya68eb3bI4wpvnKIRhATHnlRBw
	 lYOjcsKJUNI/q1jAIBNXUkWWRNvURSI1uXgdzjinFv5WTG+jiUXjAjbkmfZ3cvZMKK5Qr
	 epUWmSYhuqonzg7WPqMQ1Du41XmmjS+gLUkFsLBBXpEHKmFSjnk+AQ8RtbHS+epasqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HMx7Sunj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D913D606A31B;
	Wed,  4 Nov 2026 05:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HMx7Sunj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7701F00919;
	Wed,  4 Nov 2026 05:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793768637;
	bh=Bh8KfPuJj2iTXOUheCNI6RmSE0TesHaKpRuqz0dQaqM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HMx7SunjXBZt9ll09S6BwIUGp7QPmG2RH6JGtH8xsGsdEbPuqtgAcAtd9DMnQUIwj
	 /ZVWbep7FxXYWKiBp+zS6cux8gRKRyyIfJDYEBfinRvbXjAEqIkXqmYENEU82PMVSK
	 RNo6FpcV5Cdr30HISamHe6rLzabyMNuT7OqAuiIjeK5N1iONSyO/LJ5bIbYJfFhjtG
	 wsh9WEUJy8qQU0V7BcoM9521pDS8l13CuWHk7dfrVCL1vk7CnqAIO4YfHP13dmeru+
	 bNPc7X7+N6zdnbWRYNLanPJZVw6Jic546oakdCxfjmM0MLDhPx1PoDrGkZL+hJ5cYi
	 JrSxXS5yVHZyw==
Content-Type: multipart/mixed; boundary="===============0821062343041324575=="
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <d94520950f855a1d5ac4b51975988b70185ba7da61836aa84b044b69e8104bbc@mail.kernel.org>
In-Reply-To: <20261104043006.1199857-2-irogers@google.com>
References: <20261104043006.1199857-2-irogers@google.com>
Subject: Re: [PATCH v3 1/4] tools build: Add explicitly sequenced -lzstd to libbfd feature fallback
From: bot+bpf-ci@kernel.org
To: irogers@google.com,peterz@infradead.org,mingo@redhat.com,acme@kernel.org,namhyung@kernel.org,jolsa@kernel.org,irogers@google.com,adrian.hunter@intel.com,qmo@kernel.org,jpoimboe@kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,james.clark@linaro.org,leo.yan@arm.com,linux-perf-users@vger.kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  4 Nov 2026 05:03:56 +0000 (UTC)

--===============0821062343041324575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> tools build: Add explicitly sequenced -lzstd to libbfd feature fallback

TL;DR: Possible build break at this commit: the libbfd -lzstd fallback is
removed but no consumer uses the new feature test yet, so perf may fail to
link and bpftool may lose JIT disassembly.

> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile

[ ... ]

> @@ -249,18 +250,21 @@ $(OUTPUT)test-python-module.bin:
>  	$(BUILD) $(FLAGS_PYTHON_EMBED)
>  
>  $(OUTPUT)test-libbfd.bin:
> -	$(BUILD_BFD) || $(BUILD_BFD) -lzstd
> +	$(BUILD_BFD)
>  
>  $(OUTPUT)test-libbfd-threadsafe.bin:
> -	$(BUILD_BFD) || $(BUILD_BFD) -lzstd || $(BUILD_BFD) -liberty || $(BUILD_BFD) -liberty -lz
> +	$(BUILD_BFD) || $(BUILD_BFD) -liberty || $(BUILD_BFD) -liberty -lz || \
> +	$(BUILD_BFD) -liberty -lz -lzstd

Can this leave perf and bpftool unable to link libbfd at this commit?

Nothing here reads the new libbfd-liberty-z-zstd result.  Neither
tools/perf/Makefile.config nor tools/bpf/bpftool/Makefile calls
feature_check for it or has a branch that uses it.

On a system where "-lbfd -ldl" fails but "-lbfd -ldl -lzstd" links, the
parent commit gave feature-libbfd=1 through the removed fallback.  Here
feature-libbfd, feature-libbfd-liberty and feature-libbfd-liberty-z are
all 0, while feature-libbfd-threadsafe is 1 through the new
"-liberty -lz -lzstd" fallback.

With BUILD_NONDISTRO=1, perf's Makefile.config then passes the threadsafe
check but takes none of the EXTLIBS branches:

  ifeq ($(feature-libbfd), 1)
    EXTLIBS += -lbfd -lopcodes
  else ifeq ($(feature-libbfd-liberty), 1)
    EXTLIBS += -lbfd -lopcodes -liberty
  else ifeq ($(feature-libbfd-liberty-z), 1)
    EXTLIBS += -lbfd -lopcodes -liberty -lz
  endif

  CFLAGS += -DHAVE_LIBBFD_SUPPORT

util/libbfd.o is still built, so the perf link can fail with undefined
references to bfd_openr(), bfd_check_format() and disassembler().  bpftool
goes down the same chain, silently drops -lbfd and -DHAVE_LIBBFD_SUPPORT,
and loses JIT disassembly.

The consumers are added later in the series:

  6eb66acc776f ("perf build: Add explicitly sequenced -lzstd to libbfd
  feature fallback")
  155513d3a59d ("bpftool: Add explicitly sequenced -lzstd to libbfd
  feature fallback")

Would it be better to keep the old -lzstd fallback until those consumers
land, or to reorder or squash so that each commit remains buildable?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41774922004
--===============0821062343041324575==--
