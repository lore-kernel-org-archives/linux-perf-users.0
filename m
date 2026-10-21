Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792618248;
	b=vCUWbl8aWp1oyxOD6YyVcy93AtLvJrSymh2oxTF7w2lto+dRHSeUjzfX62iAQMhb9LRO
	 S5wvfOUYIpXBTjUKRK9ymlUws3gzUkFF8ZLo1imRiBEZYTH4oaZ4LxbHaFUkZ3oz5P72X
	 EvbMjc+V7rZZ5zNdQLhZVdkLz/DgDxuZ4QdW0UoidIaMcDSaKxmXtBQyVXgTV7PYyv0e/
	 pfAAmNTndvQ7idBgQbGwnA2MxvVaGKqAYBYqbgvwZcxA+wdPiz1d4UamKpPMckgEVdcej
	 ybibebG7vNu7Hj9xMXyTzDkKX483HpBs8lSKijZsuK0QanBqQro+PvEg7eNSBTnSjUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618248;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=od8WN8CVmg89zdoHb82fXFB7zIVfQy/GQmojzRyVr0I=;
	b=LwdpK7CKiKuRVwYFbJCr6AxrTCOqYleyyBWVQ3ptE2kmjbsE4vs9t+OfJe6Bvn/mxe6D
	 dnJKHLheaF/VlIhY2ZD/dd8QJ6MLQJmcLT9PxS0sXQCdRsrvsVh97odM348eh1dvShPPL
	 aByQCu/xxjGKmRbF5I5ipE7HmAkkBGg5fcOSRBfxK6SstR+vVUof3RS6EUoI8x8aPNcL9
	 Atw/EAgVXh6sYTMsI5HlDNLOhe+k9LwUtwE2aZ7pNwx0O61VEe8DMuzlQZxAU2w0LbBuQ
	 J47al7908klsKoLfW4pKRHmeUI6dFcrS5ulp+eRwyMl1mMGoCc/8/e2105Ocels/Fiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FKiR+QQ9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C4E60A2609;
	Wed, 21 Oct 2026 21:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FKiR+QQ9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC991F000C1;
	Wed, 21 Oct 2026 21:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792618248;
	bh=od8WN8CVmg89zdoHb82fXFB7zIVfQy/GQmojzRyVr0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FKiR+QQ9W30QUx3DxkOWrNhXOe1rZoK9JRMrCo4cX1WSpRoT0w5haei24x4haBw8K
	 IPmXclTh1az7TsBKTqCptY45LslwhiUzQyhXB1iy+YXHNKXdSR6egM1KF+Vymzvob2
	 pMsVafrNl5ExIn8gUornZvII4sv7Bkm6BiPOqMhpM7q6EFhblBZeOJsDp5zd/iIt14
	 0ZPNcgFG2xCgn4ck7KIJ7TL9jqv9HKtdZeNL7FaX+rQkZ3fLbrPIFAVttQqrshh6SP
	 ETUYLwrQvUYmUqJNh/a4S5zImDg20iJgPfHapX/GK5zOXQ7G2aqlZA8qogXw3x4NuV
	 Htr4L5VIL3r2w==
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
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v1 08/12] tools headers: Sync UAPI linux/fcntl.h with the kernel sources
Date: Wed, 21 Oct 2026 18:30:02 -0300
Message-ID: <20261021213007.21046-9-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021213007.21046-1-acme@kernel.org>
References: <20261021213007.21046-1-acme@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes in:

  cdf930a00949 ("fs: support FD_FAILFS_ROOT in fchdir()")

That don't result in changes to the string tables generated from this header.

This addresses this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/perf/trace/beauty/include/uapi/linux/fcntl.h include/uapi/linux/fcntl.h

Please see tools/include/uapi/README for further details.

Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/include/uapi/linux/fcntl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
index aadfbf6e0cb3a004..e43e3de3e9ee44a2 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
@@ -124,6 +124,7 @@ struct delegation {
 
 #define FD_PIDFS_ROOT			-10002 /* Root of the pidfs filesystem */
 #define FD_NSFS_ROOT			-10003 /* Root of the nsfs filesystem */
+#define FD_FAILFS_ROOT			-10004 /* Root of the failfs filesystem */
 #define FD_INVALID			-10009 /* Invalid file descriptor: -10000 - EBADF = -10009 */
 
 /* Generic flags for the *at(2) family of syscalls. */
-- 
2.56.0

