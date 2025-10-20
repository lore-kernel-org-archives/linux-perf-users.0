Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21E821D3DF
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Oct 2025 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760947395; cv=none; b=jCxucYQ804QU6VCz9XIytYcZiaUxQ2IxtdYrcwvKRnQI62EtGmUT86mwaKD5WcKYNdj94GxOjDpa+DUFKOzi4LGHxHit/uPhikebCZMLsT771QlwjcungEGr5mlqjogZSKTUeA+u4X3XGHB1FNNjqVFiQICAGu5+MCvRwa9M5Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760947395; c=relaxed/simple;
	bh=zSrHgFoFLOuMfBq+ow59MxETNiEc7Ug75WckEpH0B1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFNFE35fKGn0hieDzKkTfHBzKU+tx69vrRIRQ2FbH7nreKxAroRoTuVpbT7AbMCJLfvET+l1AX8+HzSr/MxRvfAVV7qtnuoFI8/wsR4lTgVmKZ8Z165WCme0dyHBdtOGGGjD4cGlBpkqPBJOPHIY6kQaEM8Jpi9UoZ9Xmi92CS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3hGRfM/; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3hGRfM/"
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7c2917b92bcso1282933a34.1
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Oct 2025 01:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760947392; x=1761552192; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KViY3RZGThzhrj6fWVe1XUp0201BJSec3EfLEu40ZP4=;
        b=J3hGRfM/RJk/toV1V/m5yeWxruG4HadpeLFi0EHfgcdcJVkuBMT4CJ0Tmk/yUBk1tC
         LDg2rcXcVLgLEYPs5ZB/TvgJYz2q2TkEsKpa1Dza0XzbSmL1wZqi87xmCJ/FWOctPau+
         P16CLfwww/EF8fDDaCSednINEcUdDfrzB2xoqptcU1bCtBYea0j7cT2W13umS5D2AYV5
         L67U4xkUdsSpnBPsnAz82ye/6TRn1qsDi3PUgmE0X4SfOjgAC8WPuWHhCUatU8veb5i8
         kXcLJs3ethOM7x+4W0gmAhOb242sY9VRRtEWkbqT1kQ6eltlLyLyjRynXJNRvO6h1e8p
         OGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760947392; x=1761552192;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KViY3RZGThzhrj6fWVe1XUp0201BJSec3EfLEu40ZP4=;
        b=WvqTEOj4uBX35cjElxNjfHtMbhd08rtjtdW6dxeT+mnhUoelm4/10Rd735MeEw03if
         7ia43hCJtkHqICcVJRAN0bsRVxPM2wkm15pPwg85IhfGNd3CPoOalug/noEIUo3a4ifS
         ZYMuj3+coWSROobjR4I3uvQDO+y0k5N/4N/PyCku2sjrqv8rTqluiLV7R2OXej3ykw+h
         NbCUc67JqvHwC9GE2e7y1PvUNHY3wdQg3EwR91DbcHJ0W7R+Qw8Ny5L0RNk27sJl3T0v
         yBoRbC3xctFcyoqgR7iNZYWImuPbA250vFuTdO0EBvCu7cqU4DMRt2vihOHzyh5/9Hxz
         BVew==
X-Forwarded-Encrypted: i=1; AJvYcCXrN5CkBjr8u3foPzh7nQNNl2W+zUWZ5DvKvvo0lqUcuW+8xrVSBmJ1C3rlXyEiYzTC76F8VF8SMXyxhxHQ29s0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7vNOxHoCETP3UDMHSvSYamxbgyCei+n89r69ay9A8tqPfqgED
	3/EpPLnAYT6EhmFDfmWC+QDk0Nhn0KVY+GZwAM6O9Xc7LJv+3WnfcDfTQajHXiRo1fgzG6Jd/Vq
	gy65C1VHSjS+uQze8J99NjP/H9Om9+/I=
X-Gm-Gg: ASbGnctxOu9fM+QUSoGFSmpJo38VwdEC3Zfhu9Z345i5/rGYcuV7Nw06xg7+KqsyAU6
	mQg2JeOt8BO54DKFK2JSz8GH20f6AGbFSKR8C4eozJNCTdqBcdZWl3KYarEGo/HSWDvskYW3KEV
	S70/zr0RGB5XqWBUDpAEvY82rsJg0EMA1USEvg+6gwNSB9QJBlVbauIyHaK4t166yzTnTSHsGnP
	tnERZiJGNta8kB9tbyq8/fzVcqwojMY85Ou8Xoz6LJUA9I2k9xSJUb3cHsW
X-Google-Smtp-Source: AGHT+IFrxgQq6FNZjWNsabTJQdU5Xs0avQkPCZRU83HNIJglyrvEYlBJqaN4elUocNpHwxjNqmdvpiJFgA8xvl/dosM=
X-Received: by 2002:a05:6830:6733:b0:745:5748:b328 with SMTP id
 46e09a7af769-7c27b5e213bmr5437222a34.2.1760947391690; Mon, 20 Oct 2025
 01:03:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADHxFxQHFkn-J9R6AJY8LxkDN-eTWjp34VvoQDcshfZs1eF0rQ@mail.gmail.com>
 <20251020024049.6877-1-hupu.gm@gmail.com> <aPW3rilb8DtFDIMC@google.com> <CADHxFxQF033b97sBx8rtRHAo5Ou5Uc3WLUH1Y5+qA3f1i2MMjw@mail.gmail.com>
In-Reply-To: <CADHxFxQF033b97sBx8rtRHAo5Ou5Uc3WLUH1Y5+qA3f1i2MMjw@mail.gmail.com>
From: hupu <hupu.gm@gmail.com>
Date: Mon, 20 Oct 2025 16:02:58 +0800
X-Gm-Features: AS18NWDnZMZHqbYH3qe8wZocpzunzmeo2BMa6O9uF8rZux20-oSim6ooTsO5dwo
Message-ID: <CADHxFxQB0n4P-BZkbJfqtvfHHo=JZWtgAEVnedZcQOkCwqJWEw@mail.gmail.com>
Subject: Re: [PATCH] perf build: Support passing extra Clang options via EXTRA_BPF_FLAGS
To: Namhyung Kim <namhyung@kernel.org>, leo.yan@arm.com, irogers@google.com
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When cross-compiling perf with BPF enabled, Clang is invoked during the
build. Some cross-compilation environments require additional compiler
options, such as `--sysroot` or custom include paths.

This patch introduces a new Make variable, `EXTRA_BPF_FLAGS`. During BPF
skeleton builds, it appends user-provided options to `CLANG_OPTIONS`,
allowing extra Clang flags to be set without modifying Makefile.perf
directly.

Example usage:
    make perf ARCH="arm64" EXTRA_BPF_FLAGS="--sysroot=..."

Change history:
  v3:
    - Move the variable description comment to the top of Makefile.perf
    - Update commit message
  v2:
    - Rename EXTRA_CLANG_FLAGS to EXTRA_BPF_FLAGS
    - Update commit message
  v1:
    - Introduce EXTRA_CLANG_FLAGS to allow passing extra Clang options

Signed-off-by: hupu <hupu.gm@gmail.com>
---
 tools/perf/Makefile.perf | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 47c906b807ef..c1a66cf3d1a7 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -35,6 +35,9 @@ include ../scripts/utilities.mak
 #
 # Define EXTRA_CFLAGS=-m64 or EXTRA_CFLAGS=-m32 as appropriate for
cross-builds.
 #
+# Define EXTRA_BPF_FLAGS="--sysroot=<path>" or other custom include paths for
+# cross-compiling BPF skeletons
+#
 # Define EXCLUDE_EXTLIBS=-lmylib to exclude libmylib from the auto-generated
 # EXTLIBS.
 #
@@ -1249,6 +1252,8 @@ else
  $(Q)cp "$(VMLINUX_H)" $@
 endif

+CLANG_OPTIONS += $(EXTRA_BPF_FLAGS)
+
 $(SKEL_TMP_OUT)/%.bpf.o: $(OUTPUT)PERF-VERSION-FILE
util/bpf_skel/perf_version.h | $(SKEL_TMP_OUT)
 $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h
  $(QUIET_CLANG)$(CLANG) -g -O2 -fno-stack-protector --target=bpf \
-- 
2.43.0
