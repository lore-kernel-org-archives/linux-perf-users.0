Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8EE43689
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Oct 2023 20:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YXai4Dq2"
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A9019B
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Oct 2023 13:17:58 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-58916df84c8so1753360a12.3
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Oct 2023 13:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696623477; x=1697228277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O2df0s7T7DwAtvRnEkwYeLwhw10mfRmv/AyASXBMHso=;
        b=YXai4Dq2sGsTEOAhTy0aoK2jij79wTK5olD/+iI+s+xqZmfwYqA63f5P4nIYCnA/Jj
         3UugGymonMmtcAyWNCyj7Yc6gXR6FVi6u2gKoSbXsT0PtelCq7+w/LmogPBPtaLJH669
         Zm/6xegAlsWoc4ZyyNlVFnioU22rFDrATrQc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696623477; x=1697228277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O2df0s7T7DwAtvRnEkwYeLwhw10mfRmv/AyASXBMHso=;
        b=A+8pTOjNWny82k2UKI5SL8rEpL6u72U0BxzJPHmjxxtNujNGoW1gmAGgYUaRw4YsXX
         VikPoGZeGo/dELDqZdJMYN6jA7SxaBLsRAN/7zf1z64EbNOu7XL3Iox3dfZ6I61Umjou
         kYYmLvKuVYvgEVYgC8a8kj9hJO6sbFW8hfoWW6kEQacZTJmQocVSOKO+Z6rhGL2A4COK
         qWQb9gtGqg58sk7jkNw7EkvAG7Y0pF7T95FiI7jx56Q8ljJnYgcCnB6D4Y4GjSO2MNBD
         jy65ca+C0vOahBcx7dKp60jzIxqMiyfkhZuJV+7ayR3Gn9FgZLSHCR576RjvGgrY8bcP
         RcCA==
X-Gm-Message-State: AOJu0YyyA//99hAiZbsduQpP/Nldnd74aJa/V7Dd65lO7X2Bx1sbahgB
	ShBVSruN0r8F6Ugy5gW+rkAazA==
X-Google-Smtp-Source: AGHT+IFuTJx33CghSF3Da0ep13Hnh7Szq3G/xAyGso4fwnb7Rzz9Icwv4gUdekOWsJS/F2HtAc7qcA==
X-Received: by 2002:a17:90b:4b4b:b0:276:79b6:8bd6 with SMTP id mi11-20020a17090b4b4b00b0027679b68bd6mr8931211pjb.15.1696623477195;
        Fri, 06 Oct 2023 13:17:57 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l12-20020a17090aec0c00b00268b439a0cbsm3938389pjy.23.2023.10.06.13.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:17:56 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <keescook@chromium.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] perf/x86/rapl: Annotate struct rapl_pmus with __counted_by
Date: Fri,  6 Oct 2023 13:17:54 -0700
Message-Id: <20231006201754.work.473-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1695; i=keescook@chromium.org;
 h=from:subject:message-id; bh=0drUnBz5ZzeWNYzRelIIqK9QIPmE6lOPX4gIPEmIa48=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlIGtyvrX6v83QbzPXJ5dTBvLyzF6pqlRJw+9O+
 IueqOLf5FmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZSBrcgAKCRCJcvTf3G3A
 JpusD/wP8pAHR5OToG3w0MqsR8g+9U+NGN++3UuuAB24bMqNos6WKIV4PuytR0dEPoFxZv0n0WK
 rD/g/kXPqYmtnwxkO4uQPqSHwpu8hbhVaqeJnIacctZpmyzLOf61lAbhckX71WEtm7bwGaJea7N
 gvTrRmxHsjHFZBnibGz9zxhjMdgcwHzdltFDVYiL54bi9vgzrKzsy6+MAqwtmN+cmC/2YxGoZs3
 zTRlmAaVlGEOpJl4OBd9oqB1YL+D7TAuXAB8k6TVBQQ8MYyEsMspkTuOO9i9gsSQC+guMzaOdNq
 XET91Jfo/Djb+MF9muIiX2HBKzisNxMg1sviXSwX6S1RZ4HRdJ9c++9DCcslJPUD3hSbJ8N2xDr
 yIeQNYH4WJMozBbo0UVonSsb/c0OeoYVghD5fKTQbklFel6JFto4hcxEnWHk+yBktnTROyVHrZR
 qT1Ju4TH0Usbo2NSH6BKuFNMkrdMeTVloFeaRDxqyCZ163ce3FbRgCLBjTqx/2mbu0ZMXysfd90
 abETP0AyBsqFDbzcUgEtk1lNEDvmU3bevXe9kOCQ8o6yRrKhWVeGDsPWFFkknF38Xbuab/F4lry
 9S7DLlfj6WdBJtTAVL1ubY1oHvCkAxH9vhJDgOictH0Hdn7ubcW/kIpon5tKCr+3huZQY1NHaiz
 7Yaqpmr PH9qpiCw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct rapl_pmus.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/events/rapl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index c2c37fb0a228..8d98d468b976 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -115,7 +115,7 @@ struct rapl_pmu {
 struct rapl_pmus {
 	struct pmu		pmu;
 	unsigned int		maxdie;
-	struct rapl_pmu		*pmus[];
+	struct rapl_pmu		*pmus[] __counted_by(maxdie);
 };
 
 enum rapl_unit_quirk {
-- 
2.34.1

