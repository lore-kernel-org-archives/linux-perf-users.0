Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ED3361DA6;
	Wed, 10 Jun 2026 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121217; cv=none; b=UQwmw6ME9Y9Qc2M1KhiIQGQ9rHrghjV6Mk/7Gwr5MdtD3jp3s7pn6meR+81oMRr0XGkKsa97lGu9VukP2hpOmDT2oAldJxPks2/HHa6Ex6IhKxnZKCKZP5W7ZWCgEWHliobzHXqSR9jPn1ut1Fnq4eRp9anDMvgbsP2g1YNSSw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121217; c=relaxed/simple;
	bh=TXnI0tIKaOPTk7AUDAFrqpKB3FY8QjI0fF79NRZP8Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDE5rVSJWyzmYBB5P96htUVoc9rqzyRZKcXhXS8OkCGL/tJNjYqc6H9EZ2MLTlRajnx0fOLLMvPeRtGoFX/7JPsGQs4Og48UYF1P996atOVbloxCsut/C4fkHuwF+sRseYljmBYtqShqDGiMz9Gl1U4WIWecEHGDYvw7BCmJzNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AclH2Qmh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AclH2Qmh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60C61F00898;
	Wed, 10 Jun 2026 19:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121216;
	bh=CbPCvN06o1gOnMzGEfRvn6eJx9i+NpYEoiN9TrKi3IM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AclH2QmhZJl22GUUh+Fasaq8WgfWRk3f/WCWqQQuaRo8WBE4HFTLtfmVmML1/PD8Z
	 +l63DQHLSi9AmiFGzGb1sdX7oXqnzW/Fmphev9GaqdEYeyeiLBNeAUkuRTwOCJ0bqh
	 0dVjv/s1N/1FBfKIaD+0MVBO/YKlIkvpgGfq+bZvAnvrK1cL241+1ktYQIZz2kaqET
	 WUFN/N7YOH79xHZK12DHzAbHNQILCn+SDCfbilYQdP2sqFFf/c/pDtGmxyXVNrK2/p
	 y5KtdlS/VnV78YCd4+AFSPdtlZT5XnBI740Dqm6JNMLjfPoU2NjTgDItOk7MJQB8Wo
	 A7UvcMRFt1eQw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 18/23] tools lib api: Fix mount_overload() snprintf truncation and toupper range
Date: Wed, 10 Jun 2026 16:51:51 -0300
Message-ID: <20260610195157.2091137-19-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610195157.2091137-1-acme@kernel.org>
References: <20260610195157.2091137-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

mount_overload() builds an environment variable name like
"PERF_SYSFS_ENVIRONMENT" from fs->name.  Two bugs:

1) snprintf() uses name_len as the buffer size instead of sizeof(upper_name).
   For fs->name = "sysfs" (len=5), the output is truncated to "PERF" (4
   chars + null), so getenv() never finds the intended variable.

2) mem_toupper() only uppercases name_len bytes, converting just the "PERF"
   prefix rather than the full string including the filesystem name portion.

Fix by using sizeof(upper_name) for snprintf and strlen(upper_name) for
mem_toupper, so the full "PERF_SYSFS_ENVIRONMENT" string is correctly
formatted and uppercased.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Fixes: 73ca85ad364769ff ("tools lib api fs: Add FSTYPE__mount() method")
Cc: Jiri Olsa <jolsa@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/api/fs/fs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
index d16911818d4d3569..cbd8eab0d1df0c6b 100644
--- a/tools/lib/api/fs/fs.c
+++ b/tools/lib/api/fs/fs.c
@@ -261,8 +261,8 @@ static const char *mount_overload(struct fs *fs)
 	/* "PERF_" + name + "_ENVIRONMENT" + '\0' */
 	char upper_name[5 + name_len + 12 + 1];
 
-	snprintf(upper_name, name_len, "PERF_%s_ENVIRONMENT", fs->name);
-	mem_toupper(upper_name, name_len);
+	snprintf(upper_name, sizeof(upper_name), "PERF_%s_ENVIRONMENT", fs->name);
+	mem_toupper(upper_name, strlen(upper_name));
 
 	return getenv(upper_name) ?: *fs->mounts;
 }
-- 
2.54.0

