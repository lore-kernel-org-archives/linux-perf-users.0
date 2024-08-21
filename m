Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8B5A31;
	Wed, 21 Aug 2024 19:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724269079; cv=none; b=gYVdvZd5cSo9+xCeUc40iUUXwm2ORu5BixvtQRX9Nx/Ke46vavo19HvhjDKZ7STe1RRKbaM/01aeDDBZVT0vZ9plFKPti+BPfidBKERcmAR7BmfXJH0LoXyGDcKl/RjXEbWVDy3BHKFlVGPh4EkmT85sHM58mCcPwybvL26+HqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724269079; c=relaxed/simple;
	bh=FbLXW2BKGI60XIr21LRoMBa8fyx8CsWz1aIa6Hk9b0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UoqLVCL8VWpfBT1aqlYNJ2YkHt9Qgam42wiqOaol23DxD9PuZCGcWPbzzHsFJQb5ucL755o+ImKZtWyp3BWHSl7iBr9SN4pyD6DqawyvXTXCJoMOTQQWLJrstwwl8VV12Oa385QOD0bFd5INXsL8eh4v3dg+5+dYzRAC7UcJYJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMoop9ov; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMoop9ov"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53349ee42a9so69162e87.3;
        Wed, 21 Aug 2024 12:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724269076; x=1724873876; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HNHqUTf8i9ol4B3IrSLnYHaoPISGRnl8F+WN3lSimFI=;
        b=hMoop9ovdTO+GqD/JO+TN1IMC60CF+5YkgAgmnGxdlwlKN5x1fJtXUBiFKOWtbabcv
         q5KLHuJwJZcI35QDMLgSod4hiLPSbSnLI3W3ZvERqzKEW6O7Q9QDSy8oofkO+9g3hf6K
         K+POamihsYZIx2rCNYvBx4X1Gig/PZOyyQioILOdtGFuFXJQ65pk4tYp5qvcNbJ7niT5
         PHGn0Yb5FuFIkT4xJtYEBCzzWBWyJOALtt7RJ0kQ1uRskZi1QyYj4pGe1V/h7YQn9+gn
         iAk2iyRf0aaVKjXQGuHZF0j1PKpDkt1qqSNUw9ow4KQfnBoyXpegNgPsgLTjX7BOWDYX
         pdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724269076; x=1724873876;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HNHqUTf8i9ol4B3IrSLnYHaoPISGRnl8F+WN3lSimFI=;
        b=lX0v2eExSsgv5CYvK7iLVVlxN3KGrqk8/dsQg5ObB2E1P7HM8/xmY1juwQ//i2VvtE
         mSk2OXuAVpZfkzkprBh324+iAma+gU+Wjxmcqmx2XIhDIGn57q3ExyuBNCNa0XgZKcSe
         +PrdIBTwmHXlykCO4UJDLM5g7xTRQIrd3+7/uz7CHWHA6wvYBRGlHyiOExQYvnN6hGXt
         RkegpUN7uuYZ3qE7mm+sMaYa5KPxv23TxZSeFpKvi9SkmHRRe7tH7MLiVDm+ViqXWHb3
         bWFpHnGWmpmdYryXuw+62HLBPsX4+rz78y1UjylyfXsqPvoLNxgMbE/gtHW8opEkbheD
         9lbA==
X-Forwarded-Encrypted: i=1; AJvYcCXp3BhMfhawkIxhoifYvqRG8UpSXlN3zzH48Pj7C9Yy6Blcxfbfs3qGQpHW8z+PWk8en6sZjMFwOdQ7nDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNGPmIqxJAtSebOLs0XnGlInSMoYk0ZbfxYfWp0xnuod//8V6N
	lX6Rd3w+Jg6Y5UnbB8MvSLJhyWfrv9oZGSNW8n65M/BRN9uZxp9UcneyRBLS1RtEQEWKJJYH+ua
	bZcfifH+RqdGnBRC6doo0FgTUSkU=
X-Google-Smtp-Source: AGHT+IERby/L6uviOiiPjYEJ069B5XI0jNWltAS8ubs5V2qmEIdcwcj9HA2UXawOjOr39yFoWwed4zqh1M6aXD33EPs=
X-Received: by 2002:a05:6512:4004:b0:533:4327:b4b5 with SMTP id
 2adb3069b0e04-533485932fcmr1978258e87.46.1724269075363; Wed, 21 Aug 2024
 12:37:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5pUMUUhG-UVKQ@mail.gmail.com>
In-Reply-To: <CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5pUMUUhG-UVKQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Wed, 21 Aug 2024 21:37:19 +0200
Message-ID: <CA+icZUXpB4KMiRek3MkgCapwoW5TC31L4-TffrV=jdhM1k8=Sg@mail.gmail.com>
Subject: Re: [Linux-6.11-rc4] perf BROKEN with LLVM/Clang 19.1.0-rc3
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"

As a workaround:

dileks@iniza:~/src/linux/git$ git diff
diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 142e9d447ce7..db45e6fe7a21 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -63,6 +63,8 @@ cflags = getenv('CFLAGS', '').split()
cflags += ['-fno-strict-aliasing', '-Wno-write-strings',
'-Wno-unused-parameter', '-Wno-redundant-decls' ]
if cc_is_clang:
    cflags += ["-Wno-unused-command-line-argument" ]
+    cflags += ["-Wno-cast-function-type-mismatch" ]
+
else:
    cflags += ['-Wno-cast-function-type' ]

dileks@iniza:~/src/linux/git$ ~/bin/perf -vv
perf version 6.11.0-rc4
                dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
   dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
        syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
               libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT
           debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
               libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
              libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
              libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
            libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
             libslang: [ on  ]  # HAVE_SLANG_SUPPORT
            libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
            libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
   libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
          libcapstone: [ on  ]  # HAVE_LIBCAPSTONE_SUPPORT
                 zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                 lzma: [ on  ]  # HAVE_LZMA_SUPPORT
            get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                  bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                  aio: [ on  ]  # HAVE_AIO_SUPPORT
                 zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
              libpfm4: [ on  ]  # HAVE_LIBPFM
        libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
        bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
 dwarf-unwind-support: [ on  ]  # HAVE_DWARF_UNWIND_SUPPORT
           libopencsd: [ OFF ]  # HAVE_CSTRACE_SUPPORT

-Sedat-
