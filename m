Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C815381A;
	Sun,  7 Jul 2024 18:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720375481; cv=none; b=PcrZQ8TM9PCy8ExVoSgrj5o5b6VRmbjghXGOBr/f4DY2M5dii6N6Bj3VfrjaCNo0t3qZ75rSUlMB2UwscO398wzzvQfdgM/SGlfBEErL58/ddSj4rsQb1Ci42aD7wHK1yTVVpB8ZgyaDzx6sXinEfMjurkOurPmCsPCXXhEcQ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720375481; c=relaxed/simple;
	bh=ORaqXEGJmsmQKYSJYCydG/l1/+Mkru7MKsPuN9IGoLs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fLMYlahKorOfNOPgRj/aHCXNWEpkqk2YE3wkucHwyNmPIirIP6MHezfwXtA3q2E/krkOwXdGkyOe0oGgkykAgFEfe1CajuVpgvFzIzrT5sIHAnjNRydIG4hff7nUMZgnXSvJnFGrQPithq5a9ip3UsD8lBuSfvU4yxayYpzwPhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYS3IFqP; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYS3IFqP"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-1fb761b1f8bso210075ad.1;
        Sun, 07 Jul 2024 11:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720375479; x=1720980279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHcZJDRcnyF51TE72qmoMaYSiW0BLRwh4RkyTqS2LqM=;
        b=WYS3IFqPqP1jWYppNcR9hpDplPkR15hcUiQIU++JPsgCDaVWUeCyV29bv06j+ayAzC
         MlnTp3XPfPU4+K3cnk1KOPqXp38MaAExm080+2dO8EAzyPotPE9944kdcBaFNZUvTIWu
         DU0EDKMavdvJyctKeJaWoqdhwB5Re7jEXpq5ayZ6+Ln4ARVHuFeThWVDKi+pRFh8K84h
         /ZCY9k+6zDoo304uHLrEN356MX6Tv8ebzqU7VM/LDk0CkwjZ5QJv9+JHMz1D6rUJXrNV
         BJor53SBmB56/PAEOqUnzANuJQZ41vZq9prq16USpW/SHonVBE3NNIm51JDKB17VHlVp
         k/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720375479; x=1720980279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHcZJDRcnyF51TE72qmoMaYSiW0BLRwh4RkyTqS2LqM=;
        b=EGSvVNeik9CpH0VCMcODU4q0zORTX0lRdCY9N6C9yL6opf7jJHOmjm6WG1JLgRTS/G
         EvcbzPLnfiYtGJ1iBD3B2PNlhzPA9LOC+8kGaiXeUOzhPovyN+hXO0UNe3AH1OyRK+fB
         COLdIPgH2DIZz1uE/3/jYMiWTm5AugxchaoUocApgDaVeZzG8cFw0Ty3BY2eTiQMN+QQ
         06C9ex9xfb1WsB/FmzTA/+UIMGFbEtSKrF8ZCoUuPHyM6xeEGrzHySDcgCGP7mG2e2Ce
         p1TrSBozUtrhDmzgcODmEBYNNyQs5ovuvxZ3QdC9KSe4NeJjkExnLaAClw/AnCw/Cv4a
         xf7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWz3JUAtHVrABEPFkDCWaZrynPTsRjNFGOZTsdqfLiYo+EKzBiWI9kcjaL88AvabP/BBPStDAi8cr/fqD5e49DSatM+CIJ//09T1PZAvdpDOD/2XLD6G2O0xFRqL0iNuclh5rz8RErwCzJZCPOrHQ==
X-Gm-Message-State: AOJu0YxQBcNserXJ/RrgKEDD0cYBt7aBe7ER8olKQ9WdoLK7RmnEhw02
	wm/gApGodt/H1agjrZg8DNAB8e7SwXOoFuhVEY8HDvZmvxLJU+Yl
X-Google-Smtp-Source: AGHT+IE0ZdHZ3PIlehaSvkf9UswEFf10IE138dkgOFKFM+QKxkWg1hI5r5VL+HRxOhT7iO64QsvXIw==
X-Received: by 2002:a17:902:d484:b0:1fa:a9f5:64b1 with SMTP id d9443c01a7336-1fb33f0e791mr125318405ad.3.1720375478554;
        Sun, 07 Jul 2024 11:04:38 -0700 (PDT)
Received: from localhost.localdomain (n058152114213.netvigator.com. [58.152.114.213])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb8ac94abasm9610735ad.125.2024.07.07.11.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 11:04:38 -0700 (PDT)
From: Haoze Xie <royenheart@gmail.com>
To: vmolnaro@redhat.com
Cc: peterz@infradead.org,
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
	linux-kernel@vger.kernel.org,
	Haoze Xie <royenheart@gmail.com>,
	Yuan Tan <tanyuan@tinylab.org>
Subject: [PATCH 1/1] perf archive: unpack to correct dir given by perf
Date: Mon,  8 Jul 2024 02:04:31 +0800
Message-Id: <18fa10628f1e037753244b438b2a08b20d611135.1720372219.git.royenheart@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1720372219.git.royenheart@gmail.com>
References: <cover.1720372219.git.royenheart@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In perf-archive.sh, the code segment that defines 'PERF_BUILDID_DIR' is
advanced before 'unpack' operation for subsequent use, followed by a
'mkdir' operation to ensure that the dir exists. Symbols in 'unpack' will
be extracted to correct dir given by perf.

When '--unpack' param is appointed, the symbols are extracted to '~/.debug'
folder by default, without using 'PERF_BUILDID_DIR' given by perf. This
will cause perf to be unable to find the correct buildid's path when users
configured buildid.dir in 'perf config' or used '--buildid-dir' cli param,
since perf will read these params and put them in 'PERF_BUILDID_DIR' env.
'perf script' and 'perf report' will use the env as the basis for buildid
indexing.

Fixes: e43c64c971e4 ("perf archive: Add new option '--unpack' to expand tarballs")
Signed-off-by: Haoze Xie <royenheart@gmail.com>
Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
---
 tools/perf/perf-archive.sh | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/tools/perf/perf-archive.sh b/tools/perf/perf-archive.sh
index 6ed7e52ab881..f29bbc129056 100755
--- a/tools/perf/perf-archive.sh
+++ b/tools/perf/perf-archive.sh
@@ -23,6 +23,19 @@ while [ $# -gt 0 ] ; do
 	fi
 done
 
+#
+# PERF_BUILDID_DIR environment variable set by perf
+# path to buildid directory, default to $HOME/.debug
+#
+if [ -z $PERF_BUILDID_DIR ]; then
+	PERF_BUILDID_DIR=~/.debug/
+else
+	# append / to make substitutions work
+	PERF_BUILDID_DIR=$PERF_BUILDID_DIR/
+fi
+
+mkdir -p $PERF_BUILDID_DIR
+
 if [ $UNPACK -eq 1 ]; then
 	if [ ! -z "$UNPACK_TAR" ]; then					# tar given as an argument
 		if [ ! -e "$UNPACK_TAR" ]; then
@@ -65,25 +78,14 @@ if [ $UNPACK -eq 1 ]; then
 		fi
 
 		# unzip the perf.data file in the current working directory	and debug symbols in ~/.debug directory
-		tar xvf $TARGET && tar xvf $PERF_SYMBOLS.tar.bz2 -C ~/.debug
+		tar xvf $TARGET && tar xvf $PERF_SYMBOLS.tar.bz2 -C $PERF_BUILDID_DIR
 
 	else																# perf tar generated by perf archive (contains only debug symbols)
-		tar xvf $TARGET -C ~/.debug
+		tar xvf $TARGET -C $PERF_BUILDID_DIR
 	fi
 	exit 0
 fi
 
-#
-# PERF_BUILDID_DIR environment variable set by perf
-# path to buildid directory, default to $HOME/.debug
-#
-if [ -z $PERF_BUILDID_DIR ]; then
-	PERF_BUILDID_DIR=~/.debug/
-else
-        # append / to make substitutions work
-        PERF_BUILDID_DIR=$PERF_BUILDID_DIR/
-fi
-
 BUILDIDS=$(mktemp /tmp/perf-archive-buildids.XXXXXX)
 
 perf buildid-list -i $PERF_DATA --with-hits | grep -v "^ " > $BUILDIDS
-- 
2.25.1

