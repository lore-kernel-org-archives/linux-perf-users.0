Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8913C1991DD
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Jun 2025 05:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750916913; cv=none; b=kNO9whPnkne6yc3iISlZw41WPwS01v3tw4M3+BvV4qDfmK7phDDoP0v+Mbo6b/7d+L8+QyLBgaExQUfNeJRHMqIVvj++BhuvHmwpZy5GUgL9TX3oBLaNkTHy4SRlKrXnNTUH709nTTqlRgECv4VUsnQu8rGfzR00t9t1xJ+0moI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750916913; c=relaxed/simple;
	bh=7iXNVMFOhItaUCoOVD5EO9MsC8N+X9oJecc6TOl/S6Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=suVr6iLGRzZ65vE/rFkzv26/d8Z/X7rxQn4FGdECuaAtn8gP/qk5h50K3fxK2Qo6atdCwu+WthDnYuTGyI5GT24N0vZX129M6Td0M0ar68kdMZrLr0jNh7HCtWCiaX5Rs8RbuDZ+mr3U2ccYjUxOFHp8nyN/RoPt/nt9T9LUmI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GSlS5gnA; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GSlS5gnA"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b00e4358a34so394957a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Jun 2025 22:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750916912; x=1751521712; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hYtEj8pZ1muLWRPDDlQVjZ5z/iyi7EezXJavrUzUbMc=;
        b=GSlS5gnAROXngFUoSdgQ+L84YdByphWuLrkbDN18dE1/xQwqrO1b2WaOZcEVDTYJxJ
         Gu1UPy89E1TlqVfEKufgQyZv+IBhxBa0TGOHA4UR2CEZdbecT9r9qUJVaeLpbT/ZlsJI
         ucet/fx56KdtM5iTr0LTV0JAgO/YCxI0hVMfJvxpVOAXX5A14EzgItgCdDtXWlD6ATmx
         Rp9jF2Ta+p8/nvW/5Pq0U6r8K6iHdJBJislaNfw52mbJ7Gp2Q4y5Mv5f8ey+H8rNpVsF
         1pmVKiFeiUHfTVRatVdOGMHA+CV5VQl2NVFP7jWWIkoRJ83KpT/OWt2pZb5SvvkkfGJR
         BuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750916912; x=1751521712;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hYtEj8pZ1muLWRPDDlQVjZ5z/iyi7EezXJavrUzUbMc=;
        b=Rdt33Pq/AQlA4VdzLHlBtJYv2EVLnaY7T57XzNn9B25CA/iIKbnz6EKomZdQhFDyRn
         /8k4l0sn1EIsRH+MhqEn21BhV6k315sUgkTkHXWEMTvePO2phfAJf0pZkXmEEulRf5qh
         2FhaCt/PdJtrWEitTh7wer9aJmNQgMLuUctF0xq8UJlh3DITuEm4aLfn9pYI+K4ir8d+
         0XD3s0f9RIBYL3gJj9a5WLo0dVUQ2Z80r+lyPjx6TarMtGTpuEcuH67tR3YspdeDnyAI
         MVPYlXkU5CfSgF74qPK5Jx7G76WFHT2JNhM+VEIfvvyoVgUVMMx7w/fcKCGzCNTxohhG
         gCNw==
X-Forwarded-Encrypted: i=1; AJvYcCWCDO2FQ6BC1lSREdTwSoQq27oOGEHc9kUJPYeWRTt1tVMJliHw3EQHSyay2orYoh2yjVhLh8RjABBVsEZ9KXvz@vger.kernel.org
X-Gm-Message-State: AOJu0YzMnO39l6wXrfTG5JyMqksG0KOrSQBFzqpUw4EI0BNVfsfG7JjH
	Lovethi/KOtG96Goo8//4EgNMrHrfVM9zKBrBmE2JIZs1CY+h1o4fQjTN4cpOQS9j+DsL4r4XGz
	6Ph4KfL43nw==
X-Google-Smtp-Source: AGHT+IE2YaB7ChZqsFi4NtfmwE6lkqlm8623UWb6T2LdxoK83rw4khrQNSFo1gWCa8kj9s1R2l6C72a5inWs
X-Received: from plez10.prod.google.com ([2002:a17:902:ccca:b0:234:aa6d:999d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a83:b0:234:ba37:879e
 with SMTP id d9443c01a7336-23824065f5dmr101279415ad.38.1750916911844; Wed, 25
 Jun 2025 22:48:31 -0700 (PDT)
Date: Wed, 25 Jun 2025 22:48:23 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250626054826.433453-1-irogers@google.com>
Subject: [PATCH v3 0/3] Switch get/put unaligned to use memcpy
From: Ian Rogers <irogers@google.com>
To: Eric Biggers <ebiggers@google.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The existing type punning approach with packed structs requires
 -fno-strict-aliasing to be passed to the compiler for
correctness. This is true in the kernel tree but not in the tools
directory resulting in this suggested patch from Eric Biggers
 <ebiggers@google.com>:
https://lore.kernel.org/lkml/20250625202311.23244-2-ebiggers@kernel.org/

Requiring -fno-strict-aliasing seems unfortunate and so this patch
makes the unaligned code work via memcpy for type punning rather than
the packed attribute.

v3: switch to __unqual_scalar_typeof, reducing the code, and use an
    uninitialized variable rather than a cast of 0 to try to avoid a
    sparse warning about not using NULL. The code is trying to
    navigate a minefield of uninitialized and casting warnings,
    hopefully the best balance has been struck, but the code will fail
    for cases like:
    const void *val = get_unaligned((const void * const *)ptr);
    due to __unqual_scalar_typeof leaving the 2nd const of the cast in
    place. Thankfully no code does this - tested with an
    allyesconfig. Support would be achievable by using void* as a
    default case in __unqual_scalar_typeof, it just doesn't seem worth
    it for a fairly unusual const case.

v2: switch memcpy to __builtin_memcpy to avoid potential/disallowed
    memcpy calls in vdso caused by -fno-builtin. Reported by
    Christophe Leroy <christophe.leroy@csgroup.eu>:
    https://lore.kernel.org/lkml/c57de5bf-d55c-48c5-9dfa-e2fb844dafe9@csgroup.eu/

Ian Rogers (3):
  vdso: Switch get/put unaligned from packed struct to memcpy
  tools headers: Update the linux/unaligned.h copy with the kernel
    sources
  tools headers: Remove unneeded ignoring of warnings in unaligned.h

 include/vdso/unaligned.h             | 39 +++++++++++++++++++++++-----
 tools/include/linux/compiler_types.h | 22 ++++++++++++++++
 tools/include/linux/unaligned.h      |  4 ---
 tools/include/vdso/unaligned.h       | 39 +++++++++++++++++++++++-----
 4 files changed, 88 insertions(+), 16 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog

