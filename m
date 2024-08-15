Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E76B28DC1;
	Thu, 15 Aug 2024 01:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723685814; cv=none; b=DANN4ArgE1hishkw9zw+0TepYJUe11432EVr+E3zhuC6VVoRpXYMeWyS/k9Nqis8TUOrUvK+1Awpij49UxeOHvldv9RgbH1YP8hjcZf3XxLFOMS3VXmy0qwIwCK/EnJm+1gJUGUU/FQcQ8ZWNOzq9m/PjJyABE6sGd9KF/tvJeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723685814; c=relaxed/simple;
	bh=c4gO+uQ4Clme1GERd/mFuj0vU9FiRxLFgXlUCt99pm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wg+BQSseOKO1j2g2Ad0PW3hBEnpBoLd9fvoeJSA7cJWE/gYRqNK4N/qergMiiyedYHPlJqdNOCaoWYYEuVRP1ZhlclZes8S2BrjbCLLsCwJmh3SOiGAp7jQJdUiB3Es+6aorxT3Ex5zwvVDuN29PTgAKXQr+ttT5WjX38e4WkMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F39OtrwH; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F39OtrwH"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-710ffaf921fso297904b3a.1;
        Wed, 14 Aug 2024 18:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723685812; x=1724290612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9A3SNQz6Q2O70xZMekgjWFxO65DMYvasXErryb0PeBU=;
        b=F39OtrwH1s09bl+YQx+gXkfAgUCtmbl5qxObEdNqiQVJVBY1h4y75xQTqKzQF7yOfV
         0hpu2X1BTWrFYhv+dlY7pWp+PIIQdvRHyCu+LUnf0jnw+2d6TYh1KMwKnkvZZa1h17wX
         05h8x6n+vFTKPTxPlgh3fyz/yZcaDJpuCR+ghK/92e8juealZF4huuCxXdKz4P9YyzFl
         E2QWXq9L3dJIjxXCxbBqI6qRZZeUaRrR0bNs55OtHH/dvSXtvByqleRTtVMKYeHIi0Os
         En5kprU6mi3SxhUIIerPrgNlCcJlXuLVDa8RqIDm0cRCi8Nl2fehCOM5vUP8jx81VUrF
         18Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723685812; x=1724290612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9A3SNQz6Q2O70xZMekgjWFxO65DMYvasXErryb0PeBU=;
        b=qfc8+kjD/7y0F8Ah74V9g6olqH32e40ldAfEy1yHhunD9zCEX69B0ze1Nki5aMSnv6
         wP+WWCndZ3CLy/OqJRwcp6qSY+w4DHpjgZiR8M7f4dY8jlEYco/PK+1gExo7FwQe1ism
         jHuuwnk3cBMxIdISyxMYbjMevXNEdIiGMFtxDwBr994OWe6+1vNgLSVT4mlNiw5I44ha
         mX0cwx9N90HwXM5RIXQ7/jybyeZuIHfvJRNh9WDCntvD445P/XF2iUzRj8D9uNGtpmO+
         dZoJmRzjUHJhiHx2VF8z7yh53vijYPMsU0/dSXt0HVPA4vgeUHUGViCtiFg+Fd7HwYro
         +7hg==
X-Forwarded-Encrypted: i=1; AJvYcCWypMjRGBxgviQ26qwTbB05h7gItNHcIaIwVvQzSvaCKJZUo7C9xjZwop0dKe2yzTD8fTOpPNmn6rz7+lH9sQSwkmX2T+ZC9Tkl456H7o3h8V/LyXArWjVSP5HIIXSZta3HNVNTEGsRGjxDkJKVwQ==
X-Gm-Message-State: AOJu0YxoBmrKv/tnu1o7pEQ5T58MkUY96vsaXmD6ohRggRvZCA1WVvkO
	LTr6w/GMMkLnda3cW57zkeH7VF8onsnM7gLp7ABq450Y1rxJK5XA
X-Google-Smtp-Source: AGHT+IGcpZpxht0aKk1jUzDHexhoN2F8wWo5Apyq7lg/ENnWyXkfqiRQVEpvmtOuI6NzOM39UsALHw==
X-Received: by 2002:a05:6a00:138a:b0:708:41c4:8849 with SMTP id d2e1a72fcca58-71276f51c73mr2003989b3a.9.1723685812484;
        Wed, 14 Aug 2024 18:36:52 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef412bsm196842b3a.123.2024.08.14.18.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 18:36:52 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/10] perf trace: Add some string arguments' name in syscall_arg_fmt__init_array()
Date: Thu, 15 Aug 2024 09:36:20 +0800
Message-ID: <20240815013626.935097-5-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240815013626.935097-1-howardchu95@gmail.com>
References: <20240815013626.935097-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add them so that we can augment more strings (which is a file path)

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/builtin-trace.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e7e8c89d9538..84c7398312d8 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1918,7 +1918,13 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 
 		if (strcmp(field->type, "const char *") == 0 &&
 		    ((len >= 4 && strcmp(field->name + len - 4, "name") == 0) ||
-		     strstr(field->name, "path") != NULL))
+		     strstr(field->name, "path") ||
+		     strstr(field->name, "file") ||
+		     strstr(field->name, "root") ||
+		     strstr(field->name, "key") ||
+		     strstr(field->name, "special") ||
+		     strstr(field->name, "type") ||
+		     strstr(field->name, "description")))
 			arg->scnprintf = SCA_FILENAME;
 		else if ((field->flags & TEP_FIELD_IS_POINTER) || strstr(field->name, "addr"))
 			arg->scnprintf = SCA_PTR;
-- 
2.45.2

