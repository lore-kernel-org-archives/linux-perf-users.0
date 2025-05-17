Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FED19E967;
	Sat, 17 May 2025 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747499557; cv=none; b=dEEzucF/udAz6H2lAqWCj4n0xEh90mPURVMJSrrx/qV9LKN5rxfhfvS0UoK9SRWXocMtUGvI8XgMxTOY4xYCt3mSN8MjRUy/EE3f1ebUMFJ7pV1mlhd3Hug0adB4UDGPm1kh8T4han+t7rYMpDvt2rOuQ9HERxsImbKMZ/eoQe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747499557; c=relaxed/simple;
	bh=8TFIlL+9Nqb7USj2bx1x7nSvC+emH7rIhEN9SdoxRiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfvTOC00uqROciubswjKgfKsDnjTToUf0tDJv40I/XHqVs4Iafq/tyqiWg/zXAHOl4GAXP+tcKlQVH1v1rRlMsmUhl+/K+wLyZGYcRh14AwlNiJhXmSqRHj4CECDkP0Wz11A0a+ta99YXH+4Znu9d8smGTMkwB9wylDkfS1Un8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZogGzwF9; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZogGzwF9"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7423fadbe77so3153046b3a.3;
        Sat, 17 May 2025 09:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747499556; x=1748104356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ujzt0Z1mlstm8/GkFppvnEuth0oQ41DBzEMpZiCaoQ=;
        b=ZogGzwF9f6XXaw5WW4OFR24FQQBrWSP28CiheQCbdeRnxlLCBUFZIhp84nVzWngF0J
         aLWQXcvG+CJ+kS+6UJVjLy3ZfzrWP/IqeQx5J3oVDclxf4PERjkdsuJO84uoQtImQvF6
         6LyiIw9TmV/j/jCUquNWeCy3lb9vC4vj1cYQkMuwTuntnt9xbr+7R4iDv/f1WY5CCW+8
         Y/FuytQQspZd6YQQNQnYBYnjKVtzoQ8BkHsUl64RPM5iwSOtMcpLKNw2zgcMkGQFH8gw
         VpRurWx5TNXRG7UhmmtuL0GNF2ghvAWp+eTLLBxeDnB2BfwGz4rrHYKzUTLsvs6GBPzi
         eZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747499556; x=1748104356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Ujzt0Z1mlstm8/GkFppvnEuth0oQ41DBzEMpZiCaoQ=;
        b=j61j7vGgs2SJyeakLRHIFAuiDHvYoc8W6cnpAPOUtFJu/jelXNh2EyF3LhfPTgf9W7
         lkjqM/Zxz3hIsDln/IZocTYu9Pwwh4u2upHg590eb/wMKXHJwljsvlmGnP2ZJWeYmuzR
         VtQZWhUI9VlFc6SXgzEhaTS3MPg0jp3Nhd2w6CjNIQkMl8YFBnzUx5t8XV/L6+0xaeOd
         Q0mvT5QGXRMViByYClVNtC1wSGbuaZJrT+f5NFbIhXV6yaFaQljc0jV3hsOnqpU+fkRG
         F6GF55QONM5t1wYK/HEwIyhX8opzIqbG8RyLD8UNCIwy+CE8BNNWm53qRwzaX/xbjfDo
         WKcw==
X-Forwarded-Encrypted: i=1; AJvYcCU8XNQzlBfOTPpYTOBzSvnK0WOcAO45XRWuGrsFC88QeuS4CICkW8f+p2UFnpVO5mEsNKM5zEFWK0AHfBg=@vger.kernel.org, AJvYcCVW2l+kMJJUVWT3DCO3/fCk1CKPHjRMTRxbPKWJGksS2h0t7wpGjWawRWecmtj3oXjreyWgrWxYQtHrjf45AniHUw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy1OWKnrSOIPL5hOsJb1HWKjrzb0BXt0dMk/DxE0u8HkTdiLXy
	RofhtBBK9qpYYKRC/K0msvG+vHkdpFKxjtfKKrf4H/n/HOMac+1l4EaR
X-Gm-Gg: ASbGncsbOf00LM95/61zh3maGdpO3pXEDDBT/udBZH8bvEeIYUAO1d8sMqtAlwugBT8
	4vou9qBoHWgnQrcJCbtf53kPW7JTYL9gMvnBwzFWGTK4RekAIF1T5D0deLuzsNOP6wCQqQ3sueq
	zb/Ns77PBLDqV0EVESAUsDDt+2VLxsz9ahs4L7Hl8eqAjPGDEU1zrzgJ2mrNmLGmqIe1NJ+rtP8
	KUe24QF0jcBnfx42hA5QmtLKmvmwmGK+YI3GG/C3khlIdcxyk28XSoaN3+16y3SZx9HCca+NhfD
	ex0eeeiNUCOlexJafPGNgH8f7Il232X8i7hnfhwPif29m1MsV2UPwPu1eW+L440OhUoIqhTQ/sA
	rimKO/uxNCSsCmewL5hIbRIhPJ83Ic+4=
X-Google-Smtp-Source: AGHT+IHbrkynmdB+VZALfNq2GX+99oVP5YB+NxnCCnHaJD2VoSsYHYD/tPhZEzUFvZbEBFVaIld/YA==
X-Received: by 2002:a05:6a00:278f:b0:742:acb6:b7c3 with SMTP id d2e1a72fcca58-742acce03bfmr8113967b3a.12.1747499555696;
        Sat, 17 May 2025 09:32:35 -0700 (PDT)
Received: from howard-ubuntu.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb085ad4sm3330321a12.59.2025.05.17.09.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 09:32:35 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v1 1/5] perf test trace: Use shell's -f flag to check if vmlinux exists
Date: Sat, 17 May 2025 09:32:26 -0700
Message-ID: <20250517163230.1237469-2-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250517163230.1237469-1-howardchu95@gmail.com>
References: <20250517163230.1237469-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To match the style of the existing codebase, no functional changes
were applied.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/tests/shell/trace_btf_enum.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/shell/trace_btf_enum.sh
index f0b49f7fb57d..b3775209a0b1 100755
--- a/tools/perf/tests/shell/trace_btf_enum.sh
+++ b/tools/perf/tests/shell/trace_btf_enum.sh
@@ -17,7 +17,7 @@ skip_if_no_perf_trace || exit 2
 
 check_vmlinux() {
   echo "Checking if vmlinux exists"
-  if ! ls /sys/kernel/btf/vmlinux 1>/dev/null 2>&1
+  if [ ! -f /sys/kernel/btf/vmlinux ]
   then
     echo "trace+enum test [Skipped missing vmlinux BTF support]"
     err=2
-- 
2.45.2

