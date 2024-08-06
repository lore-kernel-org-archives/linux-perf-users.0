Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F3E1C463F
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Aug 2024 11:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722944910; cv=none; b=lubfUP6vfXOnmNrJMCMtBigrXchwN0/CZb6cTgAKyt6+Ayrdqc3sfyswTh6+Iiz1TLWFuw7urf9TFfko6PRGFJOVO0Fof5cz6oN8I/Jwfd/X3qFU4Sai3MG2VCUWbr1ETTJj6LlkEJ4AjR9GZnknZTUSbS9Hp9nOIBQ90SZfXYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722944910; c=relaxed/simple;
	bh=w5HQUkEOQZ9OiMAzw+TwotIyqt5lF9ZFZ6Io5hL+Vpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qu7aGwRcYduwU30Ak0uLdH9S90HVaiStqBBNjuGy048vs2YNOc1nrN3vNtnpBYMERyliQsYcZ7WkgrIUja9WavzyDFTCEbTMEwxhaIWRbT6xevXf23CxH76pNpAstc38wZl2/kFqVqF5Glu/YW4r5qyza/diErfs2VgSr4YlvfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=krL8wpTU; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="krL8wpTU"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-25e3bc751daso260399fac.3
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Aug 2024 04:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722944908; x=1723549708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHmg1SR6T64IROlakovGV4e3PjU8whLQ8HGL2eHtGe0=;
        b=krL8wpTUfKRG8ru4VZdVkWyeL3x0Jrgy+829XPRjtT2oM284hrTYcjy1BcBVaFpsp4
         SbfYfQdKYLr/mlYOZx4kNdebdJ8CZlqDZT0LAI1GU5JASyAy+u6JCdGv5uS1S2lXNzjC
         aKBpP/uohepaxqwjZH8MoIv1PKmC0xE4uzBTmhT4ABherGj8Ye9inaRY4a8PcKXdagC4
         PsIvjol1uab8Z9h1192CK6Y0TMEzoMif4bn/ezvyU49QWrhgYyZ0PJZs5jaqsA/gUd81
         gBhPNqKacI1pCJHDuvAetrik4W3UgEvxEQ0BV1W33cHpXuus3RXc2cASHFX3cdE7GjFk
         rPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722944908; x=1723549708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHmg1SR6T64IROlakovGV4e3PjU8whLQ8HGL2eHtGe0=;
        b=D24KfFiq2ClcPDzEUIIdFZFI6dotWCsj4xzEBIdP2YkSqR0O5WZZQzcxnqHX1/O4BG
         yvbw0KoxDn47gSyOHVsKzG/6psYGi4jBKcNhjHz8BVrvLUGZc2PNS/zic4/B0HnAWXoa
         xGYSFXCWu5eNML8q54aTImsYiQC4j5HUtFMrvhnmhYKq4PoHwGsOGxXByu2t2OTG17dN
         S5LXT05UwGWFosOjnmJ3yfstFJvauR4Ua+e5X7Ou6vx6YbM5kVnAY3MBc2EI/Rjb9pJi
         UOiKTuwQsKAvQm22+WMDMLzzbA5qDap5mvu0GrYq0iRaCV1Nl7X6SAJijPhV/GoShQy8
         EqwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHTsT+7vCAduHfzT1+yBVtWqWOlYhWN7ZCQ7R+rEdUE1JyOF1+M53Y0he1sLxQQPM1NlmrarYNMCaPsQ5ltr0i9QuRlHipOnYVoKKNzgRCxQ==
X-Gm-Message-State: AOJu0YxL6uHF5VO0Iy8If06yCTwJlRUjc7TFcJfAezeMv4l7YwE7aML8
	ZABHurHZozwpznDo5vyZCHFk1BRLIpaJXO/+xgZYO2DadqUs+rb2FcMtYlKoOgI=
X-Google-Smtp-Source: AGHT+IGdkJ8/XmVLszO0PEPUN3TJ0RbZR+khjrBSEWmw3Rmb098Lzmz2r3RamSHWf5aQzQ8x+42NYA==
X-Received: by 2002:a05:6870:96a2:b0:254:a917:cb38 with SMTP id 586e51a60fabf-26891d4058bmr20651507fac.27.1722944907835;
        Tue, 06 Aug 2024 04:48:27 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec43944sm6831705b3a.75.2024.08.06.04.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:48:27 -0700 (PDT)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH v2 3/3] perf dwarf-aux: Fix build fail when HAVE_DWARF_GETLOCATIONS_SUPPORT undefined
Date: Tue,  6 Aug 2024 19:48:01 +0800
Message-Id: <20240806114801.1652417-4-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240806114801.1652417-1-yangjihong@bytedance.com>
References: <20240806114801.1652417-1-yangjihong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 3796eba7c137 move #else block of #ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT
code from dwarf-aux.c to dwarf-aux.h, in which die_get_var_range() used ENOTSUP
macro, but dwarf-aux.h was not self-contained and did not include file errno.h.

As a result, the build failed when HAVE_DWARF_GETLOCATIONS_SUPPORT macro was not
defined, and the error log is as follows:

  In file included from util/disasm.h:8,
                   from util/annotate.h:16,
                   from builtin-top.c:23:
  util/dwarf-aux.h: In function 'die_get_var_range':
  util/dwarf-aux.h:184:10: error: 'ENOTSUP' undeclared (first use in this function)
    184 |  return -ENOTSUP;
        |          ^~~~~~~
  util/dwarf-aux.h:184:10: note: each undeclared identifier is reported only once for each function it appears

Fixes: 3796eba7c137 ("perf dwarf-aux: Move #else block of #ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT code to the header file")
Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/perf/util/dwarf-aux.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 24446412b869..d2903894538e 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -5,6 +5,7 @@
  * dwarf-aux.h : libdw auxiliary interfaces
  */
 
+#include <errno.h>
 #include <dwarf.h>
 #include <elfutils/libdw.h>
 #include <elfutils/libdwfl.h>
-- 
2.25.1

