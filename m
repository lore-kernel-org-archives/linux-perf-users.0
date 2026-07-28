Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4758B349B0D
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Jul 2026 03:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785209780; cv=none; b=mRcFUXxAU0hfZieTonokE0Dz57iozhcsbOYbDjnHLr6yQ1WXXVF67KmAjiAKHId2H/bX4dQ0bb0QAz4RJ0HW2UuldnhoDcKqtJgwSMAIuzERQ4JXrPZiECGfK5TmJTWJViW27f+qOf8A9ArdgRjikk03ZDrZ1MsJeHjEaag2jXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785209780; c=relaxed/simple;
	bh=GpS2JFnB2ewM0P6iTWx+8S5QdjPxDiOe4wzSD6rvXxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LD7Ymxb6zokHPUym3bg6gTK4birdzgRb+z4OqxioU60vpRyrc12NtxNsZrhGPpLpWgSJne7ZvBoE22Ko8cv3eRjG568ZKVhmlAEmM2bf82VdfsLjr/ayUZHjd1ct2AVYGa/dFTE6Y1b6AUuMvz55Izb4gGnQGXKzwgGJPO6wDVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iGbPoPHl; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iGbPoPHl"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c998fd549a8so2353369a12.2
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Jul 2026 20:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1785209776; x=1785814576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OTv+ZI9c6fC7+DaQLSs6uSK+t6kk33LjEjqmF5l8N7k=;
        b=iGbPoPHl30KjLs7vja+dvO2YMfwN//NplaWit/zm7m0Ytm/gu7zgCQyIw0Hwokjqn6
         fieFMIYfXeGixPAuba2fskmGVsAr8obPyfztJBOMsEiCHyW28Jdv2c2wyhtAXEpYt/cy
         jxPpFdnq1vZjAHTg3HURoXr605a+7L5OyYJPgHWhaMkSBTi86n+DIA+p9bi3RCu9nhj5
         1jMm2rG0J/iJCYmx3Q2DD2itM71LYVbymfVt2GPDxgZOBqrcjuF7z8G7MAqOyPQtPyJx
         egP+aO5dHzOwYF3t58mXJQqmkz7+daqsjMDSQud4hbjZg//GgOe4hTCf00eB8dDKO14R
         UbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785209776; x=1785814576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OTv+ZI9c6fC7+DaQLSs6uSK+t6kk33LjEjqmF5l8N7k=;
        b=O/ztjYMTs9JMjdmb+ZHGJi0URWLOZ2gl3E73ht/gt95ek1C8EhK2LOUK28YL6ixUiX
         YmufvqLO/Z4a/RVOtv5AqRgxF8Y3zKmONKh0hgbQFQI0CWFETReN4rWydaeykNZerQ1M
         Vzbyhjn1pOQqvjozrPOeuQs/Du7CXv1dk7GbwcDdx+ikVqBQzSS054vE03o01oB2tg7i
         1jPiBISk4Bd7OHdLa7fuV8WPAM3VDytYgwW7OUbqWHYi+RBGEdPbPbTUE+My2tTeIifC
         5tIQIX4Am4G//1rBhDejE2F/xJqe9hRAMVRdE4xAc7uLi0gPpPoftXyB886UnfzKGxLu
         PNfw==
X-Forwarded-Encrypted: i=1; AHgh+Ro6COcRnJHdP5fDtK1sui6XKcXz11YywVTHpGEOvvn1oD1/rU0GmIV3CzR4tDLu7gVWDzy3GHIcBrb/57C1oExQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyuWheYwKO40k/mOEYNLfoeC3n3D5E8jXuC/Q/LVoeHKUSTesQC
	gMq2sLtA+GDIMpicNNUH7dwaV17KE4PC3YVvAL0XQvgFzRGoBkijVo0XrtpcWD49D/A=
X-Gm-Gg: AR+sD13vWWhGoz3GPm5TR2VJqKYwCpi8wODtE1bQLPt5V7KszbNifAsugSQiaAGtUaJ
	rXStpvvOVKLSR+ugGPh6O4RRrYDPagPJBFdlYcdHy9JJcvRIC+hwKunANyJVyfK5LCBJL/BzWjr
	EP8T7GALea3smM+3mESjsyXi1pWCixIFSuBxv1XHb+gPl9DKYfG320dZLNVAeqstK/MOa+9LbTB
	dK14di+CoGscMPs563mfi54HNm47PUdj6/F5pTsHUJ0wakkbA1+b2u5eINBiQxSKzfEjU05BHCi
	UHlzfnnrHi49hCLArvyJCtL6Ku1oqiVL9Yjx1iR2Q2RwpciJLWRRHpp9zVazONtoaNR57ObKvG4
	zQQsQbfvECIG5k5sKFcW+lv/MBEMAEHgmApiG3wzZpUqlaZqBL8dIZUkc+fIt/SiFvdWcPj4Esm
	HbO4ATg6QlIxT18w/HNK34IbEyXAt+1LpLKp21QT+lUBrvPIbfqoisk7brij9P5gtBDSUceeRtW
	Yl5UhKTo3cgDSI4wmSCI2DshW20SIItfSb6eQ==
X-Received: by 2002:a05:6a21:b8c:b0:3ba:cd5b:3dc8 with SMTP id adf61e73a8af0-3c8ba46c563mr928062637.31.1785209776301;
        Mon, 27 Jul 2026 20:36:16 -0700 (PDT)
Received: from FJ7FR2JRQ3.bytedance.net ([178.93.176.7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d13003f12sm102135749c88.2.2026.07.27.20.36.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 20:36:15 -0700 (PDT)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: acme@kernel.org,
	namhyung@kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	cuiyunhui@bytedance.com,
	yuanzhu@bytedance.com
Subject: [PATCH] perf symbols: Skip dynamic symbols with invalid section indexes
Date: Tue, 28 Jul 2026 11:35:53 +0800
Message-ID: <20260728033559.90302-1-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V post-link processing can remove relocation sections from the final
vmlinux while some .dynsym entries retain stale section indexes. perf
aborts the whole ELF symbol load when elf_getscn() rejects one of them,
discarding otherwise valid .symtab symbols.

Skip only dynamic symbols whose normal section index is outside the final
section table. Keep the existing error path for .symtab, reserved indexes,
and other libelf failures.

On an affected system, the vmlinux symtab matches kallsyms test changes
from Skip to Ok. [unknown] rows in the same perf.data change from 41 to 0.

Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
 tools/perf/util/symbol-elf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index f6f6b54da131..e955c3feddcd 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1681,8 +1681,13 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 			continue;
 
 		sec = elf_getscn(syms_ss->elf, sym.st_shndx);
-		if (!sec)
+		if (!sec) {
+			if (dynsym && ehdr.e_shnum &&
+			    sym.st_shndx < SHN_LORESERVE &&
+			    sym.st_shndx >= ehdr.e_shnum)
+				continue;
 			goto out_elf_end;
+		}
 
 		gelf_getshdr(sec, &shdr);
 
-- 
2.50.1 (Apple Git-155)

