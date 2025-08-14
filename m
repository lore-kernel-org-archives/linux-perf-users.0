Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9031BCA0E;
	Thu, 14 Aug 2025 06:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755151788; cv=none; b=F2Rr0D1mB/o7uLwFB7znLN0I9Xc5Sc3ZvBHX0hJEe4xvgS+HUlrSO41SIJ6wjhZmpNO0MUX964xNwdJjF1/nUaDuzXwhIkJtpfaFCFe30Wr2aATZfqeC7t6EcGLPcqpDmqhpqi9WzTLL9EuKt7709xDErCMWoVCN/gbdAHT0bD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755151788; c=relaxed/simple;
	bh=xxjNa66S9m26u8QJGchWOWwKszeJ+ZkqGcwLz4joCPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eUvRkWFYjIwxkp/wDPEG4rnf/2zNZFT+DDYvYevo1xIEZuS6iFxT1DmNUQLKOThPG2Z7LaYJQ7NWWYX6t74kxByT5SQSrBL5PCjc33B/AJaluiBC8hyrA2ccat8UmUCX95w22Dqih189IMIzKi0m5xuGzvwU8cP9UGQIhCaudcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OaQiwW2H; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaQiwW2H"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-30cce90227aso266626fac.1;
        Wed, 13 Aug 2025 23:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755151785; x=1755756585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8WGpKCewPhzJMCG3Urw9A6LrMi7qDZQiC1FF5M4yxy8=;
        b=OaQiwW2HI4u4u0Un0iRrbiBXX7YOXSY77VJp1/A0+Ffq/+G0R2OpncmsOuk9TqPy1a
         N9961OHcK6jgZ6h05FX/zPX6iwuC7Gq7EHvYmkgN74bMgbsOPbYwzC54oRhVhVMi5ABK
         wsVa+6424T/CR5RnZ4meWQFzZMX/INkVlm46mPG2kC/2L9btw7xv9PN/waFa82Py91t0
         /l09I+nEsrUouHnXxcXbTpQiyzejEVGEZxZuX2Yl3VoH8k//+M6lfu7VBDRAR1tolGPa
         OP1D6ThuLWOhIA3fLBzXJ+7EFG0Kzl6vtE/PkWeFx9g/PKP8uvWaEHg3Gn4TwuPqSYrm
         b77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755151785; x=1755756585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8WGpKCewPhzJMCG3Urw9A6LrMi7qDZQiC1FF5M4yxy8=;
        b=hPzxB/FcjlWO8qU7Oxz1JWqSz9UdCn2XzdBwn6DcH+V0NTwBulidBSYdtGKqHriC8F
         zmEY5W/8oJG/pXDQyrxRLSVq5lX9kvQ838pKlHWtKNipWBBQENmnlxIqOU+5V6bZK50Y
         QH51uheCUcaI0Fuui8yofX2nLFqk1eaVfjS3N3sNooLLSJKj+0YVIxLOfT8qttqZqj/2
         sNNlup6VWLcVH7Z5300stuEuUYBiLdGFfzSoA82fQL9AuqS3RUQD/HBoa4SUSR5YE7Nq
         tnISuQ0TzdvZqWLnev7HjjniAdnavCuRwhk2tiGDCe0lKiAp2qRUpUEVpqgSYXuFknGz
         duqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5dxIZkxWpK5TcgXLSMZNuODX0Mt2bItI4PkppZJjw5rgzhWwBax6VykqbIN95auBooyggz6j0Lj7EJ93Vz1uvCw==@vger.kernel.org, AJvYcCWefZ0QIXerLDE7EfoYtSFI2rvph7uDDh+7evbrRWU4B2GvYud7QwQSnkIskfwhh1LqveQqp0YS517iWuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKT2yClXn7/NHfhAhChC/xHsNARmQKFHYg9LYKodfEk/4+fRbO
	x3Nm7UygY/ktfHzuuHM2YjAibh+wQcTaBmbtibTV89TunGHF1pUp90UY
X-Gm-Gg: ASbGnctnnrn/be1guhZf3hhyHOLPH7+xu3xZtGstNV+3QpUVocsseXGgEtI0crynUtl
	U+YCCVqFPMaMLe26S+F2VDRCaqpEAYSAmFHFHnvyLyugCPg8QQ52YiIDFqQg1VMrURvZTfqtO7a
	GM8pXHc/EPOEkhDV+yXrfOagYS95nXnvzzCIV3JrYuPxUKT1nlYs9LRTkeJ6umiODqBJ4LBOaqh
	ti3ufm4DdXtmo0XiHOockKuOvSrQuvhsRX2piJyAQ5F3++izhaUO8Uh5/4/5G2MamTi4gRk5AJf
	6cVovBdIJYShBSLEvvWMz+c0hEUoCJfuHs2AbEmjBA+0laUdH2edeHOWbcqoaame3oyyS+K/678
	6+IcQNbPoI0JPPm96rWX+bS95
X-Google-Smtp-Source: AGHT+IGNqHwfJ/nTLo0nUxVbtwIM5BPkd3E2Odzw9x/uYyUOthi/2NzCJwqDfxyrWgoXVKKh4GUFtQ==
X-Received: by 2002:a05:6870:414c:b0:2d5:1232:b081 with SMTP id 586e51a60fabf-30cd1338d4dmr1330269fac.29.1755151784978;
        Wed, 13 Aug 2025 23:09:44 -0700 (PDT)
Received: from s-machine2.. ([2806:2f0:5501:d07c:7bd7:6cf4:be16:7894])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7436f9900ddsm1310914a34.46.2025.08.13.23.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 23:09:44 -0700 (PDT)
From: Sergio Perez Gonzalez <sperezglz@gmail.com>
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
	colin.i.king@gmail.com
Cc: Sergio Perez Gonzalez <sperezglz@gmail.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf drm_pmu: Prevent resource leak in for_each_drm_fdinfo_in_dir()
Date: Thu, 14 Aug 2025 00:06:11 -0600
Message-ID: <20250814060614.450696-1-sperezglz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Close fdinfo_dir_fd and fd_dir prior to exit, in the event of
cb() error.

Signed-off-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
---
 tools/perf/util/drm_pmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/drm_pmu.c b/tools/perf/util/drm_pmu.c
index 988890f37ba7..416aeac7956e 100644
--- a/tools/perf/util/drm_pmu.c
+++ b/tools/perf/util/drm_pmu.c
@@ -403,7 +403,7 @@ static int for_each_drm_fdinfo_in_dir(int (*cb)(void *args, int fdinfo_dir_fd, c
 	DIR *fd_dir;
 	struct dirent *fd_entry;
 	int fd_dir_fd, fdinfo_dir_fd = -1;
-
+	int ret = 0;
 
 	scnprintf(buf, sizeof(buf), "%s/fd", pid_name);
 	fd_dir_fd = openat(proc_dir, buf, O_DIRECTORY);
@@ -418,7 +418,6 @@ static int for_each_drm_fdinfo_in_dir(int (*cb)(void *args, int fdinfo_dir_fd, c
 		struct stat stat;
 		unsigned int minor;
 		bool is_dup = false;
-		int ret;
 
 		if (fd_entry->d_type != DT_LNK)
 			continue;
@@ -458,12 +457,13 @@ static int for_each_drm_fdinfo_in_dir(int (*cb)(void *args, int fdinfo_dir_fd, c
 		}
 		ret = cb(args, fdinfo_dir_fd, fd_entry->d_name);
 		if (ret)
-			return ret;
+			goto out;
 	}
+out:
 	if (fdinfo_dir_fd != -1)
 		close(fdinfo_dir_fd);
 	closedir(fd_dir);
-	return 0;
+	return ret;
 }
 
 static int for_each_drm_fdinfo(bool skip_all_duplicates,
-- 
2.43.0

