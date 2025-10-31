Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592CC175A5
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761923547; cv=none; b=gzmvAlcaZWhh3nXAquv8rn4VWpI+D4QapJkgKaacwcbRol+x+XljIzvwi4jjI01AVigah+eEfC4UWKHStWSTU24iatWeDA6nmaxN+f5kr4Fc4Nyrr6osGriJM9zBuSMq75Dnx7trEhdBYljxMXLZJwZP+8pZ++gDybYT6bGLkag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761923547; c=relaxed/simple;
	bh=91kxninMOJuDZGlQ785bNKkAwCmu72JTeQOT5NZzEjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UhCa+OOa6ZciJ9+iv1KQVbCxaSPnXWhJ4XEScWZ11WCPL6UjCDl9MY8BNqhK05kq969bP0Scrbjt/fdEa/1Ky4NATA2VYodxitfNdpebkttuFBQ7f5SA/jX1YjiDznPCcRan+0Sfhxro5dxjvOKS6Vvn98eUUT1A1XeBxAw7Sbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8o20q1Z; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8o20q1Z"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-592fa38fe60so3035516e87.3
        for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 08:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761923542; x=1762528342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FX+GUEAbTZu0XdxLl+sLP6JXHQTyzMeCDlR6Th/SyyQ=;
        b=G8o20q1ZhofSL1tSlGA0r8lCKnVdU6BfMluaTYExS3GR2zUtGQgKvEWs5EF7iKhGba
         fClj7Md/99KXE8xZLtaHLFRmGHEJBCntXLor1c3uipNPrbJ6UiZYMvN8jiqV1lZlpEIc
         IRt9xAnlCyyhv+diLVZVJB+2icb0DZ03zL9HKvciwJHvDFZcWbXkcWWz6F1QcX/aNhJW
         RPm210t+qokuNAjsV6oMek39qCiZ+yBD9t5x6ULZU505rkHh1s8Za9T9x8J5koMh2N/y
         Cauc8SROP7sDLnmwoEFN8MSOdmJPftyN0RCFi1XjfrXi0OAtfwVyBCQPvSE1PLPoMd7F
         DfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761923542; x=1762528342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FX+GUEAbTZu0XdxLl+sLP6JXHQTyzMeCDlR6Th/SyyQ=;
        b=elSvN9hxwJ5ZW1aGJ4Pl5AV1WlQb9RDXmO+j94X/Vt2alFhYm8vMyubEI9Gu+6mUSj
         BbauzuliD/Pcbm7Jeq1d95yoXR+JPt/FLDimbt4gnXMuppsMFUjjnO1Jg9ypo4Lkrh5p
         R9lg0+fjFyS+NsKwX3QkGZ7gh2cqWmRdEyLGoMNnFGaFcyiDeQuqpMqIIOC1A/06PTHO
         0qXqb+aoLYmXiYIawizH8nmcvllGEEIguQZqtprZxPilQR9I3XKpJQM2pATuzn7bjurf
         QB5gb5m4iHa7ZNV8SlY2sQHxZPyGIjQS5FWESTTWi8ruSbop02Yagd5S7oFDkp3oH7gP
         jrdw==
X-Forwarded-Encrypted: i=1; AJvYcCVwJ4daHcsaUz/iL04ak4hUQwFyqE/94XBWpPIcjqkfbTcHXW+iJiVni6Wu8Kt7/gIjd14Glt4bTtHSo7aj1GG+@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx1ISdPSAst4YqGWIw7JyTqUjrOUEF6nbrS03t9N4IQibyDdMI
	3QnoGg8IoKIefkNXFdTuM0/yomjJH0+lNcf5em9YaN95cf+pdLruxxDz
X-Gm-Gg: ASbGncstm7T8glk4S/kVe7iQaNIAEKTy0XbPB/Axj5x0rHtPoZOwR63rEISYCXtz0xS
	/mUoepgx0y9QD2e/0vDrF/kSaf3qUHJrcg5x13kbRo2A2+MM0iC84ji77AEBGNMNlcqKp6f2SSd
	7j3kei++nOCfmnAyIO/3Tde3MKPLkVaUlxiZIWhw6ejEe4do1D3NBeakzwKoUvqSpBtL9ZEzRZc
	DilDvXPn5dzQITHrsGTMKT1npM+T+aICz9idnXBJkZLcchndLLEQUh216qr0W1qWLNEFik0FUJH
	AY46058DadQV3H0AP0vnxQhtanojIj4B+2Q3UbzVrZH3A969NEeiZXocS8yq9eUGU83tvXzBoIJ
	hdnf+6NoAUN8HlynhjGru/sFfVs8pXcZ7Bm9l9VCoOxqHqMwVbHkNJrPyzaD1NgYYdLncEZ7HTw
	==
X-Google-Smtp-Source: AGHT+IGKbvonzx5y7ZgpL89fkDF2JVwXxKaHQ/ejt1OdBE6Ff68ddmi04P4EWTQqdMDYjNDgQ/iG9g==
X-Received: by 2002:a05:6512:3b1e:b0:564:2556:5bb8 with SMTP id 2adb3069b0e04-5941d53ee64mr1240323e87.37.1761923541591;
        Fri, 31 Oct 2025 08:12:21 -0700 (PDT)
Received: from archlinux ([109.234.31.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f5bbf47sm569710e87.82.2025.10.31.08.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 08:12:20 -0700 (PDT)
From: pgnmirror <vacacax16@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: pgnmirror <vacacax16@gmail.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org,
	zntsproj <vseokaktusah7@gmail.com>
Subject: [PATCH v2] tools/perf/tests/make: use IS_64_BIT for generic lib dir
Date: Fri, 31 Oct 2025 18:11:14 +0300
Message-ID: <20251031151114.5642-1-vacacax16@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the IS_64_BIT flag to set the lib directory generically for all architectures.
Previously, this logic was hardcoded for x86/x86_64 only.

Signed-off-by: zntsproj <vseokaktusah7@gmail.com>
---
 tools/perf/tests/make | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index b650ce886..64066e011 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -53,9 +53,8 @@ endif
 
 include $(srctree)/tools/scripts/Makefile.arch
 
-# FIXME looks like x86 is the only arch running tests ;-)
-# we need some IS_(32/64) flag to make this generic
-ifeq ($(ARCH)$(IS_64_BIT), x861)
+# use IS_64_BIT to select lib/lib64 generically for all architectures
+ifeq ($(IS_64_BIT), 1)
 lib = lib64
 else
 lib = lib
-- 
2.51.2

