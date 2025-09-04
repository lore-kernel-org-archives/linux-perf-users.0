Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848B2207DE2;
	Thu,  4 Sep 2025 00:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945475; cv=none; b=T7IsGDSyiF4TljWVd2h/IeD2VNf+AZSvtfG4aFBmHKeP72H8fZCPkXts3NzaTYOnMz/yzsFEom6DMzKXgMa0J+x848VqTiRPp9R9MXMVntTKTlMH9+gdytb7WelWI/z9yQPoP9LnxkBvOOkwvkpKO4H+pm+Wviv/Ga4B8+kR78E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945475; c=relaxed/simple;
	bh=8M2/0UwLcXRxMD4ixlU21GMSrgoCNNEd15QxD/byhss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rC/i1babZbtvjMVTaF7KzuheUEcs2zA1wUlf6c0nsGLgwB8vvW22tOcAIT3IQzDWCminMgeyekWqlCA5Sw93lkM93qpvps0uLIcnRb+Bno9IbZs8PrE9Dao2J29D6VBcqpOUboDZ1gaqj6plOHWTEa2KuyTNHJ52QYQGGlLw/F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiJWxl+O; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiJWxl+O"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so541362b3a.0;
        Wed, 03 Sep 2025 17:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756945472; x=1757550272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eP+OdhpAXeM3MeCoK1wrQ3GVDNoiOJzpSPwPKz/ThLg=;
        b=RiJWxl+OOBsOILiw8DNDisjKZCt+86CoJrAvJnZP8YYmysGAhsWzWfaOHUJcVk7w6l
         h9ym9e8zIFp42HO1vZyEZxLV13IFxA/1Mw5mS3e3MDsPfpVjQBH9+UeqpePyKk/XtFpY
         9YQmLefde5N8/9uEL3x0zIGRn+ZrnrJi3B5QGDj8w8WJPY0i4iTxBI7PSO8CXaxelGZN
         tjE18IeSO3L6S8yKznzmrSMg8E9tXDjNbsyoD0tCZL4Mrk/4CqCuP3j9HJprB2EzPGIW
         ThOMRn5KbNmENoTTykSrN6q7uzp8lJBwfzeQc12+C38uJtFQjKUb3t/gAs8u7Mez1t2j
         fD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756945472; x=1757550272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eP+OdhpAXeM3MeCoK1wrQ3GVDNoiOJzpSPwPKz/ThLg=;
        b=UKc0b2IlrA5+r/kR+P11LjJVy4zf+gKrxW81C3xukD0Iaa2INNyrHQqrByIgCjQwAR
         KMSBrqFPqmdtV47d9iKevXYjOOva/e/yrephcAnOtb/jnJg8QQ9KRtspxn9JoFxfH3NQ
         8OyXBKFKgcJGUkACvKhmNzBfXzMUrRl5teC9mraqapk2ncTjKM9qy6Em2n6tfJfe4Fuw
         GwLt0pU0iAc2KCv27sl5b87gUKJHFfvvDU2paJhtP35kVdVFw73KiVhizehj8CJ52Icr
         +2pP38FT3hRdu92vWG5aIKzzy03nb2UVH5fwlKI6ED6MNanbLHmcgCnQ+CIxFeC7Nnih
         MTvA==
X-Forwarded-Encrypted: i=1; AJvYcCUKjwEYmSEIv0uar7zOr1tRmU9GBvT8aULhn6ajWiHg9mPtFkDLPhFRy/ezufqvrHZXmrLKEk1Rgge+vhC5XC5z@vger.kernel.org, AJvYcCVYgqShgLe2Qzp2eQoT6Ht5Nw6H7hvoNEds+qPDcCO4AYQd/nVoEz2aQugMDF9EA1GWj2FCupkou5JC5s0kJaqZSN+o@vger.kernel.org
X-Gm-Message-State: AOJu0YxUkBDHTQ5J1ofJL6ujNzmI4UgyvtP5lTG8CTDLEfZOOEsGT1Sx
	mfG/aqS/FndiIQvhSZ5u59jMVufeYDhOXR0y9oSlxCm9llevmRtsuMGt
X-Gm-Gg: ASbGncvognJMV0wnKpQQtc/VkdHAsnPCp6IdAw3xJ6ZSHg0y1Qs6jp+9j9wQp6JuHcj
	wO4KZLx6ZYF9q0fY/KnogKaeNv+mG2KlC6Y+fCPLAqAnAhL+4F5dDE3vfYBn9VXXeTwKgF1Xzy4
	kbGfawZlwQwtFUypzS2IeM/GY/+C0ZolsTi65Mqs+17IP8TW92c2JxvFDuOKOuiEFWW0xlV/qV6
	41sZoC2Rac3q0upGPc+HyH2wDkx/RpcTm3g8Dhxszn0m4CqsZS+r4hYyV5MfKvbBLVpMlyHWb/5
	0+DVnDkBNyYpmW/sOAnX67QFURSpukZCpUB3Zmiu8sCWcqZ8AYDuss7wZiEBoyiFntkzMw4MJDq
	YrqgxnwkJqLeu87yotymeSoE5Toa88riEes63K2UQxrbP5apTwECNU69klgsWZj4=
X-Google-Smtp-Source: AGHT+IFdiMNyAnu9UryWCSK1mcKi/kj3qV4ntRIkK3d5kpgJtmLY+vw0EOiis+3DxW1OxC/tcEOAxA==
X-Received: by 2002:a05:6a00:114e:b0:76b:ef44:1fa4 with SMTP id d2e1a72fcca58-7723e27d90fmr23784888b3a.14.1756945471815;
        Wed, 03 Sep 2025 17:24:31 -0700 (PDT)
Received: from localhost.localdomain ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bd2aesm17579551b3a.48.2025.09.03.17.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 17:24:31 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v2 18/18] MAINTAINERS: add entry for KStackWatch (Kernel Stack Watch)
Date: Thu,  4 Sep 2025 08:21:15 +0800
Message-ID: <20250904002126.1514566-19-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904002126.1514566-1-wangjinchao600@gmail.com>
References: <20250904002126.1514566-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Jinchao Wang as the maintainer for KStackWatch, including its kernel
module and test script.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fed6cd812d79..097a0462e604 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13354,6 +13354,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
 F:	Documentation/dev-tools/kselftest*
 F:	tools/testing/selftests/
 
+KERNEL STACK WATCH
+M:	Jinchao Wang <wangjinchao600@gmail.com>
+S:	Maintained
+F:	mm/kstackwatch/
+F:	tools/kstackwatch/
+
 KERNEL SMB3 SERVER (KSMBD)
 M:	Namjae Jeon <linkinjeon@kernel.org>
 M:	Namjae Jeon <linkinjeon@samba.org>
-- 
2.43.0

