Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CB22264B3
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Jun 2025 05:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750916919; cv=none; b=UhasBwc5hwTbuv31X7Ku6QiCuXivsrWXwamr3J5zXECMJKeqPbXifFIRgS6+bZ/D6wtG4HXaacEr+zv/PjlOGc/akbxdpondDeq0xdK1XYoDsnuoqrJzoJKhQcGeXzyPcBjnbAKrXgi/P0KWVx+W8hv8StCt+utGGXssS1w4Wjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750916919; c=relaxed/simple;
	bh=Y9rAwk43R5Qu/XneIvtPPaxorqlg9IJwfPk0mko3rAw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U9WD0uRdCpaoNiz36aUHSuMCb1h4AYU0GbpKAwOwnoFomcv4F/hP2HWoAY3kNHnFeVHlW9MEIaHtUj+WY+ww7AUac1JTE5fQQh5GdU9z6rfuzMdXgyKTg2QWfnAcCD2gW66T1gv0JdZueI+diJtm8QFqTJZUvvS/ZKm6beVDEls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1TLyXauv; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1TLyXauv"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748f13ef248so550240b3a.3
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Jun 2025 22:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750916917; x=1751521717; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=06wlXYRsyscOOukfm0BoHmWOsjunsh8IZmbqRpcqtRo=;
        b=1TLyXauv0hSwcmp0Hyyig6+luqbkAyysSytClcC/r+u+yUjI/pJZfvyDxVbU1LaoMs
         7j+851Vb/z/Xw8//K31iveAZ6SqEXuoc6zu2pzLdjKwWicbSC5OwL9QvV3+JFgwf5nE0
         gXRgP5EY8A8g7Rp22kpVKIBfM56ndTirXLSbYQXhvLydG65PXRxf8W/TLiRMeI+nhaC9
         inZclZg8Kjo0ZwU0sJfWkRkWCkLIj4onIFaf28uaWD/XUTChrKIg3yh0haRijJ4CYZwl
         /iNrb+wr+VVLRN8pQeDA97ZxwIK/1Yc4279e2vmN4K5Z7kYot7WlPlCq2lm9oZ59Cxq6
         6Z8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750916917; x=1751521717;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06wlXYRsyscOOukfm0BoHmWOsjunsh8IZmbqRpcqtRo=;
        b=SomDONj+uDGP1T16oBCprabf5LwQN/u+1bQuRYbAujEaUL684BgZNi7cNk9oP2dxOQ
         eK/fTfbfuOdzs3gJYbLrx4HLeudx9x/lHbrSU8BQ/KnUt2Va1iye1cfFaZy5KrQc6G7p
         LY2WNFBa6XXdH/HRpPFPNg9H44SOiefascKq2Rr4lkJdeOSqtV9cpbd68MIL49WsyKq5
         V+nY0Pz6QVC7DND1bhXF3LNMjztggGAnk45hZ1eS9QDqy3+DgmQTz0FvTQCrfPIdZOLH
         hvgjVYFLPUNEzdVQZ6UTr9zssOx2GhACkEr030HQlvWTSkTK7mP/Ttk3f2wvbudYgmBr
         Hscg==
X-Forwarded-Encrypted: i=1; AJvYcCVV7yiDDCMFTNNbY40aiAbLDxYnd/uYqBDRjq47iMbdYz3TAO1QsxS46hpDyAvGZUW/O8Rte9bKV6iNMUfBln+H@vger.kernel.org
X-Gm-Message-State: AOJu0YzIZA7ckbZN9cDNFhzQzi9Ul570+0D3wUI6GWufYuWspy83iCOH
	XVKFfPM7qua1NoDuwSOrbNH5M++RnsIUswjSYRinHYGHg4mKfkigu/frBqUfbLJbubUgO2mZ+8g
	hRvoMDtqvPw==
X-Google-Smtp-Source: AGHT+IH+oNNAMV2NVtWwXyNOB/xwSiYb7Vtrnxbr8iZKkclF7b16D26wDNw57BukJDxDJDBIx0CIDLYPgWdi
X-Received: from pfbde4.prod.google.com ([2002:a05:6a00:4684:b0:741:8e1a:2d09])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d85:b0:220:193b:913
 with SMTP id adf61e73a8af0-2207f33227bmr11024525637.34.1750916917233; Wed, 25
 Jun 2025 22:48:37 -0700 (PDT)
Date: Wed, 25 Jun 2025 22:48:26 -0700
In-Reply-To: <20250626054826.433453-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250626054826.433453-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250626054826.433453-4-irogers@google.com>
Subject: [PATCH v3 3/3] tools headers: Remove unneeded ignoring of warnings in unaligned.h
From: Ian Rogers <irogers@google.com>
To: Eric Biggers <ebiggers@google.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Now the get/put unaligned use memcpy the -Wpacked and -Wattributes
warnings don't need disabling.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/linux/unaligned.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/include/linux/unaligned.h b/tools/include/linux/unaligned.h
index 395a4464fe73..d51ddafed138 100644
--- a/tools/include/linux/unaligned.h
+++ b/tools/include/linux/unaligned.h
@@ -6,9 +6,6 @@
  * This is the most generic implementation of unaligned accesses
  * and should work almost anywhere.
  */
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wpacked"
-#pragma GCC diagnostic ignored "-Wattributes"
 #include <vdso/unaligned.h>
 
 #define get_unaligned(ptr)	__get_unaligned_t(typeof(*(ptr)), (ptr))
@@ -143,6 +140,5 @@ static inline u64 get_unaligned_be48(const void *p)
 {
 	return __get_unaligned_be48(p);
 }
-#pragma GCC diagnostic pop
 
 #endif /* __LINUX_UNALIGNED_H */
-- 
2.50.0.727.gbf7dc18ff4-goog

