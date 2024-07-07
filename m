Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EC15381A;
	Sun,  7 Jul 2024 18:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720375453; cv=none; b=L5OzU0Im4K667bpUc87AdVqnNSpUywZvJfoj19gAvBjaqGYWMVBC5P33uA6lXOxu+wXO1jUnCp6VMnjkZgD7yCn2M6bjw7RTyyfVq1+VPgpRHYCXrU0tJsX8vWX7De1OqsJl2Hou+S3SC+4kcIgyFXtqMYZeQ8ncO0ZO4W7Ltto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720375453; c=relaxed/simple;
	bh=K47fHQJ9LxfBh1bNZxGRumkL7Or0ODoH4AVvfxblhew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CCZJjgpbiFUDFcxXkznTGfDSNpclxVUpispa8XFF5RdgYabeGmsopEcnvtz/JbEyIGqwHKfTCYpk3VObWvhfn+KaZx+GtURf3JzFeUcfDIVSvqWVgXCDza1UPWnTAWlBB3wMYxJjc59Owz9ZkGuYK/kO31uuDnjcu1z2o/EikZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYnc6nMF; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYnc6nMF"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-70afa821435so157512b3a.1;
        Sun, 07 Jul 2024 11:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720375451; x=1720980251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71PIMnaX2w9geLkGMT4scoxspKSo3IeLc4QsRMQ9jc0=;
        b=OYnc6nMF8of/c+9QiqMdmpzp4A9vU5ZB3tfMElWRwPxCR2b+77mnYT/55Avu3xkkQM
         KspDqUYNTFNiypU/EtUj3ezsfmE3ctaGjBHAlj3kM5KydWx0cXfEag8lyxSyWj8zPE+Z
         0qXNK2jFqWvB23AtXgOtLdFeYbDizVSrKkYMK/YIbhH4BDJjRLM00kKL1jLQoW2jo/ME
         yNlFbW4H2vcfvDTuISLWB0IaTXWj7d4Ql1YtbfLDeyGsjca4JCMWkNCQEOXWuU0Bw1Gr
         76gk6FPUAP/4vwETJZ2Czl4l9fGOI83FVUAmlQQ0mmiVAHhmTIBBZXyccgObhSoAnkAY
         aiOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720375451; x=1720980251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71PIMnaX2w9geLkGMT4scoxspKSo3IeLc4QsRMQ9jc0=;
        b=Uk9sGXO26S4NVug+89C6iaMGWu0a9VnuUPGS1yJaZbAckoV9+I0OCwwYW3Yn94whPp
         k7aDq65brRxW8Zt/6Y/AtjTP6a/kE7LcCan0ge+F7q0IvhSgDmCc+gwz40oaKCNFj9VQ
         M14DpBMQFF+ixThFSCodWyID75X66ObIrLCUEFQ+TGCAOO7EMs0tkUJu0YA6EmaGbcF3
         cH+TlTPlgSTdmYYMrz1xKFb01Hpdv19oBE+NPvVTnxFr/RqineA99pm9ZiSr/1ADIERo
         a9ibjmC1PQXb7GylSqLZR8AbdUWNCa3Mb9H1d6Q3AsDgg5ditEhNm8OFYCXQWPgbXNCU
         BDPw==
X-Forwarded-Encrypted: i=1; AJvYcCVTpjelDE7a+uI/x2nAhm2cvh47eus9VtYn8Z3M9WceYJRhuUBL3igJaKA/wbzjQAuaR5SP1FKEhVU9jXisssdrRWanF9IGPkhnXaM78SiWiQSrnds+T50wsVPXHF1M9NVwScQAt+4mvZpnxwdEdA==
X-Gm-Message-State: AOJu0YxWeEKq6Vzhl43VZuY7iLDKFHNU/ydnyExs2dyyLXII3PQLffic
	tCOv+QynG/2dPoiMqDIdqafaFBEQSoBT5EKY2arjC77ebrEHTgFP
X-Google-Smtp-Source: AGHT+IERY1aGYCcVWHrvfYxYnjDMmrRTVnCrQGm/xsVqSY80rFLs3d59Wy331T/8Es0xfVxmUImx8Q==
X-Received: by 2002:a05:6a00:178d:b0:706:a85d:bd60 with SMTP id d2e1a72fcca58-70b00b98859mr10214751b3a.3.1720375451573;
        Sun, 07 Jul 2024 11:04:11 -0700 (PDT)
Received: from localhost.localdomain (n058152114213.netvigator.com. [58.152.114.213])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b1d9bbaedsm3031750b3a.172.2024.07.07.11.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 11:04:11 -0700 (PDT)
From: Haoze Xie <royenheart@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoze Xie <royenheart@gmail.com>,
	Yuan Tan <tanyuan@tinylab.org>
Subject: [PATCH 1/1] perf build x86: Fix SC2034 error in syscalltbl.sh
Date: Mon,  8 Jul 2024 02:04:02 +0800
Message-Id: <2143cab4cd8468c88860f4e5e382d0e6b4d89ac9.1720372178.git.royenheart@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1720372178.git.royenheart@gmail.com>
References: <cover.1720372178.git.royenheart@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the unused var in 'arch/x86/entry/syscalls/syscalltbl.sh' to '_'
when reading from '$sorted_table'. This change allows the script to pass
tests of ShellCheck before and after version 0.7.2 at the same time.

When building in arch x86, syscalltbl.sh got a ShellCheck warning, which
makes compilation error:

    In arch/x86/entry/syscalls/syscalltbl.sh line 27:
    while read nr _abi name entry _compat; do
                  ^-^ SC2034: abi appears unused.
                  Verify use (or export if used externally).
                                  ^----^ SC2034: compat appears unused.
                               Verify use (or export if used externally).

The script reads unused param abi and compat. It uses format '_xxx' to
indicate dummy vars, which won't work properly when ShellCheck <= 0.7.2.

According to SC2034, the more general way of writing is to use directly
'_' to indicate discarding vars. 'entry' is also replaced by '_' because
it just happens to be defined in emit function, otherwise it will lead
to some misunderstandings.

Link: https://www.shellcheck.net/wiki/SC2034
Signed-off-by: Haoze Xie <royenheart@gmail.com>
Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
---
 tools/perf/arch/x86/entry/syscalls/syscalltbl.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/entry/syscalls/syscalltbl.sh b/tools/perf/arch/x86/entry/syscalls/syscalltbl.sh
index 59d7914ed6bb..2b71f99933a5 100755
--- a/tools/perf/arch/x86/entry/syscalls/syscalltbl.sh
+++ b/tools/perf/arch/x86/entry/syscalls/syscalltbl.sh
@@ -24,7 +24,9 @@ sorted_table=$(mktemp /tmp/syscalltbl.XXXXXX)
 grep '^[0-9]' "$in" | sort -n > $sorted_table
 
 max_nr=0
-while read nr _abi name entry _compat; do
+# the params are: nr abi name entry compat
+# use _ for intentionally unused variables according to SC2034
+while read nr _ name _ _; do
     if [ $nr -ge 512 ] ; then # discard compat sycalls
         break
     fi
-- 
2.25.1

