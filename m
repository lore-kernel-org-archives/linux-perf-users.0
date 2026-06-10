Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51DD3563EB;
	Wed, 10 Jun 2026 19:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121148; cv=none; b=R/3f888fZLtd5KHMusWePesDgFIgGIidq4vRziOXoh9ErA96c7rOCylbk8RvqtsIA67L1Y/Jz5XaQUIuitTzNV68LwXQkL7VCJxNOL/lvkcpV0VN69dZbWY+Rn2O353eI+tZsLv+Dv18QEKDAtN0LXjbUKvPS+Obp+DqTW7b5YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121148; c=relaxed/simple;
	bh=g9r3ojVu4Q0t9eqEBB8QRGcJVNfec6WsdBCG3L+EA2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xn3W4/v6jKBt0YSa3pS7V7KIGGj+RuxXreB4L23rydJTapKLbbQNRUDWwCyFz+opxwhI44/G5hK5QY+GCZGLGhmYzvPR4dQTN4TwpDJD+EtnECCs6pXjsc0WF7oxldkDUyklXvpZnJcowXaDHX/hFeErpTdCtPMHlBBP/wXgrXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7ot5OKE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7ot5OKE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D52C1F00893;
	Wed, 10 Jun 2026 19:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121147;
	bh=fe1+P/YYiVqvfueGLieBc4OySvUp4JuOnujglSK18k8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l7ot5OKEh0UX4N/9cTpRZI4dbxgFcGfQPo9y4VacgjYBdH3yD3qYfMr01pvrWb8vJ
	 qebQftUsPA5Wezfhzqfh4qYPdnXuqj3MkN+Vw23MKgOgcSl2OwdKmZOKng4+cuc2ab
	 1gFyjCDdGSYmmaQ1PFN7eDN74PSxHurq6NVdqtBGUSeZ+Wci+5ocz5N/GMFWP8s+hr
	 1pVRFn7dkfkvNm2lxR3vDapHHyBnfFvkNHpfYvon+t3Ls5YR0WYfKih+w/5n+0igED
	 4ch0tOnReQrAwLyvBlhHaKeYgJ/FIcy7Cb+AILdSsvHLkcUHe77yA7+gNlMfhtP5U5
	 XWBvftxNypkGw==
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
Subject: [PATCH 04/23] perf symbols: Fix signed overflow in sysfs__read_build_id() size check
Date: Wed, 10 Jun 2026 16:51:37 -0300
Message-ID: <20260610195157.2091137-5-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610195157.2091137-1-acme@kernel.org>
References: <20260610195157.2091137-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

sysfs__read_build_id() reads ELF note headers from sysfs files.  The
note's namesz and descsz fields are used to compute the skip size:

    int n = namesz + descsz;
    if (n > (int)sizeof(bf))

Both namesz and descsz are size_t from NOTE_ALIGN() of 32-bit note
header fields.  Their sum can exceed INT_MAX, overflowing the signed
int n to a negative value.  The check n > sizeof(bf) then evaluates
false (negative < positive in signed comparison), and read(fd, bf, n)
reinterprets the negative n as a huge size_t count — the kernel writes
up to MAX_RW_COUNT bytes into the 8192-byte stack buffer.

In practice the overflow is bounded by the sysfs file's actual size,
so a real sysfs notes file won't trigger it organically.  But crafted
input (e.g. via a mounted debugfs/sysfs image) could.

Fix by validating namesz and descsz individually against the buffer
size before summing, and change n to size_t to avoid the signed
overflow entirely.

Fixes: f1617b40596cb341 ("perf symbols: Record the build_ids of kernel modules too")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index c2bdfd0003df2abe..8fb25a5692b56c53 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -964,14 +964,17 @@ int sysfs__read_build_id(const char *filename, struct build_id *bid)
 			} else if (read(fd, bf, descsz) != (ssize_t)descsz)
 				break;
 		} else {
-			int n = namesz + descsz;
+			size_t n;
 
-			if (n > (int)sizeof(bf)) {
+			/* int sum of namesz+descsz can overflow negative, bypassing size check */
+			if (namesz > sizeof(bf) || descsz > sizeof(bf) - namesz) {
 				n = sizeof(bf);
 				pr_debug("%s: truncating reading of build id in sysfs file %s: n_namesz=%u, n_descsz=%u.\n",
 					 __func__, filename, nhdr.n_namesz, nhdr.n_descsz);
+			} else {
+				n = namesz + descsz;
 			}
-			if (read(fd, bf, n) != n)
+			if (read(fd, bf, n) != (ssize_t)n)
 				break;
 		}
 	}
-- 
2.54.0

